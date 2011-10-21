package qhn.ui 
{
	import flash.text.TextField;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	/**
	 * @author qngo
	 */
	public class NavBtn extends MovieClip 
	{
		private var _selected : Boolean = false;
		
		// id can be a string or a number
		private var _id : Object;
		private var _label : String;
		
		private var labelTF : TextField;
		private var labelMC : MovieClip;

		public function NavBtn()
		{
			mouseChildren = false;
			
			configUI();			
		}
		
		private function configUI() : void
		{
			gotoAndStop(1);
			
			labelTF = getChildByName("label_txt") as TextField;
			labelMC = getChildByName("label_mc") as MovieClip; 
			
			addListeners();
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
				removeListeners();
				
				gotoAndPlay("IN");
			}
			else
			{
				addListeners();
				
				gotoAndPlay("OUT");
			}
		}

		private function addListeners() : void
		{
			buttonMode = true;
			
			addEventListener(MouseEvent.ROLL_OVER, onOver);
			addEventListener(MouseEvent.ROLL_OUT, onOut);
		}

		private function removeListeners() : void
		{
			buttonMode = false;
			
			removeEventListener(MouseEvent.ROLL_OVER, onOver);
			removeEventListener(MouseEvent.ROLL_OUT, onOut);
		}
		
		private function onOut(event : MouseEvent) : void
		{
			gotoAndPlay("OUT");	
		}

		private function onOver(event : MouseEvent) : void
		{
			gotoAndPlay("IN");
		}
		
		public function get id() : Object
		{
			return _id;
		}
		
		public function set id(value : Object) : void
		{
			_id = value;			
		}
		
		public function get label() : String
		{
			return _label;
		}
		
		public function set label(value : String) : void
		{
			_label = value;
			
			if (labelTF != null) labelTF.text = _label;
			else labelMC.gotoAndStop(_label.toUpperCase());
		}		
	}
}
