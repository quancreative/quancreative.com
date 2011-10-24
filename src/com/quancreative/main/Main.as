////////////////////////////////////////////////////////////////////////////////
//
//  QuanCreative
//  Copyright 2010
//  All Rights Reserved.
//
//  NOTICE: QuanCreative permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it. haha.. whatever
//
////////////////////////////////////////////////////////////////////////////////
package com.quancreative.main
{
	import com.quancreative.core.SiteContextMenu;
	import com.quancreative.core.SiteSWFAddress;
	import com.quancreative.main.controller.MainController;
	import com.quancreative.main.model.MainModel;
	import com.quancreative.main.model.PageData;
	import com.quancreative.main.views.MainView;
	import com.quancreative.model.AppModel;

	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;

	/**
	 * @author qngo
	 */
	public class Main extends MovieClip 
	{
		private var model : MainModel;
		private var view : MainView;
		private var controller : MainController;
		
		public var stageWidth : Number;
		public var stageHeight : Number;
		
		public function Main()
		{
			super();
			
			if (stage) 
				onAddedToStage();
			else
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event : Event = null) : void 
		{
			if(event) removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			SiteSWFAddress.birth(stage.loaderInfo.parameters.branch);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align     = StageAlign.TOP_LEFT;
			
			stageWidth = stage.stageWidth;
			stageHeight = stage.stageHeight;
			
			AppModel.getInstance().isStandAlone = false;
								
			// adding the model
			model = new MainModel();
			model.addEventListener(Event.COMPLETE, onModelComplete);
			model.addEventListener(Event.CHANGE, onModelChange);
			model.load(new URLRequest("xml/site.xml"));
		}

		private function onModelComplete(event : Event) : void
		{
			model.removeEventListener(Event.COMPLETE, onModelComplete);
			
			controller = new MainController(model);
			
			view = new MainView(model, controller);
			
			addChild(view);
			
			contextMenu = SiteContextMenu.init(stage, model, controller);
			
			controller.init();
		}

		private function onModelChange(event : Event) : void 
		{
			var myPageData : PageData = model.currentPageData;

			view.update(event);
		}		
	}
}
