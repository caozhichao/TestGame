package czc.framework.utils
{
	import flash.net.getClassByAlias;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-7-30 下午3:40:10
	 * 
	 */
	public class CopyUtil
	{
		public function CopyUtil()
		{
			
		}
		
		/**
		 * 对象拷贝 非可视对象
		 * ByteArray copy Object
		 * @param value          copy instance
		 * @param classObject    instance Class
		 * @return               instance
		 * 
		 */		
		public static function copy(value:*,classObject:Class):*
		{
			var className:String = getQualifiedClassName(value);
			try
			{  //检查是否AMF序列化
				getClassByAlias(className);
			} 
			catch(error:ReferenceError) 
			{   //序列化
				registerClassAlias(className,classObject);
			}
			var bytes:ByteArray = new ByteArray();
			bytes.writeObject(value);
			bytes.position = 0;
			return bytes.readObject();
		}
	}

}