package test
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.ByteArray;
	import flash.utils.CompressionAlgorithm;
	import flash.utils.getTimer;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-7-25 下午2:57:04
	 * 
	 */
	public class Test2 extends Sprite
	{
		 private var _loader:Loader = new Loader();
         private var _urlstream:URLStream = new URLStream();
         private var _data:ByteArray = new ByteArray();
         public function Test2():void 
         {
	            var loadmenu:ContextMenuItem = new ContextMenuItem("Load image");
	            loadmenu.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, this.onLoadImage, false);
	             this.contextMenu = new ContextMenu();
	            this.contextMenu.customItems.push(loadmenu);
	             _urlstream.addEventListener('progress', processData);
	             _urlstream.addEventListener('complete', onComplete);
	            addChild(_loader);
	            stage.align = StageAlign.TOP_LEFT;
	      }
         public function onLoadImage(e:Event):void
         {
             _loader.unload();
             _data.length = 0;
             var url:String = /*"http://files.cnblogs.com/Greatest/test.jpg.zip"*/"assets/map1.jpg";
             _urlstream.load(new URLRequest(url + "?q=" + getTimer()))
	      }
         public function processData(e:Event):void
         {
			 /*
	         var oldlen:int = _data.length;
	         _urlstream.readBytes(_data, _data.length);
	         if (_data.length > oldlen)
	          {
	             _loader.loadBytes(_data);
		      }
			 */
	      }
		 public function onComplete(evt:Event):void
		 {
			 var byts:ByteArray = new ByteArray();
			 _urlstream.readBytes(byts);
			 byts.compress(CompressionAlgorithm.LZMA);
			 
			 byts = LZMA.decode(byts);
			 
			 _loader.loadBytes(byts);
		 }
	}
}