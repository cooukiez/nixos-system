{
	hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
      intel-media-driver # for broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
      # intel-vaapi-driver # for older processors. LIBVA_DRIVER_NAME=i965
      ];
    };
  };

  # set LIBVA_DRIVER_NAME environment variable for video acceleration
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
}