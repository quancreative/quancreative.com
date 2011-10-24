package com.quancreative.main.views 
{
	import br.com.stimuli.loading.BulkLoader;

	import qhn.mvc.view.ComponentView;
	import qhn.utils.Library;

	import com.greensock.TweenLite;
	import com.greensock.easing.Quart;
	import com.quancreative.core.Nav;
	import com.quancreative.core.SiteSWFAddress;
	import com.quancreative.main.controller.MainController;
	import com.quancreative.main.model.MainModel;
	import com.quancreative.main.model.PageData;

	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;

	/**
	 * @author qngo
	 */
	public class MainNavigation extends ComponentView 
	{	 
		private var buttons : Array = new Array();
		private var header : MovieClip;
		
		private var navHolder : Sprite = new Sprite();
		private var currentNav : Nav;
		private var logo : MovieClip;
		
		private var leftBar : Shape;
		private var rightBar : Shape;

		public function MainNavigation(aModel : MainModel, aController : MainController = null)
		{
			super(aModel, aController);
			
			var assets : MovieClip = BulkLoader.getLoader("main").getMovieClip("assets");
			
			header = MovieClip(Library.createAsset(assets, "Header"));
			header.alpha = 0;
			
			logo = MovieClip(Library.createAsset(assets, "Logo"));
			logo.buttonMode = true;
			logo.alpha = 0;
			logo.addEventListener(MouseEvent.CLICK, onLogoClick);
			
			leftBar = createShape(1, 29, 0x1D1812);
			leftBar.alpha = 0;
			
			rightBar = createShape(1, 29, 0x1D1812);
			rightBar.alpha = 0;
			
			addChild(leftBar);
			addChild(navHolder);
			addChild(rightBar);
			addChild(header);
			addChild(logo);
			
			var margin : int = 1;
			
			// create all the button
			for (var i : int = 0; i < (model as MainModel).totalPage; i++)
			{
				var pageData : PageData = (model as MainModel).pages[i];
				var myNavName : String = pageData.id;
				
				var myNav : Nav = Nav(Library.createAsset(assets, "Nav"));
				myNav.label = myNavName;				
				myNav.id = pageData.id;
				myNav.x = (myNav.width * i) + (margin * i);
				myNav.alpha = 0;
				myNav.mouseChildren = false;
				myNav.addEventListener(MouseEvent.CLICK, onNavClick);
				
				navHolder.addChild(myNav);				
				buttons[myNavName] = myNav;
				buttons.push(myNav);
			}
			
			if (stage) 
				onAddedToStage();
			else
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onLogoClick(event : MouseEvent) : void 
		{
			SiteSWFAddress.gotoPage('home');
//			(controller as MainController).gotoPage(0);
		}

		private function onAddedToStage(event : Event = null) : void 
		{
			if (event) removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			onStageResize();
			stage.addEventListener(Event.RESIZE, onStageResize);
			
			transitionIn();
		}

		private function transitionIn() : void 
		{
			var delay : Number = .5;
			var headerYpos : Number = header.y;
			header.y = -header.height;
			TweenLite.to(header, .5, {alpha : 1, y : headerYpos, ease : Quart.easeOut});
			
			TweenLite.to(logo, .5, {alpha : 1, delay : delay});
			
			TweenLite.to(leftBar, .5, {alpha : .6, delay : delay});
			
			var total : int = navHolder.numChildren;
			for (var i : int = 0; i < total; i++)
			{
				var myNav : Nav = Nav(navHolder.getChildAt(i));
				TweenLite.to(myNav, .5, {alpha : 1, delay : delay});
				
				delay += .1;
			}
			TweenLite.to(rightBar, .5, {alpha : .6, delay : delay});
		}

		private function onStageResize(event : Event = null) : void 
		{
			var yPos : int = header.y + header.height + 1;
			var stageWidth : int = stage.stageWidth;
			
			var mainContentWidth : int = 827;
			var centerStage : int = (stageWidth - mainContentWidth ) / 2;
//			var spaceToFill : int = stageWidth - navHolder.width - 2;
			
			navHolder.x = centerStage;
			navHolder.y = yPos;
			
			leftBar.width = Math.round(navHolder.x) - 1;
			leftBar.y = yPos;
			
			var endPos : int = navHolder.x + navHolder.width;
			
			rightBar.width = stageWidth - endPos;
			rightBar.x = Math.round(endPos) + 1;
			rightBar.y = yPos;
			
			header.width = stageWidth;
			
			logo.x = centerStage;
			logo.y = 26;
		}

		private function onNavClick(event : MouseEvent) : void 
		{
			// Turn off all nav.
			enableAllNav(false);
			
			var myNav : Nav = Nav(event.currentTarget);
			myNav.activate();
			myNav.removeEventListener(MouseEvent.CLICK, onNavClick);
			
//			(controller as MainController).gotoPage(myNav.id);
			SiteSWFAddress.gotoPage(myNav.id);
		}

		override public function update(event : Event = null) : void
		{
			// Set the active/old nav to its default state.
			if (currentNav)
			{
				currentNav.setDefault();
				currentNav.addEventListener(MouseEvent.CLICK, onNavClick);
			}
			
			// Wait for page transition.
			setTimeout(setNewNav, 1500);
		}
		
		private function setNewNav() : void
		{
			var pageData : PageData = (model as MainModel).currentPageData;
			if (pageData)
			{
				var myNavName : String = pageData.id;
				
				var nav : Nav = buttons[myNavName];
				
				currentNav = nav;
				currentNav.activate();
			}
			
			// Turn back on all nav.
			enableAllNav(true, currentNav);
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
		
		/*
		 * Enable or disable all page navigations.
		 */
		private function enableAllNav(value : Boolean, exception : Nav = null) : void
		{
			var total : int = buttons.length;
			for (var i : int = 0; i < total; i++)
			{
				var nav : Nav = buttons[i];
				
				if (nav != exception)
				{
					nav.enabled = value;
					nav.mouseEnabled = value;
				}
			}
		}
	}
}
