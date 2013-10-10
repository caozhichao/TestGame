package test
{
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-10-10 上午10:55:54
	 * 
	 */
	public class TweenLiteTest extends Sprite
	{
		[Embed(source="../assets/00.png")]
		public var cla:Class;
		
		public function TweenLiteTest()
		{
			super();
			
			var sp : Shape = new Shape();
			sp.graphics.beginFill(0);
			sp.graphics.drawRect(0, 0, 800, 600);
			sp.graphics.endFill();
			sp.alpha = 0.3;
			
			
			var bmp:Bitmap = new cla();
			addChild(sp);
			
			var bmp2:Bitmap = new cla();
			bmp2.x = 200;
			addChild(bmp2);
			addChild(bmp);
			TweenMax.to(bmp, 0.3, {colorTransform:{brightness:0.5}});
			TweenMax.to(bmp2, 0.3, {colorTransform:{brightness:0.5}});
			TweenMax.to(bmp2, 0.3, {colorTransform:{brightness:1},delay:5});
			
		}
	}
}