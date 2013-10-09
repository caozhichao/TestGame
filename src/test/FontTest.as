package test
{
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.GridFitType;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-8-1 下午5:32:30
	 * 
	 */
	public class FontTest extends Sprite
	{
//		[Embed(source="../assets/font.swf", symbol="MyFont")]
//		[Embed(source="../assets/pf_ronda_seven.swf", symbol="PF Ronda Seven")]
		[Embed(source="../assets/font1.swf",symbol="MyFont1")]
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
			_tf.type = TextFieldType.DYNAMIC;
//			_tf.thickness = 400;
			_tf.antiAliasType = AntiAliasType.ADVANCED;
//			_tf.gridFitType = GridFitType.PIXEL;
			var format:TextFormat = new TextFormat("Microsoft YaHei"/*"CTCuYuanSF"*/, 12/*Style.fontSize*/);
			format.color = 0xff0000;
			format.size = 12;
//			format.bold = true;
			_tf.defaultTextFormat = format;
			_tf.text = "啊不的";
			addChild(_tf);
		}
	}
}