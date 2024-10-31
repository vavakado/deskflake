{ pkgs, ... }: {
  services.sunshine = {
    enable = true;
    # Enable nvenc support (look for issue #305891)
    package = with pkgs;
      (pkgs.sunshine.override {
        cudaSupport = true;
        cudaPackages = cudaPackages;
      })
      .overrideAttrs (old: {
        nativeBuildInputs =
          old.nativeBuildInputs
          ++ [
            cudaPackages.cuda_nvcc
            (lib.getDev cudaPackages.cuda_cudart)
          ];
        cmakeFlags =
          old.cmakeFlags
          ++ [
            "-DCMAKE_CUDA_COMPILER=${(lib.getExe cudaPackages.cuda_nvcc)}"
          ];
      });
    openFirewall = true;
    capSysAdmin = true;
  };
}
