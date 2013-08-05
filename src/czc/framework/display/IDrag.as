package czc.framework.display
{
	import flash.display.DisplayObject;

	public interface IDrag
	{
		function get moveDisplayObject():DisplayObject;
		function get content():DisplayObject;
		function dragMove():void;
		function stopDragMove():void;
	}
}