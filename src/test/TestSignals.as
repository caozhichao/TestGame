package test
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.Signal;
	import org.osflash.signals.natives.NativeSignal;
	
	public class TestSignals extends Sprite
	{
		private var signals:Signal;

		private var deluxeSignal:DeluxeSignal;
		public function TestSignals()
		{
			super();
			signals = new Signal();
			function callback(...args):void
			{
				trace("TestSignals.callback()");
			}
			signals.add(callback);
			addEventListener(Event.ENTER_FRAME,onFrame);
			deluxeSignal = new DeluxeSignal(this,SignalEvent);
			deluxeSignal.addOnce(callback);
			var nativeSignal:NativeSignal = new NativeSignal(this.stage,MouseEvent.CLICK,MouseEvent);
			nativeSignal.addOnce(callback);
		}
		
		protected function onFrame(event:Event):void
		{
//			signals.dispatch("a","b");
			deluxeSignal.dispatch(new SignalEvent());
		}
	}
}