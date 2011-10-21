package com.quancreative.pages.portfolio{
	
	import flash.display.*;
	import flash.text.*;
	import flash.events.*	
	import flash.net.*
	
	public class ItemAsset extends MovieClip{
		
		private var _id:Number;
		private var _imageURL:String;
		private var _link:String;
		private var _title:String;
		private var _role:String;
		private var _technology:String;
		
		private var _originX:Number = 0;
		private var _originY:Number = 0;
		
		private var isTransitionedIn:Boolean;
		
		public function ItemAsset():void
		{
			isTransitionedIn = false;
		}
		
		public function get id():Number
		{
			return _id;
		}
		
		public function set id(value:Number):void
		{
			_id = value;
		}
		
		public function get link():String
		{
			return _link;
		}
		
		public function set link(value:String):void
		{
			_link = value;
		}
		
		public function get title():String
		{
			return _title;
		}
		
		public function set title(value:String):void
		{
			_title = value;
		}
		
		public function get role():String
		{
			return _role;
		}
		
		public function set role(value:String):void
		{
			_role = value;
		}
		
		public function get technolgy():String
		{
			return _technology;
		}
		
		public function set technology(value:String):void
		{
			_technology = value;
		}
		
		public function get imageURL():String
		{
			return _imageURL;
		}
		
		public function set imageURL(value:String):void
		{
			_imageURL = value;
		}
		
		public function get originX():Number
		{
			return _originX;
		}
		
		public function set originX(value:Number):void
		{
			_originX = value;
		}
		
		public function get originY():Number
		{
			return _originY;
		}
		
		public function set originY(value:Number):void
		{
			_originY = value;
		}
		
	}
}