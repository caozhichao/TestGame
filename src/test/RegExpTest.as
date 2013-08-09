package test
{
	import flash.display.Sprite;
	
	import czc.framework.manager.LoaderMaxManager;
	import czc.framework.vo.LoadItemVo;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-8-9 上午11:21:46
	 * 
	 */
	public class RegExpTest extends Sprite
	{
		public function RegExpTest()
		{
			super();
			
			/*
			LoaderMaxManager.instance.simpleLoader("assets/a.txt",onComplete);
			function onComplete(item:LoadItemVo):void
			{
				trace(String(item.data).replace("\\n","\n"));
			}
			*/
			var str:String = "15ab2c3a3fcafG";
			var arr:Array = str.match(/\d{2}/gi);
			trace(arr);
		}
		
	}
}