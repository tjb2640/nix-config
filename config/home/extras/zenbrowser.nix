{ config, pkgs, inputs, lib, ... }:

# Enables the zen browser and adds some extensions and things

{

  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;
    policies = {
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      Bookmarks = [
        {
          Title = "[ startpage ]";
          URL = "file:///home/ty/.dotfiles/resource/pages/browserstart/index.html";
          Placement = "menu";
        }
      ];
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };
  };

}