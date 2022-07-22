<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>
<%@ page import="com.enuri.bean.lsv2016.Category_Set_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Category_Set_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Brand_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Brand_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Recommend_Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Board_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Board_Proc"%>
<jsp:useBean id="Goods_Data" class="com.enuri.bean.main.Goods_Data" scope="page" />
<jsp:useBean id="Goods_Proc" class="com.enuri.bean.main.Goods_Proc" scope="page" />
<jsp:useBean id="Recommend_Goods_Proc" class="com.enuri.bean.lsv2016.Recommend_Goods_Proc" scope="page" />
<jsp:useBean id="Goods_Board_Data" class="com.enuri.bean.main.Goods_Board_Data" scope="page" />
<jsp:useBean id="Goods_Brand_Proc" class="com.enuri.bean.main.Goods_Brand_Proc" scope="page" />
<jsp:useBean id="category_set_proc" class="com.enuri.bean.lsv2016.Category_Set_Proc" scope="page" />
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%
String strRecom_type =  ChkNull.chkStr(request.getParameter("recomType"),"1");
int intModelno = ChkNull.chkInt(request.getParameter("nModelNo"),0);
String strCategory =  ChkNull.chkStr(request.getParameter("szCategory"),"");

String strAccessoryShowFlag =  ChkNull.chkStr(request.getParameter("accessoryShowFlag"),"");
int intModelNoGroup = ChkNull.chkInt(request.getParameter("nModelNoGroup"),0);

String strRefernum =  ChkNull.chkStr(request.getParameter("Refernum"),"");
String strReferModelno =  ChkNull.chkStr(request.getParameter("strReferModelno"),"");
String szBrand =  ChkNull.chkStr(request.getParameter("szBrand"),"");

%>
<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/default.css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/vip.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
</head>
<body>

<div id="wrap">
	<!-- 헤더영역 -->
	<!-- 서브 -->
	<nav class="m_top_sub new_m_top_sub">
		<h2 class="a_center"><a href="javascript:///" class="win_back back">뒤로가기</a><span id="title_head"></span></h2>
	</nav>
	<!--// 서브 -->
	<!--// 헤더영역 -->
	
	<section class="vip_wrap">
		<div class="prodListWrap">
			<ul class="prodList"></ul>
		</div>
	</section>
</div>
</body>
</html>
<script>
var vModelno = "<%=intModelno %>";
var vCa_code = "<%=strCategory %>";
var vCate2 = "<%=strCategory.substring(0,2) %>";
var vCate4 = "<%=strCategory.substring(0,4) %>";
var vAccessoryShowFlag = "<%=strAccessoryShowFlag %>";
var nModelNoGroup = "<%=intModelNoGroup %>";
var vRefernum = "<%=strRefernum %>";
var vReferModelno = "<%=strReferModelno %>";
var vBrand = "<%=szBrand %>";
var recomType = "<%=strRecom_type %>";

var app = getCookie("appYN");

$(function() {
	loadRecomGoods(<%=strRecom_type %>);
	
	$( ".win_back" ).click(function(){
		if(app == 'Y'){
			window.location.href = "close://";
		}else{
			history.go(-1);
		}
		
	});
});
var gb1 = 0;
var gb2 = 0;
var recomCate = "";
var bSupplyTool = false;

function loadRecomGoods(recomType) {
	var loadrecom_pageNum = 1;
	var loadrecom_pageGap = 20;
	if (typeof (recomType) == "undefined" || recomType == "")
		recomType = 1;

	var strUrl = "";
	if (recomType == 1)
		strUrl = "/lsv2016/ajax/detail/getRecommendGoods_ajax.jsp";
	else if (recomType == 2)
		strUrl = "/lsv2016/ajax/detail/getRecommendGoods2_ajax.jsp";
	else if (recomType == 3)
		strUrl = "/lsv2016/ajax/detail/getRecommendGoods3_ajax.jsp";
	else if (recomType == 4)
		strUrl = "/lsv2016/ajax/detail/getRecommendGoods4_ajax.jsp";
	else if (recomType == 5)
		strUrl = "/lsv2016/ajax/detail/getRecommendGoods5_ajax.jsp";
	else if (recomType == 6)
		strUrl = "/lsv2016/ajax/detail/getRecommendGoods6_ajax.jsp";
	else if (recomType == 7)
		strUrl = "/lsv2016/ajax/detail/getRecommendGoods7_ajax.jsp";

	var param = {
		"nModelNo" : vModelno,
		"szCategory" : vCa_code,
		"accessoryShowFlag" : vAccessoryShowFlag,
		"nModelNoGroup" : nModelNoGroup,
		"Refernum" : vRefernum,
		"strReferModelno" : vReferModelno,
		"szBrand" : vBrand,
		"recomType" : recomType,
		"pageGap" : loadrecom_pageGap,
		"pageNum" : loadrecom_pageNum
	}
	// console.log(param);

	$.ajax({
		type : "get",
		url : strUrl,
		async : true,
		data : param,
		dataType : "json",
		success : function(json) {
			var totalcnt = json["totalcnt"];
			gb1 = json["gb1"];
			gb2 = json["gb2"];
			bSupplyTool = json["bSupplyTool"];
			recomCate = json["recomCate"];

			if (totalcnt > 0) {
				var recomgoodsListObj = json["recomgoods_list"];
				recomgoodsCntAry[recomType] = totalcnt;
				recomgoodsListAry[recomType] = recomgoodsListObj;

				if (recomType == 2 || ((recomType >= 3 || recomType == 1) && totalcnt > 3)) {
					loadRecomGoodsview(recomType);
				} else {
					totalcnt = 0;
				}
			}
		},
		error : function(xhr, ajaxOptions, thrownError) {
			// alert(xhr.status);
			// alert(thrownError);
		}
	});
}


var lognum = 0;
var recomgoodsPreList = null; // 상품설명 추천상품 미리보기
var recomgoodsListAry = new Array();
var recomgoodsCntAry = new Array();
var gtotalcnt = 0;

function loadRecomGoodsview(recomType) {
	var recom_pageNum = 1;
	var recom_pageGap = 5;

	var html = "";
	var recomTitle = "";
	if (recomType == 1)
		recomTitle = "CM추천 액세서리"; // d
	else if (recomType == 2)
		recomTitle = "동일 시리즈 상품"; // f
	else if (recomType == 3)
		recomTitle = "함께 살만 한 상품"; // e
	else if (recomType == 4)
		recomTitle = "동일 브랜드 인기 상품"; // a
	else if (recomType == 5)
		recomTitle = "다른 브랜드 인기상품"; // b
	else if (recomType == 6)
		recomTitle = "동일 카테고리 인기상품"; // c

	var recomgoodsListObj = recomgoodsListAry[recomType];
	var totalcnt = recomgoodsListObj.length;
	var limtcnt = 20;
	if (totalcnt < limtcnt)
		limtcnt = totalcnt;
	var startcnt = (recom_pageNum - 1) * recom_pageGap;

	$("#title_head").text(recomTitle);
	
	var bSupplyTool = false;

	if (vCate2 != "03") {
		if (vAccessoryShowFlag == 'true' && vCate4 != "0402") {
			bSupplyTool = true;
		}
	}
	var listObj = $(".prodList");

	listObj.hide();

	/*
	 * if(recomType==1) { insertLog(14548); lognum = 14542; } if(recomType==2) {
	 * insertLog(14549); lognum = 14543; } if(recomType==3) { insertLog(14550);
	 * lognum = 14544; } if(recomType==4) { insertLog(14551); lognum = 14545; }
	 * if(recomType==5) { insertLog(14552); lognum = 14546; } if(recomType==6) {
	 * insertLog(14553); lognum = 14547; }
	 */

	for (var i = startcnt; i < limtcnt; i++) {
		var o_modelno = recomgoodsListObj[i].modelno;
		var o_modelnm = recomgoodsListObj[i].modelnm;
		var o_ca_code4 = recomgoodsListObj[i].ca_code4;
		var o_strImageUrl = recomgoodsListObj[i].strImageUrl;
		var o_minprice = recomgoodsListObj[i].minprice;
		var o_minprice2 = recomgoodsListObj[i].minprice2;
		var o_minprice3 = recomgoodsListObj[i].minprice3;
		var o_imgchk = recomgoodsListObj[i].imgchk;
		var o_sopnShowFlag = recomgoodsListObj[i].sopnShowFlag;
		var o_bbs_point_avg = recomgoodsListObj[i].bbs_point_avg;
		var o_bbs_num = recomgoodsListObj[i].bbs_num;
		var o_gb1 = recomgoodsListObj[i].gb1;
		var o_gb2 = recomgoodsListObj[i].gb2;
		var o_c_date = recomgoodsListObj[i].c_date;
		//현금몰 로직 추가 (2019.11.25)
		var o_cash_min_prc = recomgoodsListObj[i].cashMinPrc;
		var o_cash_min_prc_yn = recomgoodsListObj[i].cashMinPrcYn;
		var o_ovs_min_prc_yn = recomgoodsListObj[i].ovsMinPrcYn;
		//tlc 로직 추가 (2019.12.12)
		var o_tlc_min_prc = recomgoodsListObj[i].tlcMinPrc;

		
		html += "<li id=\"" + o_modelno + "\">";
		html += "		<a href=\"javascript:///\">";
		html += "			<img src=\""+ o_strImageUrl +"\" alt=\"\" class=\"thumb\" />";
		html += "			<span class=\"info\">";
		html += "				<span class=\"txt\">" + o_modelnm + "</span>";
		html += "				<span class=\"date\">등록일 "+ o_c_date.substring(2,4) +"년 "+ o_c_date.substring(5,7) +"월</span>";
		html += "				<span class=\"price\">";
		if (!isNaN(o_c_date) && (parseInt(o_c_date) >= parseInt(cur_date))) {
			html += "							<em class=\"low\">출시예정</em>";
		} else {
			if(typeof o_cash_min_prc_yn != "undefined" && o_cash_min_prc_yn != null && o_cash_min_prc_yn == "Y" && typeof o_cash_min_prc != "undefined" && o_cash_min_prc != null) {
				html += "							<em class=\"low\">최저가</em>";
				html += "							<em>" + commaNum(o_cash_min_prc) + "</em>원";
			} else if(typeof o_tlc_min_prc != "undefined " && o_tlc_min_prc != null && o_tlc_min_prc != "0" && o_minprice == "0") {
				html += "							<em class=\"low\">최저가</em>";
				html += "							<em>" + commaNum(o_tlc_min_prc) + "</em>원";
			} else {				
			// if(o_minprice > o_minprice3 && o_minprice3 > 0){ //모바일가격이 더 저렴하면
			// html += " <em class=\"low\">최저가</em>";
			// html += " <em>1,449,000</em>원";
			// }else{ //pc가격이 더 저렴하면
			html += "							<em class=\"low\">최저가</em>";
			html += "							<em>" + commaNum(o_minprice) + "</em>원";
			// }
			}
			
		}
		html += "				</span>";
		html += "			</span>";
		html += "		</a>";
		html += "</li>";
	}

	if (html != "") {
		listObj.html(html);
		listObj.show();

		$(".prodList li").unbind("click");
		$(".prodList li").click(function(){
			var vRecommand_Modelno = $(this).attr("id");
		
			if ( typeof vRecommand_Modelno != "undefined" ){
				location.href = "/mobilefirst/vip.jsp?freetoken=vip&modelno="+vRecommand_Modelno;
				return false;
			}
		});
	} else {
		listObj.hide();
	}
}

function commaNum(num) {  
    var len, point, str;  

    num = num + "";  
    point = num.length % 3  
    len = num.length;  

    str = num.substring(0, point);  
    while (point < len) {  
        if (str != "") str += ",";  
        str += num.substring(point, point + 3);  
        point += 3;  
    }  
    return str;  
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
</script>