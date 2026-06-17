/*
hosts/hardware/pipewire-modules.nix

part of nixos system
created 2026-06-16 by ludw
*/
{
  apple-airplay = {
    "context.modules" = [
      {name = "libpipewire-module-raop-discover";}
    ];
  };

  echo-cancellation = {
    "context.modules" = [
      {
        name = "libpipewire-module-echo-cancel";

        args = {
          "capture.props" = {
            "node.name" = "Echo Cancellation Capture";
          };

          "source.props" = {
            "node.name" = "Echo Cancellation Source";
            "node.description" = "Echo-Canceled Microphone";
          };

          "sink.props" = {
            "node.name" = "Echo Cancellation Sink";
          };

          "playback.props" = {
            "node.name" = "Echo Cancellation Playback";
          };
        };
      }
    ];
  };

  combined-sink = {
    "context.modules" = [
      {
        name = "libpipewire-module-combine-stream";
        args = {
          "combine.mode" = "sink";

          "node.name" = "combined_sink";
          "node.description" = "Simultaneous Output (All Sinks)";

          "combine.latency-compensate" = true;
          "combine.props" = {
            "audio.position" = ["FL" "FR"];
          };

          "stream.rules" = [
            {
              matches = [
                {"media.class" = "Audio/Sink";}
              ];

              actions = {
                "create-stream" = {};
              };
            }
          ];
        };
      }
    ];
  };

  virtual-loopback = {
    "context.modules" = [
      {
        name = "libpipewire-module-loopback";
        args = {
          "node.description" = "Virtual Loopback Cable";

          "capture.props" = {
            "node.name" = "virtual_cable_input";
            "media.class" = "Audio/Sink";
            "audio.position" = ["FL" "FR"];
          };

          "playback.props" = {
            "node.name" = "virtual_cable_output";
            "media.class" = "Audio/Source";
            "audio.position" = ["FL" "FR"];
          };
        };
      }
    ];
  };

  disable-system-bell = {
    "context.properties" = {
      "module.x11.bell" = false;
    };
  };
}
