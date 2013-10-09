package test
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-10-8 上午9:47:16
	 * 
	 */
	public class EmbedTest extends Sprite
	{
		[Embed(source="../assets/test1.swf",symbol="EmbedSkin")]
		private var cla:Class;
		public function EmbedTest()
		{
			super();
			var spr:Sprite = new cla();
			var tf:TextField = spr.getChildByName("_tf") as TextField;
			tf.text = "abc";
			addChild(spr);
		}
	}
}