package test
{
	import czc.framework.display.ViewStruct;
	
	import org.robotlegs.mvcs.Command;
	
	public class TestCommand extends Command
	{
		[Inject]
		public var viewStruct:ViewStruct;
		
		public function TestCommand()
		{
			super();
		}
		override public function execute():void
		{
			trace("TestCommand.execute()", viewStruct);
		}
	}
}