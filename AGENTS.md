# Repository guidance

This repository is the source for an Arch Linux desktop setup. The GitHub
repository is named `arch`, but setup intentionally checks it out locally as
`~/dotfiles` for compatibility with existing shell and editor paths.

## Changes

- Keep paths, aliases, and scripts safe to rerun from `~/dotfiles`.
- Setup scripts must converge on repeat runs; destructive helpers must refuse
  already-populated targets unless an explicit force flag is provided.
- Do not apply system changes while editing this repository; setup scripts may
  configure packages and services only when the user explicitly runs them.
- Keep unrelated TODOs in other project documentation unchanged. Active TODOs
  should be removed only after their corresponding configuration or documented
  command exists.

## Validation

Run `bash -n` on changed shell scripts, `luac -p` on changed Lua files when
available, and parse TOML/JSON configuration with the corresponding installed
tool when available. Never format or repartition a disk as part of validation.
