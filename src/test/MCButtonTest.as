package test
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.setTimeout;
	
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
			addChild(skin);
			var mcButton:MCButton = new MCButton(skin,true);
			addChild(mcButton);
			mcButton.label = "abc";
			function onClick(evt:MouseEvent):void
			{
				mcButton.setCurButtonState = MCButton.FRAME_CAN_NOT_CLICK;
			}
			mcButton.addEventListener(MouseEvent.CLICK,onClick);
			
			
			return;
			function a():void
			{
				trace("ddd" + (skin.getChildByName("_label") as TextField).text);
			}
			skin.addFrameScript(0,a,1,a,2,a);
//			
//			for (var i:int = 0; i < 3; i++) 
//			{
//				skin.gotoAndStop(i + 1);
//			}
//			return;
			function enterFrame(evt:Event):void
			{
				trace("");
			}
			skin.addEventListener(Event.ENTER_FRAME,enterFrame);
			
//			setTimeout(aaa,5000);
//			function aaa():void
//			{
//				var mcButton:MCButton = new MCButton(skin,true);
//				addChild(mcButton);
//				trace();
//				mcButton.label = "abc";
//			}
		}
	}
}