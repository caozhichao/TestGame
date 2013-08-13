package czc.framework.display
{
	import flash.display.DisplayObject;
	import flash.geom.Point;

	public interface IDrag
	{
		function get dragDisplay():DisplayObject;
		function get content():DisplayObject;
		function start():void;
		function draging():void;
		function stop():void;
		//拖动对象的起始坐标点，舞台坐标
		function get dragDisplayPoint():Point;
	}
}