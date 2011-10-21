package qhn.utils 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.media.Sound;

	/**
	 * @author qngo
	 */
	public class Library 
	{
		public static function createAsset(mc : MovieClip, className : String) :  DisplayObject
		{
			var c : Class = Class(mc.loaderInfo.applicationDomain.getDefinition(className));
			return new c();
		}

		public static function createSound(mc : MovieClip, className : String) : Sound
		{
			var c : Class = Class(mc.loaderInfo.applicationDomain.getDefinition(className));
			return new c();			
		}
	}
}
