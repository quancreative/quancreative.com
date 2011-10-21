package qhn.mvc.view 
{
	import flash.events.Event;

	/**
	 * @author qngo
	 */
	// ABSTRACT Class (should be subclassed and not instantiated)
	public class CompositeView extends ComponentView 
	{
		private var childrenArray : Array;
		
		public function CompositeView(model : Object, controller : Object = null)
		{
			super(model, controller);
			
			childrenArray = new Array();
		}
		
		override public function add(c : ComponentView) : void
		{
			childrenArray.push(c);
		}
		
		override public function remove(c : ComponentView) : void
		{
			for (var i : int = 0; i < childrenArray.length; i++)
			{
				if (childrenArray[i] == c)
				{	
					childrenArray.splice(i, 1);
					break;
				}
			}
		}

		override public function update(event : Event = null) : void
		{
			for each (var c : ComponentView in childrenArray)
			{
				c.update(event);
			}
		}
	}
}
