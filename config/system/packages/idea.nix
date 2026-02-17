{ pkgs, ... }:

# Trying IDEA OSS right now, reserving this file in case I want to 
# declare plugins in the future

{
  environment.systemPackages = with pkgs; [
    jetbrains.idea-oss
  ];
}
