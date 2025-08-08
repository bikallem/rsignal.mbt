{
  description = "A startup basic MoonBit project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    devshell.url = "github:numtide/devshell";
    moonbit-overlay.url = "github:jetjinser/moonbit-overlay";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    let
      vscode =
        pkgs:
        (pkgs.vscode.override { isInsiders = true; }).overrideAttrs (oldAttrs: rec {
          src = (
            builtins.fetchTarball {
              url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
              sha256 = "sha256:12jqmxah7bsg6hfa30dbdgprjqv20yhsbac97wqs58sl2hj88n3m";
            }
          );
          version = "latest";

          buildInputs = oldAttrs.buildInputs ++ [ pkgs.krb5 ];
        });
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devshell.flakeModule
      ];

      perSystem =
        {
          system,
          pkgs,
          ...
        }:
        rec {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              inputs.moonbit-overlay.overlays.default
              inputs.nix-vscode-extensions.overlays.default
            ];
          };

          packages.default = pkgs.vscode-with-extensions.override {
            vscode = (vscode pkgs);
            vscodeExtensions = [
              pkgs.vscode-marketplace.moonbit.moonbit-lang
              pkgs.vscode-marketplace.ms-python.vscode-pylance
              pkgs.vscode-marketplace.jnoortheen.nix-ide              
              pkgs.vscode-marketplace.github.copilot
              pkgs.vscode-marketplace.github.copilot-chat
            ];
          };

          devshells.default = {
            packages = with pkgs; [
              packages.default
              moonbit-bin.moonbit.latest
              moonbit-bin.lsp.latest
              python3
              # (vscode pkgs)
            ];
          };
        };

      systems = [
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    };
}
