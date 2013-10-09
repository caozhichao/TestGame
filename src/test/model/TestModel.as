package test.model
{
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-10-8 下午1:55:55
	 * 
	 */
	public class TestModel
	{
		private static var count:int;
		public var id:int;
		public function TestModel()
		{
			count++;
			id = count;
		}
	}
}