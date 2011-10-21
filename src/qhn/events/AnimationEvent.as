package qhn.events 
{
	import flash.events.Event;

	/**
	 * @author qngo
	 */
	public class AnimationEvent extends Event 
	{
		public static const TRANSITION_IN_COMPLETE : String = "transitionInComplete";
		public static const TRANSITION_OUT : String = "transitionOut";
		public static const TRANSITION_OUT_COMPLETE : String = "transitionOutComplete";
		public static const TRANSITION_CHANGE : String = "transitionChange";

		public function AnimationEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
