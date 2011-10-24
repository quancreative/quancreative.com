package com.quancreative.model 
{
	/**
	 * @author qngo
	 */
	public class AppModel 
	{
		private static var instance : AppModel;
		private var _isStandAlone : Boolean = true;
		
		public var contactEmailAddress : String = "info@quancreative.com";
		private var _appPath 	: String = "";
		private var _swfPath 	: String = "";

		public function AppModel(pvt : PrivateClass)
		{
			
		}
		
		public static function getInstance() : AppModel
		{
			if (instance == null)
			{
				AppModel.instance = new AppModel(new PrivateClass());
			}
			return AppModel.instance;
		}
		
		public function get swfPath() : String
		{
			return _swfPath;
		}
		
		public function set swfPath(value : String) : void
		{
			_swfPath = value;
		}
		
		public function get isStandAlone() : Boolean
		{
			return _isStandAlone;
		}
		
		public function set isStandAlone(value : Boolean) : void
		{
			_isStandAlone = value;
			
			if (!_isStandAlone)
			{
				_swfPath = "assets/swf/";
			}
		}
	}
}

class PrivateClass
{
	public function PrivateClass()
	{
		// Enforcer	
	}
}

