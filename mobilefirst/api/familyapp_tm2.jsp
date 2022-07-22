<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
	int param= ChkNull.chkInt(request.getParameter("param"), 1);
	String ch_code= ChkNull.chkStr(request.getParameter("ch_code"), "");
	String chk_id= ChkNull.chkStr(request.getParameter("chk_id"), "");
	
	String spath = request.getServletPath();  
	String url = request.getRequestURL().toString();  
	String strCurrentUrl = request.getScheme() + "://" + request.getServerName() + "/mobilefirst/api/familyapp_tm.jsp"; 

	//특정업체 기본 세팅 값 보유.
	ch_code = "1267674641";
%>
<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
	<meta property="og:title" content="티머니쇼핑">
	<meta property="og:description" content="티머니쇼핑">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/etc_tm.css">
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
</head>
<body>
<div class="family hasBanner">
	<header>
		<h2>티머니 쇼핑<span>Beta</span></h2>
		<div class="banner_part"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/m_home/grandopen.jpg" id="head_banner" /></div>
		<ul class="nav two"></ul>
	</header>
	<ul class="today_list sdeal" id="today_list">
	</ul>
	
	<ul class="mart_list timon" id="mart_list">
	</ul>
	
</div>

</body>
</html>
<script language="javascript">
var paramV = 1;
var vTab1_top = 0;
var vTab2_top = 0;


$(function() {
	paramV = <%=param%>;
	getBaselist(paramV);
	
	$("#head_banner").click(function(){
		window.open("https://goo.gl/e5cxgK");
	});
});

function getBaselist(param){
	if(paramV == 1){
		vTab1_top = $("body").scrollTop();
	}else if(paramV == 2){
		vTab2_top = $("body").scrollTop();
	}
	
	if(param == 1){
		$("body").scrollTop(vTab1_top);
	}else if(param == 2){
		$("body").scrollTop(vTab2_top);
	}
	
	paramV = param;

	var ch_code = "<%=ch_code%>";
	var chk_id = "<%=chk_id%>";
	var url = "<%=strCurrentUrl%>"+"?param="+param;
	
	pageview(ch_code, chk_id, url);
	
	$(".nav li").removeClass("on");
	
	var shop_code = "5910";
	var shop_name = "쇼킹딜";
	var json_url = "/mobilefirst/http/json/shocking.json";
	var template = "";
	
	$(".nav").html(null);
	
	if(param == 1){
		shop_code = "5910";
		shop_name = "쇼킹딜";
		json_url = "/mobilefirst/http/json/shocking.json";
		
		template += "<li id=\"deal_1\"><a href=\"javascript:///\" onclick=\"getBaselist(1);\"><img src=\"http://img.enuri.info/images/m_home/f_app01_on.png\" alt=\"쇼킹딜\" /></a></li>";
		template += "<li id=\"deal_2\"><a href=\"javascript:///\" onclick=\"getBaselist(2);\"><img src=\"http://img.enuri.info/images/m_home/f_app02.png\" alt=\"슈퍼딜\" /></a></li>";
	}else if(param == 2){
		shop_code = "536";
		shop_name = "슈퍼딜";
		json_url = "/mobilefirst/http/json/superDeal.json";

		template += "<li id=\"deal_1\"><a href=\"javascript:///\" onclick=\"getBaselist(1);\"><img src=\"http://img.enuri.info/images/m_home/f_app01.png\" alt=\"쇼킹딜\" /></a></li>";
		template += "<li id=\"deal_2\"><a href=\"javascript:///\" onclick=\"getBaselist(2);\"><img src=\"http://img.enuri.info/images/m_home/f_app02_on.png\" alt=\"슈퍼딜\" /></a></li>";
	}

	$(".nav").html(template);
	
	$.ajax({
		type: "POST",
		url: json_url,
		dataType: "JSON",
		success: function(json){
			$("#today_list").html(null);
			$("#mart_list").html(null);
			
			if(json.goodsList){
				var temp = "";
				var template = "";
				var shop_url = "";
				
				for(var i=0;i<json.goodsList.length;i++){
					if(shop_code == "6641" || shop_code == "6508"){
						temp += "<li>";
						temp += "<a href=\"javascript:///\" class=\"best_area\" modelno=\""+ json.goodsList[i].url +"\" pl_no=\""+ json.goodsList[i].pl_no +"\">";
						temp += "<div class=\"thum\"><img src=\""+json.goodsList[i].shopImageUrl+"\" alt=\"\" /></div>";
						temp += "<div class=\"info\">";
						temp += "<strong>"+json.goodsList[i].goodsnm+"</strong>";
						temp += "<div class=\"price\">";
						if(json.goodsList[i].discount_rate){
							temp += "<span class=\"sale\"><b>"+json.goodsList[i].discount_rate+"</b>%</span>";
						}
						temp += "<span class=\"prc\">";
						if(json.goodsList[i].orgPrice){
							temp += "<del>"+commaNum(json.goodsList[i].orgPrice)+"원</del>";
						}
						temp += "<b>"+commaNum(json.goodsList[i].price)+"</b>원</span>";
						temp += "</div>";
						temp += "</div>";
						temp += "</a>";
						temp += "<div class=\"option_area\">"+json.goodsList[i].pcnt+"개 구매";
						if(json.goodsList[i].option){
							var option = json.goodsList[i].option;
							var optSplit = option.split(',');
							for(var j=0;j<optSplit.length;j++){
								temp += "<em>"+optSplit[j]+"</em>";
							}
						}
						temp += "</div>";
						temp += "</li>";
					}else{
						//11번가 쇼팅딜 예외처리
						shop_url = json.goodsList[i].url;
						if(param == 1 && shop_url.indexOf("&tid=1000993624") > -1){
							shop_url = shop_url.replace("&tid=1000993624","&tid=1001064050");
						}
						template += "<li>";
						template += "<a href=\"javascript:///\" class=\"best_area\" modelno=\""+ shop_url +"\" pl_no=\""+ json.goodsList[i].pl_no +"\">";
						template += "<div class=\"thum\"><img src=\""+json.goodsList[i].shopImageUrl+"\" alt=\"\" /></div>";
						template += "<strong>"+json.goodsList[i].goodsnm+"</strong>";
						template += "<div class=\"price\">";
						if(json.goodsList[i].discount_rate){
							template += "<span class=\"sale\"><b>"+json.goodsList[i].discount_rate+"</b>%</span>";
						}
						template += "<span class=\"prc\"><b>"+commaNum(json.goodsList[i].price)+"</b>원";
						if(json.goodsList[i].orgPrice){
							template += "<del>"+commaNum(json.goodsList[i].orgPrice)+"원</del>";
						}
						template += "</span>";
						template += "</div>";
						template += "</a>";
						if(json.goodsList[i].pcnt){
							template += "<div class=\"option_area\">"+json.goodsList[i].pcnt+"개 구매";
						}
						if(json.goodsList[i].option){
							var option = json.goodsList[i].option;
							var optSplit = option.split(',');
							for(var j=0;j<optSplit.length;j++){
								if(optSplit[j] == "무료배송"){
									template += "<em>"+optSplit[j]+"</em>";
								}
							}
						}
						template += "</div>";
						template += "</li>";
					}
				}
				
				$("#today_list").html(template);
				$("#mart_list").html(temp);
				
				$(".best_area").each(function(){
					$(this).on("click",function(event) {
						clickout(ch_code, chk_id, shop_code, $(this).attr("pl_no"));
						
						window.open($(this).attr("modelno"));
					});
				});
			}
		},
		error : function(result) { 
			alert("error occured. Status:" + result.status + ' --Status Text:' + result.statusText + " --Error Result:" + result); 
		}
	});
}

function pageview(ch_code, chk_id, url){
	var param = "gubun=pageview&ch_code="+ch_code+"&chk_id="+chk_id+"&url="+url;
	
	$.ajax({
		type: "POST",
		url: "/mobilefirst/api/familyapp_setlist.jsp",
		data: param,
		dataType: "JSON",
		success: function(result){
			if(result.result == "1") {
// 				alert("log 삽입 성공");
			}else{
// 				alert("log 삽입 실패");
			}
		},
		error : function(result) { 
			alert("error occured. Status:" + result.status + ' --Status Text:' + result.statusText + " --Error Result:" + result); 
		}
	});
}

function clickout(ch_code, chk_id, shop_code, pl_no){
	var param = "gubun=clickout&ch_code="+ch_code+"&chk_id="+chk_id+"&shop_code="+shop_code+"&pl_no="+pl_no;

	$.ajax({
		type: "POST",
		url: "/mobilefirst/api/familyapp_setlist.jsp",
		data: param,
		dataType: "JSON",
		success: function(result){
			if(result.result == "1") {
// 				alert("log 삽입 성공");
			}else{
// 				alert("log 삽입 실패");
			}
		},
		error : function(result) { 
			alert("error occured. Status:" + result.status + ' --Status Text:' + result.statusText + " --Error Result:" + result); 
		}
	});
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

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
       var c = ca[i];
       while (c.charAt(0)==' ') c = c.substring(1);
       if(c.indexOf(name) == 0)
          return c.substring(name.length,c.length);
    }
    return "";
}

</script>
<%@ include file="/mobilefirst/include/common_logger.html"%>  