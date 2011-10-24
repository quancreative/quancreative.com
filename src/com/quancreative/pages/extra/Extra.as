package com.quancreative.pages.extra
{
	import com.greensock.TweenLite;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.quancreative.model.AppModel;

	import flash.display.*;
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	//import SWFAddress;
	public class Extra extends MovieClip
	{
		private var xmlList:XMLList;
			
		private var index:uint = 0;		
		private var scrollbox:Scrollbox = new Scrollbox();		
		private var projectYpos:int = 0;
		
		public function Extra()
		{
			visible = false;
			alpha = 1;
			
			TweenPlugin.activate([AutoAlphaPlugin]);
			
//			scrollbox.x = ISite.containerX;
			addChild(scrollbox);
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, xmlLoaded);
			xmlLoader.load(new URLRequest(AppModel.getInstance().swfPath + "xml/extra.xml"));
		}
		
		public function transitionIn():void
		{
			//scrollbox.visible = true;
			//TweenLite.to(scrollbox, 1, {x:Root.mainContentX, ease:Quint.easeInOut, delay:0.15});
			TweenLite.to(this, .75, {autoAlpha: 1, delay: 1});
			
			genProject();
		}
		
		public function transitionOut():void
		{
			TweenLite.to(this, 1, {autoAlpha: 0});
		}
		
		private function xmlLoaded(event:Event):void{
			try {
				// Convert the downlaoded text into an XML instance
				var xml:XML = new XML(event.target.data);
				
				parseXml(xml);
				
			} catch (error:TypeError) {
				// If we get here, that means the downloaded text could
				// not be converted into an XML instance, probably because 
				// it is not formatted correctly.
				trace("Could not parse text into XML");
				trace(error.message);
			}						
		}	
		
		private function parseXml(xml:XML):void{
			var portfolio:XML = new XML(xml.webpages.webpage.(@id == "portfolio"));
			//var interactive:XMLList = new XMLList(portfolio.works.interactive);
			xmlList = portfolio.works.interactive;
			//xmlList = interactive.@image;
			
			// If this is running outside of the host swf.
			if (AppModel.getInstance().isStandAlone) transitionIn();
		}
		
		private function genProject() : void
		{
			if(index < xmlList.length())
			{
				addProject(index);				
			}
			else
			{
				scrollbox.contentContainer.cacheAsBitmap = true;
				return;
			}			
		}
		
		private function addProject(num:uint):void
		{
			var imageURL : String = AppModel.getInstance().swfPath + xmlList[num].attribute("image");
			var pURL:URLRequest = new URLRequest(imageURL);			
			var pLink:String = xmlList[num].attribute("link");
			var pTitle:String = xmlList[num].attribute("name");
			var pRole:String = xmlList[num].attribute("role");
			var pTech:String = xmlList[num].attribute("technology");
			
			var project:Project = new Project(pURL,pLink, pTitle, pRole, pTech);			
			project.addEventListener(ProjectEvent.CREATE_COMPLETE, projectCreated);
			project.y = projectYpos;
			projectYpos += 500;
			
			scrollbox.contentContainer.addChild(project);
			
			index ++;			
		}
		
		private function projectCreated(event:ProjectEvent):void{
			genProject();
		}
	}
}


