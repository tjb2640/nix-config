{ lib, ... }:

# Server computer common values

{

  imports = [ ./base.nix ];

  # ###########################################################
  #   SYSTEM & SERVICES
  # ###########################################################

  # Harden SSH and use fail2ban
  # They provide a pre-configured jail
  services.openssh = {
    enable = lib.mkForce true;
    ports = [ 5511 ];
    settings = {
      AllowUsers = [ "ty" ];
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  services.fail2ban.enable = true;
  
}
