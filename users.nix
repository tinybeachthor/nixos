{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    martin = {
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
        "audio"
        "wireshark"
        "vboxusers"
        "libvirtd" # kvm
      ];

      shell = pkgs.zsh;

      home = "/home/martin";
      createHome = true;

      isNormalUser = true;
      uid = 1000;
    };
  };

  users.extraGroups.vboxusers.members = [ "martin" ];
}
