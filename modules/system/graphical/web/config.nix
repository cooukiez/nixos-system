{
  preferences = {
    "widget.use-xdg-desktop-portal.file-picker" = 1;
  };

  policies = {
    AutofillAddressEnabled = true;
    AutofillCreditCardEnabled = false;

    DisableAppUpdate = true;
    DisableFeedbackCommands = true;
    DisableFirefoxStudies = true;
    DisablePocket = true;
    DisableTelemetry = true;

    DontCheckDefaultBrowser = true;

    NoDefaultBookmarks = true;

    OfferToSaveLogins = false;
    PasswordManagerEnabled = false;

    Certificates = {
      Install = [
        ../../../../dhs.crt
      ];
    };

    EnableTrackingProtection = {
      Value = true;
      Cryptomining = true;
      Fingerprinting = true;

      Locked = true;
    };

    GenerativeAI = {
      Enabled = false;
      Chatbot = false;
      LinkPreviews = false;
      TabGroups = false;

      Locked = true;
    };

    AIControls = {
      SidebarChatbot = {
        Value = "unavailable";
        Locked = true;
      };

      LinkPreviewKeyPoints = {
        Value = "unavailable";
        Locked = true;
      };

      SmartTabGroups = {
        Value = "unavailable";
        Locked = true;
      };

      SmartWindow = {
        Value = "unavailable";
        Locked = true;
      };
    };
  };
}
