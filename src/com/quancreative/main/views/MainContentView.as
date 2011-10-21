package com.quancreative.main.views 
{
	import qhn.mvc.view.CompositeView;

	import com.quancreative.main.controller.MainController;
	import com.quancreative.main.model.MainModel;

	import flash.events.Event;

	/**
	 * @author qngo
	 */
	public class MainContentView extends CompositeView 
	{
		private var headerView : HeaderView;
		private var paginationView : PaginationView;
		
		public function MainContentView(aModel : MainModel, aController : MainController = null)
		{
			super(aModel, aController);
			
			headerView = new HeaderView(aModel, aController);
			paginationView = new PaginationView(aModel, aController);
			paginationView.y = 141;
			
			add(headerView);
			add(paginationView);
			
			addChild(paginationView);
			addChild(headerView);
		}
		
		override public function update(event : Event = null) : void
		{
			super.update(event);
		}
	}
}
