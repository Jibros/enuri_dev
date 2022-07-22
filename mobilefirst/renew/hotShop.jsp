<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
String strApp = ChkNull.chkStr(request.getParameter("app"));
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
	response.sendRedirect("http://m.enuri.com/mobilefirst/index.jsp#1");	
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
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/default.css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/main.css"/>
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
	<%@include file="/mobilefirst/renew/include/common.html"%>
	<%@include file="/mobilefirst/login/login_check.jsp"%>
	<script>  
	//이미지 로더 
	(function(e,t,n,r){e.fn.lazy=function(r){function u(n){if(typeof n!="boolean")n=false;s.each(function(){var r=e(this);var s=this.tagName.toLowerCase();if(f(r)||n){if(r.attr(i.attribute)&&(s=="img"&&r.attr(i.attribute)!=r.attr("src")||s!="img"&&r.attr(i.attribute)!=r.css("background-image"))&&!r.data("loaded")&&(r.is(":visible")||!i.visibleOnly)){var u=e(new Image);++o;if(i.onError)u.error(function(){d(i.onError,r);p()});else u.error(function(){p()});var a=true;u.one("load",function(){var e=function(){if(a){t.setTimeout(e,100);return}r.hide();if(s=="img")r.attr("src",u.attr("src"));else r.css("background-image","url("+u.attr("src")+")");r[i.effect](i.effectTime);if(i.removeAttribute)r.removeAttr(i.attribute);d(i.afterLoad,r);u.unbind("load");u.remove();p()};e()});d(i.beforeLoad,r);u.attr("src",r.attr(i.attribute));d(i.onLoad,r);a=false;if(u.complete)u.load();r.data("loaded",true)}}});s=e(s).filter(function(){return!e(this).data("loaded")})}function a(){if(i.delay>=0)setTimeout(function(){u(true)},i.delay);if(i.delay<0||i.combined){u(false);e(i.appendScroll).bind("scroll",h(i.throttle,u));e(i.appendScroll).bind("resize",h(i.throttle,u))}}function f(e){var t=l(),n=c(),r=e.offset().top,s=e.height();return t+n+i.threshold>r&&r+s>t-i.threshold}function l(){if(n.documentElement.scrollTop)return n.documentElement.scrollTop;return n.body.scrollTop}function c(){if(t.innerHeight)return t.innerHeight;if(n.documentElement&&n.documentElement.clientHeight)return n.documentElement.clientHeight;if(n.body&&n.body.clientHeight)return n.body.clientHeight;if(n.body&&n.body.offsetHeight)return n.body.offsetHeight;return i.fallbackHeight}function h(e,t){function s(){function o(){r=+(new Date);t.apply()}var s=+(new Date)-r;n&&clearTimeout(n);if(s>e||!i.enableThrottle)o();else n=setTimeout(o,e-s)}var n;var r=0;return s}function p(){--o;if(!s.size()&&!o)d(i.onFinishedAll,null)}function d(e,t){if(e){if(t!==null)e(t);else e()}}var i={bind:"load",threshold:500,fallbackHeight:2e3,visibleOnly:true,appendScroll:t,delay:-1,combined:false,attribute:"data-src",removeAttribute:true,effect:"show",effectTime:0,enableThrottle:false,throttle:250,beforeLoad:null,onLoad:null,afterLoad:null,onError:null,onFinishedAll:null};if(r)e.extend(i,r);var s=this;var o=0;if(i.bind=="load")e(t).load(a);else if(i.bind=="event")a();if(i.onError)s.bind("error",function(){d(i.onError,e(this))});return this};e.fn.Lazy=e.fn.lazy})(jQuery,window,document);
	</script>
</head>
<body>

<script type="text/javascript">
		//가로스크롤바 숨기기
		function loaded(){
			var iscroll = new iScroll("iscroll", {
			vScroll:false,
			hScrollbar:false
			});
		}
		document.addEventListener('DOMContentLoaded', loaded, false);

		//layer
		function onoff(id) {
			var mid=document.getElementById(id);
			if(mid.style.display=='') {
			mid.style.display='none';
			}else{ 
			mid.style.display='';}}
</script>

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
		<div class="Maincontent">
			<ul class="tab_deal">
				<li id="deal_1"><a href="#1" onclick="getBaselist(1);">슈퍼딜</a></li>
				<li id="deal_2"><a href="#2" onclick="getBaselist(2);">올킬</a></li>
				<li id="deal_3"><a href="#3" onclick="getBaselist(3);">쇼킹딜</a></li>
				<li id="deal_4"><a href="#4" onclick="getBaselist(4);">티몬</a></li>
	<!-- 		<li id="deal_5"><a href="#5" onclick="getBaselist(5);">쿠팡</a></li> -->
				<li id="deal_6"><a href="#6" onclick="getBaselist(6);">위메프</a></li>
			</ul>
	
			<h4 class="hot_title"><img id="hot_title" src="" alt="" /></h4>
	
			<ul class="today_list sdeal" id="today_list">
			</ul>
			
		</div>
	</div>
	<%@ include file="/mobilefirst/include/inc_ctu.jsp"%>
	<%@ include file="/mobilefirst/renew/include/footer.jsp"%>
<span class="zzimly" style="display:none">찜 되었습니다</span>
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

	ga('send', 'pageview', {'page': 'mf_홈_핫딜베스트'});
	
	var paramV = "1";
	var loca = location.href;
	//alert("loca:"+loca);
	if(loca.indexOf("#") > -1){
		paramV = loca.substring(loca.indexOf("#")+1,loca.length);
	}
	getBaselist(paramV);
	
});


function getBaselist(param){
	$(".tab_deal li").removeClass("on");
	
	var shop_code = "536";
	var shop_name = "슈퍼딜";
	var json_url = "/mobilefirst/http/json/superDeal.json";
	
	if(param == 1){
		shop_code = "536";
		shop_name = "슈퍼딜";
		json_url = "/mobilefirst/http/json/superDeal.json";
		$("#hot_title").attr("src","http://imgenuri.enuri.gscdn.com/images/m_home/hotdeal_superdeal.png");
		$("#deal_1").addClass("on");
	}else if(param == 2){
		shop_code = "4027";
		shop_name = "올킬";
		json_url = "/mobilefirst/http/json/allKill.json";
		$("#hot_title").attr("src","http://imgenuri.enuri.gscdn.com/images/m_home/hotdeal_allkill.png");
		$("#deal_2").addClass("on");
	}else if(param == 3){
		shop_code = "5910";
		shop_name = "쇼킹딜";
		json_url = "/mobilefirst/http/json/shocking.json";
		$("#hot_title").attr("src","http://imgenuri.enuri.gscdn.com/images/m_home/hotdeal_shocking.png");
		$("#deal_3").addClass("on");
	}else if(param == 4){
		shop_code = "6641";		
		shop_name = "티몬";
		json_url = "/mobilefirst/http/json/tmon.json";
		$("#hot_title").attr("src","http://imgenuri.enuri.gscdn.com/images/m_home/hotdeal_timon.png");
		$("#deal_4").addClass("on");
	}else if(param == 5){
		//shop_code = "";
		//shop_name = "쿠팡";
		//json_url = "/mobilefirst/http/json/coopang.json";
		//$("#hot_title").attr("src","http://imgenuri.enuri.gscdn.com/images/m_home/hotdeal_wemape.png");
		//$("#deal_5").addClass("on");
	}else if(param == 6){
		shop_code = "6508";
		shop_name = "위메프";
		json_url = "/mobilefirst/http/json/wemake.json";
		$("#hot_title").attr("src","http://imgenuri.enuri.gscdn.com/images/m_home/hotdeal_wemape.png");
		$("#deal_6").addClass("on");
	}
	
	ga("send", "event", "mf_hotdeal", "hotdeal_tab", "tab_"+ shop_name);
	
	$.ajax({
		type: "GET",
		url: json_url,
		dataType: "JSON",
		success: function(json){
			$("#today_list").html(null);
			$("#mart_list").html(null);
			
			if(json.goodsList){
				var temp = "";
				var template = "";
				for(var i=0;i<json.goodsList.length;i++){
				if(shop_code=="6641" || shop_code=="6508"){
					template += "<li>";
					template += "<a href=\"javascript:///\" modelnm=\""+ json.goodsList[i].goodsnm +"\" class=\"best_area\" url=\""+ json.goodsList[i].url +"\" modelno=\""+ json.goodsList[i].modelno +"\" pl_no=\""+ json.goodsList[i].pl_no +"\">";
					template += "<div class=\"thum sq\"><img src=\""+json.goodsList[i].shopImageUrl+"\" alt=\"\" /></div>";

					template += "<div class=\"zzimarea\" onclick=\"event.cancelBubble=true;\">";
					template += "<button type=\"button\" class=\"heart\" onclick=\"zzimSet("+json.goodsList[i].model_no +" , "+json.goodsList[i].pl_no +" ,this,"+shop_code+");\" id=P_"+ json.goodsList[i].pl_no +">찜</button>";
					template += "</div>";

					template += "<div class=\"info\">";
					if(shop_code == "6641"){
						template += "<span class=\"mall\"><img src=\"http://img.enuri.com/images/mobilefirst/main/shoplogo/tmon.png\" alt=\"\" /></span>";
					}else{
						template += "<span class=\"mall\"><img src=\"http://img.enuri.com/images/mobilefirst/main/shoplogo/wemake.png\" alt=\"\" /></span>";
					}
					template += "<strong>"+json.goodsList[i].goodsnm+"</strong>";
					template += "<div class=\"price\">";
					if(json.goodsList[i].discount_rate){
						if((json.goodsList[i].discount_rate != "" && json.goodsList[i].discount_rate != 0) && (json.goodsList[i].orgPrice != "" && json.goodsList[i].orgPrice != 0)){
							template += "<span class=\"sale\"><b>"+json.goodsList[i].discount_rate+"</b>%</span>";
							template += "<span class=\"prc\"><b>"+commaNum(json.goodsList[i].price)+"</b>원";
							template += "<del>"+commaNum(json.goodsList[i].orgPrice)+"원</del>";
						}else if((json.goodsList[i].discount_rate == "" || json.goodsList[i].discount_rate == "0") || (json.goodsList[i].orgPrice == "" || json.goodsList[i].orgPrice == "0")){
							template += "<span class=\"sale\"><b>특별가 </b></span>";
							template += "<span class=\"prc\"><b>"+commaNum(json.goodsList[i].price)+"</b>원";
						}
					}else{
						template += "<span class=\"sale\"><b>특별가 </b></span>";
						template += "<span class=\"prc\"><b>"+commaNum(json.goodsList[i].price)+"</b>원";
					}
					template += "</span>";
					template += "</div>";
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
				}else{
					template += "<li>";
					template += "<a href=\"javascript:///\" modelnm=\""+ json.goodsList[i].goodsnm +"\" class=\"best_area\" url=\""+ json.goodsList[i].url +"\" modelno=\""+ json.goodsList[i].modelno+"\" pl_no=\""+ json.goodsList[i].pl_no +"\">";
					template += "<div class=\"thum\"><img src=\""+json.goodsList[i].shopImageUrl+"\" alt=\"\" /></div>";
					
					template += "<div class=\"zzimarea\"  onclick=\"event.cancelBubble=true;\">";
					template += "<button type=\"button\" class=\"heart\" onclick=\"zzimSet("+ json.goodsList[i].model_no +" , "+ json.goodsList[i].pl_no +" ,this,"+shop_code+");\" id=P_"+ json.goodsList[i].pl_no +">찜</button>";
					template += "</div>";

					template += "<div class=\"info\">";
					if(shop_code == "536"){
						template += "<span class=\"mall\"><img src=\"http://img.enuri.com/images/mobilefirst/main/shoplogo/superdeal.png\" alt=\"\" /></span>";
					}else if(shop_code == "4027"){
						template += "<span class=\"mall\"><img src=\"http://img.enuri.com/images/mobilefirst/main/shoplogo/allkill.png\" alt=\"\" /></span>";
					}else{
						template += "<span class=\"mall\"><img src=\"http://img.enuri.com/images/mobilefirst/main/shoplogo/shocking.png\" alt=\"\" /></span>";
					}
					template += "<strong>"+json.goodsList[i].goodsnm+"</strong>";
					template += "<div class=\"price\">";
					if(json.goodsList[i].discount_rate){
						if((json.goodsList[i].discount_rate != "" && json.goodsList[i].discount_rate != 0) && (json.goodsList[i].orgPrice != "" && json.goodsList[i].orgPrice != 0)){
							template += "<span class=\"sale\"><b>"+json.goodsList[i].discount_rate+"</b>%</span>";
							template += "<span class=\"prc\"><b>"+commaNum(json.goodsList[i].price)+"</b>원";
							template += "<del>"+commaNum(json.goodsList[i].orgPrice)+"원</del>";
						}else if((json.goodsList[i].discount_rate == "" || json.goodsList[i].discount_rate == "0") || (json.goodsList[i].orgPrice == "" || json.goodsList[i].orgPrice == "0")){
							template += "<span class=\"sale\"><b>특별가 </b></span>";
							template += "<span class=\"prc\"><b>"+commaNum(json.goodsList[i].price)+"</b>원";
						}
					}else{
						template += "<span class=\"sale\"><b>특별가 </b></span>";
						template += "<span class=\"prc\"><b>"+commaNum(json.goodsList[i].price)+"</b>원";
					}
					template += "</span>";
					template += "</div>";
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
				
				$(".best_area").each(function(){
					$(this).on("click",function(event) {
						goShop($(this).attr("url"),shop_code,$(this).attr("pl_no"),'','','','','',this,$(this).attr("modelno"));
						
						ga("send", "event", "mf_hotdeal", "buy", "buy_"+shop_name+"_"+$(this).attr("modelnm"));
					});
				});
			}
		},
		complete : function(data) {
            zzimCheckSet();
       },
		error : function(result) { 
			alert("error occured. Status:" + result.status  
	                     + ' --Status Text:' + result.statusText 
	                    + " --Error Result:" + result); 
		}
	});
}


$(document).ready(function(){
	/*
	$(".heart").click(function(){
		$(".zzimly").fadeIn(400);
	});
	*/
});

function heart(obj)
{
	if (obj.className== 'heart') {
	obj.className = 'hearton';
	} else {
	obj.className = 'heart';
	}
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


function zzimDelete(part,delItemList){
    var url = "/view/deleteSaveGoodsProc.jsp";
    var param = "modelnos="+delItemList+"&tbln=save";

    $.ajax({
        type : "post",
        url : url,
        data : param, 
        dataType : "html",
        success : function(ajaxResult) {
             var tempNum = delItemList.replace(":","_");
            if(part == "C" || part == "T" || part == "D" ){
                $("#"+tempNum).attr("class","heart");        
            }else{
                $("#"+tempNum).attr("class","heart");
            }
        }
    }); 
}

function zzimSet(modelno,plno,obj,shopcode){
	if(IsLogin()) {
	    if( $(obj).attr("class") == "heart"  ){ //찜이 아닐 경우
	        addResentZzimItem(2, "P", plno);
	        ga('send', 'event', 'mf_hotdeal', 'hotdeal_zzim', shopcode+"_"+plno+'_hotdeal');
	        
	        $(obj).attr("class","hearton");
	        //$(obj).after("<span class=\"zzimly fade-out\" style=\"display: inline;\">찜 목록에<br>추가 되었습니다</span>");
	        
		    $(".zzimly").fadeIn( 820, function() {
		           setTimeout(function(){
		                $( ".zzimly" ).fadeOut( 760, function() {
		                    $(".zzimly").hide();    
		                });
		            }, 450);
		      });
	    }else{ //찜상품일 경우
	             //if(part == "C" || part == "T" || part == "D" ){
	                //zzimDelete(part,"G:"+modelno);
	             //}else{
	                 zzimDelete("S","P:"+plno);
	             //} 
	    }
	}else{
	    // 찜버튼을 클릭했을때 이벤트 등록
	    if(confirm("찜 하시려면 로그인이 필요합니다.\n로그인 하시겠습니까?")) {
	            goLogin();
	            return false;
	    }else{
	        return false;
	    }
	}
}
function addResentZzimItem(itemType, productType, modelno) {
if(itemType==2) {
    if(IsLogin()) {
    
        var url = "/mobilefirst/ajax/resentZzim/insertSaveGoodsProc.jsp";
        var param = "modelnos="+productType+":"+modelno;
        
        $.ajax({
            type : "post",
            url : url,
            data : param, 
            dataType : "json",
            success : function(ajaxResult) {
                
            }
        }); 

    } else {
        
    }
}
}
function zzimCheckSet() {

//$(".prodChoice button").unbind();

if(IsLogin()) {
    var url = "/mobilefirst/ajax/resentZzim/IsZzim_Main_Find_ajax.jsp";
    //var param = "modelnos="+goodsNumbers;
    var param = "";

    $.ajax({
        type : "post",
        url : url,
        data : param, 
        dataType : "json",
        success : function(goodsList) {
            
            $.each(goodsList, function(i, v){
                    $("#"+v).attr("class","hearton");
            });
        }
    });
} else {
    // 찜버튼을 클릭했을때 이벤트 등록
    var btn_zzimObj = $(".prodChoice button");
    btn_zzimObj.click(function (e) {
        if(confirm("찜 하시려면 로그인이 필요합니다.\n로그인 하시겠습니까?")) {
            //goLoginZzim(resentZzimModelno);
            goLogin();
            return false;
        }else{
            return false;
        }
    });
}
}
</script>
<%@include file="/mobilefirst/include/common_logger.html"%>