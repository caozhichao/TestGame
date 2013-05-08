package czc.framework.commnd
{
	import org.robotlegs.mvcs.Command;
	
	public class InjectorActorCommand extends Command
	{
		public function InjectorActorCommand()
		{
			super();
		}
		protected function instanceInjector(cla:Class):*
		{
			var obj:* = injector.instantiate(cla);
			injector.mapValue(cla,obj);
			return obj;
		}
	}
}