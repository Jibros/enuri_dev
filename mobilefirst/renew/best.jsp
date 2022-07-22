<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
Cookie[] carr = request.getCookies();
String strAppyn = "";
String strVerios = "";
String strType= ChkNull.chkStr(request.getParameter("type"),"");	
String strAppyn2 = ChkNull.chkStr(request.getParameter("app"),"");	

String strVerand = "";
String strAd_id = "";

try{
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
	    	//break;
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

long cTime = System.currentTimeMillis(); 
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
String nowDt = dayTime.format(new Date(cTime));

String seasonYN = "N";
String seasonName = "#가정의달";
if(true){
	response.sendRedirect("http://m.enuri.com/mobilefirst/index.jsp#6");	
	return;
}
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
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/default.css" />
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/best.css"/>
	<%@include file="/mobilefirst/renew/include/common.html"%>
	<script type="text/javascript" src="/mobilefirst/js/lib/LazyLoad.1.9.3.min.js"></script>
</head>
<body>
<div id="main">
	<!-- 헤더영역 -->
    <!-- 홈메인 GNB -->
    <%@include file="/mobilefirst/renew/include/gnb.html"%>
    <nav class="m_top">
        <div class="grd_next"></div>
        <div class="gnbarea" id="iscroll">
            <ul class="newgnb" style="heigth:177px">
                <%@ include file="/mobilefirst/renew/include/topMenu.jsp"%>
            </ul>
        </div>
    </nav>
    <div id="wrap">
		<ul class="brand_snb">
			<li class="brand_btt" id="brand_1" onclick="getBaselist(1);"><a href="javascript:////">Gmarket</a></li>
			<li class="brand_btt" id="brand_2" onclick="getBaselist(2);"><a href="javascript:////">AUCTION</a></li>
			<li class="brand_btt" id="brand_3" onclick="getBaselist(3);"><a href="javascript:////">11ST</a></li>
		</ul>
	
		<section class="shop_best">
			<ul class="best_list" id="best_body"></ul>
		</section>
	</div>
	<%@ include file="/mobilefirst/include/inc_ctu.jsp"%>
	<%@ include file="/mobilefirst/renew/include/footer.jsp"%>
</div>	
</body>
</html>
<script language="javascript">
var vAppyn = getCookie("appYN");
var vAppyn2 = "<%=strAppyn2%>";

if(vAppyn2 == "Y"){ 
	vAppyn = "Y";
}

var vVerios = getCookie("verios");
var vVerand = "<%=strVerand%>";
var mType = "";
if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
	mType = "I";
}else if(navigator.userAgent.indexOf("Android") > -1){
	mType = "A";
}

$(function() {
	
	ga('send', 'pageview', {'page': 'mf_홈_쇼핑베스트'});

	$('.gnbarea').scrollLeft($('.gnbarea').scrollLeft() + 380 ); 

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
					 if(param == 2){
						if(i < 4){
							template += "	<img class=\"trend_thumb\" data-original=\""+json.goodsList[i].shopImageUrl+"\"  src=\""+json.goodsList[i].shopImageUrl+"\"  alt=\"\"> ";
						}else{
							template += "	<img class=\"trend_thumb\" data-original=\""+json.goodsList[i].shopImageUrl+"\"  src=\"http://imgenuri.enuri.gscdn.com/images/mobilefirst/enuri_rod.png\" alt=\"\"> ";
						}
					 }else{
						if(i < 4){
							template += "	<img class=\"trend_thumb\" data-original=\""+json.goodsList[i].imgurl+"\"  src=\""+json.goodsList[i].imgurl+"\"  alt=\"\"> ";
						}else{
							template += "	<img class=\"trend_thumb\" data-original=\""+json.goodsList[i].imgurl+"\"  src=\"http://imgenuri.enuri.gscdn.com/images/mobilefirst/enuri_rod.png\" alt=\"\"> ";
						}
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

function commaNum(amount) {
    var delimiter = ","; 
    var i = parseInt(amount);

    if(isNaN(i)) { return ''; }
    
    var minus = '';
    
    if (i < 0) { minus = '-'; }
    i = Math.abs(i);
    
    var n = new String(i);
    var a = [];

    while(n.length > 3)
    {
        var nn = n.substr(n.length-3);
        a.unshift(nn);
        n = n.substr(0,n.length-3);
    }

    if (n.length > 0) { a.unshift(n); }
    n = a.join(delimiter);
    amount = minus + (n+ "");
    return amount;
}

</script>
<%@include file="/mobilefirst/include/common_logger.html"%>