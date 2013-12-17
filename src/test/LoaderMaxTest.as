package test
{
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.core.LoaderCore;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.CompressionAlgorithm;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-6-27 下午2:33:59
	 * 
	 */
	public class LoaderMaxTest extends Sprite
	{
		private var loader:LoaderMax;
		
		public function LoaderMaxTest()
		{
			super();
			LoaderMax.activate([SWFLoader,ImageLoader]);
			function onFrame(evt:Event):void
			{
				for (var i:int = 0; i < 100000; i++) 
				{
					new Sprite();
				}
			}
//			addEventListener(Event.ENTER_FRAME,onFrame);
			var button:PushButton = new PushButton(this,0,0,"卸载资源");
			button.label = "unload";
			button.addEventListener(MouseEvent.CLICK,onClick);
			function onClick(evt:MouseEvent):void
			{
//				addEventListener(Event.ENTER_FRAME,onFrame);
				load();
			}
			load();
		}
		private function load():void
		{
			LoaderMax.defaultAuditSize = false;
			
			loader = new LoaderMax({onComplete:getCompleteHandler(), onProgress:progressHandler/*,auditSize:false*/,maxConnections:1});
//			var context:LoaderContext = new LoaderContext();
//			context.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
//			var child:LoaderCore = LoaderMax.parse("assets/world_map.swf",{context:new LoaderContext()});
//			loader.append(child);
			var domain:ApplicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
			var context:LoaderContext = new LoaderContext(false, domain);
			loader.prepend(new SWFLoader("assets/world_map.swf", {/*name: obj.id, */context: context/*,noCache:false, */,onComplete: onComplete}));
//			loader.prepend(new SWFLoader("assets/world_map.swf", {/*name: obj.id, */context: context/*,noCache:false, */,onComplete: onComplete}));
//			var child:LoaderCore = LoaderMax.parse("assets/1.png",{context:context/*,onComplete: onComplete*/});
//			loader.append(child);
			loader.load();
			//闭包资源无法卸载????
			function completeHandler(evt:LoaderEvent):void
			{
				trace("LoaderMaxTest.completeHandler(evt)");
				loader.empty(true,true);
				//			loader.unload();
			}
		}
		private function getCompleteHandler():Function
		{
			return function completeHandler(evt:LoaderEvent):void
			{
//				var imageLoader:ImageLoader = loader.getLoader("assets/1.png");
//				var bm:Bitmap /*= loader.getContent("assets/map1.jpg")*/;
//				bm = imageLoader.rawContent;
//				var byts:ByteArray = bm.bitmapData.getPixels(bm.bitmapData.rect);
//				/*
//				byts.compress(CompressionAlgorithm.LZMA);
//				
//				var lbyts:ByteArray = LZMA.decode(byts);
//				lbyts.position = 0;
//				*/
//				
//				var l:Loader = new Loader();
//				l.loadBytes(byts);
//				addChild(l);
				trace("LoaderMaxTest.completeHandler(evt)");
//				loader.empty(true,true);
				//			loader.unload();
			}
		}
		private function completeHandler(evt:LoaderEvent):void
		{
			trace("LoaderMaxTest.completeHandler(evt)");
//			context.applicationDomain = null;
//			context = null;
//			loader.empty(true,true);
//			loader.unload();
		}
		
		private function progressHandler(evt:LoaderEvent):void
		{
			trace("progressHandler: " + loader.rawProgress);
		}
		
		private function onComplete(evt:LoaderEvent):void
		{
			trace("LoaderMaxTest.onComplete(evt)");
//			loader.unload();
//			loader.empty(true,true);
//			loader.dispose(true);
		}
	}
}