package com.quancreative.pages.extra
{
	import flash.events.*;
		
	public class ProjectEvent extends Event{
		
		public static const CREATE_COMPLETE = "createComplete";
				
		public function ProjectEvent():void{
			
			super(CREATE_COMPLETE);
			
		}
	}
}


