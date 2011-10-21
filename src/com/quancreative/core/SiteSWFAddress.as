package com.quancreative.core
{
	import com.debug.Debug;

	import flash.events.*;

	public class SiteSWFAddress extends EventDispatcher
	{
		public static const SWFADDRESS_CHANGE : String = "swfAddressChange";
		
		private static var rootBranch	: String;
		private static var _instance	: SiteSWFAddress;
		private static var _value	: String;
		
		function SiteSWFAddress()
		{
			super();
		}
		
		public static function birth(s:String = null):void{
			rootBranch = s;
			
			Debug.log("SiteSWFAddress rootBranch = " + s);
			
			if (_instance == null) _instance = new SiteSWFAddress();
			
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, _instance.onChange);
		}
		
		public static function get instance() : SiteSWFAddress
		{
			return _instance;
		}
		
		public static function getValue() : String
		{
			return _value;
		}
		
		public static function gotoPage(page : String) : void 
		{
			SWFAddress.setValue("/" + page + "/");	
		}
		
		private function onChange(event : SWFAddressEvent) : void
		{
			try 
			{
				if (event.value == '/') 
				{					
					//SWFAddress.setValue("/home/");
				} 
				else 
				{					
					//var myAddressValue:String = event.value.toLowerCase();
					_value = stripStrictSlashes(event.value);
				}
				
				dispatchEvent(new Event(SiteSWFAddress.SWFADDRESS_CHANGE));
				
				SWFAddress.setTitle(formatTitle(event.value));
			} 
			catch(err : Error) 
			{
				trace('$/error/', this);
				trace(err, this);
			}
		}
		
		private function stripStrictSlashes(str:String = null):String
		{
			if (str == null || str.length == 0) return "";
			if (str.charAt(0) == "/") str = str.substr(1);
			if (str.charAt(str.length - 1) == "/") str = str.substr(0, str.length - 1);
			return str;
		}
		
		// Custom utilities
		private function replace(str : String, find : String, replace : String) : String 
		{
			return str.split(find).join(replace);
		}
		
		private function toTitleCase(str : String) : String 
		{
			return str.substr(0,1).toUpperCase() + str.substr(1);
		}
		
		private function formatTitle(title : String) : String 
		{
			return 'QuanCreative' + (title != '/' ? ' / ' + toTitleCase(replace(title.substr(1, title.length - 2), '/', ' / ')) : '');
		}
	}
}