<%@ include file="/login/Inc_AutoLoginSet_2010.jsp"%><%
	String loginCheck_strID = cb.GetCookie("MEM_INFO","USER_ID");
//	boolean loginCheckTimeTic = false;
//	if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0) {
//		loginCheckTimeTic
//	}
	HttpSession MobilesessionCheck = request.getSession(true);
	String strEnuriAppCheck = ChkNull.chkStr((String)MobilesessionCheck.getAttribute("enuriApp"),"");
	String checkApp = strEnuriAppCheck;
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
			return true;
		}else{
			return false;
		}
	}else{
		return false;
	}

//	if(strID.length>0) return true;
//	else return false;
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

//	if(strID.length>0) return true;
//	else return false;
}

//alert("111="+document.cookie);

// 로그인 링크
function goLogin() {
	document.location.href = "/mobile2/login/login.jsp?enuriApp=<%=checkApp%>&backUrl="+encodeURIComponent(document.location.href);
}

// 로그인 후에 찜함 링크
function goLoginZzim(modelno) {
	var locStr = document.location.href;
	if(locStr.indexOf("&zzimModelno")>-1) {
		locStr = locStr.substring(0,locStr.indexOf("&zzimModelno")); 
	}

	document.location.href = "/mobile2/login/login.jsp?enuriApp=<%=checkApp%>&backUrl="+encodeURIComponent(locStr+"&zzimModelno="+modelno);
}

// 로그아웃 링크
function goLogout() {
	if(confirm("로그아웃 하시겠습니까?")) {
		var url = "/mobilefirst/ajax/login/logout_ajax.jsp";
		var param = "";

		$.ajax({
			type : "post",
			url : url,
			data : param, 
			dataType : "html",
			success : function(ajaxResult) {
				document.location.reload();
				// 무조건 메인으로
				//CmdLocation('index');
			}
		});
	}
}

// 최근본 페이지로 이동
function goResent() {
	document.location.href = "/mobile2/resentzzim/resentzzimList.jsp?enuriApp=<%=checkApp%>&listType=1";
}

function getResentCnt() {
	var loadGoodsList = "";
	listGoodsCnt = 0;

	loadGoodsList = getGoodsListStorage("resentList");

	if(loadGoodsList!=null && loadGoodsList.length>0) {
		var tempGoodsAry = loadGoodsList.split(",");
		for(var i=0; i<tempGoodsAry.length; i++) {
			if(tempGoodsAry[i].length>0) {
				listGoodsCnt++;
			}
		}
	}

	return listGoodsCnt;
}

// 찜 페이지로 이동
function goZzim() {
	if(IsLogin()==true) {
		document.location.href = "/mobile2/resentzzim/resentzzimList.jsp?enuriApp=<%=checkApp%>&listType=2";
	} else {
		if(confirm("로그인 하시겠습니까?")) {
			goLogin();
		}
	}
}

// 성인인증 링크
function goAdult() {
	if("<%=checkApp%>"!="Y") {
		if(confirm("청소년 유해 키워드가 포함된 상품이므로\n성인인증이 필요합니다.")) {
			document.location.href = "/mobile2/login/login.jsp?enuriApp=<%=checkApp%>&pageType=3&backUrl="+encodeURIComponent(document.location.href);
		}
	}
}

// 아이폰일 경우에는 로그인 체크를 매순간 해야함
function loginCheckChange() {
	try {
		var loginText = "";
		if(IsLogin()) {
			loginText = "로그아웃";
		} else {
			loginText = "로그인";
		}

		$("#islogin").html(loginText);
	} catch(e) {}

	setTimeout("loginCheckChange()", 2000);
}

setTimeout("loginCheckChange()", 2000);

-->
</script>
