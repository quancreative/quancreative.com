package com.quancreative.main.model 
{
	import com.quancreative.core.SiteSWFAddress;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * @author qngo
	 */
	public class MainModel extends EventDispatcher 
	{
		private var urlLoader : URLLoader;
		private var xml : XML;
		
		private var _pages : Array = new Array();
		private var _totalPage : int;
		private var _currentPageData : PageData;
		
		private var _globalAssetsList : XMLList;
		
		private var _portfolioXML 	: XML;
		private var _homeXML 		: XML;
		
		private var pendingPage : Object;
		
		public var state : String = "preloading";
		
		public function MainModel(target : IEventDispatcher = null)
		{
			super(target);
		}
		
		public function load(urlRequest : URLRequest) : void 
		{
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, onUrlLoaderComplete);
			urlLoader.load(urlRequest);
		}
		
		public function gotoPage(pg : Object) : void 
		{
			_currentPageData = pages[pg];
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		private function onUrlLoaderComplete(event : Event) : void 
		{
			urlLoader.removeEventListener(Event.COMPLETE, onUrlLoaderComplete);
			
			var myXml : XML = XML(event.target.data);
			parseXml(myXml);
		}
		
		private function parseXml(aXML : XML) : void 
		{
			xml = aXML;
			
			var pageList : XMLList = xml.pages.page;
			_totalPage = pageList.length();
			
			for (var i : int = 0; i < _totalPage; i++)
			{
				var pageData : PageData = new PageData();
				pageData.id = pageList[i].@id;
				pageData.src = pageList[i].@src;
				pageData.xml = new XML(pageList[i]);
				pageData.pageNum = i + 1;
				
				_pages[pageData.id] = pageData; // by id
				_pages.push(pageData); // by index
			}
			
			_globalAssetsList = xml.global_assets.asset;
			
			_portfolioXML	= new XML(xml.pages.page.(@id == "portfolio"));
			_homeXML 		= new XML(xml.pages.page.(@id == "home"));
			
			SiteSWFAddress.instance.addEventListener(SiteSWFAddress.SWFADDRESS_CHANGE, swfAddressChange);
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function swfAddressChange(event : Event = null):void
		{
//			Debug.log('SiteSWFAddress.getValue(): ' + (SiteSWFAddress.getValue()));
			if (!SiteSWFAddress.getValue())
				gotoPage(0); // home page
			else
				gotoPage(SiteSWFAddress.getValue());
		}
		
		//public function get pages() : Vector.<PageData> { return _pages; }
		public function get pages() : Array { return _pages; }
		
		public function get totalPage() : int { return _totalPage; }
		
		public function get currentPageData() : PageData { return _currentPageData; }
		
		public function get globalAssetsList() : XMLList { return _globalAssetsList; }
		
		public function get homeXML() : XML  { return _homeXML; }

		public function preloadComplete() : void 
		{
			state = "pageFlipping";
			 
			SiteSWFAddress.gotoPage('home');
		}

		public function preload() : void 
		{
			dispatchEvent(new Event("PRELOAD"));
		}
	}
}
