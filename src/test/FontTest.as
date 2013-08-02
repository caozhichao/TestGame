package test
{
	import flash.display.Sprite;
	import flash.net.registerClassAlias;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-8-1 下午5:32:30
	 * 
	 */
	public class FontTest extends Sprite
	{
		[Embed(source="../assets/font.swf", symbol="MyFont")]
//		[Embed(source="../assets/pf_ronda_seven.swf", symbol="PF Ronda Seven")]
		protected var MyFont:Class;
		
		private var _tf:TextField;
		
		public function FontTest()
		{
			super();
//			Font.registerFont(MyFont);
			var a:Array = Font.enumerateFonts();  
            trace(a);  
            for each(var obj:Object in a){  
                trace(Font(obj).fontName);  
                trace(Font(obj).fontStyle);  
                trace(Font(obj).fontType);  
            }  
			_tf = new TextField();
			_tf.x = 100;
			_tf.y = 100;
			_tf.border = true;
			_tf.embedFonts = true;
			_tf.selectable = false;
			_tf.mouseEnabled = false;
			_tf.defaultTextFormat = new TextFormat("CTCuYuanSF", 14/*Style.fontSize*/, 0x666666);
			
			_tf.text = "啊a1";
			addChild(_tf);
			
		}
	}
}