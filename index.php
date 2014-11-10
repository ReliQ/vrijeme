<?php require_once('app/header.php'); ?>

<section class="asplit">
	<div class="p-s">
		<h3>Current Prediction</h3>
		<p> <!-- Prediction goes here... -->
		<?php 
			$app->test(); 
		?>
		</p>
	</div>
	<div class="i-s">
		<h3>New Reading</h3>
		<p class="instructions">To record a new reading please provide the details requested below in the specified units.</p>
		<aside class="errors"></aside>
		<form id="new-reading" method="post">
			<fieldset class="fields">
				<div class="field">
					<label for="Humidity">Humidity (%):</label>
					<label class="maxmin">(max: 1.0, min: 0.0)</label>
					<input id="humidity" name="Humidity" type="number" min="0.0" max="1.0" step="any" required />
				</div>
				<div class="field">
					<label for="sst">Sea Surface Temperature (&deg;c):</label>
					<label class="maxmin">(max: 120, min: -20)</label>
					<input id="sst" name="SST" type="number" min="-20" max="120" step="any" required />
				</div>
				<div class="field">
					<label for="air_pressure">Atmospheric Pressure (mbar):</label>
					<label class="maxmin">(max: 1100, min: 800)</label>
					<input id="air_pressure" name="AirPressure" type="number" min="800" max="1100" step="any" required />
				</div>
				<div class="field">
					<label for="wind_speed">Wind Speed (MPH):</label>
					<label class="maxmin">(max: 500, min: 0)</label>
					<input id="wind_speed" name="WindSpeed" type="number" min="0" max="500" step="any" required />
				</div>
				<div class="field">
					<label for="lapse_rate">Lapse Rate (&deg;c/km):</label>
					<label class="maxmin">(max: 10, min: 0)</label>
					<input id="lapse_rate" name="LapseRate" type="number" min="0" max="10" step="any" required />
				</div>
			</fieldset>
			<fieldset class="actions">
				<input type="submit" value="Save" />
				<input type="reset" value="Clear" />
			</fieldset>
		</form>
	</div>
</section>
<section class="tail">
	<a id="history-toggle" class="action-btn" href="javascript:void(0)">Toggle Data History</a>
	<div id="history-area" class="data-area">
		<h3>Latest Readings</h3>
		<div id="hist"><ul></ul></div>
	</div>
	<aside id="tail-logo"><img src="./assets/img/logo-sm.png" alt="." /></aside>
</section>

<?php require_once('app/footer.php'); ?>