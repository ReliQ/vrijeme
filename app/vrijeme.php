<?php
/**
 *	Vrijeme - Weather Prediction in Prolog!
 *	Application Interface
 *	@author Patrick Reid
 */
error_reporting(E_ERROR);


/**
 *	Application class.
 */
class Vrijeme {

	public $response;

	# Constructor
	function __construct() {
		$this->init();
	}

	private function init()
	{
		$this->response = new VrijResponse();
		
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
			$this->saveReading($_POST);
		}

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
		$memfile = exec( Vrijeme::cmd("memFile") );
		$reading = "[".$reading['Humidity'].",".$reading['SST'].",".
			$reading['AirPressure'].",".$reading['WindSpeed'].",".$reading['LapseRate']."]\n";
		$this->response->success = (exec( Vrijeme::cmd("iSaveReading(".$reading.")") ) 
			|| file_put_contents($memfile, $reading, FILE_APPEND | LOCK_EX));
		if ($this->response->success)
		{
			$this->response->message = "Reading was successfully added!";
			$this->response->fMessage = "<span class=\"success\">".$this->response->message."</span>";
		} else {
			$this->response->fMessage = "<span class=\"error\">".$this->response->message."</span>";
		}
		return json_encode($this->response);
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
	public $success 	= false;
	public $message 	= "Could not add reading.";
	public $fMessage 	= null;
}

# Init
$app = new Vrijeme();