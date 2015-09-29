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


# http://superuser.com/a/611582
function countdown(){
   date1=$((`date +%s` + $1));
   while [ "$date1" -ne `date +%s` ]; do
     echo -ne "\r$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)";
     sleep 0.1
   done
}

function stopwatch(){
  date1=`date +%s`;
   while true; do
    echo -ne "\r$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)";
    sleep 0.1
   done
}
