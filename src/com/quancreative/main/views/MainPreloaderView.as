package com.quancreative.main.views 
{
	import qhn.mvc.view.ComponentView;

	import com.quancreative.main.controller.MainController;
	import com.quancreative.main.model.MainModel;
	import com.quancreative.templates.AbstractPage;

	import flash.events.Event;

	/**
	 * @author qngo
	 */
	public class MainPreloaderView extends ComponentView 
	{
		private var preloader : Preloader;
		
		private var isFirstLoad : Boolean = true;
		
		public function MainPreloaderView(aModel : MainModel, aController : MainController = null)
		{
			super(aModel, aController);
			
			(aModel as MainModel).addEventListener("PRELOAD", onPreload);
			
			preloader = new Preloader();
			preloader.addEventListener(Event.COMPLETE, onPreloadComplete);
			
			if (stage) 
				onAddedToStage();
			else 
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onPreload(event : Event) : void
		{
			if (stage) stage.frameRate = 80;
			preloader.load((model as MainModel).globalAssetsList);
			addChild(preloader);
		}

		private function onAddedToStage(event : Event = null) : void 
		{
			onStageResize();
			stage.removeEventListener(Event.RESIZE, onStageResize);
			stage.addEventListener(Event.RESIZE, onStageResize);
		}

		private function onStageResize(event : Event = null) : void 
		{
			preloader.y = 141;
			preloader.x = Math.round( (parent.stage.stageWidth - 305 ) / 2); // 305 is the preloader's width
		}
		
		private function onPreloadComplete(event : Event) : void 
		{
			if (stage) stage.frameRate = 30;
			isFirstLoad = false;
			
			removeChild(preloader);
			
			(controller as MainController).preloadComplete();
		}
	}
}
