# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "id_ID.UTF-8";
    LC_IDENTIFICATION = "id_ID.UTF-8";
    LC_MEASUREMENT = "id_ID.UTF-8";
    LC_MONETARY = "id_ID.UTF-8";
    LC_NAME = "id_ID.UTF-8";
    LC_NUMERIC = "id_ID.UTF-8";
    LC_PAPER = "id_ID.UTF-8";
    LC_TELEPHONE = "id_ID.UTF-8";
    LC_TIME = "id_ID.UTF-8";
  };

  #KDE
  # Enable the X11 windowing system.
  #services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;
  
  #XFCE
  services.xserver = {
    enable = true;   
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        #noDesktop = true;
        enableXfwm = false;
      };
    };
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = haskellPackages : [
          haskellPackages.xmonad-contrib
          haskellPackages.xmonad-extras
          haskellPackages.xmonad
        ];
      };
    };
      displayManager.defaultSession = "xfce+xmonad";
  };
  services.xserver.windowManager.spectrwm.enable = true;
  services.picom  = {
     enable       = true;
     fade         = true;
     inactiveOpacity = 0.9;
     fadeDelta       =4;
     vSync           =true;
     backend = "glx";
     settings = { 
                blur =
                     { method = "gaussian";
                       size = 10;
                       deviation = 5.0;
                     };
                blur-background = true;
		blur-background-frame = true;
		blur-background-fixed = true;
		blur-background-exclude = [
    			"window_type = 'dock'"
    			"window_type = 'desktop'"
			"class_g = 'xfce4-screenshooter'"
			];
		blur-kern = "3x3box";
		blur-method = "dual_kawase";
		blur-strength = 19;
		opacity-rule = [
  			"90:class_g = 'kitty'"
	       			];
		
		corner-radius = 12.0;
		rounded-corners-exclude = [
   		"class_g = 'Dunst'"
		];
    		};
	};
  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  #Hyprland
  #programs.hyprland = {
   #enable = true;
   #xwayland.hidpi = true;
   #xwayland.enable = true;
  #};
  # Hint Electon apps to use wayland
  #environment.sessionVariables = {
  #  NIXOS_OZONE_WL = "1";
  #};
  #services.greetd.enable = true;
  #services.greetd.restart = true;
  
  services.dbus.enable = true;

  #xdg.portal = {
  #  enable = true;
  #  wlr.enable = true;
  #  extraPortals = [
  #     pkgs.xdg-desktop-portal-gtk
  #  ];
  # };
 
  #programs.wayfire = {
  #   enable = true;
  #   plugins = with pkgs.wayfirePlugins; [
    #wcm
  #  wf-shell
    #wayfire-plugins-extra
  #];
  #};

 # Flakes

  # ~/.config/nix/nix.conf
  #experimental-features = nix-command flakes;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.power-profiles-daemon.enable = false; 
  services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;
      };
  };

  #services.bluetooth.enable = true;


  # Enable sound with pipewire.
  sound.enable = true;
  #hardware.pulseaudio.enable = true;
  #hardware.pulseaudio.support32Bit = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rafgani = {
    isNormalUser = true;
    description = "rafgani";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      appimage-run
      bolt
      btop
      catppuccin-kvantum
      dmenu
      emacs      
      evince
      #eww
      eww-wayland
      firefox
      foot
      gallery-dl
      geogebra6
      gnome.gnome-disk-utility
      geogebra
      git
      graphviz
      haskellPackages.Agda
      inkscape
      kate
      neovim
      kitty
      lyx
      libsForQt5.qtstyleplugin-kvantum
      microsoft-edge
      #materia-kde-theme
      nitrogen
      obs-studio
      photoqt
      pciutils
      pavucontrol
      powertop
      pulseaudio
      thunderbird
      qpdfview
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
      libreoffice-qt
      networkmanagerapplet
      vlc
      #teams
      texmacs
      texlive.combined.scheme-full
      xfce.thunar
      xfce.thunar-volman
      xfce.thunar-archive-plugin
      xarchiver
      xmobar
      #xfce.xfce4-systemload-plugin
      #xfce.xfce4-volumed-pulse
      xournalpp
      write_stylus
      zfs
      zoom-us
      #Hyprland
      grim
      slurp
      dunst
      rofi-wayland
      wofi
      libnotify
      socat
      jq
      python39
      #waybar
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  nixpkgs.config.permittedInsecurePackages = [
                "electron-14.2.9"
              ];
  
  
  nix.settings.trusted-users = [ "root" "rafgani" ];
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
      #libsForQt5.bismuth
      fishPlugins.done
      fishPlugins.fzf-fish
      fishPlugins.forgit
      fishPlugins.hydro
      fzf
      fishPlugins.grc
      grc
      #libsForQt5.konqueror
      #linuxPackages.nvidia_x11
      #Hyprland
      hyprland
      swww # for wallpapers
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      xwayland
      meson
      waybar
      wayland-protocols
      wayland-utils
      wl-clipboard
      wlroots
  ];
  
  #waybar overlay

  nixpkgs.overlays = [
    (self: super: {
       waybar = super.waybar.overrideAttrs (oldAttrs: {
           mesonFlags = oldAttrs.mesonFlags ++ [
              "-Dexperimental=true" ];
       });
     })
  ];

  #Fish
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;


  #Qt
  qt = {
      enable = true;
      platformTheme = "qt5ct";
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
  
  # Fstrim

  services.fstrim.enable = true;
  services.fstrim.interval = "weekly";
  boot.loader.systemd-boot.configurationLimit = 20;

  #boot.extraModulePackages = [ pkgs.linuxPackages.nvidia_x11 ];
  #boot.blacklistedKernelModules = [ "nouveau" "nvidia_drm" "nvidia_modeset" "nvidia" ];
  
  #Nvidia

  services.hardware.bolt.enable = true;

  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.prime.allowExternalGpu = true;
  hardware.nvidia.prime.offload.enable = true;
  hardware.nvidia.prime.nvidiaBusId = "PCI:7:0:0";
  hardware.nvidia.prime.intelBusId = "PCI:0:2:0";
  services.xserver.videoDrivers = ["nvidia" ];
  
  # Falthub

  #services.flatpak.enable = true;

  fonts.packages = with pkgs; [
  fantasque-sans-mono
  gyre-fonts
  nerdfonts
  meslo-lgs-nf
  ];


   # Make sure opengl is enabled
   #hardware.opengl = {
   # enable = true;
   # driSupport = true;
   # driSupport32Bit = true;
   #};

  # Tell Xorg to use the nvidia driver (also valid for Wayland)
  #services.xserver.videoDrivers = ["nvidia"];

  #hardware.nvidia = {

    # Modesetting is needed for most Wayland compositors
   # modesetting.enable = true;

    # Use the open source version of the kernel module
    # Only available on driver 515.43.04+
    #open = false;

    # Enable the nvidia settings menu
    #nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    #package = config.boot.kernelPackages.nvidiaPackages.stable;
  #};
}
