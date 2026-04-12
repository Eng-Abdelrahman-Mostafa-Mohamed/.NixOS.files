_: {
  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };
    amberol.enable = true;
    #   kdeconnect = {
    #     enable = true;
    #     indicator = true;
    #   };
    flatpak = {
      enable = true;
      uninstallUnmanaged = true;
      update.onActivation = true;
      packages = [
        "io.github.zaedus.spider"
        #     "io.github._0xzer0x.qurancompanion"
        #     "io.github.ladaapp.lada"
        #     "io.github.giantpinkrobots.flatsweep"
        #     "io.github.lo2dev.Echo"
        #     "app.fotema.Fotema"
        #     "io.github.sigmasd.stimulator"
        #     # "com.jeffser.Alpaca"
        #     "dev.skynomads.Seabird"
        #     "org.nickvision.tubeconverter"
        #     "com.github.gijsgoudzwaard.image-optimizer"
        #     "fr.handbrake.ghb"
        #     "io.github.seadve.Kooha"
        #     "org.onlyoffice.desktopeditors"
        #     "com.github.unrud.djpdf"
        #     "com.github.unrud.RemoteTouchpad"
        #     "io.gitlab.news_flash.NewsFlash"
        #     "com.warlordsoftwares.tube2go"
        #     "com.warlordsoftwares.formatlab"
        #     "io.github.zaedus.spider"
        #     "eu.nokun.MirrorHall"
        #     "es.danirod.Cartero"
        #     "pl.youkai.nscan"
        #     "com.mardojai.ForgeSparks"
        #     "com.github.tchx84.Flatseal"
        #     "com.belmoussaoui.snowglobe"
        #     "com.jetpackduba.Gitnuro"
        #     "de.philippun1.turtle"
        #     "de.philippun1.Snoop"
        #     "io.gitlab.theevilskeleton.Upscaler"
        #     "io.gitlab.adhami3310.Converter"
        #     "io.gitlab.adhami3310.Footage"
        #     "com.github.ADBeveridge.Raider"
        #     "com.github.tenderowl.frog"
        #     "org.angryip.ipscan"
        #     "org.gabmus.whatip"
        #     "org.nmap.Zenmap"
        #     "io.github.bytezz.IPLookup"
        #     "dev.geopjr.Archives"
        #     "io.github.getnf.embellish"
        #     "com.github.cassidyjames.dippi"
        #     "it.mijorus.whisper"
        #     # "com.github.joseexposito.touche"
        #     "io.github.vikdevelop.SaveDesktop"
      ];
    };
  };
}
