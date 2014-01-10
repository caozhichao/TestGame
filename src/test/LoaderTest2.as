package test
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2014-1-7 上午11:27:27
	 * 
	 */
	public class LoaderTest2 extends Sprite
	{
		private var urlloader:URLLoader;
		private var loader:Loader;
		public function LoaderTest2()
		{
			super();
			urlloader = new URLLoader();
			urlloader.dataFormat = URLLoaderDataFormat.BINARY;
			urlloader.load(new URLRequest("assets/map9.jpg"));
			urlloader.addEventListener(Event.COMPLETE,onComplete);
			/*
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
			loader.load(new URLRequest("assets/map9.jpg"));
			*/
			function onComplete(evt:Event):void
			{
				trace("加载完成...");
			}
		}
	}
}