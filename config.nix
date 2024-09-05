{ config, lib, pkgs, ... }: 
{
  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    config.allowUnfree = true;
  };

  environment.systemPackages = with pkgs;[
    helix
    bat
  ];
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.httpd = {
    enable = true;
    enablePHP = true;
    virtualHosts.default = {
      listen = [{
        ip = "*";
        port = 80;
      }];
      documentRoot = "/var/www/page";
    };
  };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };
 
  systemd.tmpfiles.rules =
    [ "d /var/www/page" "f /var/www/page/index.php - - - - <?php phpinfo();" ];
  

  system.stateVersion = "24.05";
}
