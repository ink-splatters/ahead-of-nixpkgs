{ pkgs, pre-commit-hooks, system, ... }:
pre-commit-hooks.lib.${system}.run {
  src = ../.;

  hooks = {
    deadnix.enable = true;
    markdownlint = {
      enable = true;
      settings.config = { MD013.tables = false; };
    };
    nil.enable = true;
    nixfmt.enable = true;
    statix.enable = true;
  };

  tools = pkgs;
}
