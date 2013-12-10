package test
{
	import com.bit101.components.PushButton;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import czc.framework.utils.PInPolygon;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-12-9 下午1:52:18
	 * 
	 */
	public class PInPolygonTest2 extends Sprite
	{
		private var spr2:Sprite;
		private var isCheckHit:Boolean = false;

		private var arr:Array;

		private var spr1:Sprite;
		public function PInPolygonTest2()
		{
			super();
			// Rectangle (0,0) (100,100)
			var button:PushButton = new PushButton(this,200,200,"随机生成",onClick);
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		private function onClick(evt:Event):void
		{
			trace("onClick");
			var num:int = 3;
			arr = [];
			var p:Point;
			for (var i:int = 0; i < num; i++) 
			{
				p = new Point(Math.random() * 150,Math.random() * 150);
				arr[i] = p;
			}
			spr1 = draw(arr,spr1);
			spr2 = draw(arr,spr2);
			spr2.x = 150;
			spr2.addEventListener(MouseEvent.MOUSE_DOWN,onStartDrag);
			addChild(spr1);
			addChild(spr2);
		}
		
		protected function onEnterFrame(event:Event):void
		{
			if(isCheckHit)
			{
				var p:Point;
				var gp:Point;
				var temp:Array = [];
				for (var i:int = 0; i < arr.length; i++) 
				{
					p = arr[i];
					gp = spr2.localToGlobal(p);
					var value:Boolean = PInPolygon.pInPolygon(arr,gp);
					if(value)
					{
						trace("碰撞到了...");
						break;
					}
				}
				trace("没有碰撞...");
			}
			
		}
		
		protected function onStartDrag(event:MouseEvent):void
		{
			spr2.startDrag();
			
			function onMoveDrag(evt:MouseEvent):void
			{
				isCheckHit = true;
				spr2.startDrag();
			}
			function onEndDrag(evt:MouseEvent):void
			{
				spr2.stopDrag();
				
				removeEventListener(MouseEvent.MOUSE_MOVE,onMoveDrag);
				removeEventListener(MouseEvent.MOUSE_UP,onEndDrag);
			}
			addEventListener(MouseEvent.MOUSE_MOVE,onMoveDrag);
			addEventListener(MouseEvent.MOUSE_UP,onEndDrag);
		}
		
		private function draw(points:Array,spr:Sprite):Sprite
		{
			if(spr == null)
			{
				spr = new Sprite();
				spr.cacheAsBitmap = true;
			}
			spr.graphics.clear();
			spr.graphics.lineStyle(2,0xff0000);
			var firstP:Point = points[0];
			var len:int = points.length;
			var index:int = 0;
			var startP:Point;
			var endP:Point;
			while(index < len)
			{
				if(startP == null)
				{
					startP = points[index];
					spr.graphics.moveTo(startP.x,startP.y);
				} else 
				{
					endP = points[index];
					spr.graphics.lineTo(endP.x,endP.y);
					startP = endP;
				}
				index++;
			}
			//最后一次连线
			spr.graphics.lineTo(firstP.x,firstP.y);
			spr.graphics.endFill();
			return spr;
		}
	}
}