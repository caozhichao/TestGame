package test
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import pet.data.items.MapConfig;
	import pet.game.map.core.helper.MapMaskHelper;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-10-29 上午9:50:15
	 * 
	 */
	public class MapMaskHelperTest extends Sprite
	{
		[Embed(source="../assets/map8.jpg")]
		private var cla:Class;
		private var alphaList:Array;
		
		private var showBMD:BitmapData;
		private var _maskHelper:MapMaskHelper;
		
		private var tx:int = 100;
		
		public function MapMaskHelperTest()
		{
			super();
			
			var p:Bitmap = new cla();
			addChild(p);
			/*
			showBMD = new BitmapData(1000,1000,true,0xdd << 24);
			alphaList = new Array(256);
			var len : uint = 256;
			for (var i : uint = 0; i < len; i++) {
				alphaList[i] = (255 - i) << 24;
//				trace(alphaList[i].toString(16))
			}
			var bmd:BitmapData = creatCircleMask(150, 200);
			showBMD.paletteMap(bmd,bmd.rect,new Point(0,0),null,null,null,alphaList);
//			var bmp:Bitmap = new Bitmap(bmd);
			var rect:Rectangle = bmd.rect;
			rect.x = 100;
//			showBMD.paletteMap(bmd,bmd.rect,new Point(100,0),null,null,null,alphaList);
			var bmp:Bitmap = new Bitmap(showBMD);
			addChild(bmp);
			*/
			
			var pgbmd:Bitmap = new Bitmap();
			addChild(pgbmd);
			
			_maskHelper = new MapMaskHelper();
			var color : uint = (0xff - 0xdd) << 24;
			var maskBitmapData:BitmapData = new BitmapData(800,800,true,color);
			var _pgData:BitmapData = new BitmapData(1000,1000,true,0xffff0000);
			
			pgbmd.bitmapData = _pgData;
			_maskHelper.setDB(new Dictionary(), maskBitmapData, _pgData);
			
			_maskHelper.move(400,400);
			
			stage.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			_maskHelper.move(tx,100);
			tx += 10;
		}
		
		private function creatCircleMask(radius : int, smooth : int) : BitmapData {
			var len : int = radius + smooth;
			var len2 : int = len * 2;
			var bd : BitmapData = new BitmapData(len2, len2, true, 0);
			bd.lock();
			var radiusD : int = radius * radius;
			var lenD : int = len * len;
			var ditD : int = lenD - radiusD;
			var color : uint;
			var change : Boolean;
			for (var x : int = 0; x < len2; x++) {
				for (var y : int = 0; y < len2; y++) {
					var ds : int = (x - len) * (x - len) + (y - len) * (y - len);
					change = false;
					if (ds <= radiusD) {
						color = 0xff000000;
						change = true;
					} else if (ds < lenD) {
						var d : uint = 0xff * (ditD - ds + radiusD) / ditD;
						color = uint(d << 24);
						change = true;
					}
					if (change) {
						bd.setPixel32(x, y, color);
					}
				}
			}
			bd.unlock();
			return bd;
		}
		
	}
}