<?php


function run() 
{
	$cmd = "nice -n15 swipl -f core/main.pl -g run,halt";
	echo exec( $cmd );
}