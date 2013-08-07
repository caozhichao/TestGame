package czc.framework.utils
{
	import flash.display.DisplayObjectContainer;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-8-7 下午5:02:17
	 * 
	 */
	public class Reflection
	{
		public function Reflection()
		{
		}
		
		/**
		 * 类属性实例化
		 * @param target
		 * @param skin
		 * 
		 */		
		public static function reflection(target:Object,skin:DisplayObjectContainer):void
		{
			var t:Number = getTimer();
			var xml:XML = describeType(skin);
			var variables : XMLList = xml.child("variable");
			var name:String;
			for each(var item:XML in variables)
			{
				name = item.@name;
				if(target.hasOwnProperty(name))
				{
					target[name] = skin.getChildByName(name);
				} else 
				{
					trace(target + "中未定义" + name + "属性");
				}
			}
			trace("reflection 消耗time " + (getTimer() - t));
		}
	}
}