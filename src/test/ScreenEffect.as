package test
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-10-14 上午9:28:47
	 * 
	 */
	public class ScreenEffect extends Sprite
	{
		[Embed(source="../assets/map52.jpg")]
		public var cla:Class;

		private var bmp:Bitmap;
		
//		private var count:int = 0;
		private var offY:int = 15;
		private var rect:Number = 0;
		private var bmpY:int;
		private var dir:int = 1;
		
		
		public function ScreenEffect()
		{
			super();
			bmp = new cla();
			addChild(bmp);
			
			stage.addEventListener(MouseEvent.CLICK,onClick,false,0,true);
			addEventListener(Event.ENTER_FRAME,onFrame);
			
			bmpY = bmp.y;
		}
		protected function onClick(event:MouseEvent):void
		{
			rect = 50;
			dir = 1;
		}
		
		protected function onFrame(event:Event):void
		{
			if(bmp.y != bmpY || rect > 0)
			{
				bmp.y = bmpY + rect * dir;
				rect -= 10;
				dir *= -1;
				trace(rect,"dir:" + dir," |" + bmp.y);
			}
		}
	}
}