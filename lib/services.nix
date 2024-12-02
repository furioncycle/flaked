{ lib, ... }:
let
  # make a service that is a part of the graphical session target
  mkGraphicalService = lib.recursiveUpdate {
    Unit.PartOf = [ "graphical-session.target" ];
    Unit.After = [ "graphical-session.target" ];
  };

in
{
  inherit mkGraphicalService;
}
