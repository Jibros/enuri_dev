function syncWHSaveGoods(){
	if (document.getElementById("frmSaveGoods").contentWindow.document.location.href != "" && document.getElementById("frmSaveGoods").contentWindow.document.location.href != "about:blank"){
		setTimeout("syncHeightSaveGoods()",500);
		document.getElementById("frmSaveGoods").style.display = "";
		var varW = document.body.offsetWidth/2-433;	
		if (varW < 0 ){
			varW = 0;
		}
		document.getElementById("frmSaveGoods").style.left = varW+"px";
		document.getElementById("frmSaveGoods").style.display = "";
		window.scrollTo(0,0);
   	}
}
function syncWHAllMenu(){
    if(document.getElementById("frmAllMenu").contentWindow.document.location.href != "" && document.getElementById("frmAllMenu").contentWindow.document.location.href != "about:blank") {
        syncHeightAllMenu();
        var varW = document.body.offsetWidth/2-455; 
        if (varW < 0 ){
            varW = 0;
        }
        document.getElementById("frmAllMenu").style.left = varW+"px";
        document.getElementById("frmAllMenu").style.display = "";
        window.scrollTo(0,0);
    }
}