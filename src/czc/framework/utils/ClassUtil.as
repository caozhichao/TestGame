package czc.framework.utils
{
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-8-5 上午11:47:53
	 * 
	 */
	public class ClassUtil
	{
		public function ClassUtil()
		{
		}
		
		public static function getClass(obj:Object):Class
		{
			return obj["constructor"];
		}
	}
}