package qhn.mvc.model 
{
	import flash.net.URLRequest;
	import flash.events.IEventDispatcher;

	/**
	 * @author qngo
	 */
	public interface IModel extends IEventDispatcher
	{
		/*
		 * load the xml
		 * 
		 * @param : URLRequest - the xml url 
		 */
		function load(request : URLRequest) : void;
		
		function get totalPage() : int ;
		function get currentPageNum() : int;
		function get currentPage() 	: String;
	}
}
