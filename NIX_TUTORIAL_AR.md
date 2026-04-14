# دليل شامل لـ Nix و NixOS - بالعربي

## نظرة عامة

هذا الملف يشرح تكوين NixOS الخاص بك بشكل مفصل بلغة Nix مع أمثلة.

---

## الجزء الأول: لغة Nix

### 1.1 القيم الأساسية (Values)

```nix
# الأنواع الأساسية في Nix:

# 1. النصوص (Strings)
name = "Abdelrahman";
path = /home/abdelrahman;

# 2. الأرقام (Integers/Floats)
version = 25;
pi = 3.14;

# 3. القوائم (Lists)
packages = [ gcc cmake python ];
colors = [ "red" "green" "blue" ];

# 4. القواميس/السجلات (Attribute Sets/Records)
user = {
  name = "abdelrahman";
  shell = "/bin/zsh";
  groups = [ "wheel" "docker" ];
};

# 5. القيم المنطقية (Booleans)
enable = true;
disable = false;
```

### 1.2 الدوال (Functions)

```nix
# صيغة الدالة: اسم_المعامل: قيمة_المعامل:_expression

# دالة بسيطة
double = x: x * 2;

# دالة بأكثر من معامل
add = x: y: x + y;

# استخدام الدالة
result = double 5;        # = 10
sum = add 3 4;            # = 7

# دالة مع سجل (Attribute Set)
config = { pkgs, lib, ... }: {
  # ...
};
```

### 1.3 السجلات (Attribute Sets)

```nix
# إنشاء سجل
person = {
  name = "Ahmed";
  age = 25;
  hobbies = [ "reading" "coding" ];
};

# الوصول للقيم
name = person.name;           # = "Ahmed"
firstHobby = person.hobbies.0; # = "reading"

# دمج السجلات (//)
defaults = { port = 80; host = "localhost"; };
custom = { port = 8080; };
merged = defaults // custom;   # { port = 8080; host = "localhost"; }

# استخدام with
math = { pi = 3.14; e = 2.71; };
result = with math; pi + e;    # = 5.85
```

### 1.4 التحكم الشرطي

```nix
# if الشرطية
grade = if score >= 90 then "A" else if score >= 80 then "B" else "C";

# assert التحقق
config = assert lib.assertMsg (version >= 20) "Nix version too old"; {
  # ...
};
```

### 1.5 الحلقات والتكرار

```nix
# map - تطبيق دالة على كل عنصر
numbers = [ 1 2 3 4 5 ];
doubled = map (x: x * 2) numbers;  # [ 2 4 6 8 10 ]

# filter - تصفية العناصر
evens = filter (x: x % 2 == 0) numbers;  # [ 2 4 ]

# listToAttrs - تحويل قائمة إلى سجل
pairs = [ { name = "a"; value = 1; } { name = "b"; value = 2; } ];
attrs = lib.listToAttrs pairs;  # { a = 1; b = 2; }

# pipe - تسلسل عمليات (من lib)
result = lib.pipe numbers [ (map (x: x + 1)) (filter (x: x > 3)) ];
```

### 1.6 وراثة_attrs (inherited attributes)

```nix
# بدون inherit
x = 1;
config = { x = x; };

# مع inherit
config = { inherit x; };  #Equivalent

# inherit with
inherit (pkgs) gcc cmake;  # تكافئ: gcc = pkgs.gcc; cmake = pkgs.cmake;
```

### 1.7 let و with في Nix

```nix
# let - تعريف متغيرات محلية
result = let
  a = 10;
  b = 20;
in
  a + b;  # = 30

# with - استيراد مؤقت
config = let
  os = { version = "25.11"; kernel = "6.1"; };
in
  with os;
  "OS: ${version}, Kernel: ${kernel}";
```

---

## الجزء الثاني: هيكل التكوين (Configuration Structure)

### 2.1 هيكل المجلدات

```
.dotfiles/
├── flake.nix                 # نقطة الدخول - تعريف الـ inputs والـ outputs
├── devenv.nix                # بيئة التطوير
└── nixos/
    ├── configuration.nix      # استيراد كل الوحدات
    ├── configuration/        # الوحدات المشتركة
    │   ├── system.nix       # إعدادات Nix و nixpkgs
    │   ├── environment.nix  # المتغيرات والـ packages
    │   ├── hardware.nix     # تعريفات hardware
    │   ├── boot.nix         # إعدادات bootloader
    │   ├── users.nix        # المستخدمين والمجموعات
    │   ├── programs.nix     # برامج النظام
    │   ├── services.nix     # خدمات النظام
    │   ├── networking.nix   # الشبكة
    │   ├── security.nix      # الأمان
    │   ├── locale.nix        # اللغة والمنطقة
    │   ├── virtualisation.nix #虚拟化
    │   └── home-manager.nix   # إعدادات home-manager
    ├── device/              # إعدادات خاصة بكل جهاز
    │   └── Abdelrahman-nixos/
    │       ├── configuration.nix
    │       └── hardware-configuration.nix
    └── home-manager/        # إعدادات المستخدم
        ├── hm-configuration.nix
        └── hm-configuration/
            ├── home.nix
            ├── programs.nix
            ├── services.nix
            ├── gtk.nix
            ├── xdg.nix
            ├── dconf.nix
            └── niri/
```

### 2.2 شرح flake.nix

```nix
{
  description = "Abdelrahman's NixOS Configuration";

  # ═══════════════════════════════════════════════════════════
  # inputs - هنا تعرف كل المصادر الخارجية (Flakes)
  # ═══════════════════════════════════════════════════════════
  inputs = {
    # nixpkgs - المستودع الرئيسي لحزم Nix
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    # nixpkgs-stable - نسخة مستقرة من nixpkgs
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    
    # home-manager - إدارة إعدادات المستخدم
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";  # يتبع نفس nixpkgs
    };
    
    # nuri - مدير نوافذ Wayland
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # zen-browser - متصفح Zen
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # NUR - مستودع حزم المستخدم
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # lanzaboote - bootloader آمن
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # ═══════════════════════════════════════════════════════════
  # outputs - هنا يتم بناء التكوين النهائي
  # ═══════════════════════════════════════════════════════════
  outputs = { ... }@inputs:  # @inputs يعني كل المدخلات
    let
      system = "x86_64-linux";  # بنية النظام
      
      # إنشاء تكوين stable_packages منفصل
      pkgsStable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
      
      # قائمة الأجهزة المدعومة
      hostNames = [ "Abdelrahman-nixos" ];
      
      # الوحدات المشتركة بين كل الأجهزة
      commonModules = [
        home-manager.nixosModules.home-manager  # تفعيل home-manager
        nur.modules.nixos.default               # تفعيل NUR
        ./nixos/configuration.nix               # الوحدات المشتركة
      ];
    in
    {
      # nixosConfigurations - تعريف تكوينات NixOS
      nixosConfigurations = lib.pipe hostNames [
        # تحويل كل اسم جهاز إلى تكوين كامل
        (map (hostName:
          lib.nameValuePair hostName (
            lib.nixosSystem {
              inherit system;
              modules =
                commonModules
                ++ [ { networking.hostName = hostName; } ]  # اسم الجهاز
                ++ [ (./. + "/nixos/device/${hostName}/configuration.nix") ];  # إعدادات خاصة بالجهاز
              specialArgs = {
                inherit inputs;           # تمرير كل المدخلات
                inherit system pkgsStable nur;  # تمرير المتغيرات
              };
            }
          )
        ))
        lib.listToAttrs  # تحويل للقاموس
      ];
    };
}
```

---

## الجزء الثالث: شرح الملفات الأساسية

### 3.1 nixos/configuration.nix

```nix
{ ... }:
{
  # imports - استيراد الوحدات الفرعية
  imports = [
    ./configuration/boot.nix       # إعدادات bootloader
    ./configuration/hardware.nix   # تعريف hardware
    ./configuration/locale.nix    # اللغة والمنطقة
    ./configuration/programs.nix   # البرامج
    ./configuration/services.nix    # الخدمات (مثل cups, printing)
    ./configuration/users.nix      # المستخدمين
    ./configuration/environment.nix # الحزم والمتغيرات
    ./configuration/home-manager.nix # home-manager
    ./configuration/networking.nix  # الشبكة
    ./configuration/security.nix    # الأمان
    ./configuration/system.nix       # nix و nixpkgs
    ./configuration/virtualisation.nix # virtualisation
  ];
}
```

### 3.2 nixos/configuration/system.nix

```nix
{
  pkgs,
  nur,
  ...
}:
{
  # ═══════════════════════════════════════════════════════════
  # إعدادات nix - مدير الحزم
  # ═══════════════════════════════════════════════════════════
  nix = {
    # استخدام Lix - إصدار Nix محسن
    package = pkgs.lixPackageSets.stable.lix;
    
    settings = {
      # تفعيل الميزات التجريبية
      experimental-features = [ "flakes" "nix-command" ];
      
      # substituters - مصادر التحميل
      # هذه caches تخزن الحزم المبنية مسبقاً
      substituters = [
        "https://cuda-maintainers.cachix.org"    # cache لـ CUDA
        "https://nix-community.cachix.org"        # cache المجتمع
        "https://devenv.cachix.org"               # cache لـ Devenv
        "https://cache.flox.dev"
        "https://cache.nixos-cuda.org"           # cache إضافية CUDA
        "https://cache.garnix.io"
      ];
      
      # المفاتيح العامة للموثوقية
      trusted-public-keys = [
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        # ... مفاتيح أخرى
      ];
      
      # المستخدمون الموثوقون
      trusted-users = [ "root" "abdelrahman" ];
    };
  };

  # ═══════════════════════════════════════════════════════════
  # إعدادات nixpkgs
  # ═══════════════════════════════════════════════════════════
  nixpkgs = {
    config = {
      # allowUnfree - السماح بالحزم غير الحرة
      allowUnfree = true;
      
      # android_sdk.accept_license - قبول رخصة Android SDK
      android_sdk.accept_license = true;
      
      # cudaSupport - تفعيل دعم CUDA
      cudaSupport = true;
    };
    
    # overlays - تعديلات على nixpkgs
    overlays = [
      nur.overlays.default  # تفعيل NUR overlays
    ];
  };

  # ═══════════════════════════════════════════════════════════
  # إعدادات النظام
  # ═══════════════════════════════════════════════════════════
  system = {
    stateVersion = "25.11";  # إصدار النظام
    
    # الترقية التلقائية
    autoUpgrade = {
      enable = true;
      allowReboot = true;      # السماح بإعادة التشغيل
      dates = "daily";         # يومياً
    };
  };
  
  # zramSwap - ضغط الذاكرة
  zramSwap.enable = true;
  
  # الخطوط
  fonts.packages = with pkgs; [ monaspace ];
  console.packages = with pkgs; [ monaspace ];
}
```

### 3.3 nixos/configuration/environment.nix

```nix
{
  pkgs,
  pkgsStable,
  inputs,
  ...
}:
{
  environment = {
    # إضافة المسارات للنظام
    localBinInPath = true;     # ~/.local/bin
    homeBinInPath = true;      # ~/bin
    
    # ═══════════════════════════════════════════════════════════
    # systemPackages - الحزم المثبتة على مستوى النظام
    # ═══════════════════════════════════════════════════════════
    systemPackages =
      # حزم من flakes خارجية
      (with inputs; [
        zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      ])
      
      # حزم من unstable (nixpkgs.current)
      ++ (with pkgs; [
        clang      # مترجم C/C++
        cmake      # نظام البناء
        gcc        # GNU Compiler Collection
        glib       # مكتبة C
        nodejs_22  # Node.js
        
        # أدوات NVIDIA
        nvitopPackages.nvidia
        
        # إدارة الحزم
        sbctl      # Secure Boot keys
      ])
      
      # حزم من stable (nixpkgs.release)
      ++ (with pkgsStable; [
        corepack
        cudaPackages.cuda_nvcc     # CUDA compiler
        cudaPackages.cudnn         # CUDA Deep Neural Network
        cudaPackages.nccl         # NVIDIA Collective Communications Library
      ]);
    
    # ═══════════════════════════════════════════════════════════
    # sessionVariables - متغيرات البيئة للجلسات
    # ═══════════════════════════════════════════════════════════
    sessionVariables = {
      # مسار CUDA
      CUDA_PATH = "${pkgs.cudatoolkit}";
      
      # مسارات المكتبات
      LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
        pkgs.linuxPackages.nvidia_x11
        pkgs.ncurses5
        pkgs.stdenv.cc.cc.lib
      ];
      
      # flags إضافية
      EXTRA_LDFLAGS = "-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib";
      EXTRA_CCFLAGS = "-I/usr/include";
    };
  };
}
```

### 3.4 nixos/configuration/hardware.nix

```nix
{
  config,
  pkgs,
  ...
}:
{
  hardware = {
    # تفعيل كل الـ firmware
    enableAllFirmware = true;
    
    # ═══════════════════════════════════════════════════════════
    # Bluetooth
    # ═══════════════════════════════════════════════════════════
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    
    # ═══════════════════════════════════════════════════════════
    # NVIDIA GPU
    # ═══════════════════════════════════════════════════════════
    nvidia = {
      # open = false;  # proprietary driver for CUDA
      nvidiaSettings = true;       # nvidia-settings
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      
      # Power management
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      
      # Modesetting ضروري
      modesetting.enable = true;
    };
    
    # تفعيل NVIDIA container toolkit
    nvidia-container-toolkit.enable = true;
    
    # ═══════════════════════════════════════════════════════════
    # Graphics - إعدادات الرسوميات
    # ═══════════════════════════════════════════════════════════
    graphics = {
      enable = true;
      enable32Bit = true;  # مكتبات 32-bit
      
      # حزم إضافية للرسوميات
      extraPackages = with pkgs; [
        intel-media-driver   # Intel VAAPI
        intel-ocl            # Intel OpenCL
        intel-vaapi-driver
      ];
    };
  };
}
```

### 3.5 nixos/configuration/boot.nix

```nix
{ pkgs, ... }:
{
  boot = {
    # استخدام أحدث kernel
    kernelPackages = pkgs.linuxPackages_latest;
    
    # ═══════════════════════════════════════════════════════════
    # Bootloader - systemd-boot
    # ═══════════════════════════════════════════════════════════
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;  # تعديل متغيرات EFI
    };
    
    # ═══════════════════════════════════════════════════════════
    # initrd - initial ramdisk
    # ═══════════════════════════════════════════════════════════
    initrd.systemd.enable = true;
  };
}
```

### 3.6 nixos/configuration/users.nix

```nix
{ pkgs, ... }:
{
  users.users.abdelrahman = {
    shell = pkgs.zsh;           # استخدام zsh كـ shell
    isNormalUser = true;
    description = "Abdelrahman";
    
    # المجموعات التي ينتمي إليها المستخدم
    extraGroups = [
      "wheel"        # sudo
      "docker"       # Docker
      "flatpak"      # Flatpak
      "libvirtd"     # Virtualization
      "networkmanager"  # Network Manager
      "podman"       # Podman
      "video"        # GPU access
      "render"       # GPU rendering
    ];
  };
}
```

### 3.7 nixos/device/Abdelrahman-nixos/configuration.nix

```nix
{ ... }:
{
  imports = [ ./hardware-configuration.nix ];
  
  # ═══════════════════════════════════════════════════════════
  # blacklist - تعطيل kernel modules معينة
  # ═══════════════════════════════════════════════════════════
  boot.blacklistedKernelModules = [
    "nouveau"       # nouveau driver
    "nvidia_drm"
    "nvidia_modeset"
    "nvidia"
  ];
  
  networking.hostName = "Abdelrahman-nixos";
  
  # ═══════════════════════════════════════════════════════════
  # Printing - خدمات الطباعة
  # ═══════════════════════════════════════════════════════════
  services.printing.enable = true;
  
  # ═══════════════════════════════════════════════════════════
  # NVIDIA PRIME - للتبديل بين GPU integrated و dedicated
  # ═══════════════════════════════════════════════════════════
  hardware.nvidia.prime = {
    # Offload - استخدام GPU NVIDIA للعمليات الثقيلة
    offload = {
      enable = true;
      enableOffloadCmd = true;  # تفعيل nvidia-offload
    };
    
    # معرفات GPU
    intelBusId = "PCI:0:2:0";    # Intel integrated GPU
    nvidiaBusId = "PCI:1:0:0";   # NVIDIA dedicated GPU
  };
  
  # CUDA capabilities - ميزات GPU المدعومة
  nixpkgs.config.cudaCapabilities = [ "7.5" ];
}
```

### 3.8 nixos/configuration/home-manager.nix

```nix
{
  pkgs,
  inputs,
  ...
}:
{
  home-manager = {
    useGlobalPkgs = true;     # استخدام nixpkgs من النظام
    useUserPackages = true;   # تفعيل user packages
    
    # تعريف المستخدم
    users.abdelrahman = import ./../home-manager/hm-configuration.nix;
    
    # تمرير المتغيرات الخاصة
    extraSpecialArgs = {
      inherit inputs;
      inherit nix-flatpak nur;
      inherit niri dms;
    };
    
    # نوع ملف الـ backup
    backupFileExtension = "backup-${timestamp}";
    verbose = true;
  };
}
```

---

## الجزء الرابع: المصطلحات الأساسية

| المصطلح | المعنى |
|---------|--------|
| **Flake** | وحدة برمجية قابلة لإعادة الاستخدام مع مدخلات ومخرجات محددة |
| **Nixpkgs** | المستودع الرئيسي لجميع الحزم في Nix |
| **NixOS** | نظام تشغيل مبني على Nix |
| **Home Manager** | أداة لإدارة إعدادات المستخدم بشكل declarative |
| **Module** | ملف nix يستورد إعدادات معينة |
| **Overlay** | تعديل على nixpkgs لإضافة أو تغيير حزم |
| **Derivation** | وصف لكيفية بناء حزمة معينة |
| **Store** | `/nix/store` - مكان تخزين كل الحزم المبنية |
| **Cachix** | خدمة تخزين مؤقت للحزم المبنية |
| **Substituter** | مصدر لتحميل الحزم المبنية مسبقاً |

---

## الجزء الخامس: أوامر مهمة

```bash
# إعادة بناء النظام
sudo nixos-rebuild switch --flake .#Abdelrahman-nixos

# تحديث الـ flakes
nix flake update

# البحث عن حزمة
nix search nixpkgs firefox

# الدخول إلى shell مع حزمة
nix-shell -p python3

# عرض إعدادات NixOS
nixos-option <option>

# عرض كل الخيارات المتاحة
man configuration.nix
```

---

## الجزء السادس: شرح CUDA Error الذي واجهته

### ما حدث:
عند بناء CUDA packages، فشل التحميل من NVIDIA servers بسبب:
```
curl: (56) OpenSSL SSL_read: error:0A000126:SSL routines::unexpected eof while reading
```

### السبب:
- NVIDIA download server أوقف الاتصال أثناء التحميل (Connection reset)
- هذا ليس خطأ في تكوينيك، بل مشكلة شبكة مؤقتة

### الحل:
1. **إعادة المحاولة**: غالباً تنجح في المحاولة الثانية أو الثالثة
2. **استخدام VPN**: إذا كان هناك firewall
3. **الانتظار**: خوادم NVIDIA قد تكون مشغولة

### ملاحظة عن CUDA في تكوينيك:
```nix
# في system.nix - تفعيل CUDA
nixpkgs.config.cudaSupport = true;

# في environment.nix - تثبيت حزم CUDA
cudaPackages.cuda_nvcc      # CUDA compiler
cudaPackages.cudnn          # Deep Neural Network library
cudaPackages.nccl           # Collective communications

# في device configuration - تحديد capabilities GPU
nixpkgs.config.cudaCapabilities = [ "7.5" ];  # لبطاقات GTX 16xx/RTX 20xx+

# في hardware.nix - تفعيل NVIDIA driver
hardware.nvidia.modesetting.enable = true;
hardware.nvidia-container-toolkit.enable = true;
```

---

## الجزء السابع: نصائح

### 1. فهم الفرق بين unstable و stable:
```nix
# unstable - أحدث الحزم
pkgs = import nixpkgs { ... };  # nixos-unstable

# stable - حزم مستقرة
pkgsStable = import nixpkgs-stable { ... };  # nixos-25.11
```

### 2. استخدام lib:
```nix
lib.lists.map      # map على القوائم
lib.lists.filter   # filter
lib.attrsets       # عمليات على السجلات
lib.strings        # عمليات على النصوص
lib.pipe           # تسلسل عمليات
```

### 3. debugging:
```nix
# طباعة قيمة
pkgs.lib.trace "Value: ${value}" value

# assert للتحقق
assert lib.assertMsg (version >= 20) "Version too old"; config
```

---

هذا الدليل يغطي أساسيات لغة Nix وتكوين NixOS الخاص بك. إذا كان لديك أسئلة إضافية، لا تتردد في السؤال!
