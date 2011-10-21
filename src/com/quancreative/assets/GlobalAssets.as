package com.quancreative.assets 
{
	import flash.display.MovieClip;
	import flash.text.StyleSheet;
	import flash.events.EventDispatcher;

	/**
	 * @author qngo
	 */
	public class GlobalAssets extends EventDispatcher
	{
		static private var instance : GlobalAssets;
		
		private var assets : Array;
		private var _isLoaded : Boolean;
		private var _css : StyleSheet;
		private var _fontLib : MovieClip;
		
		public function GlobalAssets (pvt : PrivateClass)
		{	
			super();
			
			trace("GlobalAssets : Instantiated! ", pvt);
		}
		
		public static function getInstance() : GlobalAssets
		{	
			if (GlobalAssets.instance == null) GlobalAssets.instance = new GlobalAssets(new PrivateClass());
				
			return GlobalAssets.instance;
		}
		
		public function add(asset : AssetData) : void
		{
			assets.push(asset);
		}
		
		public function get css() : StyleSheet { return new StyleSheet(); }
		
		public function set css(value : StyleSheet) : void { _css = value; }
		
		public function get isLoaded() : Boolean { return _isLoaded; }
		
		public function set isLoaded(value : Boolean) : void { _isLoaded = value; }
		
		public function set fontLib(value : MovieClip) : void { _fontLib = value; }
	}
}

/**
 * @author qngo
 */
class PrivateClass
{
	public function PrivateClass()
	{
		//trace("Private Class");
	}
}