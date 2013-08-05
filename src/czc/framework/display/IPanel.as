package czc.framework.display
{
	import flash.display.DisplayObject;

	/**
	 * 
	 * @author caozhichao
	 * 
	 */	
	public interface IPanel
	{
		function resize(stageWidth:int,stageHeight:int):void;
		
		function get content():DisplayObject;
	}
}