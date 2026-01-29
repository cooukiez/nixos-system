/*
  modules/home-manager/desktop/noctalia/hyprland.nix

  created by ludw
  on 2026-01-10
*/


{ config, pkgs, ... }:

let
  hyprconfig = ''
    ################
    ### MONITORS ###
    ################
    monitor=eDP-1,1920x1080@60,auto,1
    monitor=HDMI-A-1,1920x1080@60,auto,1

    ################
    ### PROGRAMS ###
    ################
    $terminal = kitty
    $fileManager = thunar
    # $menu =
    $browser = firefox
    $alt-browser = zen-browser
    $system-monitor = missioncenter

    #################
    ### AUTOSTART ###
    #################
    exec-once = dbus-update-activation-environment --systemd --all
    # exec-once =

    #############################
    ### ENVIRONMENT VARIABLES ###
    #############################
    env = HYPRCURSOR_SIZE,24

    #####################
    ### LOOK AND FEEL ###
    #####################
    general {
        gaps_in = 5
        gaps_out = 10
        border_size = 0
        resize_on_border = false
        allow_tearing = false
        layout = dwindle
    }

    decoration {
        rounding = 10
        active_opacity = 1.0
        inactive_opacity = 1.0

        shadow {
            enabled = false
            range = 4
            render_power = 3
            color = rgba(1a1a1aee)
        }

        blur {
            enabled = true
            size = 3
            passes = 2
            vibrancy = 0.1696
        }
    }

    animations {
        enabled = true
        bezier = easeOutQuint,0.23,1,0.32,1
        bezier = easeInOutCubic,0.65,0.05,0.36,1
        bezier = linear,0,0,1,1
        bezier = almostLinear,0.5,0.5,0.75,1.0
        bezier = quick,0.15,0,0.1,1
        animation = global, 1, 10, default
        animation = border, 1, 5.39, easeOutQuint
        animation = windows, 1, 4.79, easeOutQuint
        animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
        animation = windowsOut, 1, 1.49, linear, popin 87%
        animation = fadeIn, 1, 1.73, almostLinear
        animation = fadeOut, 1, 1.46, almostLinear
        animation = fade, 1, 3.03, quick
        animation = layers, 1, 3.81, easeOutQuint
        animation = layersIn, 1, 4, easeOutQuint, fade
        animation = layersOut, 1, 1.5, linear, fade
        animation = fadeLayersIn, 1, 1.79, almostLinear
        animation = fadeLayersOut, 1, 1.39, almostLinear
        animation = workspaces, 1, 1.94, almostLinear, fade
        animation = workspacesIn, 1, 1.21, almostLinear, fade
        animation = workspacesOut, 1, 1.94, almostLinear, fade
    }

    dwindle {
        pseudotile = true
        preserve_split = true
    }

    master {
        new_status = master
    }

    misc {
        force_default_wallpaper = 0
        disable_hyprland_logo = true
    }

    #############
    ### INPUT ###
    #############
    input {
        kb_layout = de
        follow_mouse = 1
        sensitivity = 0
        touchpad {
            natural_scroll = true
        }
    }

    gestures {
        gesture = 3, horizontal, workspace
    }

    device {
        name = epic-mouse-v1
        sensitivity = -0.5
    }

    ###################
    ### KEYBINDINGS ###
    ###################
    $mainMod = SUPER
    $secondMod = CTRL
    $thirdMod = ALT

    bind = $mainMod, C, killactive
    bind = $mainMod, M, exit
    bind = $mainMod, F, fullscreen
    bind = $mainMod, V, togglefloating
    bind = $mainMod, R, exec, $menu
    bind = $mainMod, P, pseudo
    bind = $mainMod, J, togglesplit
    # bind = $mainMod, W, exec, ~/.config/hypr/set_wallpaper.sh
    bind = $mainMod SHIFT, R, exec, reboot
    bind = $mainMod SHIFT, F, exec, $browser
    bind = $mainMod SHIFT, D, exec, $alt-browser
    bind = $mainMod, E, exec, $fileManager
    bind = $mainMod, Q, exec, $terminal
    bind = CTRL_SHIFT, escape, exec, $system-monitor
    # todo: replace with noctalia clipboard history command
    # bind = $mainMod SHIFT, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy

    # bind = $thirdMod SHIFT, H, exec, hyprctl keyword monitor ,3840x2160@60,auto,2
    # bind = $thirdMod SHIFT, L, exec, hyprctl keyword monitor ,1920x1080@60,auto,1

    bind = $thirdMod, left, movefocus, l
    bind = $thirdMod, right, movefocus, r
    bind = $thirdMod, up, movefocus, u
    bind = $thirdMod, down, movefocus, d

    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10

    bind = $mainMod, left, workspace, -1
    bind = $mainMod, right, workspace, +1

    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    bind = $mainMod SHIFT, left, movetoworkspace, -1
    bind = $mainMod SHIFT, right, movetoworkspace, +1

    bind = $mainMod, S, togglespecialworkspace, magic
    bind = $mainMod SHIFT, S, movetoworkspace, special:magic

    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1

    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow

    bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    bindel = ,XF86MonBrightnessUp, exec, brightnessctl s 10%+
    bindel = ,XF86MonBrightnessDown, exec, brightnessctl s 10%-

    bindl = , XF86AudioNext, exec, playerctl next
    bindl = , XF86AudioPause, exec, playerctl play-pause
    bindl = , XF86AudioPlay, exec, playerctl play-pause
    bindl = , XF86AudioPrev, exec, playerctl previous

    # bind = , Print, exec, ~/.config/hypr/capture.sh 0
    # bind = $mainMod, Print, exec, ~/.config/hypr/capture.sh 1
    # bind = $mainMod SHIFT, Print, exec, ~/.config/hypr/capture.sh 2
    # bind = $thirdMod SHIFT, Print, exec, ~/.config/hypr/capture.sh 3
    # bind = $mainMod SHIFT, Q, exec, ~/.config/hypr/capture.sh stop

    ##############################
    ### WINDOWS AND WORKSPACES ###
    ##############################
    windowrulev2 = suppressevent maximize, class:.*
    windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0

    layerrule = blur, noctalia-background-.*$
    layerrule = blurpopups, noctalia-background-.*$
    layerrule = ignorealpha 0.5, noctalia-background-.*$
  '';
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;

    extraConfig = hyprconfig;
  };
}
