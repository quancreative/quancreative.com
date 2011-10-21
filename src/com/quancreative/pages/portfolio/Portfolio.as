package com.quancreative.pages.portfolio
{
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.quancreative.model.AppModel;
	import com.quancreative.pages.portfolio.view.PageView;

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.net.URLRequest;

	public class Portfolio extends MovieClip
	{	
		private var pageModel : PageModel;
		private var pageView : PageView;
		private var controller : PageController;

		public function Portfolio()
		{
			TweenPlugin.activate([AutoAlphaPlugin]);
			
//			visible = false;
//			alpha = 0;
		
			pageModel = new PageModel();						
			pageModel.addEventListener(Event.COMPLETE, onModelComplete);
			pageModel.addEventListener(Event.CHANGE, onModelChange);
			pageModel.load(new URLRequest("xml/portfolio.xml"));
//			pageModel.parseXML(portfolioXML);
		}

		private function onModelComplete(event:Event) : void
		{
			pageModel.removeEventListener(Event.COMPLETE, onModelComplete);
			
			controller = new PageController(pageModel);
			
			pageView = new PageView(pageModel, controller);
			addChild(pageView);
			
			// If this is running by itself.
			if (AppModel.getInstance().isStandAlone) transitionIn();
		}

		private function onModelChange(event : Event) : void 
		{
			pageView.update(event);
		}
		
		public function transitionIn() : void
		{	
			controller.gotoPage("thumbView");
			
//			setTimeout(transitionOut, 8000); // testing
		}
		
		public function transitionOut() : void
		{
			controller.transitionOut();
		}
	}
}


