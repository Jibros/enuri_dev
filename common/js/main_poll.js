window.name = "enuri_poll";
function CmdGetInfo(mode){
	var surl = document.URL;
	if(surl.indexOf("&article_idx=")>0){
		surl = surl.substring(0,surl.indexOf("&article_idx="));
	}
	if(mode==0){ //즐겨찾기
		window.external.AddFavorite(surl, '에누리▒토론방');
	}else if(mode==1){ //링크걸기
		copy_LINK("<a href=\""+surl+"\" target=\"_blank\"><img src=\"http://img.enuri.gscdn.com/images/view/get_info/link_img_poll.gif\" align=\"absmiddle\" border=\"0\"></a>","poll");
	}else{ //URL복사
		copy_URL(surl,'poll');									
	}
}
// 브라우져 정보 읽어오기
function getBrowserName() {
	if(navigator.userAgent.toLowerCase().indexOf("msie 6")>-1 && navigator.userAgent.toLowerCase().indexOf("msie 7")==-1 
		&& navigator.userAgent.toLowerCase().indexOf("msie 8")==-1) {
		return "msie6";
	}
	if(navigator.userAgent.toLowerCase().indexOf("msie 7")>-1 && navigator.userAgent.toLowerCase().indexOf("msie 8")==-1) {
		return "msie7";
	}
	if(navigator.userAgent.toLowerCase().indexOf("msie")!=-1) {
		return "msie";
	}
	if(navigator.userAgent.toLowerCase().indexOf("firefox")>-1) {
		return "firefox";
	}
	if(navigator.userAgent.toLowerCase().indexOf("opera")>-1) {
		return "opera";
	}
	if(navigator.userAgent.toLowerCase().indexOf("chrome")>-1) {
		return "chrome";
	}
	if(navigator.userAgent.toLowerCase().indexOf("safari")>-1) {
		return "safari";
	}
}
var borwserName = getBrowserName();
var selfW = window.screen.width;
var selfH = window.screen.availHeight;
function init(){
	try{
		//window.moveTo(30,0);

		//==============================================================
		//비스타 여부 체크
		//==============================================================
		var IS_VISTA="0";
		if(navigator.appName == "Microsoft Internet Explorer") {
			var Agent = navigator.userAgent
			Agent = Agent.toLowerCase();
			if(Agent.indexOf("nt 6.")>0 || Agent=="mozilla/4.0 (compatible; msie 6.0)") {
				IS_VISTA="1";
			}
		}
		var iw = 797;
		if(IS_VISTA=="1") {
			iw = 797;
		}else if(borwserName=="msie6" || borwserName=="msie7"){

		}else if(borwserName=="firefox"){
			iw = 795;
		}else if(borwserName=="safari"){
			iw = 795;
		}
		if(IS_VISTA=="1") {
			window.resizeTo(iw,eval(selfH)-30);
		} else {
			window.resizeTo(iw,eval(selfH)-30);
		}
	}catch(e){
		window.status="e";
	}
}
function syncHeightIFrame(){
	try{
		document.getElementById("poll_content").style.height = document.getElementById("poll_content").contentWindow.document.body.scrollHeight;
	}catch(e){}
}
function Cmd_Open_FavoriteLayer(){
	if(document.getElementById("incFavoriteLayer").innerHTML != document.getElementById("div_favorite").innerHTML){
		document.getElementById("incFavoriteLayer").innerHTML = document.getElementById("div_favorite").innerHTML;
	}
	if(document.getElementById("incFavoriteLayer").style.display == "none"){
		document.getElementById("incFavoriteLayer").style.display = "inline";
	}else{
		document.getElementById("incFavoriteLayer").style.display = "none";		
	}
}
function cmdOpenPoll(param){
	var obj = eval("document.frmPoll_"+param);
	var idx = obj.idx.value;
	location.replace("Poll.jsp?idx="+idx);
	return;
	for(i=1;i<=poll_cnt;i++){
		var obj = eval("document.frmPoll_"+i);
		if(i==param){
			document.getElementById("poll_article_"+i).className = "poll_article_sel";
			document.getElementById("poll_article_inner_"+i).className = "poll_article_inner_sel";
			document.getElementById("article_subject_txt_"+i).className = "article_subject_txt_sel";
			document.getElementById("poll_article_dummy_"+i).style.display = "block";
			cmdOpenDetail(obj.idx.value);
		}else{
			document.getElementById("poll_article_"+i).className = "poll_article";
			if(obj.isjoin.value==1){
				document.getElementById("poll_article_inner_"+i).className = "poll_article_inner_done";
			}else{
				document.getElementById("poll_article_inner_"+i).className = "poll_article_inner";
			}
			document.getElementById("article_subject_txt_"+i).className = "article_subject_txt";
			document.getElementById("poll_article_dummy_"+i).style.display = "none";
		}
	}
}
function cmdJoinPoll(param,max_width){
	//cmdOpenPoll(param);
	var obj = eval("document.frmPoll_"+param);
	var idx = obj.idx.value;
	if(obj.isjoin.value=="1"){
		document.getElementById("msg_done").style.display = "block";
		document.getElementById("msg_txt").innerHTML = "이미 투표 하셨습니다.";
		cmdOpenDetail(idx);
		return;
	}
	var article_idx = 0;
	for(i=0;i<6;i++){
		if(obj.article_idx[i]){
			if(obj.article_idx[i].checked){
				article_idx = obj.article_idx[i].value;
				break;
			}
		}
	}
	if(article_idx<=0){
		alert("항목을 선택하세요");
		return;
	}
	var p_url = "/knowbox/Poll_Proc.jsp";
	var p_param = "mode=JOIN&idx="+idx+"&article_idx="+article_idx;
	var getRec = new Ajax.Request(
		p_url,
		{
			method:'post',parameters:p_param,onComplete:cmdAfterJoin
		}
	);
	function cmdAfterJoin(originalRequest){
		eval("arrReturn = " + originalRequest.responseText);
		var iReturn = parseInt(arrReturn.rvalue,10);
		if(iReturn==1){ //투표저장
			document.getElementById("msg_done").style.display = "block";
			document.getElementById("msg_txt").innerHTML = "투표 반영되었습니다.";
		}else if(iReturn==2){ //이미 참여한 투표
			document.getElementById("msg_done").style.display = "block";
			document.getElementById("msg_txt").innerHTML = "이미 투표 하셨습니다.";
		}else{ //비정상
			return;
		}
		obj.isjoin.value = "1";
		document.getElementById("poll_join_btn_"+param).innerHTML = "";
		for(i=0;i<6;i++){
			if(obj.article_idx[i]){
				obj.article_idx[i].disabled = true;
			}
		}
		p_url = "/knowbox/Poll_Proc.jsp";
		p_param = "mode=GETGRAPH&idx="+idx+"&max_width="+max_width;
		getRec = new Ajax.Request(
			p_url,
			{
				method:'post',parameters:p_param,onComplete:cmdDrawGraph
			}
		);
		function cmdDrawGraph(originalRequest){
			eval("arrReturn = " + originalRequest.responseText);
			var iVal1 = parseInt(arrReturn.rvalue1,10);
			var iVal2 = parseInt(arrReturn.rvalue2,10);
			var iVal3 = parseInt(arrReturn.rvalue3,10);
			var iVal4 = parseInt(arrReturn.rvalue4,10);
			if(document.getElementById("article_graph_"+idx+"_1")) document.getElementById("article_graph_"+idx+"_1").style.width = iVal1+"px";
			if(document.getElementById("article_graph_"+idx+"_2")) document.getElementById("article_graph_"+idx+"_2").style.width = iVal2+"px";
			if(document.getElementById("article_graph_"+idx+"_3")) document.getElementById("article_graph_"+idx+"_3").style.width = iVal3+"px";
			if(document.getElementById("article_graph_"+idx+"_4")) document.getElementById("article_graph_"+idx+"_4").style.width = iVal4+"px";
		}
		cmdOpenDetail(idx);
	}
}
function cmdCloseMsg(el){
	if(document.getElementById(el)){
		document.getElementById(el).style.display = "none";
	}
}
function cmdOpenDetail(idx){
	if(parseInt(idx,10)>0){
		document.getElementById("poll_content").src = "/knowbox/Poll_Detail.jsp?idx="+idx;
	}
}
function cmdHideMsgDone(){
	if(document.getElementById("msg_done")){
		document.getElementById("msg_done").style.display = "none";
	}
}
init();