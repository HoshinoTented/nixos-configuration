{ ... }:

{
  users.users.hoshino = {
    isNormalUser = true;
    home = "/home/hoshino";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };
}
