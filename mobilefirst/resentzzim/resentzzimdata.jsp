<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
	String strApp = ChkNull.chkStr(request.getParameter("app"),"");	 //	Y일때 앱

	String ConstServer = ConfigManager.ConstServer(request);

	// 1:최근본, 2:찜
	// showModelnos가 들어오면 그냥 리스트를 보여줌
	String listType = ChkNull.chkStr(request.getParameter("listType"), "1");
	String loadPageNum = ChkNull.chkStr(request.getParameter("pageNum"), "1");

	int listShowType = 1; // 2번, 3번은 리스트 형태가 똑같음
	if(listType.equals("2")) listShowType = 2;

	String showModelnos = ChkNull.chkStr(request.getParameter("showModelnos"), "");

	
	String strID = cb.GetCookie("MEM_INFO","USER_ID");

	// 검색관련 변수 선언
	HttpSession Mobilesession = request.getSession(true);
	
	String strAppRZ = ChkNull.chkStr(request.getParameter("app"),"");	 //	Y일때 앱
	
	
	
	
%>
<html>
<head>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/mustache.js"></script>
<script type="text/javascript" src="/mobilefirst/js/resentzzimStorage.js"></script>
<script type="text/javascript" src="/mobilefirst/js/utils.js"></script>
<%-- <%@ include file="/mobilefirst/include/common.html"%> --%>
<%@ include file="/mobilefirst/login/login_check.jsp"%>
</head>
<body>
<script language="JavaScript">
if(window.android)
{
	
	loadZzimListAnd();
	//IsLogin();
	function loadZzimListAnd() {
		var loadUrl = "/mobilefirst/ajax/resentZzim/Ajax_goodsListNew.jsp?listType=2&folder_id=1&deviceType=m&pageNum=1&pageGap=10";
		
		$.getJSON(loadUrl, null, function(data) {
			var jsonObj = data["goodsList"];
			//alert(jsonObj);
			
			var resentImgList = data["myGoodsTotalCnt"]+"ENURI";
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
					//alert(modelname);
					if(modelno=="0") {
						itemStr = "P"+p_pl_no+"|"+middleImageUrl+"|"+smallImageUrl+"|"+factory+"|"+modelname+"|"+minprice;
					} else {
						itemStr = "G"+modelno+"|"+middleImageUrl+"|"+smallImageUrl+"|"+factory+"|"+modelname+"|"+minprice;
					}
					resentImgList += itemStr + "ENURI";
					//alert(resentImgList);
				});
			}
			
			if(window.android)
			{
				//alert(resentImgList);
				window.android.onZzimListAnd(resentImgList);
			}
		});
	}
}
</script>
</body>
</html>

