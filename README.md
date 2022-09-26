# vimrc
my vimrc

## Enable system clipboard
```
sudo apt install xclip
```

## Generate compile_commands.json

```
# Two ways to generate compile_commands.json
# 1.   In project root.
mkdir -p build && cd build && cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 ../${SRC_FOLDER}
# 2.   In makefile folder
bear make
#link compile_commands.json to project root
ln -s compile_commands.json {PROJECT_ROOT}/.

```

## TODO
