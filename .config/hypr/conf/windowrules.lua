-- Shared initial size for floating utility windows (Omarchy's 875x600 default).
for _, app in ipairs({ "blueman-manager", "org.pulseaudio.pavucontrol", "Pavucontrol" }) do
    hl.window_rule({ match = { class = app }, float = true, size = { 875, 600 }, center = true })
end
hl.window_rule({ match = { class = "org.kde.dolphin" }, float = true, size = { 1200, 800 }, center = true })
hl.window_rule({ match = { class = "firefox" }, no_blur = true })
hl.window_rule({ match = { class = "mpv" }, workspace = "2" })
hl.window_rule({ match = { class = "(jetbrains-.*)" }, no_initial_focus = true })
