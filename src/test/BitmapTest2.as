package test
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-10-11 上午10:16:55
	 * 
	 */
	public class BitmapTest2 extends Sprite
	{
		[Embed(source="../assets/map606.jpg")]
		private var mapCla:Class;
		
		private var p:Sprite;
		private var _stepCount:Number;
		private var _speed:Number = 5;
		private var _stepX:Number;
		private var _stepY:Number;
		
		private var _circle:Circle;

		private var bmd:BitmapData;
		public function BitmapTest2()
		{
			super();
			var map:Bitmap = new mapCla();
			map.width = 800;
			map.height = 600;
			addChild(map);
			
			bmd = new BitmapData(800,600,true,0xff000000);
			var bmp:Bitmap = new Bitmap(bmd);
			addChild(bmp);
			
			_circle = new Circle();
//			addChild(_circle);
			
			p = new Sprite();
			p.graphics.beginFill(0xff0000);
			p.graphics.drawCircle(0,0,10);
			p.graphics.endFill();
			addChild(p);
			
			addEventListener(Event.ENTER_FRAME,onFrame);
			stage.addEventListener(MouseEvent.CLICK,onClick);
			
			updateShadow();
			
		}
		
		protected function onFrame(event:Event):void
		{
			if(_stepCount > 0)
			{
				p.x += _stepX;
				p.y += _stepY;
				_circle.x = p.x;
				_circle.y = p.y;
				_stepCount--;
				
				
				updateShadow();
			}
		}
		
		private function updateShadow():void
		{
			var rec:Rectangle = _circle.getBounds(stage);
			//圆心点坐标
			var px:int = rec.x + rec.width / 2;
			var py:int = rec.y + rec.height / 2;
			
			//和阴影的叫鸡
			var intersection:Rectangle = new Rectangle(0,0,800,600).intersection(rec);
//			trace(rec.x,rec.y,rec.width,rec.height,px,py);
//			trace(intersection.x,intersection.y,intersection.width,intersection.height);
//			return;
			var sx:int = intersection.x;
			var sy:int = intersection.y;
			var cx:int = sx + intersection.width;
			var cy:int = sy + intersection.height;
			
			var p1:Point = new Point(px,py);
			var p2:Point = new Point();
			bmd.lock();
			for (var i:int = sx; i < cx; i++) 
			{
				for(var j:int = sy; j < cy; j++)
				{
					p2.x = i;
					p2.y = j;
					var distance:int = Point.distance(p1,p2); 
					if( distance <= Circle._r2)
					{
//						var pix:uint = bmd.getPixel32(i,j);
//						if((pix >>> 24) > 0)
//						{
							var a:uint = distance * 1;
							var c:uint = 0x00000000;
							a = a << 24;
							c = c | a;
//							trace(pix >>> 24,c >>> 24);
//							bmd.setPixel32(i,j,0x00ff0000);
							bmd.setPixel32(i,j,c);
//						}
					}
				}
			}
			bmd.unlock();
		}
		protected function onClick(event:MouseEvent):void
		{
			var mouseX:int = stage.mouseX;
			var mouseY:int = stage.mouseY;
			var angle : Number = Math.atan2(mouseY - p.y, mouseX - p.x);
			var ds : Number = Point.distance(new Point(mouseX,mouseY), new Point(p.x,p.y));
			_stepCount = ds / _speed;
			_stepX = _speed * Math.cos(angle);
			_stepY = _speed * Math.sin(angle);
		}
		
	}
}
import flash.display.Sprite;

class Circle extends Sprite
{
//	private var _r1:int = 99;
	public static  var _r2:int = 100;
	
	public function Circle()
	{
		draw(0xffff00,_r2);
//		draw(0x00ff00,_r1);
	}
	private function draw(color:uint,r:int):void
	{	
		this.graphics.beginFill(color);
		this.graphics.drawCircle(0,0,r);
		this.graphics.endFill();
	}
}
