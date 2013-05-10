package czc.framework.manager
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	/**
	 * 
	 * @author caozhichao
	 * 
	 */	
	public class LoaderManager
	{
		private var _loaders:Array;
		public function LoaderManager()
		{
			_loaders = [];
		}
		
		public function load(urls:Array,success:Function,applicationDomain:ApplicationDomain=null,process : Function = null, faile : Function = null):void
		{
			var len:int = urls.length;
			var url:String;
			var loader:BulkLoader = getLoader();
			//设置log等级
//			loader.logLevel = BulkLoader.LOG_VERBOSE;
			//添加事件
			function onAllItemsLoaded(evt:Event):void
			{
				success();
				_loaders.push(loader);
				loader.removeEventListener(BulkLoader.COMPLETE, onAllItemsLoaded);
				loader.removeEventListener(BulkProgressEvent.PROGRESS,onProgress);
			}
			function onProgress(evt:BulkProgressEvent):void
			{
//				trace(int(evt.weightPercent * 100) + "%");
				if(process != null)
				{
					process();
				}
			}
			loader.addEventListener(BulkLoader.COMPLETE, onAllItemsLoaded,false,0,true);
			loader.addEventListener(BulkProgressEvent.PROGRESS,onProgress,false,0,true);
			var loaderContext:LoaderContext;
			var props:Object;
			if(applicationDomain)
			{
				loaderContext = new LoaderContext(false,applicationDomain);
				props = new Object();
				props.context = loaderContext;
			}
			for (var i:int = 0; i < len; i++) 
			{
				url = urls[i];
				loader.add(url,props);
			}
			loader.start();
		}
		
		private function getLoader():BulkLoader
		{
			var loader:BulkLoader = _loaders.shift();
			if(loader == null)
			{
				loader = BulkLoader.createUniqueNamedLoader();
			}
			return loader;
		}
	}
}