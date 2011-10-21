package com.quancreative.pages.contact 
{
	import flash.utils.clearTimeout;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	import br.com.stimuli.loading.BulkLoader;

	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.quancreative.main.controller.MainController;
	import com.quancreative.main.model.MainModel;
	import com.quancreative.main.model.PageData;
	import com.quancreative.pages.contact.view.ContactForm;
	import com.quancreative.templates.AbstractPage;

	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * @author qngo
	 */
	public class ContactPage extends AbstractPage 
	{
		private var mainModel : MainModel;
		private var mainController : MainController;
		
		private var timer : uint;
		private var form : ContactForm;
		
		public function ContactPage(aModel : MainModel, aController : MainController = null)
		{
			super(aModel, aController);
			
			mainModel = aModel;
			mainController = aController;
			
			pageId = "contact";
			
			TweenPlugin.activate([AutoAlphaPlugin]);
			
			form = ContactForm(BulkLoader.getLoader("main").getMovieClip("contactForm"));
			
			addChild(form);
			
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
			form.x = centerStage;
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
			// Wait for the previous page to transition out.
			timer = setTimeout(form.transitionIn, 500);
		}

		override public function transitionOut() : void
		{
			// Clear the setTimeout if it's running.
			clearTimeout(timer);
			form.transitionOut();
		}
	}
}
