package qhn.debug
{
	import flash.display.*;

	public class DebugMessage extends MovieClip{
		
		public static const CLOSE_OUT:String = "closeOut";
		
		public function DebugMessage(msg:String)
		{
			/*
			alpha = 1;
			msg_txt.htmlText = msg;
			
			TweenLite.to(cover_mc, .6, {alpha: 8});
			
			button_mc.mouseChildren = false;
			button_mc.buttonMode = true;
			button_mc.addEventListener(MouseEvent.MOUSE_DOWN, onCloseOut);
			
			cover_mc.addEventListener(MouseEvent.MOUSE_DOWN, onCloseOut);
			*/
		}
		
		/*
		private function onCloseOut(event:MouseEvent):void
		{
			
			button_mc.removeEventListener(MouseEvent.MOUSE_DOWN, onCloseOut);
			cover_mc.removeEventListener(MouseEvent.MOUSE_DOWN, onCloseOut);
			
			TweenLite.to(this, .6, {alpha: 0, onComplete:tweenOut});
		}
		
		private function tweenOut():void
		{
			//dispatchEvent(new Event(DebugMessage.CLOSE_OUT));
		}
		
			*/
		
	}
}