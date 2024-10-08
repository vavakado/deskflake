{ pkgs, ... }: {
  virtualisation.libvirtd.enable = true;

  # Enable TPM emulation (optional)
  virtualisation.libvirtd.qemu = {
    swtpm.enable = true;
    ovmf.packages = [ pkgs.OVMFFull.fd ];
  };

  # Enable USB redirection (optional)
  virtualisation.spiceUSBRedirection.enable = true;


  environment.systemPackages = with pkgs;
    [ virt-manager gnome-boxes ];
}
