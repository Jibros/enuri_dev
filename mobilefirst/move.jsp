<%@page import="com.enuri.bean.member.Login_Proc"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%@ page import="com.enuri.bean.main.Shoplist_Data"%>
<%@ page import="com.enuri.bean.main.Shoplist_Proc"%>
<jsp:useBean id="Shoplist_Data" class="com.enuri.bean.main.Shoplist_Data"  />
<jsp:useBean id="Shoplist_Proc" class="com.enuri.bean.main.Shoplist_Proc"  />
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<jsp:useBean id="Goods_Proc" class="com.enuri.bean.main.Goods_Proc" scope="page" />
<jsp:useBean id="Pricelist_Data" class="com.enuri.bean.main.Pricelist_Data" scope="page" />
<jsp:useBean id="Pricelist_Proc" class="com.enuri.bean.main.Pricelist_Proc" scope="page" />
<%@ page import="com.enuri.bean.lsv2016.Coupon_Layer_Proc"%>
<jsp:useBean id="Coupon_Layer_Proc" class="com.enuri.bean.lsv2016.Coupon_Layer_Proc" scope="page" />
<%@ page import="com.enuri.bean.main.Plno_Clickout_Proc"%>
<jsp:useBean id="Plno_Clickout_Proc" class="com.enuri.bean.main.Plno_Clickout_Proc" />
<%
int szVcode				= ChkNull.chkInt(request.getParameter("vcode"),0);
String strUrl				= ChkNull.chkStr(request.getParameter("url"),"");
String strCh				= ChkNull.chkStr(request.getParameter("ch"),"");	//시분초
long lngPlno 				= ChkNull.chkLong(request.getParameter("plno"),0);
String strFrom				= ChkNull.chkStr(request.getParameter("from"),"");
String strSb				= ChkNull.chkStr(request.getParameter("sb"),"");
String strTp				= ChkNull.chkStr(request.getParameter("tp"),"");

try{	//전체오류나면 그냥 URL 센딩.                 
	
Pricelist_Data pricelist_data = Pricelist_Proc.getData_Plno(lngPlno);

String strCa_code = "";
int intModelno = 0;
String strPlGoodsNmM = "";
int intCoupon = 0; 
int intPrice = 0;
String strEpImgUrl = "";
String strImageUrl = "";
String strGoodNm = "";
String strFactory = "";
String strBrand = "";
String[] strFbn = null;
String strViewGoodsNm = "";
String strAdult = cb.GetCookie("MEM_INFO", "ADULT");
String strId = cb.GetCookie("MEM_INFO","USER_ID");

//최저가 표시방법 변경
String strMin_deliveryinfo = "";
int intMin_deliveryType2 = 0;
int intMin_deliveryInfo2 = 0;
String strGoodsDeliveryInfoTxt = "";
//일반상품 클릭아웃체크
long lngMin_price = 0;
int intMin_Modelno = 0;
String strMinCa_code = "";

if(pricelist_data != null){
	strCa_code = pricelist_data.getCa_code();
	intModelno = pricelist_data.getModelno();
	strPlGoodsNmM = pricelist_data.getGoodsnm();
	intCoupon = pricelist_data.getCoupon();
	strEpImgUrl = pricelist_data.getImgurl();
	intPrice = (int)pricelist_data.getInstance_price();
	szVcode = (int)pricelist_data.getShop_code();
	
	if(strSb.equals("F") || strTp.equals("Y") || strUrl.equals("")  ){ //strTp 은 pc 트렌트 픽업 관리자에서 넘기는 값이다
		strUrl = pricelist_data.getUrl();
		strUrl = toUrlCode(strUrl); 
	}
	
	//해외직구 상품일경우 몰리 게이트 페이지로 전달
    //2019-11-07 shwoo
    if(",8446,8447,8448,8826,8827,8828,8829,".indexOf(","+szVcode+",") > -1){
    	//업체 맵핑
    	String strOvsShopcode = "";
    	if(szVcode == 8446)	strOvsShopcode = "1739";
    	if(szVcode == 8447)	strOvsShopcode = "440";
    	if(szVcode == 8448)	strOvsShopcode = "1270";
    	if(szVcode == 8826)	strOvsShopcode = "7650";
    	if(szVcode == 8827)	strOvsShopcode = "782";
    	if(szVcode == 8828)	strOvsShopcode = "469";
    	if(szVcode == 8829)	strOvsShopcode = "7714";
    	
    	String strShop_url = "/global/m/portal.jsp?muid="+strOvsShopcode+"&url="+strUrl +"&from=en";
        response.setStatus(301);
        response.setHeader("Location",strShop_url);
        response.setHeader("Connection", "close");
    }
	//2022.01.04 성인카테 변경 1640->163630
	//CutStr.cutStr(strCate,4).equals("1640") -> (CutStr.cutStr(strCate,6).equals("163630")
 	 if((CutStr.cutStr(strCa_code,4).equals("1640") || CutStr.cutStr(strCa_code,6).equals("163630") || CutStr.cutStr(strCa_code,6).equals("931004") || CutStr.cutStr(strCa_code,6).equals("051523")  || CutStr.cutStr(strCa_code,6).equals("051513") ) && !strAdult.equals("1")){ //성인용품+미성년or인증안됨(true:성인, false: 미성년)
	 	 strEpImgUrl = ConfigManager.IMG_ENURI_COM +"/images/home/thumb_adult_300.jpg";
     }
	 if(intModelno>0) {
	    	//최저가 보여주는 로직 변경.
	    	//최저가에 배송비 유무 로직 추가.
	    	//Pricelist_Data objPricelistData = Pricelist_Proc.get_Vip_minpricedata(intModelno);
	    	
	    	Goods_Data goods_data = Goods_Proc.Goods_One(intModelno,0);
	    	
	    	//goods_data null check
	    	if(goods_data !=null){
	    		//모델명 치환 규칙 적용
		    	strGoodNm = goods_data.getModelnm();
		    	strFactory = goods_data.getFactory();
		    	strBrand = goods_data.getBrand();
		    	strFbn = getModel_FBN(strCa_code, strGoodNm, strFactory, strBrand);
		    	strViewGoodsNm = strFbn[1] + " "+ strFbn[2] + " "+ strFbn[0];
		    	strViewGoodsNm = strViewGoodsNm.replace("  "," ");
		    	if(strAdult.equals("1")) {
					goods_data.setAdultChk(true);
				} else {
					// 성인구분 넣어줘야함
					goods_data.setAdultChk(false);
				}
				strImageUrl = ImageUtil_lsv.getImageSrc(goods_data);
				if (strImageUrl.indexOf(ConfigManager.PHOTO_ENURI_COM) > -1) {
					strImageUrl = strImageUrl.replace(ConfigManager.PHOTO_ENURI_COM, ConfigManager.PHOTO_ENURI_CDN_COM);
				}
	    	}
		 }
	 
	 
	 if(lngPlno>0) {
		Pricelist_Data objPricelistData = Pricelist_Proc.getData_Delivery(lngPlno);
    	
		if(objPricelistData != null){
    		strMin_deliveryinfo = objPricelistData.getDeliveryinfo();
    		intMin_deliveryType2 = objPricelistData.getDeliverytype2();
    		intMin_deliveryInfo2 = objPricelistData.getDeliveryinfo2();
    		lngMin_price = objPricelistData.getPrice_long();
    		intMin_Modelno = objPricelistData.getModelno();
    		strMinCa_code = objPricelistData.getCa_code();
    		
    		String strLcate = "";
    		String strMcate = "";
    		
    		if(strMinCa_code.length()>=4){
            	strLcate = strMinCa_code.substring(0,2);
                strMcate = strMinCa_code.substring(0,4);
            }
    		
    		// deliveryType2==0 : 배송비 정보가 불명확함
    		// deliveryType2==1 : 배송비 정보가 정확학
    		// 배송비 정보는 deliveryInfo2에 들어 있으며
    		// deliveryInfo2==0 이면 무료배송
    		// deliveryInfo의 정보는 배송비가 정해지는 규칙이 들어 있음(업체에서 입력)
    		
    		if(strMin_deliveryinfo.equals("무료배송")){
    			strGoodsDeliveryInfoTxt = "(무료배송)";
    		} else {
    			if(intMin_deliveryType2 == 0) {
    				if (strMin_deliveryinfo.equals("")) {	//유무료
    					strGoodsDeliveryInfoTxt = "(유무료)";
    				} else {
    					strGoodsDeliveryInfoTxt = strMin_deliveryinfo;
    				}
    			} else {
    				if(intMin_deliveryType2 == 1 && intMin_deliveryInfo2 == 0) {
    					strGoodsDeliveryInfoTxt = "(무료배송)";
    				} else {
    					strGoodsDeliveryInfoTxt = "(배송비:"+FmtStr.moneyFormat(intMin_deliveryInfo2+"")+"원)";
    				}
    			}
    		}
    		
          	//일반상품 clickout log 임시 누적 2019-05-08. shwoo
            if(lngPlno>0 && intMin_Modelno <= 0){
            	//System.out.println("lngPlno>>>"+lngPlno);
    			// (1505)커피,차, (1511)라면,통조림,즉석식품, (1635) 건전지,소방,산업, (1647)모바일쿠폰,상품권이 아닌 상품
    			//System.out.println("strMcate>>>"+strMcate);
    			if(!(strMcate.equals("1505") || strMcate.equals("1511") || strMcate.equals("1635") || strMcate.equals("2145") || strMcate.equals("1647"))){
    				//5000원 미만은 전부 or 10000원 이하면서 14,18,21 카테일때는 전부 입력
    				//System.out.println("lngMin_price>>>"+lngMin_price);
    				//System.out.println("strLcate>>>"+strLcate);
    				if(lngMin_price < 5000 || (lngMin_price <= 10000 && (strLcate.equals("14") || strLcate.equals("18") || strLcate.equals("21")))){
    					//System.out.println("!!!!!!!!!!!!!!!!!!success");
    					Plno_Clickout_Proc.plno_insert(lngPlno);					
    				}
    			}
            }

    	}
	}   	
	   
} 
Shoplist_Data sdata    = Shoplist_Proc.getData_One(szVcode);

String strShopName     = sdata.getShop_name();
String strApFlag       = sdata.getApflag();
String strEtcLogo      = sdata.getEtclogo();
String strCpc_flag     = sdata.getCpc_flag();

String strShopLogo = "";
if(strEtcLogo.trim().equals("Y")) {
    strShopLogo = "<img src=\""+ConfigManager.STORAGE_ENURI_COM+"/logo/logo20/logo_20_"+szVcode+".png\" onerror=\"$(this).replaceWith('"+strShopName+"')\">";
} else {
    strShopLogo = "<span class=\"noimg\">" + strShopName + "</span>";
}

//비타트라 로고 수동추가
if(strShopName.equals("VITATRA")){
	 strShopLogo = "<img src=\""+ConfigManager.STORAGE_ENURI_COM+"/logo/logo20/logo_20_30130.png\">";
 } 

String strType = "";
String strCate4 = "";
String strCoupon = "";
boolean blCouponflag = false;

if(!strSb.equals("")){ 
	//edplatform 에서 넘어온 값이 있으면 move 페이지 안보여주고 바로 redirect
	response.sendRedirect(strUrl);
}

if(strCate4 != null && strCate4.length()>=4 ){
	strCate4 = strCa_code.substring(0,4);
}

//쿠폰여부
if(szVcode==4027 || szVcode==536 || szVcode==663){
	strType = "2";				//case2. 모바일 제휴& 할인 자동 적용
}else if(szVcode==75  ){
	strType = "6";
}else if(szVcode==57){
	strType = "6";
}else if(szVcode==55 || szVcode==806 || szVcode==90  || szVcode==1878){
	strType = "6";				//case6. 모바일 제휴 & 쿠폰 유무를 모를 때
}else if(szVcode==5910 || szVcode==49 || szVcode==47 || szVcode==6547 || szVcode==6588  || szVcode==6603 ){
	strType = "7";				//case7. 모바일 제휴 & CTU 적용 불가
}else if(szVcode==6620){		// 특이. 갤러리아몰은 쿠폰필드 1이면 case6, 쿠폰필드0이면 case2
	if(intCoupon == 1){
		strType = "6";
	}else{
		strType = "2";
	}
}else if(szVcode==663){		// 특이. 롯데아이몰은 쿠폰필드 1이면 case5, 쿠폰필드0이면 case2
	if(intCoupon == 1){
		strType = "5";
	}else{
		strType = "2";
	}
}else if(szVcode==6665){
	if(intCoupon == 1){
		strType = "6";
	}else{
		strType = "2";
	}
}else{
	strType = "7";				//case7. 모바일 비제휴 ---> 일단 case2로...
}

if(strCate4.equals("0304") && (szVcode==806 || szVcode==663 || szVcode==55 || szVcode==57) ){
	strType = "7";
}

if(strPlGoodsNmM.indexOf("에누리") > -1 && strPlGoodsNmM.indexOf("추가할인") > -1){
	strCoupon = strPlGoodsNmM.substring(0, strPlGoodsNmM.indexOf("추가할인")+4);
	if( strCoupon.indexOf("추가할인") > strCoupon.indexOf("에누리")){
		strCoupon = strCoupon.substring(strCoupon.indexOf("에누리")+3, strCoupon.indexOf("추가할인"));
	}
}

//SSG(6665) 쿠폰 관련 (모델명에 할인문구 있을경우 케이스 추가)
if(szVcode == 6665 && strType.equals("6") && strPlGoodsNmM.indexOf("에누리") > -1 && strPlGoodsNmM.indexOf("더블할인쿠폰") > -1 ){
	strCoupon = strPlGoodsNmM;
	strCoupon = strCoupon.substring(strCoupon.indexOf("에누리")+3, strCoupon.indexOf("% 더블할인쿠폰")+1).replace(" ","");
	strType = "4";
}

if(!strCoupon.equals("") || strType.equals("4") || strType.equals("5") || strType.equals("6") ){
	blCouponflag = true;
}

String strCoupon_img = "";
String strCoupon_txt = "";

strCoupon_txt = Coupon_Layer_Proc.getCoupon_txt(szVcode);

boolean blCheck_coupon = true;

if(strCoupon_txt.equals("")){
	strCoupon_txt = "쇼핑몰로 이동중입니다.";
	blCheck_coupon = false;
}

String euserkey = "";
Login_Proc login_Proc = new Login_Proc();
if(  !"".equals(strId)  ){
	
	if( "6641".equals(szVcode+"")  ){ //티몬
		euserkey = login_Proc.getUsrMtcEnc(strId);
	}else if( "7943".equals(szVcode+"")  ){
		euserkey = login_Proc.getUsrMtcEnc(strId);
	}
}
%>
<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />	
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilenew/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/default.css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/move.css?v=20180913">
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/lib/animate.css" type="text/css">
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	//런칭할때 UA-52658695-3 으로 변경
	ga('create', 'UA-52658695-3', 'auto');
	</script> 
	<script  src="https://www.googletagmanager.com/gtag/js?id=AW-966646648"> </script>
	<script>
	window.dataLayer = window.dataLayer  || [ ] ;
    function gtag ( ) {dataLayer.push (arguments ) ; }
    gtag('js' , new Date ( ) ) ;
    gtag('config', 'AW-966646648') ;
	gtag('event', 'conversion', {
			'send_to': 'AW-966646648/2UzKCOio3wkQ-Lb3zAM',
			'transaction_id': ''
		});
	</script>

</head>
<body>

<div class="move_wrap">
<%
	if (strFrom.equals("zum")) {
%>
<div class="zum">
        <img src="<%=ConfigManager.IMG_ENURI_COM%>/images/board/big/logo_zum.gif" alt="zum">
        <span class="txt_move">에서 알려드립니다.</span>
    </div>
<% } else { %>
	<div class="mall">
		<%=strShopLogo %>
		<span class="txt_move">쇼핑몰로 이동중 입니다.</span>
	</div>
<% } %>	
	<div class="bar_area">로딩중</div>
	<div class="dis_price">
		<% if(blCheck_coupon){ %>
			<strong class="tit">에누리쿠폰가</strong>
		<% }else{	%>
			<strong class="tit">에누리할인가</strong>
		<% } %>
		<span class="pricing"><strong class="num"><%=toNumFormat(intPrice) %></strong>원</span>
		<span class="deli_price"><%=strGoodsDeliveryInfoTxt %></span>
	</div>
	<div class="btn_mv">
		<a href="javascript:void(0);" class="stop" title="쇼핑몰이동 멈춤">일시정지</a>
		<a href="javascript:void(0);" class="play" title="쇼핑몰이동">play</a>
	</div>
	<div class="guide_area">
		<span class="txt">쇼핑몰에서 <b>정확한 가격과 상품정보를 꼭 확인</b>하세요!</span>
	</div>
	<%if(intModelno > 0 ) {%>
	<div class="cont_area" >
		<ul class="compare_area">
			<li class="prod_info">
				<div class="mall_tit"><strong>에누리</strong></div>
				<div class="thumb"><img src="<%=strImageUrl %>" onError="this.src='<%=ConfigManager.IMG_ENURI_COM%>/images/home/thumb_none_300.jpg';" alt=""></div>
				<div class="prod_tit"><em><%=strViewGoodsNm %></em></div>
			</li>
			<li class="prod_info">
				<div class="mall_tit"><strong><%=strShopName %></strong></div>
				<div class="thumb"><img src="<%=strEpImgUrl %>" onError="this.src='<%=ConfigManager.IMG_ENURI_COM%>/images/home/thumb_none_300.jpg';" alt=""></div>
				<div class="prod_tit"><em><%=strPlGoodsNmM %></em></div>
			</li>
		</ul>
	</div>
	<%} %>
	<dl class="notice">
<%
	if (strFrom.equals("zum")) {
%>
        <dd><span>1.</span>줌닷컴 쇼핑검색 서비스는 "에누리"를 운영하는 ㈜써머스플랫폼의 데이터 제공으로 이루어집니다.</dd>
        <dd><span>2.</span>"에누리"와 쇼핑몰의 상품정보, 가격이 일치하지 않을 수 있습니다. <u class="red underline">쇼핑몰 이동 후 반드시 상품정보 및 가격을 다시 한번 확인하세요.</u></span></dd>
        <dd><span>3.</span>"에누리"를 운영하는 (주)써머스플랫폼은 통신판매 정보제공자로<b class="red"> 상품의 주문/배송/환불에 대한 의무와 책임은 각 쇼핑몰(판매자)에게 있습니다.</b></dd>
        <dd><span>4.</span>안전한 구매를 위해 안전거래(에스크로,전자 보증 등)를 통해 구매하시기 바랍니다.</dd>
        <dd><span>5.</span>쇼핑몰 이동 후 할인쿠폰이 있을 경우,쿠폰 다운받기 하신 후 결제 단계에서 적용해야 해당 가격으로 구매 가능합니다.</dd>
<% } else { %>
		<dd><span>1.</span>"에누리"와 쇼핑몰의 상품정보, 가격이 일치하지 않을 수 있습니다. <em class="red">쇼핑몰 이동 후 반드시 상품정보 및 가격을 다시 한번 확인하세요.</span></dd>
		<dd><span>2.</span>"에누리"를 운영하는 (주)써머스플랫폼은 통신판매 정보제공자로 <em class="red">상품의 주문/배송/환불에 대한 의무와 책임은 각 쇼핑몰(판매자)에게 있습니다.</em></dd>
		<dd><span>3.</span>안전한 구매를 위해 안전거래(에스크로,전자 보증 등)를 통해 구매하시기 바랍니다.        </dd>
		<dd><span>4.</span>쇼핑몰 이동 후 할인쿠폰이 있을 경우,쿠폰 다운받기 하신 후 결제 단계에서 적용해야 해당 가격으로 구매 가능합니다.</dd>
<% }  %>	
	</dl>
</div>

<p class="adbnr" style="display:none"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/move_bnr_shopping.png"></p>
</body>
</html>
<script>
var varMoveTimer;

$(function() {
	if("<%=strUrl %>" != ""){
		//viewCatchIcon();
		varMoveTimer = setTimeout("redirect_url()", 1000);
		
	}
	ga('send', 'pageview', {
		'page': '/mobilefirst/move2.jsp',
		'title': 'mf_화면이동_<%=szVcode %>'
	}); 
	$(".stop").on("click",function(){
	    clearInterval(varMoveTimer);
	});
	$(".play").on("click",function(){
		varMoveTimer = setTimeout("redirect_url()", 1000);
	});
});
function redirect_url(){
	
	if( "7943" == "<%=szVcode%>" || "6641" == "<%=szVcode%>" ){ //에누리PC //티몬
		
		<% if(!"".equals(euserkey) ){ %>
			location.href = "<%=strUrl %>&euserkey=<%=euserkey%>";
		<%}else{%>
			location.href = "<%=strUrl %>";
		<%}%>
			
	}else{
		location.href = "<%=strUrl %>";    		
	}
}
<%-- var i = 0;
var snipper = setInterval(function(){
	var node_li = document.createElement("li"),
		node_span = document.createElement("span");
	if(i > 2){
		clearInterval(snipper);
	}else{
		node_li.appendChild(node_span);
		document.getElementById("snipper").appendChild(node_li);
		i++;
	}
},200); --%>

<%-- 
function viewCatchIcon(){
	$.ajax({ 
		type: "POST",
		url: "/mobilefirst/evt/ajax/catch_setlist.jsp",
		async: false,
		data: { eventId: "2017022101", job:"2",goUrl:"<%=strUrl %>", modelNo:"<%=intModelno%>" },
		dataType:"JSON",
		success: function(json){
			if(json.result){
				$(".icon_wrap").show();
			}
		}
	});
}

function catchIcon(){
	$.ajax({ 
		type: "POST",
		url: "/mobilefirst/evt/ajax/catch_setlist.jsp",
		async: false,
		data: { eventId: "2017022101", job:"1",goUrl:"<%=strUrl %>", modelNo:"<%=intModelno%>"  },
		dataType:"JSON",
		success: function(json){
			var msg="";
			//비로그인시
			if(!json.result && !json.loginYN){
				msg= "로그인 후\n앱다운로드300만 기념\n이벤트에 참여하세요!\n\n'확인'을 누르면\n이벤트페이지로 이동합니다.";				
			}
			//로그인시
			else if(json.result && json.loginYN){
				msg= "에누리 잡기 성공!\n\n더 많은 에누리를 잡고\nⓔ3,000점을 받으세요!\n\n'확인'을 누르면\n이벤트페이지로 이동합니다.";
			}
			$(".icon_wrap").hide();
			var isGo = confirm(msg);
			if(isGo){
				location.href="/mobilefirst/evt/threemillion.jsp?freetoken=event";
			}
			
		}
	});
} --%>
</script>
<script language="JavaScript" src="http://img.enuri.info/common/js/Log_Tail_Mobile.js"></script>
<%
}catch(Exception e){
	response.sendRedirect(strUrl);
}
%>
