package test
{
	import flash.display.Sprite;
	
	import czc.framework.utils.StringBuffer;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-6-9 下午4:45:43
	 * 
	 */
	public class Test extends Sprite
	{
		public function Test()
		{
			super();
			/*
			trace(A.prototype.constructor);      // [class A]
			trace(A.prototype.constructor == A); // true
			var myA:A = new A();
			trace(myA.constructor == A);         // true
			A.prototype.a = 10;
			trace(A.prototype.a);
			function aaaa():void
			{
			}
			A.prototype.aaaa = aaaa;
			var myA1:A = new A();
			trace(myA1["aaa"]);
			
			var buffer:StringBuffer = new StringBuffer();
			buffer.append("a");
			buffer.append("b");
			trace(buffer.toString());
			
			trace("a\rb");
			
			var arr:Array = [1,2];
			arr ||= [];
			trace("arr:" + arr);
			var obj:Object = {a:1,b:2};
			for (var key:String in obj)
			{
				trace("obj:" + key + "|" + obj[key]);
			}
			*/
			
			var a:int = 1;
			trace(a.toString(2));
		}
	}
}

dynamic  class A
{
	
	
}
