package com.quancreative.main.views 
{
	import qhn.mvc.view.CompositeView;

	import com.quancreative.core.SiteContextMenu;
	import com.quancreative.main.controller.MainController;
	import com.quancreative.main.model.MainModel;

	import flash.events.Event;

	/**
	 * @author qngo
	 */
	public class MainView extends CompositeView 
	{
		private var mainPreloaderView : MainPreloaderView;
		private var mainContentView : MainContentView;
		
		public function MainView(aModel : MainModel, aController : MainController = null)
		{
			super(aModel, aController);
			
			// MainPreloaderView doesn't require to be added (add()). 
			// It listens to the model outside of the composite pattern. 
			mainPreloaderView = new MainPreloaderView(aModel, aController);
			
			addChild(mainPreloaderView);
		}

		override public function update(event : Event = null) : void
		{	
			switch ((model as MainModel).state)
			{
				case "pageFlipping" :
					// This should run only once.
					if (!mainContentView)
					{
						mainContentView = new MainContentView((model as MainModel), (controller as MainController));
						add(mainContentView);
						addChild(mainContentView);
					}
				break;
			}
			
			super.update(event);
		}
	}
}                        