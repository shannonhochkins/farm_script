#!/bin/bash
scene=myscene x=1920    y=1080

while getopts scene:base:s:e:x:y: opt; do
  case $opt in
  scene)
  	echo "scene was triggered"
      scene=$OPTARG
      ;;
  base)
      base=$OPTARG
      ;;
  s)
      d=$OPTARG
      ;;
  e)
      r=$OPTARG
      ;;
  x)
      c=$OPTARG
      ;;
  y)
      y=$OPTARG
      ;;
  esac
done

shift $((OPTIND - 1))





while getopts ":a" opt; do
  case $opt in
    a)
      echo "-a was triggered!" >&2
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done




echo Hello $scene world.
exit;
Render -preFrame "exec(\"sh \'/Volumes/raid/farm_script/preFrame.sh\'\")" -mr:v 0 -mr:rt 8 -mr:mem 7000 -b 1 -rl 1 -s $s -e $e -skipExistingFrames 1 -x $x -y $y -proj $base -rd $base $theScene
