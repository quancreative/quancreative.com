package qhn.effects 
{
	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author qngo
	 */
	public class Sequence 
	{
		private var array : Array;
		private var index : int = 0;
		private var timer : Timer = new Timer(150, 1);
		private var callFunction : Function;
		private var options : Object;
		
		public function Sequence(arr : Array, func : Function, obj : Object = null) : void
		{
			array = arr;
			
			callFunction = func;

			options = obj ? obj : null;
						
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
		}

		private function onTimer(event : TimerEvent) : void 
		{
			timer.reset();
			timer.stop();
			
			if (index < array.length)
			{
				var myDisplay : Object = array[index];
				
				callFunction.call(null, myDisplay);	
				
				index ++;
				
				timer.start();	
			}
			else
			{
				timer.removeEventListener(TimerEvent.TIMER, onTimer);
				timer = null;
			}
		}
	}
}
