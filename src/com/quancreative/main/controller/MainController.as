package com.quancreative.main.controller 
{
	import com.quancreative.main.model.MainModel;

	/**
	 * @author qngo
	 */
	public class MainController 
	{
		private var model : MainModel;
		
		public function MainController(m : MainModel)
		{
			model = m;	
		}
		
		public function gotoPage(pg : Object) : void
		{
			model.gotoPage(pg);
//			
//			if (isNaN(Number(pg)))
//			{
//				var page : String = String(pg).toLocaleLowerCase();
//				var myPageData : PageData = model.currentPageData;	
//				if (myPageData)
//				{
//					if (page != myPageData.id)
//					//else 
//						//Debug.log("You're already on the page" + this);
//				}
//				else
//				{
//					model.gotoPage(page);
//				}
//			}
		}

		public function preloadComplete() : void 
		{
			model.preloadComplete();
		}

		public function init() : void 
		{
			model.preload();
		}
	}
}
