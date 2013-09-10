package test
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-9-10 上午10:11:19
	 * 
	 */
	public class HtmlSwfTest extends Sprite
	{
		private var tf:TextField;
		public function HtmlSwfTest()
		{
			super();
			
			tf = new TextField();
			tf.border = true;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.multiline = true;
			
			tf.x = 100;
				 
			tf.text = "vars---";
			
			addChild(tf);
			var vars:Object = this.loaderInfo.parameters;
			for(var key:String in vars)
			{
				trace("key:" + key + " value:" + vars[key]);
				tf.appendText("key:" + key + " value:" + vars[key] + "\n");
			}
		}
	}
}