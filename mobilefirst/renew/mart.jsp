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
} catch(Exception e) {}  
long cTime = System.currentTimeMillis(); 
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
String nowDt = dayTime.format(new Date(cTime));

String seasonYN = "N";
String seasonName = "#가정의달";
if(true){
	response.sendRedirect("http://m.enuri.com/mobilefirst/index.jsp#7");	
	return;
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
	<%@include file="/mobilefirst/renew/include/common.html"%>
	<%@include file="/mobilefirst/login/login_check.jsp"%>
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/default.css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/main.css"/>
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css">
	<script>  
	//이미지 로더 
	(function(e,t,n,r){e.fn.lazy=function(r){function u(n){if(typeof n!="boolean")n=false;s.each(function(){var r=e(this);var s=this.tagName.toLowerCase();if(f(r)||n){if(r.attr(i.attribute)&&(s=="img"&&r.attr(i.attribute)!=r.attr("src")||s!="img"&&r.attr(i.attribute)!=r.css("background-image"))&&!r.data("loaded")&&(r.is(":visible")||!i.visibleOnly)){var u=e(new Image);++o;if(i.onError)u.error(function(){d(i.onError,r);p()});else u.error(function(){p()});var a=true;u.one("load",function(){var e=function(){if(a){t.setTimeout(e,100);return}r.hide();if(s=="img")r.attr("src",u.attr("src"));else r.css("background-image","url("+u.attr("src")+")");r[i.effect](i.effectTime);if(i.removeAttribute)r.removeAttr(i.attribute);d(i.afterLoad,r);u.unbind("load");u.remove();p()};e()});d(i.beforeLoad,r);u.attr("src",r.attr(i.attribute));d(i.onLoad,r);a=false;if(u.complete)u.load();r.data("loaded",true)}}});s=e(s).filter(function(){return!e(this).data("loaded")})}function a(){if(i.delay>=0)setTimeout(function(){u(true)},i.delay);if(i.delay<0||i.combined){u(false);e(i.appendScroll).bind("scroll",h(i.throttle,u));e(i.appendScroll).bind("resize",h(i.throttle,u))}}function f(e){var t=l(),n=c(),r=e.offset().top,s=e.height();return t+n+i.threshold>r&&r+s>t-i.threshold}function l(){if(n.documentElement.scrollTop)return n.documentElement.scrollTop;return n.body.scrollTop}function c(){if(t.innerHeight)return t.innerHeight;if(n.documentElement&&n.documentElement.clientHeight)return n.documentElement.clientHeight;if(n.body&&n.body.clientHeight)return n.body.clientHeight;if(n.body&&n.body.offsetHeight)return n.body.offsetHeight;return i.fallbackHeight}function h(e,t){function s(){function o(){r=+(new Date);t.apply()}var s=+(new Date)-r;n&&clearTimeout(n);if(s>e||!i.enableThrottle)o();else n=setTimeout(o,e-s)}var n;var r=0;return s}function p(){--o;if(!s.size()&&!o)d(i.onFinishedAll,null)}function d(e,t){if(e){if(t!==null)e(t);else e()}}var i={bind:"load",threshold:500,fallbackHeight:2e3,visibleOnly:true,appendScroll:t,delay:-1,combined:false,attribute:"data-src",removeAttribute:true,effect:"show",effectTime:0,enableThrottle:false,throttle:250,beforeLoad:null,onLoad:null,afterLoad:null,onError:null,onFinishedAll:null};if(r)e.extend(i,r);var s=this;var o=0;if(i.bind=="load")e(t).load(a);else if(i.bind=="event")a();if(i.onError)s.bind("error",function(){d(i.onError,e(this))});return this};e.fn.Lazy=e.fn.lazy})(jQuery,window,document);
	</script> 
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
   <!--// 홈메인 GNB -->
   <div id="wrap"> 
	<div class="Maincontent">
		<!-- 메인 배너 -->
		<div class="mainbnr">
			<ul class="evtbnr">
			</ul>
		</div>
		<!--// 메인 배너 -->
		<ul class="mart_cate"></ul>
		<!-- 상품 list -->
		<h4 class="mart_tit"></h4>
		<ul class="mart_list">
		</ul>
		<!--// list -->
	</div>
	</div>
	<%@ include file="/mobilefirst/renew/include/footer.jsp"%> 
</div>
<span class="zzimly" style="display:none">찜 되었습니다</span>
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

var nowTime = "<%=nowDt%>";
nowTime = nowTime*1;

var arrGroup = new Array();
var arrGroupNum = new Array();	//random 시킬 배열 번호
var nowCate = 1;

$(function() {
	//shop별 JSON랜덤화
	getJsonRandom();
	//상단 cate,banner load
	getCateAndBanner();
	init();
	//pageview
	ga('send', 'pageview', {		'page': '/mobilefirst/renew/mart.jsp',		'title': 'mf_홈_마트핫픽'	}); 
});
function init(){
	$('.evtbnr').slick({
		dots: true,
		infinite: true,
		speed: 300,
		slidesToShow: 1,
		adaptiveHeight: true,
		autoplay: true,
		autoplaySpeed: 3000
	});
}
function getCateAndBanner(){
	var json_list;
	json_list = <%@ include file="/mobilefirst/http/json/bannerAndCate.json"%>;
	//배너
	var json = json_list.top;
	if(json.banner){
		var template = "";
				
		for(var i=0;i<json.banner.length;i++){
			if(nowTime >= json.banner[i].sdate && nowTime <= json.banner[i].edate){
				if( (mType == "I" && json.banner[i].ios == "Y") || 
						(mType == "A" && json.banner[i].aos == "Y") ){
					template += "<li><a href=\"#\" onclick=\"goLink('"+json.banner[i].link+"','"+json.banner[i].txt+"');\"><img src=\""+json.banner[i].img+"\" alt=\"\"  /></li>";
				}
			}
		}
		$(".evtbnr").html(template);
	}
	//카테고리
	json = json_list.icon;
	if(json.cateIcon){
		var template = "";
		for(var i=0;i<json.cateIcon.length;i++){
			var classOn = "";
			if(i == 0)				classOn = "on";
			template += "<li class=\"cate_li "+classOn+"\" data-cate='"+json.cateIcon[i].cateCode+"' data-excate='"+json.cateIcon[i].ex_cateCode+"' onClick=\"onList(this,'"+json.cateIcon[i].cateCode+"','"+json.cateIcon[i].ex_cateCode+"','"+json.cateIcon[i].txt+"',"+(i+1)+");\"><img src=\""+json.cateIcon[i].iconImg+"\"/><span>"+json.cateIcon[i].txt+"</span></li>";
		}
		$(".mart_cate").html(template);
	}
	var firstCate = $(".mart_cate li:first").data("cate");
	var firstExCate = $(".mart_cate li:first").data("excate");
	var firstTxt = $(".mart_cate li:first span").html();
	//list load
	getList(firstCate,firstExCate,firstTxt);
}
function getJsonRandom(){
	var json_list;
	json_list = <%@ include file="/mobilefirst/http/json/allMart.json"%>;
	if(json_list.shoplist){
		/**************category별 제품 랜덤 ******************/
		//group max값 구하기
		var maxGroupNo = 1;
		for(var i=0; i<json_list.shoplist.length; i++){
			if(json_list.shoplist[i].group >= maxGroupNo){
				maxGroupNo = json_list.shoplist[i].group;
			}
		}
		//max 배열 생성
		for(var i=0; i<maxGroupNo; i++){
			arrGroup[i] = new Array();
			arrGroupNum[i] = new Array();
		}
		for(var l=0; l<maxGroupNo; l++){
			var num = 0;
			for(var i=0; i<json_list.shoplist.length; i++){
				if(json_list.shoplist[i].group == (l+1)){
					var goodsList = eval("json_list['"+json_list.shoplist[i].shop+"'].goodsList");
					if(goodsList){
						var goodsListLen = eval("json_list['"+json_list.shoplist[i].shop+"'].goodsList.length");
						for(var j=0; j<goodsListLen; j++){
							var goodArr = eval("json_list['"+json_list.shoplist[i].shop+"'].goodsList"+"["+j+"]");
							arrGroup[l].push(goodArr);
							arrGroupNum[l].push(num);
							num = num + 1;
						}
					}
				}
			}
		}
		for(var i=0; i<arrGroupNum.length; i++){
			arrGroupNum[i].shuffle();
			//arrGroupNum[i].printout();
		}
		/**************category별 제품 랜덤 끝******************/
	}
}
function getList(strCate,strExCate,strTxt){
	var totalCnt = 0;
	var template = "";
	//BEST 카테고리별 개수
	var cateNum = new Array();
	for(var m=0; m<$(".mart_cate").find("li").length; m++){
		cateNum[m] = 0;
	}
	for(var i=0; i<arrGroupNum.length; i++){	
		var goodsInfo = new Object();
		goodsInfo.goodsList = arrGroup[i];
		var jsonInfo = JSON.stringify(goodsInfo);
		var jsondata =  JSON.parse(jsonInfo);
		
		for(var l=0; l<arrGroupNum[i].length; l++){
			var goodArr = jsondata.goodsList[arrGroupNum[i][l]];

			//카테고리 검사
			var bCate = false;
			if(strCate == ""){//BEST
				//카테고리별 5개씩 충족되었을 시 break;
				var bNum = 0;
				var cateLen = $(".mart_cate").find("li").length;
				for(var m=0; m<cateLen; m++){
					if(cateNum[m] >= 5){
						bNum = bNum + 1;
					}
				}
				if(bNum == cateLen-1){
					break;
				}
				
				//카테고리별 5개씩 선정
				for(var m=0; m<cateLen; m++){
					var cate = $(".mart_cate").find("li").eq(m).data("cate");
					var exCate = $(".mart_cate").find("li").eq(m).data("excate");
					if(cate != ""){
						bCate = checkCate(goodArr,cate.toString(),exCate.toString());
						if(bCate){
							if(cateNum[m] < 5){
								cateNum[m] = cateNum[m] + 1;
							}else{
								bCate = false;
							}
							break;
						}
					}
				}
			}else{
				bCate = checkCate(goodArr,strCate,strExCate);
			}
			
			if(bCate){
				var tmp = writeTemplate(goodArr);
				template = template + tmp;
				totalCnt = totalCnt + 1;
			}
		}
	}
	$(".mart_list").html(template);
	$(".mart_tit").html("<strong>"+strTxt+"</strong>"+CommaFormattedN(totalCnt)+"개");
	zzimCheckSet();
	if(strCate == "")		randomBest();
}
//BEST random
function randomBest(){
	var len = $(".mart_list li").length;
    $(".mart_list").each(function(){
    	var ul = $(this);
        var liArr = ul.children('li');
        liArr.sort(function() {
        	var temp = parseInt(Math.random()*len);
            var temp1 = parseInt(Math.random()*len);
            return temp1-temp;
        }).appendTo(ul);
    });
}
//콤마 옵션
function CommaFormattedN(amount) {
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
function imgLoad(doc,shopNm){
	$(doc).parent().html(shopNm);
}
//category 클릭
function onList(doc,strCate,strExCate,strTxt,num){
	nowCate = num;
	ga('send', 'event', 'mf_mart', 'cate', 'cate_'+nowCate+"_"+strTxt);
	$(".cate_li").removeClass("on");
	$(doc).addClass("on");
	getList(strCate,strExCate,strTxt);
}
//category 체크
function checkCate(goodArr,strCate,strExCate){
	var arrStrCate = strCate.split(',');
	var arrStrExCate = strExCate.split(',');
	
	var bCate = false;
	for(var m=0; m<arrStrCate.length; m++){
		//카테고리 검사
		var prodCate = goodArr.ca_code.substr(0,arrStrCate[m].length);
		if(arrStrCate[m] != "" && prodCate == arrStrCate[m]){
			bCate = true;
			//제외 카테고리 검사
			for(var n=0; n<arrStrExCate.length; n++){
				var prodExCate = goodArr.ca_code.substr(0,arrStrExCate[n].length);
				if(arrStrExCate[n] != "" && prodExCate == arrStrExCate[n]){
					bCate = false;
				}
			}
			if(bCate){
				break;
			}
		}
	}
	return bCate;
}
function goLink(url,txt){
	ga('send', 'event', 'mf_mart', 'banner', 'banner_'+txt);
	location.href = url;
}
function goLinkBuy(url,scode,txt){
	ga('send', 'event', 'mf_mart', 'buy', 'buy_'+scode+"_cate_"+nowCate+"_"+txt);
	location.href = url;
}
function writeTemplate(goodArr){
	var template = "";
	template += "<li>";
	template += "<a href='javascript:///' onClick=\"goLinkBuy('"+goodArr.url+"','"+goodArr.shopCode+"','"+goodArr.goodsnm+"');\">";
	template += "	<span class=\"thum\">";
	template += "	<img src=\""+goodArr.imgurl+"\" />";
	template += "	</span>";
	template += "	<div class=\"info\">";
	template += "		<span class=\"mall\">";
	template += "		<img src=\"http://imgenuri.enuri.gscdn.com/images/view/ls_logo/2013/Ap_logo_"+goodArr.shopCode+".png\" alt=\""+goodArr.shopName+"\" onerror=\"this.style.visibility='hidden';\" />";
	template += "		</span>";
	template += "		<strong>"+goodArr.goodsnm+"</strong>";
	template += "		<div class=\"price\">";
	if(goodArr.discount_rate)		template += "			<span class=\"sale\"><b>"+goodArr.discount_rate+"</b>%</span>";
	
	template += "			<span class=\"prc\">";
	if(goodArr.orgPrice && goodArr.orgPrice != ""){
		template += "		<del>"+CommaFormattedN(goodArr.orgPrice)+"원</del>";
	}
	template += "			<b>"+CommaFormattedN(goodArr.price)+"</b>원";
	template += "			</span>";
	template += "		</div>";
	//찜 
	template += "		<div class=\"zzimarea\" onclick=\"event.cancelBubble=true;\">";
	template += "			<button type=\"button\" class=\"heart\" onclick=\"zzimSet('"+goodArr.modelno+"' , '"+goodArr.pl_no+"' ,this , '"+goodArr.shopCode+"');\" id=\"P_"+goodArr.pl_no+"\">찜</button>";
	template += "		</div>";
	//찜끝
	template += "	</div>";
	template += "</a>";
	
	if(goodArr.pCnt || goodArr.option != ""){
		template += "<div class=\"option_area\">";
		if(goodArr.pCnt)			template += CommaFormattedN(goodArr.pCnt)+"개 구매";
		//옵션 (ex:무료배송, 카드할인 ..)
		if(1==2 && goodArr.option != ""){
			var optionStr = goodArr.option.split(',');
			for(var k=0; k<optionStr.length; k++){
				template += "<em>"+optionStr[k]+"</em>";
			}
		}
		template += "</div>";
	}
	template += "</li>";
	return template;
}
//random
Array.prototype.shuffle = function(){ 
	var num = this.length; 
	var temp, rnd; 
	var i; 
	for(i=0; i<num; i++) { 
		rnd = Math.floor(Math.random()*num); 
		temp = this[i]; 
		this[i] = this[rnd]; 
		this[rnd] = temp; 
	} 
}; 
Array.prototype.printout = function(){ 
	var num = this.length; 
	var i; 
	for(i=0; i<num; i++) { 
		console.log( this[i] ); 
	} 
}; 

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
        ga('send', 'event', 'mf_mart', 'mart_zzim', shopcode+"_"+plno);
        
        $(obj).attr("class","hearton");
        //$(obj).after("<span class=\"zzimly fade-out\" style=\"display: inline;\">찜 되었습니다</span>");
                    $(".zzimly").fadeIn( 820, function() {
                   setTimeout(function(){
                        $( ".zzimly" ).fadeOut( 760, function() {
                            $(".zzimly").hide();    
                        });
                    }, 450);
              });
        
    }else{ //찜상품일 경우
        zzimDelete("N","P:"+plno);
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
<%@ include file="/mobilefirst/include/common_logger.html"%>