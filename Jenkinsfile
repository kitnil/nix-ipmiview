pipeline {
    agent { label "nixbld" }
    environment {
        NIXPKGS_CONFIG = "${WORKSPACE}/config.nix"
        NIX_PATH = "nixpkgs=https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz"
    }
    stages {
        stage("Build derivation") {
            steps {
                nixSh cmd: 'nix-build -E "with (import <nixpkgs> {}); with pkgs; callPackage ./default.nix {}"'
            }
        }
    }
    post {
        success { cleanWs() }
        failure { notifySlack "Build failled: ${JOB_NAME} [<${RUN_DISPLAY_URL}|${BUILD_NUMBER}>]", "red" }
    }
}
