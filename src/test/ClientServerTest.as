package test
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.utils.ByteArray;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-9-22 上午10:23:06
	 * 
	 */
	public class ClientServerTest extends Sprite
	{
		private var socket:Socket;
		private var logField:TextField;

		private var sendTxt:TextField;
		
		public function ClientServerTest()
		{
			super();
			setupUI();
		
			socket = new Socket();
			socket.addEventListener(Event.CONNECT,onConnect);
			socket.addEventListener(ProgressEvent.SOCKET_DATA,onSocketData);
			socket.addEventListener(IOErrorEvent.IO_ERROR,onIoError);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
			socket.addEventListener(Event.CLOSE,onClose);
			socket.connect("127.0.0.1",8888);
		}
		
		protected function onClose(event:Event):void
		{
			log("connect close");
		}
		
		protected function onSecurityError(event:SecurityErrorEvent):void
		{
			log(event.toString());
		}
		
		protected function onIoError(event:IOErrorEvent):void
		{
			log(event.toString());
		}
		
		protected function onConnect(event:Event):void
		{
			log("connect success:");
		}
		
		protected function onSocketData(event:ProgressEvent):void
		{
			var buffer:ByteArray = new ByteArray();
			socket.readBytes( buffer, 0, socket.bytesAvailable );
			log( "接受服务器的数据: " + buffer.toString() );
		}
		
		private function send(evt:MouseEvent):void
		{
			var value:String = sendTxt.text;
			log("发生数据..." + value);
			socket.writeMultiByte(value,"utf-8");
			socket.flush();
		}
		
		private function log( text:String ):void
		{
			logField.appendText( text + "\n" );
			logField.scrollV = logField.maxScrollV;
			trace( text );
		}
		
		
		private function setupUI():void
		{
			sendTxt = createTextField( 10, 10, "send input", "",true,100);
			createTextButton( 170, 110, "Send", send );
			logField = createTextField( 10, 135, "Log", "", false, 200 );
		}
		
		private function createTextField( x:int, y:int, label:String, defaultValue:String = '', editable:Boolean = true, height:int = 20 ):TextField
		{
			var labelField:TextField = new TextField();
			labelField.text = label;
			labelField.type = TextFieldType.DYNAMIC;
			labelField.width = 100;
			labelField.x = x;
			labelField.y = y;
			
			var input:TextField = new TextField();
			input.text = defaultValue;
			input.type = TextFieldType.INPUT;
			input.border = editable;
			input.selectable = editable;
			input.width = 280;
			input.height = height;
			input.x = x + labelField.width;
			input.y = y;
			
			this.addChild( labelField );
			this.addChild( input );
			
			return input;
		}
		
		private function createTextButton( x:int, y:int, label:String, clickHandler:Function ):TextField
		{
			var button:TextField = new TextField();
			button.htmlText = "<u><b>" + label + "</b></u>";
			button.type = TextFieldType.DYNAMIC;
			button.selectable = false;
			button.width = 180;
			button.x = x;
			button.y = y;
			button.addEventListener( MouseEvent.CLICK, clickHandler );
			
			this.addChild( button );
			return button;
		}        
		
	}
}