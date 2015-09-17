 # alias gowork="export GOPATH=`pwd`;export OLDPATH=$PATH; export PATH=$PATH:$GOPATH/bin" 
 # alias gounwork="export PATH=$OLDPATH;unset GOPATH;unset OLDPATH" 


gowork () {
  export GOPATH=`pwd`
  export OLDPATH=$PATH
  export PATH=$PATH:$GOPATH/bin	
}

gounwork () {
  export PATH=$OLDPATH
  unset GOPATH
  unset OLDPATH	
}
