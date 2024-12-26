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

# set the caps lock key to behave like esc
sudo sed -i 's/XKBOPTIONS=.*/XKBOPTIONS="caps:escape"/g' /etc/default/keyboard

if ! command -v nix &> /dev/null
then
  sh <(curl -L https://nixos.org/nix/install) --no-daemon
else
  echo "Nix already found, skipping download"
fi

# install a bunch of stuff needed by ghcup
sudo apt update
sudo apt install -y build-essential curl libffi-dev libffi8 libgmp-dev libgmp10 libncurses-dev pkg-config

if ! command -v ghcup &> /dev/null
then
  sudo apt install -y build-essential curl libffi-dev libffi7 libgmp-dev libgmp10 libncurses-dev libncurses5 libtinfo5
  curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
else
  echo "GHCup already found, skipping download"
fi

if ! command -v spotify &> /dev/null
then
  curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt update && sudo apt install -y spotify-client
else
  echo "Spotify already found, skipping download"
fi

sudo add-apt-repository ppa:neovim-ppa/stable -y
sudo apt install neovim -y
