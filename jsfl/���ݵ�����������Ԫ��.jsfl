
function findFiles()
{
	var folderURI  = fl.browseForFolderURL("选择文件夹");
	if(folderURI)
	{
		//fl.trace(folderURI);
		var truthBeTold = window.prompt("输入你要查找的链接名：");
		var folderContents = FLfile.listFolder(folderURI);
	 	for each (var path in folderContents)
     	{		  
		  	if(path.split(".")[1] == "fla")
		  	{
			  	fl.trace("path:" + path);
			 	var dom = fl.openDocument(folderURI + "/" + path);
				var linkName = find(dom,truthBeTold);
				if(linkName != null){
					alert(linkName);
					break;
				} else 
				{
					dom.close(false);
				}          		
		  	}		  
	 	}
		if(linkName == "" || linkName == null) alert("库中没有该元件");		
	}	
}

function find(dom,truthBeTold)
{
	if(dom){
	//var truthBeTold = window.prompt("输入你要查找的链接名：");
 	var itemArray = dom.library.items;//获取库中的元件 
 	var itemName;
 	for(var i = 0; i < itemArray.length; i ++){
  		if(truthBeTold == itemArray[i].linkageClassName){
   			itemName = itemArray[i].name;
    		//alert(itemName);
   			// currDom.library.addItemToDocument({x:0, y:0},itemName);//
    		dom.library.selectItem(itemName);
    		break;
  		}
 	}
	return itemName;
	/*
 	if(itemName == "" || itemName == null) alert("库中没有该元件");
	*/
	}
	
	
}

//var currDom = fl.getDocumentDOM();
//find(currDom);
findFiles();


