package czc.framework.display
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	/**
	 * 
	 * @author caozhichao
	 * 
	 */	
	public class ViewStruct
	{
		private static var layer:int = 0;
		private var _layers:Array;
		public static const MAIN:int = layer++;
		public static const UI:int = layer++;
		public static const POPUP:int = layer++;
		public static const TIPS:int = layer++;
		
		public function ViewStruct()
		{
		}
		
		public function init(contextView:DisplayObjectContainer):void
		{
			_layers = [];
			var len:int = layer;
			for (var i:int = 0; i < len; i++) 
			{
				var sp : Sprite= new Sprite();
				contextView.addChild(sp);
				_layers[i] = sp;
			}
		}
		
		public function getLayerById(layerId:int):Sprite
		{
			return _layers[layerId];
		}
		
	}
}