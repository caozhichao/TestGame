package
{
	import com.sociodox.theminer.TheMiner;
	
	import flash.display.Sprite;
	
	import test.TestTimer;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-8-1 下午2:06:38
	 * 
	 */
	public class TheMinerTest extends TestTimer
	{
		public function TheMinerTest()
		{
			super();
			this.addChild(new TheMiner(true));
		}
	}
}