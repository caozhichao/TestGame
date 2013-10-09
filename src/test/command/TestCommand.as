package test.command
{
	import org.robotlegs.mvcs.Command;
	
	import test.model.TestModel;
	import test.view.TestView;
	
	public class TestCommand extends Command
	{
		[Inject(name="testModel1")]
		public var testModel1:TestModel;
		
		public function TestCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			trace("testModel1:" + testModel1);
		}
	}
}