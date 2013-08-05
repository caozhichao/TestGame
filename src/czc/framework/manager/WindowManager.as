package czc.framework.manager
{
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-8-5 上午9:29:48
	 * 
	 */
	public class WindowManager
	{
		public static var instance:PopUpManager = new PopUpManager();
		public function WindowManager()
		{
			if(instance)
			{
				throw new Error("WindowManager a single");
			}
		}
	}
}