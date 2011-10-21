package com.quancreative.core
{
	import com.quancreative.model.AppModel;
	import com.quancreative.main.model.MainModel;
	import com.quancreative.main.controller.MainController;
	import com.quancreative.main.model.PageData;

	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;

	public class SiteContextMenu
	{	
		private static var menu:ContextMenu = new ContextMenu();
		private static var customItems:Array = [];
		private static var separator:Boolean = false;
		private static var stage:Stage;
		
		private static var logoItem:ContextMenuItem = new ContextMenuItem("*** QuanCreative ***", true);			
		private static var fullScreenItem:ContextMenuItem = new ContextMenuItem("Full Screen", true);
		private static var exitFullScreenItem:ContextMenuItem = new ContextMenuItem("Exit Full Screen", true); 
		
		private static var controller : MainController;
		private static var model : MainModel;
		private static var pages : Array = new Array();
		
		public static function init(s:Stage, aModel : MainModel, aController: MainController) : ContextMenu
		{
			stage = s;
			
			model = aModel;
			model.addEventListener(Event.CHANGE, onModelChange);
			
			controller = aController;
			
			pages = model.pages;
			
			menu.hideBuiltInItems();
			menu.addEventListener(ContextMenuEvent.MENU_SELECT, menuSelectHandler);
			
			separator = true;
			
			fullScreenItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, fullScreenItemSelectHandler);			
			exitFullScreenItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, exitFullScreen);
			logoItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onLogoItemSelect);
			
			addCustomMenuItems(pages);
			
			/*			
			var emailItem:ContextMenuItem = new ContextMenuItem("info@quancreative.com", true)
			emailItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, emailItemSelectHandler);
			
			menu.customItems.push(emailItem);*/
			
			customItems.push(fullScreenItem);
			customItems.push(exitFullScreenItem);
			customItems.push(logoItem);	
			
			menu.customItems = customItems;			
			return menu;
		}

		private static function onLogoItemSelect(event : ContextMenuEvent) : void 
		{
			controller.gotoPage(0); // 0 = home page
		}

		private static function onModelChange(event : Event) : void 
		{
			var pageData : PageData = model.currentPageData;
			if (pageData)
			{
				
			}
		}

		private static function addCustomMenuItems(pages:Array):void
		{
			for (var i:int = 0; i < pages.length; i++)
			{
				var pageData : PageData = pages[i];
				var pageName : String = pageData.id;
			
				addPageToMenu(capitalize(pageName));
			}
		}

		private static function capitalize(str : String) : String
		{
			var firstChar : String = str.substr(0, 1);
			var restOfString : String = str.substr(1, str.length);
			
			return firstChar.toUpperCase() + restOfString.toLocaleLowerCase();
		}

		private static function addPageToMenu(page:String):void
		{
			var cmi:ContextMenuItem = new ContextMenuItem(page, separator);
			cmi.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onGoto);
			separator = false;
			customItems.push(cmi);
		}
		
		private static function onGoto(event : ContextMenuEvent) : void
		{
			//trace(ContextMenuItem(event.target).caption);
			var page : String = ContextMenuItem(event.target).caption;
			controller.gotoPage(page.toLowerCase());
		}
	
		private static function emailItemSelectHandler(event : ContextMenu):void{
			
			var urlRequest:URLRequest = new URLRequest("mailto:" + AppModel.getInstance().contactEmailAddress);			
			
			try {
                navigateToURL(urlRequest, "_self");
            }
            catch (e:Error) {
                // handle error here
            }
		}
		
		private static function fullScreenItemSelectHandler(event:ContextMenuEvent):void {			
			stage.displayState = StageDisplayState.FULL_SCREEN;
        }
		
		private static function exitFullScreen(event:ContextMenuEvent):void{
			stage.displayState = StageDisplayState.NORMAL;
		}
				
		private static function menuSelectHandler(event:ContextMenuEvent):void 
		{			
			/*trace("===== key in obj =====");
			for (var key:String in event.target.customItems)
			{
				trace(key + " = " + event.target.customItems[key]);
				
			}
			trace("======================"); */
						
           if (stage.displayState == StageDisplayState.NORMAL)
		   {
			   /*fullScreenItem.enabled = true;
			   exitFullScreenItem.enabled = false;*/
   			   fullScreenItem.visible = true;
			   exitFullScreenItem.visible = false;
		   } 
		   else 
		   {
			   fullScreenItem.visible = false;
			   exitFullScreenItem.visible = true;
		   }		   
        }	
	}
}