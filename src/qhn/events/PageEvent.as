package qhn.events 
{
	import flash.events.Event;

	/**
	 * @author qngo
	 */
	public class PageEvent extends Event 
	{
		public static const PAGE_COMPLETE : String = "pageComplete";
		public static const PAGE_END : String = "pageEnd";
		public static const PAGE_CHANGE : String = "pageChange";
		
		public var data : Object;
		
		public function PageEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false, data : Object = null)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
	}
}
