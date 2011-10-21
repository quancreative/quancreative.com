package 
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;

	import com.quancreative.main.views.PreloaderClip;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.StyleSheet;

	public class Preloader extends MovieClip 
	{
		private var clip : PreloaderClip;
		private var bulkLoader : BulkLoader = new BulkLoader("main");
		
		public function Preloader()
		{
			super();
			
			clip = new PreloaderClip();
			
			bulkLoader.addEventListener(BulkLoader.COMPLETE, onAllItemsLoaded);
            bulkLoader.addEventListener(BulkLoader.PROGRESS, onAllItemsProgress);
            
			addChild(clip);
		}
		
//		override public function update(event : Event = null) : void
//		{
//			var priorityIndex : int = 1;
//			
//			if (!model.isGlobalAssetsLoaded)
//			{
//				var globalAssetsList : XMLList = model.globalAssetsList;
//				
//				for (var i : int = 0; i < globalAssetsList.length(); i ++)
//				{
//					var myId : String = globalAssetsList[i].@id;
//					var mySrc : String = globalAssetsList[i].@src;
//					
//					bulkLoader.add(mySrc, {priority : priorityIndex, id : myId});
//					
//					priorityIndex ++;
//				}
//			}
//			
//			var currentPageData : PageData = model.currentPageData;
//			
//			bulkLoader.add(currentPageData.src, {id : currentPageData.id});
//			
//			start();
//		}
//		
		public function start() : void
		{
			clip.addEventListener(Event.INIT, clipInit);
			clip.addEventListener(Event.COMPLETE, clipComplete);
			clip.animateIn();
		}

		private function clipInit(event : Event) : void
		{	
			bulkLoader.start();
		}

		private function onAllItemsProgress(event : BulkProgressEvent) : void 
		{
			//trace(event.loadingStatus());
			var percent : int = event.weightPercent * 100;				
			//trace('Item loaded: ' + event.itemsLoaded + " of " + event.itemsTotal);
			
			clip.updateProgress(percent);
		}

		private function onAllItemsLoaded(event : Event) : void 
		{
			// TODO Oddy: Once removed, listener won't work if add it again
			//bulkLoader.removeEventListener(BulkLoader.COMPLETE, onAllItemsLoaded);
			//bulkLoader.removeEventListener(BulkLoader.PROGRESS, onAllItemsProgress);
			
			parseItems(bulkLoader, bulkLoader.items);
			
			clip.setComplete();
		}

		private function parseItems(bLoader : BulkLoader, loadedItems : Array) : void 
		{
			var loader : BulkLoader = bLoader;
			var myLoadedItems : Array = loadedItems;
			
			for (var i : int = 0; i < myLoadedItems.length; i++) 
			{
				var myBulkItem : Object = myLoadedItems[i];
				var myId : String = myBulkItem.id;
				
				var myItem : Object = {
					id : myId,
					info : myBulkItem,
					content : null
				};
				
				switch (myBulkItem.type)
				{
					case "text"  :
						var myCSS : StyleSheet = new StyleSheet();
						myCSS.parseCSS(loader.getText(myId));
						
						myItem.content = myCSS;
						
						break;
						
					case "movieclip"  :
						var myMovie : MovieClip = loader.getMovieClip(myId);
						//trace('_____myMovie: ' + (myMovie));
						
						myItem.content = myMovie;
						
						break;
				}
				//sharedAssets.addItem(myId, myItem);
			} // end for()
		}
		
		private function clipComplete(event : Event) : void
		{
			clip.removeEventListener(Event.INIT, clipInit);
			clip.removeEventListener(Event.COMPLETE, clipComplete);
			
//				
//			var globalAssets : GlobalAssets = GlobalAssets.getInstance();
//			var globalAssetsList : XMLList = model.globalAssetsList;
//			
//			for (var i : int = 0; i < globalAssetsList.length(); i ++)
//			{
//				var myId = globalAssetsList[i].@id;
//				var mySrc = globalAssetsList[i].@src;
//				
//				switch (myId)
//				{
//					case "css" :
//						var myCSS : StyleSheet = new StyleSheet();
//						myCSS.parseCSS(bulkLoader.getText(myId));
//						globalAssets.css = myCSS;
//						break;
//						
//					case "font"  :
//						globalAssets.fontLib = bulkLoader.getMovieClip(myId);
//						break;
//				}
//			}
//		
//			var currentPageData : PageData = model.currentPageData;
//			
//			currentPageData.isLoaded = true;
//			currentPageData.swf = bulkLoader.getMovieClip(currentPageData.id);
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function removeItem(id : String) : void 
		{
			var myId : String = id;
			
			if (bulkLoader.hasItem(myId))
			{
				//trace("Bulkloader has the item with an ID = " + myId);
				bulkLoader.remove(myId);	
			}
			else
			{
				//trace("Bulkloader has no such item");	
			}
		}

		public function getMovie(id : String) : MovieClip 
		{
			return bulkLoader.getMovieClip(id);	
		}

		public function load(aList : XMLList) : void 
		{
			var priorityIndex : int = 1;
			
			var globalAssetsList : XMLList = aList;
			
			for (var i : int = 0; i < globalAssetsList.length(); i ++)
			{
				var myId : String = globalAssetsList[i].@id;
				var mySrc : String = globalAssetsList[i].@src;
				
				bulkLoader.add(mySrc, {priority : priorityIndex, id : myId});
				
				priorityIndex ++;
			}
			
			start();
		}
	}
}
