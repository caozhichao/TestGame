package game.startup
{
	import br.com.stimuli.loading.BulkLoader;
	
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getDefinitionByName;
	
	import game.startup.event.StartupEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class InitLoadCommand extends Command
	{
		[Inject]
		public var load:BulkLoader;
		
		public function InitLoadCommand()
		{
			super();
		}
		override public function execute():void
		{
			trace("InitLoadCommand.execute()",load);
			load.add("assets/ui/mainUI.swf",{context:new LoaderContext(false,ApplicationDomain.currentDomain)});
			load.addEventListener(BulkLoader.COMPLETE, onAllItemsLoaded);
			load.start();
		}
		private function onAllItemsLoaded(evt:Event):void
		{
			trace("InitLoadCommand.onAllItemsLoaded(evt)");
			dispatch(new StartupEvent(StartupEvent.ENTER_GAME));
		}
	}
}