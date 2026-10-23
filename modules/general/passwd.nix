{ pkgs, user, config, ... }:
let
    password = "$y$j9T$zwImDNhx/m6xqpJk4y17s/$61DGJaZbKvtZaplx.d1Zj02fqwKUWoKPOB5fj1yd2y1";
in {
    programs.zsh.enable = true;
    users.mutableUsers = false;
    users.users.root = {
        hashedPassword = password;
        shell = pkgs.zsh;
    };
}