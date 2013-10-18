package test
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import czc.framework.manager.TimerManager;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-10-18 下午4:45:23
	 * 
	 */
	public class BitmapMoveTest extends Sprite
	{
		[Embed(source="../assets/map6_7.jpg")]
		private var cla:Class;
		private var _speed:Number = 5;
		private var _stepCount:int;
		private var _stepX:int;
		private var _stepY:int;
		private var bmp:Bitmap;
		public function BitmapMoveTest()
		{
			super();
			bmp = new cla();
			addChild(bmp);
			stage.addEventListener(MouseEvent.CLICK,onClick);
//			TimerManager.instance.init(60);
//			TimerManager.instance.setInterval(onFrame,20);
			addEventListener(Event.ENTER_FRAME,onFrame);
		}
		
		protected function onFrame(event:Event):void
		{
			if(_stepCount > 0)
			{
				bmp.x += _stepX;
				bmp.y += _stepY;
				_stepCount--;
			}
		}
		
		protected function onClick(event:MouseEvent):void
		{
			var mouseX:int = stage.mouseX;
			var mouseY:int = stage.mouseY;
			var angle : Number = Math.atan2(mouseY - bmp.y, mouseX - bmp.x);
			var ds : Number = Point.distance(new Point(mouseX,mouseY), new Point(bmp.x,bmp.y));
			_stepCount = ds / _speed;
			var vx:Number = _speed * Math.cos(angle);
			var vy:Number = _speed * Math.sin(angle);
			_stepX = vx;
			_stepY = vy;
			trace("vx:" + vx," vy:" + vy + " _stepX:" + _stepX + " _stepY:" + _stepY); 
		}
	}
}