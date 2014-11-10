<?php
/**
 *	Vrijeme - Weather Prediction in Prolog!
 *	The Application
 *	@author Patrick Reid, Brian Findlay, Ashani Kentish, Rajiv Manderson
 */
# error_reporting(E_ERROR);

/**
 *	Application class.
 */
class Vrijeme {

	private $response;

	# Constructor
	function __construct() {
		$this->init();
	}

	private function init()
	{
		if (isset($_GET['vriq']))
		{
			$do = $_GET['vriq'];
			switch($do) 
			{
				case "current":
					die(json_encode($this->currentData()));
				case "info":
					die($this->sysInfo());
				case "prediction":
					die($this->prediction());
				default:
					die("Hehe!");
			}
		} elseif (isset($_POST['Humidity'])) 
		{
			// $reading 				= array();
			// $reading['Humidity'] 	= $_POST['humidity'];
			// $reading['SST']	 		= $_POST['sst'];
			// $reading['AirPressure'] = $_POST['air-pressure'];
			// $reading['WindSpeed'] 	= $_POST['wind-speed'];
			// $reading['LapseRate']	= $_POST['lapse-rate'];

			return $this->saveReading($_POST);
		}

		$response = new VrijResponse();

	}

	/**
	 * Format command for prolog counterpart.
	 * @return Formatted string to invoke command via prolog.
	 */
	private function cmd($cmd="run") 
	{
		return "nice -n15 swipl -f core/interface.pl -g \"".$cmd.",halt\"";
	}

	/**
	 * Get current data/readings.
	 * @return An array of readings.
	 */
	public function currentData() 
	{
		$current = substr( exec( Vrijeme::cmd("current") ), 1, -1);
		$current = array_filter(split(']', str_replace("[", "", $current)));
		
		foreach ($current as $key => $reading) 
		{
			$rea 		= $current[$key];
			$reading 	= array();
			if (substr($rea, 0, 1) == ",")
			{
				$rea = substr($rea, 1);
			}
			$rea = split(',', $rea);
			
			$reading['Humidity'] 	= $rea[0];
			$reading['SST']	 		= $rea[1];
			$reading['AirPressure'] = $rea[2];
			$reading['WindSpeed'] 	= $rea[3];
			$reading['LapseRate']	= $rea[4];

			$current[$key] = $reading;
		}

		return $current;
	}

	/**
	 * Get prediction based on.
	 * @return Get a prediction.
	 */
	public function saveReading($reading)
	{
		return system( Vrijeme::cmd("iSaveReading([".$reading['Humidity'].",".$reading['SST'].",".
			$reading['AirPressure'].",".$reading['WindSpeed'].",".$reading['LapseRate']."])") );
	}

	/**
	 * Get prediction based on.
	 * @return Get a prediction.
	 */
	public function prediction() 
	{
		return system( Vrijeme::cmd("predict") );
	}

	// Test
	public function test() 
	{
		$ire = array(); 
		$ire['Humidity'] 	= 0.7;
		$ire['SST']	 		= 40;
		$ire['AirPressure'] = 1010;
		$ire['WindSpeed'] 	= 95;
		$ire['LapseRate']	= 2;
		return $this->saveReading($ire);
	}

	/**
	 * Get system information.
	 * @return System information.
	 */
	public static function sysInfo()
	{
		return exec( Vrijeme::cmd("sysInfo") );
	}

}


/**
 *	App response class.
 */
class VrijResponse {
	public $success;
	public $message;
}

# Init
$app = new Vrijeme();