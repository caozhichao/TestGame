package czc.framework.manager
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	/**
	 * 弹窗管理 
	 * @author caozhichao
	 * 
	 */	
	public class PopUpManager
	{
		private var _container:DisplayObjectContainer
		public function PopUpManager()
		{
		}
		
		public function init(spr:Sprite):void
		{
			_container = spr;
		}
	}
}