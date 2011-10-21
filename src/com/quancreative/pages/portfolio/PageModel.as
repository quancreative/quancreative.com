package com.quancreative.pages.portfolio
{
	import qhn.events.AnimationEvent;

	import com.quancreative.pages.portfolio.model.PageData;

	import flash.events.*;
	import flash.net.*;

	public class PageModel extends EventDispatcher
	{
		protected var loader:URLLoader;	
		
		private var xml : XML;
		public var currentPage:Object;
		public var currentFile:String;
		//public var activeNav:Nav;
		public var currentIndex:int;
		public var previousIndex:int;
		
		public var currentProject:Project;
		
		public var totalItems:int;
		public var previousPage:String;
		
		public var itemArray:Array;
		
		private var _totalPage : int;
		private var _pages : Array = new Array();
		private var _currentPageData : PageData;
		
		public function PageModel(target : IEventDispatcher = null)
		{
			super(target);			
		}
		
		public function load(req:URLRequest) : void
		{
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loaderCompleted);
			loader.load(req);
		}
		
		private function loaderCompleted(event:Event):void
		{
			loader.removeEventListener(Event.COMPLETE, loaderCompleted);
			
			try 
			{	
				parseXML(new XML(loader.data));				
			} 
			catch (error:TypeError) 
			{
				// If we get here, that means the downloaded text could
				// not be converted into an XML instance, probably because 
				// it is not formatted correctly.
				trace("Could not parse text into XML", this);
				trace(error.message, this);
			}
		}
		
		public function parseXML(aXML : XML) : void
		{
			xml = aXML;
			
			var projectList : XMLList = xml.interactive;
			_totalPage = projectList.length();
			
			for (var i : int = 0; i < _totalPage; i++)
			{
				var projectData : PageData = new PageData();
				projectData.image = projectList[i].@image;
				projectData.link = projectList[i].@link;
				projectData.name = projectList[i].@name;
				projectData.role = projectList[i].@role;
				projectData.technology = projectList[i].@technology;
				
				_pages[projectData.name] = projectData;
				_pages.push(projectData); // by index
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function gotoPage(pg : Object) : void
		{
			_currentPageData = pages[pg];
			currentPage = pg;
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function transitionOut() : void 
		{
			dispatchEvent(new AnimationEvent(AnimationEvent.TRANSITION_OUT));
		}
		
		public function get pages() : Array { return _pages; }
		
		public function get totalPage() : int { return _totalPage; }
		
		public function get currentPageData() : PageData { return _currentPageData; }
		
		public function get bkgdURL() : String { return xml.@bkgd; }
	}
} 