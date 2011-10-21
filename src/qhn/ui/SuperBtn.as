package qhn.ui 
{
	import flash.events.MouseEvent;
	import flash.display.MovieClip;

	/**
	 * @author qngo
	 */
	public class SuperBtn extends MovieClip 
	{
		private var _id		: String;
		private var _enable : Boolean = true;
		private var _selected : Boolean = false;
		
		public function SuperBtn()
		{
			mouseChildren = false;
			enable = true;
			gotoAndStop("UP");
		}
		
		private function addEvents() : void
		{
			buttonMode = true;
			
			addEventListener(MouseEvent.ROLL_OVER, onOver);
			addEventListener(MouseEvent.ROLL_OUT, onOut);
		}

		private function removeEvents() : void
		{
			buttonMode = false;
						
			removeEventListener(MouseEvent.ROLL_OVER, onOver);
			removeEventListener(MouseEvent.ROLL_OUT, onOut);
		}
		
		private function onOver(event : MouseEvent) : void 
		{
			gotoAndPlay("OVER");
		}
		
		private function onOut(event : MouseEvent) : void 
		{
			gotoAndPlay("OUT");	
		}
		
		public function get enable() : Boolean
		{
			return _enable;
		}
		
		/*
		 * !!! Caution !!!
		 * Customized. Not the same as adobe's MovieClip enabled
		 */
		public function set enable(value : Boolean) : void
		{
			_enable = value;
			
			if (_enable)
			{
				addEvents();
				gotoAndStop("UP");
			}
			else 
			{
				removeEvents();
				
				if (_selected) gotoAndPlay("ON");
				else gotoAndStop("OFF"); 	
			}
		}
		
		public function get selected() : Boolean
		{
			return _selected;
		}
		
		public function set selected(value : Boolean) : void
		{
			_selected = value;
			
			if (_selected)
			{
				gotoAndPlay("ON");
			}
			else
			{	
				gotoAndPlay("UP");	
			}
		}
		
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
