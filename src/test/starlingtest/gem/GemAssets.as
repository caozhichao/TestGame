package test.starlingtest.gem
{
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-12-10 上午10:33:27
	 * 
	 */
	public class GemAssets
	{
		[Embed(source="../../../assets/gem/gem.xml",mimeType="application/octet-stream")]
		public static const gem_xml:Class;
		[Embed(source="../../../assets/gem/gem.png")]
		public static const gem:Class;
		public function GemAssets()
		{
		}
	}
}