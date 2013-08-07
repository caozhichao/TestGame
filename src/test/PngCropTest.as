package test
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	import czc.framework.manager.LoaderMaxManager;
	import czc.framework.vo.LoadItemVo;
	
	
	/**
	 * png 图剪切优化	
	 * @author caozhichao
	 * 创建时间：2013-8-7 上午10:47:47
	 * 
	 */
	public class PngCropTest extends Sprite
	{
		private var cols:int;
		public function PngCropTest()
		{
			super();
			var url:String = "assets/00.png";
			LoaderMaxManager.instance.simpleLoader(url,onComplete);
			function onComplete(item:LoadItemVo):void
			{
				var bm:Bitmap = item.data;
				var bmd:BitmapData = bm.bitmapData;
				var pixels:Vector.<uint> = bmd.getVector(bmd.rect);
				var w:int = bmd.width;
				var h:int = bmd.height;
				
				cols = w;
				//首行
				var startY:int = test(0,h,w,pixels,true);
				//末行
				var endY:int = test(h-1,-1,w,pixels,true);
				//首列
				var startX:int = test(0,w,h,pixels,false);
				//末列
				var endX:int  = test(w-1,-1,h,pixels,false);
				trace("w:" + ((endX - startX) + 1),"h:" + ((endY - startY) + 1));  
				
				
				//显示新图
				var tw:int = (endX - startX) + 1;
				var th:int = (endY - startY) + 1;
				
				var croy:Vector.<uint> = new Vector.<uint>();
				
				var index:int;
				var position:int;
				var j:int;
				while(startY <= endY)
				{
					j = startX;
					while(j <= endX)
					{
						position = getPixelPosition(startY,j,cols);
						croy[index] = pixels[position];
						j++;
						index++;
					}
					startY++;
				}
				var bmd2:BitmapData = new BitmapData(tw,th);
				var rect:Rectangle = bmd2.rect;
				
				bmd2.setVector(bmd2.rect,croy);
				addChild(new Bitmap(bmd2));
				
				
//				trace(pixels);
			}
		}
		
		private function test(startIndex:int,endIndex:int,innerLoop:int,pixels:Vector.<uint>,isRow:Boolean):int
		{
			var position:int;
			var status:Boolean = startIndex < endIndex;
			while(startIndex != endIndex)
			{
				var i:int = 0;
				while( i < innerLoop)
				{
					if(isRow)
					{
						position = getPixelPosition(startIndex,i,cols);
					} else 
					{
						position = getPixelPosition(i,startIndex,cols);
					}
					var color:uint = pixels[position];
					var alpha:uint = (color >>> 24);
					if(alpha > 30) // 0
					{
						return startIndex;
					}
					i++;
				}
				status?startIndex++:startIndex--;
			}
			return 0;
		}
		
		
		private function getPixelPosition(row:int,cols:int,countCols:int):int
		{
			var position:int;
			position = row * countCols + cols;
			return position;
		}
	}
}