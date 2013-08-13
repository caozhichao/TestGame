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
			var b:A = new A();
			b.x = 150;
			b.y = 100;
			addChild(b);
			DragManager.instance.addDrag(b);
			function fun():void
			{
//				DragManager.instance.removeDrag(a);
			}
			setTimeout(fun,10000);
			
		}
	}
}
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.geom.Point;

import czc.framework.display.IDrag;
import czc.framework.manager.LoaderManager;
import czc.framework.manager.LoaderMaxManager;
import czc.framework.vo.LoadItemVo;

class A extends Sprite implements IDrag
{
	private var spr:Sprite;
	private var _mc:MovieClip;
	private var _cla:Class;
	public function A()
	{
//		this.graphics.beginFill(0xff0000);
//		this.graphics.drawRect(0,0,50,50);
//		this.graphics.endFill();
		
//		spr = dragDisplay as Sprite;
//		spr.x = 25;
//		spr.y = 25;
//		addChild(spr);
		var url:String = "assets/test1.swf"
		LoaderMaxManager.instance.simpleLoader(url,callback);
		function callback(item:LoadItemVo):void
		{
			var cla:Class = item.domain.getDefinition("action_2_1") as Class;
			_cla = cla;
			_mc = new cla();
			_mc.x = 10;
			_mc.y = 10;
			addChild(_mc);
		} 
	}
	public function get dragDisplay():DisplayObject
	{
//		var spr:Sprite = new Sprite();
//		spr.graphics.beginFill(0xff0000);
//		spr.graphics.drawRect(0,0,50,50);
//		spr.graphics.endFill();
//		return spr;
		return new _cla();
	}
	public function get content():DisplayObject
	{
		return this;
	}
	public function start():void
	{
	}
	public function draging():void
	{
	}
	public function stop():void
	{
	}
	public function get dragDisplayPoint():Point
	{
		var p:Point = this.localToGlobal(new Point(_mc.x,_mc.y));
		return p;
	}
}