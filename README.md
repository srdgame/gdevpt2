## gdev
Project for gamedev. All object classes will be put in the root dir, hopefully it won't get too crowded.

- images in data/
- maps in maps/

useful stuff to have in your ~/.bash_profile or equiv.
```
## Create love binary by doing `clv binary_name`
clv () {
   zip -9 -r $1.love .
}

## Run love binary by typing `lv binary_name`
lv () {
  love $1.love
}

## Compile and run by typing `clvl binary_name`
clvl () {
  clv $1 && lv $1
}

## Delete love binaries
rml () {
  rm *.love
}
```
