<%@ page contentType="text/html; charset=utf-8"%>
<%
cb = new CookieBean(request.getCookies());		//쿠키빈을 Default로 생성한다.
String isAdult = ChkNull.chkStr(cb.GetCookie("MEM_INFO","ADULT"), "");

String strEdReqUrl = ChkNull.chkStr(request.getRequestURL().toString(), "");
String strEdUserIp = ConfigManager.szConnectIp(request);
String strEdShopImg = ConfigManager.IMG_ENURI_COM;
String strReferer = ChkNull.chkStr(request.getHeader("REFERER"),"");

String strEp = ChkNull.chkStr(request.getParameter("ep"),"");	//1:LP , 2:SRP
String strEk = ChkNull.chkStr(request.getParameter("ek"),"");	//ep=1 (cate), ep=2 (keyword)

if (strReferer.indexOf("%u") >= 0 || strReferer.indexOf("%20") >= 0){
	strReferer = CvtStr.unescape(strReferer);
	
}else if(strReferer.indexOf("%25") >= 0){
	strReferer = CvtStr.unescape(CvtStr.unescape(strReferer));
}
%>
<script language="JavaScript"> 
	//공용 변수(URL정보, 사용자IP, Enuri 이미지 URL)
	var varEDSearchPage = "<%= strEdReqUrl %>";
	var varEDUserIp = "<%= strEdUserIp %>";
	var varShopImage = "<%= strEdShopImg %>";
	
	//var varReferrer = document.referrer;
	var varReferrer = "<%=strReferer%>";
	var varKeyword = ""; 
	var varEDCateCode = "<%=strCate%>";
	var varEDKeyword = "";		//기본 키워드 변수로 사용 하기로 정함.
	
	var varEp = "<%=strEp %>";
	var varEk = "<%=strEk %>";
	
	/*
	//alert("varReferrer>>>"+varReferrer);
	//alert("varKeyword1>>>"+varKeyword);
	if(( varReferrer.indexOf("search.jsp")> -1 && varReferrer.indexOf("keyword=")> -1) || ( varReferrer.indexOf("list.jsp")> -1 && varReferrer.indexOf("from=search")> -1)){
		varKeyword = varReferrer.substring(varReferrer.indexOf("keyword=")+8,varReferrer.length);
		
		if(varKeyword.indexOf("&") > -1){
			varKeyword = varKeyword.substring(0,varKeyword.indexOf("&"));
		} 
		
		//alert("varKeyword3>>>"+varKeyword);
	}else if(varReferrer.indexOf("list.jsp")> -1 && varReferrer.indexOf("cate=")> -1){
		varEDCateCode = varReferrer.substring(varReferrer.indexOf("cate=")+5,varReferrer.length);
		if(varEDCateCode.indexOf("&") > -1){
			varEDCateCode = varEDCateCode.substring(0,varEDCateCode.indexOf("&"));
		}
	}else{
		varEDCateCode = varEDCateCode;
	}
 
	var varEDKeyword = "";		//기본 키워드 변수로 사용 하기로 정함.
	
	var varSrpKeyword = varKeyword; 

	if (varReferrer.indexOf("/mobilefirst/search.jsp") > -1  || ( varReferrer.indexOf("list.jsp")> -1 && varReferrer.indexOf("from=search")> -1) ) {		//search/EnuriSearch.jsp 용 키워드 값
		varEDKeyword = decodeURIComponent(varSrpKeyword);
	}  
	*/
	if(varEp == "1"){
		varEDCateCode = varEk;
	}else if(varEp == "2"){
		varEDKeyword = varEk;
	}
	 
	//성인 상품 노출 위해 인증여부 변수
	var varIsAdult = "<%=isAdult %>";
	
	//운영서버 체크 위한 구문
	var varEdIsReal = false;  
	if (varEDSearchPage.indexOf("www.enuri.com") > -1 || varEDSearchPage.indexOf("m.enuri.com") > -1) {
		varEdIsReal = true;
	}
	
	//varEDCateCode = "0405";
	
</script>
<!-- 최신 버젼의 jquery 사용 및  alias 설정 : 최신버젼의 jquery를 사용하되 다른 페이지에 영향력 없도록 alias 설정-->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script>
var jq11 = jQuery.noConflict();  
</script> 
<!-- 플러스링크 추가--> 
<%	//해당 페이지가 아닌 경우 불필요한 HTML 미적용
	if (strEdReqUrl.indexOf("/mobilefirst/detail.jsp") > -1) {
%>   
	<h3 class="pluslink_tit" style="display:none;">플러스링크 AD</h3>
	<ul class="prodList">
		<li id="plusLinkGoodsItemCron"  class="pluslink_goods_list" style="display:none;"> 
			<a href="javascript:;" class="listarea"> 
				<span class="pluslink">플러스링크 AD</span><!-- 150605 플러스링크 -->
				<span class="thum"><img src="http://photo3.enuri.com/data/images/service/middle/7868000/7868054.jpg" alt="" id="img_11819835" width="100%" /></span>
				<div>
					<span class="best">최우수판매자</span><!-- 150605 최우수판매자 -->
					<span class="best_mall"><img src="http://img.enuri.info/images/board/big/logo_57b.gif" alt="현대Hmall"></span><!-- 150605 최우수판매자 -->
					<strong class="name">[르샵] 카라 라쿤퍼(Fur) [르샵] 카라 라쿤퍼(Fur) [르샵] 카라 라쿤퍼(Fur) [르샵] 카라 라쿤퍼(Fur)</strong>
					<em class="delivery">무료배송</em><!-- 150605 -->
					<span class="price"><span class="min">추가할인가</span> <em>279,000<em>원</em></em></span>
				</div>
			</a>  
		</li>  
	</ul>
<!-- //플러스링크 추가--> 
<script type="text/javascript" src="/mobilefirst/edplatform/edplatform_mobile_vip.js"></script>
<%
}
%>