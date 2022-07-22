<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%

response.sendRedirect("/mobilefirst/index.jsp");
return;

/*
Cookie[] carr = request.getCookies();
String strAppyn = "";
String strVerios = "";
String strType= ChkNull.chkStr(request.getParameter("type"),"");	


try{
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("appYN")){
	    	strAppyn = carr[i].getValue();
	    }
	}
} catch(Exception e) {
}  

%>
<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />	
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
	<%@ include file="/mobilefirst/include/common.html" %>
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/best.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/LazyLoad.1.9.3.min.js"></script>
</head>
<%@ include file="/mobilefirst/include/common_top.jsp" %>
<body>
<%@ include file="/mobilefirst/gnb/gnb.html" %>
<div id="wrap">
	<div id="main">
		<nav class="m_top" <%=(strAppyn.equals("Y")?"style=\"display:none;\"":"") %> >
			<ul class="newgnb">
			    <li><a href="/mobilefirst/Index.jsp">홈</a></li>
			    <li><a href="/mobilefirst/trend_news.jsp?type=pickup" id="trendTab">트렌드픽업</a></li>
			    <li><a href="/mobilefirst/best.jsp" class="on">쇼핑베스트</a></li>
			    <li><a href="/mobilefirst/trend_news.jsp"  id="trendNews">쇼핑 TIP</a></li>
			    <li><a href="/mobilefirst/plan_event.jsp">이벤트</a></li></ul>
			</ul>  
		</nav> 
	
		<ul class="brand_snb">
			<li><a href="#1" class="brand_btt" id="brand_1" onclick="getBaselist(1);" class="on">Gmarket</a></li>
			<li><a href="#2" class="brand_btt" id="brand_2" onclick="getBaselist(2);">AUCTION</a></li>
			<li><a href="#3" class="brand_btt" id="brand_3" onclick="getBaselist(3);">11ST</a></li>
		</ul>
	
		<section class="shop_best">
			<ul class="best_list" id="best_body"></ul>
		</section>
	
		<%@ include file="/mobilefirst/include/inc_ctu.jsp"%>
		<%@ include file="/mobilefirst/include/footer.jsp"%>
	</div>
</div>
</body>
</html>
<script language="javascript">

$(function() {

	var paramV = "1";
	var loca = location.href;
	if(loca.indexOf("#") > -1){
		paramV = loca.substring(loca.indexOf("#")+1,loca.length);
	}
	getBaselist(paramV);
	
	
});


function getBaselist(param){
	$(".brand_btt").removeClass("on");
	
	var shop_code = "536";
	var json_url = "/mobilefirst/http/json/bestGmarket.json";
	var shop_name = "";
	if(param == 1){
		shop_code = "536";
		json_url = "/mobilefirst/http/json/bestGmarket.json";
		$("#brand_1").addClass("on");
		
		shop_name = "지마켓";
	}else if(param == 2){
		shop_code = "4027";
		json_url = "/mobilefirst/http/json/bestAuction.json";
		$("#brand_2").addClass("on");
		
		shop_name = "옥션";
	}else if(param == 3){
		shop_code = "5910";
		json_url = "/mobilefirst/http/json/best11st.json";
		$("#brand_3").addClass("on");
		
		shop_name = "11번가";
	}
	
	ga("send", "event", "mf_home", "tab_쇼핑베스트_"+shop_name, "tab_쇼핑베스트_"+ shop_name +"_홈");
	
	$.ajax({
		type: "GET",
		url: json_url,
		dataType: "JSON",
		success: function(json){
			$("#best_body").html(null);
			
			if(json.goodsList){
				var template = "";
				
				for(var i=0;i<json.goodsList.length;i++){
					template += "<li>";
					template += "	<a href=\"javascript:///\" class=\"best_area\" modelno=\""+ json.goodsList[i].modelno +"\" url=\""+ json.goodsList[i].url +"\" pl_no=\""+ json.goodsList[i].pl_no +"\">";
					template += "		<span class=\"num\">"+( i + 1) +"</span>";
					if(json.goodsList[i].modelno > 0){
						template += "		<span class=\"infobtn\" modelno=\""+ json.goodsList[i].modelno +"\">카탈로그보기</span>";
					}
					if(i < 4){
						template += "	<img class=\"trend_thumb\" data-original=\""+json.goodsList[i].imgurl+"\"  src=\""+json.goodsList[i].imgurl+"\"  alt=\"\"> ";
					}else{
						template += "	<img class=\"trend_thumb\" data-original=\""+json.goodsList[i].imgurl+"\"  src=\"http://imgenuri.enuri.gscdn.com/images/mobilefirst/enuri_rod.png\" alt=\"\"> ";
					}
					template += "		<strong>"+ json.goodsList[i].goodsnm +"</strong>";
					template += "		<span class=\"pr\">"+ commaNum(json.goodsList[i].price) +"<em>원</em>";
					if( json.goodsList[i].deliverytype2 == "1" &&  json.goodsList[i].deliveryinfo2 == "0"){
						template += "<span class=\"free\">무료배송</span>";
					}
					template += "		</span>";
					template += "	</a>";
					if(json.goodsList[i].ca_codeName != ""){
						template += "	<a href=\"javascript:///\" class=\"best_more\" cate=\""+ json.goodsList[i].ca_code4 +"\"><span>"+ json.goodsList[i].ca_codeName +"</span></a>";
					}
					template += "</li>";
				}
				
				$("#best_body").html(template);
				
				$(".best_area").each(function(){
					$(this).on("click",function(event) {
						goShop($(this).attr("url"),shop_code,$(this).attr("pl_no"),'','','','','',this,$(this).attr("modelno"));
						
						ga("send", "event", "mf_home", "tab_쇼핑베스트_"+shop_name, "tab_쇼핑베스트_"+ shop_name +"_상품");
					});
				});
				
				$(".infobtn").each(function(){
					$(this).on("click",function(event) {
						event.stopPropagation();
						location.href = "/mobilefirst/detail.jsp?modelno="+ $(this).attr("modelno");
						
						ga("send", "event", "mf_home", "tab_쇼핑베스트_"+shop_name, "tab_쇼핑베스트_"+ shop_name +"_인포");
					});
				});
				
				$(".best_more").each(function(){
					$(this).on("click",function(event) {
						event.stopPropagation();
						go_cate($(this).attr("cate"));
						
						ga("send", "event", "mf_home", "tab_쇼핑베스트_"+shop_name, "tab_쇼핑베스트_"+ shop_name +"_카테");
					});
				});
				
				$(".trend_thumb").lazyload({
					onError: function(element) {
			           console.log("error loading image: " + $(this));
			        }
				});

			}
		},
		error : function(result) { 
			alert("error occured. Status:" + result.status  
	                     + ' --Status Text:' + result.statusText 
	                    + " --Error Result:" + result); 
		}
	});
}

function go_cate(cate){
	location.href="/mobilefirst/list.jsp?cate="+cate;
}

function go_vip(modelno){
	location.href="/mobilefirst/detail.jsp?modelno="+modelno;
}


</script>
<% */ %>