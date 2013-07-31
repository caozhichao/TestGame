package test
{
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	import czc.framework.utils.CopyUtil;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-7-30 下午3:24:21
	 * 
	 */
	public class ByteArrayTest extends Sprite
	{
		public function ByteArrayTest()
		{
			super();
			
			var bytes:ByteArray = new ByteArray();
			/*
			var arr:Array = [1,2];
			bytes.writeObject(arr);
			
			bytes.position = 0;
			var copyArr:Array = bytes.readObject();
			*/
			var a1:A = new A(100);
			a1.b = 500;
//			a1.a = 100;
			var copya1:A = CopyUtil.copy(a1,A);
			trace(copya1.getA() + "|" + copya1.b);
//			var copya2:A = CopyUtil.copy(copya1,A);
//			var spr:Sprite = new Sprite();
//			var copySpr:Sprite = CopyUtil.copy(spr,Sprite);
			trace("ByteArrayTest.ByteArrayTest()");
		}
	}
}


class A
{
	private var _a:int;
	public var b:int;
	public var str:String;
	
	public function A(a:int = -1)
	{
		_a = a;
	}
	
	/*
	public function writeExternal(output:IDataOutput):void
	{
		output.writeInt(_a);
	}
	
	public function readExternal(input:IDataInput):void
	{
		_a = input.readInt();
	}
	*/
	public function getA():int
	{
		return _a;
	}
	
	
//	public function set a(value:int):void
//	{
//		_a = value;
//	}
//	public function get a():int
//	{
//		return _a;
//	}
}