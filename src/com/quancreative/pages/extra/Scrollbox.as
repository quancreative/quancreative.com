package com.quancreative.pages.extra
{
	import com.greensock.TweenLite;
	import com.quancreative.Root;

	import flash.display.*;

	public class Scrollbox extends MovieClip
	{
		public var contentContainer : MovieClip;
		public var scrollbar	: MovieClip;
		
		private var masker : MovieClip;
		
		public function Scrollbox()
		{
			contentContainer = MovieClip(getChildByName("contentContainer_mc"));
			scrollbar = MovieClip(getChildByName("scrollbar_mc"));
			masker = MovieClip(getChildByName("masker_mc"));
			
			if(Root.mainContentHeight != 0){
				masker.height = Root.mainContentHeight;
			}
			
			scrollbar.addEventListener(ScrollbarEvent.VALUE_CHANGED, scrollboxChanged);
		}	

		private function scrollboxChanged(event:ScrollbarEvent) : void
		{
			TweenLite.to(contentContainer, .5, {y:(-event.scrollPercent * (contentContainer.height - masker.height))});
		}
	}
}


