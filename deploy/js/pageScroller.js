
function smoothScroll(){
	var location = window.location.href.match(/^[^#]*/)[0] + '#';
	var $links = $('#main-nav ul li a');
	var links = document.links;	
	//alert(links.href.indexOf(location));
	
	var timer = null;
	
	$links.each(function(index){
		var thisLink = this;		
		
		$(this).click(function(){
			clearInterval(timer);
			
			var thisAnchor = thisLink.href.substring(location.length);
			
			var $myAnchor = $("a[name="+thisAnchor+"]");
			var elementPos = $myAnchor[0].offsetTop;
			timer = setInterval(animate, 100, elementPos);
			
			return false;
		});
	});	
	
	function animate(num){
		
		var winPos = window.pageYOffset;
		var dist = (num - winPos) / 4;		
		
		if(dist	<= 1 && dist >= -1){
			clearInterval(timer);
			return;
		} else {
			window.scrollBy(0, dist);	
		}		
	}
}
