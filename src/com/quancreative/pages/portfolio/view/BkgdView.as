package com.quancreative.pages.portfolio.view 
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;

	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;

	/**
	 * @author qngo
	 */
	public class BkgdView extends Sprite
	{
		private var loader : Loader = new Loader();
		
		public function BkgdView(url : String = null)
		{
			if (url)load(url);
		}
		
		public function load(url : String) : void
		{
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete);
			loader.load(new URLRequest(url));
			loader.alpha = .4;
			
			addChild(loader);
			
			if (stage)
				onAddedToStage();
			else
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onLoaderComplete(event : Event) : void 
		{
			loader.x = -(loader.width/2) + 600;
			loader.y = -(loader.height/2) + 300;
		}

		private function onAddedToStage(event : Event = null) : void 
		{
			addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}

		private function onEnterFrameHandler(event : Event) : void 
		{
			initSlider(stage.mouseX, stage.mouseY);
		}
		
		private function initSlider(mouseValX : Number, mouseValY : Number) : void 
		{
			var initialWidth : Number = stage.stageWidth;
			var stageHeight : Number = stage.stageHeight;
			
			// return (0 - 1)
			var mousePercentX : Number = mouseValX / initialWidth;
			var mousePercentY : Number = (mouseValY / stageHeight);
			
			// rotationY -40 to 40
			var availMovementRotationY : Number = 40;
			var dy : Number = (availMovementRotationY * mousePercentX);
			
			// rotationX 
			var availMovementRotationX : Number = 30;
			var dx : Number = availMovementRotationX * mousePercentY;			 
			
			TweenLite.to(this, 2, {rotationX : (-15 + dx), rotationY : (-20 + dy), ease: Expo.easeOut});
		}
	}
}
