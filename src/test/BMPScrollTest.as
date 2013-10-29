package test
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-10-18 下午5:56:40
	 * 
	 */
	public class BMPScrollTest extends Sprite
	{
		public function BMPScrollTest()
		{
			super();
			
			var bmd:BitmapData = new BitmapData(80, 80, true, 0xFFCCCCCC);
			var rect:Rectangle = new Rectangle(0, 0, 40, 40);
			bmd.fillRect(rect, 0xFFFF0000);
			
			var bm:Bitmap = new Bitmap(bmd);
			bm.x = 100;
			bm.y = 100;
			addChild(bm);
			
			var bm2:Bitmap = new Bitmap(bmd.clone());
			bm2.x = 200;
			bm2.y = 100;
			addChild(bm2);
			
			
//			trace (bmd.getPixel32(50, 20).toString(16)); // ffcccccccc
			
			bmd.scroll(20, 0); 
			
//			trace (bmd.getPixel32(50, 20).toString(16)); // ffff0000
		}
	}
}