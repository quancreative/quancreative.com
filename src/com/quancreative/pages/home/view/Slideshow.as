package com.quancreative.pages.home.view 
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;

	public class Slideshow extends Sprite 
	{
		private var container : DisplayObjectContainer;
		private var list : XMLList;
	
		private var loader : Loader = new Loader();
		
		private var timer:Timer = new Timer(2000, 1);
		private var _index : int = 0;

		public function Slideshow(aContainer : DisplayObjectContainer, xmlList : XMLList) 
		{
			super();
			
			container = aContainer;
			list = xmlList;
			container.addChild(loader);
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete);
			
			timer.addEventListener(TimerEvent.TIMER, onTimer);
		}		

		private function onLoaderComplete(event : Event) : void 
		{
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		private function maskComplete(event:Event) : void
		{					
			timer.start();
		}
		
		private function onTimer(event:TimerEvent) : void
		{
			timer.stop();
			timer.reset();
		}
		
		public function get currentImage() : Bitmap
		{
			return Bitmap(loader.content);
		}

		public function startSlideshow() : void 
		{
			loader.load(new URLRequest(list[_index].@image));
			//timer.start();
		}
		
		public function stopSlideshow() : void
		{
			timer.stop(); 
		}
		
		public function get currentIndexNum() : int
		{	
			return _index;
		}
	}
}
