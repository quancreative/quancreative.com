package com.quancreative.pages.home.model 
{
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * @author qngo
	 */
	public class HomePageModel extends EventDispatcher 
	{
		public var slideshowXML : XML;
		
		private var urlLoader : URLLoader;
		private var xml : XML;
		
		public var transitionState : String;
		
		public function HomePageModel(target : IEventDispatcher = null)
		{
			super(target);
			
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, onUrlLoaderComplete);
		}
		
		public function load(urlRequest : URLRequest) : void
		{
			urlLoader.load(urlRequest);
		}
		
		private function onUrlLoaderComplete(event : Event) : void 
		{
			urlLoader.removeEventListener(Event.COMPLETE, onUrlLoaderComplete);
			
			var myXml : XML = new XML(event.target.data);
			parseXML(myXml);
		}
		
		public function parseXML(data : XML) : void 
		{
			xml = data;
			slideshowXML = new XML(xml.slideshow);
			
			dispatchEvent(new Event(Event.COMPLETE));
		}

		public function changeState(state : String) : void 
		{
			transitionState = state;
			dispatchEvent(new Event(Event.CHANGE));
		}
	}
}
