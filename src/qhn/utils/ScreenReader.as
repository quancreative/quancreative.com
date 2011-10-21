package qhn.utils 
{
	import flash.accessibility.Accessibility;
	import flash.accessibility.AccessibilityProperties;
	import flash.display.DisplayObject;

	/**
	 * @author qngo
	 */
	public class ScreenReader 
	{
		public static function add(display : DisplayObject, name : String, desc : String, disableChildren : Boolean = false) : void
		{
			var myDisplay : DisplayObject = display;
			
			var accessProps:AccessibilityProperties = new AccessibilityProperties();
			accessProps.name = name;
			accessProps.description = desc;
			
			if (disableChildren)
			{
				//accessProps.silent = true;
				accessProps.forceSimple = true;
			}
			 
			myDisplay.accessibilityProperties = accessProps;
			
			if (Accessibility.active) Accessibility.updateProperties();
		}
	}
}
