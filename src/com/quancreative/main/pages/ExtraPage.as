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
	public class ExtraPage extends AbstractPage 
	{
		
		private var extraSWF : MovieClip;
		private var isActive : Boolean = false;
		
		public function ExtraPage(aModel : MainModel, aController : MainController = null)
		{
			super(aModel, aController);
			pageId = "extra";
			
			extraSWF = MovieClip(BulkLoader.getLoader("main").getMovieClip("extraSWF"));
			
			addChild(extraSWF);
			
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
			extraSWF.x = centerStage;
		}

		override public function update(event : Event = null) : void
		{
			var pageData : PageData = (model as MainModel).currentPageData;
			
			if (pageData)
			{
				if (pageData.id == String(pageId))
				{
					extraSWF.transitionIn();
					isActive = true;
				}
				else
				{
					if (isActive) extraSWF.transitionOut();
				}
			}
			
			super.update(event);  
		}
	}
}
