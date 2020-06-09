#!/bin/bash
# my-global-repo-scripts-private get-softwareversions.bash

echo " "
echo "Getting your software versions - Processing"

declare -a software
declare -a command
declare -a version
i=1

# UBUNTU
software[$i]="ubuntu"
thecommand="lsb_release -a"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"Description:"* ]]; then
        # Remove Description:
        line=${line//Description:/}
        # Remove leading white space
        NO_LEAD_SPACE="$(echo -e "${line}" | sed -e 's/^[[:space:]]*//')"
        version[$i]=$NO_LEAD_SPACE
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# KERNAL
software[$i]="kernal"
thecommand="uname -a"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
# LOOK AT LINE BY LINE
version[$i]=$OUTPUT
i=$i+1
printf "."

# GUEST ADDITIONS (VIRTUALBOX)
software[$i]="guest-additions"
thecommand="ls /opt | grep Guest"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"GuestAdditions"* ]]; then
        version[$i]=$line
    else
        version[$i]="N/A"
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# GNOME SHELL
software[$i]="GNOME-shell"
thecommand="gnome-shell --version"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"GNOME"* ]]; then
        version[$i]=$line
    else
        version[$i]="N/A"
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# BASH
software[$i]="bash"
thecommand="echo $BASH_VERSION"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
version[$i]=$OUTPUT
i=$i+1
printf "."

# ADD SPACE
software[$i]="jeffprintformat"
command[$i]="addspace"
i=$i+1
printf "."

# AWS
software[$i]="aws"
thecommand="aws --version"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
# LOOK AT LINE BY LINE
version[$i]=$OUTPUT
i=$i+1
printf "."

# BIND
software[$i]="bind"
thecommand="named -v"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
# LOOK AT LINE BY LINE
version[$i]=$OUTPUT
i=$i+1
printf "."

# DOCKER
software[$i]="docker"
thecommand="docker version"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"Version:"* ]]; then
        # Remove Version:
        line=${line//Version:/}
        # Remove leading white space
        NO_LEAD_SPACE="$(echo -e "${line}" | sed -e 's/^[[:space:]]*//')"
        version[$i]=$NO_LEAD_SPACE
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# FLY
software[$i]="fly"
thecommand="fly -version"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
# LOOK AT LINE BY LINE
version[$i]=$OUTPUT
i=$i+1
printf "."

# GCLOUD
software[$i]="gcloud"
thecommand="gcloud -v"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"SDK"* ]]; then
        version[$i]=$line
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# GCLOUD KUBECTL
software[$i]="kubectl"
thecommand="gcloud -v"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"kubectl"* ]]; then
        version[$i]="  $line"
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# GIT
software[$i]="git"
thecommand="git version"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
version[$i]=$OUTPUT
i=$i+1
printf "."

# GO
software[$i]="go"
thecommand="go version"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
version[$i]=$OUTPUT
i=$i+1
printf "."

# JEFFS my-go-tools (decryptfile)
software[$i]="jeffs(decryptfile)"
thecommand="decryptfile -v"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
version[$i]=$OUTPUT
i=$i+1
printf "."

# JEFFS my-go-tools (encryptfile)
software[$i]="jeffs(encryptfile)"
thecommand="encryptfile -v"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
version[$i]=$OUTPUT
i=$i+1
printf "."

# JEFFS my-go-tools (markdown-create-table-of-contents)
software[$i]="jeffs(markdown-create-table-of-contents)"
thecommand="markdown-create-table-of-contents -v"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
version[$i]=$OUTPUT
i=$i+1
printf "."

# JEFFS my-go-tools (markdown-delimiter-doer)
software[$i]="jeffs(markdown-delimiter-doer)"
thecommand="markdown-delimiter-doer -v"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
version[$i]=$OUTPUT
i=$i+1
printf "."

# JEFFS my-go-tools (md5-hash-file)
software[$i]="jeffs(md5-hash-file)"
thecommand="md5-hash-file -v"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
version[$i]=$OUTPUT
i=$i+1
printf "."

# KEYBASE (CLIENT)
software[$i]="keybase(Client)"
thecommand="keybase version"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"Client"* ]]; then
        version[$i]="$line"
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# KEYBASE (SERVICE)
software[$i]="keybase(Service)"
thecommand="keybase version"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"Service"* ]]; then
        version[$i]="$line"
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# KUBECTL
software[$i]="kubectl"
thecommand="kubectl version"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"Major:"* ]]; then
        # Shorting the line a bit to 60 characters"
        SHORTEN=${line:0:60}  
        version[$i]="$SHORTEN, etc..."
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# LATEX
software[$i]="latex"
thecommand="latex -version"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"pdfTeX"* ]]; then
        version[$i]=$line
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# LATEX dvisvgm
software[$i]="dvisvgm"
thecommand="dvisvgm --version"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
version[$i]="  $OUTPUT"
i=$i+1
printf "."

# LATEX pdflatex 
software[$i]="pdflatex"
thecommand="pdflatex -version"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"pdfTeX"* ]]; then
        version[$i]="  $line"
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# NATS-SERVER
software[$i]="nats-server"
thecommand="nats-server -v"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
version[$i]="$OUTPUT"
i=$i+1
printf "."

# PACKER 
software[$i]="packer"
thecommand="packer version"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"Packer"* ]]; then
        version[$i]=$line
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# POSTGRES
software[$i]="postgres"
thecommand="postgres -V"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
version[$i]="$OUTPUT"
i=$i+1
printf "."

# POSTGRES psql
software[$i]="psql"
thecommand="psql -V"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
version[$i]="  $OUTPUT"
i=$i+1
printf "."

# PROTOC
software[$i]="protoc"
thecommand="protoc --version"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
version[$i]="$OUTPUT"
i=$i+1
printf "."

# PYTHON (Redirect stderr)
software[$i]="python"
thecommand="python -V"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT=$( ($thecommand) 2>&1)
version[$i]="$OUTPUT"
i=$i+1
printf "."

# PYTHON pip 
software[$i]="pip"
thecommand="pip -V"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"pip "* ]]; then
        version[$i]="  $line"
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# PYTHON3
software[$i]="python3"
thecommand="python3 -V"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
version[$i]="$OUTPUT"
i=$i+1
printf "."

# PYTHON3 pip3
software[$i]="pip3"
thecommand="pip3 -V"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
version[$i]="  $OUTPUT"
i=$i+1
printf "."

# PYTHON3 pylint 
software[$i]="pylint"
thecommand="pylint --version"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"pylint"* ]]; then
        version[$i]="  $line"
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# REDIS-CLI
software[$i]="redis-cli"
thecommand="redis-cli --version"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
version[$i]="$OUTPUT"
i=$i+1
printf "."

# VAGRANT 
software[$i]="vagrant"
thecommand="vagrant version"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"Installed"* ]]; then
        version[$i]="$line"
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# VS CODE
software[$i]="vscode"
thecommand="code -v"
command[$i]=$thecommand
# Only stdout, not stderr
OUTPUT="$($thecommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    #Right now its on the first line
    version[$i]="$line"
    break 
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# PRINT OUT
echo " "
echo " "
for index in ${!software[*]}
do
    sw=${software[$index]}
    cmd=${command[$index]}
    ver=${version[$index]}

    # jeff print format
    if [[ $sw == *"jeffprintformat"* ]]; then
        if [[ $cmd == *"addspace"* ]]; then
            echo ""
        elif [[ $cmd == *"printthis"* ]]; then
            echo "$ver"
        fi
    # Blank or white space
    elif [[ -z "${ver// }" ]]; then
        tput setaf 7; printf "   %-18s" $sw;
        tput setaf 1; echo "Software Not Installed"
    # Not applicable
    elif [[ $ver == *"N/A"* ]]; then
        tput setaf 7; printf "   %-18s" $sw;
        tput setaf 7; echo "$ver"
    # Normal Format    
    else
        tput setaf 7; printf "   %-18s" $sw;
        tput setaf 2; echo "$ver"
    fi     
done
echo " "

