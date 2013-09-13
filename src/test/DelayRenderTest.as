package test
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-9-11 上午10:03:30
	 * 
	 */
	public class DelayRenderTest extends Sprite
	{
		protected var list:Array = [];
		private var count:int = 100000;
		private var frameCreateNum:int = 100;
		private var createNum:int;
		public function DelayRenderTest()
		{
			super();
			
			addEventListener(Event.ENTER_FRAME,onFrame,false,0,true);
		}
		
		protected function onFrame(event:Event):void
		{
			var t:Number = getTimer();
			if(createNum < count)
			{
				var i:int = 0;
				var spr:Sprite;
				while(i < frameCreateNum)
				{
					spr = createSpr();
					spr.x = Math.random() * 1200;
					spr.y = Math.random() * 700;
					addChild(spr);
					i++;
					createNum++;
				}
			}
			trace("create time:" + (getTimer() - t));
		}
		
		private function createSpr():Sprite
		{
			var spr:Sprite = new Sprite();
			spr.graphics.beginFill(0xff0000);
			spr.graphics.drawCircle(0,0,10);
			spr.graphics.endFill();
			return spr;
		}
		
	}
}