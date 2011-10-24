package com.quancreative.pages.extra
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Quint;
	import com.quancreative.Root;

	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;

	public class Project extends Sprite{
		
		private static const padding:uint = Root.containerPadding;
		
		private static const boxWidth:uint = 829;
		private static const boxHeight:uint = 391;
		
		private var imageURL:URLRequest;
		private var link:String;
		private var title:String;
		private var role:String;
		private var technology:String;
		
		private var cover:Shape;
		private var imageHolder:Sprite = new Sprite();
		
		private var preloader:TextField = new TextField();
		
		public function Project(imgURL:URLRequest, href:String, pTitle:String, pRole:String, pTech:String){
			
			imageURL = imgURL;
			link = href;
			title = pTitle;
			role = pRole;
			technology = pTech;
			
			imageHolder.visible = false;		
						
			var holderFill:Shape = createShape(boxWidth, boxHeight, 0x111111);			
			holderFill.alpha = 0.6;
			
			cover = createShape(boxWidth, boxHeight, 0x000000);
			cover.height = 27;
			
			var format:TextFormat = new TextFormat();
			format.size = 20;
			format.font = new VistaSans().fontName;
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
		
		private function createHolder():void{		
			
			var yPos:int = Root.mainContentHeight;
			
			TweenLite.from(cover, 1, {y:yPos, ease:Quint.easeOut, overwrite:false, onComplete:moveYFinished});
			
			function moveYFinished():void{
								
				TweenLite.to(cover, .5, {height:boxHeight, ease:Quint.easeOut, delay:.25, onComplete:heightenFinished});
			}
						
			function heightenFinished():void{
				// let imageHolder hides behide the cover
				imageHolder.visible = true;
				
				loadImage();
			}
		}
		
		private function loadImage():void{
			var imageLoader:Loader = new Loader();			
			imageLoader.contentLoaderInfo.addEventListener(Event.OPEN, imageOpened);
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded);
			imageLoader.load(imageURL);
			imageLoader.x = padding;
			imageLoader.y = padding;
			
			imageHolder.addChild(imageLoader);
			imageHolder.addEventListener(MouseEvent.MOUSE_UP, onUp);
			imageHolder.buttonMode = true;
		}
		
		private function onUp(event:MouseEvent):void{
			var myLink:String = "http://" + link;
			var urlRequest:URLRequest = new URLRequest(myLink);
			
			try	{				
				navigateToURL(urlRequest, '_self');			
				
			} catch (error:Error){
				
			}

			
		}
		
		private function imageOpened(event:Event):void{			
			preloader.visible = true;
		}
		
		private function imageLoaded(event:Event):void{			
			preloader.visible = false;			
			removeChild(preloader);
			
			TweenLite.to(cover, 1, {height:0, y:boxHeight, ease:Quint.easeOut, delay:.25, onComplete:shrinkFinished});
			
			function shrinkFinished():void{
				removeChild(cover);				
			}
			
			createTextHolder();
		}
		
		private function createTextHolder():void{
			// projectDetails is found in the library
			var projectDetails:ProjectDetails = new ProjectDetails();
			projectDetails.y = imageHolder.height + Root.borderSize;
			projectDetails.titleTxt.htmlText = "<p>" + title +" / <a href='http://"+link+"'>"+link +"</a></p>";
			projectDetails.role.text = role;
			projectDetails.technology.text = technology;
			
			addChild(projectDetails);
			TweenLite.from(projectDetails, 1, {alpha:0, ease:Quint.easeOut, delay:1});
			
			dispatchEvt();
		}
		
		private function dispatchEvt():void{
			dispatchEvent(new ProjectEvent());
		}
		
		private function createShape(sWidth:int, sHeight:int, sBkgdColor:uint):Shape{
			var shape:Shape = new Shape();
			shape.graphics.beginFill(sBkgdColor);
			shape.graphics.lineStyle();
			shape.graphics.drawRect(0, 0, sWidth, sHeight);
			shape.graphics.endFill();
			
			return shape;
		}		
	}
}

