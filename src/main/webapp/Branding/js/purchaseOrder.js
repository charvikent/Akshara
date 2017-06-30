$( document ).ready(function() {  

        var scntDiv = $('#tableGenre');
        var i = $('#tableGenre tr').size() + 1;


        $('#addLine').on('click', function() {
                $('<tr><td>'+(i-1)+'</td><td><select name="genre[]" id="genre'+(i-1)+'"></select></td><td><a href="#" id="delLine" class="btn btn-xs red" ><i class="icon-remove"></i></a></td></tr>').appendTo(scntDiv);
                    alert(i);

                    // If element id "genre1" exist

                    if($("#genre"+(i-1)).length != 0) {
                        //alert("#genre"+(i-1)+" exist");

                        // i populate select box options with mysql data

                        $.ajax({    
                            type: "POST",
                            url : "productsForClient.htm",            
                            dataType: "html",   //expect html to be returned                
                            success: function(response){  
                            	$.each(response, function(k, tests) {
                            		 $("#genre"+(i-1)).append(tests.id);
                            	});
                              /*var java=  $("#genre"+(i-1)).html(response).val(); */
                               /* alert(java);
                                alert(response);*/
                            }

                        });

                    }
                i++;
                return false;
        }); 

});