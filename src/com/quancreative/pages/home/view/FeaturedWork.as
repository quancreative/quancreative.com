package com.quancreative.pages.home.view 
{
	import br.com.stimuli.loading.BulkLoader;

	import qhn.utils.Library;

	import com.greensock.TweenLite;
	import com.greensock.easing.Quint;

	import flash.display.*;
	import flash.events.*;

	public class FeaturedWork extends MovieClip 
	{	
		private var slideshow : Slideshow; 
		private var imageList : XMLList;
		
		private var description : MovieClip;
		private var featureLabel: MovieClip;
		private var holder 		: MovieClip;
		private var bkgd 		: MovieClip;
		private var holderMask 	: MovieClip;
		
		public function FeaturedWork() 
		{
			var assets : MovieClip = BulkLoader.getLoader("main").getMovieClip("assets");
			
			holderMask = MovieClip(Library.createAsset(assets, "FeaturedWorkMask"));
			holderMask.gotoAndStop(1);
			holderMask.addEventListener(Event.COMPLETE, onMaskComplete);
				
			holder = MovieClip(getChildByName("holder_mc"));
			holder.addChild(holderMask);
			
			featureLabel = MovieClip(getChildByName("featureLabel_mc"));
			
			description = MovieClip(getChildByName("description_mc"));
			
			bkgd = MovieClip(getChildByName("bkgd_mc"));
		}
		
		private function init() : void
		{
			featureLabel.alpha = 0;
			description.alpha = 0;
			description.descriptionText.text = "";
			bkgd.height = 0;
			bkgd.alpha = 0;
		}

		private function onMaskComplete(event : Event) : void 
		{
			//var bitmap : Bitmap = slideshow.currentImage;
			var text : String = imageList[slideshow.currentIndexNum].@name;
			description.descriptionText.text = text;
			
//			TweenLite.to(featureLabel, .4, {alpha : 1});
			featureLabel.alpha = 1;
			featureLabel.gotoAndPlay("IN");
			TweenLite.to(description, .4, {alpha : 1, delay : .4});
		}

		private function onSlideShowChange(event : Event) : void 
		{
			holder.mask = holderMask;
			holderMask.gotoAndPlay("IN");
		}

		public function startSlideshow(xml : XML) : void 
		{
			holderMask.gotoAndStop(1);
			imageList = xml.clip;
			init();
			TweenLite.to(bkgd, 1, {height : 279, alpha : 1, ease:Quint.easeOut});
			
			initSlideshow();
		}
		
		private function initSlideshow() : void
		{
			if (!slideshow)
			{
				slideshow = new Slideshow(holder, imageList);
				slideshow.addEventListener(Event.CHANGE, onSlideShowChange);
			}
			slideshow.startSlideshow();
		}
		
		public function reset() : void
		{
			if (featureLabel.currentLabel == "IN")
				featureLabel.gotoAndPlay("OUT");
				
			holderMask.gotoAndStop(1);
			
			init();
		}
		
		override public function stop() : void
		{
			if (featureLabel.currentLabel == "IN")
				featureLabel.gotoAndPlay("OUT");
				
			TweenLite.to(bkgd, .3, {height : 0, alpha : 0, ease:Quint.easeIn, onComplete : init});
			TweenLite.to(description, .2, {alpha : 0});
			holderMask.gotoAndStop(1);
			super.stop();
		}
	}
}

