package test.map
{
	import flash.display.Sprite;
	
	/**
	 * 瓷砖类
	 * 
	 * @author	eidiot (http://eidiot.net)
	 * @version	1.0
	 * @date	070416 
	 */	
	public class Tile extends Sprite
	{
		public function Tile(p_color : uint = 0xCCCCCC, p_w : int = 10, p_h : int = 10)
		{
			with (this.graphics)
			{
				lineStyle(1, 0x666666);
				beginFill(p_color);
				drawRect(0, 0, p_w, p_h);
				endFill();
			}
		}
	}
}