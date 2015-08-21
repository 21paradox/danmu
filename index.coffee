colors = ["#fc4267", "#ff6600", "#cc916a", "#ffde58", "#77c261", "#f14700", "#ffffff"]

fonts = [16, 22, 26]

# $('button').click () ->
	
# 	d = $('#marquee .wrap:eq(0) span').filter () ->
# 			elementWidth = $(this).width()
# 			elementLeft = $(this).position().left
			
# 			if (pageWidth - (elementWidth + elementLeft) < 0) 
# 			    return false;
# 			else 
# 			    return true;
# 	console.log d	

# 	$('#marquee').marquee('pause')

	
danmu = (data, config, render) ->
 
	rows = 4
	width = '480px'
	outNode = document.getElementById('marquee');
 
 	# use user defined render if possible
	if not render? 
		render = (data) ->
			template = "<div class='damu-wrap' 
							style='width: 0px; 
									position: absolute; 
									overflow: hidden; 
									padding-left: #{width};
									margin-bottom: 20px;'>"
		
			for i in [0 ... rows]
				
				template += "<div class='danmu-row' 
								style='white-space: nowrap; 
										float: left; 
										padding-right: #{width};
										line-height: 28px;'>"
		
				for item, index in data when index % rows is i
					template += "<span style='margin-right: 20px;'>#{item}</span>"
				
				template += "</div>"
				
			template += "</div>"	
			return template
			
	# $(outNode).append(render(data))
	appenDom = (outNode, data) ->
		damuNode = document.createElement('div')
		damuNode.innerHTML = render(data)
		damuNode1 = damuNode.firstChild
		outNode.appendChild(damuNode1)
		return damuNode1
	
	curIndex = 0
		
	# sub array from global data array
	# http://stackoverflow.com/questions/17483149/how-to-access-array-in-circular-manner-in-javascript
	getsubArr = () ->
		subarr = [data[curIndex]]
		for j in [1...20]
			subarr.push data[ (curIndex + j) % data.length ]
		# reset currentIndex
		curIndex = (curIndex + j) % data.length + 1
		return subarr
		
	animationRequest = null;	
		
	run = (danmuNode) ->
		# offsetWidth is the same as width
		offsetWidth = danmuNode.offsetWidth
		scrollWidth = danmuNode.scrollWidth
		newScene = false
		# define animate loop
		animateLoop = () ->
			# if reached right
			if danmuNode.scrollLeft + 2 * offsetWidth >= danmuNode.scrollWidth and not newScene
				applyScene()
				newScene = true
			
			if danmuNode.scrollLeft + offsetWidth >= danmuNode.scrollWidth 
				danmuNode.parentNode.removeChild(danmuNode);
				return
			else
				danmuNode.scrollLeft += 1
				animationRequest = requestAnimationFrame(animateLoop)
		
		# run animate
		animateLoop()
		
	# get sub array , then append dom, then do animation
	applyScene = () ->
		d = getsubArr()
		danmuNode = appenDom(outNode, d)
		run(danmuNode)
		
	applyScene()
	
	
	document.getElementById('test123').onclick = () ->
		cancelAnimationFrame(animationRequest)
		
	document.getElementById('test1234').onclick = () ->
		cancelAnimationFrame(animationRequest)
	
 
#run 
data = [];

for index in [0 ... 20]
	if index is 0
		data.push 'start name'
	else
		data.push Random.chineseName(10)

console.log data



	
danmu(data, {
	
	
})
