package com.quancreative.pages.home.view 
{
	import flash.utils.setTimeout;
	import com.greensock.easing.Quart;
	import br.com.stimuli.loading.BulkLoader;

	import qhn.effects.Typewriter;
	import qhn.mvc.view.CompositeView;
	import qhn.utils.Library;

	import com.greensock.TweenLite;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.quancreative.core.SiteSWFAddress;
	import com.quancreative.pages.home.controller.HomePageController;
	import com.quancreative.pages.home.model.HomePageModel;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * @author qngo
	 */
	public class HomePageView extends CompositeView
	{
		private var intro : MovieClip;
		private var messageText : TextField;
		private var featuredWork : FeaturedWork;
		private var featuredWorkDefaultYpos : Number; 
		
		public function HomePageView(aModel : HomePageModel, aController : HomePageController)
		{
			super(aModel, aController);
			
			TweenPlugin.activate([AutoAlphaPlugin]);
			
			var assets : MovieClip = BulkLoader.getLoader("main").getMovieClip("assets");
			
			intro = MovieClip(Library.createAsset(assets, "Intro"));
			intro.buttonMode = true;
			intro.addEventListener(MouseEvent.CLICK, onIntroClick);
			
			featuredWork = FeaturedWork(intro.getChildByName("featuredWork_mc"));
			featuredWork.visible = false;
			
			messageText = TextField(intro.getChildByName("msg_txt"));
			messageText.visible = false;
			
			if (stage) 
				onAddedToStage();
			else 
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			addChild(intro);
		}
		
		override public function update(event : Event = null) : void
		{
			switch ((model as HomePageModel).transitionState)
			{
				case "transitionIn"  :
					// Make sure it goes back to default incase of rapid clicking by the user.
					featuredWork.reset();
					// Wait one second for previous page to transition out.					
					setTimeout(transitionIn, 1000);
				break;
					
				case "transitionOut"  :
					transitionOut();
				break;
			}
		}
		
		public function transitionIn() : void
		{
			visible = true;
			alpha = 1;
			
			messageText.visible = true;
			Typewriter.forward(messageText, 20, {delay : .5, onComplete : typerCompleted});
		}
		
		public function transitionOut() : void
		{
			featuredWorkDefaultYpos = featuredWork.y;
			featuredWork.stop();
			
			TweenLite.to(messageText, .7, {autoAlpha: 0});
			TweenLite.to(featuredWork, .5, {delay: .3, ease:Quart.easeIn, onComplete : transitionOutComplete});
		}
		
		private function transitionOutComplete() : void
		{
			// Set back to default.
			featuredWork.y = featuredWorkDefaultYpos;
			featuredWork.alpha = 1;
			featuredWork.visible = true;
			
			messageText.alpha = 1;
			messageText.visible = true;
			
			visible = false;
			
			(controller as HomePageController).changeState("transitionOutComplete");
		}

		private function onIntroClick(event : MouseEvent) : void 
		{
			SiteSWFAddress.gotoPage('portfolio');
		}

		private function typerCompleted() : void
		{
			featuredWork.visible = true;
			featuredWork.startSlideshow((model as HomePageModel).slideshowXML);
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
			
			var centerStage : int = (stageWidth - mainContentWidth ) / 2;
			intro.x = centerStage;
		}
	}
}
