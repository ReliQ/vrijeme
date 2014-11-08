<?php
/**
 *	Vrijeme
 */


function run($cmd) 
{
	$cmd = "nice -n15 swipl -f core/main.pl -g ".$cmd.",halt";
	return exec($cmd);
}