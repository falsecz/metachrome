$(document).ready(function() {
	// nacist komentare pres jSon - development/comments.json
	$.ajax({
        type: "GET",
        url: "development/comments.json",
        data: {},	
        cache: false,  
        dataType: "json",
        success: function(data) {
            // pokud jde o text, tak to tady uz dekodovat nemusim, udela se to samo
        	//alert("Response ok: ");  
        	
        	//var items = data[0];
        	
        	$.each(data, function(index, item) 
			{
	            // alert("type: " + item["type"] + " , content: " + item["content"] + " , uid:" + item["uid"]);
        		
        		$("#comments_list").append("<tr><td>"+ item["date"] +"</td><td>"+ item["content"] +"</td><td>"+ item["nick"] +"</td></tr>");
	        });
        },
        error: function() {
        	alert("Error.");
        }
    });
});