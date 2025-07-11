{
  boot.supportedFilesystems = [ "ntfs" ];
  fileSystems."/mnt/corpse" = {
    device = "/dev/disk/by-uuid/01D9C60AB3801AB0";
    fsType = "ntfs-3g";
    options = [
      "uid=1000"
      "gid=100"
      "dmask=027"
      "fmask=137"
      "rw"
      "x-systemd.automount"
    ];
  };

  fileSystems."/mnt/vault156" = {
    device = "/dev/disk/by-uuid/a607cf11-85e9-4d2a-b9b0-ccc1fa23e9a5";
    fsType = "ext4";
    options = [ "x-systemd.automount" ];
  };
}
