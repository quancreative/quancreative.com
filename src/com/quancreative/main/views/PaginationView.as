package com.quancreative.main.views 
{
	import qhn.mvc.view.CompositeView;

	import com.quancreative.core.SiteSWFAddress;
	import com.quancreative.main.controller.MainController;
	import com.quancreative.main.model.MainModel;
	import com.quancreative.main.model.PageData;
	import com.quancreative.main.pages.ExtraPage;
	import com.quancreative.main.pages.PortfolioPage;
	import com.quancreative.pages.about.AboutPage;
	import com.quancreative.pages.contact.ContactPage;
	import com.quancreative.pages.home.HomePage;
	import com.quancreative.templates.AbstractPage;

	import flash.events.Event;

	/**
	 * @author qngo
	 */
	public class PaginationView extends CompositeView 
	{
		private var pages : Array;
		private var currentPage : AbstractPage;
		
		public function PaginationView(aModel : MainModel, aController : MainController = null)
		{
			super(aModel, aController);
			
			createPage();
			
			if (stage) onAddedToStage();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event : Event = null) : void 
		{
			if (event) stage.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		override public function update(event : Event = null) : void
		{
			trace("page changing" , this);
			
			switch ((model as MainModel).state)
			{
				case "pageFlipping" :
					if((model as MainModel).currentPageData)
					{
						if (pages)
						{
							var currentPageId : String = (model as MainModel).currentPageData.id;
							
							// Remove previous page if it existed.
							//if (currentPage) removeChild(currentPage);
							
							currentPage = pages[currentPageId];
							// Set its z-index to the top of the list. 
							addChild(currentPage);
							
							SWFAddress.setValue("/" + currentPageId + "/");	
						}
					}
				break;
			}
			
			super.update(event);
		}
		
		private function createPage() : void 
		{
			pages = new Array();
			// create all the pages
			for (var i : int = 0; i < (model as MainModel).totalPage; i++)
			{
				var page : AbstractPage;				
				var pageData : PageData = (model as MainModel).pages[i];
				
				switch (pageData.id)
				{
					case "home" :
						page = new HomePage((model as MainModel), (controller as MainController));
					break;
						
					case "portfolio" :
						page = new PortfolioPage((model as MainModel), (controller as MainController));
					break;
					
					case "contact" : 
						page = new ContactPage((model as MainModel), (controller as MainController));
					break;
						
					case "about" :
						page = new AboutPage((model as MainModel), (controller as MainController));
					break;
					
					case "extra" :
						page = new ExtraPage((model as MainModel), (controller as MainController));
					break;
				}
				
				add(page);
				addChild(page);
				pages[pageData.id] = page;
			}
		}
	}
}
