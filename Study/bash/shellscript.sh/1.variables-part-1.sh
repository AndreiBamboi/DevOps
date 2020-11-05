#!/bin/sh

#Good variable
var1=1
echo $var1
#Bad variable
#var2 = 2
#Use with external program
expr $var1 + 1

#Using read and intagrate variable into a different expresion
echo "Numele tau ?"
read -p "Scrie numele tau: " nume
echo "salut $nume"
echo "sau poate ${nume}_user"