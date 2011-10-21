package com.utils{
	
	public class Caculate{
		
		public static function column(count:Number, num:Number):Boolean
		{
			var myBoo:Boolean = false;
					
			if ((count + 1) % num == 0)
			{
				myBoo = true;
			}
			
			
			/*for (var i:Number = 0; i < totalItem; i++)
			{
				if((i + 1) % num == 0)
				{
					trace('start a new row');
				}
			}*/
			
			return myBoo;
		}
	}
}