package test
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getDefinitionByName;
	
	import br.com.stimuli.loading.BulkLoader;
	
	import czc.framework.component.MCBitmap;
	import czc.framework.manager.TimerManager;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-9-9 下午2:04:22
	 * 
	 */
	public class MCBitmapTest extends Sprite
	{
		public function MCBitmapTest()
		{
			super();
//			var mc:CMovieClip = new CMovieClip("assets/test1.swf","recruit.background1");
//			addChild(mc);
			
			TimerManager.instance.init(20);
			
			var loader:BulkLoader = new BulkLoader("test");
			loader.logLevel = BulkLoader.LOG_INFO;
			var context:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
			//add url
			loader.add("assets/test1.swf",{"context":context});
			loader.addEventListener(BulkLoader.COMPLETE,onComplete);
			loader.start();
			function onComplete(evt:Event):void
			{
				var cla:Class = getDefinitionByName("aa") as Class;
				var skin:MovieClip;
				for (var i:int = 0; i < 100; i++) 
				{
//					/*
					skin = new cla() as MovieClip;
					var mc:MCBitmap = new MCBitmap(skin,true);
					mc.x = 50 + Math.random() * 750;
					mc.y = 50 + Math.random() * 550;
					addChild(mc);
//					*/
					
					/*
					skin = new cla();
					skin.x = 50 + Math.random() * 750;
					skin.y = 50 + Math.random() * 550;
					addChild(skin);
					*/
				}
				
			}
		}
	}
}