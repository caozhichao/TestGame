package test
{
	import com.adobe.crypto.MD5;
	import com.bit101.components.Label;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.CompressionAlgorithm;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-6-9 下午4:45:43
	 * 
	 */
	public class Test extends Sprite
	{
//		private var loader:URLLoader;
		private static var dic:Dictionary = new Dictionary();
		private var bd:BitmapData;
		private var loader:Loader;
		private var bm:Bitmap;
		
//		[Inline]
		final private function getValue(i:int):int
		{
			return i + 1;
		}
		
		public function Test()
		{
			super();
			var len:int = 4000000;
			var value:int;
			var t:Number = getTimer();
			for (var i:int = 0; i < len; i++) 
			{
//				value = i + 1;
				value = getValue(i);
			}
			trace(getTimer() - t);
			
			/*
			var label:Label = new Label();
			label.text = "d啊";
			label.x = 100;
			label.y = 100;
			addChild(label);
			*/
			/*
			var a:uint = 0x01 & 0x02;
			var b:uint = 0x02 & 0x03;
			var c:uint = 0x01 | 0x02;
			trace(a,b,c);
			*/
			
			/*
			进制
			2     16     10
			
			0001 ->0x01 -> 1
		  & 0010 ->0x02 -> 2 
		--------
			0000 
			*/
			
			/*
			var a:int = 1;
			trace(a.toString(2));
			a = a << 1;
			trace(a.toString(2));
			*/
			/*
			for(var i:int = 0; i < 10; i++)
			{
				var str:int;
				if(i == 0 )
				{
					str = 100;
				}
				trace(i + "|" + str);
			}
			*/
//			CompressionAlgorithm.LZMA
			
			/*
			function a(b:int):void
			{
//				rest.length
			}
			trace(a.length);
			trace(a.hasOwnProperty("length"));
			*/
			
			/*
			var md5:String = MD5.hash("loginUI");
			trace(md5);
			*/
			/*
			var panel:Sprite = this;
			loader = new Loader();
			var domain:ApplicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
			var context:LoaderContext = new LoaderContext(false);
			function onComplete(evt:Event):void
			{
				trace("Test.onComplete(evt)");
				loader.unloadAndStop(true);
			}
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
			loader.load(new URLRequest("assets/world_map.swf"),new LoaderContext(false,new ApplicationDomain(ApplicationDomain.currentDomain)));
			function onFrame(evt:Event):void
			{
				for (var i:int = 0; i < 100000; i++) 
				{
					new Sprite();
				}
			}
			addEventListener(Event.ENTER_FRAME,onFrame);
			*/
			/*
			var label:Label = new Label();
			label.text = "label";
			label.x = 100;
			label.y = 100;
			addChild(label);
			*/
			/*
//			Security.loadPolicyFile("http://127.0.0.1:8080/crossdomain.xml");
			loader = new URLLoader();
			function onComplete(evt:Event):void
			{
				trace(loader.data);
			}
			loader.addEventListener(Event.COMPLETE,onComplete);
			var url:URLRequest = new URLRequest("http://127.0.0.1:8080/bin/gameSetting.xml");
			loader.load(url);
			*/
			
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
			
//			var a:int = 1 << 24;
//			trace(a.toString(16));
//			var m:MapMaskHelper = new MapMaskHelper();
			/*
			var timer:Timer = new Timer(50);
			timer.addEventListener(TimerEvent.TIMER,onTimer);
			var index:int = 0;
			function onTimer(evt:TimerEvent):void
			{
				tf.appendText(index + "");
				index++;
			}
			timer.start();
			var tf:TextField = new TextField;
//			tf.border = true;
			tf.autoSize = TextFieldAutoSize.LEFT;
			addChild(tf);
			*/
//			addEventListener(Event.ADDED_TO_STAGE,onAdd);
			
			/*
			var a:Sprite;
			a ||= new Sprite();
			a = a || new Sprite();
			trace(a);
			*/
			
			var str:Sprite = new Sprite();
			trace(getMemoryName(str));
		}
		
		public function getMemoryName(obj:Object):String
		{
			var memoryHash:String;
			try
			{
				　　Test(obj);
			}
			catch(e:Error)
			{
				//获取内存地址哈希值
				　　memoryHash =String(e).replace(/.*([@|\$].*?) 转换为 .*$/gi,'$1');
			}
			return memoryHash;
		}
		
		
		protected function onAdd(event:Event):void
		{
			stage.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			var fileReference:FileReference = new FileReference();
			fileReference.browse();
			function onSelect(evt:Event):void
			{
//				fileReference.load();
				var url:URLRequest = new URLRequest("http://192.168.85.15:8080/test/t.xml");
				fileReference.upload(url);
			}
			function onComplete(evt:Event):void
			{
				var bytes:ByteArray = fileReference.data;
				var str:String = bytes.readMultiByte(bytes.length,"utf-8");
				trace(str);
			}
			fileReference.addEventListener(Event.SELECT,onSelect);
			fileReference.addEventListener(Event.COMPLETE,onComplete);
		}
	}
}

dynamic  class A
{
	
	
}
