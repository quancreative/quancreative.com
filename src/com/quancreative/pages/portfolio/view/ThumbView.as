package com.quancreative.pages.portfolio.view 
{
	import flash.utils.setTimeout;
	import qhn.events.AnimationEvent;
	import qhn.mvc.view.ComponentView;

	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	import com.quancreative.pages.portfolio.Item;
	import com.quancreative.pages.portfolio.PageController;
	import com.quancreative.pages.portfolio.PageModel;
	import com.quancreative.pages.portfolio.model.PageData;
	import com.utils.Caculate;

	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author qngo
	 */
	public class ThumbView extends ComponentView 
	{
		private var items : Array = new Array();
		
		public function ThumbView(aModel : PageModel, aController : PageController = null)
		{
			super(aModel, aController);
			aModel.addEventListener(AnimationEvent.TRANSITION_OUT, onTransitionOut);
			
			var margin		: Number = 1 + 10 + 1;
			var itemWidth	: Number = 275;
			var itemHeight	: Number = 167;
			var xPos 		: Number = 0;
			var yPos 		: Number = 0;
			var delay		: Number = 0;
			
			var myPage : Array = aModel.pages;
			
			for (var i : int = 0; i < myPage.length ;i++)
			{
				var pageData : PageData = myPage[i];
				
				var myItem : Item = new Item();
				myItem.id = i;
				myItem.originX = xPos;
				myItem.originY = yPos;
				myItem.link = pageData.link;
				//myItem.title = pageData;
				myItem.role = pageData.role;
				myItem.technology = pageData.technology;
				myItem.imageURL = pageData.image;
				myItem.x = myItem.originX;
				myItem.y = myItem.originY;
				myItem.delay = delay;
				myItem.addEventListener(MouseEvent.CLICK, onItemClick);
				
				xPos += itemWidth + margin;
				delay += .05;

				if (Caculate.column(i,2))
				{
					xPos = 0;
					yPos += itemHeight + margin;
				}
				
				addChild(myItem);
				
				items.push(myItem);
			}
		}

		private function onTransitionOut(event : AnimationEvent) : void 
		{
			// If this page is the current page.
			if ((model as PageModel).currentPage == "thumbView")
			{
				transitionOut();
			}
		}

		private function onItemClick(event : MouseEvent) : void 
		{
			var myItem : Item = Item(event.currentTarget);
			(controller as PageController).gotoPage(myItem.id);
		}
		
		public function transitionIn() : void
		{
			var total : int = items.length;
			for (var i : int = 0;i < total; i++) 
			{
				var item : Item = items[i];
				item.transitionIn();
			}
			
			TweenLite.to(this, .3, {alpha : 1});
		}
		
		override public function update(event : Event = null) : void
		{
			if ((model as PageModel).currentPage == "thumbView")
			{
				// Give it sometime for others to transition out. 
				setTimeout(transitionIn, 1000);
			}
			else
				transitionOut();
		}

//		private function onEnterFrameHandler(event : Event) : void 
//		{
//			if (stage) initSlider(stage.mouseX, stage.mouseY);
//		}

//		private function initSlider(mouseValX : Number, mouseValY : Number) : void 
//		{
//			var initialWidth : Number = stage.stageWidth;
//			var stageHeight : Number = stage.stageHeight;
//			
//			// return (0 - 1)
//			var mousePercentX : Number = mouseValX / initialWidth;
//			var mousePercentY : Number = (mouseValY / stageHeight);
//			
//			// rotationY -40 to 40
//			var availMovementRotationY : Number = 40;
//			var dy : Number = (availMovementRotationY * mousePercentX);
//			
//			// rotationX 
//			var availMovementRotationX : Number = 30;
//			var dx : Number = availMovementRotationX * mousePercentY;			 
//			
//			TweenLite.to(this, 2, {rotationX : (-15 + dx), rotationY : (-20 + dy), ease: Expo.easeOut});
//		}
		
		public function transitionOut(event : Event = null) : void
		{
			var total : int = items.length;
		
			for (var i : int = 0;i < total; i++) 
			{
				var item : Item = items[i];
				item.transitionOut();
			}
		}
	}
}
