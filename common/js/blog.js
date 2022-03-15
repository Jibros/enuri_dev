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
}
function checkSearchKey(){
	if(event.keyCode==13) {
		cmdSearch();
	}
}
function cmdSearch(){
	var obj = document.getElementById("eb_keyword");
	if(obj.value.trim().length<2){
		alert("2자 이상의 검색어를 넣으세요");
		return false;
	}
	if(obj.value.trim().length>20){
		alert("20자 이내의 검색어를 넣으세요");
		return false;
	}
	if(preCheckKbSearchKeyword(obj)){
		top.location.href = "Index.jsp?keyword="+escape(obj.value);
	}
}
function preCheckKbSearchKeyword(obj){
	var varKeyword = obj.value;
	varKeyword = convertSpecialKeyword(varKeyword);
	obj.value = varKeyword;
	return true;
}
var intReadFrmHeight = -1;
function getFrameHeight(){
	return intReadFrmHeight;
}
function setFrameHeight(h){
	intReadFrmHeight = h;
}
function kbReadResize() {
	var oFrame = document.getElementById("ifBodyRead");
	if(oFrame.src){
		var sh = oFrame.contentWindow.getBodyScrollHeight()+10;
		oFrame.height = sh;
		if(BrowserDetect.browser=="Safari"){
			oFrame.style.height = sh+"px";
		}
		var sh_r = oFrame.contentWindow.getKbreadBodyHeight()+10;
		oFrame.height = sh_r;
		if(BrowserDetect.browser=="Safari"){
			oFrame.style.height = sh_r+"px";
		}
		setFrameHeight(sh);
	}
}
function initFrame(obj){

}
//스크롤 위치 조정
function cmdSetScroll(param){
	if (document.body.scrollTop){
		document.body.scrollTop = param+"px";
	}else{
		document.documentElement.scrollTop = param+"px";
	}
}
//구매가이드에서 필요한 함수
function knowBoxBigImgOpen_20091221(url1) {
	var k = window.open(url1,"guideImgPopup","width=100,height=100,top=0,left=0,toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=no,menubar=no,personalbar=no");
	k.focus();
}
function cmdAfterLoginKbTop(review){
	if(typeof(review)=="undefined"){
		review = "";
	}
	top.cmdMyAreaReload();
	top.hideLoginLayer();
	top.hideLoginAutoAlert();
	if(iGroup==3){
		loadBlogQnaLogin(1);
	}else{
		if(document.getElementById("ifBodyRead")){
			if(review=="REVIEW_APP"){ //체험단 신청
				setReviewAppSession();
			}
			document.getElementById("ifBodyRead").contentWindow.location.reload();
		}
	}
}
function setReviewAppSession() {
	var url = "/knowbox/kbReviewAppSetSession.jsp";
	var param = "sessionVal=true";
	var getRec = new Ajax.Request(
		url,
		{
			method:'post',parameters:param
		}
	);
}
function showLoginStatus(){} //로그인상태 호출 함수
function ebGroupListResize() {
	var oFrame = document.getElementById("ifGroupList");
	if(oFrame.src){
		try{
			var sh = oFrame.contentWindow.getBodyScrollHeight();
			oFrame.height = sh;
			if(BrowserDetect.browser=="Safari"){
				oFrame.style.height = sh+"px";
			}
			var sh_r = oFrame.contentWindow.getKbreadBodyHeight();
			oFrame.height = sh_r;
			if(BrowserDetect.browser=="Safari"){
				oFrame.style.height = sh_r+"px";
			}
		}catch(e){}
	}
}
function ebListResize() {
	var oFrame = document.getElementById("ifKbList");
	if(oFrame.src){
		try{
			var sh = oFrame.contentWindow.getBodyScrollHeight();
			oFrame.height = sh;
			if(BrowserDetect.browser=="Safari"){
				oFrame.style.height = sh+"px";
			}
			var sh_r = oFrame.contentWindow.getKbreadBodyHeight();
			oFrame.height = sh_r;
			if(BrowserDetect.browser=="Safari"){
				oFrame.style.height = sh_r+"px";
			}
		}catch(e){}
	}
}
function cmdEnuri(){
	insertLog(6331);
	var win = window.open("/","ENURIFROMBLOG");
	win.focus();
}
function cmdBlogIndex(){
	insertLog(6273);
	top.location.href = "/blog/Index.jsp";
}
function cmdBlogCateAll(){
	insertLog(6284);
	top.location.href = "/blog/Index.jsp?cate=all";
}
function cmdBlogGroup(group){
	top.location.href = "/blog/Index.jsp?group="+group;
}
function setGroupList(){
	if(document.getElementById("blogGroupRunKey") && document.getElementById("blogGroupPage")){
		var blogGroupRunKey = eval(document.getElementById("blogGroupRunKey").innerHTML);
		var blogGroupPage = eval(document.getElementById("blogGroupPage").innerHTML);
		var blogGroupPageCount = eval(document.getElementById("blogGroupPageCount").innerHTML);
		if(iRunKey==blogGroupRunKey){
			if(iGroup==3){ //질문답변
				document.getElementById("top_grouppage_box").style.display = "none";
				if(islogin()){
					document.getElementById("top_group3_myqna").style.display = "";
				}
				document.getElementById("top_bm_box_1").style.display = "none";
				document.getElementById("top_bm_box_2").style.display = "none";
				loadBlogQnaLogin(0);
			}else{
				document.getElementById("top_grouppage_box").style.display = "";
				document.getElementById("top_group3_myqna").style.display = "none";
				document.getElementById("top_bm_box_1").style.display = "none";
				document.getElementById("top_bm_box_2").style.display = "none";
				document.getElementById("top_bm_box_"+iGroup).style.display = "";
				
				document.getElementById("group_page").innerHTML = document.getElementById("blogGroupPage").innerHTML;
				if(blogGroupPage>1){
					document.getElementById("btn_page_prev").style.cursor = "pointer";
				}else{
					document.getElementById("btn_page_prev").style.cursor = "default";
				}
				if(blogGroupPage<blogGroupPageCount){
					document.getElementById("btn_page_next").style.cursor = "pointer";
				}else{
					document.getElementById("btn_page_next").style.cursor = "default";
				}
			}
		}
	}
}
function showGroupList(originalRequest){
	var orgHTML = originalRequest.responseText.trim();
	var blogGroupRunKey = eval(orgHTML.substring(orgHTML.indexOf("blogGroupRunKey")+17, orgHTML.indexOf("</div>",orgHTML.indexOf("blogGroupRunKey")+17)));
	var blogGroupPage = eval(orgHTML.substring(orgHTML.indexOf("blogGroupPage")+15, orgHTML.indexOf("</div>",orgHTML.indexOf("blogGroupPage")+15)));
	var blogGroupPageCount = eval(orgHTML.substring(orgHTML.indexOf("blogGroupPageCount")+20, orgHTML.indexOf("</div>",orgHTML.indexOf("blogGroupPageCount")+20)));
	if(blogGroupRunKey==iRunKey){
		cmdGroupSet(iGroup);
		if(iGroup==3){ //질문답변
			document.getElementById("top_grouppage_box").style.display = "none";
			if(islogin()){
				document.getElementById("top_group3_myqna").style.display = "";
			}
			document.getElementById("top_bm_box_1").style.display = "none";
			document.getElementById("top_bm_box_2").style.display = "none";
			document.getElementById("group_list").innerHTML = orgHTML;
			loadBlogQnaLogin(0);
		}else{
			cmdBmSet(iGroup, iBmno);
			document.getElementById("top_grouppage_box").style.display = "";
			document.getElementById("top_group3_myqna").style.display = "none";
			document.getElementById("top_bm_box_1").style.display = "none";
			document.getElementById("top_bm_box_2").style.display = "none";
			document.getElementById("top_bm_box_"+iGroup).style.display = "";
			
			document.getElementById("group_page").innerHTML = blogGroupPage;
			if(blogGroupPage>1){
				document.getElementById("btn_page_prev").style.cursor = "pointer";
			}else{
				document.getElementById("btn_page_prev").style.cursor = "default";
			}
			if(blogGroupPage<blogGroupPageCount){
				document.getElementById("btn_page_next").style.cursor = "pointer";
			}else{
				document.getElementById("btn_page_next").style.cursor = "default";
			}
			document.getElementById("group_list").innerHTML = orgHTML;
		}
	}
}
function groupPrevPage(){
	var nowPage = eval(document.getElementById("group_page").innerHTML);
	var blogGroupPageCount = eval(document.getElementById("blogGroupPageCount").innerHTML);
	if(nowPage=="" || nowPage<=1){
		return;
	}
	iRunKey++;
	nowPage--;
	loadGroupList(nowPage);
}
function groupNextPage(){
	var nowPage = eval(document.getElementById("group_page").innerHTML);
	var blogGroupPageCount = eval(document.getElementById("blogGroupPageCount").innerHTML);
	if(nowPage=="" || blogGroupPageCount=="" || nowPage>=blogGroupPageCount){
		return;
	}
	iRunKey++;
	nowPage++;
	loadGroupList(nowPage);
}
function loadGroupList(nowPage){
	var url = "/blog/Blog_Grouplist.jsp";
	var param = "runkey="+iRunKey+"&group="+iGroup+"&bmno="+iBmno+"&kbno="+iKbno+"&page="+nowPage;
	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:showGroupList
		}
	);
}
function loadGroupModifyQna(kbno){
	iKbno = kbno;
	var url = "/blog/Blog_Grouplist.jsp";
	var param = "runkey="+iRunKey+"&group=3&bmno=0&kbno="+iKbno+"&qnatype=m";
	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:showGroupList
		}
	);
}
var chmail_log = false;
function CmdClickMail(){
	var obj = document.getElementById("frmWKnowBox");
	obj.interest_flag.checked = true;
	CmdCheckMail();
}
function CmdCheckMail(){
	if(!chmail_log){
		insertLog(5963);
		chmail_log = true;
	}
	var obj = document.getElementById("frmWKnowBox");
	if(obj.interest_flag.checked){
		obj.interest_email.style.color = "#000000";
	}else{
		obj.interest_email.style.color = "#808080";
	}
	if(obj.interest_email.value.trim()==""){
		obj.interest_email.value = obj.interest_email.defaultValue;
	}
}
var isKbWriteProgress = 0;
function cmdWriteSubmit(){
	if(!islogin()){
		alert("로그인하세요");
		return false;
	}
	insertLog(982);insertLog(5893);
	if(isKbWriteProgress==1){
		alert("등록중입니다. 잠시만 기다려주세요.");
		return false;
	}
	var obj = document.getElementById("frmWKnowBox");
	if(obj.title_m.value.trim()==""){
		alert("제목을 입력하세요");
		obj.title_m.select();
		return false;
	}
	if(document.getElementById("user_write_email") && document.getElementById("user_write_email").innerHTML=="" && obj.interest_email && obj.interest_email.value==obj.interest_email.defaultValue){
		obj.interest_email.value = "";
	}
	if(obj.interest_flag && obj.interest_flag.checked && obj.interest_email){
		if(obj.interest_email.value.trim()==""){
			alert("이메일을 입력해주십시오.");
			obj.interest_email.select();
			return false;
		}
		if ((obj.interest_email.value).isemail()==false){
			alert("사용할 수 없는 메일주소입니다.\n다시 입력하세요");
			obj.interest_email.select();
			return false;
		}
	}else if(obj.interest_email){
		obj.interest_email.value = "";
	}
	if(!obj.content_m || obj.content_m.value.trim()==""){
		alert("글 내용을 입력하세요");
		return false;
	}
	isKbWriteProgress = 1;
	obj.submit();
}
function cmdUnderline(obj,tg){
	if(tg==1){
		obj.style.textDecoration = "underline";
	}else{
		obj.style.textDecoration = "none";
	}
}
function cmdBlogKbread(group, kbno){
	top.location.href = "/blog/Index.jsp?group="+group+"&kbno="+kbno;
}
function cmdBlogTopKbread(kbno, idx){
	for(i=0; i<6; i++){
		if(document.getElementById("top_list_tr_"+i)){
			if(i==idx){
				document.getElementById("top_list_tr_"+i).className = "top_list_readsel";
				document.getElementById("top_list_td_"+i).className = "top_list_title_sel";
			}else{
				document.getElementById("top_list_tr_"+i).className = "";
				document.getElementById("top_list_td_"+i).className = "top_list_title_normal";
			}
		}else{
			break;
		}
	}
	iKbno = kbno;
	cmdRead(kbno);
}
function cmdRead(kbno){
	document.getElementById("eb_kbread").style.display = "block";
	var vkbno = document.getElementById("ifBodyRead").contentWindow.iKbno;
	document.getElementById("ifBodyRead").src = "/knowbox/List_read.jsp?from=blog&kbno="+kbno;
	if (document.body.scrollTop){
		document.body.scrollTop = "0px";
	}else{
		document.documentElement.scrollTop = "0px";
	}
	var vsrc = document.getElementById("ifKbList").src;
	document.getElementById("ifKbList").src = "/blog/Blog_list.jsp?group="+iGroup+"&kbno="+kbno;
}
function GoNextPage(pageNo){
	insertLog(6294);
	var obj = document.fmKBListSelf;
	obj.page.value = pageNo;
	obj.submit();
}
function gopage(value){
	GoNextPage(value);
}
function cmdGroupList(group){ //페이지 새로고침 없이 탭변경
	try{
		if(iGroup==group){
			return;
		}
		iGroup = group;
		iBmno = 0;
		iRunKey++;
		loadGroupList(1);
	}catch(e){}
}
function cmdBmList( bmno){
	try{
		if(iBmno==bmno){
			return;
		}
		iBmno = bmno;
		iRunKey++;
		loadGroupList(1);
	}catch(e){}
}
function cmdGroupSet(group){
	for(i=1; i<10; i++){
		if(document.getElementById("btn_group_"+i)){
			if(i==group){
				if(document.getElementById("btn_group_"+i).src.indexOf("_on")<0){
					document.getElementById("btn_group_"+i).src = document.getElementById("btn_group_"+i).src.replace(".gif","_on.gif");
				}
			}else{
				document.getElementById("btn_group_"+i).src = document.getElementById("btn_group_"+i).src.replace("_on.gif",".gif");
			}
		}else{
			break;
		}
	}
}
function cmdBmSet(group, bmno){
	for(i=0; i<10; i++){
		if(document.getElementById("btn_bm_"+group+"_"+i)){
			if(bmno==document.getElementById("btn_bm_"+group+"_"+i).getAttribute("bmno")){
				document.getElementById("btn_bm_"+group+"_"+i).className = "top_bm_list_sel";
			}else{
				document.getElementById("btn_bm_"+group+"_"+i).className = "top_bm_list_normal";
			}
		}else{
			break;
		}
	}
}
function cmdImgOver(oid){
	var obj = document.getElementById(oid);
	if(obj){
		obj.src = obj.src.replace(".gif","_ov.gif");
	}
}
function cmdImgOut(oid){
	var obj = document.getElementById(oid);
	if(obj){
		obj.src = obj.src.replace("_ov.gif",".gif");
	}
}
function loadBlogQnaLogin(readref){
	function showBlogQnaLogin(originalRequest){
		if(islogin()){
			document.getElementById("bbs_writer_login_before").style.display = "none";
			document.getElementById("bbs_writer_login_after").style.display = "";
			document.getElementById("bbs_login_before").innerHTML = "";
			document.getElementById("bbs_login_after").innerHTML = originalRequest.responseText;
			if(iGroup==3){
				document.getElementById("top_group3_myqna").style.display = "";
			}
		}else{
			document.getElementById("bbs_writer_login_before").style.display = "";
			document.getElementById("bbs_writer_login_after").style.display = "none";
			document.getElementById("bbs_login_before").innerHTML = originalRequest.responseText;
			document.getElementById("bbs_login_after").innerHTML = "";
			if(iGroup==3){
				document.getElementById("top_group3_myqna").style.display = "none";
			}
		}
		if(readref && document.getElementById("ifBodyRead")){
			document.getElementById("ifBodyRead").contentWindow.location.reload();
		}
	}
	var url = "/login/Ajax_Bbs_LoginLine.jsp";
	var param = "";
	if(document.getElementById("frmWKnowBox") && document.getElementById("frmWKnowBox").qnatype.value=="m" && document.getElementById("frmWKnowBox").kbno.value!=""){
		param = "bbstype=m"
	}
	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:showBlogQnaLogin
		}
	);
}
function cmdAfterKbWrite(kbno){
	top.location.href = "/blog/Index.jsp?group=3&kbno="+kbno;
}
function cmdListMyQna(){
	iKbno = 0;
	//document.getElementById("eb_kbread").style.display = "none";
	document.getElementById("ifKbList").src = "/blog/Blog_list.jsp?group=3&myqna=1&findmyqna=1";
}
function cmdModifyBlogQna(kbno){
	iRunKey++;
	loadGroupModifyQna(kbno);
}
function cmdDelBlogFile(){
	var obj = document.getElementById("frmWKnowBox");
	if(confirm("첨부된 파일을 삭제하시겠습니까?")){
		obj.delfile.value = "1";
		document.getElementById("bbs_file_modify").style.display = "none";
		document.getElementById("bbs_file_input").style.display = "block";
	}
}
Event.observe(window, 'load', function() {
    Event.observe('eb_keyword', 'keypress', checkSearchKey);
});