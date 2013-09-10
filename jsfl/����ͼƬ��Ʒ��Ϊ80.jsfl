
/*
var folderURI  = fl.browseForFolderURL("选择文件夹");
fl.outputPanel.clear();
if(folderURI)
{
	//fl.trace(folderURI);
	var folderContents = FLfile.listFolder(folderURI);
	 for each (var path in folderContents)
     {		
	 	  
		  
		  if(path.split(".")[1] == "fla")
		  {
			  fl.trace("path:" + path);
			 var dom = fl.openDocument(folderURI + "/" + path);
		 	 setBitmapQuality80(dom);
		  	fl.saveDocument(fl.getDocumentDOM());
		  	//fl.trace(path.substr(0,path.length-4)+".swf");
		  	dom.exportSWF(folderURI + "/" + path.substr(0,path.length-4)+".swf",true);
          	dom.close(false);
		  }
		  
	 }
}
*/

setBitmapQuality80(fl.getDocumentDOM());
function setBitmapQuality80(doc)
{
	//var doc = fl.getDocumentDOM();
	
	var lib = doc.library;
	var items = lib.items;
	var len = items.length;
	var item;
	for(var i = 0; i <  len; i++)
	{
		item = items[i];
	
		if(item.itemType == "bitmap")
		{
			fl.trace(item.itemType + i);
			item.allowSmoothing = false;
			item.compressionType = "photo";
			item.quality = 80;
		}
	
	}
	alert("更新完成!");
	
}



