{ outputs, inputs }:
let
  addPatches = pkg: patches: pkg.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ patches;
  });
in
{
  # For every flake input, aliases 'pkgs.inputs.${flake}' to
  # 'inputs.${flake}.packages.${pkgs.system}' or
  # 'inputs.${flake}.legacyPackages.${pkgs.system}' or
  flake-inputs = final: _: {
    inputs = builtins.mapAttrs
      (_: flake: (flake.legacyPackages or flake.packages or { }).${final.system} or { })
      inputs;
  };

  # Adds my custom packages
  additions = final: prev: import ../pkgs { pkgs = final; } // { };

  # Modifies existing packages
  modifications = final: prev: {
    auto-cpufreq = prev.auto-cpufreq.overrideAttrs (oldAttrs: {
      postPatch =
        oldAttrs.postPatch
        + ''

              substituteInPlace pyproject.toml \
              --replace-fail 'psutil = "^6.0.0"' 'psutil = ">=6.0.0,<8.0.0"'
            '';
    });
  };
}
