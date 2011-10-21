package com.quancreative.pages.home 
{
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.quancreative.main.controller.MainController;
	import com.quancreative.main.model.MainModel;
	import com.quancreative.main.model.PageData;
	import com.quancreative.pages.home.controller.HomePageController;
	import com.quancreative.pages.home.model.HomePageModel;
	import com.quancreative.pages.home.view.HomePageView;
	import com.quancreative.templates.AbstractPage;

	import flash.events.Event;

	/**
	 * @author qngo
	 */
	public class HomePage extends AbstractPage 
	{
		private var mainModel : MainModel;
		private var mainController : MainController;
		
		private var pageModel	: HomePageModel;
		private var pageView 	: HomePageView;
		private var pageController : HomePageController;
		
		public function HomePage(aModel : MainModel, aController : MainController = null)
		{
			super(aModel, aController);
			
			mainModel = aModel;
			mainController = aController;
			
			pageId = "home";
			
			TweenPlugin.activate([AutoAlphaPlugin]);
			
			visible = false;
			alpha = 0;
			
			pageModel = new HomePageModel();						
			pageModel.addEventListener(Event.COMPLETE, onModelComplete);
			pageModel.addEventListener(Event.CHANGE, onModelChange);
			pageModel.parseXML(mainModel.homeXML);
		}
		
		private function onModelComplete(event:Event) : void
		{
			pageModel.removeEventListener(Event.COMPLETE, onModelComplete);
			
			pageController = new HomePageController(pageModel);
			
			pageView = new HomePageView(pageModel, pageController);
			addChild(pageView);
		}
		
		private function onModelChange(event : Event = null) : void 
		{
			pageView.update(event);
			switch (pageModel.transitionState)
			{	
				case "transitionOutComplete" :
					visible = false;
					alpha = 0;
				break;
			}
		}
		
		override public function transitionInComplete() : void
		{
			super.transitionInComplete();
		}
		
		override public function update(event : Event = null) : void
		{
			var pageData : PageData = mainModel.currentPageData;
			
			if (pageData)
			{
				if (pageData.id == String(pageId))
				{
					visible = true;
					alpha = 1;
					pageController.transitionIn();
				}
				else
				{
					pageController.transitionOut();
				}
			}
			
//			super.update(event);  
		}
	}	
}