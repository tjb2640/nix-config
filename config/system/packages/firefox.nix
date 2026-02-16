{ config, pkgs, lib, ... }:

# Home manager default settings for Firefox
# Will result in a message in the settings about a managed browser
# TODO: this file should soon be deprecated in some way, I am switching to Zen Browser

{
  
  programs.firefox = {
    enable = true;

    languagePacks = [ "en-CA" "en-GB" "en-US" "de" "fr" ];

    preferences = {
      "browser.contentblocking.category" = "standard";
      "browser.startup.homepage" = "file:///home/ty/.dotfiles/resource/pages/browserstart/index.html";
      "intl.locale.requested" = "en-CA,en-GB,en-US";
      "intl.regional_prefs.use_os_locales" = true;
      "media.eme.enabled" = true; # DRM
      "privacy.donottrackheader.enabled" = true;
      "privacy.globalprivacycontrol.enabled" = true;
      "privacy.trackingprotection.cryptomining.enabled" = true;
      "privacy.trackingprotection.enabled" = true;
      "privacy.trackingprotection.fingerprinting.enabled" = true;
      "privacy.trackingprotection.pbmode.enabled" = true;
      "privacy.trackingprotection.socialtracking.enabled" = true;
    };

    policies = {
      DisableTelemetry = true;
    };

    # This may fix screen sharing options under Wayland
    wrapperConfig = {
      pipewireSupport = true;
    };
  };

  xdg.mime.defaultApplications = {
    "application/pdf" = "firefox.desktop";
    "text/html" = "firefox.desktop";
    "text/markdown" = "firefox.desktop";
    "text/x-markdown" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
  };

}
