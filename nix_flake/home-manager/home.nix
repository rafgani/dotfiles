{ config, pkgs, ... }:

{ 


  imports = [
   # ./apps/zsh.nix
  ];

  home.username = "rafgani";
  home.homeDirectory = "/home/rafgani";
  home.stateVersion = "23.05";
  home.packages = with pkgs; [
    btop
    htop
    foot
    kitty
    waynergy
    qpdfview
    #zsh
    #fzf
    git
    #zoom-us
    lyx
    kate
    grc
    texmacs
    firefox
    gcc 
    ghc
    cabal2nix
    gnumake
    gallery-dl
    #gnomeExtensions.paperwm
    #gnomeExtensions.dash-to-dock
    #gnomeExtensions.material-shell
    #gnomeExtensions.gtk-title-bar
    texlive.combined.scheme-full
    rofi-wayland
    photoqt
    geogebra6
    #pcmanfm
    mpv
    smplayer
    sageWithDoc
    appimage-run
    libsForQt5.bismuth
    #virtscreen
    zoom-us
    networkmanager_dmenu
  ];

  #programs.bash.enable = true;
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      # Manually packaging and enable a plugin
      {
      name = "z";
      src = pkgs.fetchFromGitHub {
        owner = "jethrokuan";
        repo = "z";
        rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
        sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
        };
       }
      ];
    };
  
}
