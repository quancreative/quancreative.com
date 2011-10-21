package com.quancreative.pages.portfolio
{
	import flash.utils.setTimeout;
	import com.greensock.TweenLite;
	import com.greensock.easing.Quint;
	import com.quancreative.api.ISite;

	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;

	public class Item extends MovieClip{
		
		public static const ITEM_SELECT : String = "item_select";
		
		private var _id:Number;
		private var _imageURL:String;
		private var _link:String;
		private var _title:String;
		private var _role:String;
		private var _technology:String;
		
		private var _originX:Number = 0;
		private var _originY:Number = 0;
		
		private var isTransitionedIn:Boolean;
		
		private static const padding:uint = ISite.containerPadding;
		
		private static const boxWidth:uint = 275;
		private static const boxHeight:uint = 167;
	
		private var preloader:TextField = new TextField();
		
		private var _asset:ItemAsset;
		
		// White fill
		private var outerFill:Shape;
		private var innerFill:Shape;
		
		private var holder:Sprite;
		private var loaderMask:Shape;
		private var loader:Loader;
		
		private var itemDetail : MovieClip;
		private var itemDetailYpos:Number;
		
		private var isLoaded : Boolean = false;
		
		// Set by ThumbView
		public var delay:Number; 
		
		public function Item()
		{
			super();
				
			buttonMode = false;
			mouseChildren = false;
			mouseEnabled = false;
			enabled = false;
		
			outerFill = createShape(boxWidth, boxHeight, 0xFFFFFF);
			outerFill.alpha = 0;
			
			var innerFillWidth:Number = boxWidth - (padding * 2);
			var innerFillHeight:Number = boxHeight - (padding * 2);			
			innerFill = createShape(innerFillWidth, innerFillHeight, 0x111111);
			innerFill.alpha = 0;
			innerFill.x = padding;
			innerFill.y = padding;
			
			itemDetail = new ItemDetail();
			itemDetail.bkgd_mc.alpha = 0.8;
			itemDetailYpos = padding + innerFillHeight - itemDetail.bkgd_mc.height;
			itemDetail.x = padding;
			itemDetail.y = innerFill.height + padding; // pull it up using tween;
			//itemDetail.title_txt.htmlText = title;
			itemDetail.visible = false;
			
			loaderMask = createShape(263, 155, 0x000000);
			loaderMask.x = padding;
			loaderMask.y = padding;
			
			loader = new Loader();
			loader.x = padding;
			loader.y = padding;
			loader.alpha = 0;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderCompleted);
			
			//loader.mask = loaderMask;
			
			holder = new Sprite();			
			holder.addChild(loader);
			holder.addChild(itemDetail);
			holder.mask = loaderMask;
			
			// add child to the display's list
			addChild(outerFill);
			addChild(innerFill);
			addChild(holder);
//			addChild(itemDetail);
			addChild(loaderMask);
			
			transitionInPrep();
		}

		private function transitionInPrep() : void 
		{
			// reset everything
			outerFill.x = 0;
			outerFill.y = 0;
			outerFill.scaleX = 1;
			outerFill.scaleY = 1;
			outerFill.alpha = 0;
			
			innerFill.alpha = 0;
			innerFill.x = padding;
			innerFill.y = padding;
			innerFill.scaleX = 1;
			innerFill.scaleY = 1;
			
			loaderMask.x = padding;
			loaderMask.y = padding;
			loaderMask.scaleX = 1;
			loaderMask.scaleY = 1;
			
			loader.y = padding;
			
			itemDetail.y = innerFill.height + padding;
		}

		private function loaderCompleted(event:Event):void
		{
			isLoaded = true;
//			transitionIn();
		}
		
		public function transitionIn():void
		{
			if (isLoaded)
				initTranstion();
			else
				setTimeout(transitionIn, 200);
		}
		
		private function initTranstion() : void
		{
			transitionInPrep();
			
			TweenLite.from(outerFill,.5,{alpha:0,x:boxWidth/2,y:boxHeight/2,scaleX:0,scaleY:0,ease:Quint.easeOut,delay:delay,onInit:function():void{outerFill.alpha=1;}});
			
			function onInnerFillInit() : void
			{
				innerFill.alpha = 0.8;
			}
			
			TweenLite.from(innerFill, .4, {x: boxWidth/2, y: boxHeight/2, scaleX:0, scaleY:0, alpha:0, delay: (delay + .15), ease:Quint.easeOut, onInit: onInnerFillInit});
			
			loader.alpha = 0;
			loader.x = -loader.width/2;			
			TweenLite.to(loader, .5, {x:padding, alpha:1, delay: (delay + .5)});
			
			itemDetail.visible = true;
			TweenLite.to(itemDetail, .5, {y:itemDetailYpos, ease:Quint.easeOut, delay:( delay + .75), onComplete: addEvents});
		}
		
		private function addEvents() : void
		{
			addEventListener(MouseEvent.ROLL_OVER, onOver);
			addEventListener(MouseEvent.ROLL_OUT, onOut);
				
			buttonMode = true;
			enabled = true;
			mouseEnabled = true;
		}

		private function removeEvents() : void
		{
			buttonMode = false;
			enabled = false;
			mouseEnabled = false;
			
			removeEventListener(MouseEvent.ROLL_OVER, onOver);
			removeEventListener(MouseEvent.ROLL_OUT, onOut);
		}

		public function transitionOut():void
		{
			removeEvents();
			
			TweenLite.to(loaderMask, .4, {x:boxWidth, scaleX:0});
			TweenLite.to(innerFill, .4, {x: boxWidth/2, y: boxHeight/2, scaleX:0, scaleY:0, alpha: 0, delay:.4});
			TweenLite.to(outerFill, .4, {x: boxWidth/2, y: boxHeight/2, scaleX:0, scaleY:0, alpha: 0, delay:.5});
		}
		
		private function onOver(event:MouseEvent):void
		{
			TweenLite.to(outerFill, .2, {alpha:0.6});
			TweenLite.to(loader, 3, {y:-20});
			TweenLite.to(itemDetail, .4, {y:innerFill.height + padding});
		}
		
		private function onOut(event:MouseEvent):void
		{
			TweenLite.to(outerFill, .2, {alpha:1});
			TweenLite.to(loader, .4, {y:padding, ease:Quint.easeOut});
			TweenLite.to(itemDetail, .2, {y:itemDetailYpos, ease:Quint.easeOut});
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
		
		public function get id() : Number
		{
			return _id;
		}
		
		public function set id(value:Number) : void
		{
			_id = value;
		}
		
		public function get link():String
		{
			return _link;
		}
		
		public function set link(value:String):void
		{
			_link = value;
		}
		
		public function get title():String
		{
			return _title;
		}
		
		public function set title(value:String):void
		{
			_title = value;
		}
		
		public function get role():String
		{
			return _role;
		}
		
		public function set role(value:String):void
		{
			_role = value;
		}
		
		public function get technolgy():String
		{
			return _technology;
		}
		
		public function set technology(value:String):void
		{
			_technology = value;
		}
		
		public function get imageURL():String
		{
			return _imageURL;
		}
		
		public function set imageURL(value:String):void
		{
			_imageURL = value;
			loader.load(new URLRequest(_imageURL));
		}
		
		public function get originX():Number
		{
			return _originX;
		}
		
		public function set originX(value:Number):void
		{
			_originX = value;
		}
		
		public function get originY():Number
		{
			return _originY;
		}
		
		public function set originY(value:Number):void
		{
			_originY = value;
		}
	}
}