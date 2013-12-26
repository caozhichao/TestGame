package test
{
	import com.greensock.TweenLite;
	import com.greensock.plugins.ScrollRectPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-12-25 下午6:54:46
	 * 
	 */
	public class ScrollRectTest extends Sprite
	{
		public function ScrollRectTest()
		{
			super();
			
			TweenPlugin.activate([ScrollRectPlugin]);
			
			var circle:Sprite = new Sprite();
			circle.graphics.beginFill(0xFFCC00);
			circle.graphics.drawCircle(200, 200, 200);
			circle.scrollRect = new Rectangle(0, 0, 200, 200);
			addChild(circle);
			
			circle.addEventListener(MouseEvent.CLICK, clicked);
			
			function clicked(event:MouseEvent):void {
				var rect:Rectangle = event.target.scrollRect;
				rect.y -= 10;
//				TweenLite.to(rect,1,{y:rect.y - 5});
				TweenLite.to(circle, 0.5, {scrollRect:{left:rect.left, right:rect.right, top:rect.top, bottom:rect.bottom}});
//				TweenLite.to(circle, 1, {scrollRect:{left:0, right:288, top:0, bottom:216}});
//				TweenLite.to(circle,1,{scrollRect:rect});
//				event.target.scrollRect = rect;
			}


		}
	}
}