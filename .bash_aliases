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


# notify slack
function notify () {

  SLACK_URL="https://hooks.slack.com/services/INTERGRATION/KEY/HERE"
  RECIPIENT=${2:-@ruiwen}

  START=$(date -u)
  START_TIME=$(date +%s)

  OUTPUT="$($1)"

  DURATION=$((`date +%s` - $START_TIME))

  TEXT=$(cat <<TEXT
  \`\`\`
  DONE: ${1}\n
  Output:\n
  ${OUTPUT}\n\n
  Started: ${START}\n
  Duration: ${DURATION}s
  \`\`\`
TEXT
)

  BODY=$(cat <<BODY
  {"text": "${TEXT}", "channel": "${RECIPIENT}"}
BODY
)

  curl -X POST -d "${BODY}" -H "Content-Type: application/json" ${SLACK_URL}
}
