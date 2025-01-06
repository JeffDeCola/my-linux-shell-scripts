#!/bin/bash
# my-linux-shell-scripts get-software-versions.bash

# USAGE:
# bash get-software-versions.bash
#

# DECLARE ARRAYS AND INIT SOME VARIABLES --------------------------------------

declare -a software
declare -a command
declare -a version
declare -a indent
i=1

echo " "
echo "Getting your software versions - Processing"

# UBUNTU ----------------------------------------------------------------------

software[i]="ubuntu"
theCommand="lsb_release -a"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"Description:"* ]]; then
        # Remove Description:
        line=${line//Description:/}
        # Remove leading white space
        NO_LEAD_SPACE="$(echo -e "${line}" | sed -e 's/^[[:space:]]*//')"
        version[i]=$NO_LEAD_SPACE
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# GNOME SHELL -----------------------------------------------------------------

software[i]="GNOME-shell"
theCommand="gnome-shell --version"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"GNOME"* ]]; then
        version[i]=$line
    else
        version[i]="N/A"
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# KERNAL ----------------------------------------------------------------------

software[i]="kernal"
theCommand="uname -a"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
# LOOK AT LINE BY LINE
version[i]=$OUTPUT
i=$i+1
printf "."

# BASH ------------------------------------------------------------------------

software[i]="bash"
theCommand="echo $BASH_VERSION"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
version[i]=$OUTPUT
i=$i+1
printf "."

# ZSH -------------------------------------------------------------------------

software[i]="zsh"
theCommand="zsh --version"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
version[i]=$OUTPUT
i=$i+1
printf "."

# GUEST ADDITIONS (VIRTUALBOX) ------------------------------------------------

software[i]="guest-additions"
theCommand="ls /opt | grep Guest"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"GuestAdditions"* ]]; then
        version[i]=$line
    else
        version[i]="N/A"
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# -----------------------------------------------------------------------------
# ADD A SPACE -----------------------------------------------------------------
# -----------------------------------------------------------------------------

command[i]="addSpace"
i=$i+1
printf "."

# AWS -------------------------------------------------------------------------

software[i]="aws"
theCommand="aws --version"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
# LOOK AT LINE BY LINE
version[i]=$OUTPUT
i=$i+1
printf "."

# BIND ------------------------------------------------------------------------

software[i]="bind"
theCommand="named -v"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
# LOOK AT LINE BY LINE
version[i]=$OUTPUT
i=$i+1
printf "."

# DOCKER TITLE ----------------------------------------------------------------

software[i]="DOCKER"
theCommand="docker version"
command[i]=$theCommand
version[i]="DOCKER"
dockerNotFound="0"
# Redirect stderr to stdout so we can look at it
# OUTPUT="$($theCommand 2> /dev/null)"
OUTPUT="$($theCommand 2>&1)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"not found"* ]]; then
        # No Docker found
        version[i]=" "
        dockerNotFound="1"
        printf "."
    fi
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."


# DOCKER - CLIENT AND SERVER --------------------------------------------------
# SKIP IF NO DOCKER
if [[ $dockerNotFound == "0" ]]; then
    indent[i]="  "
    software[i]="client"
    theCommand="docker version"
    command[i]=$theCommand
    # Only stdout, not stderr
    OUTPUT="$($theCommand 2> /dev/null)"
    # LOOK AT LINE BY LINE
    while IFS= read -r line
    do
        if [[ $line == *"Version:"* ]]; then
            # Remove Version:
            line=${line//Version:/}
            # Remove leading white space
            NO_LEAD_SPACE="$(echo -e "${line}" | sed -e 's/^[[:space:]]*//')"
            version[i]=$NO_LEAD_SPACE
            # Break out if already found both versions (server and client)
            if [[ $foundFirstVersion == "1" ]]; then
            break
            fi
            # NOW LOOK FOR SERVER VERSION
            foundFirstVersion="1"
            i=$i+1
            indent[i]="  "
            software[i]="server"
            command[i]=$theCommand
            printf "."
        fi
    done < <(printf '%s\n' "$OUTPUT")
    i=$i+1
    printf "."
fi

# FLY -------------------------------------------------------------------------
software[i]="fly"
theCommand="fly -version"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
# LOOK AT LINE BY LINE
version[i]=$OUTPUT
i=$i+1
printf "."

# GCLOUD ----------------------------------------------------------------------
software[i]="gcloud"
theCommand="gcloud -v"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"SDK"* ]]; then
        version[i]=$line
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# GCLOUD KUBECTL --------------------------------------------------------------

software[i]="kubectl"
theCommand="gcloud -v"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"kubectl"* ]]; then
        version[i]="  $line"
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# GH (github CLI) -------------------------------------------------------------

software[i]="gh"
theCommand="gh --version"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"version"* ]]; then
        version[i]="$line"
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# GIT -------------------------------------------------------------------------

software[i]="git"
theCommand="git version"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
version[i]=$OUTPUT
i=$i+1
printf "."

# GO --------------------------------------------------------------------------

software[i]="go"
theCommand="go version"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
version[i]=$OUTPUT
i=$i+1
printf "."

# GTKWAVE ---------------------------------------------------------------------

software[i]="gtkwave"
theCommand="gtkwave --version"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"GTKWave Analyzer"* ]]; then
        version[i]="$line"
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# IVERILOG --------------------------------------------------------------------

software[i]="iverilog"
theCommand="iverilog -V"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"Verilog version"* ]]; then
        version[i]="$line"
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# JEFFS my-go-tools TITLE -----------------------------------------------------

software[i]="JEFFS"
theCommand="NOTHING"
command[i]=$theCommand
version[i]="JEFFS"
i=$i+1
printf "."

# JEFFS my-go-tools (decryptfile) ----------------------------------------------

indent[i]="  "
software[i]="decryptfile"
theCommand="decryptfile -v"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
version[i]=$OUTPUT
i=$i+1
printf "."

# JEFFS my-go-tools (encryptfile) ----------------------------------------------

indent[i]="  "
software[i]="encryptfile"
theCommand="encryptfile -v"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
version[i]=$OUTPUT
i=$i+1
printf "."

# JEFFS my-go-tools (md5-hash-file) -------------------------------------------

indent[i]="  "
software[i]="md5-hash-file"
theCommand="md5-hash-file -v"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
version[i]=$OUTPUT
i=$i+1
printf "."

# JEFFS my-go-tools (md5-hash-file) -------------------------------------------

indent[i]="  "
software[i]="sha256-hash-file"
theCommand="sha256-hash-file -v"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
version[i]=$OUTPUT
i=$i+1
printf "."

# JEFFS my-go-tools (markdown-check-links) ------------------------------------

indent[i]="  "
software[i]="markdown-check-links"
theCommand="markdown-check-links -v"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
version[i]=$OUTPUT
i=$i+1
printf "."

# JEFFS my-go-tools (markdown-create-table-of-contents) -----------------------

indent[i]="  "
software[i]="markdown-create-table..."
theCommand="markdown-create-table-of-contents -v"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
version[i]=$OUTPUT
i=$i+1
printf "."

# JEFFS my-go-tools (markdown-delimiter-doer) ---------------------------------

indent[i]="  "
software[i]="markdown-delimiter-doer"
theCommand="markdown-delimiter-doer -v"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
version[i]=$OUTPUT
i=$i+1
printf "."

# KEYBASE ---------------------------------------------------------------------

software[i]="KEYBASE"
theCommand="NOTHING"
command[i]=$theCommand
version[i]="KEYBASE"
i=$i+1
printf "."

# KEYBASE (CLIENT) ------------------------------------------------------------

indent[i]="  "
software[i]="client(ERASE)"
theCommand="keybase version"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"Client"* ]]; then
        version[i]="$line"
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# KEYBASE (SERVICE) -----------------------------------------------------------

indent[i]="  "
software[i]="service(ERASE)"
theCommand="keybase version"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"Service"* ]]; then
        version[i]="$line"
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# KUBECTL ---------------------------------------------------------------------

software[i]="kubectl"
theCommand="kubectl version"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"Major:"* ]]; then
        # Shorting the line a bit to 60 characters"
        SHORTEN=${line:0:60}  
        version[i]="$SHORTEN, etc..."
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# LATEX -----------------------------------------------------------------------

software[i]="latex"
theCommand="latex -version"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"pdfTeX"* ]]; then
        version[i]=$line
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# LATEX tlmgr -----------------------------------------------------------------

indent[i]="  "
software[i]="tlmgr"
theCommand="tlmgr -version"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"revision"* ]]; then
        version[i]="$line"
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# LATEX dvisvgm ----------------------------------------------------------------

indent[i]="  "
software[i]="dvisvgm"
theCommand="dvisvgm --version"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
version[i]="$OUTPUT"
i=$i+1
printf "."

# LATEX ghostscript ------------------------------------------------------------

indent[i]="  "
software[i]="ghostscript"
theCommand="ghostscript -v"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"GPL"* ]]; then
        # Remove leading white space
        NO_LEAD_SPACE="$(echo -e "${line}" | sed -e 's/^[[:space:]]*//')"
        version[i]=$NO_LEAD_SPACE
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# NATS-SERVER -----------------------------------------------------------------

software[i]="nats-server"
theCommand="nats-server -v"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
version[i]="$OUTPUT"
i=$i+1
printf "."

# PACKER ----------------------------------------------------------------------

software[i]="packer"
theCommand="packer version"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"Packer"* ]]; then
        version[i]=$line
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# POSTGRES --------------------------------------------------------------------

software[i]="postgres"
theCommand="postgres -V"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
version[i]="$OUTPUT"
i=$i+1
printf "."

# POSTGRES psql ---------------------------------------------------------------

indent[i]="  "
software[i]="psql"
theCommand="psql -V"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
version[i]="$OUTPUT"
i=$i+1
printf "."

# PROTOC ----------------------------------------------------------------------

software[i]="protoc"
theCommand="protoc --version"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
version[i]="$OUTPUT"
i=$i+1
printf "."

# PYTHON (Redirect stderr) ----------------------------------------------------

software[i]="python"
theCommand="python -V"
command[i]=$theCommand
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"Python "* ]]; then
        version[i]="$line"
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# PYTHON pip ------------------------------------------------------------------

indent[i]="  "
software[i]="pip"
theCommand="pip -V"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"pip "* ]]; then
        version[i]="$line"
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# PYTHON3 ---------------------------------------------------------------------

software[i]="python3"
theCommand="python3 -V"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
version[i]="$OUTPUT"
i=$i+1
printf "."

# PYTHON3 pip3 -----------------------------------------------------------------

indent[i]="  "
software[i]="pip3"
theCommand="pip3 -V"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
version[i]="$OUTPUT"
i=$i+1
printf "."

# PYTHON3 pylint ---------------------------------------------------------------

indent[i]="  "
software[i]="pylint"
theCommand="pylint --version"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"pylint"* ]]; then
        version[i]="$line"
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# REDIS-CLI -------------------------------------------------------------------

software[i]="redis-cli"
theCommand="redis-cli --version"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
version[i]="$OUTPUT"
i=$i+1
printf "."

# VAGRANT ---------------------------------------------------------------------

software[i]="vagrant"
theCommand="vagrant version"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    if [[ $line == *"Installed"* ]]; then
        version[i]="$line"
        break
    fi  
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# VS CODE ---------------------------------------------------------------------

software[i]="vscode"
theCommand="code -v"
command[i]=$theCommand
# Only stdout, not stderr
OUTPUT="$($theCommand 2> /dev/null)"
# LOOK AT LINE BY LINE
while IFS= read -r line
do
    #Right now its on the first line
    version[i]="$line"
    break 
done < <(printf '%s\n' "$OUTPUT")
i=$i+1
printf "."

# -----------------------------------------------------------------------------
# PRINT OUT RESULTS -----------------------------------------------------------
# -----------------------------------------------------------------------------

echo " "
echo " "

for index in ${!software[*]}
do

    sw=${software[$index]}  # Software Name
    cmd=${command[$index]}  # Command (NOT CURRENTLY USED except for addSpace)
    ver=${version[$index]}  # Version
    ind=${indent[$index]}   # Do we add an Indent

    # Add a space
    if [[ $cmd == "addSpace" ]]; then
        echo ""
    fi

    # WHITE - Use the Titles in the version area
    if [[ $ver == *"N/A"* ]] || [[ $ver == *"JEFFS"* ]] || [[ $ver == *"DOCKER"* ]] || [[ $ver == *"KEYBASE"* ]]; then
        tput setaf 7; printf "$ind""   %-28s" "$sw";
        tput setaf 7; echo "$ver"
    # RED - Blank or white space - Software Not Installed
    elif [[ -z "${ver// }" ]]; then
        tput setaf 7; printf "$ind""   %-28s" "$sw";
        tput setaf 1; echo "Software Not Installed"
    # GREEN - Normal Format
    else
        tput setaf 7; printf "$ind""   %-28s" "$sw";
        tput setaf 2; echo "$ver"
    fi

done

echo " "
