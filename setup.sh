DIR=$( cd $( dirname $BASH_SOURCE[0] ) && pwd )
BASHRC=$HOME/.bashrc

NVIM_HOME=$HOME/.config/nvim
VIM_PLUG_LOCATION="${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim
NVIM_RC=$NVIM_HOME/init.vim
VIM_RC=$HOME/.vimrc

GHCI=$HOME/.ghci

SSH_CONFIG=$HOME/.ssh/config

US_SE_KEYBOARD_LAYOUT=/usr/share/X11/xkb/symbols/us_se

rm -f $BASHRC
ln -s $DIR/bashrc $BASHRC

rm -f $VIM_RC
ln -s $DIR/vimrc $VIM_RC

mkdir -p $HOME/.config/nvim
rm -f $NVIM_RC
ln -s $DIR/vimrc $NVIM_RC

rm -f $GHCI
ln -s $DIR/ghci $GHCI

mkdir -p $HOME/.ssh
rm -f $SSH_CONFIG
ln -s $DIR/ssh-config $SSH_CONFIG

if [ ! -f "$VIM_PLUG_LOCATION" ]; then
  sh -c "curl -fLo \"$VIM_PLUG_LOCATION\" \
    --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
else
  echo "Vim plug already found, skipping download"
fi

# If the keyboard layout was updated for the first time, go to Settings ->
# Region & Language, add a new "input source", choose "Swedish (US, with
# Swedish letters)"
if [ "$(uname -s)" = "Linux" ]; then
  sudo rm -f $US_SE_KEYBOARD_LAYOUT
  sudo ln -s $DIR/se_keyboard_layout $US_SE_KEYBOARD_LAYOUT
fi

