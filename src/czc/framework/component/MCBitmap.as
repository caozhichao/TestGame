package czc.framework.component
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	import czc.framework.manager.TimerManager;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-8-27 下午2:00:38
	 * 
	 */
	public class MCBitmap extends Sprite
	{
		private var _skin:MovieClip;
		private var _isCache:Boolean;
		private var _list:Array;
		private var _isAddPlay:Boolean;
		private var _bmp:Bitmap;
		
		private var frameIndex:int;
		private var totalFrames:int;
		private var _frameRate:int;
		
		public function MCBitmap(value:MovieClip,isCacheBitmap:Boolean,isAddPlay:Boolean=true,frameRate:int=20)
		{
			super();
			_list = [];
			_frameRate = frameRate;
			_isAddPlay = isAddPlay;
			_isCache = isCacheBitmap;
			skin = value;
			if(_isCache)
			{
				_bmp = new Bitmap();
			}
			if(isAddPlay)
			{
				addEventListener(Event.ADDED_TO_STAGE,onAdd,false,0,true);
			}
			
		}
		
		protected function onAdd(event:Event):void
		{
			play();
		}
		
		public function play():void
		{
			if(_isCache)
			{
				addChild(_bmp);
			} else 
			{
				addChild(_skin);
			}
			TimerManager.instance.setInterval(render,int(1000 / _frameRate));	
		}
		
		private function render():void
		{
			if(_isCache)
			{
				var cache:BMDCache = _list[frameIndex % totalFrames];
				_bmp.x = cache.x;
				_bmp.y = cache.y;
				_bmp.bitmapData = cache.bmd;
			} else 
			{
				_skin.gotoAndStop(frameIndex % totalFrames);
			}
			frameIndex++;
		}
		
		public function stop():void
		{	
			if(_isCache)
			{
				removeChild(_bmp);
			} else 
			{
				removeChild(_skin);
			}
			TimerManager.instance.clearTimer(render);	
		}
		
		public function set skin(value:MovieClip):void
		{
			_skin = value;
			if(_skin)
			{
				totalFrames = _skin.totalFrames;
				if(_isCache)
				{
					_list = draw(_skin);
					totalFrames = _list.length;
				}
			}
		}
		
		/**
		 * 把MovieClip draw 成位图BitmapData数组  
		 * @param mc
		 * @return 
		 * 
		 */
		private function draw(mc : MovieClip) : Array {
			var list : Array = [];
			var len : int = mc.totalFrames;
			var bmd : BitmapData;
			var cache:BMDCache;
			var rec:Rectangle;
			var matrix:Matrix = new Matrix();
			for (var i : int = 1; i <= len; i++) {
				cache = new BMDCache();
				mc.gotoAndStop(i);
				rec = mc.getBounds(mc);
				bmd = new BitmapData(rec.width + rec.x, rec.height, true, 0);
				matrix.tx = -rec.x;
				matrix.ty = -rec.y;
				bmd.draw(mc,matrix);
				cache.x = rec.x;
				cache.y = rec.y;
				cache.bmd = bmd;
				list.push(cache);
			}
			return list;
		}
		
	}
}
import flash.display.BitmapData;

class BMDCache
{
	public var bmd:BitmapData;
	public var x:Number;
	public var y:Number;
}