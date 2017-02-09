master_file=../master.tex
header_file=../header.txt

rm -f $master_file

cat "$header_file" >> "$master_file"

for dir in ../*/
do
    dir=${dir%*/}
    dir_str=${dir##*/}

    # Add dummy day and month to allow comparison
    date "+%y" -d January-1-$dir_str > /dev/null 2>&1
    valid_dir=$?

    # If we have a valid year, loop over the month directories
    if [ $valid_dir == 0 ]; then

        for month_dir in ../$dir_str/*/
        do
            month_dir=${month_dir%*/}
            month_dir_str=${month_dir##*/}

            # Add dummy day and year to allow comparison
            date "+%B" -d $month_dir_str-1-2000 > /dev/null 2>&1
            valid_month_dir=$?

            # If we have a valid month, update its files
            if [ $valid_month_dir == 0 ]; then
                ./update_month.sh $dir_str $month_dir_str
            fi
        done

        ./update_year.sh $dir_str

        echo "\input{"$dir_str"/"$dir_str"}" >> $master_file

    fi

done

echo "" >> $master_file
echo "\end{document}" >> $master_file
