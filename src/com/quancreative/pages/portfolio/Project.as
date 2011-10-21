package com.quancreative.pages.portfolio
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Quint;
	import com.quancreative.api.ISite;

	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;

	public class Project extends Sprite
	{
		private static const padding:uint = ISite.containerPadding;
		
		public var boxWidth:uint = 829;
		public var boxHeight:uint = 391;
		
		private var _item:Item;
		
		private var cover:Shape;
		private var imageHolder:Sprite = new Sprite();
		
		private var preloader:TextField = new TextField();
		
		//private var projectDetails : ProjectDetails;
		
		public function Project()
		{
			
		}
		
		public function set item(value:Item):void
		{
			_item = value;
		}
		
		public function get item():Item
		{
			return _item;
		}
		
		public function load():void
		{
			imageHolder.visible = false;		
						
			var holderFill:Shape = createShape(boxWidth, boxHeight, 0x111111);			
			holderFill.alpha = 0.6;
			
			cover = createShape(boxWidth, boxHeight, 0x000000);
			cover.height = 27;
			
			var format:TextFormat = new TextFormat();
			format.size = 20;
			//format.font = new VistaSans().fontName;
			format.color = 0xFFFFFF; 
			format.align = 'center';

			preloader.embedFonts = true;
			preloader.defaultTextFormat = format;
			preloader.antiAliasType = AntiAliasType.ADVANCED;
			preloader.text = "loading";
			preloader.height = preloader.textHeight;
			preloader.x = Math.round( (boxWidth - preloader.width) / 2);
			preloader.y = Math.round( (boxHeight - preloader.height) / 2);
			preloader.selectable = false;
			preloader.visible = false;
			
			imageHolder.addChild(holderFill);
			addChild(imageHolder);			
			addChild(cover);
			addChild(preloader);
			
			createHolder();
		}
		
		private function createHolder():void
		{
			
			var yPos:int = ISite.mainContentHeight;
			
			TweenLite.from(cover, 1, {y:yPos, ease:Quint.easeOut, overwrite:false, onComplete:moveYFinished});
			
			function moveYFinished():void
			{
								
				TweenLite.to(cover, .5, {height:boxHeight, ease:Quint.easeOut, delay:.25, onComplete:heightenFinished});
			}
						
			function heightenFinished():void
			{
				// let imageHolder hides behide the cover
				imageHolder.visible = true;
				
				loadImage();
			}
		}
		
		private function loadImage():void
		{
			var imageLoader:Loader = new Loader();			
			imageLoader.contentLoaderInfo.addEventListener(Event.OPEN, imageOpened);
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded);
			imageLoader.load(new URLRequest(item.imageURL));
			imageLoader.x = padding;
			imageLoader.y = padding;
			
			imageHolder.addChild(imageLoader);
			
			//imageHolder.addEventListener(MouseEvent.MOUSE_UP, onUp);
			imageHolder.buttonMode = true;
		}
		
		private function onUp(event:MouseEvent):void{
			var myLink:String = "http://" + item.link;
			var urlRequest:URLRequest = new URLRequest(myLink);
			
			try	{				
				navigateToURL(urlRequest, '_self');
			} 
			catch (error:Error)
			{
				trace('error @ Project.as > private function onUp');
			}
		}
		
		private function imageOpened(event:Event):void
		{			
			preloader.visible = true;
		}
		
		private function imageLoaded(event:Event):void
		{
			preloader.visible = false;			
			removeChild(preloader);
			
			TweenLite.to(cover, 1, {height:0, y:boxHeight, ease:Quint.easeOut, delay:.25, onComplete:shrinkFinished});
			
			function shrinkFinished():void{
				removeChild(cover);	
				createTextHolder();
			}
		}
		
		private function createTextHolder():void
		{
			// projectDetails is found in the library
			
//			projectDetails = new ProjectDetails();
//			projectDetails.stop();
//			projectDetails.y = imageHolder.height + ISite.borderSize;
//			projectDetails.title_mc.titleTxt.htmlText = "<p><a href='http://" + item.link + "'>" + item.title + "</a></p>";
//			projectDetails.detail_mc.role.text = item.role;			
//			projectDetails.addEventListener("DETAIL_IN_COMPLETE", onDetailInComplete);
//			
//			addChild(projectDetails);
//			projectDetails.gotoAndPlay("IN");
		}
		
		private function onDetailInComplete(event:Event):void
		{
			event.target.removeEventListener("DETAIL_IN_COMPLETE", onDetailInComplete);
			
//			var closeBox:CloseBox = new CloseBox();
//			var closeBoxWidth:int = 24;
//			closeBox.x = imageHolder.width - closeBoxWidth + padding - 2;
//			closeBox.y = -4;
//			//closeBox.gotoAndPlay("IN");
//			closeBox.buttonMode = true;
//			closeBox.mouseChildren = false;
//			closeBox.addEventListener(MouseEvent.MOUSE_DOWN, onCloseDown);
//			
//			addChild(closeBox);
//			
//			closeBox.gotoAndPlay("IN");
//			dispatchEvt();
		}
		
		private function onCloseDown(event:MouseEvent):void
		{
			event.target.addEventListener("CLOSE_OUT_COMPLETE", onCloseOutComplete);
			event.target.gotoAndPlay("OUT");			
		}
		
		private function onCloseOutComplete(event:Event):void
		{
			event.target.removeEventListener("CLOSE_OUT_COMPLETE", onCloseOutComplete);
			
//			projectDetails.addEventListener("DETAIL_OUT_COMPLETE", onDetailOutComplete);
//			projectDetails.gotoAndPlay("OUT");
		}
		
		private function onDetailOutComplete(event:Event):void
		{
			event.target.removeEventListener("DETAIL_OUT_COMPLETE", onDetailOutComplete);
			transitionOut();
		}
		
		private function transitionOut():void
		{
			TweenLite.to(this, .5,{alpha:0, onComplete:onTransitionOutComplete});
		}
		
		private function onTransitionOutComplete():void
		{
			PageHQ.instance.projectOut();
		}
		
		private function dispatchEvt():void
		{
			dispatchEvent(new ProjectEvent());
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
	}
}

