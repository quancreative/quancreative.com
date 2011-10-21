
package com.quancreative.pages.portfolio
{

	public class PageController {
		
		private var model : PageModel;
		
		public function PageController(m:PageModel)
		{
			model = m;
		}

		public function gotoPage(pg : Object) : void 
		{
			model.gotoPage(pg);
		}

		public function transitionOut() : void 
		{
			model.transitionOut();
		}
	}
}
