/**
 *  Vrijeme
 *	App Support Script
 *  @author :   Patrick Reid - @IAmReliQ
 *  @init   :   Nov. 9, 2014
 */


var Vrij = {};
Vrij.init = function() {
    $('a#history-toggle').on('click', function() {
    	$(this).toggleClass('active');
    });
    console.log('Vrij loaded.');
};


$(function() {
    Vrij.init();
});