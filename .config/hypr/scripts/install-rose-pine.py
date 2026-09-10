#!/usr/bin/env python3
"""Build the pinned full GTK theme. Requires curl, sassc and bash."""
import argparse
from datetime import datetime
from pathlib import Path
import shutil
import subprocess
import tarfile
import tempfile

REVISION = 'c4fdfa62a9eb6941a36b2cd5026fc64123aaa0dd'
URL = f'https://github.com/Fausto-Korpsvart/Rose-Pine-GTK-Theme/archive/{REVISION}.tar.gz'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path, help='Use an already downloaded theme source tree')
    args = parser.parse_args()
    for command in ('sassc', 'bash', 'curl'):
        if not shutil.which(command):
            parser.error(f'{command} is required')
    with tempfile.TemporaryDirectory(prefix='rose-pine-') as temporary:
        work = Path(temporary)
        source = args.source
        if source is None:
            archive = work / 'theme.tar.gz'
            subprocess.run(['curl', '-fL', URL, '-o', str(archive)], check=True)
            with tarfile.open(archive) as bundle:
                bundle.extractall(work, filter='data')
            source = work / f'Rose-Pine-GTK-Theme-{REVISION}'
        subprocess.run(['bash', str(source / 'themes/install.sh'), '-d', str(work / 'built'),
                        '-c', 'dark', '-t', 'default'], check=True)
        # This upstream revision leaks a GTK 4-only property into GTK 3 CSS.
        for css in (work / 'built/Rosepine-Dark/gtk-3.0').glob('*.css'):
            css.write_text(''.join(line for line in css.read_text().splitlines(keepends=True)
                                   if 'border-spacing:' not in line))
        destination = Path.home() / '.local/share/themes/Rosepine-Dark'
        if destination.exists():
            backup = Path.home() / '.local/state/dotfiles/backups' / datetime.now().strftime('%Y%m%d-%H%M%S-%f')
            backup.mkdir(parents=True)
            shutil.move(str(destination), backup / destination.name)
        destination.parent.mkdir(parents=True, exist_ok=True)
        shutil.copytree(work / 'built/Rosepine-Dark', destination)
        print(f'Installed {destination}. Reopen GTK applications to apply the theme.')


if __name__ == '__main__':
    main()
