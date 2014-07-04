$(document).ready(function(){
	$(document).on('click', '#test_link', function(){
		$("#loding").show();
		$.ajax({ 
      url: "/home/links_check",
      dataType: "html",
      data: {"link": $("#link").val()},
      success: function(data){
      	$("#loding").hide();
        $("#links_show").html(data); 
      }
    });
	});	
});