package test
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-7-24 下午2:40:03
	 * 
	 */
	public class PNGTest extends Sprite
	{
		private var loader:Loader;
		
		public function PNGTest()
		{
			super();
			loader = new Loader();
			function onComplete(evt:Event):void
			{
				var bmp:Bitmap = loader.content as Bitmap;
				addChild(bmp);
			}
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
			loader.load(new URLRequest("assets/1.png"));
			
//			var bd:BitmapData = new BitmapData(2,2,true,0xffff0000);
//			var bm:Bitmap = new Bitmap(bd);
//			bm.y = 200;
//			bm.width = bm.height = 100;
//			var bytes:ByteArray = bd.getPixels(bd.rect);
//			addChild(bm);
		}
	}
}