include_local_recipe "alacritty"
include_local_recipe "chruby"
include_local_recipe "gdb"
include_local_recipe "neovim"
include_local_recipe "vim"
include_local_recipe "fish"
include_local_recipe "fish-chruby"
include_local_recipe "ruby-dev"
include_local_recipe "tmux"


dotfile ".profile" do
  source "dominic/profile"
end
