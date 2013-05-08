package czc.framework.event
{
	import flash.events.Event;
	
	public class BaseEvent extends Event
	{
		protected var _data:*;
		public static const TEST_EVENT:String = "TEST_EVENT";
		public function BaseEvent(type:String, data:*=null,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_data = data;
			super(type, bubbles, cancelable);
		}
		public function get data():*
		{
			return _data;
		}
	}
}