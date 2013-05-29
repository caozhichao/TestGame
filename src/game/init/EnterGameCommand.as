package game.init
{
	import czc.framework.display.ViewStruct;
	
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	
	import org.robotlegs.mvcs.Command;
	
	public class EnterGameCommand extends Command
	{
		[Inject]
		public var struct:ViewStruct;
		
		public function EnterGameCommand()
		{
			super();
		}
		override public function execute():void
		{
			var sp:Sprite = struct.getLayerById(ViewStruct.POPUP);
			var cla:Class = getDefinitionByName("ui.number.blue") as Class;
			sp.addChild(new cla());
		}
	}
}