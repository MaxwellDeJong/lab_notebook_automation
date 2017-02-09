year=$1

if [ $# -eq 0 ]; then
    echo "Argument needed."
    exit 1
fi

update=$(./year_update_needed.sh $year)

months_file=../$year/months.txt
year_file=../$year/$year.tex
year_file_exists=0

if [ -f $year_file ]; then
    year_file_exists=1
fi

if [ $update == 1 ] || [ $year_file_exists == 0 ]; then

    rm -f $year_file

    echo "\part{"$year"}" >> $year_file
    echo "" >> $year_file

    while read p; do
        echo "\input{"$1"/"$p"/"$p"}" >> $year_file
    done <$months_file
fi
