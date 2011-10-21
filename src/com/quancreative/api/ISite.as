package com.quancreative.api{

	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.*;
	import flash.net.URLRequest;

	public class ISite extends Sprite {
		
		public static var stage:Stage;
		
		public static const containerWidth:uint = 829;
		public static const containerHeight:uint = 391;
		public static const containerPadding:uint = 6;
		
		public static const xmlRequest:URLRequest  = new URLRequest("xml/quancreative.xml");
		
		public static const space:uint = 1;
		// in seconds
		public static const tweenDuration:uint = 1;
		
		public static var originX:Number;
		public static var originY:Number;
		
		public static var containerX:Number;
		public static var containerY:Number;
		public static var mainContentHeight:uint;
		public static var mainContentWidth:uint;
		
		public static const borderSize:uint = 1;
		
		public function ISite(){			
			
		}
	}
}


