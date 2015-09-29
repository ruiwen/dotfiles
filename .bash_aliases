 # alias gowork="export GOPATH=`pwd`;export OLDPATH=$PATH; export PATH=$PATH:$GOPATH/bin"
 # alias gounwork="export PATH=$OLDPATH;unset GOPATH;unset OLDPATH"


function gowork () {
  export GOPATH=`pwd`
  export OLDPATH=$PATH
  export PATH=$PATH:$GOPATH/bin
}

function gounwork () {
  export PATH=$OLDPATH
  unset GOPATH
  unset OLDPATH
}
