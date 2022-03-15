
function getBeginnerDic(kb_no,modelno,cate,org_kb_no,level,e,multimodelno){
	if(!e) var e = window.event;
	if (e){
		e.cancelBubble = true;
		e.returnValue = false;
		if (e.stopPropagation) {
			e.stopPropagation();
			e.preventDefault();
		}
	}
	hideAllLayer("beginner");
	if (typeof (top.SimpleView) != "undefined"){
		var simpleViewObj = new top.SimpleView();
		if (simpleViewObj.viewState){
			top.hideSimpleView();
		}
	}
	if (getBeginnerDic._kb_no){
		if (getBeginnerDic._kb_no == kb_no && top.document.getElementById("div_beginnerFrame").style.display !="none" ){
			top.document.getElementById("ifrmBeginnerFrame").src = "/html/etc/Blank.htm";
			top.document.getElementById("div_beginnerFrame").style.display = "none";
			getBeginnerDic._kb_no = "";
			return;
		}
	}
	if (getBeginnerDic._kb_no2){
		if (top.document.getElementById("div_beginnerFrame2").style.display !="none" ){
			top.document.getElementById("ifrmBeginnerFrame2").src = "/html/etc/Blank.htm";
			top.document.getElementById("div_beginnerFrame2").style.display = "none";
			getBeginnerDic._kb_no2 = "";
		}
	}	
	var posLeft;
	var posTop;
	if (document.getElementById("view").value == "2p"){
		var posLeftTop = Position.cumulativeOffset($("goodslist2_td_1_"+modelno));
		posLeft = posLeftTop[0];
		posTop = posLeftTop[1];
		if (posLeft > 500){
			posLeft = 45;
		}else{
			posLeft = posLeft + document.getElementById("goodslist2_td_2_"+modelno).offsetWidth + 16;
		}
	}else if(document.getElementById("view").value == "1p"){
		var posLeftTop = Position.cumulativeOffset($("goodslist1_td_1_"+modelno));
		posLeft = 107;
		posTop = posLeftTop[1]+document.getElementById("goodslist1_td_1_"+modelno).offsetHeight;	
	}else if (document.getElementById("view").value == "gp"){
		if (varTargetPage != "/view/Listbody_Smart.jsp"){
			if (typeof(multimodelno) == "undefined" || multimodelno == null ){
				var posLeftTop = Position.cumulativeOffset($("goodslistgp_td_1_"+modelno));
				posLeft = posLeftTop[0];
				posTop = posLeftTop[1];
				
				if (typeof(org_kb_no) =="undefined"){
					posLeft = posLeft + document.getElementById("goodslistgp_td_1_"+modelno).offsetWidth -20;
				}else{
					posLeft = posLeft + document.getElementById("goodslistgp_td_1_"+modelno).offsetWidth - 400;
				}
			}else{
				var posLeftTop = Position.cumulativeOffset($("goodslistgp_td_1_"+modelno));
				var posLeftTop2 = Position.cumulativeOffset($("goods_more_list_td1_"+multimodelno));
				
				posLeft = posLeftTop[0];
				posTop = posLeftTop2[1];
				
				if (typeof(org_kb_no) =="undefined"){
					posLeft = posLeft + document.getElementById("goodslistgp_td_1_"+modelno).offsetWidth -20;
				}else{
					posLeft = posLeft + document.getElementById("goodslistgp_td_1_"+modelno).offsetWidth - 440;
				}		
			}
		}else{
			var posLeftTop = Position.cumulativeOffset($("div_smart_goodsinfo"));
			if (top.document.URL.indexOf("/knowbox/List.jsp") >= 0){
				posLeft = posLeftTop[0]+375;
				posTop = posLeftTop[1] + document.getElementById("div_smart_goodsinfo").offsetHeight - 20
			}else{
				posLeft = posLeftTop[0]+117;
				posTop = posLeftTop[1] + document.getElementById("div_smart_goodsinfo").offsetHeight - 30
			}
		}
	}else if (document.getElementById("view").value == "txt"){
		var posLeftTop = Position.cumulativeOffset($("goodslisttxt_td_1_"+modelno));
		posLeft = posLeftTop[0];
		posTop = posLeftTop[1] + document.getElementById("goodslist3_td_1_"+modelno).offsetHeight;
		posLeft = posLeft + 220;
	}
	posTop = posTop + getListFrameTopPos();

	insertLogCate(2394,cate);
	top.insertTermDicTitleLog('read',kb_no);

	var mileObj = new Date();
	var strUrl = "/include/IncBeginnerDic_2010.jsp?kb_no="+kb_no+"&modelno="+modelno+"&cate="+cate+"&t="+mileObj.getMilliseconds();
	if (varTargetPage == "/view/Listbody_Smart.jsp"){
		strUrl += "&from=detail"
	}
	top.document.getElementById("ifrmBeginnerFrame").src = strUrl;
	
	top.document.getElementById("div_beginnerFrame").style.display = "";
	top.document.getElementById("div_beginnerFrame").style.left = posLeft+"px";
	top.document.getElementById("div_beginnerFrame").style.top = (posTop-20)+"px";
	getBeginnerDic._kb_no = kb_no;
}
function getListFrameTopPos(){
	var varReturn = 0;
	if (top.document.getElementById("enuriMenuFrame")){
		if (top.document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame")){
			varReturn = Position.cumulativeOffset(top.document.getElementById("enuriMenuFrame"))[1] + Position.cumulativeOffset(top.document.getElementById("enuriMenuFrame").contentWindow.document.getElementById("enuriListFrame"))[1];
		}else{
			varReturn = Position.cumulativeOffset(top.document.getElementById("enuriMenuFrame"))[1];
		}
	}else if(top.document.getElementById("searchListFrame")){
		varReturn = Position.cumulativeOffset(top.document.getElementById("searchListFrame"))[1];
	}else if(top.document.getElementById("enuriListFrame")){
		varReturn = Position.cumulativeOffset(top.document.getElementById("enuriListFrame"))[1];
	}
	return varReturn;
}
function insertBeginnerDicLog(kb_no){
	if (top.document.getElementById("div_beginner_tip_"+kb_no) || top.document.getElementById("div_beginner_tip_"+kb_no)){
		if (top.document.getElementById("div_beginner_tip_"+kb_no)){
			if (top.document.getElementById("div_beginner_tip_"+kb_no).style.display == "none"){
				insertLog(2616);
			}
		}else if (top.document.getElementById("div_beginner_tip_"+kb_no)){
			if (top.document.getElementById("div_beginner_tip_"+kb_no).style.display == "none"){
				insertLog(2616);
			}
		}
	}else{
		insertLog(2616);
	}
}

function getAdditionalBeginnerDic(kb_no,org_kb_no,cate,level){
	function showBeginnerDic(originalRequest){
		setTimeout(function(){
			if (!document.getElementById("div_beginner_tip_"+kb_no)){
				var varBeginnerDiv = top.document.createElement("DIV");
				varBeginnerDiv.innerHTML = originalRequest.responseText;
				varBeginnerDiv.style.position = "absolute";
				varBeginnerDiv.style.zIndex = 102;
				varBeginnerDiv.oncopy = function(){
					cmdEnuriContentsCopy();
				}
				varBeginnerDiv.id = "div_beginner_tip_"+kb_no;
				varBeginnerDiv.style.left = varAddPosLeft+"px";
				varBeginnerDiv.style.top = varAddPosTop+"px";
				varBeginnerDiv.style.display = "";
				top.document.getElementById("wrap").insertBefore(varBeginnerDiv,null);
				top.document.getElementById("div_beginner_tip_"+kb_no).style.left = varAddPosLeft+"px";
				top.document.getElementById("div_beginner_tip_"+kb_no).style.top = varAddPosTop+"px";
				top.document.getElementById("div_beginner_tip_"+kb_no).style.display = "";
			}
		},100);
	}
	function getBeginnerDicLevel(kb_no){
		for (var kb_no_cnt2 = 0;kb_no_cnt2<top.getBeginnerDic.kb_nos.length;kb_no_cnt2++){
			if (top.getBeginnerDic.kb_nos[kb_no_cnt2] == kb_no ){
				return top.getBeginnerDic.level[kb_no_cnt2];
			}
		}
	}
		
	var varParentBeginnerObjId = "";
	if (top.document.getElementById("div_beginner_tip_"+org_kb_no)){
		if (top.document.getElementById("div_beginner_tip_"+org_kb_no).style.display != "none"){
			varParentBeginnerObjId = "div_beginner_tip_"+org_kb_no;
		}
	}
	if (top.document.getElementById("div_beginner_tip_"+org_kb_no)){
		if (top.document.getElementById("div_beginner_tip_"+org_kb_no).style.display != "none"){
			varParentBeginnerObjId = "div_beginner_tip_"+org_kb_no;
		}		
	}	
	
	if (varParentBeginnerObjId){
		
		var varAddPos = Position.cumulativeOffset(top.document.getElementById(varParentBeginnerObjId));
		var varAddPosLeft = varAddPos[0];
		var varAddPosTop = varAddPos[1]+top.document.getElementById(varParentBeginnerObjId).offsetHeight;

		if (top.getBeginnerDic.kb_nos){
			var isClickedKbNo = false;
			if (top.document.getElementById("div_beginner_tip_"+kb_no)){
				var varOneLevel = 0;
				if (typeof(level) == "undefined" || level == null){
					varOneLevel = 1;
				}else{
					varOneLevel = level;
				}
				if (top.document.getElementById("div_beginner_tip_"+kb_no).style.display != "none" && getBeginnerDicLevel(kb_no) == varOneLevel){
					top.document.getElementById("div_beginner_tip_"+kb_no).style.display = "none";
					return;
				}
			}			
			for (var kb_no_cnt = 0;kb_no_cnt<top.getBeginnerDic.kb_nos.length;kb_no_cnt++){
				if (top.document.getElementById("div_beginner_tip_"+top.getBeginnerDic.kb_nos[kb_no_cnt])){
					if (level){
						if (top.getBeginnerDic.level[kb_no_cnt] == level){
							top.closeBeginnerDic(top.getBeginnerDic.kb_nos[kb_no_cnt]);
						}
					}else{
						top.closeBeginnerDic(top.getBeginnerDic.kb_nos[kb_no_cnt]);
					}
				}
				if (kb_no == top.getBeginnerDic.kb_nos[kb_no_cnt]){
					isClickedKbNo = true;
					if (level){
						top.getBeginnerDic.level[kb_no_cnt] = level;
					}else{
						top.getBeginnerDic.level[kb_no_cnt] = 1;
					}
				}
			}
			if (top.document.getElementById("div_beginner_tip_"+kb_no)){
				top.document.getElementById("div_beginner_tip_"+kb_no).style.left = varAddPosLeft+"px";
				top.document.getElementById("div_beginner_tip_"+kb_no).style.top = varAddPosTop+"px";
				top.document.getElementById("div_beginner_tip_"+kb_no).style.display = "";
				return;
			}			
	
			if (!isClickedKbNo){
				top.getBeginnerDic.kb_nos[top.getBeginnerDic.kb_nos.length] = kb_no;
				if (level){
					top.getBeginnerDic.level[top.getBeginnerDic.level.length] = level;
				}else{
					top.getBeginnerDic.level[top.getBeginnerDic.level.length] = 1;
				}
			}
		}else{
			top.getBeginnerDic.kb_nos = new Array();
			top.getBeginnerDic.level = new Array();
			top.getBeginnerDic.kb_nos[0] = kb_no;
			top.getBeginnerDic.level[0] = 1;
		}				
		insertLogCate(2394,cate);
		top.insertTermDicTitleLog('read',kb_no);
		if (typeof(level) == "undefined" || level == null){
			level = 1;
		}
		var mileObj = new Date();
		var strUrl = "/include/IncBeginnerDic_2010.jsp";
		var strSubmit = "kb_no="+kb_no+"&cate="+cate+"&level="+level+"&t="+mileObj.getMilliseconds();
		if (varTargetPage == "/view/Listbody_Smart.jsp"){
			strSubmit += "&from=detail"
		}		
		var getBeginner = new Ajax.Request(
			strUrl,
			{
				method:'get',parameters:strSubmit,onComplete:showBeginnerDic
			}
		);	
	}
}
