﻿package com.quancreative.pages.extra
{
	import flash.events.*;

	public class ScrollbarEvent extends Event{
		
		public static const VALUE_CHANGED = "valueChanged";
		public var scrollPercent:Number;
		
		public function ScrollbarEvent(sp:Number):void{
			super(VALUE_CHANGED);
			scrollPercent = sp;
		}
	}
}


