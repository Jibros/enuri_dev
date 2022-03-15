
function getBeginnerDic(kb_no){
	if(!e) var e = window.event;
	if (e){
		e.cancelBubble = true;
		e.returnValue = false;
		if (e.stopPropagation) {
			e.stopPropagation();
			e.preventDefault();
		}
	}
/*	hideAllLayer("beginner");*/

	if (getBeginnerDic._kb_no){
		if (getBeginnerDic._kb_no == kb_no && top.$("div_beginnerFrame").style.display !="none" ){
			top.$("ifrmBeginnerFrame").src = "/html/etc/Blank.htm";
			top.$("div_beginnerFrame").style.display = "none";
			getBeginnerDic._kb_no = "";
			return;
		}
	}
	if (getBeginnerDic._kb_no2){
		if (top.$("div_beginnerFrame2").style.display !="none" ){
			top.$("ifrmBeginnerFrame2").src = "/html/etc/Blank.htm";
			top.$("div_beginnerFrame2").style.display = "none";
			getBeginnerDic._kb_no2 = "";
		}
	}
	var posLeft;
	var posTop;

	/*
	 * 프레임 위치 조정 코딩
	 */
	posTop  = Position.cumulativeOffset(event.srcElement)[1] + getListFrameTopPos() + 128;
	posLeft = parent.document.getElementById('ph_con1').width/2 + 20;
	
	/*top.insertTermDicTitleLog('read',kb_no);*/ // 로그

	var strUrl = "/include/IncBeginnerDic_min.jsp?kb_no="+kb_no;
/*	if (varTargetPage == "/view/Listbody_Smart.jsp"){
		strUrl += "&from=detail"
	}*/
	top.$("ifrmBeginnerFrame").src = strUrl;

	top.$("div_beginnerFrame").style.display = "";
	top.$("div_beginnerFrame").style.left = posLeft+"px";
	top.$("div_beginnerFrame").style.top = (posTop-20)+"px";
	
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
/*
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
*/

function getAdditionalBeginnerDic(kb_no){
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

/*		top.insertTermDicTitleLog('read',kb_no);*/
		if (typeof(level) == "undefined" || level == null){
			level = 1;
		}
		var mileObj = new Date();
		var strUrl = "/include/IncBeginnerDic_min.jsp";
		var strSubmit = "kb_no="+kb_no;
/*		if (varTargetPage == "/view/Listbody_Smart.jsp"){
			strSubmit += "&from=detail"
		}*/
		var getBeginner = new Ajax.Request(
			strUrl,
			{
				method:'get',parameters:strSubmit,onComplete:showBeginnerDic
			}
		);
	}
}
