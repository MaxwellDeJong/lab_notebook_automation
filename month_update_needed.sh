prefix=$1
output_file=$prefix/dates.txt
update=0
file_exists=1

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
    exit 1
fi

if [ ! -f $output_file ]; then
    update=1
    file_exists=0
fi

for dir in $prefix/*/
do
    dir=${dir%*/}
    dir_str=${dir##*/}

    date "+%y-%B-%d" -d $dir_str > /dev/null 2>&1
    valid_dir=$?

    if [ $valid_dir == 0 ]; then

        if [ $file_exists == 1 ]; then
            dir_exists=$(fgrep -c $dir_str $output_file)

            if [ $dir_exists != 1 ]; then
                update=1
                echo $dir_str >> $output_file
            fi
        else
            echo $dir_str >> $output_file
        fi

    fi

done

echo $update
