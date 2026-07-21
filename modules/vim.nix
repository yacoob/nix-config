{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (config.flavour) atLeast;

  # Personal, lazyvim-independent config. Applied to plain neovim (base) via
  # extraLuaConfig and fed into lazyvim (desktop) through config.* — one source.
  options = ''
    local opt = vim.opt

    -- whitespace
    opt.list = true -- highlight some special characters
    opt.listchars = { tab = "| ", trail = "·", extends = "»", precedes = "«" }

    -- searching
    opt.gdefault = true -- g flag by default for :s
    opt.matchpairs = "[:],(:),{:},<:>" -- add < and > to list of matching brackets
    opt.showmatch = true -- flash matching bracket

    -- ui
    opt.guifont = "FiraCode Nerd Font:h14"
    opt.scrolloff = 14 -- leave this amount of lines while scrolling up/down
    opt.winblend = 10 -- transparency for floating window
    opt.pumblend = 10 -- transparency for popup menu

    -- behavioral
    opt.autowrite = true -- auto-write file before certain operations
    opt.keymodel = "startsel" -- shift+special key = selection
    opt.cmdheight = 1 -- no more "press enter prompts" for one line outputs

    -- disable unused language providers
    vim.g.loaded_perl_provider = 0
    vim.g.loaded_python3_provider = 0
    vim.g.loaded_ruby_provider = 0
    vim.g.loaded_node_provider = 0
  '';

  keymaps = ''
    local wk = require("which-key")

    -- forgot your sudo?
    vim.keymap.set("c", "w!!", "w !sudo tee % >/dev/null", { desc = "sudo write :3" })

    -- Insert mode abbreviations
    vim.keymap.set("ia", "---", "—")
    vim.keymap.set("ia", "dts", 'strftime("%Y-%m-%d")', { expr = true })

    -- moving whole lines
    vim.keymap.set("n", "<A-k>", "ddkP")
    vim.keymap.set("n", "<A-j>", "ddp")
    vim.keymap.set("v", "<A-k>", "xkP`[V`")
    vim.keymap.set("v", "<A-j>", "xp`[V`]")

    -- my convenience shortcuts
    wk.add({ { "<Leader>Y", group = "yacoob shortcuts", icon = "󱚥" } })
    vim.keymap.set("n", "<Leader>Yc", ":cd %:p:h<CR>:pwd<CR>", { desc = "cd to current file's path" })
  '';

  autocmds = ''
    -- Create augroup
    local yacoob_group = vim.api.nvim_create_augroup("yacoob", { clear = true })

    -- Strip trailing whitespace on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = yacoob_group,
      desc = "Strip trailing whitespace on save",
      command = ":%s/\\s\\+$//e",
    })
  '';
in
{
  # minimal: a lightweight vi (provides the `vi` the fish EDITOR fallback lands on)
  home.packages = lib.optional (!(atLeast "base")) pkgs.nvi;

  programs.neovim = lib.mkMerge [
    # base + desktop: neovim, with vi/vim aliases
    (lib.mkIf (atLeast "base") {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    })
    # base only: personal config on plain neovim (desktop routes it through lazyvim)
    (lib.mkIf (atLeast "base" && !(atLeast "desktop")) {
      plugins = [ pkgs.vimPlugins.which-key-nvim ];
      initLua = ''
        -- leader must be set before which-key and any <Leader> mapping
        vim.g.mapleader = " "

        require("which-key").setup()

        ${options}
        ${keymaps}
        ${autocmds}
      '';
    })
  ];

  # desktop: full lazyvim on top, with the personal config plus lazyvim-specific bits
  programs.lazyvim = lib.mkIf (atLeast "desktop") {
    enable = true;
    installCoreDependencies = false;

    config.options = ''
      ${options}

      -- lazyvim settings
      vim.g.root_spec = { "lsp", { ".jj", ".git", "lua" }, "cwd" }

      -- lazyvim top-level lsp preferences
      vim.g.lazyvim_python_lsp = "ty"
      vim.g.lazyvim_python_ruff = "ruff"
    '';
    config.keymaps = keymaps;
    config.autocmds = autocmds;

    plugins.tokyonight = ''
      return {
        "folke/tokyonight.nvim",
        opts = { style = "night" },
      }
    '';
  };
}
