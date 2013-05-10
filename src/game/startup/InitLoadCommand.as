package game.startup
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	import br.com.stimuli.loading.loadingtypes.LoadingItem;
	
	import czc.framework.manager.LoaderManager;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.StatusEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.System;
	import flash.utils.getDefinitionByName;
	
	import game.startup.event.StartupEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class InitLoadCommand extends Command
	{
		[Inject]
		public var loaderManager:LoaderManager;
		public function InitLoadCommand()
		{
			super();
		}
		override public function execute():void
		{
			loaderManager.load(["assets/ui/mainUI.swf","assets/ui/component.swf","assets/ui/bitFaceSpace.swf","assets/ui/world_map.swf"],onAllComplete,ApplicationDomain.currentDomain);
		}
		
		private function onAllComplete():void
		{
			dispatch(new StartupEvent(StartupEvent.ENTER_GAME));
		}
	}
}