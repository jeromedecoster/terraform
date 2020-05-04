set -e

[[ $1 == '--no-color' ]] && COL=0;

nocol() { echo "[$1] ${@:2}"; }
log()   { [[ $COL == 0 ]] && nocol $@ || echo -e "\e[0;4m${1}\e[0m ${@:2}"; }        # underline $1
info()  { [[ $COL == 0 ]] && nocol $@ || echo -e "\e[38;5;82;4m${1}\e[0m ${@:2}"; }  # underline $1 in green
warn()  { [[ $COL == 0 ]] && nocol $@ || echo -e "\e[38;5;208;4m${1}\e[0m ${@:2}"; } # underline $1 in orange
error() { [[ $COL == 0 ]] && nocol $@ || echo -e "\e[38;5;196;4m${1}\e[0m ${@:2}"; } # underline $1 in red

URL=$(curl --silent https://www.terraform.io/downloads.html \
    | grep --only-matching https://releases.hashicorp.com/terraform/.*linux_amd64.zip \
    | cat )
# `| cat` tip from https://stackoverflow.com/a/6550543

[[ -z $URL ]] && { error abort download URL not found; exit; }

VERSION=$(echo $URL \
    | sed --expression 's|.*/terraform/||' --expression 's|/.*||')

[[ -n $(which terraform) && -n $(terraform version | grep $VERSION) ]] \
    && { warn abort terraform $VERSION already installed; exit; }

info install terraform $VERSION
TEMP=$(mktemp --directory)
cd $TEMP

log download $URL
[[ -n $(which curl) ]] \
    && curl $URL --progress-bar --output terraform.zip \
    || wget $URL --quiet --show-progress --output-document terraform.zip;

unzip terraform.zip

[[ -z $(sudo --user $(whoami) --set-home bash -c "[[ -w /usr/local/bin ]] && echo 1;") ]] \
    && { warn warn sudo access is required; sudo mv terraform /usr/local/bin; } \
    || mv terraform /usr/local/bin;

info installed terraform $VERSION

rm --force --recursive $TEMP
