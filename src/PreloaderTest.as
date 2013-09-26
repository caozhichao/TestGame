package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-9-22 上午11:20:23
	 * 
	 */
	[SWF(backgroundColor="#0", frameRate="30", width="1200", height="650")]
	public class PreloaderTest extends Sprite
	{
		private var loader:Loader;
		private var domain:ApplicationDomain;
		
		public function PreloaderTest()
		{
			super();
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
			domain = new ApplicationDomain();
			loader.load(new URLRequest("TestGame.swf"),new LoaderContext(false,domain));
		}
		
		protected function onComplete(event:Event):void
		{
			var cla:Class = domain.getDefinition("TestGame") as Class;
			var main:Sprite = new cla();
			this.addChildAt(main, 0);
		}
	}
}