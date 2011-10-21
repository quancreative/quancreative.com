package com.debug{
	
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.external.ExternalInterface;
	import flash.text.*;
	
	public class Debug{
	
		public static function alert(data:*):void{
			ExternalInterface.call("sendToJS", data);
		}
		
		public static function log(msg:*):void{			
			Debug.addToTrace(msg);
			var myMsg:String = msg;
			ExternalInterface.call("writeToLog", myMsg);			
		}
		
		private function toJS(msg:String):void{
			ExternalInterface.call("sendToJS", msg);
		}
		
		protected static function addToTrace(msg:*):void{
			trace('/*------------------------------------- */');
			trace(msg);
			trace('/*------------------------------------- */');
		}
	}
}