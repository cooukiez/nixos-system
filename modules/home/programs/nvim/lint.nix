/*
  modules/home/programs/nvim/lint.nix

  created by ludw
  on 2026-02-16
*/

{
  # linting
  # https://nix-community.github.io/nixvim/plugins/lint/index.html
  plugins.lint = {
    enable = true;

    # enabling these will cause errors unless these tools are installed
    lintersByFt = {
      nix = [ "nix" ];
      markdown = [
        "markdownlint"
        # "vale"
      ];
      #clojure = ["clj-kondo"];
      #dockerfile = ["hadolint"];
      #inko = ["inko"];
      #janet = ["janet"];
      #json = ["jsonlint"];
      #rst = ["vale"];
      #ruby = ["ruby"];
      #terraform = ["tflint"];
      #text = ["vale"];
    };

    # create autocommand which carries out the actual linting
    autoCmd = {
      callback.__raw = ''
        function()
          if vim.opt_local.modifiable:get() then
            require('lint').try_lint()
          end
        end
      '';
      group = "lint";
      event = [
        "BufEnter"
        "BufWritePost"
        "InsertLeave"
      ];
    };
  };

  # https://nix-community.github.io/nixvim/NeovimOptions/autoGroups/index.html
  autoGroups = {
    lint = {
      clear = true;
    };
  };
}
