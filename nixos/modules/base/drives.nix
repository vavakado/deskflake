{
  boot.supportedFilesystems = [ "ntfs" ];
  fileSystems."/mnt/corpse" = {
    device = "/dev/disk/by-partuuid/2be7643d-46e7-96e2-d242-f873181ab5b4";
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
}
