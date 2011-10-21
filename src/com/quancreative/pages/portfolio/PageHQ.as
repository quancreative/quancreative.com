package com.quancreative.pages.portfolio
{
	import flash.events.EventDispatcher;
	import flash.events.Event;
	
	public class PageHQ extends EventDispatcher
	{
		public static const PROJECT_OUT:String = "projectOut";
		public static const ITEM_OUT:String = "itemOut";
		public static const TRANSITION_OUT:String = "transitionOut";
		public static const TRANSITION_IN:String = "transitionIn";
		public static const PRELOAD:String = "preload";
		public static const COMPLETE:String = "complete";
		
		private var listeners:Object;		
		private var uniqueID:uint = 0;		
		private var gotoEventObj:Object;
		
		private static var _instance:PageHQ;
		
		function PageHQ()
		{
			super();
			listeners = {};
			listeners.projectOut = {};
		}
		
		public static function birth():void
		{
			if (_instance == null) _instance = new PageHQ();
		}
		
		public static function get instance():PageHQ
		{
			return _instance;
		}
		
		public function projectOut():void
		{
			dispatchEvent(new Event(PROJECT_OUT));
		}
		
		public function ItemOut():void
		{
			dispatchEvent(new Event(ITEM_OUT));
		}
		
		public function beforeGoto():void
		{
			
		}
	}
}