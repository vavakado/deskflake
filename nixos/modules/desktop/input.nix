{ pkgs, ... }:
{
  hardware.uinput.enable = true;
  hardware.logitech.wireless.enableGraphical = true;
  hardware.logitech.wireless.enable = true;

  hardware.i2c.enable = true;

  services.udev.packages = with pkgs; [
    vial
  ];
  environment.systemPackages = with pkgs; [
    vial
  ];

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-mozc
        # fcitx5-gtk
      ];
      quickPhrase = {
        smile = "（・∀・）";
        angry = "(￣ー￣)";
        sad = "(︶︹︺)";
        surprised = "（゜◇゜）";
        smug = "(¬‿¬)";
        cry = "(Ｔ▽Ｔ)";
        confused = "(・_・ヾ";
        blush = "(⁄ ⁄>⁄ ▽ ⁄<⁄ ⁄)";
        evil = "Ψ(｀▽´)Ψ";
        lenny = "( ͡° ͜ʖ ͡°)";
        shrug = "¯\\_(ツ)_/¯";
        tableflip = "(╯°□°）╯︵ ┻━┻";
        unflip = "┬─┬ ノ( ゜-゜ノ)";
        scream = "ヽ(ﾟДﾟ)ﾉ";
        thinking = "(☞ﾟヮﾟ)☞";
        suspicious = "눈_눈";
        dead = "x_x";
        happyCry = "(；▽；)";
        no = "（；¬＿¬）";
        yes = "٩(◕‿◕｡)۶";
        facepalm = "(－‸ლ)";
        tired = "(-_-)zzz";
        bored = "(๑-﹏-)";
        panic = "(;慌;)";
        derp = ">_>;";
        love = "(♥‿♥)";
        idea = "(⌐■_■)";
        cool = "(*^▽^*)";
        flustered = "( ◡▽◡)";
        sneaky = "(_)...";
        sleepy = "(。-`ω´-)";
        hungry = "＼(ºωº`)／";
        yawn = "(＾-゜)";
        party = "ヽ(•̀ᴗ•́)ノ";
        derp2 = "O_O";
        shock = "Σ( ° △ °|||)";
        rage = ">:(((((";
        grin = "^_^";
        smirk = "¬_¬";
        sigh = "(¬_¬)";
        drool = "\\(¦3:)\\/\"";
        flex = "(ง •_•)ง";
        jazzhands = "(◕‿◕✿)";
        meh = "¯\\_(ツ)_/¯";
        success = "ε(´∀`)ε";
        victory = "＼(＾○＾)／";
        failure = "(x_x)";
        oops = "(」o‸o)」";
        sorry = "(T_T)";
        blame = "('_')";
        helpless = "(„ᵕᴗᵕ„)";
        brokenheart = "(╥﹏╥)";
        starve = "(つω`*)";
        chill = "8-)";
        curious = "( ・ω・)";
        nerd = "8-|";
        sarcastic = "┐(￣ヘ￣)┌";
        sweatdrop = "(汗)";
        sparkles = "(ﾉ◕ヮ◕)ﾉ*:･ﾟ✧";

        awkward = "(・_・;)";
        prayer = "(*・人・*)";
        plotting = "(¬‿¬ )";
        fakeSmile = "(＾▽＾)";
        geek = "(☞ﾟ∀ﾟ)☞";
        mindBlown = "(°ロ°)☝";
        pokerFace = "(・_・)";
        tearsOfJoy = "｡ﾟ( ﾟ^∀^ﾟ)ﾟ｡";
        sobbing = "(இ﹏இ`｡)";
        gremlin = "ʕ•ᴥ•ʔ";
        baka = "(≧д≦ヾ)";
        sneezed = "(｡•́︿•̀｡)";
        zoomer = "(☞ﾟヮﾟ)☞ YEET";
        edgy = "☠(▀̿Ĺ̯▀̿ ̿)";
        glitch = "⸮‽⸘⸮‽";
        hacker = "(▀̿Ĺ̯▀̿ ̿)";
        nihilist = "(╯︵╰,)";
        woozy = "(◎_◎;)";
        dramatic = "∑(O_O;)";
        monkaS = "(；ﾟДﾟ)";
        ew = "(＃＞＜)";
        wheeze = "(≧▽≦)ノ";
        rageQuit = "༼ つ ◕_◕ ༽つ ┻━┻";
        spooky = "༼ つ ▀_▀ ༽つ";
        goblin = "(ﾉಥ益ಥ）ﾉ﻿ ┻━┻";
      };
    };
  };

  services.xserver = {
    xkb.extraLayouts.colemak-caps = {
      description = "Colemak layout wiht no caps remap";
      languages = [ "eng" ];
      symbolsFile = ./us;
    };
  };
}
