{ pkgs, ... }:
{
  unplugged = pkgs.writeShellScript "unplugged" ''
    if command -v "easyeffects" &>/dev/null ; then
      systemctl --user stop easyeffects
    fi

    cpupower frequency-set -g powersave
  '';

  plugged = pkgs.writeShellScript "plugged" ''
    if command -v "easyeffects" &>/dev/null ; then
      systemctl --user start easyeffects
    fi

    cpupower frequency-set -g performance
  '';
}
