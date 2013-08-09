package czc.framework.manager
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.DataLoader;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.core.LoaderCore;
	
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	
	import czc.framework.vo.LoadItemVo;
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-8-5 下午5:46:56
	 * 
	 */
	public class LoaderMaxManager
	{
		public static var instance:LoaderMaxManager = new LoaderMaxManager();
		//简单加载
		private var _simpleLoader:LoaderMax;
		private var _urls:Dictionary;
		public function LoaderMaxManager()
		{
			if(instance)
			{
				throw new Error("LoaderMaxManager a single");
			}
			LoaderMax.activate([SWFLoader,ImageLoader,XMLLoader]);
			LoaderMax.defaultAuditSize = false;
			_simpleLoader = new LoaderMax({maxConnections:1});
			
			_urls = new Dictionary();
			
		}
		
		public function simpleLoader(url:String,success:Function=null,fail:Function=null):void
		{
			var domain:ApplicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
			var item:LoadItemVo = getLoadItemVo(url,domain);
			var context:LoaderContext = new LoaderContext(false, domain);
			var child:LoaderCore = LoaderMax.parse(url,{context:context,onComplete: onComplete});
			_simpleLoader.append(child);
			_simpleLoader.load();
			setURL(url,_simpleLoader);
			function onComplete(evt:LoaderEvent):void
			{
				if(child is ImageLoader)
				{
					item.data = (child as ImageLoader).rawContent;
				} else if (child is DataLoader)
				{
					item.data = (child as DataLoader).content;
				}
				success(item);
			}
		}
		
		private function load(list:Array,success:Function,fail:Function):void
		{
			
		}
		
		private function setURL(url:String,loader:LoaderMax):void
		{
			_urls[url] = loader;
		}
		
		private function getLoadItemVo(url:String,domain:ApplicationDomain):LoadItemVo
		{
			var item:LoadItemVo = new LoadItemVo();
			item.url = url;
			item.domain = domain;
			return item
		}
		
		public function unloadAndStop(url:String):void
		{
			var loaderMax:LoaderMax = _urls[url];
			var loaderCore:LoaderCore = loaderMax.getLoader(url);
			loaderMax.remove(loaderCore);
			loaderCore.dispose();
			delete _urls[url];
		}
	}
}