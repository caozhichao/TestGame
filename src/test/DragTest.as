package test
{
	import flash.display.Sprite;
	import flash.utils.setTimeout;
	
	import czc.framework.manager.DragManager;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-8-5 下午3:09:52
	 * 
	 */
	public class DragTest extends Sprite
	{
		public function DragTest()
		{
			super();
			var spr:Sprite = new Sprite();
			this.addChild(spr);
			DragManager.instance.init(spr);
			var a:A = new A();
			addChild(a);
			a.x = 100;
			a.y = 100;
			DragManager.instance.addDrag(a);
			function fun():void
			{
				DragManager.instance.removeDrag(a);
			}
			setTimeout(fun,10000);
			
		}
	}
}
import flash.display.DisplayObject;
import flash.display.Sprite;

import czc.framework.display.IDrag;

class A extends Sprite implements IDrag
{
	public function A()
	{
		this.graphics.beginFill(0xff0000);
		this.graphics.drawRect(0,0,50,50);
		this.graphics.endFill();
	}
	public function get moveDisplayObject():DisplayObject
	{
		var spr:Sprite = new Sprite();
		spr.graphics.beginFill(0xff0000);
		spr.graphics.drawRect(0,0,50,50);
		spr.graphics.endFill();
		return spr;
	}
	public function get content():DisplayObject
	{
		return this;
	}
	public function dragMove():void
	{
		
	}
	public function stopDragMove():void
	{
		
	}
}