package game.init.commond
{
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	
	import br.com.stimuli.loading.BulkLoader;
	
	import czc.framework.manager.LoaderManager;
	
	import game.init.event.InitGameEvent;
	
	import org.robotlegs.mvcs.Command;
	
	
	/**
	 * @author caozhichao
	 * 创建时间：2013-5-29 下午2:47:25
	 * 
	 */
	public class InitConfigCommand extends Command
	{
		[Inject]
		public var loaderManager:LoaderManager;
		
		public function InitConfigCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			loaderManager.load(["assets/battle_npc.xml"],onComplete,ApplicationDomain.currentDomain);
		}
		
		private function onComplete(loader:BulkLoader):void
		{
			// true 是否释放资源
			var xml:XML = loader.getXML("assets/battle_npc.xml",true);
			dispatch(new InitGameEvent(InitGameEvent.INIT_MODEL));
		}
	}
}