{ pkgs, ... }:
{
  services.postgresql = {
    enable = false;
    package = pkgs.postgresql_16;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
    initialScript = pkgs.writeText "create-postgres-user" ''
      CREATE USER postgres WITH PASSWORD 'postgres';
    '';
  };
}
