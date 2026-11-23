#!/usr/bin/env python3
"""Regenerate formulas from the latest release of each project.

A project is skipped until its latest release carries all four binaries
and their .sha256 files.
"""

import json
import subprocess
import urllib.request
from pathlib import Path

PLATFORMS = [
    ("macos", "arm", "darwin-arm64"),
    ("macos", "intel", "darwin-amd64"),
    ("linux", "arm", "linux-arm64"),
    ("linux", "intel", "linux-amd64"),
]

PROJECTS = [
    {
        "name": "zop",
        "class": "Zop",
        "repo": "theherk/zop",
        "desc": "Every project, ranked by use: list, refresh, and per-project tmp paths",
        "test": '"zop", shell_output("#{bin}/zop --help")',
    },
    {
        "name": "rhuidean-studio",
        "class": "RhuideanStudio",
        "repo": "theherk/rhuidean-studio",
        "desc": "Polyrhythmic orbital music visualizer",
        "test": '"rhuidean-studio", shell_output("#{bin}/rhuidean-studio --version")',
    },
]


def latest(repo):
    out = subprocess.run(
        ["gh", "api", f"repos/{repo}/releases/latest"],
        capture_output=True,
        text=True,
    )
    return json.loads(out.stdout) if out.returncode == 0 else None


def sha(url):
    with urllib.request.urlopen(url) as r:
        return r.read().decode().split()[0]


def render(p, tag, shas):
    base = f"https://github.com/{p['repo']}/releases/download/{tag}"
    blocks = []
    for os_name in ("macos", "linux"):
        inner = []
        for o, arch, suffix in PLATFORMS:
            if o != os_name:
                continue
            inner.append(
                f"    on_{arch} do\n"
                f'      url "{base}/{p["name"]}-{suffix}"\n'
                f'      sha256 "{shas[suffix]}"\n'
                f"    end"
            )
        blocks.append(f"  on_{os_name} do\n" + "\n".join(inner) + "\n  end")
    return f'''class {p["class"]} < Formula
  desc "{p["desc"]}"
  homepage "https://github.com/{p["repo"]}"
  version "{tag}"
  license "MIT"

''' + "\n\n".join(blocks) + f'''

  def install
    bin.install Dir["{p["name"]}-*"].first => "{p["name"]}"
  end

  test do
    assert_match {p["test"]}
  end
end
'''


def main():
    for p in PROJECTS:
        rel = latest(p["repo"])
        if not rel:
            print(f"{p['name']}: no release")
            continue
        tag = rel["tag_name"]
        assets = {a["name"]: a["browser_download_url"] for a in rel["assets"]}
        shas = {}
        for _, _, suffix in PLATFORMS:
            name = f"{p['name']}-{suffix}"
            if name not in assets or f"{name}.sha256" not in assets:
                shas = None
                break
            shas[suffix] = sha(assets[f"{name}.sha256"])
        if shas is None:
            print(f"{p['name']} {tag}: binaries missing, skipped")
            continue
        path = Path("Formula") / f"{p['name']}.rb"
        path.write_text(render(p, tag, shas))
        print(f"{p['name']}: {tag}")


main()
