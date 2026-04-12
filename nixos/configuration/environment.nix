{
  pkgs,
  pkgsStable,
  inputs,
  ...
}:
{
  environment = {
    localBinInPath = true;
    homeBinInPath = true;
    systemPackages =
      (with inputs; [
        zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        # flox.packages.${system}.default
        # fh.packages.${system}.default
        # nixos-conf-editor.packages.${system}.nixos-conf-editor
        # nix-software-center.packages.${system}.nix-software-center
      ])
      ++ (with pkgs; [
        clang
        cmake
        gcc
        glib
        gnome-extension-manager
        gnome-extensions-cli
        gnome-tweaks
        gnumake
        gpu-viewer
        ignition
        lshw-gui
        nautilus-python
        nix-diff
        nodejs_22
        ntfs3g
        nvitop
        nvtopPackages.nvidia
        sbctl
        unzip
        wget
        zip

        # Additional CUDA development tools
        # python3Packages.torch
        # python3Packages.tensorflow
        # python3Packages.cupy
      ])
      ++ (with pkgsStable; [
        corepack
        cudaPackages.cuda_cccl
        cudaPackages.cuda_cudart
        cudaPackages.cuda_cupti
        cudaPackages.cuda_gdb
        cudaPackages.cuda_nsight
        cudaPackages.cuda_nvcc
        cudaPackages.cuda_nvprof
        cudaPackages.cudatoolkit
        cudaPackages.cudnn
        cudaPackages.nccl
        fh
      ]);
    # CUDA environment variables
    sessionVariables = {
      CUDA_PATH = "${pkgs.cudatoolkit}";
      LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
        pkgs.linuxPackages.nvidia_x11
        pkgs.ncurses5
        pkgs.stdenv.cc.cc.lib
        pkgs.zlib
        pkgs.libGL
        pkgs.glib
        pkgs.gtk3
        pkgs.libGLU
      ];
      EXTRA_LDFLAGS = "-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib";
      EXTRA_CCFLAGS = "-I/usr/include";
    };
  };
}
