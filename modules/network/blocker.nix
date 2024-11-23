{ config, ... }:
{
  networking.stevenblack = {
    enable = true;
    block = [
      "porn"
      "gambling"
      "fakenews"
    ];
  };
}
