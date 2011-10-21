package com.quancreative.pages.portfolio.view 
{
	import flash.utils.setTimeout;
	import qhn.events.AnimationEvent;
	import qhn.events.PageEvent;
	import qhn.mvc.view.ComponentView;

	import com.greensock.TweenLite;
	import com.quancreative.pages.portfolio.PageController;
	import com.quancreative.pages.portfolio.PageModel;
	import com.quancreative.pages.portfolio.model.PageData;

	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;

	/**
	 * @author qngo
	 */
	public class FullView extends ComponentView 
	{
		private var loader : Loader;
		private var closeBox : MovieClip;
		private var projectDetails : MovieClip;
		
		private var imgWidth : int = 817;
		private var imgHeight : int = 379;
		
		private var bkgd : Shape;
		private var border : int = 6;
		
		public function FullView(aModel : PageModel, aController : PageController = null)
		{
			super(aModel, aController);
			
			aModel.addEventListener(AnimationEvent.TRANSITION_OUT, onTransitionOut);
			
			controller = aController;
			
			closeBox = new CloseBox();
			closeBox.addEventListener(MouseEvent.CLICK, onCloseClick);
			closeBox.buttonMode = true;
			closeBox.gotoAndStop(1);
			closeBox.x = imgWidth - closeBox.width - border - 2;
			closeBox.y = - 4;
			
			projectDetails = new ProjectDetails();
			projectDetails.gotoAndStop(1);
			projectDetails.y = imgHeight + (border * 2) + 1;
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderCompleted);
			loader.x = border;
			loader.y = border;
			
			bkgd = createShape(imgWidth + (border * 2), imgHeight + (border * 2), 0x111111);
			bkgd.alpha = .6;
			
			addChild(bkgd);
			addChild(projectDetails);
			addChild(loader);
			addChild(closeBox);
			
			// prep for transitionIn
			alpha = 0;
		}

		public function transitionIn() : void
		{
			TweenLite.to(this, .3, {alpha : 1, onComplete : transitionInComplete});
		}

		private function transitionInComplete() : void 
		{
			closeBox.gotoAndPlay("IN");
			projectDetails.gotoAndPlay("IN");
			
			dispatchEvent(new AnimationEvent(AnimationEvent.TRANSITION_IN_COMPLETE));
		}
		
		private function onCloseClick(event : MouseEvent) : void 
		{
			playOut();
			
			(controller as PageController).gotoPage('thumbView');
		}
		
		private function playOut() : void
		{
			closeBox.gotoAndPlay("OUT");
			projectDetails.gotoAndPlay("OUT");
			
			// Delay is for the closeBox and porjectDetails to play their out transition.
			TweenLite.to(this, .5, {alpha : 0, delay: .5});
		}
		
		private function onTransitionOut(event : AnimationEvent) : void 
		{
			// If this page is the current page.
			if ((model as PageModel).currentPage != "thumbView")
			{
				playOut();
			}
		}
		
		public function transitionOut() : void
		{
			
		}
		
		private function loaderCompleted(event : Event) : void 
		{
			
		}
		 
		private function createShape(sWidth:int, sHeight:int, sBkgdColor:uint):Shape
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill(sBkgdColor);
			shape.graphics.lineStyle();
			shape.graphics.drawRect(0, 0, sWidth, sHeight);
			shape.graphics.endFill();
			
			return shape;
		}
		
		override public function update(event : Event = null) : void
		{
			super.update(event);
			
			if ((model as PageModel).currentPage != "thumbView")
			{
				var pgData : PageData = (model as PageModel).currentPageData;
				
				if (pgData)
				{
					loader.load(new URLRequest(pgData.image));
					
					projectDetails.title_mc.titleTxt.htmlText = "<p><a href='http://" + pgData.link + "'>" + pgData.link + "</a></p>";
					projectDetails.detail_mc.role.text = pgData.role;
					
					setTimeout(transitionIn, 1000);
				}
			}
		}
	}
}
