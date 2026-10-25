{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.zst";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    pkgs = import nixpkgs {system = "x86_64-linux";};
  in {
    packages.x86_64-linux.vodbot = pkgs.python3Packages.buildPythonApplication {
      pname = "vodbot";
      version = "1.1.12";
      src = ./.;
      pyproject = true;
      build-system = with pkgs.python3Packages; [
        google-api-python-client
        google-auth-httplib2
        google-auth-oauthlib
        setuptools
      ];
      dependencies = with pkgs; [
        python3Packages.argcomplete
        python3Packages.dataclasses-json
        python3Packages.discord-webhook
        python3Packages.m3u8
        python3Packages.pillow
        python3Packages.requests
        ffmpeg
      ];
    };
    packages.x86_64-linux.default = self.packages.x86_64-linux.vodbot;
  };
}
