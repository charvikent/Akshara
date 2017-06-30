// Pagination

function paginationTable(noOfPages){
	$("div.holder").jPages({
        containerID: "itemContainer",
        perPage: noOfPages,
        keyBrowse: true,
        scrollBrowse: false,
        animation: "bounceInUp",
        callback: function (pages,
items) {
            $("#legend2").html("Page " + pages.current + " of " + pages.count);
            $("#legend1").html("Elements "+items.range.start + " - " + items.range.end + " of " + items.count);
        }
    });
}

//cartPagination

function paginationTableCart(noOfPages){
	$("div.holder").jPages({
        containerID: "cartTableBody",
        perPage: noOfPages,
        keyBrowse: true,
        scrollBrowse: false,
        animation: "bounceInUp",
        callback: function (pages,
items) {
            $("#legend2").html("Page " + pages.current + " of " + pages.count);
            $("#legend1").html("Elements "+items.range.start + " - " + items.range.end + " of " + items.count);
        }
    });
}

// Chosen DropDown

function chosenDropDown(){
	  var config = {
		      '.some-select'           : {},
		      '.some-select-theme'     : {},
		      '.some-select-state'  : {allow_single_deselect:true}
		    }
		    for (var selector in config) {
		      $(selector).chosen(config[selector]);
		    }
	  }

