package test
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-10-29 上午9:56:43
	 * 
	 */
	public class PaletteMapTest extends Sprite
	{
		public function PaletteMapTest()
		{
			super();
			
			/*
			var myBitmapData:BitmapData = new BitmapData(80, 80, false, 0x00FF0000);
			myBitmapData.fillRect(new Rectangle(20, 20, 40, 40), 0x0000FF00);
			
			var redArray:Array = new Array(256);
			var greenArray:Array = new Array(256);
			
			for(var i:uint = 0; i < 255; i++) {
				redArray[i] = 0x00000000;
				greenArray[i] = 0x00000000;
			}
			
			redArray[0xFF]   = 0x0000FF00;
			greenArray[0xFF] = 0x00FF0000;
			
			var bottomHalf:Rectangle = new Rectangle(0, 0, 80, 40);
			var pt:Point = new Point(0, 0);
			myBitmapData.paletteMap(myBitmapData, bottomHalf, pt, redArray,greenArray);
			
			var bm1:Bitmap = new Bitmap(myBitmapData);
			addChild(bm1);
			*/
			
			var alphaList:Array = new Array(256);
			var len : uint = 256;
			for (var i : uint = 0; i < len; i++) {
				alphaList[i] = 255 - i;
			}
			
			var bmd:BitmapData = new BitmapData(300,300,true,0xFF000000);
			
			bmd.paletteMap(bmd,new Rectangle(0,0,300,150),new Point(0,0),null,null,null,alphaList);
			
			var bmp:Bitmap = new Bitmap(bmd);
			addChild(bmp);
		}
	}
}