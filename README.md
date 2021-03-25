# bash-trash

**A Recyclebin For BASH**

## 1. Introduction

- `del $file`: Use `mv $file $HOME/.Trash` instead of `rm`.
`del` put `$file` to `$HOME/.Trash`, and make a dir with name of `$file_deletetime`. There are two file in `$file_time`: `$file` & `${file}.bash_trash_log`. `${file}.bash_trash_log` has some infomation of $file.

eg: 

```bash
~$ del Data\
Put /home/zprhhs/Data to /home/zprhhs/.Trash
~$ ls .Trash/Data_01-29_10-39-23/
Data  Data.bash_trash_log
~$ cat .Trash/Data_01-29_10-39-23/Data.bash_trash_log
/home/zprhhs/Data
Time: Fri Jan 29 10:39:23 CST 2021
Command: del Data/
```

- `hf`: Go to `$HOME/.Trash`
- `hf $file_deletetime`: Restore `$file_deletetime/$file`, and remove `$file_deletetime`. If you are not in `$HOME/.Trash`, this commmad will work like `hf`.

`hf $file_deletetime` read target path from `$file_deletetime/${file}.bash_trash_log`, and move `$file_deletetime/$file` to it, when move finished, `hf` will delete `$file_deletetime`

eg:

```bash
~$ hf
~/.Trash$ hf Data_01-29_10-39-23/
Restore file /home/zprhhs/.Trash/Data_01-29_10-39-23/Data to /home/zprhhs/Data
~/.Trash$ ls ~
Data
```

## 2. install 

Add to BASHRC

## 3. attention

This code is use for author, inevitable have bugs, The author is not responsible for all problems. Data is priceless, please use with caution.
