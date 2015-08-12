colors = ["#fc4267", "#ff6600", "#cc916a", "#ffde58", "#77c261", "#f14700", "#ffffff"]

fonts = [16, 22, 26]
 
$('#marquee').marquee()

pageWidth = $("#video-wrap").width()

 
$('button').click () ->
	
	d = $('#marquee .wrap:eq(0) span').filter () ->
			elementWidth = $(this).width()
			elementLeft = $(this).position().left
			
			if (pageWidth - (elementWidth + elementLeft) < 0) 
			    return false;
			else 
			    return true;
	console.log d	

	$('#marquee').marquee('pause')
	
	