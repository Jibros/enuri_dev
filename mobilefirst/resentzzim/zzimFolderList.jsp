<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
     String ConstServer = ConfigManager.ConstServer(request);
     String strID = cb.GetCookie("MEM_INFO","USER_ID");
     // 검색관련 변수 선언
     HttpSession Mobilesession = request.getSession(true);
     String strAppRZ = ChkNull.chkStr(request.getParameter("app"),"");  //  Y일때 앱
     String strApp = strAppRZ;
     // 만약 로그인이 안되어 있고 listType = "2"; 일경우는 로그인페이지로 이동함
     if(strID.length()==0) {
          response.sendRedirect("/mobilefirst/login/login.jsp?backUrl=/mobilefirst/resentzzim/resentzzimList.jsp?listType=2&app="+strAppRZ);
           return;
     }
%>
<%   
Cookie[] carr = request.getCookies();
String strAppyn = "";
String strVerios = "";
String strVerand = "";
String strAd_id = "";
int intVerios = 0;
int intVerand = 0;
try {
    for(int i=0;i<carr.length;i++){
        if(carr[i].getName().equals("appYN")){
            strAppyn = carr[i].getValue();
            break;
        }
    }
    for(int i=0;i<carr.length;i++){
        if(carr[i].getName().equals("verios")){
            strVerios = carr[i].getValue();
            break;
        }
    }
    for(int i=0;i<carr.length;i++){
        if(carr[i].getName().equals("verand")){
            strVerand = carr[i].getValue();
            break;
        }
    }
    for(int i=0;i<carr.length;i++){
        if(carr[i].getName().equals("adid")){
            strAd_id = carr[i].getValue();
            break;
        }
    }
} catch(Exception e) {
}
int i_Log = 5941;
int i_Log_pad = 0;
if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0){
      i_Log = 5940;
}else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0){
      i_Log = 5939;
}else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0){
      i_Log = 5939;
      i_Log_pad = 1;
}else{
      i_Log = 5941;
}
if(!strVerios.equals("")){
      intVerios = Integer.parseInt(strVerios.replace(".",""));
}
if(!strVerand.equals("")){
      intVerand = Integer.parseInt(strVerand.replace(".",""));
}
boolean blTopbar_show = true;
if(strAppyn.equals("Y")){
	if(i_Log == 5940){
	     if(intVerand >= 320){
	          blTopbar_show = false;
	     }
	}else if(i_Log == 5939){
	  if(intVerios >= 32000){
	      blTopbar_show = false;
	  }
	}
}
%>
<!DOCTYPE html> 
<html lang="ko">
<head>
	<title>에누리(가격비교) eNuri.com</title>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />	
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<%@ include file="/mobilefirst/renew/include/common.html" %>
    <script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/utils.js"></script>
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/default.css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/lp.css"/>
</head>
<body>

<div id="main">
     <% if(strApp.equalsIgnoreCase("Y")){ %>
     <% }else{  %>
           <%@include file="/mobilefirst/renew/include/gnb.html"%>
     <% } %>
	<!-- 서브 -->
	<% if(!strApp.equalsIgnoreCase("Y")){ %>
    <nav class="lp_top" id="lp_top" style="<%=(blTopbar_show)?"":"display:none" %>;">
        <h2><a href="javascript:history.back();" class="ico_m">뒤로가기</a>찜 폴더 관리</h2>
    </nav>
    <% } %>
	<!--// 서브 -->
	<!--// 헤더영역 -->
	
	<section id="container">
		<ul class="choiceFolderList">
			<!-- <li>
				<span>찜폴더1(기본)</span>	<span><strong>1건</strong>/50건</span>
			</li>
			<li>
				<span>찜폴더2</span><span><strong>0건</strong>/50건</span><button id="folderDel2" type="button" class="btnTxt folderDelBtn">삭제</button>
			</li> -->
		</ul>
		<div class="btnWrap2">
			<button id="folderAddBtn" type="button" class="btnTxt" style="width:90px;">폴더추가</button>
		</div>
	</section>

<!-- 파워링크 -->
<div id="adLinkList"></div>
</div>	
<%@ include file="/mobilefirst/login/login_check.jsp"%>
<%@include file="/mobilefirst/include/common_logger.html"%>
<%@ include file="/mobilefirst/renew/include/footer.jsp"%>
</body>
<script src="/mobilefirst/js/lib/mustache.js"></script>
<script type="text/javascript" src="/mobilefirst/js/resentzzimStorage.js"></script>
<script type="text/javascript" src="/mobilefirst/js/zzimFolderManage.js"></script>
</html>
