package qhn.mvc.view 
{
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;

	/**
	 * @author qngo
	 */
	// ABSTRACT Class (should be subclassed and not instantiated);
	public class ComponentView extends Sprite
	{
		protected var model : Object;
		protected var controller : Object;
		
		public function ComponentView(model : Object, controller : Object = null)
		{
			this.model = model;
			this.controller = controller;
		}
		
		public function add(c : ComponentView) : void
		{
			throw new IllegalOperationError("add operation not supported");
		}
		
		public function remove(c : ComponentView) : void
		{
			throw new IllegalOperationError("remove operation not supported");
		}
		
		public function getChild(num : int) : ComponentView
		{
			throw new IllegalOperationError("getChild operation not supported");
			
			return null;
		}
		
		// ABSTRACT Method (must be overridden in a subclass)
		public function update(event : Event = null) : void	
		{
		}		
	}
}
