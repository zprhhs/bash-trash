alias mv="mv -i" 
alias del=mv2trash
alias hf=restore2path
mv2trash() {
    if [[ ! -d $HOME/.Trash ]]; then
        mkdir $HOME/.Trash
    fi
    delete_time=$(date +'%m-%d_%H-%M-%S')
    for arg in "$@"; do
        for file_path in `realpath $arg`; do
            if [[ "$file_path" == "$HOME/.Trash" ]]; then
                echo "Can't Put .Trash to Itself!!"
                continue
            fi
            file_name=${file_path##*/}
            if [[ ! -d $file_path && ! -f $file_path ]]; then
                echo "No Such file!"
                continue
            fi
            mkdir $HOME/.Trash/${file_name}_${delete_time}
            echo "Put $file_path to $HOME/.Trash"
            mv $file_path $HOME/.Trash/${file_name}_$delete_time/
            echo "${file_path}"    > $HOME/.Trash/${file_name}_${delete_time}/${file_name}.bash_trash_log
            echo "Time: $(date)"  >> $HOME/.Trash/${file_name}_${delete_time}/${file_name}.bash_trash_log
            echo "Command: rm $*" >> $HOME/.Trash/${file_name}_${delete_time}/${file_name}.bash_trash_log
        done
    done
}
restore2path() {
    if [[ "$PWD" != "$HOME/.Trash" ]]; then 
        cd $HOME/.Trash
        return
    fi
    for arg in "$@"; do
        for command_file in `realpath $arg`; do
            if [[ ! -d $command_file ]]; then
                echo "No such file to restore"
            fi
            file_path=""
            now_path=""
            for file in `ls $command_file`; do
                if [[ -f $command_file/$file && "${file##*.}" == "bash_trash_log" ]]; then
                    for line in `cat $command_file/$file`; do
                        file_path=$line
                        break
                    done
                else
                    now_path=$command_file/$file
                fi
            done
            prefix_path=${file_path%/*}
            if [[ ! -d $prefix_path ]]; then
                mkdir -p $prefix_path && mv $now_path $file_path && rm $command_file -rf
                echo "Restore file $now_path to $file_path"
                continue
            fi
            echo "Restore file $now_path to $file_path"
            mv $now_path $file_path && rm $command_file -rf
        done
    done
}
