package test
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import czc.framework.utils.PInPolygon;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-11-22 下午1:40:02
	 * 
	 */
	public class PInPolygonTest extends Sprite
	{
		public function PInPolygonTest()
		{
			super();
			var points:Array =[new Point(10,10),new Point(100,10),new Point(100,50),new Point(150,50),new Point(150,100),new Point(10,100)];
			var p:Point = new Point(150,80);
			draw(points,p);
			var t:Number = getTimer();
			for(var i:int = 0; i < 1000; i++)
			{
				var value:Boolean = PInPolygon.pInPolygon(points,p);
				trace("点是否在多边形里面:" + value);
			}
			trace("耗时:" + (getTimer() - t));
		}
		
		private function draw(points:Array,p:Point):void
		{
			this.graphics.lineStyle(2,0xff0000);
			
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
					this.graphics.moveTo(startP.x,startP.y);
				} else 
				{
					endP = points[index];
					this.graphics.lineTo(endP.x,endP.y);
					startP = endP;
				}
				index++;
			}
			//最后一次连线
			this.graphics.lineTo(firstP.x,firstP.y);
			this.graphics.moveTo(p.x,p.y);
			this.graphics.lineTo(0,p.y);
			this.graphics.endFill();
		}
	}
}