package com.quancreative.pages.portfolio.view
{
	import qhn.mvc.view.CompositeView;

	import com.quancreative.pages.portfolio.PageController;
	import com.quancreative.pages.portfolio.PageModel;

	import flash.events.*;

	public class PageView extends CompositeView 
	{
		private var thumbView : ThumbView; 
		private var fullView : FullView;
		private var centerStageX : Number = 0;
//		private var bkgd : BkgdView;
		
		public function PageView(aModel : PageModel, aController : PageController = null)
		{	
			super(aModel, aController);
			
			thumbView = new ThumbView(aModel, aController);
			
			fullView = new FullView(aModel, aController);
			
//			bkgd = new BkgdView(aModel.bkgdURL);
			
			add(fullView);
			add(thumbView);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event : Event = null) : void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var mainContentWidth : int = 827;
			var stageWidth : int = stage.stageWidth;
			
			centerStageX = (stageWidth - mainContentWidth ) / 2;

//			addChild(bkgd);
			addChild(thumbView);
						
			thumbView.x = centerStageX;
			fullView.x = centerStageX;
		}		

		override public function update(event : Event = null) : void
		{
			// swap depth trick
			if ((model as PageModel).currentPage == "thumbView")
				addChild(thumbView);
			else
				addChild(fullView);
			
			super.update(event);
		}
	}
}