#!/bin/sh

#--------------
# author:xiaog
#--------------

#
#   NOTE:Make sure you have INSTALLed git and ctags
#

_CURRENT_PATH=`pwd`
_TEMP_DIR=$_CURRENT_PATH/temp
_USER=`whoami`
_VIM_HOME=""
_VIM_PLUGIN=""
_VIM_DOC=""
_VIM_FTPLUGIN=""

init()
{
    if [ "$_USER" = "root" ];then
        _VIM_HOME="/root/.vim"
    else
        _VIM_HOME="/home/"$_USER"/.vim"
    fi
    _VIM_PLUGIN=$_VIM_HOME"/plugin"
    _VIM_DOC=$_VIM_HOME"/doc"
    _VIM_FTPLUGIN=$_VIM_HOME"/ftplugin"

    if [ ! -d "$_VIM_PLUGIN" ]; then
        echo "mkdir $_VIM_PLUGIN ..."
        mkdir $_VIM_PLUGIN
    fi
    if [ ! -d "$_VIM_FTPLUGIN" ]; then
        echo "mkdir $_VIM_FTPLUGIN ..."
        mkdir $_VIM_FTPLUGIN
    fi
    if [ ! -d "$_TEMP_DIR" ]; then
        echo "mkdir $_TEMP_DIR ..."
        mkdir "$_TEMP_DIR"
    fi
}

#	taglist.vim
taglist()
{
    _TAGLIST="taglist"
    echo "INSTALL $_TAGLIST start ..."
    _TAGLIST_FILE="taglist.zip"

    if [ ! -d "$_TEMP_DIR/$_TAGLIST" ]; then
        echo "mkdir $_TAGLIST ..."
        mkdir "$_TEMP_DIR/$_TAGLIST"
    fi
        wget -q -nd -O $_TEMP_DIR/$_TAGLIST/$_TAGLIST_FILE \
    http://sourceforge.net/projects/vim-taglist/files/vim-taglist/4.5/taglist_45.zip/download
    cd $_TEMP_DIR

    if [ ! -d "$_TAGLIST" ]; then
        mkdir "$_TAGLIST"
    fi
    echo "unzip $_TAGLIST_FILE ..."
    unzip -o $_TEMP_DIR/$_TAGLIST/$_TAGLIST_FILE -d $_TEMP_DIR/$_TAGLIST > /dev/null
    cp -rf $_TEMP_DIR/$_TAGLIST/plugin/* $_VIM_PLUGIN
    cp -rf $_TEMP_DIR/$_TAGLIST/doc/* $_VIM_DOC
    echo "INSTALL $_TAGLIST success ..."
}

#	INSTALL NERDTree
nerdtree()
{
    _NERDTREE="nerdtree"
    echo "INSTALL $_NERDTREE start ..."
    if [ ! -d "$_TEMP_DIR/$_NERDTREE" ]; then
        mkdir $_TEMP_DIR/$_NERDTREE
        git clone https://github.com/scrooloose/nerdtree.git $_TEMP_DIR/$_NERDTREE
    fi
    cp -rf $_TEMP_DIR/$_NERDTREE/plugin $_VIM_HOME
    cp -rf $_TEMP_DIR/$_NERDTREE/doc $_VIM_HOME
    echo "INSTALL $_NERDTREE success ..."
}
#	INSTALL a.vim
a(){
    _A="a.vim"
    echo "INSTALL $_A start ..."
    wget -q -nd -O $_VIM_PLUGIN/$_A \
    http://www.vim.org/scripts/download_script.php?src_id=7218
    echo "INSTALL $_A success ..."
}

#	INSTALL a.vim
c()
{
    _C="c.vim"
    _C_FILE="cvim"
    _C_ZIP="cvim.zip"
    echo "INSTALL $_C start ..."
    if [ ! -d "$_TEMP_DIR/$_C_FILE" ]; then
        mkdir "$_TEMP_DIR/$_C_FILE" 
    fi
    wget -q -nd -O $_TEMP_DIR/$_C_ZIP \
    http://www.vim.org/scripts/download_script.php?src_id=17992
    echo "unzip $_C ..."
    unzip -o $_TEMP_DIR/$_C_ZIP -d $_TEMP_DIR/$_C_FILE -x *Templates *.template > /dev/null
    cp -rf $_TEMP_DIR/$_C_FILE/* $_VIM_HOME/
    echo "INSTALL $_C success ..."
}

clean()
{
    rm -rf $_TEMP_DIR
}

main()
{
   clean;
   init;
   a;
   c;
   nerdtree;
   taglist;
}

main


