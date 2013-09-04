var ImageURL;  
browImageFile();  
/*打开图片文件夹*/  
function browImageFile()  
{  
    fl.outputPanel.clear();     
    ImageURL= fl.browseForFolderURL("请选择素材文件夹");   
    if(ImageURL)  
    importFolder(ImageURL);    
    fl.trace(ImageURL);  
}  
/*导入文件夹*/  
function importFolder(folderURI)   
{  
    var dom = fl.getDocumentDOM();
	//fl.trace("folderURI" + folderURI);
	
    var lib = fl.getDocumentDOM().library;  
    fl.trace(folderURI);          
    var folderContents;  
    var fitem;  
          
   	var libPath = folderURI.replace(ImageURL, "");  
	
    var subLibPath = libPath.substr(1);        //去掉第一个“/”   
         
    //文件 获取folderURI 下的文件名   
    folderContents = FLfile.listFolder(folderURI, "files");  
          
        for (var i in folderContents)   
        {  
                fitem = folderContents[i];  
                var inx = fitem.lastIndexOf(".");  
                if (inx > 0)  
                {  
                        var ext = fitem.substr(inx+1).toLowerCase();  //扩展名   
                        if (ext == "jpg" ||ext == "png" || ext == "gif")  
                        {  
                                fl.trace("导入文件：" + fitem);  
                                dom.importFile(folderURI + "/" + fitem, true);                                 
                                if (libPath != "")  
                                {  
                                    lib.selectItem(fitem);  
                                    lib.moveToFolder(subLibPath);  
                                }  
                        }  
                }  
        }  
      
 alert("文件夹导入完成！");       
 addAllImagAsLink();  
    
}  
  
/*给所有图片添加as链接*/  
function addAllImagAsLink()  
{  
      
   var doc=fl.getDocumentDOM();   
   var lib=doc.library;   
   if(lib.items.length==0)return;    
   for(i=0; i<lib.items.length; i++)  
   {  
   	 var item = lib.items[i];
	 //fl.trace("item_name:" + item.name);
     if(item.itemType=="bitmap")  
     {  
    	//var item = lib.items[i];   
    	var className ;  
    	item.linkageExportForAS = true;
    	if(item.name.lastIndexOf(".")!=-1)  
    	{	  
       		className = item.name.substr(0, item.name.lastIndexOf("."));  
       		fl.trace("导出swf文件:"+className+".swf");  
    	} 
    	//链接名称   
		item.linkageClassName = className;
    	item.linkageExportInFirstFrame = true;  
    	item.linkageBaseClass = "flash.display.BitmapData";  
    	item.quality = 80;      //设置质量为80   
		//导出成单个swf
    	exportSwf(ImageURL+"/"+className);
  	}  
  } 
  	//删除库中的临时文件
	delectLib();  
}  
  
/*导出swf*/  
function exportSwf(name)  
{  
    fl.getDocumentDOM().setPlayerVersion(10);  
    fl.getDocumentDOM().exportSWF(name,true);  
}  
  
/*删除所有*/  
function delectLib()  
{  
    var lib = fl.getDocumentDOM().library;  
    lib.selectAll();  
    var selItems = lib.getSelectedItems();  
    if(!selItems) return ;  
    for(var i=0;i<selItems.length;i++ )  
    {  
        lib.deleteItem(selItems[i].name);  
    }  
     alert("删除库所有元件操作结束！");   
}  
