package test
{
	import com.bit101.components.PushButton;
	
	import flash.display.Sprite;
	
	import czc.framework.manager.PopUpManager;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-8-2 上午10:16:26
	 * 
	 */
	public class PanelTest extends Sprite
	{
		public function PanelTest()
		{
			super();
			var layer:Sprite = new Sprite();
			addChild(layer);
			PopUpManager.instance.init(layer);
			
			var p:Sprite = getPanel(0xff0000);
			PopUpManager.instance.showPanel(p,true,true);
			p = getPanel(0x00ff00,100,100);
			PopUpManager.instance.showPanel(p,true,true);
			
			
			
			
			
			function onDelete():void
			{
//				PopUpManager.instance.removePanel(p);
//				PopUpManager.instance.removeAllPanels();
//				trace(PopUpManager.instance.hasShowPanel(p));
				PopUpManager.instance.showPanel(p);
			}
			var button:PushButton = new PushButton(this,0,0,"delete",onDelete);
		}
		
		private function getPanel(color:uint,w:int=100,h:int=150):Sprite
		{
			var panel:Sprite = new Sprite();
			panel.graphics.beginFill(color);
			panel.graphics.drawRect(0,0,w,h);
			panel.graphics.endFill();
			return panel;
		}
	}
}