package com.quancreative.core
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.net.URLRequest;

	public class Root extends MovieClip {
		
		public static var stage:Stage;
		
		public static const containerWidth:uint = 829;
		public static const containerHeight:uint = 391;
		public static const containerPadding:uint = 6;
		
		public static const xmlRequest:URLRequest  = new URLRequest("xml/quancreative.xml");
		
		public static const space:uint = 1;
		// in seconds
		public static const tweenDuration:uint = 1;
		
		public static var mainContentX:int;
		public static var mainContentY:int;
		public static var mainContentHeight:uint;
		public static var mainContentWidth:uint;
		
		public static const borderSize:uint = 1;
		
		public function Root()
		{			
			Root.stage = this.stage;
		}
	}
}


