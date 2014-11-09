<?php
/**
 *	Vrijeme - Weather Prediction in Prolog!
 *	The Application
 *	@author Patrick Reid, Brian Findlay, Ashani Kentish, Rajiv Manderson
 */

class Vrijeme {

	private $cmd = "nice -n15 swipl -f core/main.pl -g run,halt";

	function __construct()
	{
		
	}

	// App info
	public static function info()
	{
		return "Vrijeme AI v1.0";
	}

	// Run app
	public function run($cmd) 
	{
		//return ;
		return exec($this->cmd);
	}


	function __destruct(){}	
}

# Init
$app = new Vrijeme();