package test
{
	import com.bit101.components.PushButton;
	
	import flash.display.Sprite;
	
	import czc.framework.display.IPanel;
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
			PopUpManager.instance.init(layer,[[B,A]]);
			
			var p:Sprite = getPanel(0xff0000);
			var cla:Class = p["constructor"];
			PopUpManager.instance.showPanel(p as IPanel,true,true);
			var b:Sprite = new B(0x00ff00,100,100);
			PopUpManager.instance.showPanel(b as IPanel,true);
			
			function onDelete():void
			{
//				PopUpManager.instance.removePanel(p);
//				trace(PopUpManager.instance.hasShowPanel(p));
				PopUpManager.instance.showPanel(b as IPanel);
//				PopUpManager.instance.removePanels(PopUpManager.instance.panels);
			}
			var button:PushButton = new PushButton(this,0,0,"delete",onDelete);
		}
		
		private function getPanel(color:uint,w:int=100,h:int=150):Sprite
		{
			/*
			var panel:Sprite = new Sprite();
			panel.graphics.beginFill(color);
			panel.graphics.drawRect(0,0,w,h);
			panel.graphics.endFill();
			return panel;
			*/
			var a:A = new A(color,w,h);
			return a;
		}
	}
}
import flash.display.DisplayObject;
import flash.display.Sprite;

import czc.framework.display.IPanel;

class A extends Sprite implements IPanel
{
	public function A(color:uint,w:int,h:int)
	{
		this.graphics.beginFill(color);
		this.graphics.drawRect(0,0,w,h);
		this.graphics.endFill();
	}
	public function resize(stageWidth:int,stageHeight:int):void
	{
		this.x = stageWidth - this.width - 10;
		this.y = stageHeight - this.height - 10;
	}
	public function get content():DisplayObject
	{
		return this;
	}
}

class B extends Sprite implements IPanel
{
	public function B(color:uint,w:int,h:int)
	{
		this.graphics.beginFill(color);
		this.graphics.drawRect(0,0,w,h);
		this.graphics.endFill();
	}
	public function resize(stageWidth:int,stageHeight:int):void
	{
		this.x = stageWidth - this.width - 10;
		this.y = stageHeight - this.height - 10;
	}
	public function get content():DisplayObject
	{
		return this;
	}
}

class C extends Sprite implements IPanel
{
	public function C(color:uint,w:int,h:int)
	{
		this.graphics.beginFill(color);
		this.graphics.drawRect(0,0,w,h);
		this.graphics.endFill();
	}
	public function resize(stageWidth:int,stageHeight:int):void
	{
		this.x = stageWidth - this.width - 10;
		this.y = stageHeight - this.height - 10;
	}
	public function get content():DisplayObject
	{
		return this;
	}
}
