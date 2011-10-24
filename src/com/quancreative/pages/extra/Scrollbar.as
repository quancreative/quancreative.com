package com.quancreative.pages.extra
{
	import flash.display.*;
	import flash.events.*;

	public class Scrollbar extends MovieClip{
		
		private var yOffset:Number;
		private	var yMin:Number;
		private	var yMax:Number;
		
		private var thumb : MovieClip;
		private var track : MovieClip;
		
		public function Scrollbar()
		{
			thumb = MovieClip(getChildByName("thumb_mc"));
			track = MovieClip(getChildByName("track_mc"));
			
			yMin = 0;
			yMax = track.height - thumb.height;
			thumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
			//stage.addEventListener(MouseEvent.MOUSE_UP, thumbUp);
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
		}
		
		private function addedToStage(event:Event):void{
			stage.addEventListener(MouseEvent.MOUSE_UP, thumbUp);
		}
		
		private function removedFromStage(event:Event):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP, thumbUp);
		}
						
		private function thumbDown(event:MouseEvent):void{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
			yOffset = mouseY - thumb.y;
		}
		
		private function thumbUp(event:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
		}
		
		private function thumbMove(event:MouseEvent):void{
			thumb.y = mouseY - yOffset;
			if(thumb.y <= yMin){				
				thumb.y = yMin;
				
			}else if(thumb.y >= yMax){
				thumb.y = yMax;
			}
						
			dispatchEvent(new ScrollbarEvent(thumb.y / yMax));
			
			event.updateAfterEvent();
		}
	}
}


