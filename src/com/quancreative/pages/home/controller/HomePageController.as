
package com.quancreative.pages.home.controller 
{
	import com.quancreative.pages.home.model.HomePageModel;

	/**
	 * @author qngo
	 */
	public class HomePageController 
	{
		private var model : HomePageModel;
		
		public function HomePageController(m : HomePageModel)
		{
			model = m;	
		}
		public function transitionIn() : void 
		{
			if (model.transitionState == null || model.transitionState == "transitionOutComplete")
				model.changeState("transitionIn");
		}
		
		public function transitionOut() : void 
		{
			if (model.transitionState == "transitionIn")
				model.changeState("transitionOut");
		}

		public function changeState(state : String) : void 
		{
			model.changeState(state);
		}
	}
}
