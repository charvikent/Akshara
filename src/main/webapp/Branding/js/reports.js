/**
 * 
 * @author anil
 *
 */

/********** Reports Js**************/
function test(divId) {
		var displayDiv = document.getElementById(divId);
		$(displayDiv).fadeToggle();
	}
/********** Reports Purpose**************/
function rowShowHide(rowId) {
	var currStyleVal = document.getElementById(rowId).style.display;
	var spanid = rowId+'-span'; 
	if(currStyleVal == 'none'){
		document.getElementById(rowId).style.display = "";
		$('#'+spanid).removeClass("expand");
		$('#'+spanid).addClass("collapse");
		
	}else {
		 document.getElementById(rowId).style.display = "none";
		 $('#'+spanid).removeClass("collapse");
			$('#'+spanid).addClass("expand");
		 
	}
}