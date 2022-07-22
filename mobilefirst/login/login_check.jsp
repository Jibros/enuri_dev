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
var vCheckfirst = true;

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
			try {
				if(window.android){
					if(vCheckfirst){
						window.android.isLogin("true");
						vCheckfirst = false;
					}
				}
			} catch(e) {}
			return true;
		}else{
			try {
				if(window.android){
					window.android.isLogin("false");
				}
			} catch(e) {}
			return false;
		}
	}else{
		try {
			if(window.android){
				window.android.isLogin("false");
			}	
		} catch(e) {}
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
	document.location.href = "/mobilefirst/login/login.jsp?app=<%=strApp%>&backUrl="+encodeURIComponent(document.location.href);
	return false;
}

// 성인 인증 로그인 링크
function goALogin() {
	document.location.href = "/mobilefirst/login/adult.jsp?app=<%=strApp%>&backUrl="+encodeURIComponent(document.location.href);
}

// 회원가입 링크
function goJoin() {
	document.location.href = "/mobilefirst/login/join.jsp?app=<%=strApp%>&backUrl="+encodeURIComponent(document.location.href);
}

// 회원수정 링크
function goModify() {
	document.location.href = "/mobilefirst/login/modify.jsp?app=<%=strApp%>&backUrl="+encodeURIComponent(document.location.href);
}

// 로그인 후에 찜함 링크
function goLoginZzim(modelno) {
	var locStr = document.location.href;
	if(locStr.indexOf("&zzimModelno")>-1) {
		locStr = locStr.substring(0,locStr.indexOf("&zzimModelno")); 
	}

	document.location.href = "/mobilefirst/login/login.jsp?app=<%=strApp%>&backUrl="+encodeURIComponent(locStr+"&zzimModelno="+modelno);
}

// 로그아웃 링크
function goLogout() {
	<%if(!strApp.equals("Y")) {%>if(confirm("로그아웃 하시겠습니까?")) {<%}%>
		var url = "/mobilefirst/ajax/login/logout_ajax.jsp";
		var param = "";

		$.ajax({
			type : "post",
			url : url,
			data : param, 
			dataType : "html",
			success : function(ajaxResult) {
				var nowUrl = document.location.href;
				
				if(nowUrl.indexOf("/mobilefirst/resentzzim/resentzzimList.jsp?listType=2")>-1) {
					top.location.href = "/mobilefirst/Index.jsp";
				}else if(nowUrl.indexOf("/mobiledepart/resentzzim/resentzzimList.jsp?listType=2")>-1) {
						top.location.href = "/mobiledepart/Index.jsp";					
				} else {
					//top.location.reload();
					if(window.android){
						window.android.logout();
					}else{
						top.location.reload();
					}
				}
			}
		});
	<%if(!strApp.equals("Y")) {%>}<%}%>
}



// 로그아웃 링크
function goLogoutDirect() {
	
		var url = "/mobilefirst/ajax/login/logout_ajax.jsp";
		var param = "";

		$.ajax({
			type : "post",
			url : url,
			data : param, 
			dataType : "html",
			success : function(ajaxResult) {
				var nowUrl = document.location.href;
				
				if(nowUrl.indexOf("/mobilefirst/resentzzim/resentzzimList.jsp?listType=2")>-1) {
					top.location.href = "/mobilefirst/Index.jsp";
				}else if(nowUrl.indexOf("/mobiledepart/resentzzim/resentzzimList.jsp?listType=2")>-1) {
						top.location.href = "/mobiledepart/Index.jsp";					
				} else {
					//top.location.reload();
					if(window.android){
						window.android.logout();
					}else{
						top.location.reload();
					}
				}
			}
		});
	
}



// 최근본 페이지로 이동
function goResent() {
	
	ga('send', 'event', 'menu', 'click', '메뉴_최근본상품');
	document.location.href = "/mobilefirst/resentzzim/resentzzimList.jsp?listType=1";
}

// 찜 페이지로 이동
function goZzim() {
	
	ga('send', 'event', 'menu', 'click', '메뉴_찜한상품');
	
	<%if(strApp.equals("Y")) {%>
	document.location.href = "/mobilefirst/resentzzim/resentzzimList.jsp?listType=2";
	<%} else {%>
	if(IsLogin()==true) {
		document.location.href = "/mobilefirst/resentzzim/resentzzimList.jsp?listType=2";
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
		document.location.href = "/mobilefirst/login/adult.jsp?app=<%=strApp%>&backUrl="+encodeURIComponent(document.location.href);
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
		var loadUrl = "/mobilefirst/ajax/resentZzim/resentZzimCnt_ajax.jsp";

		$.getJSON(loadUrl, null, function(data) {
			// 찜 상품 개수 세팅
			var myZzimGoodsCnt = data["myZzimGoodsCnt"];
			setCookie("zzimCnt", myZzimGoodsCnt, 365);

			setTimeout("zzimCntMenuSet("+myZzimGoodsCnt+")", 1000);
		});
	} else {
		setCookie("zzimCnt", "0", 365);
	}
}

function zzimCntMenuSet(myZzimGoodsCnt) {
	try {
		$("#zzim_cnt a").html("찜 한 상품("+myZzimGoodsCnt+")");
	} catch(e) {}
}

// 쿠키에 최근본 상품 찜상품 개수 세팅
loadResentZzimCnt();

function loadResentZzimCntAnd() {
	// 최근 본 상품 개수 세팅
	var myTodayGoodsCnt = getResentCnt();
	setCookie("resentCnt", myTodayGoodsCnt, 365);

	var loadUrl = "/mobilefirst/ajax/resentZzim/resentZzimCnt_ajax.jsp";

	$.getJSON(loadUrl, null, function(data) {
		// 찜 상품 개수 세팅
		var myZzimGoodsCnt = data["myZzimGoodsCnt"];
		setCookie("zzimCnt", myZzimGoodsCnt, 365);

		if(window.android){
			window.android.onCookieUpdate();
		}
	});
}

// ***************************************************************
// IOS MyPage에서 최근본과 찜을 읽어옴 시작
// ***************************************************************

var recentListIOSStr = "";
function getRecentListIOS() {
	var resentListStr = getCookie("resentList");
	var resentListStrAry = null;
	var resentListStr2 = "";
	try {
		resentListStrAry = resentListStr.split(",");
		if(resentListStr.indexOf(",")>-1) {
			for(var i=0; i<resentListStrAry.length; i++) {
				resentListStr2 += resentListStrAry[i]+",";
			}
		}
	} catch(e) {
		resentListStr = "";
	}

	var loadUrl = "/mobilefirst/ajax/resentZzim/Ajax_goodsListNew.jsp?listType=9&goodsNumList="+resentListStr2;

	$.getJSON(loadUrl, null, function(data) {
		var jsonObj = data["goodsList"];
		var resentImgList = "";

		if(jsonObj) {
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
		}

		recentListIOSStr = resentImgList;
		document.location = "appcall:myPage=recent";

	});
}


var zzimListIOSStr = "";

function getZzimListIOS() {
	var loadUrl = "/mobilefirst/ajax/resentZzim/Ajax_goodsListNew.jsp?";
	loadUrl += "listType=2"; 
	loadUrl += "&folder_id=1&deviceType=m&pageNum=1&pageGap=10";


	$.getJSON(loadUrl, null, function(data) {
		var jsonObj = data["goodsList"];
		var itemListStr = "";
 
		
		if(jsonObj) {
			$.each(jsonObj, function(indexI, listObj) {
				
				var modelno = listObj["modelno"];
				var p_pl_no = listObj["p_pl_no"];
				var factory = listObj["factory"];
				var modelname = listObj["modelnm"];
				var minprice = listObj["minprice"];
				var middleImageUrl = listObj["middleImageUrl"];
				var smallImageUrl = listObj["smallImageUrl"];
				var minpriceText = listObj["minPriceText"];
				
				
				if(minpriceText != "")
					minprice=minpriceText;
				else 
					minprice+="원";
					
				var itemStr = "";
				
				if(modelno=="0") {
					itemStr = "P"+p_pl_no+"|"+middleImageUrl+"|"+smallImageUrl+"|"+factory+"|"+modelname+"|"+minprice;
				} else {
					itemStr = "G"+modelno+"|"+middleImageUrl+"|"+smallImageUrl+"|"+factory+"|"+modelname+"|"+minprice;
				}
				itemListStr += itemStr + "ENURI";
				
			});
		}

		zzimListIOSStr = itemListStr;
		//alert(zzimListIOSStr);
		document.location = "appcall:myPage=zzim";
	});
}

//***************************************************************
//IOS MyPage에서 최근본과 찜을 읽어옴 끝
//***************************************************************


function loadResentImages() {
	//alert("mobilefirst");
	
	var tempResentImgList = getCookie("resentImgList");
	
	var resentListStr = getCookie("resentList");
	var resentListStrAry = null;
	var resentListStr2 = "";
	try {
		resentListStrAry = resentListStr.split(",");
		if(resentListStr.indexOf(",")>-1) {
			for(var i=0; i<resentListStrAry.length; i++) {
				resentListStr2 += resentListStrAry[i]+",";
				if(i>=10) break;
			}
		}
	} catch(e) {
		resentListStr = "";
	}

	// 최근 본 상품 개수 세팅
	var myTodayGoodsCnt = getResentCnt();
	setCookie("resentCnt", myTodayGoodsCnt, 365);

	var loadUrl = "/mobilefirst/ajax/resentZzim/Ajax_goodsListNew.jsp?listType=9&goodsNumList="+resentListStr2;
	
	$.getJSON(loadUrl, null, function(data) {
		var jsonObj = data["goodsList"];
		var resentImgList = "";

		
		if(jsonObj) {
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
		}		
		setCookie("resentImgList", resentImgList, 365);
		//alert("3 "+getCookie("resentImgList"));
		<%if(strApp.equals("Y")) {%>
			if(window.android){
				//alert(resentImgList);
				window.android.onCookieUpdate();
			} else {
				/*
				if(navigator.userAgent.indexOf("Android") >= 0){
				}else{
					var nowUrl = document.location.href;
					if(nowUrl.indexOf("trend_news.jsp")>-1 || nowUrl.indexOf("best_list.jsp")>-1 || nowUrl.indexOf("plan_event.jsp")>-1) {
					} else {
						var nowUrl = document.location.href;
						if(nowUrl.indexOf("mobilenew/Index.jsp")>-1) {
							setTimeout("reloadResentCall()", 500);
						} else {
							setTimeout("reloadResentCall()", 100);
						}
					}
				}
				*/
			}
		<%}%>
	});
}

function reloadResentCall() {
	//window.location = "appcall://reloadResent";
}

// 쿠키에 최근본 상품 찜상품 개수 세팅
loadResentImages();

function delResentApp(goodsCode) {
	//alert("first");
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
	//alert("1 "+getCookie("resentList"));
	setCookie("resentList", resentListStr);
	//alert("2 "+getCookie("resentList"));
	loadResentImages();
}

// procType = 2 : 오토로그인 하기
// procType = 3 : 오토로그인 해제
function setAutoLogin(procType) {
	var url = "/mobilefirst/ajax/login/setAutoLogin_ajax.jsp";
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
//var IsAutoLogin = ;
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

if(window.android){
	window.android.getLoginID(strID);
}


// G+MODELNO, P+PLNO 를 이용해서 상품창 이동하는 함수
function moveGoodsPage(goodsCode) {
	if(goodsCode.indexOf("G")>-1) {
		document.location.href = "/mobilefirst/detail.jsp?modelno="+goodsCode.substring(1);
	}

	if(goodsCode.indexOf("P")>-1) {
		var url = "/mobilefirst/ajax/resentZzim/getPlno_infos_ajax.jsp";
		var param = "plno="+goodsCode.substring(1);
		var resultChk = false;
		var newUrl = "";
		
		$.ajax({
			type : "post",
			url : url,
			data : param, 
			async : false,
			dataType : "json",
			success : function(result) {
				var shop_code = result["shop_code"];
				var ca_code = result["ca_code"];
				var pl_no = result["pl_no"];
				var url = result["url"];

				if(window.android) {
					document.location.href = url;
				} else {
					//window.open(url);
					resultChk = true;
					newUrl = url;
				}

				var logParam = "cate="+ca_code+"&modelno=0&rank=&pl_no="+pl_no+"&vcode="+shop_code;
				$.ajax({
					type: "POST",
					url: "/mobilefirst/include/m4_move_log.jsp",
					data: logParam
				});

				<%if(strApp.equals("Y")) {%>
				// 찜에서 이동후 최근본에 업데이트 하기 위한 IOS로직
				if(window.android){
				} else {
					// 상품창 이동후 최근본 쿠키에 저장
					var prodectStr = "";
					var resentListStr = getCookie("resentList");

					if(goodsCode.indexOf("G")>-1) {
						prodectStr = "G:" + goodsCode.substring(1) + ",";
					}
					if(goodsCode.indexOf("P")>-1) {
						prodectStr = "P:" + goodsCode.substring(1) + ",";
					}
					// 신규 상품이 쿠키에 있는지 확인하고 삭제(순서가 틀릴수 있기때문에)
					if(resentListStr.indexOf(prodectStr)>-1) {
						resentListStr = resentListStr.split(prodectStr).join("");
					}
					// 신규 상품을 추가
					resentListStr = prodectStr + "," + resentListStr;

					// 쿠키에 저장
					setCookie("resentList", resentListStr);
					// 앱용 최근본 상품 새로 고침
					loadResentImages();
				}
				<%}%>

			}
		});
		
		if(resultChk){
			if( navigator.userAgent.indexOf("iPhone") > 0 || navigator.userAgent.indexOf("iPod") > 0 || navigator.userAgent.indexOf("iPad") > 0){
				newUrl = newUrl + "&DEVICE_BROWSER=Y";
			}
			 
			window.open(newUrl);
		}
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

<%if(strApp.equals("Y")) {%>
getRewardPoint();

var ios_point_list = "";

//reward point 검색
function getRewardPoint(){
	//alert(1);
	//document.location = "appcall://POINT=0-0";
	var nowUrl = document.location.href;
	if(nowUrl.indexOf("trend_news.jsp")>-1 || nowUrl.indexOf("best_list.jsp")>-1 || nowUrl.indexOf("plan_event.jsp")>-1) {
		return;
	}
	
	var loadUrl = "/mobilefirst/reward/reward_get_point.jsp";
	
	$.getJSON(loadUrl, null, function(data) {
		if(data) {
			var point_pre_fix = data["POINT_PRE_FIX"];
			var point_remain = data["POINT_REMAIN"];
			var revolution = data["REVOLUTION"];

			ios_point_list = revolution+"="+point_remain+"="+point_pre_fix;

			if(window.android){
				window.android.getPoint(point_remain,point_pre_fix,revolution);
			}else{
				if(navigator.userAgent.indexOf("Android") >= 0){
				}else{
					//document.location = "appcall:myPage=point";
				}
			}
			
		}		
	});
}

<%}%>

-->
</script>
