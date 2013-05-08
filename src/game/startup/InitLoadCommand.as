package game.startup
{
	import br.com.stimuli.loading.BulkLoader;
	
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
		}
	}
}