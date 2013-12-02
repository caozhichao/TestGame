var isChange=false;
function main(){
	fl.outputPanel.clear();
	fl.trace("files:");
	var path=fl.browseForFolderURL();
	var list=FLfile.listFolder(path,"files");
	for each(var name in list){
		if(name.lastIndexOf(".fla")!=-1){
			fl.openDocument(path+"/"+name);
			var dom=fl.getDocumentDOM();
			if(checkElement(dom)){
				fl.trace(dom.name);
				if(isChange) fl.saveDocumentAs(dom);
			}
			dom.close(false);
		}
	}
	fl.outputPanel.save(path+"/checkStage.txt");
	fl.outputPanel.clear();
}
function checkElement(dom){
	var hasEls=false;
	var layers=dom.getTimeline().layers;
	for each(var layer in layers){
		if(layer.layerType!="guide"){
			var frames=layer.frames;
			for each(var frame in frames){
				var elements=frame.elements;
				if(elements.length){
					if(!isChange) return true;
					hasEls=true;
				}
			}
			if(isChange) layer.layerType="guide";
		}
	}
	return hasEls;
}
main();