package test
{
	import org.osflash.signals.IPrioritySignal;
	import org.osflash.signals.events.IEvent;
	
	public class SignalEvent implements IEvent
	{
		public function SignalEvent()
		{
		}
		
		public function get target():Object
		{
			return null;
		}
		
		public function set target(value:Object):void
		{
		}
		
		public function get currentTarget():Object
		{
			return null;
		}
		
		public function set currentTarget(value:Object):void
		{
		}
		
		public function get signal():IPrioritySignal
		{
			return null;
		}
		
		public function set signal(value:IPrioritySignal):void
		{
		}
		
		public function get bubbles():Boolean
		{
			return false;
		}
		
		public function set bubbles(value:Boolean):void
		{
		}
		
		public function clone():IEvent
		{
			return null;
		}
	}
}