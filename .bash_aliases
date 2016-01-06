 # alias gowork="export GOPATH=`pwd`;export OLDPATH=$PATH; export PATH=$PATH:$GOPATH/bin"
 # alias gounwork="export PATH=$OLDPATH;unset GOPATH;unset OLDPATH"
alias timecurl="curl -w \"@${HOME}/dotfiles/curl/curlformat\" -o /dev/null -s "

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

function findport() {
  sudo lsof -i :${1}
}

function killport() {
  findport ${1}
  read -e -p "Kill these processes? [y/n]: " RESPONSE
  if [ ${RESPONSE,,} == 'y' ]; then
    sudo kill $(sudo lsof -t -i:${1})
    echo "Killed."
  fi
}


# Install stuff

function version_codename() {
  echo $(lsb_release -c | cut -f 2)
}

function install_requirements() {
  if [ ! $(which add-apt-repository) ];then
    sudo apt-get install software-properties-common
  fi
}

function install_go() {
  install_requirements
  sudo add-apt-repository ppa:ubuntu-lxc/lxd-stable &&
  sudo apt-get update &&
  sudo apt-get install -y golang
}

function install_postgres() {
  install_requirements
  VERSION=$(version_codename)
  if [ ! -e /etc/apt/sources.list.d/pgdg.list ]; then
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    echo "deb http://apt.postgresql.org/pub/repos/apt/ ${VERSION}-pgdg main" | sudo tee -a  /etc/apt/sources.list.d/pgdg.list > /dev/null
  fi
  sudo apt-get update
  sudo apt-get install postgresql-9.4
}

function install_docker() {
  install_requirements
  VERSION=$(version_codename)
  if [ ! -e /etc/apt/sources.list.d/docker.list ]; then
    sudo apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
    echo "deb https://apt.dockerproject.org/repo ubuntu-${VERSION} main" | sudo tee -a /etc/apt/sources.list.d/docker.list > /dev/null
  fi
  sudo apt-get update
  sudo apt-get purge lxc-docker*
  sudo apt-cache policy docker-engine
  sudo apt-get install docker-engine
}

