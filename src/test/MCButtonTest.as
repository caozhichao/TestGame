package test
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import czc.framework.component.MCButton;
	import czc.framework.manager.LoaderMaxManager;
	import czc.framework.vo.LoadItemVo;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-8-15 上午11:22:47
	 * 
	 */
	public class MCButtonTest extends Sprite
	{
		public function MCButtonTest()
		{
			super();
			var url:String = "assets/test1.swf";
			LoaderMaxManager.instance.simpleLoader(url,success);
		}
		
		private function success(item:LoadItemVo):void
		{
			var skin:MovieClip = new (item.domain.getDefinition("mc_button") as Class)();
			var mcButton:MCButton = new MCButton(skin,true);
			addChild(mcButton);
			trace();
		}
	}
}