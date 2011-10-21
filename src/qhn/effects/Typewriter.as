package qhn.effects
{
	import flash.events.*;
	import flash.text.*;
	import flash.utils.*;

	public class Typewriter {
						
		private var letterCount:uint = 1;
		private var charToAdd:uint = 2;
		//Set this higher to increase the alpha typing effect
		
		private var messageText : TextField;		
		
		private var myText : String;
		
		private var timer : Timer = new Timer(20, 1);
		private var options : Object;
				
		public function Typewriter(mText : TextField, delay : uint, obj : Object)
		{
			myText = mText.text;
			
			messageText = mText;						
			messageText.autoSize = "left";
			messageText.selectable = false;			
			messageText.text = "";
			
			timer.delay = delay;
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			
			options = obj;
			if (options.delay != null)
			{
				var myDelay : int = options.delay * 1000;
				setTimeout(start, myDelay);
			}
			else
			{
				start();
			}
		}
		
		public function start() : void
		{
			timer.start();
		}
		
		private function onTimer(event:TimerEvent) : void
		{			
			timer.reset();
			timer.stop();
			
			// Type in the text n characters at a time
			if (letterCount < myText.length)
			{
				messageText.text = myText.substring(0, letterCount);				
				letterCount = letterCount + charToAdd;
				timer.start();

			} else {				
				messageText.text = myText;
				
				if (options.onComplete != null) options.onComplete.apply();
				
				timer.removeEventListener(TimerEvent.TIMER, onTimer);
			}						
		}

		public static function forward(target : TextField, delay : int, obj : Object) : Typewriter 
		{
			return new Typewriter(target, delay, obj);
		}
		
		public static function backward(target : TextField, delay : int, obj : Object) : Typewriter
		{
			obj.runBackwards = true;			
			return new Typewriter(target, delay, obj);
		}
	}
}