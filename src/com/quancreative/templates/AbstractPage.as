package com.quancreative.templates
{
	import qhn.events.AnimationEvent;
	import qhn.mvc.view.ComponentView;

	import flash.events.*;

	public class AbstractPage extends ComponentView
	{
		public var pageId : Object;
		 	
		public function AbstractPage(aModel : Object, aController : Object = null)
		{
			super(aModel, aController);
		}

		public function transitionIn() : void
		{
			//trace('called from abstract page');
		}
		
		public function transitionInComplete() : void
		{
			dispatchEvent(new AnimationEvent(AnimationEvent.TRANSITION_IN_COMPLETE));
		}
		
		public function transitionOut() : void
		{
			
		}
		
		public function transitionOutComplete() : void
		{			
			dispatchEvent(new AnimationEvent(AnimationEvent.TRANSITION_OUT_COMPLETE));
		}
		
		override public function update(event : Event = null) : void
		{
			super.update(event);
		}
		
		//--------------------------------------
		//  Events
		//--------------------------------------
		
		public function fullScreen(event : Event) : void
		{
			
		}
		
		public function stageResize(event : Event) : void
		{
			
		}
	}
}