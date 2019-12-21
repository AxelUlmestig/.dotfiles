DIR=$( cd $( dirname $BASH_SOURCE[0] ) && pwd )
BASHRC=$HOME/.bashrc
VIM_RC=$HOME/.vimrc
NVIM_RC=$HOME/.config/nvim/init.vim
GHCI=$HOME/.ghci
SSH_CONFIG=$HOME/.ssh/config

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
