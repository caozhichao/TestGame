package test
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	
	/**
	 *	
	 * 位图抠图	
	 * @author caozhichao
	 * 创建时间：2013-10-11 上午9:27:59
	 * 
	 */
	public class BitmapTest extends Sprite
	{
		[Embed(source="../assets/00.png")]
		public var cla:Class;
		public function BitmapTest()
		{
			super();
			var bmp:Bitmap = new cla();
			addChild(bmp);
			
			//原图
			var bmd:BitmapData = bmp.bitmapData;
			var bw:int = bmp.width;
			var bh:int = bmp.height;
			
			//初始化一张完全大小的底图，指定底图颜色
			var bmd2:BitmapData = new BitmapData(bw,bh,false,0xffffff);
			var bmp2:Bitmap = new Bitmap(bmd2);
			bmp2.x = 300;
			addChild(bmp2);
			
			//去掉透明度为0像素点的图
			var bmd3:BitmapData = bmd.clone();
			var bmp3:Bitmap = new Bitmap(bmd3);
			bmp3.x = 300;
			bmp3.y = 300;
			addChild(bmp3);
			var pix:uint;
			for (var i:uint = 0; i < bw; i++) 
			{
				for (var j:uint = 0; j < bh; j++) 
				{
					pix = bmd. getPixel32 (i, j);
					//完全透明的像素点
					if (pix <= 0) // 要抠取的颜色 
					{
						//替换透明像素为指定的颜色
						bmd3.setPixel32(i,j,0xff000000);
						//设置底图 指定颜色
						bmd2.setPixel(i,j,0x000000);
					}
				}
			}   
		}
	}
}