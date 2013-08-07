package test
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import czc.framework.manager.LoaderMaxManager;
	import czc.framework.utils.Reflection;
	import czc.framework.vo.LoadItemVo;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-8-7 下午5:16:51
	 * 
	 */
	public class ReflectionTest extends Sprite
	{
		private var skin:Sprite;
		public var _tf:TextField;
		public var _spr:Sprite;
		public function ReflectionTest()
		{
			super();
			var url:String = "assets/test1.swf";
			LoaderMaxManager.instance.simpleLoader(url,onComplete);
			var t:ReflectionTest = this;
			function onComplete(item:LoadItemVo):void
			{
				skin = new (item.domain.getDefinition("ui.Test"))();
				Reflection.reflection(t,skin);
			}
		}
	}
}