package czc.framework.display
{
	/**
	 * 
	 * @author caozhichao
	 * 
	 */	
	public class ViewStruct
	{
		private static var layer:int = 0;
		public static const MAIN:int = layer++;
		public static const UI:int = layer++;
		public static const POPUP:int = layer++;
		public static const TIPS:int = layer++;
		
		public function ViewStruct()
		{
		}
	}
}