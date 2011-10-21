package com.quancreative.main.views 
{
	import qhn.mvc.view.CompositeView;

	import com.quancreative.main.controller.MainController;
	import com.quancreative.main.model.MainModel;

	import flash.events.Event;

	/**
	 * @author qngo
	 */
	public class HeaderView extends CompositeView 
	{
		private var mainNav : MainNavigation;
		
		public function HeaderView(aModel : MainModel, aController : MainController = null)
		{
			super(aModel, aController);
			
			mainNav = new MainNavigation(aModel, aController);
			
			add(mainNav);
			
			addChild(mainNav); 
		}
		
		override public function update(event : Event = null) : void
		{
			super.update(event);
		}
	}
}
