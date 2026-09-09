hl.workspace_rule({ workspace = "1", monitor = "DP-1", on_created_empty = "uwsm app -- kitty", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-1" })
hl.workspace_rule({ workspace = "3", monitor = "DP-3", on_created_empty = "firefox" })
hl.workspace_rule({ workspace = "4", monitor = "DP-3", on_created_empty = "kitty -e ncspot" })
