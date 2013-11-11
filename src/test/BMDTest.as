package test
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-11-11 下午2:06:09
	 * 
	 */
	public class BMDTest extends Sprite
	{
		[Embed(source="../assets/map2.jpg")]
		private var cla:Class;
		
		public function BMDTest()
		{
			super();
			var bmp:Bitmap = new cla();
			addChild(bmp);
			
			trace(bmp.width,bmp.height);
			var bmd:BitmapData = new BitmapData(600,375,false,0);
			var matrix:Matrix = new Matrix();
//			var rect:Rectangle = new Rectangle();
//			rect.width = 500;
//			rect.height = 375;
//			rect.x = 50;
			matrix.tx = 50;
			bmd.draw(bmp,matrix,null,null);
			
			var bmp2:Bitmap = new Bitmap(bmd);
			bmp2.x = 510;
			addChild(bmp2);
		}
	}
}