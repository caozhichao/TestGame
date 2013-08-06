package test
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	
	import czc.framework.manager.LoaderMaxManager;
	import czc.framework.manager.TimerManager;
	import czc.framework.vo.LoadItemVo;
	
	/**
	 *		
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
			LoaderMaxManager.instance.simpleLoader(url,success);
			function success(item:LoadItemVo):void
			{
//				var domain:ApplicationDomain = item.domain;
//				var cls:Vector.<String> = domain.getQualifiedDefinitionNames();
				LoaderMaxManager.instance.unloadAndStop(url);
				trace("sssssssss");
			}
		}
	}
}