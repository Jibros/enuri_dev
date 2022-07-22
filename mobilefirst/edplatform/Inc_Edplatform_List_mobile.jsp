<%@ page contentType="text/html; charset=utf-8"%>
<%
cb = new CookieBean(request.getCookies());		//쿠키빈을 Default로 생성한다.
String isAdult = ChkNull.chkStr(cb.GetCookie("MEM_INFO","ADULT"), "");

String strEdReqUrl = ChkNull.chkStr(request.getRequestURL().toString(), "");
String strEdUserIp = ConfigManager.szConnectIp(request);
String strEdShopImg = ConfigManager.IMG_ENURI_COM;
%>
<script language="JavaScript"> 
	//공용 변수(URL정보, 사용자IP, Enuri 이미지 URL)
	var varEDSearchPage = "<%= strEdReqUrl %>";
	var varEDUserIp = "<%= strEdUserIp %>";
	var varShopImage = "<%= strEdShopImg %>";
	
	//Listbody_Mp3.jsp 용 변수 선언 (카테고리코드, 키워드)
	var varEDCateCode = "<%= strCate %>";
	var varEDKeyword = "";		//기본 키워드 변수로 사용 하기로 정함.
	
	//EnuriSearch.jsp 용 변수 선언 (키워드) - SRP는 카테고리 검색이 없으므로, 키워드만 받아서 사용한다. 
	var varSrpKeyword = "<%= strKeyword %>";		//searchList Keyword Param
	var varSrpKeyword2 = "<%= strSKeyword %>";
	
	 if (varEDSearchPage.indexOf("/mobilefirst/search.jsp") > -1 && varSrpKeyword.length > 0) {		//search/EnuriSearch.jsp 용 키워드 값  : 일반적인 검색일때
		varEDKeyword = varSrpKeyword;
	} else if (varEDSearchPage.indexOf("/mobilefirst/list.jsp") > -1 && $(".search_mnt")) {	//search/EnuriSearch.jsp 용 키워드 값  : 분류검색어로 검색페이지에서 넘어왔을때도 cpc 검색 로직을 태움
		varEDKeyword = varSrpKeyword2;
	}
 

	//성인 상품 노출 위해 인증여부 변수
	var varIsAdult = "<%= isAdult %>";
	
	//운영서버 체크 위한 구문
	var varEdIsReal = false; 
	if (varEDSearchPage.indexOf("www.enuri.com") > -1 || varEDSearchPage.indexOf("m.enuri.com") > -1) {
		varEdIsReal = true;
	}
</script>
<!-- 최신 버젼의 jquery 사용 및  alias 설정 : 최신버젼의 jquery를 사용하되 다른 페이지에 영향력 없도록 alias 설정-->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script>
var jq11 = jQuery.noConflict();  
</script> 
<!-- 플러스링크 추가--> 
<%	//해당 페이지가 아닌 경우 불필요한 HTML 미적용
	if (strEdReqUrl.indexOf("/mobilefirst/list.jsp") > -1 || strEdReqUrl.indexOf("/mobilefirst/search.jsp") > -1) {
%>   
	<li id="plusLinkGoodsItemCron"  class="pluslink_goods_list" style="display:none;"> 
		<a href="javascript:;" class="listarea"> 
			<span class="pluslink">플러스링크 AD</span><!-- 150605 플러스링크 -->
			<span class="thum"><img src="http://img.enuri.info/images/blank.gif" alt="" id="img_11819835" width="100%" /></span>
			<div>
				<span class="best">최우수판매자</span><!-- 150605 최우수판매자 -->
				<span class="best_mall"><img src="http://img.enuri.info/images/blank.gif" onerror="this.src='http://img.enuri.info/images/blank.gif'" alt="현대Hmall"></span><!-- 150605 최우수판매자 -->
				<strong class="name cpc"></strong> 
				<em class="delivery"></em><!-- 150605 -->
				<span class="price"><span class="min">추가할인가</span> <em><em></em></em></span>
			</div>   
		</a>  
	</li>  
<!-- //플러스링크 추가--> 
<script type="text/javascript" src="/mobilefirst/edplatform/edplatform_mobile.js"></script>
<%
}
%>