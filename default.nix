# shell.nix

{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    git
    python311
    #pyenv
    stdenv.cc.cc.lib
    #llama-cpp
    libstdcxx5

    poetry
    gnumake
    cmake
    ninja
    gcc

  ];


# idk is this the correct way to have models 
# poetry run python scripts/setup or
# python311Packages.huggingface-hub
# huggingface-cli download TheBloke/Mistral-7B-Instruct-v0.1-GGUF mistral-7b-instruct-v0.1.Q4_K_M.gguf --local-dir . --local-dir-use-symlinks False

  shellHook = ''
    # Set up Python 3.11 with pyenv
    #pyenv install 3.11
    #pyenv local 3.11

    # Verify Python version
    python --version

    # Install the dependencies using Poetry
    poetry install --with ui
    poetry install --with local


    export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [
        pkgs.stdenv.cc.cc
        ]}
  '';
}
