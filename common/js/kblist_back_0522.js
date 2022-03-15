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
/* 글목록 확장 상태 */ 
var kblist_wide = 0;
var kblist_nowidx = 1;
/* 확장버튼 top 위치 설정*/
function setKbWideTopPosition(){
	var varTop = getBodyScrollTop();
	if(getBodyScrollTop()==0) varTop = 0;
	varTop += 250;
	return varTop + "px";
}
function setKbWideLeftPosition(){
	var varLeft = 265;
	if(kblist_wide==1){ //확장상태
		varLeft = 460;
	}
	varLeft = varLeft - getBodyScrollLeft();
	return varLeft + "px";
}
function cmdAfterLoginKbTop(review){
	if(typeof(review)=="undefined"){
		review = "";
	}
	top.hideNonbanking_site();
	top.cmdMyAreaReload();
	top.showLoginStatus();
	top.hideLoginLayer();
	top.hideLoginAutoAlert();
	if(document.getElementById("kbtop_code_add")){
		if(islogin()){
			document.getElementById("kbtop_code_add").style.display = "block";
			var sc = document.cookie;
			if(sc.indexOf("AP_YN=2")>=0){
				if(document.getElementById("kbtop_phonesale_writebtn")){
					document.getElementById("kbtop_phonesale_writebtn").style.display = "block";
				}
			}
		}else{
			document.getElementById("kbtop_code_add").style.display = "none";
		}
	}
	if(document.getElementById("blogGroupNo") && document.getElementById("blogGroupNo").innerHTML=="3"){ //블로그 질문답변
		if(islogin()){
			//document.getElementById("top_group3_myqna").style.display = "";
		}
		loadBlogQnaLogin(0);
	}
	if(document.getElementById("ifBodyRead")){
		if(review=="REVIEW_APP"){ //체험단 신청
			setReviewAppSession();
		}
		document.getElementById("ifBodyRead").contentWindow.location.reload();
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
function hideAllLayer(){
	if(document.getElementById("kb_codelist")){
		document.getElementById("kb_codelist").style.display = "none";
	}
	if(document.getElementById("select_paging_group")){
		document.getElementById("select_paging_group").style.display = "none";
	}
	if(document.getElementById("sort_mode")){
		hideSortmode();
	}
}
var iKbListTop = 0; //my메뉴 없을때 목록top위치
var iKbListAddCodeTop = 0;  //my메뉴 있을때 목록top위치
var iKbListTop_now = 0;
function cmdListWide(){
	if(kblist_wide==0){ //축소상태 -> 확장시키기
		insertLog(5732);
		kblist_wide = 1;
		if(iKbListTop>=iKbListAddCodeTop){
			var obj_height = $("kbtop_code_add").getHeight();
			iKbListAddCodeTop = iKbListTop+obj_height;
		}
		document.getElementById("kb_list_top_blank").style.height = $("kb_list_top2").getHeight()+"px";
		document.getElementById("kb_list_top_blank").style.display = "block";
		document.getElementById("kb_list_top3").className = "td_kblist_top3_b";
		document.getElementById("kb_list_widegb_blank").style.display = "block";
		document.getElementById("kb_list_top2").className = "td_kblist_top2_b";
		if((BrowserDetect.browser=="Explorer" && BrowserDetect.version==6) || (BrowserDetect.OS=="iPad" && BrowserDetect.browser=="Safari")) {
			if(document.getElementById("kb_list_box").style.position!="absolute"){
				document.getElementById("kb_list_box").style.position = "absolute";
				document.getElementById("kb_list_box").style.top = iKbListTop_now+"px";
			}
		}else{
			if(document.getElementById("kb_list_box").style.position=="fixed"){ //떠있는상태
				
			}else{ //일반상태
				document.getElementById("kb_list_box").style.top = "";
				document.getElementById("kb_list_box").style.bottom = "";
				document.getElementById("kb_list_box").style.position = "absolute";
			}
		}
		if(BrowserDetect.browser=="Explorer" && (BrowserDetect.version==6 || BrowserDetect.version==7)){
			setKbListWidth();
		}
		if(document.getElementById("btn_kb_wide")){
			document.getElementById("btn_kb_wide").src = document.getElementById("btn_kb_wide").src.replace("btn_listopen.png","btn_listhide.png");
			setBtnKbWideLeftPosition();
		}
		for(i=1;i<50;i++){
			if(document.getElementById("kb_article_title_"+i)){
				if(document.getElementById("kb_article_title_"+i).className=="kb_article_title_guide"){ //상품사진없음
					if((BrowserDetect.browser=="Explorer" && (BrowserDetect.version==6 || BrowserDetect.version==7)) || (BrowserDetect.OS=="iPad" && BrowserDetect.browser=="Safari")) {
						document.getElementById("kb_article_title_"+i).style.width = "454px";
						document.getElementById("kb_article_info_"+i).style.width = "454px";
					}else{
						document.getElementById("kb_article_title_"+i).style.width = "446px";
						document.getElementById("kb_article_info_"+i).style.width = "446px";
					}
				}else{
					if((BrowserDetect.browser=="Explorer" && (BrowserDetect.version==6 || BrowserDetect.version==7)) || (BrowserDetect.OS=="iPad" && BrowserDetect.browser=="Safari")) {
						document.getElementById("kb_article_"+i).style.width = "459px";
					}
					document.getElementById("kb_article_title_"+i).style.width = "395px";
					document.getElementById("kb_article_info_"+i).style.width = "395px";
				}
				if(document.getElementById("kb_article_title_simple_"+i) && document.getElementById("kb_article_title_wide_"+i)){
					document.getElementById("kb_article_title_simple_"+i).style.display = "none";
					document.getElementById("kb_article_title_wide_"+i).style.display = "";
				}
				if(document.getElementById("kb_article_kkname_"+i)) document.getElementById("kb_article_kkname_"+i).style.display = "block";
				if(document.getElementById("kb_article_writer_"+i)) document.getElementById("kb_article_writer_"+i).style.display = "block";
			}else{
				break;
			}
		}
		hideAllLayer();
		if(document.getElementById("kb_list_my_blank")){
			document.getElementById("kb_list_my_blank").style.width = "460px";
		}
		if(document.getElementById("phonesale_listtopline")){
			document.getElementById("phonesale_listtopline").style.width = "456px";
		}
		if(document.getElementById("search_now")){
			document.getElementById("search_now").style.width = "460px";
		}
		if(document.getElementById("search_now_txt")){
			document.getElementById("search_now_txt").style.width = "390px";
		}
		if(document.getElementById("search_bottom")){
			document.getElementById("search_bottom").style.width = "460px";
		}
		if(document.getElementById("tbl_paging")){
			document.getElementById("tbl_paging").style.width = "460px";
		}
		if(document.getElementById("paging_box")){
			document.getElementById("paging_box").style.width = (parseInt(document.getElementById("paging_box").style.width,10)+220)+"px";
		}
		if(document.getElementById("paging_add") && document.getElementById("paging_2")){
			var paging_add = document.getElementById("paging_2").innerHTML;
			document.getElementById("paging_add").innerHTML = paging_add;
			document.getElementById("paging_add").style.width = "66px";
			document.getElementById("paging_2").innerHTML = "";
		}
		if(document.getElementById("paging_group_add") && document.getElementById("paging_group_2")){
			var paging_group_add = document.getElementById("paging_group_2").innerHTML;
			document.getElementById("paging_group_add").innerHTML = paging_group_add;
			document.getElementById("paging_group_2").innerHTML = "";
		}
		if(document.getElementById("kb_add")){
			document.getElementById("kb_add").style.width = "450px";
		}
		if(document.getElementById("sponsor_link")){
			document.getElementById("sponsor_link").style.width = "450px";
		}
		document.getElementById("kb_list_box_blank").style.height = document.getElementById("kb_list_box").getHeight()+"px";
	}else{ //확장상태 -> 축소시키기
		insertLog(5733);
		kblist_wide = 0;
		document.getElementById("kb_list_top2").className = "td_kblist_top2_s";
		document.getElementById("kb_list_top3").className = "td_kblist_top3_s";
		document.getElementById("kb_list_top_blank").style.display = "none";
		document.getElementById("kb_list_widegb_blank").style.display = "none";
		if((BrowserDetect.browser=="Explorer" && BrowserDetect.version==6) || (BrowserDetect.OS=="iPad" && BrowserDetect.browser=="Safari")) {
			if(document.getElementById("ph_list").offsetHeight >= (document.getElementById("ph_con1").offsetHeight + document.getElementById("ph_con2").offsetHeight)){ //목록이 글내용보다 길때
				document.getElementById("kb_list_box").style.position = "static";
			}else{
				if(Position.cumulativeOffset($("kb_list_box"))[1]>Position.cumulativeOffset($("kb_list_box_blank"))[1]){ //떠있는상태
				
				}else{
					document.getElementById("kb_list_box").style.position = "static";
				}
			}
		}else{
			if(document.getElementById("kb_list_box").style.position=="fixed"){ //떠있는상태
	
			}else{ //일반상태
				document.getElementById("kb_list_box").style.position = "static";
				document.getElementById("kb_list_box").style.bottom = "";
			}		
		}
		if(BrowserDetect.browser=="Explorer" && (BrowserDetect.version==6 || BrowserDetect.version==7)){
			setKbListWidth();
		}
		if(document.getElementById("btn_kb_wide")){
			document.getElementById("btn_kb_wide").src = document.getElementById("btn_kb_wide").src.replace("btn_listhide.png","btn_listopen.png");
			setBtnKbWideLeftPosition();
		}
		for(i=1;i<50;i++){
			if(document.getElementById("kb_article_title_"+i)){
				if(document.getElementById("kb_article_title_"+i).className=="kb_article_title_guide"){
					document.getElementById("kb_article_title_"+i).style.width = "226px";
					document.getElementById("kb_article_info_"+i).style.width = "226px";
				}else{
					if((BrowserDetect.browser=="Explorer" && (BrowserDetect.version==6 || BrowserDetect.version==7)) || (BrowserDetect.OS=="iPad" && BrowserDetect.browser=="Safari")) {
						document.getElementById("kb_article_"+i).style.width = "239px";
					}
					document.getElementById("kb_article_title_"+i).style.width = "175px";
					document.getElementById("kb_article_info_"+i).style.width = "175px";
				}
				if(document.getElementById("kb_article_title_simple_"+i) && document.getElementById("kb_article_title_wide_"+i)){
					document.getElementById("kb_article_title_simple_"+i).style.display = "";
					document.getElementById("kb_article_title_wide_"+i).style.display = "none";
				}
				if(document.getElementById("kb_article_kkname_"+i)) document.getElementById("kb_article_kkname_"+i).style.display = "none";
				if(document.getElementById("kb_article_writer_"+i)) document.getElementById("kb_article_writer_"+i).style.display = "none";
			}else{
				break;
			}
		}
		hideAllLayer();
		if(document.getElementById("kb_list_my_blank")){
			document.getElementById("kb_list_my_blank").style.width = "240px";
		}
		if(document.getElementById("phonesale_listtopline")){
			document.getElementById("phonesale_listtopline").style.width = "236px";
		}
		if(document.getElementById("search_now")){
			document.getElementById("search_now").style.width = "240px";
		}
		if(document.getElementById("search_now_txt")){
			document.getElementById("search_now_txt").style.width = "170px";
		}
		if(document.getElementById("search_bottom")){
			document.getElementById("search_bottom").style.width = "240px";
		}
		if(document.getElementById("tbl_paging")){
			document.getElementById("tbl_paging").style.width = "240px";
		}
		if(document.getElementById("paging_box")){
			document.getElementById("paging_box").style.width = (parseInt(document.getElementById("paging_box").style.width,10)-220)+"px";
		}
		if(document.getElementById("paging_add") && document.getElementById("paging_2")){
			var paging_add = document.getElementById("paging_add").innerHTML;
			document.getElementById("paging_2").innerHTML = paging_add;
			document.getElementById("paging_add").innerHTML = "";
			document.getElementById("paging_add").style.width = "0";
		}
		if(document.getElementById("paging_group_add") && document.getElementById("paging_group_2")){
			var paging_group_add = document.getElementById("paging_group_add").innerHTML;
			document.getElementById("paging_group_2").innerHTML = paging_group_add;
			document.getElementById("paging_group_add").innerHTML = "";
		}
		if(document.getElementById("kb_add")){
			document.getElementById("kb_add").style.width = "226px";
		}
		if(document.getElementById("sponsor_link")){
			document.getElementById("sponsor_link").style.width = "226px";
		}
		document.getElementById("kb_list_box_blank").style.height = "0";
	}
}
function cmdKbCateAll(){ //최근글 전체
	location.href = "List.jsp";
}
function cmdKbCatelist(kbcate){
	insertLog(5978);
	if(kbcate=="kb0"){
		insertLog(5698);
	}else if(kbcate=="kb1"){
		insertLog(5699);
	}else if(kbcate=="kb2"){
		insertLog(5700);
	}else if(kbcate=="kb3"){
		insertLog(5701);
	}else if(kbcate=="kb4"){
		insertLog(5702);
	}else if(kbcate=="kb5"){
		insertLog(5703);
	}else if(kbcate=="kb6"){
		insertLog(5704);
	}else if(kbcate=="kb7"){
		insertLog(5705);
	}else if(kbcate=="kb8"){
		insertLog(5706);
	}else if(kbcate=="kb9"){
		insertLog(5707);
	}else if(kbcate=="kb10"){
		insertLog(5708);
	}else if(kbcate=="kb11"){
		insertLog(5980);
	}
	var obj = document.getElementById("frmKbList");
	obj.kbcate.value = kbcate;
	if(kbcate!="kb11" && (obj.kbcode.value=="mc1" || obj.kbcode.value=="mc2" || obj.kbcode.value=="mc3" || obj.kbcode.value=="mc4")){
		obj.kbcode.value = "";
	}else if(kbcate!="kb0" && obj.kbcode.value=="kc7"){
		obj.kbcode.value = "";
	}
	if(obj.kbcode.value=="kc8"){
		obj.kbcode.value = "";
	}
	obj.kbno.value = 0;
	obj.kb_keyword.value = "";
	obj.page.value = 0;
	obj.action = "List.jsp";
	obj.submit();
}
function cmdKbCodelist(kbcode){
	var obj = document.getElementById("frmKbList");
	insertLog(5979);
	if(kbcode=="kc0"){
		insertLog(5691);
	}else if(kbcode=="kc1"){
		insertLog(5693);
	}else if(kbcode=="kc2"){
		insertLog(5694);
	}else if(kbcode=="kc3"){
		insertLog(5695);
	}else if(kbcode=="kc4"){
		insertLog(5690);
	}else if(kbcode=="kc5"){
		insertLog(5689);
	}else if(kbcode=="kc6"){
		insertLog(5692);
	}else if(kbcode=="kc7"){
		insertLog(7350);
	}else if(kbcode=="kc8"){
		obj.kbcate.value = "";
	}else if(kbcode==""){
		insertLog(5688);
	}
	obj.kbcode.value = kbcode;
	obj.kbno.value = 0;
	obj.modelno.value = 0;
	obj.kb_keyword.value = "";
	obj.page.value = 0;
	obj.action = "List.jsp";
	//obj.action = "ListPoll.jsp"; //토론방
	obj.submit();
}
function cmdListSetPhoneOut(kbno,pout,nick){
	for(i=1;i<50;i++){
		if(document.getElementById("kb_article_"+i)){
			if(document.getElementById("kb_article_"+i).getAttribute("kbno")==kbno){
				if(pout==1){
					document.getElementById("kb_article_title_simple_"+i).style.color = "#b4b4b4";
					document.getElementById("kb_article_title_wide_"+i).style.color = "#b4b4b4";
				}else{
					document.getElementById("kb_article_title_simple_"+i).style.color = "#5f5f5f";
					document.getElementById("kb_article_title_wide_"+i).style.color = "#5f5f5f";
				}
				document.getElementById("kb_article_title_simple_nick_"+i).innerHTML = nick;
				document.getElementById("kb_article_title_wide_nick_"+i).innerHTML = nick;
				break;
			}
		}
	}
}
function cmdOpenBlog(){
	insertLog(6271);
	var w = window.screen.width;
	if(w>=1024){
		w = 1012;
		if(getBrowserName()=="msie6"){
			w = 1024;
		}
	}
	var h = screen.availHeight;
	var win = window.open("/blog/","enuri_blog","width="+w+" height="+h+" top=0 left=0 toolbar=yes,location=yes,directories=yes,status=yes,scrollbars=yes,resizable=yes,menubar=yes,personalbar=yes");
	win.focus();
}
function cmdViewKbcodeBox(){
	if(document.getElementById("kb_codelist")){
		if(document.getElementById("kb_codelist").style.display=="block"){
			document.getElementById("kb_codelist").style.display = "none";
		}else{
			document.getElementById("kb_codelist").style.display = "block";
		}
	}
}
function cmdMyKb(menuno){
	location.href = "MyList.jsp?menuno="+menuno;
}
function cmdPhoneWrite(){
	var surl = "/knowbox/List_write.jsp?kbcate=kb0&kbcode=kc7&cate=0304&rcontent=write";
	document.getElementById("ifBodyRead").src = surl;
	if(document.getElementById("kb_article_"+kblist_nowidx)){
		document.getElementById("kb_article_"+kblist_nowidx).className = "kblist_article_normal";
	}
}
function cmdPhoneTab(factory){
	insertLog(7352);
	document.frmKbListSearch_T.factory.value = factory;
	document.frmKbListSearch_T.submit();
}
function cmdSetMovieIcon(idx,change){ //제목에 동영상아이콘 있을때 배경변화때문에 이미지 교체해줘야함
	var cstr = "";
	var chtml = "";
	if(change=="now"){
		cstr = "bde1ff";
	}else{
		cstr = "f7f7f7";
	}
	if(document.getElementById("kb_article_title_"+idx) && document.getElementById("kb_article_title_"+idx).getAttribute("ctype")=="knowbox"){
		chtml = document.getElementById("kb_article_title_"+idx).innerHTML;
		chtml = chtml.replace("f7f7f7",cstr);
		chtml = chtml.replace("f7f7f7",cstr);
		chtml = chtml.replace("bde1ff",cstr);
		chtml = chtml.replace("bde1ff",cstr);
		if(document.getElementById("mysave_kmno_"+idx)){ //저장한글일때 체크상태유지해줌
			if(document.getElementById("mysave_kmno_"+idx).checked==true){
				chtml = chtml.replace("id=mysave_kmno_"+idx,"id=mysave_kmno_"+idx+" checked",cstr);
			}
		}
		document.getElementById("kb_article_title_"+idx).innerHTML = chtml;
	}
}
function cmdRead(idx,kbno,modelno,bloghide){
	if(typeof(bloghide)=="undefined"){
		bloghide = 1;
	}
	if(bloghide && document.getElementById("blog_info_top")) document.getElementById("blog_info_top").style.display = "none";
	insertLog(5734);
	flagRun = 1;
	if(kblist_wide==1){ //확장->축소
		cmdListWide();
	}
	var obj = document.getElementById("frmKbList");
	var surl = "List_read.jsp?kbno="+kbno;
	if(iKbno==kbno) surl += "&from="+strFrom;
	document.getElementById("ifBodyRead").src = surl;
	if(document.getElementById("kb_article_"+kblist_nowidx)){
		document.getElementById("kb_article_"+kblist_nowidx).className = "kblist_article_normal";
	}
	cmdSetMovieIcon(kblist_nowidx,"read");
	document.getElementById("kb_article_"+idx).className = "kblist_article_now";
	if(document.getElementById("kb_article_regdate_"+idx)){
		document.getElementById("kb_article_regdate_"+idx).className = "kb_article_regdate_read";
	}
	if(document.getElementById("kb_article_readcnt_"+idx)){
		document.getElementById("kb_article_readcnt_"+idx).className = "kb_article_readcnt_read";
	}
	cmdSetMovieIcon(idx,"now");
	obj.kbno.value = kbno;
	obj.iscar.value = "";
	kblist_nowidx = idx;
	intReadFrmHeight = -1;
	cmdSetScroll(0);
	hideAllLayer();
}
function cmdReadModel(idx,modelno){
	if(document.getElementById("blog_info_top")) document.getElementById("blog_info_top").style.display = "none";
	insertLog(5734);
	flagRun = 1;
	if(kblist_wide==1){ //확장->축소
		cmdListWide();
	}
	var obj = document.getElementById("frmKbList");
	var surl = "List_readBbs.jsp?modelno="+modelno;
	document.getElementById("ifBodyRead").src = surl;
	if(document.getElementById("kb_article_"+kblist_nowidx)){
		document.getElementById("kb_article_"+kblist_nowidx).className = "kblist_article_normal";
	}
	document.getElementById("kb_article_"+idx).className = "kblist_article_now";
	if(document.getElementById("kb_article_regdate_"+idx)){
		document.getElementById("kb_article_regdate_"+idx).className = "kb_article_regdate_read";
	}
	if(document.getElementById("kb_article_readcnt_"+idx)){
		document.getElementById("kb_article_readcnt_"+idx).className = "kb_article_readcnt_read";
	}
	obj.modelno.value = modelno;
	obj.iscar.value = "";
	kblist_nowidx = idx;
	intReadFrmHeight = -1;
	cmdSetScroll(0);
	hideAllLayer();
}
function cmdReadCar(idx,kbno,modelno,bloghide){
	if(typeof(bloghide)=="undefined"){
		bloghide = 1;
	}
	if(bloghide && document.getElementById("blog_info_top")) document.getElementById("blog_info_top").style.display = "none";
	insertLog(5734);
	flagRun = 1;
	if(kblist_wide==1){ //확장->축소
		cmdListWide();
	}
	var obj = document.getElementById("frmKbList");
	var surl = "/car/knowbox/Auto_Knowbox_Read_Main.jsp?knowbox_top=y&kb_no="+kbno+"&modelno="+modelno;
	document.getElementById("ifBodyRead").src = surl;
	if(document.getElementById("kb_article_"+kblist_nowidx)){
		document.getElementById("kb_article_"+kblist_nowidx).className = "kblist_article_normal";
	}
	cmdSetMovieIcon(kblist_nowidx,"read");
	document.getElementById("kb_article_"+idx).className = "kblist_article_now";
	if(document.getElementById("kb_article_regdate_"+idx)){
		document.getElementById("kb_article_regdate_"+idx).className = "kb_article_regdate_read";
	}
	if(document.getElementById("kb_article_readcnt_"+idx)){
		document.getElementById("kb_article_readcnt_"+idx).className = "kb_article_readcnt_read";
	}
	cmdSetMovieIcon(idx,"now");
	obj.kbno.value = kbno;
	obj.modelno.value = modelno;
	obj.iscar.value = "auto";
	kblist_nowidx = idx;
	intReadFrmHeight = -1;
	cmdSetScroll(0);
	hideAllLayer();
}
function cmdFindKb(kbno){
	var obj = document.getElementById("frmKbList");
	if(document.getElementById("kb_article_"+kblist_nowidx)){
		document.getElementById("kb_article_"+kblist_nowidx).className = "kblist_article_normal";
	}
	cmdSetMovieIcon(kblist_nowidx,"read");
	kblist_nowidx = 0;
	for(i=1; i<50; i++){
		if(document.getElementById("kb_article_"+i)){
			if(document.getElementById("kb_article_"+i).getAttribute("kbno")==kbno){
				kblist_nowidx = i;
			}
		}
	}
	if(kblist_nowidx==0){
		if(sKbcode!="kc8" && iGroup==3){ //블로그 질문답변글인 경우 고정 질문답변을 현재글로 표시
			for(i=1; i<50; i++){
				if(document.getElementById("kb_article_"+i)){
					if(document.getElementById("kb_article_"+i).getAttribute("bgroup")==3){
						kblist_nowidx = i;
					}
				}
			}
		}
	}
	if(kblist_nowidx>0){
		document.getElementById("kb_article_"+kblist_nowidx).className = "kblist_article_now";
		if(document.getElementById("kb_article_regdate_"+kblist_nowidx)){
			document.getElementById("kb_article_regdate_"+kblist_nowidx).className = "kb_article_regdate_read";
		}
		if(document.getElementById("kb_article_readcnt_"+kblist_nowidx)){
			document.getElementById("kb_article_readcnt_"+kblist_nowidx).className = "kb_article_readcnt_read";
		}
		cmdSetMovieIcon(kblist_nowidx,"now");
		obj.kbno.value = kbno;
		obj.iscar.value = "";
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
function showGroupList(originalRequest){
	var orgHTML = originalRequest.responseText.trim();
	var blogGroupRunKey = eval(orgHTML.substring(orgHTML.indexOf("blogGroupRunKey")+17, orgHTML.indexOf("</div>",orgHTML.indexOf("blogGroupRunKey")+17)));
	var blogGroup = eval(orgHTML.substring(orgHTML.indexOf("blogGroupNo")+13, orgHTML.indexOf("</div>",orgHTML.indexOf("blogGroupNo")+13)));
	var blogGroupKbno = eval(orgHTML.substring(orgHTML.indexOf("blogGroupKbno")+15, orgHTML.indexOf("</div>",orgHTML.indexOf("blogGroupKbno")+15)));
	$("ifBodyRead").style.display = "block";
	if(blogGroupRunKey==iRunKey){
		//alert(orgHTML);
		document.getElementById("blog_info_top").innerHTML = orgHTML;
		if(blogGroup==3){ //질문답변
			if(islogin()){
				//document.getElementById("top_group3_myqna").style.display = "";
			}
			loadBlogQnaLogin(0);
		}
		document.getElementById("blog_info_top").style.display = "block";
		if(iKbno==0 && blogGroupKbno>0){
			var obj = document.getElementById("frmKbList");
			var surl = "List_read.jsp?kbno="+blogGroupKbno;
			document.getElementById("ifBodyRead").src = surl;
			iKbno = blogGroupKbno;
			obj.kbno.value = blogGroupKbno;
			obj.iscar.value = "";
			cmdFindKb(iKbno);
		}
	}
	if(varLinkChk==1){
		cmdQna(3,0);
		varLinkChk=0;
	}
	
}
function loadGroupList(nowPage,qnatype){
	if(typeof(qnatype)=="undefined"){
		qnatype = "";
	}
	var url = "/blog/IncBlogKbTop.jsp";
	var param = "runkey="+iRunKey+"&group="+iGroup+"&bmno="+iBmno+"&kbno="+iKbno+"&qnatype="+qnatype+"&page="+nowPage;
	var getRec = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:showGroupList
		}
	);
}
function cmdBlogGroup(group,kbno){
	if(typeof(group)=="undefined"){
		group = iGroup;
	}
	if(typeof(kbno)=="undefined"){
		kbno = 0;
	}
	iRunKey++;
	iGroup = group;
	iBmno = 0;
	iKbno = kbno;
	loadGroupList(0);
}
function cmdBmList(bmno){
	try{
		if(iBmno==bmno){
			return;
		}
		iBmno = bmno;
		iKbno = 0;
		iRunKey++;
		loadGroupList(0);
	}catch(e){}
}
function cmdBlogRead(group,idx){
	insertLog(5734);
	flagRun = 1;
	if(kblist_wide==1){ //확장->축소
		cmdListWide();
	}
	iGroup = group;
	iBmno = 0;
	iKbno = 0;
	loadGroupList(0);
	if(document.getElementById("kb_article_"+kblist_nowidx)){
		document.getElementById("kb_article_"+kblist_nowidx).className = "kblist_article_normal";
	}
	cmdSetMovieIcon(kblist_nowidx,"read");
	document.getElementById("kb_article_"+idx).className = "kblist_article_now";
	if(document.getElementById("kb_article_regdate_"+idx)){
		document.getElementById("kb_article_regdate_"+idx).className = "kb_article_regdate_read";
	}
	if(document.getElementById("kb_article_readcnt_"+idx)){
		document.getElementById("kb_article_readcnt_"+idx).className = "kb_article_readcnt_read";
	}
	cmdSetMovieIcon(idx,"now");
	kblist_nowidx = idx;
	intReadFrmHeight = -1;
	cmdSetScroll(0);
	hideAllLayer();
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
function groupPrevPage(){
	var nowPage = eval(document.getElementById("group_page").innerHTML);
	var pageCount = eval(document.getElementById("group_pagecount").innerHTML);
	if(nowPage=="" || nowPage<=1){
		nowPage = pageCount;
	}else{
		nowPage--;
	}
	iRunKey++;
	loadGroupList(nowPage);
}
function groupNextPage(){
	var nowPage = eval(document.getElementById("group_page").innerHTML);
	var pageCount = eval(document.getElementById("group_pagecount").innerHTML);
	if(nowPage>=pageCount){
		nowPage = 1;
	}else{
		nowPage++;	
	}
	iRunKey++;
	loadGroupList(nowPage);
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
	cmdFindKb(iKbno);
	var obj = document.getElementById("frmKbList");
	var surl = "List_read.jsp?kbno="+iKbno;
	document.getElementById("ifBodyRead").src = surl;
	obj.kbno.value = iKbno;
	obj.iscar.value = "";
}
function cmdListMyQna(kbno){
	iKbno = kbno;
	var obj = document.getElementById("frmKbList");
	var surl = "List_read.jsp?kbno="+iKbno+"&myqna=1&findmyqna=0";
	document.getElementById("ifBodyRead").src = surl;
	obj.kbno.value = iKbno;
	obj.iscar.value = "";
}
function cmdModifyBlogQna(kbno){
	iRunKey++;
	iGroup = 3;
	iBmno = 0;
	iKbno = kbno;
	var obj = document.getElementById("frmKbList");
	obj.kbno.value = iKbno;
	obj.iscar.value = "";
	loadGroupList(1,'m');
}
function cmdDelBlogFile(){
	var obj = document.getElementById("frmWKnowBox");
	//if(confirm("첨부된 파일을 삭제하시겠습니까?")){
		obj.delfile.value = "1";
		document.getElementById("bbs_file_modify").style.display = "none";
		document.getElementById("bbs_file_input").style.display = "block";
	//}
}
function cmdBlogKbread(group, kbno, myqna){ //Blog_list.jsp에서 호출
	if(typeof(myqna)=="undefined"){
		myqna = "";
	}
	iKbno = kbno;
	var obj = document.getElementById("frmKbList");
	var surl = "List_read.jsp?kbno="+iKbno+"&myqna="+myqna;
	document.getElementById("ifBodyRead").src = surl;
	obj.kbno.value = iKbno;
	obj.iscar.value = "";
	cmdFindKb(kbno);
	intReadFrmHeight = -1;
	cmdSetScroll(0);
	hideAllLayer();
}
var isKbWriteProgress = 0;
function cmdBlogQnaWriteSubmit(){
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
function cmdAfterKbWrite(kbno){
	isKbWriteProgress = 0;
	iKbno = kbno;
	loadGroupList(1);
	var obj = document.getElementById("frmKbList");
	var surl = "List_read.jsp?kbno="+iKbno;
	document.getElementById("ifBodyRead").src = surl;
	obj.kbno.value = iKbno;
	obj.iscar.value = "";
	intReadFrmHeight = -1;
	cmdSetScroll(0);
	hideAllLayer();
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
function cmdMylistCheck(obj){ //저장한글 체크박스 클릭
	insertLog(5760);
	var frm = document.getElementById("frmMyListCheck");
	var chcount = 0;
	var bxcount = 0;
	var chlist = "";
	for(i=0; i<frm.elements.length; i++){
		var el = frm.elements[i];
		if(el.getAttribute("NAME")=="mysave_kmno"){
			bxcount++;
		}
	}
	if(bxcount==1){
		if(obj.checked){
			chcount = 1;
			chlist = obj.value;
		}
	}else if(bxcount > 1){
		var fcount = frm.mysave_kmno.length;
		for(i=0; i<fcount; i++) {
			if(frm.mysave_kmno[i].checked){
				chcount++;
	        	if(chlist==""){
	        		chlist = frm.mysave_kmno[i].value;
	        	}else{
	        		chlist = chlist + "," + frm.mysave_kmno[i].value;	
	        	}
			}
		}
	}
	frm.chklist.value = chlist;
	if(document.getElementById("mylist_checkbtn")){
		if(chcount==0){
			document.getElementById("mylist_checkbtn").style.display = "none";
		}else{
			var left = Position.cumulativeOffset(obj)[0];
			var top = Position.cumulativeOffset(obj)[1]+15;
			if($("kb_list_box").style.position=="absolute" || $("kb_list_box").style.position=="fixed"){
				var top_e = Position.cumulativeOffset($("kb_list_box"))[1];
				top = top - top_e;
			}
			document.getElementById("mylist_checkbtn").style.display = "block";
			document.getElementById("mylist_checkbtn").style.left = left+"px";
			document.getElementById("mylist_checkbtn").style.top = top+"px";
		}
	}
}
function cmdMylistDel(){ //저장한글 삭제
	insertLog(5761);
	if(confirm("선택한 글을 저장목록에서 삭제하시겠습니까?")){
		var frm = document.getElementById("frmMyListCheck");
		frm.mode.value = "save_del";
		frm.action = "/knowbox/MyList_proc.jsp";
		frm.submit();
	}
}
function over_view_mode(obj){
	obj.className = "over";
}
function out_view_mode(obj){
	obj.className = "out";
}
function chkKbListSearch(obj,where){
	if(obj.kb_keyword.value.trim().length==1){
		alert("2자 이상의 검색어를 넣으세요");
		return false;
	}
	if(preCheckKbSearchKeyword(where)){
		insertLog(5735);
		obj.submit();
	}
}

function chkKbSmartListSearch(where){
	if($("kb_keyword_t").value.trim().length < 2 && 1 < $("kb_keyword_t").value.trim().length){
		alert("2자 이상의 검색어를 넣으세요");
		return false;
	}
	if(preCheckKbSearchKeyword(where)){
		var searchWord = $("kb_keyword_t").value.trim();
		var url = "/knowbox/IncKbList_Drawlist_Count_Proc.jsp";
		var param = "smart_tap_menu="+varStrSmartTapMenu+"&searchword="+searchWord;
		var getRec = new Ajax.Request(
			url,
			{
				method:'get',parameters:param,onComplete:chkKbSmartListSearchCallback
			}
		);			
	}
}
function chkKbSmartListSearchCallback(originalRequest){
	eval("varReturn = " + originalRequest.responseText);
	var cnt = eval("varReturn.count");
	if(cnt==0){
		alert("검색 결과가 없습니다.");
	}else{
		insertLog(5735);
		smart_list_search();
	}
}

function getKbKeywordObj(where){
	if(where=="t"){
		return document.getElementById("kb_keyword_t");
	}else{
		return document.getElementById("kb_keyword_b");
	}
}
function preCheckKbSearchKeyword(where){
	var varKeyword = getKbKeywordObj(where).value;
	varKeyword = convertSpecialKeyword(varKeyword);
	getKbKeywordObj(where).value = varKeyword;
	return true;
}
function showSortmode(){
	if (document.getElementById("sort_mode").style.display=="block"){
		document.getElementById("sort_mode").style.display = "none";
		document.getElementById("img_sort_btn").src = document.getElementById("img_sort_btn").src.replace("newdown_close.gif","newdown.gif");
	}else{
		var posLeftTop = Position.cumulativeOffset($("search_sort"));
		document.getElementById("sort_mode").style.left = posLeftTop[0]+"px";
		document.getElementById("sort_mode").style.top = posLeftTop[1]+18+"px";
		document.getElementById("sort_mode").style.display = "block";
		document.getElementById("img_sort_btn").src = document.getElementById("img_sort_btn").src.replace("newdown.gif","newdown_close.gif"); 
	}
}
function hideSortmode(){
	if (document.getElementById("sort_mode").style.display=="block"){
		document.getElementById("sort_mode").style.display = "none";
		document.getElementById("img_sort_btn").src = document.getElementById("img_sort_btn").src.replace("newdown_close.gif","newdown.gif");
	}
}
function select_sort(sort){
	if(sKbcode == "kc8"){
		var obj = document.getElementById("frmKbList");
		obj.kbsort.value = sort;
		smart_list_sort(sort);
	}else{
		var obj = document.getElementById("frmKbList");
		obj.page.value = "";
		obj.kbno.value = "";
		obj.modelno.value = "";
		obj.kbsort.value = sort;
		obj.submit();
	}
}
function goPage(i){
	insertLog(5736);
	var obj = document.getElementById("frmKbList");
	obj.page.value = i;
	obj.kbno.value = "";
	obj.modelno.value = "";
	obj.submit();
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
		setFrameHeight(sh);
	}
	if((BrowserDetect.browser=="Explorer" && BrowserDetect.version==6) || (BrowserDetect.OS=="iPad" && BrowserDetect.browser=="Safari")) {
		setKbListTopPositionIE6();
	}else{
		setKbListTopPosition();
	}
}
function initFrame(obj){

}
//스크롤 위치 조정
function cmdSetScroll(param){
	if(param==0){
		document.getElementById("kb_list_box_blank").style.height = "0";
		document.getElementById("kb_list_widegb_blank").style.height = "0";
	}
	if (document.body.scrollTop){
		document.body.scrollTop = param+"px";
	}else{
		document.documentElement.scrollTop = param+"px";
	}
	if((BrowserDetect.browser=="Explorer" && BrowserDetect.version==6) || (BrowserDetect.OS=="iPad" && BrowserDetect.browser=="Safari")) {
		setKbListTopPositionIE6();
	}else{
		setKbListTopPosition();
	}
}
function setKbListWidth(){
	var obj = $("kb_list_box");
	if(BrowserDetect.browser=="Explorer" && (BrowserDetect.version==6 || BrowserDetect.version==7)){
		if(kblist_wide==0){ //축소상태
			obj.style.width = "240px";
		}else{
			obj.style.width = "460px";
		}
	}
}
//확장버튼 위치고정
function setBtnKbWideLeftPosition(){
	var varLeftPos = 0;
	if(kblist_wide==0){ //축소상태
		varLeftPos = 240;
	}else{
		varLeftPos = 460;
	}
	if(!(BrowserDetect.browser=="Explorer" && BrowserDetect.version==6) && !(BrowserDetect.OS=="iPad" && BrowserDetect.browser=="Safari")) {
		varLeftPos = varLeftPos - getBodyScrollLeft();
	}
	if(document.getElementById("btn_kb_wide")) document.getElementById("btn_kb_wide").style.left = varLeftPos + "px"
}
function setBtnKbWideTopPositionIE6(){
	var varTop = 0;
	varTop = 240 + getBodyScrollTop();
	return varTop + "px";
}
//목록 위치고정
function setKbListLeftPosition(){
	var obj = $("kb_list_box");
	var varLeftPos = 1;
	if((BrowserDetect.browser=="Explorer" && BrowserDetect.version==6) || (BrowserDetect.OS=="iPad" && BrowserDetect.browser=="Safari")){
		varLeftPos = 1;
	}else{
		if(obj.style.position=="fixed"){
			varLeftPos = varLeftPos - getBodyScrollLeft();
		}
	}
	document.getElementById("kb_list_box").style.left = varLeftPos + "px";
}
function setKbListTopPositionIE6(){
	try{
		var obj = $("kb_list_box");
		setKbListTopValue();
		if(iKbListTop_now<=0){
			if(document.getElementById("kbtop_code_add").style.display=="block"){ //my메뉴 보기상태
				iKbListTop_now = iKbListAddCodeTop;
			}else{
				iKbListTop_now = iKbListTop;
			}
		}
		if(!document.getElementById("ph_list") || !document.getElementById("ph_con1") || !document.getElementById("ph_con2")){
			return 0;
		}
		if(document.getElementById("ph_list").offsetHeight >= (document.getElementById("ph_con1").offsetHeight + document.getElementById("ph_con2").offsetHeight)){ //목록이 글내용보다 길때
			if(kblist_wide==0){ //축소상태
				obj.style.position = "static";
				return 0;
			}else{ //확장상태
				obj.style.position = "absolute";
				return iKbListTop_now;
			}
		}else{
			if((obj.offsetHeight + iKbListTop_now) > (getBodyClientHeight() + getBodyScrollTop())){ //목록이 다 보이도록 스크롤을 내리지 않은 상태
				if(kblist_wide==0){ //축소상태
					obj.style.position = "static";
					return 0;
				}else{ //확장상태
					obj.style.position = "absolute";
					setKbListWidth();
					return iKbListTop_now;
				}
			}else{ //목록이 다 보이거나 목록 끝까지 스크롤을 내린상태
				if(obj.offsetHeight < getBodyClientHeight()){ //목록이 짧아서 화면에 다 보이는 경우
					document.getElementById("kb_list_widegb_blank").style.height = (getBodyScrollHeight()-iKbListTop_now)+"px";
					if(iKbListTop_now >= getBodyScrollTop()){ //정상상태로 
						if(kblist_wide==0){ //축소상태
							obj.style.position = "static";
							return 0;
						}else{ //확장상태
							obj.style.position = "absolute";
							setKbListWidth();
							return getBodyScrollTop()+iKbListTop_now;
						}
					}else{
						if(Position.cumulativeOffset(obj)[1] < getBodyScrollTop()){ //스크롤을 내리면 목록의 위를 고정
							obj.style.position = "absolute";
							setKbListWidth();
							return getBodyScrollTop()-1; //-1 해주지 않으면 끝까지 내렸을때 브라우저가 죽는다
						}else{
							obj.style.position = "static";
							return 0;
						}
					}
				}else{ //목록이 화면보다 길때 스크롤을 내리면 아래쪽을 고정
					obj.style.position = "absolute";
					setKbListWidth();
					var rtop = 0;
					if(getBodyClientHeight()+getBodyScrollTop()>=getBodyScrollHeight()){ //끝까지 내린상태
						rtop = getBodyScrollHeight()-obj.offsetHeight-1; //-1 해주지 않으면 끝까지 내렸을때 브라우저가 죽는다
					}else{
						rtop = getBodyClientHeight()+getBodyScrollTop()-obj.offsetHeight;
					}
					return rtop;
				}
			}
		}
	}catch(e){
		return 0;
	}
}
function setKbListTopValue(){
	if(iKbListTop<=0){
		if(document.getElementById("kbtop_code_add").style.display=="block"){ //my메뉴 보기상태
			if($("kb_list_box").style.position=="absolute" || $("kb_list_box").style.position=="fixed"){
				iKbListAddCodeTop = Position.cumulativeOffset($("kb_list_box_blank"))[1];
			}else{
				iKbListAddCodeTop = Position.cumulativeOffset($("kb_list_box"))[1];
			}
			iKbListTop = iKbListAddCodeTop - $("kbtop_code_add").getHeight();
		}else{
			if($("kb_list_box").style.position=="absolute" || $("kb_list_box").style.position=="fixed"){
				iKbListTop = Position.cumulativeOffset($("kb_list_box_blank"))[1];
			}else{
				iKbListTop = Position.cumulativeOffset($("kb_list_box"))[1];
			}
			iKbListAddCodeTop = iKbListTop;
		}
	}
}
function setKbListTopPosition(){
	var obj = $("kb_list_box");
	setKbListTopValue();
	if(iKbListTop_now<=0){
		if(document.getElementById("kbtop_code_add").style.display=="block"){ //my메뉴 보기상태
			iKbListTop_now = iKbListAddCodeTop;
		}else{
			iKbListTop_now = iKbListTop;
		}
	}
	if(!document.getElementById("ph_list") || !document.getElementById("ph_con1") || !document.getElementById("ph_con2")){
		return;
	}
	if(document.getElementById("ph_list").offsetHeight >= (document.getElementById("ph_con1").offsetHeight + document.getElementById("ph_con2").offsetHeight)){ //목록이 글내용보다 길때
		if(kblist_wide==0){ //축소상태
			obj.style.bottom = "";
			obj.style.top = "0";
			obj.style.position = "static";
		}else{ //확장상태
		}
	}else{
		if((obj.offsetHeight + iKbListTop_now) > (getBodyClientHeight() + getBodyScrollTop())){ //목록이 다 보이도록 스크롤을 내리지 않은 상태
			if(kblist_wide==0){ //축소상태
				obj.style.bottom = "";
				obj.style.top = "0";
				obj.style.position = "static";
			}else{ //확장상태
				obj.style.position = "absolute";
				obj.style.top = iKbListTop_now+"px";
				obj.style.bottom = "";
			}
			document.getElementById("kb_list_box_blank").style.height = "0";
		}else{ //목록이 다 보이거나 목록 끝까지 스크롤을 내린상태
			if(obj.offsetHeight < getBodyClientHeight()){ //목록이 짧아서 화면에 다 보이는 경우
				document.getElementById("kb_list_widegb_blank").style.height = (getBodyScrollHeight()-iKbListTop_now)+"px";
				if(iKbListTop_now >= getBodyScrollTop()){ //정상상태로
					if(kblist_wide==0){ //축소상태
						obj.style.bottom = "";
						obj.style.top = "0";
						obj.style.position = "static";
					}else{ //확장상태
						if(obj.style.position=="fixed"){
							obj.style.position = "absolute";
							obj.style.top = iKbListTop_now+"px";
							obj.style.bottom = "";
						}else{
						}
					}
					document.getElementById("kb_list_box_blank").style.height = "0";				
				}else{
					if(Position.cumulativeOffset(obj)[1] < getBodyScrollTop()){ //스크롤을 내리면 목록의 위를 고정
						obj.style.position = "fixed";
						obj.style.top = "0";
						obj.style.bottom = "";
						document.getElementById("kb_list_box_blank").style.height = obj.offsetHeight+"px";
					}else{
					}
				}
				setKbListWidth();
			}else{ //목록이 화면보다 길때 스크롤을 내리면 아래쪽을 고정
				obj.style.position = "fixed";
				obj.style.top = "";
				obj.style.bottom = "0";
				setKbListWidth();
				document.getElementById("kb_list_box_blank").style.height = obj.offsetHeight+"px";
			}
		}
	}
}
function cmdTmp(){
	if($("tmp_123")){
		//$("tmp_123").innerHTML = Position.cumulativeOffset($("kb_list_box_blank"))[1] + "," + $("kb_list_box_blank").style.height;
		//$("tmp_123").innerHTML = $("tmp_123").innerHTML + "<br>" + Position.cumulativeOffset($("kb_list_box"))[1] + "," + $("kb_list_box").getHeight() + "," + getBodyScrollHeight();
		//$("tmp_123").innerHTML = getBodyClientHeight() + "," + getBodyScrollTop() + " : " + getBodyScrollHeight() + "," + $("kb_list_box").offsetHeight;
		//$("tmp_123").innerHTML = Position.cumulativeOffset($("kb_list_box"))[1] + "," + Position.cumulativeOffset($("kb_list_box_blank"))[1];
		//$("tmp_123").innerHTML = document.getElementById("kb_list_widegb_blank").style.height;
		//$("tmp_123").innerHTML = getBodyScrollTop() + "," + iKbListTop_now;
		//$("tmp_123").innerHTML = iKbListTop + "," + iKbListAddCodeTop + "," + iKbListTop_now + "," + document.getElementById("kbtop_code_add").style.display;
		//$("tmp_123").innerHTML = $("kb_list_box_blank").style.height + "," + $("kb_list_box").offsetHeight + "," + Position.cumulativeOffset($("kb_list_box"))[1] + "," + ($("kb_list_box").offsetHeight + Position.cumulativeOffset($("kb_list_box"))[1]) + "," +  getBodyScrollHeight();
		if(document.getElementById("ph_list") && document.getElementById("ph_con2")){
			//$("tmp_123").innerHTML = document.getElementById("ph_list").offsetHeight+":"+document.getElementById("ph_con1").offsetHeight+"+"+document.getElementById("ph_con2").offsetHeight;
		}
		if((BrowserDetect.browser=="Explorer" && BrowserDetect.version==6) || (BrowserDetect.OS=="iPad" && BrowserDetect.browser=="Safari")) {
			$("tmp_123").style.top = getBodyScrollTop()+100;
		}
	}
}
window.setInterval("cmdTmp()",100);
window.onresize = function(){
	try{
		setTimeout(function(){
			setBtnKbWideLeftPosition();
		},100);
	}catch(e){}
	try{
		setTimeout(function(){
			setKbListLeftPosition();
		},100);
	}catch(e){}
}
window.onscroll = function(){
	try{
		setTimeout(function(){
			setBtnKbWideLeftPosition();
		},100);
	}catch(e){}
	try{
		setTimeout(function(){
			setKbListLeftPosition()
		},100);
	}catch(e){}
	try{
		if(!(BrowserDetect.browser=="Explorer" && BrowserDetect.version==6) && !(BrowserDetect.OS=="iPad" && BrowserDetect.browser=="Safari")) {
			setTimeout(function(){
				setKbListTopPosition();
			},100);
		}
	}catch(e){}
}
//구매가이드에서 필요한 함수
function knowBoxBigImgOpen_20091221(url1) {
	url1 = url1.replace("/view/include/BigImageOnlyPopup.jsp?","/view/Detailmulti.jsp?viewBimg=Y&");
	k = window.open(url1,"guideImgPopup","width=100,height=100,top=0,left=0,toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=no,menubar=no,personalbar=no");
	k.focus();
}
function goTop() {
	if(document.getElementById("wrap")) {
		document.getElementById("wrap").scrollIntoView(true);
	}
	if(document.getElementById("body")) {
		document.getElementById("body").scrollIntoView(true);
		document.getElementById("body").scrollTop = "0";
	}
}
function closeImgDiv(obj) {
	obj.style.display = "none";
}
function showImgDiv_20091221(imgPath) {
	if(document.getElementById("imgKnowboxTag")) {
		document.getElementById("imgKnowboxTag").src = imgPath;
		document.getElementById("imgKnowboxShowDiv").style.left = 160+"px";
	}
	if(document.getElementById("FSETMAIN")) {
		document.getElementById("imgKnowboxShowDiv").style.top = (top.document.getElementById("FSETMAIN").scrollTop + 100)+"px";
	} else {
		document.getElementById("imgKnowboxShowDiv").style.top = (top.document.body.scrollTop + 100)+"px";
	}
	document.getElementById("imgKnowboxShowDiv").style.display = "inline";
}
function knowBoxBigImgOpen_20091221(url1) {
	url1 = url1.replace("/view/include/BigImageOnlyPopup.jsp?","/view/Detailmulti.jsp?viewBimg=Y&");
	k = window.open(url1,"guideImgPopup","width=100,height=100,top=0,left=0,toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=no,menubar=no,personalbar=no");
	k.focus();
}
// 업로드된 확대이미지를 보여주기 위한 함수
function bigImageShowPopup(imgPath) {
	var url = "http://www.enuri.com/view/enuriupload/Show_OneImageKnowboxPopup.jsp?imgname="+imgPath;
	var imageshowPopup = window.open(url, "imageshow", "width="+window.screen.width+",height="+window.screen.height+",top=0,left=0,toolbar=no,location=no,directories=no,status=no,scrollbars=no,menubar=no,personalbar=no");
	imageshowPopup.focus();
}