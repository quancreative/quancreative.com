package com.quancreative.main.views
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;

	/**
	 * @author qngo
	 */
	public class PreloaderClip extends MovieClip 
	{
		private var progressMC : MovieClip;
		private var progressTF : TextField;
		
		private var targetFrame : Number;
		
		public function PreloaderClip()
		{
			super();
		}

		public function animateIn() : void
		{
			addEventListener("ANIMATE_IN", onAnimateIn);
			gotoAndPlay("IN");
		}
		
		public function updateProgress(num : Number) : void
		{
			targetFrame = num;			
		}
		
		// loading is complete, so make sure the preloader progress clip plays away.
		public function setComplete() : void
		{
			progressMC.play();
		}

		private function onAnimateIn(event : Event) : void
		{	
			progressTF = TextField(getChildByName("progress_txt"));
					
			progressMC = MovieClip(getChildByName("progress_mc"));
			progressMC.stop();
			progressMC.addEventListener(Event.COMPLETE, onProgressBarComplete);
			progressMC.addEventListener(Event.ENTER_FRAME, onProgressEnterFrame);
			
			dispatchEvent(new Event(Event.INIT));
		}
		
		private function onProgressBarComplete(event : Event) : void
		{
			progressMC.removeEventListener(Event.COMPLETE, onProgressBarComplete);
			progressMC.removeEventListener(Event.ENTER_FRAME, onProgressEnterFrame);
			
			//	if(pct_mc.tf != null) pct_mc.tf.text = "";	
			animateOut();
		}
		
		private function animateOut() : void
		{
			addEventListener("ANIMATE_OUT", onAnimateOut);
			
			gotoAndPlay("OUT");
		}
		
		private function onAnimateOut(event : Event) : void
		{
			removeEventListener("ANIMATE_IN", onAnimateIn);
			removeEventListener("ANIMATE_OUT", onAnimateOut);
			
			dispatchEvent(new Event(Event.COMPLETE));
		}

		private function onProgressEnterFrame(event : Event) : void
		{
			(targetFrame > progressMC.currentFrame) ? progressMC.play() : progressMC.stop();
			
			var totalPct:Number = Math.round((progressMC.currentFrame / progressMC.totalFrames) * 100);
			
			progressTF.text = totalPct.toString() + "%";
		}
	}
}
