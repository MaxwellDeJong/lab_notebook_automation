weekendOverride=$1

foldername=$(date '+%y-%B-%d')
year=$(date '+%Y')
month=$(date '+%B')
dayofweek=$(date '+%u')

filename=$foldername.tex
secstr="\section{"$foldername"}"
labelstr="\label{sec:"$foldername"}"

makefile=0

# New directory and file to be completed
newdir=../$year/$month/$foldername/
newfile=../$year/$month/$foldername/$filename

# Only make file if today is weekday or manual override
if [ "$dayofweek" != 6 ] && [ "$dayofweek" != 7 ]; then
    makefile=1
elif [ "weekendOverride" == 1]; then
    makefile=1
else
    makefile=0
fi

# Create directory and file if requested
if [ "$makefile" == 1 ]; then
    mkdir -p $newdir

    # Check if file exists before making new file
    if [ ! -f $newfile ]; then
        touch $newfile
        printf $secstr"\n"$labelstr > $newfile
    fi
fi
