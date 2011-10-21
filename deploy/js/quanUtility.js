function findYPos(obj)
{
	var curtop = 0;
	if (obj.offsetParent)
	{
		while (obj.offsetParent)
		{
			curtop += obj.offsetTop
			obj = obj.offsetParent;
		}
		
	} else if (obj.y){
		curtop += obj.y;
	}
	
	return curtop;
}

function findXPos(obj)
{
	var curleft = 0;
	if (obj.offsetParent)
	{
		while (obj.offsetParent)
		{
		curleft += obj.offsetLeft
		obj = obj.offsetParent;
		}
		
	} else if (obj.x){
		curleft += obj.x;
	}
	
	return curleft;
}
