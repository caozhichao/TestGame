package czc.framework.utils
{
	
	/**
	 * 字符串连接处理		
	 * @author caozhichao
	 * 创建时间：2013-6-14 下午5:31:06
	 * 
	 */
	public class StringBuffer
	{
		private var _buffer:Array;
		
		public function StringBuffer()
		{
			_buffer = [];
		}
		public function append(value:String):void {
			this._buffer.push(value);
		}
		public function toString():String {
			return this._buffer.join("");
		}
	}
}