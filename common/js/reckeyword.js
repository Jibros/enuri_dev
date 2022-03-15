
function setFocusRecKeyword(){
	if (document.getElementById("keyword")){
		setKeywordValueStatus();
	}else{
		if (setFocusRecKeyword._f_cnt){
			setFocusRecKeyword._f_cnt++;
		}else{
			setFocusRecKeyword._f_cnt = 1;
		}
		if (setFocusRecKeyword._f_cnt < 5){	
			setTimeout("setFocusRecKeyword()",200);
		}	
	}

}
function setRecKeyword(param,checked,reload,factory){
	/*
	if (setRecKeyword._f_loading){
		return
	}
	*/
	setRecKeyword._f_loading = true;
	document.getElementById("factory").value = factory;
	//특수문자 처리
	var reckeyword_org = document.getElementById("keyword").value;
	
	
	var reckeyword = param.replace("<br>"," ");
	reckeyword = reckeyword.replace("<BR>"," ");
	reckeyword = reckeyword.replace(/ /g,"");
	reckeyword = reckeyword.trim();
	
	//선택한거 또 선택했는지 체크
	var regkeyword_org_array = reckeyword_org.split(" ");
	var bexits = false;
	for(i=0;i<regkeyword_org_array.length;i++){
		if (regkeyword_org_array[i].trim() == reckeyword.trim()){
			bexits = true;
		}
	}
	
	if(bexits) { //선택한거 또 선택했으면 선택한거 삭제
		reckeyword_org = "";
		for(i=0;i<regkeyword_org_array.length;i++){
			if (regkeyword_org_array[i].trim() != reckeyword.trim()){
				reckeyword_org = reckeyword_org + regkeyword_org_array[i].trim() + " ";
			}
		}		
	}else{//선택한게 아니더라도 체크된상태여야지만 입력
		if (checked){
			if (reckeyword_org.trim().length > 0 ){
				reckeyword_org = reckeyword_org+" "+reckeyword;
			}else{
				reckeyword_org = reckeyword;
			}
		}
	}
	//손으로 삭제한거가 있을경우 "," 처리
	var regkeyword_org_array_eq = reckeyword_org.split(" ");
	reckeyword_org = "";
	for(i=0;i<regkeyword_org_array_eq.length;i++){
		if (regkeyword_org_array_eq[i].trim().length > 0){
			reckeyword_org = reckeyword_org + regkeyword_org_array_eq[i].trim() + " ";
		}
	}		
	//마지막 "," 삭제
	if(reckeyword_org.substring(reckeyword_org.length-1,reckeyword_org.length)==" "){
		reckeyword_org = reckeyword_org.substring(0,reckeyword_org.length-1);
	}
	document.getElementById("keyword").value = reckeyword_org.trim();
	
	var dis_regkeyword_org_array = reckeyword_org.split(" ");
	
	var dis_rec_top_keywords = $("reckeyword_top_list").getElementsBySelector('span[class="reckeyword"]');
	var dis_rec_top_keywords_checked = new Array(dis_rec_top_keywords.length);
	
	var dis_rec_all_keywords = $("reckeyword_all_list").getElementsBySelector('span[class="reckeyword"]');
	var dis_rec_all_keywords_checked = new Array(dis_rec_all_keywords.length);
	
	var checkedCnt = 0;
	var varLastCheckedValue = "";

	for (j=0;j<dis_regkeyword_org_array.length;j++){
		for (i=0;i<dis_rec_top_keywords.length;i++){
			if (dis_rec_top_keywords[i].innerHTML.replace(/ /g,"").trim() == dis_regkeyword_org_array[j]){
				varLastCheckedValue = dis_rec_top_keywords[i].innerHTML.trim();
				dis_rec_top_keywords[i].style.color ="#c70b06";
				dis_rec_top_keywords_checked[i] = true;
			}else{
				if (!dis_rec_top_keywords_checked[i]){
					dis_rec_top_keywords[i].style.color ="#000000";
				}
			}
		}		
		
		for (i=0;i<dis_rec_all_keywords.length;i++){
			if (dis_rec_all_keywords[i].innerHTML.replace(/ /g,"").trim() == dis_regkeyword_org_array[j]){
				checkedCnt++;
				varLastCheckedValue = dis_rec_all_keywords[i].innerHTML.trim();
				dis_rec_all_keywords[i].style.color ="#c70b06";
				dis_rec_all_keywords_checked[i] = true;
			}else{
				if (!dis_rec_all_keywords_checked[i]){
					dis_rec_all_keywords[i].style.color ="#000000";
				}
			}
		}
	}	
	if (checkedCnt >= 6 && !reload){
		alert("5개까지만 선택 가능합니다.");
		setRecKeyword._f_loading = false;
		setRecKeyword(param,false,true);
	}else if (checkedCnt >= 6 && reload){
		setRecKeyword._f_loading = false;
		setRecKeyword(varLastCheckedValue,false,true,factory);
	}
	setKeywordValueStatus();
	if (document.getElementById("keyword").value.trim() != ""){
		document.getElementById("keyword").focus();
		getCountInResult(true);
	}else{
		document.getElementById("keyword").value = "";
		setRecKeyword._f_loading = false;
		document.getElementById("txt_rec_help").style.display = "";
		document.getElementById("rec_init").style.display = "none";
		document.getElementById("wrap_reckeyword_count").style.display = "none";
		
	}
}
function setKeywordValueStatus(){
	if (document.getElementById("keyword").value.trim().length >  0){
		document.getElementById("rec_keyword_clear").style.display = "";
		document.getElementById("recgobutton").src = var_img_enuri_com + "/2012/list/reckeyword/btn_sir_on.gif"
		document.getElementById("recgobutton").style.cursor = "pointer";
		document.getElementById("rec_keyword_left").style.display = "";
		document.getElementById("keyword").style.backgroundImage = "url(" + var_img_enuri_com + "/2012/list/reckeyword/keyword_bg_03.gif)";
		
	}else{
		document.getElementById("rec_keyword_clear").style.display = "none";
		document.getElementById("recgobutton").src = var_img_enuri_com + "/2012/list/reckeyword/btn_sir.gif"
		document.getElementById("recgobutton").style.cursor = "default";
		document.getElementById("rec_keyword_left").style.display = "none";
		document.getElementById("keyword").style.backgroundImage = "url(" + var_img_enuri_com + "/2012/list/reckeyword/keyword_bg.gif)";
		
	}
}
function setSync(e){
	setKeywordValueStatus();
	checkKeydownEnter(e);
}

//onsubmit에 getCountInResult 호출 경우 checkKeydownEnter() 호출 제거
function setSync2(e){
	setKeywordValueStatus();
}

function checkKeydownEnter(e){
	var keycode;
	if(typeof(e) != "undefined"){
		if (typeof(e.which) != "undefined"){
			keycode = e.which;
		}else{
			keycode = e.keyCode;
		}
	}else{
		keycode = event.keyCode;
	}
	if (keycode == 13 ){
		getCountInResult();
	}
}

function initReckeyword(enuriCnt){
	insertLog(2161);
	if (enuriCnt == 0 ){
		if (document.getElementById("m_price")){
			document.frmList.m_price.value = "";
		}
		if (document.getElementById("factory")){
			document.frmList.factory.value = "";
		}
		if (document.getElementById("condi")){
			document.frmList.condi.value = "";
		}
		if (document.getElementById("shop_code")){
			document.frmList.shop_code.value="";
		}
	}
	document.getElementById("keyword").value = "";
	if (varTargetPage == "/fashion/Listbody_Brand_Main.jsp"){
		document.location.reload();
	}else{
		document.frmList.submit();
		//getCountInResult(false);
	}
}

function clearReckeyword(){
	document.getElementById("keyword").value = "";
	setSync();
	setRecKeyword("",false,false,"");
	document.getElementById("keyword").focus();
}
function toggleRecSearchImg(status){
	if (status == 'on'){
		if (document.getElementById("keyword").value.trim().length > 0){
			document.getElementById("recgobutton").src = var_img_enuri_com + "/2012/list/reckeyword/btn_sir_on.gif"
		}
	}else{
		document.getElementById("recgobutton").src = var_img_enuri_com + "/2012/list/reckeyword/btn_sir.gif"	
	}
}
