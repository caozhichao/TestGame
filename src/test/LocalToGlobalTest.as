package test
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-5-31 下午5:25:55
	 * 
	 */
	public class LocalToGlobalTest extends Sprite
	{
		public function LocalToGlobalTest()
		{
			super();
			
			var square:Sprite = new Sprite();
			square.graphics.beginFill(0xFFCC00);
			square.graphics.drawRect(0, 0, 50, 50);
			square.x = 0;
			square.y = 0;
			addChild(square);
			stage.addEventListener(MouseEvent.CLICK, traceCoordinates)
			function traceCoordinates(event:MouseEvent):void {
				var clickPoint:Point = new Point(square.mouseX, square.mouseY);
				trace("display object coordinates:", clickPoint);
				trace("stage coordinates:", square.localToGlobal(clickPoint));
				var p:Point = square.localToGlobal(clickPoint);
				function onComplete():void
				{
					square.x = 0;
					square.y = 0;
				}
				TweenLite.to(square,1,{x:stage.mouseX,y:stage.mouseY,onComplete:onComplete});
			}
		}
	}
}