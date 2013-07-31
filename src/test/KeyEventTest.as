package test
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.ui.KeyboardType;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-7-31 下午2:27:40
	 * 
	 */
	public class KeyEventTest extends Sprite
	{
		private var keyDown:Array = [0,0,0,0];
		
		public function KeyEventTest()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,onStage);
		}
		
		protected function onStage(event:Event):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onkeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
		}
		
		protected function onKeyUp(event:KeyboardEvent):void
		{
//			trace("onKeyUp|" + event.charCode + "|" + event.keyCode + "|" + event.keyLocation);
		}
		
		protected function onkeyDown(event:KeyboardEvent):void
		{
//			trace("onkeyDown|" + event.charCode + "|" + event.keyCode + "|" + event.keyLocation);
			switch(event.keyCode)
			{
				case Keyboard.UP:
					break;
				case Keyboard.DOWN:
					break;
				case Keyboard.LEFT:
					break;
				case Keyboard.RIGHT:
					break;
			}
		}
		
	}
}