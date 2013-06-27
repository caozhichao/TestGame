package test
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.data.SWFLoaderVars;
	
	import flash.display.Sprite;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-6-27 下午2:33:59
	 * 
	 */
	public class LoaderMaxTest extends Sprite
	{
		private var xmlLoader:XMLLoader;
		public function LoaderMaxTest()
		{
			super();
			var vars:SWFLoaderVars = new SWFLoaderVars();
			vars.onComplete(onComplete);
			xmlLoader = new XMLLoader("assets/battle_npc.xml",vars);
			xmlLoader.load();
		}
		
		private function onComplete(evt:LoaderEvent):void
		{
			var xml:XML  = xmlLoader.getContent("assets/battle_npc.xml");
			trace("LoaderMaxTest.onComplete()");
		}
	}
}