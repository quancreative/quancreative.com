package qhn.ui
{
	import qhn.events.ScrollbarEvent;

	import flash.display.*;
	import flash.events.*;

	public class Scrollbar extends MovieClip
	{
		
		protected var thumb:MovieClip;
		protected var track:MovieClip;
		
		private var _contentMc:MovieClip;
		
		private var yOffset:Number;
		private	var yMin:Number;
		private	var yMax:Number;
		
		public function Scrollbar()
		{
			super();
			
			configUI();
		}
		
		private function configUI() : void
		{
			thumb = MovieClip(getChildByName("thumb_mc"));
			
			track = MovieClip(getChildByName("track_mc"));
		}

		public function init() : void
		{
			yMin = 0;
			yMax = track.height - thumb.height;

			thumb.buttonMode = true;
			thumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
		}
		
		// Note: this is a public function. Called by parent 
		public function onMouseWheel(event : MouseEvent) : void
		{
			var myDelta : Number = event.delta;
			
			thumb.y -= myDelta;
			
			yOffset = mouseY - thumb.y;
			
			thumbMove(event);
		}

		private function thumbDown(event:MouseEvent) : void
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpEvent);
			stage.addEventListener(Event.MOUSE_LEAVE, mouseLeaveFlash);
			
			yOffset = mouseY - thumb.y;
		}
		
		private function mouseLeaveFlash(event:Event) : void
		{
			removeEvents();
		}
		
		private function mouseUpEvent(event:MouseEvent) : void
		{
			removeEvents();
		}
		
		private function removeEvents() : void
		{
			stage.removeEventListener(Event.MOUSE_LEAVE, mouseLeaveFlash);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpEvent);
		}

		private function thumbMove(event : MouseEvent = null) : void
		{
			thumb.y = mouseY - yOffset;
			
			if(thumb.y <= yMin)
			{
				thumb.y = yMin;
			}
			else if(thumb.y >= yMax)
			{
				thumb.y = yMax;
			}
						
			dispatchEvent(new ScrollbarEvent(thumb.y / yMax));
			
			if (event != null) event.updateAfterEvent();
		}
		
		public function set contentMc(value:MovieClip):void
		{
			_contentMc = value;
		}
	}
}