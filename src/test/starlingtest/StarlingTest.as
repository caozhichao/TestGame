package test.starlingtest
{
	import flash.display.Sprite;
	
	import starling.core.Starling;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-11-20 下午1:52:20
	 * 
	 */
	public class StarlingTest extends Sprite
	{
		private var _starling:Starling;
		
		public function StarlingTest()
		{
			super();
			_starling = new Starling(StarlingGame,stage);
			_starling.showStats = true;
			_starling.start();
		}
	}
}