#!/bin/sh

# THE BEER-WARE LICENSE (Revision 42.1):
#
# The author wrote this file. As long as you retain this notice you can do
# whatever you want with this stuff. If we meet some day, and you think this
# stuff is worth it, you can buy me a beer in return.
#
#
# Author:		Johannes Markert <me@jmark.de>
# Version:		1.0.0
#
# Description:
#
#	Load environment variables into current session from a given text file.
#	
#	In order to create an environment snapshot in the first place run following
#	command like so:
#	
#	 $ set | grep <PREFIX> > <snapshotfile>
#	
#	You have to source this script in order to register the variables within
#	the current session.
#	
#	 $ source load_vars.sh <snapshotfile>
#
# Changelog:
#
#	* 2016-09-06:
#		- added 'eval' so that the values get interpolated
#		- prefixed variable names with '_' so namespace does not get polluted
#		- 'unset' variables at the end
#	* 2016-09-02:
#		- Initial commit.

OLDIFS=$IFS
IFS=$(echo -en "\n\b")

for _v in $(cat "$1")
do
	_tmp=$(eval echo $_v)
	echo Loading $_tmp
	export $_tmp
done

unset _tmp
unset _v

IFS=$OLDIFS
