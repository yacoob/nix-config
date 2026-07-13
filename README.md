## Next

- entire fish config
- stop and figure out a sensible layout for multiple hosts
- figure out out-of-tree stuff for corp

## naive modification list

```
dot_config/fish/conf.d/01-general.fish
dot_config/fish/conf.d/02-extra-binaries.fish
dot_config/fish/conf.d/03-interactive.fish
dot_config/fish/conf.d/04-theme.fish
dot_config/fish/conf.d/05-extras.fish
dot_config/fish/conf.d/06-plugins.fish
dot_config/fish/conf.d/zz-hooks.fish
dot_config/fish/fish_plugins
dot_config/fish/functions/humanize-seconds.fish

dot_local/bin/executable_u4025qw-kvm-flip.sh
dot_face.icon
dot_appimages/
workarea/

dot_config/nvim/dot_neoconf.json
dot_config/nvim/init.lua
dot_config/nvim/lua/
dot_config/nvim/lua/config/
dot_config/nvim/lua/config/autocmds.lua
dot_config/nvim/lua/config/keymaps.lua
dot_config/nvim/lua/config/lazy.lua
dot_config/nvim/lua/config/options.lua
dot_config/nvim/lua/plugins/
dot_config/nvim/lua/plugins/nvim-lint.lua
dot_config/nvim/lua/plugins/tokyonight.lua
dot_config/nvim/stylua.toml

dot_config/git/attributes.tmpl
dot_gitconfig
dot_gitconfig.oauth

dot_ssh/allowedSigners
dot_ssh/authorized_keys.tmpl

dot_config/systemd/user/gh-pr-count.service
dot_config/systemd/user/gh-pr-count.timer

dot_config/kcminputrc.src.ini
dot_config/kdeglobals.src.ini
dot_config/kglobalshortcutsrc.src.ini
dot_config/krunnerrc
dot_config/kscreenlockerrc.src.ini
dot_config/kwinrc.src.ini
dot_config/plasma-localerc
dot_config/plasmaparc.src.ini
dot_config/plasmashellrc.src.ini
dot_config/private_kxkbrc

dot_aptitude/config
dot_config/atuin/config.toml
dot_config/bat/config
dot_config/bat/themes/tokyonight_night.tmTheme
dot_config/environment.d/qt_font_scaling.conf
dot_config/ghostty/config
dot_config/htop/htoprc
dot_config/jj/config.toml
dot_config/lazygit/config.yml
dot_config/stylua/stylua.toml
dot_config/tealdeer/config.toml
dot_ipython/profile_default/ipython_config.py
dot_markdownlint-cli2.yaml
dot_rgignore
```

## Future
- work out something that works well for onyx and snufkin
- generalize to all hosts (including corp?) if there are no problems
- test out nixos vm
