package qhn.debug
{
	import flash.display.*;
	import flash.events.*;
	import flash.external.ExternalInterface;
	import flash.text.*;

	public class Debug{
			
		public static function alert(data:*):void{
			ExternalInterface.call("sendToJS", data);
		}
		
		public static function timerLog(msg:*, delay:Number = 1000) : void
		{
			/*
			timer = new Timer(delay);
			timer.addEventListener(TimerEvent.TIMER, timerHandle);
			timer.start();
			*/
		}
		
		public static function boxMessage(msg:*, mc:MovieClip):void
		{
			var myTextField:TextField = new TextField();
			myTextField.background = true;
			myTextField.backgroundColor = 0xFFFFFF;
			myTextField.wordWrap = true;
			myTextField.text = msg as String;
			
			var newFormat:TextFormat = new TextFormat();
			newFormat.bold = true;
            newFormat.size = 18;
            newFormat.color = 0xFF0000;
            newFormat.align = TextFormatAlign.CENTER;
            myTextField.defaultTextFormat = newFormat;

			mc.addChild(myTextField);
		}
		
		private function timerHandler(event:TimerEvent):void
		{
			//Debug.log(event.msg);
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
			trace('/*---------- Debug ---------- */');
			trace(msg);
			trace('/*-------- end Debug -------- */');
		}
	}
}