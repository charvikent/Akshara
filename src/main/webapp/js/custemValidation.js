 $('.nospecialCharacter').bind('keypress', function(e) {
		    console.log( e.which );
		        var k = e.which;
		        var ok = k >= 65 && k <= 90 || // A-Z
		            k >= 97 && k <= 122 || // a-z
		            k >= 48 && k <= 57; // 0-9
		        
		        if (!ok){
		            e.preventDefault();
		        }
		});
 
 
 $(".numericOnly").keypress(function (e) {
	    if (String.fromCharCode(e.keyCode).match(/[^0-9]/g)) return false;
	});