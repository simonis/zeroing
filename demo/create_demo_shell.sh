
unset JAVA_TOOL_OPTIONS

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

export PATH=/priv/simonisv/Git/fireCRaCer:/priv/simonisv/output/crac-opt/images/jdk/bin:/priv/simonisv/Git/criu/criu:$PATH
# Need a new version of 'kill' which can pass integer value with the signal using sigqueue
# See: https://gitlab.com/procps-ng/procps/-/merge_requests/32
export PATH=/share/software/procps-master_bin/bin:$PATH
# Need a new version of ssh (8.3+) which supports environment variables for 'IdentityFile' in ~/.ssh/config
# See: https://www.openssh.com/releasenotes.html
export PATH=/share/software/openssh-9.6p1_bin/bin:$PATH
# Disable the bash builtin 'kill'
enable -n kill
export FC=/priv/simonisv/Git/fireCRaCer/deps
alias la='ls -la'
alias c='clear'

# export PS1="\[\e]0;\u@aws: \w\a\]\[\033[01;32m\]\u@aws\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ "
export PS1="$ "

DIR=$1

if [ "$1" == "firecracker1" ]; then
:
else
if [ "$1" == "firecracker2" ]; then
  DIR="firecracker1"
else
if [ "$1" == "petclinic" ]; then
  export CONSOLE_LOG_PATTERN="%clr(%d{hh:mm:ss.SSS}){faint} %clr(%.-1p) %.-65m%n${LOG_EXCEPTION_CONVERSION_WORD:-%wEx}"
  export CRAC_CRIU_PATH=/priv/simonisv/Git/criu/criu/criu
  export _JAVA_OPTIONS="-Xmx512m -XX:+UseSerialGC -Dlogging.level.org.springframework.web.filter.CommonsRequestLoggingFilter=DEBUG -DMyCommandLineRunner.jsonProcessing=true"
else
if [ "$1" == "crac2" ]; then
:
else
if [ "$1" == "firecracker" ]; then
  export FC_JAVA_OPTIONS="-Xmx512m -Xms512m -XX:+UseSerialGC -DMyCommandLineRunner.jsonProcessing=true -XX:CRaCCheckpointTo=/tmp/petclinic-crac -XX:CREngine=pauseengine -Djdk.crac.resource-policies=/opt/tools/crac-resource-policies.yaml"
  export BOOT_ARGS="sshd=true"
  export VCPU_COUNT=8
else
if [ "$1" == "firecracerclone" ]; then
  DIR="firecracer"
else
if [ "$1" == "firecracercmd" ]; then
  DIR="firecracer"
else
if [ "$1" == "uffd" ]; then
  DIR="firecracer"
else
if [ "$1" == "criu1" ]; then
  export CONSOLE_LOG_PATTERN="%clr(%d{hh:mm:ss.SSS}){faint} %clr(%.-1p) %.-65m%n${LOG_EXCEPTION_CONVERSION_WORD:-%wEx}"
else
if [ "$1" == "criu2" ]; then
  DIR="criu1"
  export CONSOLE_LOG_PATTERN="%clr(%d{hh:mm:ss.SSS}){faint} %clr(%.-1p) %.-65m%n${LOG_EXCEPTION_CONVERSION_WORD:-%wEx}"
else
if [ "$1" == "pmap" ]; then
  DIR="criu"
  export CONSOLE_LOG_PATTERN="%clr(%d{hh:mm:ss.SSS}){faint} %clr(%.-1p) %.-65m%n${LOG_EXCEPTION_CONVERSION_WORD:-%wEx}"
fi
fi
fi
fi
fi
fi
fi
fi
fi
fi
fi

mkdir -p /tmp/_$DIR
# Delete on exit
trap '{ rm -rf -- "/tmp/_$DIR"; }' EXIT
cd /tmp/_$DIR
if [ "$1" == "firecracker1" ]; then
  truncate -s 0 fc.log && rm -rf fc.sock
fi
if [ "$1" == "criu" ]; then
  mkdir -p /tmp/petclinic-criu
  mkdir -p /tmp/petclinic-criu-zero
  mkdir -p /tmp/petclinic-crac
fi

# See https://unix.stackexchange.com/questions/353386/when-is-a-multiline-history-entry-aka-lithist-in-bash-possible
# for why we need bash 5+ for multiline commands in the bash history file.
set -o history
unset HISTFILE
export HISTTIMEFORMAT=''
# Only keep the predefined history
export HISTIGNORE='*'
history -c
history -r $MYPATH/.history_$1
