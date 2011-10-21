package com.quancreative.core
{
	import flash.display.MovieClip;
	import flash.events.*;

	public class Nav extends MovieClip
	{
		private var nameClip : MovieClip;
		private var _label : String;
		private var _id : String;

		public function Nav()
		{
			super();
			
			nameClip = MovieClip(getChildByName("name_mc"));
			nameClip.name_txt.mouseEnabled = false;
			
			setDefault();
		}
		
		public function set label(value : String) : void
		{
			_label = value;
			
			nameClip.name_txt.text = _label;
		}

		public function setDefault():void{
			gotoAndStop(1);
			buttonMode = true;
						
			addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
			addEventListener(MouseEvent.ROLL_OUT, onMouseOut);			
		}
		
		public function activate():void
		{
			gotoAndStop("ACTIVE");
			buttonMode = false;
			//removeEventListener(MouseEvent.MOUSE_DOWN, onClick);
			removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
			removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);	
		}
		
		//--------------------------------------
		//  Events
		//--------------------------------------
		private function onMouseOver(event:MouseEvent) : void
		{
			event.target.gotoAndPlay("IN");
		}

		private function onMouseOut(event:MouseEvent) : void
		{
			event.target.gotoAndPlay("OUT");
		}
		
		//--------------------------------------
		//  Getter & Setter
		//--------------------------------------
		
		public function get id() : String
		{
			return _id;
		}
		
		public function set id(value : String) : void
		{
			_id = value;
		}		
	}
}


