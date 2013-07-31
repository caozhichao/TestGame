package test
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import deng.fzip.FZip;
	import deng.fzip.FZipFile;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-7-26 下午3:39:07
	 * 
	 */
	public class FZipTest extends Sprite
	{
		private var loader:URLLoader;
		public function FZipTest()
		{
			super();
			loader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.load(new URLRequest("assets/test1.swf"));
			loader.addEventListener(Event.COMPLETE,onComplete);
			function onComplete(evt:Event):void
			{
				var swfLoader:Loader = new Loader();
				var bytes:ByteArray = loader.data;
				bytes.position = 0;
				bytes.writeByte(10);
				swfLoader.loadBytes(bytes);
				addChild(swfLoader);
				
				/*
				var t:Number = getTimer();
				var bytes:ByteArray = loader.data;
				var fzip:FZip = new FZip();
				fzip.addEventListener(Event.COMPLETE,onFZipComplete);
				fzip.loadBytes(bytes);
				function onFZipComplete(evt:Event):void
				{
//					var f:FZipFile = fzip.getFileByName("npcs.xml");
//					var str:String = f.getContentAsString();
					trace(getTimer() - t);	
				}
				*/
			}
		}
	}
}