package test
{
	import flash.display.Sprite;
	
	import czc.framework.component.ScrollPane;
	import czc.framework.manager.LoaderMaxManager;
	import czc.framework.vo.LoadItemVo;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-8-9 下午4:25:34
	 * 
	 */
	public class ScrollTest extends Sprite
	{
		public function ScrollTest()
		{
			super();
			var url:String = "assets/test1.swf";
			LoaderMaxManager.instance.simpleLoader(url,onComplete);
			function onComplete(item:LoadItemVo):void
			{
				var scrollSkin:Sprite = new (item.domain.getDefinition("ui_scroll") as Class)();
				var scrollPane:ScrollPane = new ScrollPane();
				
//				scrollPane.setSize(
			}
		}
	}
}