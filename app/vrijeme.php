<?php
/**
 *	Vrijeme - Weather Prediction in Prolog!
 *	The Application
 *	@author Patrick Reid, Brian Findlay, Ashani Kentish, Rajiv Manderson
 */
# error_reporting(E_ERROR);


class Vrijeme {

	private $wam;

	# Constructor
	function __construct() {
		
	}

	/**
	 * Format command for prolog counterpart.
	 * @return Formatted string to invoke command via prolog.
	 */
	public static function cmd($cmd="run") 
	{
		return "nice -n15 swipl -f core/interface.pl -g \"".$cmd.",halt\"";
	}

	/**
	 * Get system information.
	 * @return System information.
	 */
	public function info()
	{
		return "Vrijeme AI v1.0";
	}

	// Test
	public function test() 
	{
		// return system( Vrijeme::cmd("saveReading([0.23, 51, 860, 86, 2])") );
		return print_r(exec( Vrijeme::cmd("memFile") ));
	}

	# Destructor
	function __destruct(){}	
}

# Init
$app = new Vrijeme();