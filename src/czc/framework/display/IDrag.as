package czc.framework.display
{
	import flash.display.DisplayObject;
	import flash.geom.Point;

	public interface IDrag
	{
		//拖动时显示的图片
		function get dragDisplay():DisplayObject;
		//拖动的对象
		function get content():DisplayObject;
		//开始拖动
		function start():void;
		//拖动中
		function draging():void;
		//停止拖动
		function stop():void;
		//拖动对象的起始坐标点，舞台坐标
		function get dragDisplayPoint():Point;
	}
}