package test
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	
	import czc.framework.manager.LoaderMaxManager;
	import czc.framework.manager.TimerManager;
	import czc.framework.vo.LoadItemVo;
	
	/**
	 *
	 * 1.加载的swf舞台上有动画(动画没有停止在第指定帧)，swf将无法卸载  使用unloadAndStop 可以卸载->停止影片剪辑
	 * @author caozhichao
	 * 创建时间：2013-8-5 下午5:58:50
	 * 
	 */
	public class LoaderTest extends Sprite
	{
		public function LoaderTest()
		{
			TimerManager.instance.init(60);
			function onFrame():void
			{
				for (var i:int = 0; i < 1000; i++) 
				{
					new Sprite();
				}
			}
			TimerManager.instance.setInterval(onFrame,50);
			var url:String = "assets/test1.swf";
			/*
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
			function onComplete(evt:Event):void
			{
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onComplete);
//				loader.unload();
//				loader.unloadAndStop();
				loader = null;
			}
			loader.load(new URLRequest(url),new LoaderContext(false,new ApplicationDomain()));
			*/
			
			var loader:BulkLoader = new BulkLoader("test");
			loader.logLevel = BulkLoader.LOG_INFO;
			var context:LoaderContext = new LoaderContext(false,new ApplicationDomain());
			//add url
			loader.add("assets/test1.swf",{"context":context});
			loader.add("assets/test1.swf",{"context":context});
			loader.add("assets/test1.swf",{"context":context});
			
			loader.addEventListener(BulkLoader.COMPLETE,onAllComplete);
			loader.addEventListener(BulkLoader.PROGRESS,onItemComplete);
//			loader.addEventListener(BulkProgressEvent.PROGRESS,onItemProgress);
			function onItemProgress(evt:BulkProgressEvent):void
			{
				trace("_percentLoaded:" + evt._percentLoaded," bytesLoaded" + evt.bytesLoaded," bytesTotal" + evt.bytesTotal);
			}
			function onItemComplete(evt:BulkProgressEvent):void
			{
//				trace("itemsLoaded:" + evt.itemsLoaded);
				trace("evt.weightPercent",evt.weightPercent," Loaded" , evt.bytesLoaded," of ",  evt.bytesTotal,"itemsLoaded:" + evt.itemsLoaded + "/" + evt.itemsTotal);
			}
			function onAllComplete(evt:Event):void
			{
//				loader.removeEventListener(BulkLoader.COMPLETE,onAllComplete);
//				loader.removeAll();
//				loader.remove(url,true);
//				context = null;
				trace("加载完成");
			}
			loader.start();
			/*
			LoaderMaxManager.instance.simpleLoader(url,success);
			function success(item:LoadItemVo):void
			{
//				var domain:ApplicationDomain = item.domain;
//				var cls:Vector.<String> = domain.getQualifiedDefinitionNames();
				LoaderMaxManager.instance.unloadAndStop(url);
				trace("sssssssss");
			}
			*/
		}
	}
}