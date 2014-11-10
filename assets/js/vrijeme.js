/**
 *  Vrijeme
 *	App Support Script
 *  @author :   Patrick Reid - @IAmReliQ
 *  @init   :   Nov. 9, 2014
 */


var Vrij = {};
Vrij.latency = 10; // seconds to wait befor update
Vrij.updateTime = Vrij.latency * 1000;
Vrij.init = function() {
    var update = setInterval(function() {
        Vrij.update()
    }, Vrij.updateTime);
    $('a#history-toggle').on('click', function() {
        $(this).toggleClass('active');
    });
    Vrij.update();
    Vrij.watch();
    console.log('Vrij JS loaded.');
};
Vrij.getCurrent = function() {
    $.get("./?vriq=current", function(data) {
        var canvas = $('#hist ul');
        canvas.html(null);
        $.each($.parseJSON(data), function(reading, values) {
            canvas.html(canvas.html() + "<li> Humidity: " + values.Humidity + "," + " Sea Surface Temperature: " + values.SST + "&deg;c," + " Air Pressure: " + values.AirPressure + "mb," + " Wind Speed: " + values.WindSpeed + "MPH," + " Lapse Rate: " + values.LapseRate + "&deg;c/km</li>")
        });
    });
};
Vrij.getPrediction = function() {
    $.get("./?vriq=prediction", function(data) {
        var canvas = $('#main .asplit .p-s p');
        canvas.html(data);
    });
};
Vrij.watch = function() {
    var form = $('form#new-reading');
    form.submit(function(ev) {
        //ev.preventDefault();
        var data = form.serializeObject();
        alert(JSON.stringify(data));
        $.post("./", function(data) {
            
        });
    });
};
Vrij.update = function() {
    console.log('Vrij is updating...');
    Vrij.getCurrent();
    console.log('...update complete.');
}


$(function() {
    Vrij.init();
});



/** 
 *	JQuery serialize object
 *	Utility function
 * 	from: http://css-tricks.com/snippets/jquery/serialize-form-to-json/
 */
$.fn.serializeObject = function() {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name]) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};