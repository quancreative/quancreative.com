package com.quancreative.main.pages 
{
	import br.com.stimuli.loading.BulkLoader;

	import com.quancreative.main.controller.MainController;
	import com.quancreative.main.model.MainModel;
	import com.quancreative.main.model.PageData;
	import com.quancreative.templates.AbstractPage;

	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * @author qngo
	 */
	public class PortfolioPage extends AbstractPage 
	{
		private var mainModel : MainModel;
		private var mainController : MainController;
		
		private var portfolioSWF : MovieClip;
		
		public function PortfolioPage(aModel : MainModel, aController : MainController = null)
		{
			super(aModel, aController);
			
			mainModel = aModel;
			mainController = aController;
			
			visible = false;
			alpha = 0;
			
			pageId = "portfolio";
			
			portfolioSWF = MovieClip(BulkLoader.getLoader("main").getMovieClip("portfolioSWF"));
			
			addChild(portfolioSWF);
			
			if (stage) 
				onAddedToStage();
			else
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event : Event = null) : void 
		{
			if (event)removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			onStageResize();
			stage.addEventListener(Event.RESIZE, onStageResize);
		}
		
		private function onStageResize(event : Event = null) : void 
		{
			var mainContentWidth : int = 827;
			var stageWidth : int = stage.stageWidth;
//			
			var centerStage : int = (stageWidth - mainContentWidth ) / 2;
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
					portfolioSWF.transitionIn();
				}
				else
				{
					portfolioSWF.transitionOut();
				}
			}
			
			super.update(event);  
		}
	}
}
