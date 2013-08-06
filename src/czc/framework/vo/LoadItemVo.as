package czc.framework.vo
{
	import flash.system.ApplicationDomain;
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-8-6 上午9:35:38
	 * 
	 */
	public class LoadItemVo
	{
		public var url:String;
		public var domain:ApplicationDomain;
		public var onComplete:Function;
		public var data:*;
		
		public function LoadItemVo()
		{
		}
	}
}