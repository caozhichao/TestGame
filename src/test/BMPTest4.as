package test
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-10-28 下午4:25:01
	 * 
	 */
	public class BMPTest4 extends Sprite
	{
		public function BMPTest4()
		{
			/*
			var bmd:BitmapData = new BitmapData(200, 200, false, 0x00CCCCCC);
			
			var seed:Number = Math.floor(Math.random() * 10);
			var channels:uint = BitmapDataChannel.RED | BitmapDataChannel.BLUE;
			bmd.perlinNoise(100, 80, 6, seed, false, true, channels, false, null);
			
			var bm:Bitmap = new Bitmap(bmd);
			addChild(bm);
			
			var bmd:BitmapData = new BitmapData(100, 80, false, 0x00CCCCCC);
			var bitmap:Bitmap = new Bitmap(bmd);
			addChild(bitmap);
			*/
			
			var bmd:BitmapData = new BitmapData(100, 80, false, 0x00CCCCCC);
			var bitmap:Bitmap = new Bitmap(bmd);
			addChild(bitmap);
			

			
			var tim:Timer = new Timer(20);
			tim.start();
			tim.addEventListener(TimerEvent.TIMER, timerHandler);
			
			function timerHandler(event:TimerEvent):void {
				var randomNum:Number = Math.floor(Math.random() * int.MAX_VALUE);
				dissolve(randomNum);
			}
			
			function dissolve(randomNum:Number):void {
				var rect:Rectangle = bmd.rect;
				var pt:Point = new Point(0, 0);
				var numberOfPixels:uint = 100;
				var red:uint = 0x00FF0000;
				bmd.pixelDissolve(bmd, rect, pt, randomNum, numberOfPixels, red);
				var grayRegion:Rectangle = bmd.getColorBoundsRect(0xFFFFFFFF, 0x00CCCCCC, true);
				if(grayRegion.width == 0 && grayRegion.height == 0 ) {
					tim.stop();
				}
			}
			
		}
		
		
		
	}
}