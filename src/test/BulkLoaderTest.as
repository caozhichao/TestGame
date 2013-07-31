package test
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getDefinitionByName;
	
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-7-10 下午4:44:21
	 * 
	 */
	public class BulkLoaderTest extends Sprite
	{

		private var loader:BulkLoader;
		public function BulkLoaderTest()
		{
			super();
			loader = new BulkLoader();
			loader.logLevel = BulkLoader.LOG_VERBOSE;
			loader.addEventListener(BulkLoader.PROGRESS,onProgress);
			loader.addEventListener(BulkLoader.COMPLETE,onComplete);
			for (var i:int = 0; i < 1; i++) 
			{
//				loader.add("assets/map" + (i + 1)+ ".jpg");
			}
			loader.add("assets/world_map.swf",{context:new LoaderContext(false,new ApplicationDomain(null))});
			loader.start();
		}
		
		protected function onComplete(event:BulkProgressEvent):void
		{
			var sp:Sprite = loader.getSprite("assets/world_map.swf");
			addChild(sp);
//			var b:Bitmap = loader.getBitmap("assets/map1.jpg");
//			loader.removeAll();
//			addChild(b);
//			addChild(new (getDefinitionByName("WorldMapView") as Class)());
//			loader.remove("assets/world_map.swf");
//			addChild(new (getDefinitionByName("WorldMapView") as Class)());
		}
		protected function onProgress(event:BulkProgressEvent):void
		{
//			trace(event.loadingStatus());
		}
	}
}