year=$1
month=$2
prefix=../$1/$2

if [ $# -eq 0 ] || [ $# -eq 1 ]; then
    echo "Two arguments needed."
    exit 1
fi

update=$(./month_update_needed.sh $prefix)

dates_file=$prefix/dates.txt
month_file=$prefix/$month.tex
month_file_exists=0

if [ -f $month_file ]; then
    month_file_exists=1
fi

if [ $update == 1 ] || [ $month_file_exists == 0 ]; then

    rm -f $month_file

    echo "\chapter{"$month"}" >> $month_file
    echo "" >> $month_file

    while read p; do
        echo "\input{"$1"/"$2"/"$p"/"$p"}" >> $month_file
        echo "\FloatBarrier" >> $month_file
        echo "\newpage" >> $month_file
    done <$dates_file
fi
