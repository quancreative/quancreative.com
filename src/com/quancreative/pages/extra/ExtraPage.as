package com.quancreative.pages.extra 
{
	import br.com.stimuli.loading.BulkLoader;

	import qhn.utils.Library;

	import com.greensock.TweenLite;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;
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
		private var mainModel : MainModel;
		private var mainController : MainController;
		
		private var comingSoon : MovieClip;
		
		public function ExtraPage(aModel : MainModel, aController : MainController = null)
		{
			super(aModel, aController);
			
			mainModel = aModel;
			mainController = aController;
			
			pageId = "extra";
			
			TweenPlugin.activate([AutoAlphaPlugin]);
			
			visible = false;
			alpha = 0;
			
			var assets : MovieClip = BulkLoader.getLoader("main").getMovieClip("assets");
			comingSoon = MovieClip(Library.createAsset(assets, "ComingSoonExtra"));
			addChild(comingSoon);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event : Event) : void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var mainContentWidth : int = 827;
			var stageWidth : int = stage.stageWidth;
			
			var centerStage : int = (stageWidth - mainContentWidth ) / 2;
			comingSoon.x = centerStage;
		}
		
		override public function update(event : Event = null) : void
		{
			var pageData : PageData = mainModel.currentPageData;
			
			if (pageData)
			{
				if (pageData.id == String(pageId))
					transitionIn();
				else
					transitionOut();
			}
		}
		
		override public function transitionIn() : void
		{
			transitionInComplete();
			
			TweenLite.to(this, 1, {autoAlpha : 1, delay : .75, onComplete:transitionInComplete});
		}
		
		override public function transitionInComplete() : void
		{
			super.transitionInComplete();	
		}
		
		override public function transitionOut() : void
		{
			TweenLite.to(this, 1, {autoAlpha : 0, onComplete:transitionOutComplete});
		}
		
		override public function transitionOutComplete() : void
		{
			super.transitionOutComplete();
		}
	}
}
