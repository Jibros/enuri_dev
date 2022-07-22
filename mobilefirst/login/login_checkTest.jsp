<%@ include file="/login/Inc_AutoLoginSet_2010.jsp"%><%
	String loginCheck_strID = cb.GetCookie("MEM_INFO","USER_ID");
	
	boolean IsAutoLogin = false;
	if(loginCheck_strID.length()>0) {
		String tempAutoLogin = cb.GetCookie("MYINFO","AUTOLOGIN");
		String tempAutoLoginID = cb.GetCookie("MYINFO","AUTOLOGINID");

		if(tempAutoLogin.equals("Y") && loginCheck_strID.equals(tempAutoLoginID)) {
			IsAutoLogin = true;
		}
	}
%>
<script language="JavaScript">
<!--
var strID = "<%=loginCheck_strID%>";

function IsLogin() {
	var cName = "LSTATUS";
	var s = document.cookie.indexOf(cName +'=');
	if (s != -1){
		s += cName.length + 1;
		e = document.cookie.indexOf(';',s);
		if (e == -1){
			e = document.cookie.length
		}
		if( unescape(document.cookie.substring(s,e))=="Y"){
			if(window.android){
				window.android.isLogin("true");
			}
			return true;
		}else{
			if(window.android){
				window.android.isLogin("false");
			}
			return false;
		}
	}else{
			if(window.android){
				window.android.isLogin("false");
			}	
		return false;
	}
}

function IsLoginCheck() {
	var cName = "LSTATUS";
	var s = document.cookie.indexOf(cName +'=');
	if (s != -1){
		s += cName.length + 1;
		e = document.cookie.indexOf(';',s);
		if (e == -1){
			e = document.cookie.length
		}
		if( unescape(document.cookie.substring(s,e))=="Y"){
			return true;
		}else{
			return false;
		}
	}else{
		return false;
	}
}

// 로그인 링크
function goLogin() {
	document.location.href = "/mobilenew/login/login.jsp?app=<%=strApp%>&backUrl="+encodeURIComponent(document.location.href);
}

// 성인 인증 로그인 링크
function goALogin() {
	document.location.href = "/mobilenew/login/adult.jsp?app=<%=strApp%>&backUrl="+encodeURIComponent(document.location.href);
}

// 회원가입 링크
function goJoin() {
	document.location.href = "/mobilenew/login/join.jsp?app=<%=strApp%>&backUrl="+encodeURIComponent(document.location.href);
}

// 회원수정 링크
function goModify() {
	document.location.href = "/mobilenew/login/modify.jsp?app=<%=strApp%>&backUrl="+encodeURIComponent(document.location.href);
}

// 로그인 후에 찜함 링크
function goLoginZzim(modelno) {
	var locStr = document.location.href;
	if(locStr.indexOf("&zzimModelno")>-1) {
		locStr = locStr.substring(0,locStr.indexOf("&zzimModelno")); 
	}

	document.location.href = "/mobilenew/login/login.jsp?app=<%=strApp%>&backUrl="+encodeURIComponent(locStr+"&zzimModelno="+modelno);
}

// 로그아웃 링크
function goLogout() {
	<%if(!strApp.equals("Y")) {%>if(confirm("로그아웃 하시겠습니까?")) {<%}%>
		var url = "/mobilenew/ajax/login/logout_ajax.jsp";
		var param = "";

		$.ajax({
			type : "post",
			url : url,
			data : param, 
			dataType : "html",
			success : function(ajaxResult) {
				//top.location.reload();
				if(window.android){
					window.android.logout();
				}else{
					top.location.reload();
				}
			}
		});
	<%if(!strApp.equals("Y")) {%>}<%}%>
}

// 최근본 페이지로 이동
function goResent() {
	document.location.href = "/mobilenew/resentzzim/resentzzimList.jsp?listType=1";
}

// 찜 페이지로 이동
function goZzim() {
	<%if(strApp.equals("Y")) {%>
	document.location.href = "/mobilenew/resentzzim/resentzzimList.jsp?listType=2";
	<%} else {%>
	if(IsLogin()==true) {
		document.location.href = "/mobilenew/resentzzim/resentzzimList.jsp?listType=2";
	} else {
		if(confirm("로그인 하시겠습니까?")) {
			goLogin();
		}
	}
	<%}%>
}

// 성인인증 링크
function goAdult() {
	if(confirm("청소년 유해 키워드가 포함된 상품이므로\n성인인증이 필요합니다.")) {
		document.location.href = "/mobilenew/login/adult.jsp?app=<%=strApp%>&backUrl="+encodeURIComponent(document.location.href);
	}
}

function getCookie(c_name) {
	var i,x,y,ARRcookies=document.cookie.split(";");
	for(i=0;i<ARRcookies.length;i++) {
		x = ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
		y = ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
		x = x.replace(/^\s+|\s+$/g,"");
		if(x==c_name) {
			return unescape(y);
		}
	}
}

function setCookie(c_name, value, exdays) {
	var exdate=new Date();
	exdate.setDate(exdate.getDate() + exdays);
	var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
	c_value += "; domain=" + document.domain;
	c_value += "; path=/ ";

	document.cookie=c_name + "=" + c_value;
}

// 최근본 상품의 개수를 구함
function getResentCnt() {
	var resentListStr = getCookie("resentList");
	var resentListStrAry = null;
	var rtnValue = 0;
	
	if(resentListStr!=null) {
		resentListStrAry = resentListStr.split(",");
		if(resentListStrAry!=null) {
			try {
				for(var i=0; i<resentListStrAry.length; i++) {
			
					if(resentListStrAry[i].length>0) {
						rtnValue++;
					}
				}
			} catch(e) {}
		}
	}
	
	return rtnValue;
}

function loadResentZzimCnt() {
	// 최근 본 상품 개수 세팅
	var myTodayGoodsCnt = getResentCnt();
	setCookie("resentCnt", myTodayGoodsCnt, 365);

	if(IsLogin()) {
		var loadUrl = "/mobilenew/ajax/resentZzim/resentZzimCnt_ajax.jsp";

		$.getJSON(loadUrl, null, function(data) {
			// 찜 상품 개수 세팅
			var myZzimGoodsCnt = data["myZzimGoodsCnt"];
			setCookie("zzimCnt", myZzimGoodsCnt, 365);
			
		});
	} else {
		setCookie("zzimCnt", "0", 365);
	}
}

// 쿠키에 최근본 상품 찜상품 개수 세팅
loadResentZzimCnt();

<%if(strApp.equals("Y")) {%>
function loadResentImages() {
	var tempResentImgList = getCookie("resentImgList");
	//if(!(tempResentImgList===undefined) && tempResentImgList.length>0) {
	//	return;
	//}

	var resentListStr = getCookie("resentList");
	var resentListStrAry = resentListStr.split(",");
	var resentListStr2 = "";
	if(resentListStr.indexOf(",")>-1) {
		for(var i=0; i<resentListStrAry.length; i++) {
			resentListStr2 += resentListStrAry[i]+",";
			if(i>6) break;
		}
	}

	// 최근 본 상품 개수 세팅
	var myTodayGoodsCnt = getResentCnt();
	setCookie("resentCnt", myTodayGoodsCnt, 365);

	var loadUrl = "/mobilenew/ajax/resentZzim/Ajax_goodsListNew.jsp?listType=9&goodsNumList="+resentListStr2;

	$.getJSON(loadUrl, null, function(data) {
		var jsonObj = data["goodsList"];
		var resentImgList = "";

		$.each(jsonObj, function(indexI, listObj) {
			var modelno = listObj["modelno"];
			var p_pl_no = listObj["p_pl_no"];
			var middleImageUrl = listObj["middleImageUrl"];
			var itemStr = "";

			if(modelno=="0") {
				itemStr = "P"+p_pl_no+"|"+middleImageUrl;
			} else {
				itemStr = "G"+modelno+"|"+middleImageUrl;
			}

			resentImgList += itemStr + ",";
		});

		setCookie("resentImgList", resentImgList, 365);

		if(window.android){
			window.android.onCookieUpdate();
		} else {
			//window.location = "appcall://reloadResent";
			$("hFrame").location = "appcall://reloadResent";
		}
	});
}

// 쿠키에 최근본 상품 찜상품 개수 세팅
loadResentImages();

function delResentApp(goodsCode) {
	var prodectStr = "";
	var resentListStr = getCookie("resentList");

	if(goodsCode.indexOf("G")>-1) {
		prodectStr = "G:" + goodsCode.substring(1) + ",";
	}
	if(goodsCode.indexOf("P")>-1) {
		prodectStr = "P:" + goodsCode.substring(1) + ",";
	}
	if(resentListStr.indexOf(prodectStr)>-1) {
		resentListStr = resentListStr.split(prodectStr).join("");
	}

	setCookie("resentList", resentListStr);

	loadResentImages();
}

// procType = 2 : 오토로그인 하기
// procType = 3 : 오토로그인 해제
function setAutoLogin(procType) {
	var url = "/mobilenew/ajax/login/setAutoLogin_ajax.jsp";
	var param = "procType="+procType;

	$.ajax({
		type : "post",
		url : url,
		data : param, 
		dataType : "html",
		success : function(ajaxResult) {
			/*
			if(procType==2) {
				IsAutoLogin = true;
			}
			if(procType==3) {
				IsAutoLogin = false;
			}
			*/
			document.locaction.reload();
		}
	});
}

// 오토로그인 확인
//var IsAutoLogin = <%=isLogintop_AutoLoginOk%>;
function IsAutoLogin() {
/*
	var myinfoCookie = getCookie("MYINFO");
	var myinfoCookieAry = myinfoCookie.split("&");

	var autologinFindInt = 0;
	for(var i=0; i<myinfoCookieAry.length; i++) {
		if(myinfoCookieAry[i].indexOf("AUTOLOGIN=Y")>-1) {
			autologinFindInt++;
		}
		if(myinfoCookieAry[i].indexOf("AUTOLOGINID=")>-1 && myinfoCookieAry[i].length>15) {
			autologinFindInt++;
		}
	}
	if(autologinFindInt==2) return true;
	else return false;
*/
	return <%=IsAutoLogin%>;
}
<%}%>

// G+MODELNO, P+PLNO 를 이용해서 상품창 이동하는 함수
function moveGoodsPage(goodsCode) {
	if(goodsCode.indexOf("G")>-1) {
		document.location.href = "/mobilenew/detail.jsp?modelno="+goodsCode.substring(1);
	}

	if(goodsCode.indexOf("P")>-1) {
		var url = "/mobilenew/ajax/resentZzim/getPlno_infos_ajax.jsp";
		var param = "plno="+goodsCode.substring(1);

		$.ajax({
			type : "post",
			url : url,
			data : param, 
			dataType : "json",
			success : function(result) {
				var shop_code = result["shop_code"];
				var url = result["url"];

				document.location.href = url;
			}
		});
	}
}

// 로딩중 시작
function loadingStart() {
	<%if(!strApp.equals("Y")) {%>
	$(".nowloading").css("display", "block");
	<%}%>
}

// 로딩중 끝
function loadingEnd() {
	<%if(!strApp.equals("Y")) {%>
	$(".nowloading").css("display", "none");
	<%}%>
}


// 뒤로 가기
function goHistoryBack() {
	<%if(strApp.equals("Y")) {%>
		if(window.android) {
			window.android.onBack();
		} else {
			document.location = "appcall://prev";
		}
	<%} else {%>
		history.back(-1);
	<%}%>
}


-->
</script>
<iframe id="hFrame" style="width:0px;height:0px;position:absolute;visibility:hidden;" frameborder="0" vspace="0" hspace="0" scrolling="no"></iframe> 