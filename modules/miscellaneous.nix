{ pkgs, ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "hoshino" ];
    };
  };

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "hoshino-nix";
        "netbios name" = "hoshino-nix";
        "security" = "user";
        # change this according to my internet interface
        "interfaces" = "wlp2s0 192.168.0.0/16";
        "bind interfaces only" = "yes";
        # change the subnet ("192.168." in this case) according to the network you connect to, otherwise other machines are unable to connect to this machine.
        "hosts allow" = "192.168. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
      };

      "share" = {
        "path" = "/home/hoshino/Public";
        "browseable" = "yes";
        "read only" = "yes";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "write list" = "hoshino";
        "force user" = "hoshino";
        "force group" = "users";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}
