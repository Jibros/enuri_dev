// 브라우져 정보 읽어오기
function getBrowserName() {
	if (navigator.userAgent.toLowerCase().indexOf("msie 6") > -1 && navigator.userAgent.toLowerCase().indexOf("msie 7") == -1 && navigator.userAgent.toLowerCase().indexOf("msie 8") == -1) {
		return "msie6";
	}
	
	if (navigator.userAgent.toLowerCase().indexOf("msie 7") > -1 && navigator.userAgent.toLowerCase().indexOf("msie 8") == -1) {
		return "msie7";
	}
	if (navigator.userAgent.toLowerCase().indexOf("msie") != -1) {
		return "msie";
	}
	if (navigator.userAgent.toLowerCase().indexOf("firefox") > -1) {
		return "firefox";
	}
	if (navigator.userAgent.toLowerCase().indexOf("opera") > -1) {
		return "opera";
	}
	if (navigator.userAgent.toLowerCase().indexOf("chrome") > -1) {
		return "chrome";
	}
}
/* 글목록 확장 상태 */
var kblist_wide = 0;
var kblist_nowidx = 1;
/* 확장버튼 top 위치 설정 */
function setKbWideTopPosition() {
	var varTop = getBodyScrollTop();
	if (getBodyScrollTop() == 0)
		varTop = 0;
	varTop += 250;
	return varTop + "px";
}
function setKbWideLeftPosition() {
	var varLeft = 265;
	if (kblist_wide == 1) { // 확장상태
		varLeft = 460;
	}
	varLeft = varLeft - getBodyScrollLeft();
	return varLeft + "px";
}
function cmdAfterLoginKbTop(review) {
	if (typeof (review) == "undefined") {
		review = "";
	}
	
	top.hideNonbanking_site();
	top.cmdMyAreaReload();
	top.showLoginStatus();
	top.hideLoginLayer();
	top.hideLoginAutoAlert();
	
	if (document.getElementById("kbtop_code_add")) {
		if (islogin()) {
			document.getElementById("kbtop_code_add").style.display = "block";
			var sc = document.cookie;
			if (sc.indexOf("AP_YN=2") >= 0) {
				if (document.getElementById("kbtop_phonesale_writebtn")) {
					document.getElementById("kbtop_phonesale_writebtn").style.display = "block";
				}
			}
		} else {
			document.getElementById("kbtop_code_add").style.display = "none";
		}
	}
	
	if (document.getElementById("blogGroupNo")
			&& document.getElementById("blogGroupNo").innerHTML == "3") { // 블로그
																			// 질문답변
		if (islogin()) {
			// document.getElementById("top_group3_myqna").style.display = "";
		}
		loadBlogQnaLogin(0);
	}
	
	if (document.getElementById("ifBodyRead")) {
		if (review == "REVIEW_APP") { // 체험단 신청
			setReviewAppSession();
		}
		document.getElementById("ifBodyRead").contentWindow.location.reload();
	}
}
function setReviewAppSession() {
	var url = "/knowbox/kbReviewAppSetSession.jsp";
	var param = "sessionVal=true";
/*	var getRec = new Ajax.Request(url, {
		method : 'post',
		parameters : param
	});*/
	commonAjaxRequest(url,param,'');
}
function hideAllLayer() {
	if (document.getElementById("kb_codelist")) {
		document.getElementById("kb_codelist").style.display = "none";
	}
	if (document.getElementById("select_paging_group")) {
		document.getElementById("select_paging_group").style.display = "none";
	}
	if (document.getElementById("sort_mode")) {
		hideSortmode();
	}
	cmdHideMyMenu();
}

var iKbListTop 			= 0; // my메뉴 없을때 목록top위치
var iKbListAddCodeTop 	= 0; // my메뉴 있을때 목록top위치
var iKbListTop_now 		= 0;

function cmdListWide() {
	if (kblist_wide == 0) { // 축소상태 -> 확장시키기
		insertLog(5732);
		kblist_wide = 1;
		
		if (iKbListTop >= iKbListAddCodeTop) {
			var obj_height = cumulativeOffset(document.getElementById("kbtop_code_add"))[1];
			iKbListAddCodeTop = iKbListTop + obj_height;
		}
		
		document.getElementById("kb_list_top_blank").style.height = cumulativeOffset(document.getElementById("kb_list_top2"))[1] + "px";
		document.getElementById("kb_list_top_blank").style.display = "block";
		document.getElementById("kb_list_top3").className = "td_kblist_top3_b";
		document.getElementById("kb_list_widegb_blank").style.display = "block";
		document.getElementById("kb_list_top2").className = "td_kblist_top2_b";
		
		if ((BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6) || (BrowserDetect.OS == "iPad" && BrowserDetect.browser == "Safari")) {
			if (document.getElementById("kb_list_box").style.position != "absolute") {
				document.getElementById("kb_list_box").style.position = "absolute";
				document.getElementById("kb_list_box").style.top = iKbListTop_now + "px";
			}
		} else {
			if (document.getElementById("kb_list_box").style.position == "fixed") { // 떠있는상태

			} else { // 일반상태
				document.getElementById("kb_list_box").style.top = "";
				document.getElementById("kb_list_box").style.bottom = "";
				document.getElementById("kb_list_box").style.position = "absolute";
			}
		}
		
		if (BrowserDetect.browser == "Explorer" && (BrowserDetect.version == 6 || BrowserDetect.version == 7)) {
			setKbListWidth();
		}
		
		if (document.getElementById("btn_kb_wide")) {
			document.getElementById("btn_kb_wide").src = document.getElementById("btn_kb_wide").src.replace("btn_listopen.png", "btn_listhide.png");
			setBtnKbWideLeftPosition();
		}
		
		for (i = 1; i < 50; i++) {
			if (document.getElementById("kb_article_title_" + i)) {
				if (document.getElementById("kb_article_title_" + i).className == "kb_article_title_guide") { // 상품사진없음
					if ((BrowserDetect.browser == "Explorer" && (BrowserDetect.version == 6 || BrowserDetect.version == 7)) || (BrowserDetect.OS == "iPad" && BrowserDetect.browser == "Safari")) {
						document.getElementById("kb_article_title_" + i).style.width = "454px";
						document.getElementById("kb_article_info_"  + i).style.width = "454px";
					} else {
						document.getElementById("kb_article_title_" + i).style.width = "446px";
						document.getElementById("kb_article_info_"  + i).style.width = "446px";
					}
				} else {
					if ((BrowserDetect.browser == "Explorer" && (BrowserDetect.version == 6 || BrowserDetect.version == 7)) || (BrowserDetect.OS == "iPad" && BrowserDetect.browser == "Safari")) {
						document.getElementById("kb_article_" + i).style.width = "459px";
					}
					document.getElementById("kb_article_title_" + i).style.width = "395px";
					document.getElementById("kb_article_info_" + i).style.width = "395px";
				}
				if (document.getElementById("kb_article_title_simple_" + i)
						&& document
								.getElementById("kb_article_title_wide_" + i)) {
					document.getElementById("kb_article_title_simple_" + i).style.display = "none";
					document.getElementById("kb_article_title_wide_" + i).style.display = "";
				}
				if (document.getElementById("kb_article_kkname_" + i))
					document.getElementById("kb_article_kkname_" + i).style.display = "block";
				if (document.getElementById("kb_article_writer_" + i))
					document.getElementById("kb_article_writer_" + i).style.display = "block";
			} else {
				break;
			}
		}
		
		hideAllLayer();
		
		if (document.getElementById("kb_list_my_blank")) {
			document.getElementById("kb_list_my_blank").style.width = "460px";
		}
		
		if (document.getElementById("phonesale_listtopline")) {
			document.getElementById("phonesale_listtopline").style.width = "456px";
		}
		
		if (document.getElementById("search_now")) {
			document.getElementById("search_now").style.width = "460px";
		}
		/*
		 * if(document.getElementById("search_now_txt")){
		 * document.getElementById("search_now_txt").style.width = "390px"; }
		 */
		if (document.getElementById("search_bottom")) {
			document.getElementById("search_bottom").style.width = "460px";
		}
		
		if (document.getElementById("tbl_paging")) {
			document.getElementById("tbl_paging").style.width = "460px";
		}
		
		if (document.getElementById("paging_box")) {
			document.getElementById("paging_box").style.width = (parseInt(
					document.getElementById("paging_box").style.width, 10) + 220)
					+ "px";
		}
		
		if (document.getElementById("paging_add")
				&& document.getElementById("paging_2")) {
			var paging_add = document.getElementById("paging_2").innerHTML;
			document.getElementById("paging_add").innerHTML = paging_add;
			document.getElementById("paging_add").style.width = "66px";
			document.getElementById("paging_2").innerHTML = "";
		}
		
		if (document.getElementById("paging_group_add") && document.getElementById("paging_group_2")) {
			var paging_group_add = document.getElementById("paging_group_2").innerHTML;
			document.getElementById("paging_group_add").innerHTML = paging_group_add;
			document.getElementById("paging_group_2").innerHTML = "";
		}
		
		if (document.getElementById("kb_add")) {
			document.getElementById("kb_add").style.width = "450px";
		}
		
		if (document.getElementById("sponsor_link")) {
			document.getElementById("sponsor_link").style.width = "450px";
		}
		
		document.getElementById("kb_list_box_blank").style.height = cumulativeOffset(document.getElementById("kb_list_box"))[1] + "px";
	} else { // 확장상태 -> 축소시키기
		insertLog(5733);
		
		kblist_wide = 0;
		
		document.getElementById("kb_list_top2").className 				= "td_kblist_top2_s";
		document.getElementById("kb_list_top3").className 				= "td_kblist_top3_s";
		document.getElementById("kb_list_top_blank").style.display 		= "none";
		document.getElementById("kb_list_widegb_blank").style.display 	= "none";
		
		if ((BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6) || (BrowserDetect.OS == "iPad" && BrowserDetect.browser == "Safari")) {
			if (document.getElementById("ph_list").offsetHeight >= (document.getElementById("ph_con1").offsetHeight + document.getElementById("ph_con2").offsetHeight)) { // 목록이 글내용보다 길때
				document.getElementById("kb_list_box").style.position = "static";
			} else {
				// 떠있는상태
				if (cumulativeOffset(document.getElementById("kb_list_box"))[1] > cumulativeOffset(document.getElementById("kb_list_box_blank"))[1]) {
				} else {
					document.getElementById("kb_list_box").style.position = "static";
				}
			}
		} else {
			if (document.getElementById("kb_list_box").style.position == "fixed") { // 떠있는상태

			} else { // 일반상태
				document.getElementById("kb_list_box").style.position = "static";
				document.getElementById("kb_list_box").style.bottom = "";
			}
		}
		
		if (BrowserDetect.browser == "Explorer"
				&& (BrowserDetect.version == 6 || BrowserDetect.version == 7)) {
			setKbListWidth();
		}
		
		if (document.getElementById("btn_kb_wide")) {
			document.getElementById("btn_kb_wide").src = document.getElementById("btn_kb_wide").src.replace("btn_listhide.png", "btn_listopen.png");
			
			setBtnKbWideLeftPosition();
		}
		
		for (i = 1; i < 50; i++) {
			if (document.getElementById("kb_article_title_" + i)) {
				if (document.getElementById("kb_article_title_" + i).className == "kb_article_title_guide") {
					document.getElementById("kb_article_title_" + i).style.width = "226px";
					document.getElementById("kb_article_info_" + i).style.width = "226px";
				} else {
					if ((BrowserDetect.browser == "Explorer" && (BrowserDetect.version == 6 || BrowserDetect.version == 7)) || (BrowserDetect.OS == "iPad" && BrowserDetect.browser == "Safari")) {
						document.getElementById("kb_article_" + i).style.width = "239px";
					}
					
					document.getElementById("kb_article_title_" + i).style.width = "175px";
					document.getElementById("kb_article_info_" + i).style.width = "175px";
				}
				if (document.getElementById("kb_article_title_simple_" + i) && document.getElementById("kb_article_title_wide_" + i)) {
					document.getElementById("kb_article_title_simple_" + i).style.display = "";
					document.getElementById("kb_article_title_wide_" + i).style.display = "none";
				}
				if (document.getElementById("kb_article_kkname_" + i))
					document.getElementById("kb_article_kkname_" + i).style.display = "none";
				if (document.getElementById("kb_article_writer_" + i))
					document.getElementById("kb_article_writer_" + i).style.display = "none";
			} else {
				break;
			}
		}
		hideAllLayer();
		if (document.getElementById("kb_list_my_blank")) {
			document.getElementById("kb_list_my_blank").style.width = "240px";
		}
		if (document.getElementById("phonesale_listtopline")) {
			document.getElementById("phonesale_listtopline").style.width = "236px";
		}
		if (document.getElementById("search_now")) {
			document.getElementById("search_now").style.width = "240px";
		}
		/*
		 * if(document.getElementById("search_now_txt")){
		 * document.getElementById("search_now_txt").style.width = "170px"; }
		 */
		if (document.getElementById("search_bottom")) {
			document.getElementById("search_bottom").style.width = "240px";
		}
		
		if (document.getElementById("tbl_paging")) {
			document.getElementById("tbl_paging").style.width = "240px";
		}
		
		if (document.getElementById("paging_box")) {
			document.getElementById("paging_box").style.width = (parseInt(
					document.getElementById("paging_box").style.width, 10) - 220)
					+ "px";
		}
		
		if (document.getElementById("paging_add")&& document.getElementById("paging_2")) {
			var paging_add = document.getElementById("paging_add").innerHTML;
			document.getElementById("paging_2").innerHTML 		= paging_add;
			document.getElementById("paging_add").innerHTML 	= "";
			document.getElementById("paging_add").style.width 	= "0";
		}
		
		if (document.getElementById("paging_group_add") && document.getElementById("paging_group_2")) {
			var paging_group_add = document.getElementById("paging_group_add").innerHTML;
			document.getElementById("paging_group_2").innerHTML = paging_group_add;
			document.getElementById("paging_group_add").innerHTML = "";
		}
		
		if (document.getElementById("kb_add")) {
			document.getElementById("kb_add").style.width = "226px";
		}
		
		if (document.getElementById("sponsor_link")) {
			document.getElementById("sponsor_link").style.width = "226px";
		}
		
		document.getElementById("kb_list_box_blank").style.height = "0";
	}
}
function cmdKbCateAll() { // 최근글 전체
	insertLog(5978);
	insertLog(9673);	
	location.href = "List.jsp";
}
function cmdKbCatelist(kbcate) {
	insertLog(5978);
	
	if (kbcate == "kb0") {// 휴대폰
		insertLog(5698);
	} else if (kbcate == "kb1") { // 영상,음향
		/* insertLog(5699); */
		insertLog(9666);
	} else if (kbcate == "kb2") {// 노트북
		insertLog(5700);
	} else if (kbcate == "kb3") {
		insertLog(5701);
	} else if (kbcate == "kb4") {// 컴퓨터
		insertLog(5702);
	} else if (kbcate == "kb5") {// 가전 
		insertLog(5704);
	} else if (kbcate == "kb6") {
		//insertLog(5704);
	} else if (kbcate == "kb7") {// 자동차,레저
		insertLog(5705);
	} else if (kbcate == "kb8") {// 유아,리빙
		insertLog(5706);
		/*insertLog(9672);*/
	} else if (kbcate == "kb9") {// 패션,뷰티
		insertLog(5707);
	} else if (kbcate == "kb10") {// 스마트패드
		/*insertLog(5708);*/
		insertLog(9665);
	} else if (kbcate == "") {
		/* insertLog(5980); */
		insertLog(9673);
	}
	
	var obj = document.getElementById("frmKbList");
	
	obj.kbcate.value = kbcate;
	
	if (kbcate != "kb0" && obj.kbcode.value == "kc7")
		obj.kbcode.value = "";
	
	if (obj.kbcode.value == "kc8" || obj.kbcode.value == "kc12") 
		obj.kbcode.value = "";
	
	if(isGuide)
		obj.kbcode.value = "";
	
	obj.isGuide.value = false;
	
	obj.kbno.value 		 = 0;
	obj.kb_keyword.value = "";
	obj.page.value 		 = 0;
	obj.action 			 = "List.jsp";
	obj.submit();
}
// qna 분류 리스트 search
var tempKbcate = "";

function qnacatelistcnt(kbcate) {
	tempKbcate = kbcate;
	
	var searchWord = document.getElementById("kb_keyword_t").value.trim();
	var url = "/knowbox/IncKbList_Drawlist_Count_Proc.jsp";
	// var param =
	// "smart_tap_menu=3&qnacatelist=Y&kbcate="+kbcate+"&searchword="+searchWord;
	var param = "smart_tap_menu=3&qnacatelist=Y&kbcate=" + kbcate;
	
/*	var getRec = new Ajax.Request(url, {
		method : 'get',
		parameters : param,
		onComplete : chkQnaCateListCntCallback
	});*/
	
	commonAjaxRequest(url,param,chkQnaCateListCntCallback);
}
function chkQnaCateListCntCallback(originalRequest) {
	eval("varReturn = " + (libType() == "PR" ? originalRequest.responseText : originalRequest));
	
	var cnt = eval("varReturn.count");
	
	if (cnt == 0) {
		alert("검색 결과가 없습니다.");
	} else {
		/*
		 * if(sKbcate != ""){ $("kbtop_cate_"+sKbcate).className = "kbtop_cate"; }
		 */
		sKbcate = tempKbcate;
		/* $("kbtop_cate_"+sKbcate).className = "kbtop_cate_sel"; */
		var obj = document.getElementById("frmKbList");
		var sort = obj.kbsort.value;
		document.getElementById("kb_keyword_t").value = "";
		incQNAList_Paging(varStrSmartTapMenu, tempPageNo, sort, "", sKbcate);
	}
	
	tempPageNo = 0;
}

function chkKbCheckSearchCntCallback(originalRequest) {
	eval("varReturn = " + (libType() == "PR" ? originalRequest.responseText : originalRequest));
	
	var cnt = eval("varReturn.count");
	
	if (cnt == 0) {
		varStrSmartTapMenu = tempPageNo;
		alert("검색 결과가 없습니다.");
	} else {
		var obj = document.getElementById("frmKbList");
		var sort = obj.kbsort.value;
		var searchWord = document.getElementById("kb_keyword_t").value.trim();
		incKbList_Paging(varStrSmartTapMenu, tempPageNo, sort, searchWord);
	}
	
	tempPageNo = 0;
}
function cmdKbCodelist(kbcode) {
	var obj = document.getElementById("frmKbList");
	
	insertLog(5979);
	
	if (kbcode == "kc0") {
		insertLog(5691);
	} else if (kbcode == "kc1") {
		insertLog(5693);
	} else if (kbcode == "kc2") {
		insertLog(5694);
	} else if (kbcode == "kc3") {
		insertLog(5695);
	} else if (kbcode == "kc4") {
		insertLog(5690);
	} else if (kbcode == "kc5") {
		insertLog(5689);
	} else if (kbcode == "kc6") {
		insertLog(5692);
	} else if (kbcode == "kc7") {
		insertLog(7350);
	} else if (kbcode == "kc8") {
		insertLog(8015);
		obj.kbcate.value = "";
		obj.smart_tap_menu.value = 1;
	} else if (kbcode == "kc9") {
		obj.kbcate.value = "kbALL";
		insertLog(9672);
		// obj.smart_tap_menu.value = 3;
	} else if (kbcode == "kc12") {
		
	} else if (kbcode == "") {
		insertLog(5688);
	}

	obj.isGuide.value		= false;
	obj.kbcode.value 		= kbcode;
	obj.kbno.value 			= 0;
	obj.modelno.value 		= 0;
	obj.kb_keyword.value 	= "";
	obj.page.value 			= 0;
	obj.action 				= "List.jsp";
	
	obj.submit();
}

function cmdListSetPhoneOut(kbno, pout, nick) {
	for (i = 1; i < 50; i++) {
		if (document.getElementById("kb_article_" + i)) {
			if (document.getElementById("kb_article_" + i).getAttribute("kbno") == kbno) {
				if (pout == 1) {
					document.getElementById("kb_article_title_simple_" + i).style.color = "#b4b4b4";
					document.getElementById("kb_article_title_wide_"   + i).style.color = "#b4b4b4";
				} else {
					document.getElementById("kb_article_title_simple_" + i).style.color = "#5f5f5f";
					document.getElementById("kb_article_title_wide_"   + i).style.color = "#5f5f5f";
				}
				
				document.getElementById("kb_article_title_simple_nick_" + i).innerHTML = nick;
				document.getElementById("kb_article_title_wide_nick_"   + i).innerHTML = nick;
				
				break;
			}
		}
	}
}

function cmdOpenBlog() {
	insertLog(6271);
	
	var w = window.screen.width;
	
	if (w >= 1024) {
		w = 1012;
		if (getBrowserName() == "msie6") {
			w = 1024;
		}
	}
	
	var h = screen.availHeight;
	var win = window.open("/blog/","enuri_blog","width="+ w + " height=" + h + " top=0 left=0 toolbar=yes,location=yes,directories=yes,status=yes,scrollbars=yes,resizable=yes,menubar=yes,personalbar=yes");
	
	win.focus();
}
function cmdViewKbcodeBox() {
	if (document.getElementById("kb_codelist")) {
		if (document.getElementById("kb_codelist").style.display == "block") {
			document.getElementById("kb_codelist").style.display = "none";
		} else {
			document.getElementById("kb_codelist").style.display = "block";
		}
	}
}
function cmdMyKb(menuno) {
	function cmdMyKbCallBack(originalRequest) {
		if ((libType() == "PR" ? originalRequest.responseText : originalRequest) == '-1')
			alert('로그인이 필요합니다.');
		else {
			if(parseInt(libType() == "PR" ? originalRequest.responseText : originalRequest) > 0)
				location.href = "MyList.jsp?menuno=" + menuno + "&smart_tap_menu=1&isKc9=fase";
			else
				alert('표시할 글 목록이 없습니다');
		}
	}

	var url = "/knowbox/MyListChk.jsp";
	var param = "?menuno=" + menuno + "&smart_tap_menu=1&isKc9=fase";

/*	var getRec = new Ajax.Request(url, {
		method : 'get',
		parameters : param,
		onComplete : cmdMyKbCallBack
	});*/
	
	commonAjaxRequest(url,param,cmdMyKbCallBack);
}

function cmdPhoneWrite() {
	var surl = "/knowbox/List_write.jsp?kbcate=kb0&kbcode=kc7&cate=0304&rcontent=write";
	document.getElementById("ifBodyRead").src = surl;
	
	if (document.getElementById("kb_article_" + kblist_nowidx)) {
		document.getElementById("kb_article_" + kblist_nowidx).className = "kblist_article_normal";
	}
}
function cmdPhoneTab(factory) {
	insertLog(7352);
	document.frmKbListSearch_T.factory.value = factory;
	document.frmKbListSearch_T.submit();
}
function cmdSetMovieIcon(idx, change) { // 제목에 동영상아이콘 있을때 배경변화때문에 이미지 교체해줘야함
	var cstr = "";
	var chtml = "";
	
	if (change == "now") {
		cstr = "bde1ff";
	} else {
		cstr = "f7f7f7";
	}
	
	if (document.getElementById("kb_article_title_" + idx) && document.getElementById("kb_article_title_" + idx).getAttribute("ctype") == "knowbox") {
		chtml = document.getElementById("kb_article_title_" + idx).innerHTML;
		chtml = chtml.replace("f7f7f7", cstr);
		chtml = chtml.replace("f7f7f7", cstr);
		chtml = chtml.replace("bde1ff", cstr);
		chtml = chtml.replace("bde1ff", cstr);
		
		if (document.getElementById("mysave_kmno_" + idx)) { // 저장한글일때
																// 체크상태유지해줌
			if (document.getElementById("mysave_kmno_" + idx).checked == true) {
				chtml = chtml.replace("id=mysave_kmno_" + idx,"id=mysave_kmno_" + idx + " checked", cstr);
			}
		}
		
		document.getElementById("kb_article_title_" + idx).innerHTML = chtml;
	}
}

function cmdRead(idx, kbno, modelno, bloghide) {
	sWriteMcate = strQnACate == '' ? '' : sWriteMcate;
	
	if (typeof (bloghide) == "undefined")
		bloghide = 1;

	if (bloghide == 1 && typeof (document.getElementById("blog_info_top")) != 'undefinded')
		document.getElementById("blog_info_top").style.display = "none";
	else
		document.getElementById("blog_info_top").style.display = "block";

	/*insertLog(5734);*/

	flagRun = 1;

	/*
	 * if(kblist_wide==1){ //확장->축소 cmdListWide(); }
	 */
	var obj 	= document.getElementById("frmKbList");
	var surl 	= "List_read.jsp?kbno=" + kbno;

	if (iKbno == kbno)
		surl += "&from=" + strFrom;
	
	if(strQnACate != "")
		surl += "&QnACate=" + strQnACate;
	
	document.getElementById("ifBodyRead").src = surl;
	
	// 기존글 원래 스타일로 복원
	if (document.getElementById("kb_article_" + kblist_nowidx))
		document.getElementById("kb_article_" + kblist_nowidx).className = "kblist_article_normal";
	
	if (document.getElementById("kb_article_regdate_" + kblist_nowidx))
		document.getElementById("kb_article_regdate_" + kblist_nowidx).className = "kb_article_regdate_normal";
	
	if (document.getElementById("kb_article_readcnt_" + kblist_nowidx))
		document.getElementById("kb_article_readcnt_" + kblist_nowidx).className = "kb_article_readcnt_normal";
	
	cmdSetMovieIcon(kblist_nowidx, "read");

	if(varLinkChk == 0){
		// 선택글목록 스타일 적용
		if (document.getElementById("kb_article_" + idx))
			document.getElementById("kb_article_" + idx).className = "kblist_article_now";
		
		if (document.getElementById("kb_article_regdate_" + idx))
			document.getElementById("kb_article_regdate_" + idx).className = "kb_article_regdate_read";
		
		if (document.getElementById("kb_article_readcnt_" + idx))
			document.getElementById("kb_article_readcnt_" + idx).className = "kb_article_readcnt_read";
	}
	
	cmdSetMovieIcon(idx, "now");
	
	obj.kbcate.value 	= sKbcate;
	obj.kbno.value 		= kbno;
	obj.iscar.value 	= "";
	kblist_nowidx 		= idx;
	
	intReadFrmHeight = -1;
	
	cmdSetScroll(0);
	
	hideAllLayer();
}

function cmdReadModel(idx, modelno) {
	if (document.getElementById("blog_info_top"))
		document.getElementById("blog_info_top").style.display = "none";
	
	insertLog(5734);
	
	flagRun = 1;
	
	if (kblist_wide == 1) { // 확장->축소
		cmdListWide();
	}
	
	var obj = document.getElementById("frmKbList");
	var surl = "List_readBbs.jsp?modelno=" + modelno;
	document.getElementById("ifBodyRead").src = surl;
	
	if (document.getElementById("kb_article_" + kblist_nowidx)) {
		document.getElementById("kb_article_" + kblist_nowidx).className = "kblist_article_normal";
	}
	
	document.getElementById("kb_article_" + idx).className = "kblist_article_now";
	
	if (document.getElementById("kb_article_regdate_" + idx)) {
		document.getElementById("kb_article_regdate_" + idx).className = "kb_article_regdate_read";
	}
	
	if (document.getElementById("kb_article_readcnt_" + idx)) {
		document.getElementById("kb_article_readcnt_" + idx).className = "kb_article_readcnt_read";
	}
	
	obj.modelno.value 	= modelno;
	obj.iscar.value 	= "";
	kblist_nowidx 		= idx;
	intReadFrmHeight 	= -1;
	
	cmdSetScroll(0);
	hideAllLayer();
}
function cmdReadCar(idx, kbno, modelno, bloghide) {
	if (typeof (bloghide) == "undefined") {
		bloghide = 1;
	}
	
	if (bloghide && document.getElementById("blog_info_top"))
		document.getElementById("blog_info_top").style.display = "none";
	
	insertLog(5734);
	
	flagRun = 1;
	
	if (kblist_wide == 1) { // 확장->축소
		cmdListWide();
	}
	
	var obj = document.getElementById("frmKbList");
	var surl = "/car/knowbox/Auto_Knowbox_Read_Main.jsp?knowbox_top=y&kb_no=" + kbno + "&modelno=" + modelno;
	document.getElementById("ifBodyRead").src = surl;
	
	if (document.getElementById("kb_article_" + kblist_nowidx)) {
		document.getElementById("kb_article_" + kblist_nowidx).className = "kblist_article_normal";
	}
	
	cmdSetMovieIcon(kblist_nowidx, "read");
	
	document.getElementById("kb_article_" + idx).className = "kblist_article_now";
	
	if (document.getElementById("kb_article_regdate_" + idx)) {
		document.getElementById("kb_article_regdate_" + idx).className = "kb_article_regdate_read";
	}
	
	if (document.getElementById("kb_article_readcnt_" + idx)) {
		document.getElementById("kb_article_readcnt_" + idx).className = "kb_article_readcnt_read";
	}
	cmdSetMovieIcon(idx, "now");
	
	obj.kbno.value 		= kbno;
	obj.modelno.value 	= modelno;
	obj.iscar.value 	= "auto";
	kblist_nowidx 		= idx;
	intReadFrmHeight 	= -1;
	
	cmdSetScroll(0);
	hideAllLayer();
}
function cmdFindKb(kbno) {
	var obj = document.getElementById("frmKbList");
	
	if (document.getElementById("kb_article_" + kblist_nowidx)) {
		document.getElementById("kb_article_" + kblist_nowidx).className = "kblist_article_normal";
	}
	cmdSetMovieIcon(kblist_nowidx, "read");
	kblist_nowidx = 0;
	for (i = 1; i < 50; i++) {
		if (document.getElementById("kb_article_" + i)) {
			if (document.getElementById("kb_article_" + i).getAttribute("kbno") == kbno) {
				kblist_nowidx = i;
			}
		}
	}
	if (kblist_nowidx == 0) {
		if (sKbcode != "kc8" && iGroup == 3) { // 블로그 질문답변글인 경우 고정 질문답변을 현재글로
												// 표시
			for (i = 1; i < 50; i++) {
				if (document.getElementById("kb_article_" + i)) {
					if (document.getElementById("kb_article_" + i).getAttribute("bgroup") == 3) {
						kblist_nowidx = i;
					}
				}
			}
		}
	}
	if (kblist_nowidx > 0) {
		document.getElementById("kb_article_" + kblist_nowidx).className = "kblist_article_now";
		if (document.getElementById("kb_article_regdate_" + kblist_nowidx)) {
			document.getElementById("kb_article_regdate_" + kblist_nowidx).className = "kb_article_regdate_read";
		}
		if (document.getElementById("kb_article_readcnt_" + kblist_nowidx)) {
			document.getElementById("kb_article_readcnt_" + kblist_nowidx).className = "kb_article_readcnt_read";
		}
		cmdSetMovieIcon(kblist_nowidx, "now");
		obj.kbno.value = kbno;
		obj.iscar.value = "";
	}
}
function loadBlogQnaLogin(readref) {
	function showBlogQnaLogin(originalRequest) {
		if (islogin()) {
			if(document.getElementById("bbs_writer_login_before"))
				document.getElementById("bbs_writer_login_before").style.display = "none";
			if(document.getElementById("bbs_writer_login_after"))
				document.getElementById("bbs_writer_login_after").style.display = "";
			if(document.getElementById("bbs_login_before"))
				document.getElementById("bbs_login_before").innerHTML = "";
			if(document.getElementById("bbs_login_after"))
			document.getElementById("bbs_login_after").innerHTML = libType() == "PR" ? originalRequest.responseText : originalRequest;
			
		    if(document.getElementById('content_m')){
		    	document.getElementById('content_m').onfocus = function(){ document.getElementById('content_m').style.background = 'url()';} 
		    	document.getElementById('content_m').onblur  = function(){ if(document.getElementById('content_m').value.trim().isEmpty()) document.getElementById('content_m').style.background = 'url(http://img.enuri.gscdn.com/images/blog/txt_info_1.gif) no-repeat 6px 7px';}
		    	document.getElementById('content_m').readonly = false;
		    	
		    	if(document.getElementById('content_m').innerText == "")
		    		document.getElementById('content_m').style.background = 'url(http://img.enuri.gscdn.com/images/blog/txt_info_1.gif) no-repeat 6px 7px';
		    }
		    
			if (iGroup == 3) {
				/*document.getElementById("top_group3_myqna").style.display = "";*/
			}
		} else {
			if(document.getElementById("bbs_writer_login_before"))
				document.getElementById("bbs_writer_login_before").style.display = "";
			if(document.getElementById("bbs_writer_login_after"))
				document.getElementById("bbs_writer_login_after").style.display = "none";
			if(document.getElementById("bbs_login_before"))
				document.getElementById("bbs_login_before").innerHTML = libType() == "PR" ? originalRequest.responseText : originalRequest;
			if(document.getElementById("bbs_login_after"))
				document.getElementById("bbs_login_after").innerHTML = "";
			
		    if(document.getElementById('content_m')){
		    	document.getElementById('content_m').innerText = '';
		    	document.getElementById('content_m').style.background = 'url(http://img.enuri.gscdn.com/images/blog/txt_info_1.gif) no-repeat 6px 7px';
		    	document.getElementById('content_m').onblur  = function(){document.getElementById('content_m').txt = '';}
		    	document.getElementById('content_m').onclick  = function(){alert('로그인을 하시면 글을 작성할 수 있습니다');document.getElementById('loginid').focus();}
		    	document.getElementById('content_m').readonly = true;
		    }
		    
			if (iGroup == 3) {
				if(document.getElementById("top_group3_myqna"))
					document.getElementById("top_group3_myqna").style.display = "none";
			}
		}
		
		if (document.getElementById("user_write_email") && document.getElementById("interest_email")) {
			document.getElementById("interest_email").value = document.getElementById("user_write_email").innerHTML;
		}
		
		if (document.getElementById("interest_email")) {
			OutLoginMail(document.getElementById("interest_email"));
		}
		
		if (readref && document.getElementById("ifBodyRead")) {
			document.getElementById("ifBodyRead").contentWindow.location.reload();
		}
	}
	var url = "/login/Ajax_Bbs_LoginLine2.jsp";
	var param = "";

	if (document.getElementById("frmWKnowBox") && document.getElementById("frmWKnowBox").qnatype.value == "m" && document.getElementById("frmWKnowBox").kbno.value != "") {
		param = "bbstype=m"
	}
	
/*	var getRec = new Ajax.Request(url, {
		method : 'get',
		parameters : param,
		onComplete : showBlogQnaLogin
	});*/
	
	commonAjaxRequest(url,param,showBlogQnaLogin);
}

var tempQnatype = "";
function showGroupList(originalRequest) {
	var orgHTML = (libType() == "PR" ? originalRequest.responseText : originalRequest).trim();

	var blogGroupRunKey = eval(orgHTML.substring(orgHTML.indexOf("blogGroupRunKey") + 17, orgHTML.indexOf("</div>", orgHTML.indexOf("blogGroupRunKey")  + 17)));
	var blogGroup 		= eval(orgHTML.substring(orgHTML.indexOf("blogGroupNo") 	+ 13, orgHTML.indexOf("</div>", orgHTML.indexOf("blogGroupNo") 		+ 13)));
	var blogGroupKbno	= eval(orgHTML.substring(orgHTML.indexOf("blogGroupKbno") 	+ 15, orgHTML.indexOf("</div>", orgHTML.indexOf("blogGroupKbno") 	+ 15)));

	document.getElementById("ifBodyRead").style.display = "block";

	if (blogGroupRunKey == iRunKey) {
		// alert(orgHTML);
		document.getElementById("blog_info_top").innerHTML = orgHTML;

		if (blogGroup == 3 || blogGroup == 0) { // 질문답변
			if (islogin()) {
				// document.getElementById("top_group3_myqna").style.display = "";
			}

			document.getElementById("blog_top_layer").style.display = "none";
			loadBlogQnaLogin(0);
		}
		
		if (document.getElementById("interest_email")) {
			OutLoginMail(document.getElementById("interest_email"));
		}
		
		document.getElementById("blog_info_top").style.display = "block";
		
		if (iKbno == 0 && blogGroupKbno > 0) {
			var obj = document.getElementById("frmKbList");
			var surl = "List_read.jsp?kbno=" + blogGroupKbno;
			document.getElementById("ifBodyRead").src = surl;
			iKbno = blogGroupKbno;
			obj.kbno.value = blogGroupKbno;
			obj.iscar.value = "";
			cmdFindKb(iKbno);
		}
	}

	if (varLinkChk == 1 || varLinkChk == 2) {
		cmdQna(3, 0);
		varLinkChk = 0;
	}

	if (tempQnatype == "m") {
		document.getElementById("ifBodyRead").style.display = "none";
	}
	
	// if(varIsKc9 == "true"){
	// document.getElementById("knsmart_Qna").style.display = "block";
	// cmdQna(3,0);
	// varIsKc9 = "false";
	// }
}

function loadGroupList(nowPage, qnatype) {
	if (typeof (qnatype) == "undefined") {
		qnatype = "";
	}
	
	tempQnatype = qnatype;
	var url = "/blog/IncBlogKbTop.jsp";
	var param = "runkey=" + iRunKey + "&group=" + iGroup + "&bmno=" + iBmno + "&kbno=" + iKbno + "&qnatype=" + qnatype + "&page=" + nowPage + "&writecate=" + sKbcate2 + "&writeMcate=" + sWriteMcate + "&cate=" + strQnACate + "&linkChk=" + varLinkChk;
	
/*	var getRec = new Ajax.Request(url, {
		method : 'get',
		parameters : param,
		onComplete : showGroupList
	});*/
	commonAjaxRequest(url,param,showGroupList);
}
function cmdBlogGroup(group, kbno) {
	if (typeof (group) == "undefined") {
		group = iGroup;
	}
	if (typeof (kbno) == "undefined") {
		kbno = 0;
	}
	
	iRunKey++;
	iGroup = group;
	iBmno = 0;
	iKbno = kbno;
	loadGroupList(0);
}
function cmdBmList(bmno) {
	try {
		if (iBmno == bmno) {
			return;
		}
		iBmno = bmno;
		iKbno = 0;
		iRunKey++;
		loadGroupList(0);
	} catch (e) {
	}
}
function cmdBlogRead(group, idx) {
	insertLog(5734);
	flagRun = 1;
	if (kblist_wide == 1) { // 확장->축소
		cmdListWide();
	}
	iGroup = group;
	iBmno = 0;
	iKbno = 0;
	loadGroupList(0);
	if (document.getElementById("kb_article_" + kblist_nowidx)) {
		document.getElementById("kb_article_" + kblist_nowidx).className = "kblist_article_normal";
	}
	cmdSetMovieIcon(kblist_nowidx, "read");
	document.getElementById("kb_article_" + idx).className = "kblist_article_now";
	if (document.getElementById("kb_article_regdate_" + idx)) {
		document.getElementById("kb_article_regdate_" + idx).className = "kb_article_regdate_read";
	}
	if (document.getElementById("kb_article_readcnt_" + idx)) {
		document.getElementById("kb_article_readcnt_" + idx).className = "kb_article_readcnt_read";
	}
	cmdSetMovieIcon(idx, "now");
	kblist_nowidx = idx;
	intReadFrmHeight = -1;
	cmdSetScroll(0);
	hideAllLayer();
}
function cmdImgOver(oid) {
	var obj = document.getElementById(oid);
	if (obj) {
		obj.src = obj.src.replace(".gif", "_ov.gif");
	}
}
function cmdImgOut(oid) {
	var obj = document.getElementById(oid);
	if (obj) {
		obj.src = obj.src.replace("_ov.gif", ".gif");
	}
}
function groupPrevPage() {
	var nowPage = eval(document.getElementById("group_page").innerHTML);
	var pageCount = eval(document.getElementById("group_pagecount").innerHTML);
	if (nowPage == "" || nowPage <= 1) {
		nowPage = pageCount;
	} else {
		nowPage--;
	}
	iRunKey++;
	loadGroupList(nowPage);
}
function groupNextPage() {
	var nowPage = eval(document.getElementById("group_page").innerHTML);
	var pageCount = eval(document.getElementById("group_pagecount").innerHTML);
	if (nowPage >= pageCount) {
		nowPage = 1;
	} else {
		nowPage++;
	}
	iRunKey++;
	loadGroupList(nowPage);
}
function cmdBlogTopKbread(kbno, idx) {
	for (i = 0; i < 6; i++) {
		if (document.getElementById("top_list_tr_" + i)) {
			if (i == idx) {
				document.getElementById("top_list_tr_" + i).className = "top_list_readsel";
				document.getElementById("top_list_td_" + i).className = "top_list_title_sel";
			} else {
				document.getElementById("top_list_tr_" + i).className = "";
				document.getElementById("top_list_td_" + i).className = "top_list_title_normal";
			}
		} else {
			break;
		}
	}
	iKbno = kbno;
	cmdFindKb(iKbno);
	var obj = document.getElementById("frmKbList");
	var surl = "List_read.jsp?kbno=" + iKbno;
	document.getElementById("ifBodyRead").src = surl;
	obj.kbno.value = iKbno;
	obj.iscar.value = "";
}
function cmdListMyQna(kbno) {
	iKbno = kbno;
	var obj = document.getElementById("frmKbList");
	var surl = "List_read.jsp?kbno=" + iKbno + "&myqna=1&findmyqna=0";
	document.getElementById("ifBodyRead").src = surl;
	obj.kbno.value = iKbno;
	obj.iscar.value = "";
}
function cmdModifyBlogQna(kbno) { // qna수정하기 폼 호출
	iRunKey++;
	iGroup = 3;
	iBmno = 0;
	iKbno = kbno;
	var obj = document.getElementById("frmKbList");
	obj.kbno.value = iKbno;
	obj.iscar.value = "";
	loadGroupList(1, 'm');
}
function cmdDelBlogFile() {
	var obj = document.getElementById("frmWKnowBox");
	// if(confirm("첨부된 파일을 삭제하시겠습니까?")){
	obj.delfile.value = "1";
	document.getElementById("bbs_file_modify").style.display = "none";
	document.getElementById("bbs_file_input").style.display = "block";
	// }
}
function cmdBlogKbread(group, kbno, myqna,lCate,mCate) { // Blog_list.jsp에서 호출
	if (typeof (myqna) == "undefined") {
		myqna = "";
	}
	
	iKbno = kbno;
	
	lCate = lCate == null ? "" : lCate;
	mCate = mCate == null ? "" : mCate;

	if(lCate != null || lCate != '')
		cmdBlogGroup(3,kbno);
	
	var obj = document.getElementById("frmKbList");
	var surl = "List_read.jsp?kbno=" + iKbno + "&myqna=" + myqna + "&kbLcate=" + lCate + "&kbMcate=" + mCate;
	
	document.getElementById("ifBodyRead").src = surl;
	
	obj.kbno.value = iKbno;
	obj.iscar.value = "";
	
	cmdFindKb(kbno);
	
	intReadFrmHeight = -1;
	
	cmdSetScroll(0);
	hideAllLayer();
}
var isKbWriteProgress = 0;
function cmdBlogQnaWriteSubmit() {
	if (isKbWriteProgress == 1) {
		alert("등록중입니다. 잠시만 기다려주세요.");
		return false;
	}
	var obj = document.getElementById("frmWKnowBox");
	var loginId = document.getElementById("loginid");
	var loginpwd = document.getElementById("pass");

/*	if (typeof (loginId) != 'undefined' && typeof (loginpwd) != 'undefined'
			&& typeof (obj.loginid) != 'undefined') {
		if (typeof (loginId) != 'undefined' && loginId != null
				&& typeof (loginpwd) != 'undefined' && loginId != null) {

			if (loginId.value.trim().length == 0)
				loginId.value = obj.loginid.value;

			if (loginId.value == "" && loginpwd.value == "") {
				showInfo(6);
				return;
			}

			if (loginId.value == "" && loginpwd.value != "") {
				showInfo(2);
				return;
			}

			if (loginId.value != "" && loginpwd.value == "") {
				showInfo(3);
				return;
			}

		}
	}*/

/*	if (obj.writeCate && obj.writeCate.selectedIndex == 0) {
		alert("글분류를 선택하세요");
		return false;
	}*/

	if (obj.lCateCode.value.isEmpty() || obj.lCateCode.value == 'kbALL'){
		alert('1차분류를 선택해주세요');
		return false;
	}
	
	if (obj.mCateCode.value.isEmpty() && obj.lCateCode.value != 'kb11'){
		alert('2차분류를 선택해주세요 ');
		return false;
	}
	
	if (obj.title_m.value.trim() == "") {
		alert("제목을 입력하세요");
		obj.title_m.select();
		return false;
	}
	if (!obj.content_m || obj.content_m.value.trim() == "") {
		alert("글 내용을 입력하세요");
		obj.content_m.focus();
		return false;
	}
	if (obj.interest_email && obj.interest_email.value != "") {
		if (!mailCheck(obj.interest_email)) {
			return;
		}
	}
	
	obj.title_m.value   = obj.title_m.value.trim().replaceAll("<", "&lt").replaceAll(">", "&gt");
	obj.content_m.value = obj.content_m.value.trim().replaceAll("<", "&lt").replaceAll(">", "&gt");
/*	if (typeof (loginId) != 'undefined' && typeof (loginpwd) != 'undefined'
			&& typeof (obj.loginid) != 'undefined') {
		if (typeof (loginId) != 'undefined' && loginId != null
				&& typeof (loginpwd) != 'undefined' && loginId != null) {
			if (chkNickByte(loginId.value)) { // 한글 1-8자, 영문 2-16자까지만 사용가능
				showInfo(2);
				return;
			}

			if (!chkPassChar2(loginpwd.value)) {
				showInfo(3);
				return;
			}
		}
	}*/

	isKbWriteProgress = 1;

/*	if ((typeof (loginId) != 'undefined' && typeof (loginpwd) != 'undefined')
			&& (loginId != null && loginpwd != null)) {
		obj.loginId.value = loginId.value;
		obj.loginPwd.value = loginpwd.value;
		obj.target = "ifKbWrite";
	} else {
		insertLog(982);
		insertLog(5893);
		obj.encoding = "multipart/form-data";
		obj.target = "ifKbWrite";
		obj.action = "/knowbox/List_writeUpload_proc.jsp";
	}
	*/
/*	if ((typeof (loginId) != 'undefined' && typeof (loginpwd) != 'undefined')
			&& (loginId != null && loginpwd != null)) {
		obj.loginId.value = loginId.value;
		obj.loginPwd.value = loginpwd.value;
		obj.target = "ifKbWrite";
	} else {*/
		insertLog(982);
		insertLog(5893);
		obj.encoding = "multipart/form-data";
		obj.target = "ifKbWrite";
		obj.action = "/knowbox/List_writeUpload_proc.jsp";
	/*}	*/
	obj.submit();

}
/*function afterNickCheck(param) {
	if (param == 0) {
		insertLog(982);
		insertLog(5893);
		var obj = document.getElementById("frmWKnowBox");
		obj.encoding = "multipart/form-data";
		obj.target = "ifKbWrite";
		obj.action = "/knowbox/List_writeUpload_proc.jsp";
		obj.submit();
	} else {
		closeAllInfo();
		showInfo(5);
	}
	isKbWriteProgress = 0;
}*/
function afterNickCheck(nick){
    parent.CmdJoin(5);
}

function cmdAfterKbWrite(kbno, wCate,lcate,mcate) {
	cmdSetScroll(0);

	if (wCate != null && wCate != '') {
		var loc = top.location.href;

		top.location.replace(loc.replace(loc.substring(loc.indexOf('kbcate=') + 'kbcate='.length, loc.indexOf('kbcate=') + 'kbcate='.length + (loc.substring(loc.indexOf('kbcate=') + 'kbcate='.length, loc.length).indexOf("&"))), wCate));
	} else if(kbno != null && lcate != null){
		top.location.replace('List.jsp?kbcate=' + lcate + '&kbno=' + kbno + '&kbcode=kc9');
	}else
		top.location.reload();
}

var chmail_log = false;
function cmdMylistCheck(obj) { // 저장한글 체크박스 클릭
	insertLog(5760);
	var frm = document.getElementById("frmMyListCheck");
	var chcount = 0;
	var bxcount = 0;
	var chlist = "";
	for (i = 0; i < frm.elements.length; i++) {
		var el = frm.elements[i];
		if (el.getAttribute("NAME") == "mysave_kmno") {
			bxcount++;
		}
	}
	if (bxcount == 1) {
		if (obj.checked) {
			chcount = 1;
			chlist = obj.value;
		}
	} else if (bxcount > 1) {
		var fcount = frm.mysave_kmno.length;
		for (i = 0; i < fcount; i++) {
			if (frm.mysave_kmno[i].checked) {
				chcount++;
				if (chlist == "") {
					chlist = frm.mysave_kmno[i].value;
				} else {
					chlist = chlist + "," + frm.mysave_kmno[i].value;
				}
			}
		}
	}
	frm.chklist.value = chlist;
	if (document.getElementById("mylist_checkbtn")) {
		if (chcount == 0) {
			document.getElementById("mylist_checkbtn").style.display = "none";
		} else {
			var left = cumulativeOffset(obj)[0];
			var top = cumulativeOffset(obj)[1] + 15;
			if (document.getElementById("kb_list_box").style.position == "absolute"
					|| document.getElementById("kb_list_box").style.position == "fixed") {
				var top_e = cumulativeOffset(document.getElementById("kb_list_box"))[1];
				top = top - top_e;
			}
			document.getElementById("mylist_checkbtn").style.display = "block";
			document.getElementById("mylist_checkbtn").style.left = left + "px";
			document.getElementById("mylist_checkbtn").style.top = top + "px";
		}
	}
}
function cmdMylistDel() { // 저장한글 삭제
	insertLog(5761);
	if (confirm("선택한 글을 저장목록에서 삭제하시겠습니까?")) {
		var frm = document.getElementById("frmMyListCheck");
		frm.mode.value = "save_del";
		frm.action = "/knowbox/MyList_proc.jsp";
		frm.submit();
	}
}
function over_view_mode(obj) {
	obj.className = "over";
}
function out_view_mode(obj) {
	obj.className = "out";
}
var obj_kb_search;
function chkKbListSearch(obj, where) {
	if (obj.kb_keyword.value.trim().length < 2) {
		alert("2자 이상의 검색어를 넣으세요");
		return false;
	}

	insertLog(5735);
	if (obj.kb_keyword.value.trim().length == 0) {
		obj.target = "";
		obj.mode.value = "";
		obj.submit();
	}
	if (preCheckKbSearchKeyword(where)) {
		obj.target = "hKbListFrame";
		obj.mode.value = "pre_search";
		obj.submit();
		obj_kb_search = obj;
	}
}
function chkKbListSearchCallback() {
	obj_kb_search.target = "";
	obj_kb_search.mode.value = "";
	obj_kb_search.submit();
}
function chkKbListSearchKey(e, obj, where) {
	if (e.keyCode == 13) {
		chkKbListSearch(obj, where);
	}
}
function chkKbSmartListSearch(obj, where) {

	// if(document.getElementById("kb_keyword_t").value.trim().length < 2 && 1 <
	// document.getElementById("kb_keyword_t").value.trim().length){
	// alert("2자 이상의 검색어를 넣으세요");
	// return false;
	// }

	// 분류 sKbcate
	// 2013.02.20 by CDS
	if (document.getElementById("kb_keyword_t").value.trim().length < 2) {
		alert("2자 이상의 검색어를 넣으세요");
		return false;
	}

	if (preCheckKbSearchKeyword(where)) {
		var searchWord = document.getElementById("kb_keyword_t").value.trim();
		var url = "/knowbox/IncKbList_Drawlist_Count_Proc.jsp";
		
		if (varIsKc9 == "true") 
			varStrSmartTapMenu = 3;
		
		var param = "smart_tap_menu=" + varStrSmartTapMenu + "&searchword=" + searchWord;
		
		if (sKbcate != "") 
			param = param + "&qnacatelist=Y&kbcate=" + sKbcate;
		
		commonAjaxRequest(url,param,chkKbSmartListSearchCallback);
	}
}
function chkKbSmartListSearchCallback(originalRequest) {
	eval("varReturn = " +( libType() == "PR" ? originalRequest.responseText : originalRequest));
	var cnt = eval("varReturn.count");
	if (cnt == 0) {
		alert("검색 결과가 없습니다.");
	} else {
		insertLog(5735);
		smart_list_search();
	}
}
function chkKbSmartListSearchKey(e, obj, where) {
	if (e.keyCode == 13) {
		chkKbSmartListSearch(obj, where);
	}
}
function getKbKeywordObj(where) {
	if (where == "t") {
		return document.getElementById("kb_keyword_t");
	} else {
		return document.getElementById("kb_keyword_b");
	}
}
function preCheckKbSearchKeyword(where) {
	var varKeyword = getKbKeywordObj(where).value;
	varKeyword = convertSpecialKeyword(varKeyword);
	getKbKeywordObj(where).value = varKeyword;
	return true;
}
function showSortmode() {
	if (document.getElementById("sort_mode").style.display == "block") {
		document.getElementById("sort_mode").style.display = "none";
		document.getElementById("img_sort_btn").src = document
				.getElementById("img_sort_btn").src.replace(
				"newdown_close.gif", "newdown.gif");
	} else {
		var posLeftTop = cumulativeOffset(document.getElementById("search_sort"));
		document.getElementById("sort_mode").style.left = posLeftTop[0] + "px";
		document.getElementById("sort_mode").style.top = posLeftTop[1] + 18
				+ "px";
		document.getElementById("sort_mode").style.display = "block";
		document.getElementById("img_sort_btn").src = document
				.getElementById("img_sort_btn").src.replace("newdown.gif",
				"newdown_close.gif");
	}
}
function hideSortmode() {
	if (document.getElementById("sort_mode").style.display == "block") {
		document.getElementById("sort_mode").style.display = "none";
		document.getElementById("img_sort_btn").src = document
				.getElementById("img_sort_btn").src.replace(
				"newdown_close.gif", "newdown.gif");
	}
}
function select_sort(sort) {
	if (sKbcode == "kc8") {
		var obj = document.getElementById("frmKbList");
		obj.kbsort.value = sort;
		smart_list_sort(sort);
	} else {
		var obj = document.getElementById("frmKbList");
		obj.page.value = "";
		obj.kbno.value = "";
		obj.modelno.value = "";
		obj.kbsort.value = sort;
		obj.submit();
	}
}
function goPage(i) {
	if (sKbcode == "kc8" || sKbcode == "kc9") {
		smart_menu('', i)
	} else {
		insertLog(5736);
		var obj = document.getElementById("frmKbList");
		obj.page.value = i;
		obj.kbno.value = "";
		obj.modelno.value = "";
		obj.isGuide.value = isGuide;
		if(sKbcode ==  'kc1' && isGuide)
			obj.kbcode.value = 'kc11';
		obj.submit();
	}
}
var intReadFrmHeight = -1;
function getFrameHeight() {
	return intReadFrmHeight;
}
function setFrameHeight(h) {
	intReadFrmHeight = h;
}
function kbReadResize() {
	var oFrame = document.getElementById("ifBodyRead");

	if (oFrame.src) {
		var sh = oFrame.contentWindow.getBodyScrollHeight();
		oFrame.height = sh;
		if (BrowserDetect.browser == "Safari") {
			oFrame.style.height = sh + "px";
		}
		
		if(oFrame.contentWindow){
			if(oFrame.contentWindow.document.getElementById("kbread_body"))
				var sh_r = oFrame.contentWindow.document.getElementById("kbread_body").offsetHeight;
			else 
				var sh_r = 0;				
		}

		oFrame.height = sh;
		if (BrowserDetect.browser == "Safari") {
			oFrame.style.height = sh_r + "px";
		}
		setFrameHeight(sh);
	}
	if ((BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6)
			|| (BrowserDetect.OS == "iPad" && BrowserDetect.browser == "Safari")) {
		setKbListTopPositionIE6();
	} else {
		setKbListTopPosition();
	}
}
function initFrame(obj) {

}
// 스크롤 위치 조정
function cmdSetScroll(param) {
	if (param == 0) {
		document.getElementById("kb_list_box_blank").style.height = "0";
		document.getElementById("kb_list_widegb_blank").style.height = "0";
	}
	if (document.body.scrollTop) {
		document.body.scrollTop = param + "px";
	} else {
		document.documentElement.scrollTop = param + "px";
	}
	if ((BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6)
			|| (BrowserDetect.OS == "iPad" && BrowserDetect.browser == "Safari")) {
		setKbListTopPositionIE6();
	} else {
		setKbListTopPosition();
	}
}
function setKbListWidth() {
	var obj = document.getElementById("kb_list_box");
	if (BrowserDetect.browser == "Explorer"
			&& (BrowserDetect.version == 6 || BrowserDetect.version == 7)) {
		if (kblist_wide == 0) { // 축소상태
			obj.style.width = "240px";
		} else {
			obj.style.width = "460px";
		}
	}
}
// 확장버튼 위치고정
function setBtnKbWideLeftPosition() {
	var varLeftPos = 0;
	if (kblist_wide == 0) { // 축소상태
		varLeftPos = 240;
	} else {
		varLeftPos = 460;
	}
	if (!(BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6)
			&& !(BrowserDetect.OS == "iPad" && BrowserDetect.browser == "Safari")) {
		varLeftPos = varLeftPos - getBodyScrollLeft();
	}
	if (document.getElementById("btn_kb_wide"))
		document.getElementById("btn_kb_wide").style.left = varLeftPos + "px"
}
function setBtnKbWideTopPositionIE6() {
	var varTop = 0;
	varTop = 240 + getBodyScrollTop();
	return varTop + "px";
}
// 목록 위치고정
function setKbListLeftPosition() {
	var obj = document.getElementById("kb_list_box");
	var varLeftPos = 1;
	if ((BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6)
			|| (BrowserDetect.OS == "iPad" && BrowserDetect.browser == "Safari")) {
		varLeftPos = 1;
	} else {
		if (obj.style.position == "fixed") {
			varLeftPos = varLeftPos - getBodyScrollLeft();
		}
	}
	document.getElementById("kb_list_box").style.left = varLeftPos + "px";
}
function setKbListTopPositionIE6() {
	try {
		var obj = document.getElementById("kb_list_box");
		setKbListTopValue();
		if (iKbListTop_now <= 0) {
			if (document.getElementById("kbtop_code_add").style.display == "block") { // my메뉴
																						// 보기상태
				iKbListTop_now = iKbListAddCodeTop;
			} else {
				iKbListTop_now = iKbListTop;
			}
		}
		if (!document.getElementById("ph_list")
				|| !document.getElementById("ph_con1")
				|| !document.getElementById("ph_con2")) {
			return 0;
		}
		if (document.getElementById("ph_list").offsetHeight >= (document
				.getElementById("ph_con1").offsetHeight + document
				.getElementById("ph_con2").offsetHeight)) { // 목록이 글내용보다 길때
			if (kblist_wide == 0) { // 축소상태
				obj.style.position = "static";
				return 0;
			} else { // 확장상태
				obj.style.position = "absolute";
				return iKbListTop_now;
			}
		} else {
			if ((obj.offsetHeight + iKbListTop_now) > (getBodyClientHeight() + getBodyScrollTop())) { // 목록이 다 보이도록 스크롤을 내리지 않은 상태
				if (kblist_wide == 0) { // 축소상태
					obj.style.position = "static";
					return 0;
				} else { // 확장상태
					obj.style.position = "absolute";
					setKbListWidth();
					return iKbListTop_now;
				}
			} else { // 목록이 다 보이거나 목록 끝까지 스크롤을 내린상태
				if (obj.offsetHeight < getBodyClientHeight()) { // 목록이 짧아서 화면에 다 보이는 경우
					document.getElementById("kb_list_widegb_blank").style.height = (getBodyScrollHeight() - iKbListTop_now)
							+ "px";
					if (iKbListTop_now >= getBodyScrollTop()) { // 정상상태로
						if (kblist_wide == 0) { // 축소상태
							obj.style.position = "static";
							return 0;
						} else { // 확장상태
							obj.style.position = "absolute";
							setKbListWidth();
							return getBodyScrollTop() + iKbListTop_now;
						}
					} else {
						if (cumulativeOffset(obj)[1] < getBodyScrollTop()) { // 스크롤을 내리면 목록의 위를 고정
							obj.style.position = "absolute";
							setKbListWidth();
							return getBodyScrollTop() - 1; // -1 해주지 않으면 끝까지
															// 내렸을때 브라우저가 죽는다
						} else {
							obj.style.position = "static";
							return 0;
						}
					}
				} else { // 목록이 화면보다 길때 스크롤을 내리면 아래쪽을 고정
					obj.style.position = "absolute";
					setKbListWidth();
					var rtop = 0;
					if (getBodyClientHeight() + getBodyScrollTop() >= getBodyScrollHeight()) { // 끝까지 내린상태
						rtop = getBodyScrollHeight() - obj.offsetHeight - 1; // -1  해주지 않으면 끝까지 내렸을때 브라우저가 죽는다
					} else {
						rtop = getBodyClientHeight() + getBodyScrollTop()
								- obj.offsetHeight;
					}
					return rtop;
				}
			}
		}
	} catch (e) {
		return 0;
	}
}
function setKbListTopValue() {
	if (iKbListTop <= 0) {
		if (document.getElementById("kbtop_code_add").style.display == "block") { // my메뉴 보기상태
			if (document.getElementById("kb_list_box").style.position == "absolute" || document.getElementById("kb_list_box").style.position == "fixed") {
				iKbListAddCodeTop = cumulativeOffset(document.getElementById("kb_list_box_blank"))[1];
			} else {
				iKbListAddCodeTop = cumulativeOffset(document.getElementById("kb_list_box"))[1];
			}
			
			iKbListTop = iKbListAddCodeTop - cumulativeOffset(document.getElementById("kbtop_code_add"))[1];
		} else {
			if (document.getElementById("kb_list_box").style.position == "absolute" || document.getElementById("kb_list_box").style.position == "fixed") {
				iKbListTop = cumulativeOffset(document.getElementById("kb_list_box_blank"))[1];
			} else {
				iKbListTop = cumulativeOffset(document.getElementById("kb_list_box"))[1];
			}
			
			iKbListAddCodeTop = iKbListTop;
		}
	}
}
function setKbListTopPosition() {
	var obj = document.getElementById("kb_list_box");
	setKbListTopValue();
	if (iKbListTop_now <= 0) {
		if (document.getElementById("kbtop_code_add").style.display == "block") { // my메뉴 보기상태
			iKbListTop_now = iKbListAddCodeTop;
		} else {
			iKbListTop_now = iKbListTop;
		}
	}
	
	if (!document.getElementById("ph_list") || !document.getElementById("ph_con1") || !document.getElementById("ph_con2")) {
		return;
	}
	
	if (document.getElementById("ph_list").offsetHeight >= (document.getElementById("ph_con1").offsetHeight + document.getElementById("ph_con2").offsetHeight)) { // 목록이 글내용보다 길때
		if (kblist_wide == 0) { // 축소상태
			obj.style.bottom 	= "";
			obj.style.top 		= "0";
			obj.style.position 	= "static";
		} else { // 확장상태
		}
	} else {
		if ((obj.offsetHeight + iKbListTop_now) > (getBodyClientHeight() + getBodyScrollTop())) { // 목록이 다 보이도록 스크롤을 내리지 않은 상태
			if (kblist_wide == 0) { // 축소상태
				obj.style.bottom 	= "";
				obj.style.top 		= "0";
				obj.style.position 	= "static";
			} else { // 확장상태
				obj.style.position 	= "absolute";
				obj.style.top 		= iKbListTop_now + "px";
				obj.style.bottom 	= "";
			}
			document.getElementById("kb_list_box_blank").style.height = "0";
		} else { // 목록이 다 보이거나 목록 끝까지 스크롤을 내린상태
			if (obj.offsetHeight < getBodyClientHeight()) { // 목록이 짧아서 화면에 다 보이는 경우
				document.getElementById("kb_list_widegb_blank").style.height = (getBodyScrollHeight() - iKbListTop_now) + "px";
				
				if (iKbListTop_now >= getBodyScrollTop()) { // 정상상태로
					if (kblist_wide == 0) { // 축소상태
						obj.style.bottom = "";
						obj.style.top = "0";
						obj.style.position = "static";
					} else { // 확장상태
						if (obj.style.position == "fixed") {
							obj.style.position = "absolute";
							obj.style.top = iKbListTop_now + "px";
							obj.style.bottom = "";
						} else {
						}
					}
					document.getElementById("kb_list_box_blank").style.height = "0";
				} else {
					if (cumulativeOffset(obj)[1] < getBodyScrollTop()) { // 스크롤을  내리면 목록의 위를 고정
						obj.style.position 	= "fixed";
						obj.style.top 		= "0";
						obj.style.bottom 	= "";
						document.getElementById("kb_list_box_blank").style.height = obj.offsetHeight + "px";
					} else {
					}
				}
				setKbListWidth();
			} else { // 목록이 화면보다 길때 스크롤을 내리면 아래쪽을 고정
				obj.style.position = "fixed";
				obj.style.top = "";
				obj.style.bottom = "0";
				setKbListWidth();
				document.getElementById("kb_list_box_blank").style.height = obj.offsetHeight
						+ "px";
			}
		}
	}
}
function cmdTmp() {
	if (document.getElementById("tmp_123")) {
		// document.getElementById("tmp_123").innerHTML =
		// cumulativeOffset(document.getElementById("kb_list_box_blank"))[1] + "," +
		// document.getElementById("kb_list_box_blank").style.height;
		// document.getElementById("tmp_123").innerHTML = document.getElementById("tmp_123").innerHTML + "<br>" +
		// cumulativeOffset(document.getElementById("kb_list_box"))[1] + "," +
		// document.getElementById("kb_list_box").getHeight() + "," + getBodyScrollHeight();
		// document.getElementById("tmp_123").innerHTML = getBodyClientHeight() + "," +
		// getBodyScrollTop() + " : " + getBodyScrollHeight() + "," +
		// document.getElementById("kb_list_box").offsetHeight;
		// document.getElementById("tmp_123").innerHTML =
		// cumulativeOffset(document.getElementById("kb_list_box"))[1] + "," +
		// cumulativeOffset(document.getElementById("kb_list_box_blank"))[1];
		// document.getElementById("tmp_123").innerHTML =
		// document.getElementById("kb_list_widegb_blank").style.height;
		// document.getElementById("tmp_123").innerHTML = getBodyScrollTop() + "," + iKbListTop_now;
		// document.getElementById("tmp_123").innerHTML = iKbListTop + "," + iKbListAddCodeTop + "," +
		// iKbListTop_now + "," +
		// document.getElementById("kbtop_code_add").style.display;
		// document.getElementById("tmp_123").innerHTML = document.getElementById("kb_list_box_blank").style.height + "," +
		// document.getElementById("kb_list_box").offsetHeight + "," +
		// cumulativeOffset(document.getElementById("kb_list_box"))[1] + "," +
		// (document.getElementById("kb_list_box").offsetHeight +
		// cumulativeOffset(document.getElementById("kb_list_box"))[1]) + "," +
		// getBodyScrollHeight();
		// if(document.getElementById("ph_list") &&
		// document.getElementById("ph_con2")){
		// document.getElementById("tmp_123").innerHTML =
		// document.getElementById("kb_list_box_blank").style.width;
		// }
		// document.getElementById("tmp_123").innerHTML =
		// document.getElementById("ph_list").offsetWidth;
		// if((BrowserDetect.browser=="Explorer" && BrowserDetect.version==6) ||
		// (BrowserDetect.OS=="iPad" && BrowserDetect.browser=="Safari")) {
		// document.getElementById("tmp_123").style.top = (getBodyScrollTop()+100)+"px";
		// }
	}
}
window.setInterval("cmdTmp()", 100);
window.onresize = function() {
	try {
		setTimeout(function() {
			setBtnKbWideLeftPosition();
		}, 100);
	} catch (e) {
	}
	
	try {
		setTimeout(function() {
			setKbListLeftPosition();
		}, 100);
	} catch (e) {
	}
}

window.onscroll = function() {
	try {
		setTimeout(function() {
			setBtnKbWideLeftPosition();
		}, 100);
	} catch (e) {
	}
	
	try {
		setTimeout(function() {
			setKbListLeftPosition()
		}, 100);
	} catch (e) {
	}
	
	try {
		if (!(BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6) && !(BrowserDetect.OS == "iPad" && BrowserDetect.browser == "Safari")) {
			setTimeout(function() {
				setKbListTopPosition();
			}, 100);
		}
	} catch (e) {
	}
	
//	setBannerScroll();
}

var $aside;
var $utilmenu;

$(document).ready(function(){
	$aside = $("#aside");
	$utilmenu = $("#utilMenu");	
	
//	setBannerScroll();
});

function setBannerScroll(){
	var pos = $utilmenu.position().top+$utilmenu.height();
	var scrollTop = $(document).scrollTop();
	
	if(scrollTop<pos)
		$aside.css("top",pos-scrollTop);
	else
		$aside.css("top",0);
}
// 구매가이드에서 필요한 함수
function knowBoxBigImgOpen_20091221(url1) {
	url1 = url1.replace("/view/include/BigImageOnlyPopup.jsp?","/view/Detailmulti.jsp?viewBimg=Y&");
	k = window.open(url1,"guideImgPopup","width=100,height=100,top=0,left=0,toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=no,menubar=no,personalbar=no");
	k.focus();
}
function goTop() {
	if (document.getElementById("wrap")) {
		document.getElementById("wrap").scrollIntoView(true);
	}
	
	if (document.getElementById("body")) {
		document.getElementById("body").scrollIntoView(true);
		document.getElementById("body").scrollTop = "0";
	}
}
function closeImgDiv(obj) {
	obj.style.display = "none";
}
function showImgDiv_20091221(imgPath) {
	if (document.getElementById("imgKnowboxTag")) {
		document.getElementById("imgKnowboxTag").src = imgPath;
		document.getElementById("imgKnowboxShowDiv").style.left = 290 + "px";
	}
	if (document.getElementById("FSETMAIN")) {
		document.getElementById("imgKnowboxShowDiv").style.top = (document.getElementById("FSETMAIN").scrollTop + 200) + "px";
	} else {
		document.getElementById("imgKnowboxShowDiv").style.top = (getBodyScrollTop() + 200) + "px";
	}
	document.getElementById("imgKnowboxShowDiv").style.display = "inline";
}
// 업로드된 확대이미지를 보여주기 위한 함수
function bigImageShowPopup(imgPath) {
	var url = "http://www.enuri.com/view/enuriupload/Show_OneImageKnowboxPopup.jsp?imgname=" + imgPath;
	var imageshowPopup = window.open(url,"imageshow","width=" + window.screen.width + ",height=" + window.screen.height + ",top=0,left=0,toolbar=no,location=no,directories=no,status=no,scrollbars=no,menubar=no,personalbar=no");
	imageshowPopup.focus();
}

var tempPageNo = "";
function smart_menu(mentNo, pageNo) {
	tempPageNo = pageNo;
	if (mentNo == "") {
		mentNo = varStrSmartTapMenu;
	} else {
		varStrSmartTapMenu = mentNo;
	}
	var obj = document.getElementById("frmKbList");
	var sort = obj.kbsort.value;
	obj.kbsort.value = "regdate";
	/* document.getElementById("search_sort").childNodes[0].innerHTML = "<P>등록일 순</P>"; */
	// document.getElementById("kb_keyword_t").value = "";
	var url = "/knowbox/IncKbList_Drawlist_Count_Proc.jsp";
	var param = "smart_tap_menu=" + mentNo + "&page=" + pageNo + "&kbcate=" + sKbcate;
	commonAjaxRequest(url,param,chkKbCheckSearchCntCallback);
}
function chkKbCheckSearchCntCallback(originalRequest) {
	eval("varReturn = " + (libType() == "PR" ? originalRequest.responseText : originalRequest));
	var cnt = eval("varReturn.count");
	if (cnt == 0) {
		// varStrSmartTapMenu = tempPageNo;
		alert("검색 결과가 없습니다.");
	} else {
		// if(varIsKc9=="false"){
		// var liLayer = document.getElementById("knsmart_tab").getElementsByTagName('img');
		// for(var i=0;i<liLayer.length;i++){
		// liLayer[i].src =
		// var_img_enuri_com+"/images/knowbox/2012/knsmart_tab_0"+(i+1)+"_0620.gif";
		// }
		// liLayer[varStrSmartTapMenu-1].src =
		// var_img_enuri_com+"/images/knowbox/2012/knsmart_tab_0"+varStrSmartTapMenu+"_0620_on.gif";
		// }
		var obj = document.getElementById("frmKbList");
		obj.smart_tap_menu.value = varStrSmartTapMenu;
		var sort = obj.kbsort.value;
		var searchWord = document.getElementById("kb_keyword_t").value.trim();
		incKbList_Paging(varStrSmartTapMenu, tempPageNo, sort, searchWord);
	}
	tempPageNo = 0;
}
// kc8 스마트 부분 글 리스트 검색
function smart_list_search() {
	/* var strSortHtml = "<P>등록일 순</P>"; */
	var sort = "regdate";
	var obj = document.getElementById("frmKbList");
	obj.kbsort.value = sort;
	/* document.getElementById("search_sort").childNodes[0].innerHTML = strSortHtml; */
	var searchWord = document.getElementById("kb_keyword_t").value.trim();
	if (sKbcate != "") {
		incQNAList_Paging(varStrSmartTapMenu, "", sort, searchWord, sKbcate)
	} else {
		incKbList_Paging(varStrSmartTapMenu, "", sort, searchWord);
	}
}
// kc8 스마트 부분 글 sort
function smart_list_sort(sort) {
	document.getElementById("sort_mode").style.display = "none";
	var strSortHtml = "<P>등록일 순</P>";
	if (sort == "regdate") {
		strSortHtml = "<P>등록일 순</P>";
	} else if (sort == "readcnt") {
		strSortHtml = "<P>조회수 순</P>";
	} else if (sort == "childno") {
		strSortHtml = "<P>댓글수 순</P>";
	}
	document.getElementById("search_sort").childNodes[0].innerHTML = strSortHtml;
	var searchWord = document.getElementById("kb_keyword_t").value.trim();
	if (sKbcate != "") {
		incQNAList_Paging(varStrSmartTapMenu, "", sort, searchWord, sKbcate)
	} else {
		incKbList_Paging(varStrSmartTapMenu, "", sort, searchWord);
	}

}
function incKbList_Paging(tapmenu, page, sort, keyword) {
	document.getElementById("drawlist_div").innerHTML = "";
	document.getElementById("drawlist_div").style.display = "none";
	document.getElementById("search_now").style.display = "none";
	// if(document.getElementById("knsmart_tab")){
	// document.getElementById("knsmart_tab").style.display="none";
	// }

	/*
	 * if(keyword.length > 0 && keyword != ""){
	 * document.getElementById("div_search_layer").style.display="block";
	 * document.getElementById("search_now_txt").innerHTML = "<font color=\"red\">"+keyword+"</font>의
	 * 지식통 검색결과(<font id=\"searchtotalcnt\" ></font>개)"; }else{
	 * document.getElementById("div_search_layer").style.display="none"; }
	 */

	var url = "/knowbox/IncKbList_Drawlist_Count_Proc.jsp";
	var param = "smart_tap_menu=" + tapmenu + "&searchword=" + keyword
			+ "&kbcate=" + sKbcate;
	commonAjaxRequest(url,param,chkKbViewSearchLayerCallback);

	if (typeof (page) == "undefined" || page == "") {
		page = 1;
	}

	document.getElementById("ifBodyRead").src = "";
	var url = "/knowbox/IncKbList_Drawlist_Proc.jsp";
	var param = "smart_tap_menu=" + varStrSmartTapMenu + "&page=" + page + "&sort=" + sort + "&searchword=" + keyword + "&kbcate=" + sKbcate;
	commonAjaxRequest(url,param,smartMenuCallback);
	document.getElementById("IncKbList_Paging_div").innerHTML = "";
	document.getElementById("IncKbList_Paging_div").style.display = "none";

	var url = "/knowbox/IncKbList_Paging_Proc.jsp";
	var param = "smart_tap_menu=" + varStrSmartTapMenu + "&page=" + page+ "&searchword=" + keyword + "&kbcate=" + sKbcate;
	commonAjaxRequest(url,param,smartPagingCallback);
	cmdHideMyMenu();
}
function incQNAList_Paging(tapmenu, page, sort, keyword, kbcate) {
	document.getElementById("drawlist_div").innerHTML 	= "";
	document.getElementById("drawlist_div").style.display = "none";
	document.getElementById("search_now").style.display 	= "none";
	
	// if(document.getElementById("knsmart_tab")){
	// document.getElementById("knsmart_tab").style.display="none";
	// }
	/*
	 * if(keyword.length > 0 && keyword != ""){
	 * document.getElementById("div_search_layer").style.display="block";
	 * document.getElementById("search_now_txt").innerHTML = "<font color=\"red\">"+keyword+"</font>의
	 * 지식통 검색결과(<font id=\"searchtotalcnt\" ></font>개)"; }else{
	 * document.getElementById("div_search_layer").style.display="none"; }
	 */

	var url = "/knowbox/IncKbList_Drawlist_Count_Proc.jsp";
	var param = "smart_tap_menu=" + tapmenu + "&searchword=" + keyword
			+ "&qnacatelist=Y&kbcate=" + kbcate;
	commonAjaxRequest(url,param,chkKbViewSearchLayerCallback);

	if (typeof (page) == "undefined" || page == "") {
		page = 1;
	}
	
	document.getElementById("ifBodyRead").src = "";
	
	var url = "/knowbox/IncKbList_Drawlist_Proc.jsp";
	var param = "smart_tap_menu=" + varStrSmartTapMenu + "&page=" + page + "&sort=" + sort + "&searchword=" + keyword + "&qnacatelist=Y&kbcate=" + kbcate;
	commonAjaxRequest(url,param,smartMenuCallback);
	
	document.getElementById("IncKbList_Paging_div").innerHTML = "";
	document.getElementById("IncKbList_Paging_div").style.display = "none";

	var url = "/knowbox/IncKbList_Paging_Proc.jsp";
	var param = "smart_tap_menu=" + varStrSmartTapMenu + "&page=" + page + "&searchword=" + keyword + "&kbcate=" + kbcate;
	commonAjaxRequest(url,param,smartPagingCallback);
	cmdHideMyMenu();
}
function chkKbViewSearchLayerCallback(originalRequest) {
	eval("varReturn = " + (libType() == "PR" ? originalRequest.responseText : originalRequest));
	var cnt = eval("varReturn.count");
	/*document.getElementById("searchtotalcnt").innerHTML = cnt;*/
}
function smartPagingCallback(originalRequest) {
	document.getElementById("IncKbList_Paging_div").innerHTML = libType() == "PR" ? originalRequest.responseText : originalRequest;
	document.getElementById("IncKbList_Paging_div").style.display = "block";
}
function smartMenuCallback(originalRequest) {
	document.getElementById("drawlist_div").innerHTML = libType() == "PR" ? originalRequest.responseText : originalRequest;
	document.getElementById("search_now").style.display = "block";
	// if(document.getElementById("knsmart_tab")){
	// document.getElementById("knsmart_tab").style.display="block";
	// }
	document.getElementById("drawlist_div").style.display = "block";
	
	setKbListTopPosition();
	
	if (document.getElementById("kb_article_1")) {		
		cmdRead(1, document.getElementById("kb_article_1").getAttribute("kbno"));
		cmdBlogGroup(iGroup, document.getElementById("kb_article_1").getAttribute("kbno"));
	}
}
function cmdQna(group, kbno) {
	document.getElementById("blog_top_layer").style.display = "none";
	loadBlogQnaLogin(0);
	document.getElementById("top_bm_list").style.display = "block";
	document.getElementById("ifBodyRead").style.display = "none";
	
	document.getElementById("ifKbListBlog").src = "/blog/Blog_list.jsp?group=3&kbno=" + iKbno + "&myqna=&findmyqna=&lCateCode=" + sKbcate2 + "&mCateCode=" + sWriteMcate + "&from=qna&linkchk=2";
	
	if(varLinkChk == 0){
		// 질문하기 선택 시에 선택 글 표시 해제
		var listObj = document.getElementById('drawlist_div');
		for(var i=0;i<listObj.childNodes.length;i++)
			if(listObj.childNodes[i].className == 'kblist_article_now')
				listObj.childNodes[i].className = 'kblist_article_normal';
/*		if($$('div.kblist_article_now').size() > 0)
			$$('div.kblist_article_now')[0].className = 'kblist_article_normal';
		if(document.getElementById('ifKbListBlog').contentWindow.$$('span.eb_article_1').size() > 0)
			document.getElementById('ifKbListBlog').contentWindow.$$('span.eb_article_1')[0].className = 'eb_article_2';*/
	}
}

function cmdQnaCancel() {
	var obj = document.getElementById("frmKbList");
	cmdRead(1, obj.kbno.value, 0, 0);
	cmdBlogGroup(1, obj.kbno.value);
}
function showInfo(param) {
	closeAllInfo(param);
	
	var obj 	= document.getElementById("layer_info_" + param);
	var obj_btn = document.getElementById("btn_info_"   + param);
	
	var obj_left = 0;
	var obj_top  = 0;
	
	if (param == 1) { // 비회원글쓰기안내
		obj_left = cumulativeOffset(obj_btn)[0] - 200;
		obj_top  = cumulativeOffset(obj_btn)[1] + 13;
	} else if (param == 2) { // 닉네임
		obj_left = cumulativeOffset(obj_btn)[0] + 0;
		obj_top  = cumulativeOffset(obj_btn)[1] + 13;
	} else if (param == 3) { // 비밀번호
		obj_left = cumulativeOffset(obj_btn)[0] + 0;
		obj_top  = cumulativeOffset(obj_btn)[1] + 13;
	} else if (param == 4) { // 댓글알림
		obj_left = cumulativeOffset(obj_btn)[0] + 0;
		obj_top  = cumulativeOffset(obj_btn)[1] + 13;
	} else if (param == 5) { // 닉네임 오류
		obj_btn  = document.getElementById("btn_info_3");
		obj_left = cumulativeOffset(obj_btn)[0] - 25;
		obj_top  = cumulativeOffset(obj_btn)[1] + 13;
	} else if (param == 6) { // 이름 및 비번 미입력
		obj_left = cumulativeOffset(obj_btn)[0] + 360;
		obj_top  = cumulativeOffset(obj_btn)[1] + 170;
	} else if (param == 7) { // 자동 로그인안내
        obj_btn  = document.getElementById("btn_autologin");
        obj_left = cumulativeOffset(obj_btn)[0] - 214;
        obj_top  = cumulativeOffset(obj_btn)[1] + 13;       
    } 
	
	if (obj) {
		if (obj.style.display == "block") {
			obj.style.display = "none";
		} else {
			obj.style.left = obj_left + "px";
			obj.style.top  = obj_top + "px";
			obj.style.display = "block";
		}
	}
}
function closeAllInfo(param) {
	for (i = 1; i < 10; i++) {
		if (document.getElementById("layer_info_" + i)) {
			if (i != param) {
				document.getElementById("layer_info_" + i).style.display = "none";
			}
		} else {
			break;
		}
	}
	cmdHideMyMenu();
}
function pageInputTypeReload() { // 블로그qna에서 로그아웃 후 호출됨
	cmdAfterLoginKbTop();
}
function InputLoginId(obj) {
	obj.style.background = "#ffffff";
	closeAllInfo();
	obj.focus();
	obj.select();
}
function OutLoginId(obj) {
	if (obj.value == "") {
		obj.style.background = "#ffffff url(http://img.enuri.gscdn.com/images/knowbox/goodboard/tx_name2.gif) no-repeat 1px 3px";
	}
}
function InputLoginPass(obj) {
	obj.style.background = "#ffffff";
	closeAllInfo();
	obj.focus();
	obj.select();
}
function InputLoginLayerPass(obj) {
	obj.style.background = "#ffffff";
}
function OutLoginPass(obj) {
	if (obj.value == "") {
		obj.style.background = "#ffffff url(http://img.enuri.gscdn.com/images/knowbox/goodboard/tx_pw2.gif) no-repeat 1px 3px";
	}
}
function InputLoginContents(obj) {
	obj.style.background = 'url(http://img.enuri.gscdn.com/images/blog/txt_info_2.gif) no-repeat 6px 7px';
	closeAllInfo();
	obj.focus();
	obj.select();
}
function OutLoginContents(obj) {
	if (obj.value == "") {
		obj.style.background = "#ffffff url(http://img.enuri.gscdn.com/images/knowbox/goodboard/tx_03.gif) no-repeat 1px 3px";
	}
}
function InputLoginMail(obj) {
	obj.style.background = "#ffffff";
	closeAllInfo();
	obj.focus();
	obj.select();
}
function OutLoginMail(obj) {
	if (obj.value == "") {
		obj.style.background = "#ffffff url(http://img.enuri.gscdn.com/images/knowbox/goodboard/tx_mail.gif) no-repeat 1px 2px";
	} else {
		obj.style.background = "#ffffff";
	}
}
/*
 * prototype.getBytes : 바이트 수를 계산해서 반환한다
 */
String.prototype.getBytes = function() {
	var str = this.trim();
	var l = 0;

	if (str != null && str != 'undefined')
		for ( var i = 0; i < str.length; i++)
			l += (str.charCodeAt(i) > 128) ? 2 : 1;
	return l;
}
/*
 * chkNickByte : 닉네임의 바이트 수를 검증한다.
 */
function chkNickByte(strNickname) {
	var len = strNickname.trim().getBytes();

	if (len < 2 || len > 16)
		return true;
	else
		return false;
}

/*
 * chkPassChar2 : 비밀번호를 체크한다.
 */
function chkPassChar2(strPass) {
	var regExp = /^[a-zA-Z0-9_]{2,12}$/;

	return regExp.test(strPass);
}

/*
 * mailCheck : 이메일 체크
 */
function mailCheck(mailObj) {
	var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

	if (!regExp.test(mailObj.value.trim())) {
		alert("올바른메일주소를 입력해 주세요");
		mailObj.focus();
		return false;
	} else
		return true;
}

function cmdViewMyNickMenu(obj) {
	var vLeft = cumulativeOffset(obj)[0];
	var vTop = cumulativeOffset(obj)[1] + 11;
	document.getElementById("div_my_nick_menu").style.left = vLeft + "px";
	document.getElementById("div_my_nick_menu").style.top = vTop + "px";
	document.getElementById("div_my_nick_menu").style.display = "block";
}
function cmdMyNickMenuClick(param) {
	if (param == 3) { // 로그아웃
		document.getElementById("hiddenLoginFrame").src = "/login/Logout_Exe_2010.jsp?from=detailbbs";
	}
	cmdHideMyMenu();
}
function fnChkByteLength(objTar)
{
    if(event.keyCode > 31 || event.keyCode == "") 
    {
        if(objTar.value.bytes() > objTar.maxLength)
        {
            alert("최대 한글 1~8자, 영문 2~16자까지 입력이 가능합니다");
            objTar.value = objTar.value.cut(objTar.maxLength);
        }
    }
}

String.prototype.bytes = function() {
    var str = this;
    var l   = 0;
    
    for (var i=0; i<str.length; i++) l += (str.charCodeAt(i) > 128) ? 2 : 1;
        return l;
}

function cmdAfterLoginQnA()
{
	if(document.getElementById('content_m')){
	    document.getElementById('content_m').readOnly = false;
	    document.getElementById('content_m').onclick = function() {};
	    document.getElementById('imgRegist').onclick = function() {cmdBlogQnaWriteSubmit()};
	}
}

function fnChkTextArea(obj,maxLetter){
    var arrObjValue = obj.value.split("\n");

    for(i=0;i<arrObjValue.length;i++){
        if(arrObjValue.length == obj.rows && Math.ceil(arrObjValue[i].getByteLength / maxLetter) > 1){
            arrObjValue[i] = arrObjValue[i].cut(maxLetter);
            obj.value = arrObjValue.join("\n");
            alert('최대' + obj.rows + '줄까지 작성가능합니다.');
            break;
        }
    }

    if(arrObjValue.length > obj.rows){

        obj.value = arrObjValue.splice(0,obj.rows).join("\n");
        alert('최대 ' + obj.rows + '줄까지 작성가능합니다.');
        return;
    }

    if(obj.value.getByteLength() > maxLetter){
        alert('최대' + maxLetter + 'Byte까지 입력가능합니다.');
        obj.value = obj.value.cut(maxLetter);
    }
}
function fnHideLLayer(){
	document.getElementById('nowLoc_L_Layer').style.display = "none";
	document.getElementById("lm_lname").onclick = showLocLCate;
	if(frmWKnowBox.lCateName.value != '-분류선택-'){
		document.getElementById("lm_lname").getElementsByTagName("DIV")[0].style.color = '#494949';
		//document.getElementById("lm_lname").getElementsByTagName("DIV")[0].style.fontWeight = 'bold';
	}
	document.getElementById("lm_lname").getElementsByTagName("DIV")[0].innerHTML = frmWKnowBox.lCateName.value;
	document.getElementById("lcate_dn").src = var_img_enuri_com+"/2012/list/linemap2013/now_combo_dn.gif";
}

function fnHideMLayer(){
	document.getElementById('nowLoc_M_Layer').style.display = "none";

	if(!frmWKnowBox.lCateCode.value.isEmpty() && frmWKnowBox.lCateCode.value != 'kbALL'){
		document.getElementById("lm_mname").onclick 	= function(){showLocMCate();}  
		document.getElementById("lm_mname_btn").onclick = function(){showLocMCate();}  
	} else {
		document.getElementById("lm_mname").onclick 	= function(){}  
		document.getElementById("lm_mname_btn").onclick = function(){}  
	}
	
	if(!frmWKnowBox.mCateName.value.isEmpty()){
		if(frmWKnowBox.mCateName.value != '-분류선택-'){
			document.getElementById("lm_mname").getElementsByTagName("DIV")[0].style.color = '#494949';
			//document.getElementById("lm_mname").getElementsByTagName("DIV")[0].style.fontWeight = 'bold';
		}
		document.getElementById("lm_mname").getElementsByTagName("DIV")[0].innerHTML = frmWKnowBox.mCateName.value;
	}
	document.getElementById("mcate_dn").src = var_img_enuri_com+"/2012/list/linemap2013/now_combo_dn.gif";
}

function showLocLCate(){
	insertLog(10079);
    var obj = document.getElementById('lm_lname');

    document.getElementById('nowLoc_L_Layer').style.top  = (cumulativeOffset(obj)[1] + 17) + "px";
    document.getElementById('nowLoc_L_Layer').style.left = (cumulativeOffset(obj)[0] -  4)  + "px";

    document.getElementById('nowLoc_L_Layer').style.display = "inline";
    fnHideMLayer();
	document.getElementById("lcate_dn").src = var_img_enuri_com+"/2012/list/linemap2013/now_combo_x.gif";
	frmWKnowBox.lCateName.value = document.getElementById("lm_lname").getElementsByTagName("DIV")[0].innerHTML;
	
	document.getElementById("lm_lname").onclick = function(){fnHideLLayer();}
	document.getElementById("lm_lname").getElementsByTagName("DIV")[0].style.color 		= '#000000';
	//document.getElementById("lm_lname").getElementsByTagName("DIV")[0].style.fontWeight = 'normal';
	document.getElementById("lm_lname").getElementsByTagName("DIV")[0].style.fontSize 	= '11px';
	document.getElementById("lm_lname").getElementsByTagName("DIV")[0].innerHTML 		= "선택하세요";
}

function showLocLCateSel(code,name,eObj){
    function getMCateCallback(originalRequest) {
        var goodsInfo = new Array((libType() == "PR" ? originalRequest.responseText : originalRequest).split(",").length-1);

        for(i=0;i<(libType() == "PR" ? originalRequest.responseText : originalRequest).split(",").length-1;i++){
     	   	goodsInfo[i] = new Array(2);
     	   	goodsInfo[i][0] = (libType() == "PR" ? originalRequest.responseText : originalRequest).split(",")[i].split("|")[0];
     	   	goodsInfo[i][1] = (libType() == "PR" ? originalRequest.responseText : originalRequest).split(",")[i].split("|")[1];
        }
        
        if(document.getElementById('nowLoc_M_Layer_In').getElementsByTagName('ul')[0]){
        	var obj = document.getElementById('nowLoc_M_Layer_In').getElementsByTagName('ul')[0];
        	document.getElementById('nowLoc_M_Layer_In').removeChild(obj);
        }
        
        var obj = document.createElement('ul');
        obj.className = 'cate_layer_ul';
        
        parentObj = document.getElementById('nowLoc_M_Layer_In').appendChild(obj);

        for(i=0;i<goodsInfo.length;i++){
     	   var childObj  = document.createElement('li');

     	   childObj.id 			= 'mCateList' + i;
     	   childObj.innerHTML 	= goodsInfo[i][1];
     	   childObj.onmouseover = function() {this.style.color='#c70b09';}
     	   childObj.onmouseout	= function() {this.style.color='#242424';}
      		  
      	   if(window.attachEvent){
      		   childObj.attachEvent("onclick",new Function("showLocMCateSel('" + goodsInfo[i][0] + "','" + goodsInfo[i][1] + "','" + childObj.id + "')"));      		   
      	   } else if(window.addEventListener){
      		   childObj.addEventListener("click",new Function("showLocMCateSel('" + goodsInfo[i][0] + "','" + goodsInfo[i][1] + "','" + childObj.id + "')"),false);
      	   }else {
      		   childObj.addEventListener("click",new Function("showLocMCateSel('" + goodsInfo[i][0] + "','" + goodsInfo[i][1] + "','" + childObj.id + "')"),false);
      	   }
      	   
     	   parentObj.appendChild(childObj);
        }        
        
    	for(i=0;i<document.getElementById('linemap').getElementsByTagName('li').length;i++)
    		document.getElementById('linemap').getElementsByTagName('li')[i].style.display = code == 'kb11' ? 'none' : 'inline';
    	
        if(code == 'kb11'){
        	document.getElementById('lm_lcombo').style.display = 'inline';
        	document.getElementById('lm_lname').style.display  = 'inline';
        }
        
        if(goodsInfo.length > 1){
        	document.getElementById('lm_mname').onclick 	= function(){showLocMCate();}
        	document.getElementById('lm_mname_btn').onclick = function(){showLocMCate();}
        } else {
        	document.getElementById('lm_mname').onclick 	= function(){};
        	document.getElementById('lm_mname_btn').onclick = function(){};
        }
        
    	document.getElementById("lm_lname").onclick = showLocLCate;
    	
    	if(code != 'kb11')
    		showLocMCate();
     }

    for(i=0;i<eObj.parentNode.getElementsByTagName('li').length;i++){
    	eObj.parentNode.getElementsByTagName('li')[i].style.fontWeight 		= 'normal';
    	eObj.parentNode.getElementsByTagName('li')[i].style.color 			= '#000000';
    	eObj.parentNode.getElementsByTagName('li')[i].style.backgroundImage = "url(" + var_img_enuri_com + "/2012/list/linemap2013/bullet.gif)";
    	eObj.parentNode.getElementsByTagName('li')[i].onmouseover = function(){this.style.color='#c70b09';}
    	eObj.parentNode.getElementsByTagName('li')[i].onmouseout  = function(){this.style.color='#242424';}
    }
    
    //eObj.style.fontWeight 	= 'bold';
    eObj.style.color 		= '#00589a';
    eObj.style.backgroundImage = "url(" + var_img_enuri_com + "/2012/list/linemap2013/icon_arr_b.gif)";
    eObj.onmouseover = function(){this.style.color='#00589a';}
    eObj.onmouseout = function(){this.style.color='#00589a';}

	frmWKnowBox.lCateCode.value = code;
	frmWKnowBox.lCateName.value = name;	
	frmWKnowBox.mCateCode.value = "";
	frmWKnowBox.mCateName.value = "";	
	
	document.getElementById("lm_lname").getElementsByTagName("DIV")[0].style.color 		= '#494949';
	//document.getElementById("lm_lname").getElementsByTagName("DIV")[0].style.fontWeight = 'bold';
	document.getElementById('nowLoc_L_Layer').style.display = "none";
	document.getElementById("lm_mname").getElementsByTagName("DIV")[0].style.color 		= '#000000';
	//document.getElementById("lm_mname").getElementsByTagName("DIV")[0].style.fontWeight	= 'normal';
	
	document.getElementById("lm_mname").getElementsByTagName("DIV")[0].innerHTML = "-분류선택-";
	document.getElementById("lm_lname").getElementsByTagName("DIV")[0].innerHTML = name;	
	
	document.getElementById("lcate_dn").src = var_img_enuri_com+"/2012/list/linemap2013/now_combo_dn.gif";
	
    var url = "/knowbox/AjaxQnAMCate.jsp";

    var param = "MCate=" + code;
    commonAjaxRequest(url,param,getMCateCallback);
}

function showLocMCate(){   
	insertLog(10079);
	var obj = document.getElementById('lm_mname');
	
	if(!frmWKnowBox.lCateName.value.isEmpty())
		fnHideLLayer();
	
	document.getElementById("mcate_dn").src = var_img_enuri_com+"/2012/list/linemap2013/now_combo_x.gif";
	
	frmWKnowBox.mCateName.value = document.getElementById("lm_mname").getElementsByTagName("DIV")[0].innerHTML;
	
	document.getElementById("lm_mname").onclick 		 = function(){fnHideMLayer();}	
	document.getElementById("lm_mname").getElementsByTagName("DIV")[0].style.color 	 = '#000000';
	//document.getElementById("lm_mname").getElementsByTagName("DIV")[0].style.fontWeight = 'normal';
	document.getElementById("lm_mname").getElementsByTagName("DIV")[0].style.fontSize = '11px';
	document.getElementById("lm_mname").getElementsByTagName("DIV")[0].innerHTML = "선택하세요";    
	
    document.getElementById('nowLoc_M_Layer').style.top  = (cumulativeOffset(obj)[1] + 17) + "px";
    document.getElementById('nowLoc_M_Layer').style.left = (cumulativeOffset(obj)[0] - 4)  + "px";
    
    document.getElementById('nowLoc_M_Layer').style.display = "inline";
    document.getElementById("lm_mname_btn").onclick = function(){fnHideMLayer();}    
}

function showLocMCateSel(code,name,idName){
	frmWKnowBox.mCateCode.value = code;
	frmWKnowBox.mCateName.value = name;	
	
	document.getElementById('nowLoc_M_Layer').style.display = "none";
	document.getElementById("lm_mname").getElementsByTagName("DIV")[0].style.color 		= '#494949';
	//document.getElementById("lm_mname").getElementsByTagName("DIV")[0].style.fontWeight = 'bold';
	document.getElementById("lm_mname").onclick 			= showLocMCate; 

	document.getElementById("lm_mname").getElementsByTagName("DIV")[0].innerHTML = name;	
	document.getElementById("mcate_dn").src = var_img_enuri_com+"/2012/list/linemap2013/now_combo_dn.gif";

    for(i=0;i<document.getElementById(idName).parentNode.getElementsByTagName('li').length;i++){
    	//document.getElementById(idName).parentNode.getElementsByTagName('li')[i].style.fontWeight 		= 'normal';
    	document.getElementById(idName).parentNode.getElementsByTagName('li')[i].style.color 			= '#000000';
    	document.getElementById(idName).parentNode.getElementsByTagName('li')[i].style.backgroundImage = "url(" + var_img_enuri_com + "/2012/list/linemap2013/bullet.gif)";
    	document.getElementById(idName).parentNode.getElementsByTagName('li')[i].onmouseover = function(){this.style.color='#c70b09';}
    	document.getElementById(idName).parentNode.getElementsByTagName('li')[i].onmouseout  = function(){this.style.color='#242424';}
    }
    
    //document.getElementById(idName).style.fontWeight 	= 'bold';
    document.getElementById(idName).style.color 		= '#00589a';
    document.getElementById(idName).style.backgroundImage = "url(" + var_img_enuri_com + "/2012/list/linemap2013/icon_arr_b.gif)";
    document.getElementById(idName).onmouseover = function(){this.style.color='#00589a';}
    document.getElementById(idName).onmouseout  = function(){this.style.color='#00589a';}
}
function getKbreadBodyHeight(){
	if(document.getElementById("kbread_body"))
		return document.getElementById("kbread_body").offsetHeight;
	else 
		return 0;
}
function kbReadListResize() {
	var oFrame = document.getElementById("ifKbList");
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
		docResize();
	}
}

function kbReadListResize2() {
	var oFrame = document.getElementById("ifKbListBlog");
	if(oFrame){
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
			docResize();
		}
	}
}

function docResize() {
	try{
		cmdHideMyMenu();
		cmdHideMemMenu();
	}catch(e){}
	parent.kbReadResize();
}

function fnOnLoadIframe(){
	document.getElementById("QnA_sponsor_link").innerHTML = document.getElementById("sponsor_link2").contentWindow.document.body.innerHTML;
}

function cumulativeOffset(element) {
	var valueT = 0, valueL = 0;
	
	do {
		valueT += element.offsetTop || 0; 
		valueL += element.offsetLeft || 0; 
		element = element.offsetParent;
	} while (element); 
	
	return [valueL, valueT]; 
}