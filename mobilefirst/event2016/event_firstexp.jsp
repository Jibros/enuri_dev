<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%
String browser = request.getHeader("User-Agent");

if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1 
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1 
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
|| ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){

}else{
	response.sendRedirect("/event2016/p_event_firstexp.jsp");	//pc url 
}

String chkId = ChkNull.chkStr(request.getParameter("chk_id"));

String cUserId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");

Members_Proc members_proc = new Members_Proc();

String cUsername = "";
String userArea = "";

if(!cUserId.equals("")){

	cUsername = members_proc.getUserName(cUserId);
	userArea = cUsername;
	
	if(cUsername.equals("")){
		userArea = cUserNick;
	}
	if(userArea.equals("")){
		userArea = cUserId;
	}

}


Cookie[] carr = request.getCookies();
    String strAppyn = "";
    String strVerios = "";
    String strAd_id = "";
    int intVerios = 0;
     
    try {
        for(int i=0;i<carr.length;i++){
            if(carr[i].getName().equals("appYN")){
                strAppyn = ChkNull.chkStr(carr[i].getValue(),"");
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
            if(carr[i].getName().equals("adid")){
                strAd_id = carr[i].getValue();
                break;
            } 
        }
    } catch(Exception e) { 
    }

    if(strAppyn.equals("")){
        strAppyn = ChkNull.chkStr(request.getParameter("app"),"");    
    }
    

//facebook 썸네일 관련
String strFb_title = "에누리 가격비교";
String strFb_description = "에누리 모바일 가격비교";
String strFb_img = "http://imgenuri.enuri.gscdn.com/images/mobilenew/images/enuri_logo_facebook200.gif";

//이벤트 설정
String strEvent_code = "2016050101";
String strEvent_name = "신규고객이벤트";
String strEvent_class = "Welcome";	//프로모션별 클래스 : 혜택 Benefit / 웰컴 Welcome / 출석 Attend / 구매 Buy / 추천 Recommend

String strGno     = ChkNull.chkStr(cb.GetCookie("GATEP","GNO"),"");
String strGkind     = ChkNull.chkStr(cb.GetCookie("GATEP","GKIND"),"");

String loc = ChkNull.chkStr(request.getParameter("loc"));

%>
<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8">	
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />	
	<meta property="og:title" content="<%=strFb_title %>">
	<meta property="og:description" content="<%=strFb_description %>">
	<meta property="og:image" content="<%=strFb_img %>">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/event/common_area.css"/>
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/event/filck.css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/event/new_june.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/flick.event.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/iscroll.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/event_common.js"></script> 
</head>

<body>

<div class="<%=strEvent_class %>">

<%@ include file="/mobilefirst/event2016/event_top.jsp" %>

<!-- 앱전용 이벤트 --> 
<!-- 
<div class="layer_back" id="app_only" style="display:none;">
    <div class="appLayer">
        <h4>모바일 앱 전용 이벤트</h4>
        <a href="javascript:///" class="close" onclick="onoff('app_only')">창닫기</a>
        <p class="txt"><strong>가격비교 최초!</strong><em>현금 같은 혜택</em>을 제공하는<br />에누리앱을 설치합니다.</p>
        <p class="btn_close"><button id="install" onclick="go_install()" >설치하기</button></p>
    </div>
</div>
 -->

<!-- 첫구매 --> 
<div class="layer_back" id="first" style="display:none;">
    <div class="Layer" id="first_shopping"></div>
</div>

<!-- 첫설치 유의사항 --> 
<div class="layer_back" id="review" style="display:none;">
    <div class="noteLayer">
        <h4>유의사항</h4>
        <a href="javascript:///" class="close" onclick="onoff('review')">창닫기</a>
        <ul class="txtlist" id="firstNotice">
            <li>이벤트 기간 : 2016년 6월 1일 ~ 6월 30일</li>
            <li>대상자 : 2016년 2월 15일 이후 앱 첫 설치하고 6월 30일 이내 앱 이벤트 페이지에서 e머니받기 버튼 클릭 시 e머니 적립</li>
            <li>ID, 기기 당 1회 적립 (중복적립 불가)</li>
            <!--<li>추천을 받고 앱설치 시, 본인과 추천회원에게 각 1,000점 즉시 적립</li>--><!-- 앱 에서만 노출 -->
            <li>e머니 유효기간: 적립일부터 30일</li>
            <li>적립된 e머니는 앱 설치 후 다양한 e쿠폰 상품으로 교환 가능합니다.</li>
            <li>부정 참여 시 적립이 취소될 수 있습니다.</li>
            <li>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</li>
        </ul>
    </div>
</div>

<!-- 첫구매 유의사항 --> 
<div class="layer_back" id="notetxt" style="display:none">
    <div class="noteLayer h_layer">
        <h4>유의사항</h4>
        <a href="javascript:///" class="close" onclick="onoff('notetxt')">창닫기</a>
        <dl class="txtlist" id="firstBuyNotice">
            <dt>이벤트 기간</dt>
            <dd>2016년 6월 1일 ~ 6월 30일</dd>

            <dt>첫 구매자 대상</dt>
            <dd>2016년 5월 3일 이후 앱 첫 설치하고 6월 30일 이내</dd>
            <dd>에누리 앱 로그인 후 대상쇼핑몰에서 1천원 이상 (배송비, 설치비 제외한 최종 결제 금액) 처음 구매한 고객 (배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 최종 결제 금액)</dd>

            <dt>대상 쇼핑몰</dt>
            <dd>G마켓, 11번가, 인터파크, 티몬, GS SHOP, CJmall, 옥션</dd>

            <dt>혜택</dt>
            <dd>e머니 3,000점</dd>
            <dd>구매 후 6월 30일 이내 앱 이벤트 페이지에서 신청하기 버튼 클릭 시 e머니 적립</dd>
            <dd>적립 시점<br />
            - 확정구매 전 신청 : 확정구매 후 적립<br />
            - 확정구매 후 신청 : 다음 날 적립 (확정구매 : 결제일로부터 10일)
            </dd>
            <dd>적립된 e머니는 앱 설치 후 다양한 e쿠폰 상품으로 교환 가능합니다.</dd>

            <!-- 앱 에서만 노출 -->
            <% if(strAppyn.equals("Y")){%>
            <!-- <dt>친구 추천 혜택</dt> -->
            <!-- <dd>추천 받고 첫 구매 시 (배송비, 설치비 제외한 최종 결제 금액 1만원 이상 / 앱에서 이전 구매이력 없음) 본인에게 2천점, 추천한 회원에게 1만점 추가 적립</dd> -->
            <% } %>
            <!--// 앱 에서만 노출 -->

            <dt>유의사항</dt>
            <dd>취소, 반품 시 대상 제외 됨</dd>
            <dd>ID, 기기 당 1회 적립 (중복적립 불가)</dd>
            <dd>e머니 유효기간: 적립일부터 30일</dd>
            <dd>부정 참여 시 적립이 취소될 수 있습니다.</dd>
            <dd>본 이벤트는 당사 사정에 따라 사전고지 없이 변경 또는 종료될 수 있습니다.</dd>
        </dl>
    </div>
</div>

<div class="con01"><!-- 앱일 경우 app 추가 -->
    <div class="content">
        <h2>첫설치01 앱 첫 설치하면 반가워서 즉시적립</h2>
        <a href="javascript:///" class="btn" id="all_view">앱 설치하기</a>
        
        <ul class="txt">
            <li>적립 대상 : 2016년 2월 15일 이후 앱 첫 설치</li>
            <li>적립 방법 : 6월30일 이내 앱에서 로그인 후 받기 버튼 클릭</li>
        </ul>

        <a href="javascript:///" class="note_view" onclick="onoff('review')">유의사항</a>
    </div>
    
</div>

<div class="con02"><!-- 앱일 경우 app 추가 -->
    <div class="content">
        <h2>첫설치02 앱에서 첫 구매하면 고마워서 추가적립</h2>
        <a href="javascript:///" class="btn" onclick="firstShopping()">앱에서 구매하기</a>
        <ul class="txt">
            <li>적립 대상 : 5월 3일 이후 앱 첫 설치하고 6월 30일 이내 구매</li>
            <li>적립 방법 : 적립대상 쇼핑몰에서 구매하고 6월 30일 이내 신청하기</li>
        </ul>

        <a href="javascript:///" class="note_view" onclick="onoff('notetxt')">유의사항</a>
    </div>
    
</div>

<%@ include file="/mobilefirst/event2016/event_bottom.jsp" %>

</div>

</body>
</html>
<script>
var vEvent = "<%=strEvent_class %>"; 
var strApp = "<%=strAppyn%>";
var vEvent_title = "신규고객이벤트";
var vEvent_page = "/mobilefirst/event2016/event_firstexp.jsp";
var username = "<%=userArea%>";
var vChkId = "<%=chkId %>";

var app = getCookie("appYN");

$(document).ready(function() {
	
	if(strApp =='Y' ){
		
		ga('send', 'pageview', {
			'page': vEvent_page,
			'title': vEvent_title+'_APP'
		});
		
		$('.con01').addClass("app");
        $('.con02').addClass("app");
		
		//$('#firstNotice li:last').after('<li>추천을 받고 앱설치시, 본인과 추천회원에게 각각 1,000점 적립</li>');
        //$('#firstBuyNotice').append('<dd>추천을 받고 1만원 이상 첫구매시, 본인에게 5,000점, 추천회원에게 10,000점 적립</dd>');
		
	}else{
        $('.con01').removeClass("app");
        $('.con02').removeClass("app");
        	   
		ga('send', 'pageview', {
			'page': vEvent_page,
			'title': vEvent_title+'_WEB'
		});
	}
	
	var loc = "<%=loc%>";
    
    if(loc == '2'){
        var pos = 630;
        $("html, body").animate({scrollTop:pos},'slow');
    }
	
	
	if(islogin()){
		getPoint();
	}
	
	$( ".win_close" ).click(function(){
		if(strApp == 'Y'){
			window.location.href = "close://";
		}else{
			window.location.replace("/mobilefirst/Index.jsp");
		}
		
	});
    
    /*
	$(".my_e").click(function(){
	
		if(strApp == 'Y'){
			ga('send', 'event', '<%=strEvent_name %>_APP', 'button', '내 e머니 확인하기');
			location.href="/mobilefirst/emoney/emoney.jsp?&freetoken=emoney";
			return false;
		}else{
			ga('send', 'event', '<%=strEvent_name %>_WEB', 'button', '내 e머니 확인하기');
			$("#app_only").show();
		}
	
		//location.href="/mobilefirst/emoney/emoney.jsp?&freetoken=emoney";
	});
	*/

	$(".btn_login").click(function(){
		ga('send', 'event', 'mf_event', '프로모션공통영역', '무빙탭_개인화영역');
		if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
			location.href = "/mobilefirst/login/login.jsp";
		}else	if(navigator.userAgent.indexOf("Android") > -1){
			location.href = "/mobilefirst/login/login.jsp?backUrl="+vEvent_page+"?freetoken=event&chk_id="+vChkId;
		}
		
	});
	
	
	//앱받고 e머니 받기
    $("#all_view").click(function(){
            
            if(datePopUpSet("2016/06/30","popup")){
                alert("6월 이벤트 종료!\n7월 이벤트는\n7/1에 곧 오픈 예정 입니다.\n");
	            return false;
            }
            
            if(strApp != 'Y' ){
                
                ga('send', 'event', '신규고객이벤트_WEB', 'button', '앱받고 e머니 받기');
                $("#app_only").show();
                
                return false;
            }
                    ga('send', 'event', '신규고객이벤트_APP', 'button', '앱받고 e머니 받기');
                        
                    if(!islogin()){
                        
                        if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
                            location.href = "/mobilefirst/login/login.jsp";
                        }else   if(navigator.userAgent.indexOf("Android") > -1){
                            location.href = "/mobilefirst/login/login.jsp?backUrl=/mobilefirst/event/event_three.jsp?freetoken=event";
                        }
                        
                        return false;
                    }
                    
                    var chkId = "<%=chkId%>";
                    var goUrl = "/mobilefirst/ajax/rewardAjax/memberRevolutionAjax2.jsp"+"?chkId="+chkId;
                    
                    $.ajax({
                            url: goUrl,
                            dataType: 'json',
                            async: false,
                            success: function(data){
                                
                                if(data.result == 'S' || data.result == 'NU' || data.result == 'NN') {
                                     
                                     if(data.nomieeYN){
                                         alert("설치해 주셔서 감사합니다. 추천 첫설치 축하! 1천점 적립되었습니다.");
                                         location.href="/mobilefirst/emoney/emoney.jsp?freetoken=emoney";
                                         return false;
                                     }else{
                                         alert("설치해 주셔서 감사합니다. e머니 500점이 적립되었습니다.");
                                         location.href="/mobilefirst/emoney/emoney.jsp?freetoken=emoney";
                                         return false;
                                     }

                                }else if(data.result == 'UN'){
                                    alert("유저 아이디가 없습니다. 로그인 확인해 주세요");
                                    return false;
                                }else if(data.result == 'DN'){
                                    alert("시스템 오류 입니다. 앱을 새로 실행 주세요 새로 실행해도 같은 메세지가 나올 경우 고객 센터로 연락 주세요 ");
                                    return false;
                                }else if(data.result == 'AR'){ //이미 적립군 동의
                                    alert("설치해주셔서 감사합니다.\n기존 설치 고객님입니다.");
                                    location.href="/mobilefirst/emoney/emoney.jsp?freetoken=emoney";
                                }else if(data.result == 'F'){
                                    //alert("시스템 오류가 발생했습니다. ");
                                }else if(data.result == 'IN'){
                                    //alert("해당 기기는 설치 확인이 되지 않습니다. ");
                                    location.href="/mobilefirst/emoney/emoney.jsp?freetoken=emoney";
                                }else if(data.result == 'RU'){
                                    //alert("해당 기기는 적립군 기기로 등록 되었습니다. \n 한기기당 적립군 한 아이디만 등록 가능 합니다.");
                                    alert("설치해주셔서 감사합니다.\n기존 설치 고객님입니다.");
                                    location.href="/mobilefirst/emoney/emoney.jsp?freetoken=emoney";
                                }else if(data.result == 'UV'){
                                    alert("설치해주셔서 감사합니다.\n기존 설치 고객님입니다.");
                                    location.href="/mobilefirst/emoney/emoney.jsp?freetoken=emoney";
                                    return false;
                                }
                                                        
                            }
                        });
                            
                            //location.href = "/mobilefirst/event/event_cashback.jsp";
                    });
    
	
});


//해당 날짜 이상일 경우는 해당 함수를 호출 하지 않는다.
//setDate = 설정 날짜
//setFct = 설정 함수
function datePopUpSet(setDate,setFct){
    var now = new Date(); 
    var todayAtMidn = new Date(now.getFullYear(),now.getMonth(),now.getDate());
    var specificDate = new Date(setDate);
    if(specificDate.getTime() < todayAtMidn.getTime()){
        return true;        
    }else{
        return false;       
    }
}

function go_install(){
    
    if(strApp == 'Y' ){
        ga('send', 'event', '신규고객이벤트_APP', 'button', '설치하기');
    }else{
        ga('send', 'event', '신규고객이벤트_WEB', 'button', '설치하기');
    }
    appDown();
    
}

function appDown(){

        var strGkind = '<%=strGkind%>'+'';
        var strGno = '<%=strGno%>'+'';
        
        setLog();
        
        if(strGkind == '' &&  strGno == ''){
               
            if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
                location.href = "https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8&freetoken=outlink";
            }else if(navigator.userAgent.indexOf("Android") > -1){
                location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Dramen_event%26utm_medium%3Devent_button%26utm_campaign%3Dpromotion_ramen_event_web";
            }
        
        }else{
            getGateMarketUrl();
        }
}



function getGateMarketUrl(){
            
            var strGno = '<%=strGno%>'+'';
            var strGkind = '<%=strGkind%>'+'';

            var vData = {tg_id : strGno , tg_from : strGkind};
            var sTag_id;
            $.ajax({
                type: "POST",
                async : false,
                url: "/mobilefirst/ajax/gate_getList.jsp",              
                data : vData ,
                dataType: "JSON",
                success: function(data){
                    
                    sTag_id = data.gatelist;
                    
                    if(sTag_id.length > 0){
                    
                        var google_url = sTag_id[0].google_url;
                        var tg_keyword = sTag_id[0].tg_keyword;
                        
                        if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
                            location.href = "https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8&freetoken=outlink";
                        }else if(navigator.userAgent.indexOf("Android") > -1){
                            
                            if(google_url != ""){
                                location.href = google_url;
                            }else{
                                location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Dramen_event%26utm_medium%3Devent_button%26utm_campaign%3Dpromotion_ramen_event_web";
                            }
                                                    
                        }
                    
                    }else{
                    
                         if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
                            location.href = "https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8&freetoken=outlink";
                          }else if(navigator.userAgent.indexOf("Android") > -1){
                            location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Dramen_event%26utm_medium%3Devent_button%26utm_campaign%3Dpromotion_ramen_event_web";
                          }
                    }

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert(xhr.status);
                    alert(thrownError);
                }
            });
        
            //return sTag_id;
        }



//첫구매 확인
function firstShopping(){
        
        if(datePopUpSet("2016/06/30","popup")){
            alert("6월 이벤트 종료!\n7월 이벤트는\n7/1에 곧 오픈 예정 입니다.\n");
            return false;
        }
        
        if(strApp != 'Y'){
            ga('send', 'event', '신규고객이벤트_WEB', 'button', '첫구매 대상 확인');
            onoff('app_only');
            return false;   
        }else{
            ga('send', 'event', '신규고객이벤트_APP', 'button', '첫구매 대상 확인');
        }
        
        if(!islogin()){
            
            alert("로그인 후 이용할 수 있습니다.");
            
            if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
                location.href = "/mobilefirst/login/login.jsp";
            }else   if(navigator.userAgent.indexOf("Android") > -1){
                location.href = "/mobilefirst/login/login.jsp?backUrl=/mobilefirst/event/event_three.jsp?freetoken=event";
            }
            return false;
        }
        
        $.ajax({ 
            type: "GET",
            url: "/mobilefirst/ajax/eventAjax/mobileTokenAjax.jsp",
            async: false,
            dataType:"JSON",
            success: function(json){
                
                var fdate = json.version_first_date; //설치 날짜
                var point_date = json.min_date_01 ; //첫구매 날짜
                var fix_date = json.min_date_04 ; // 구매확정 날짜
                var fix_date_04 = json.min_date_04 ; // 구매확정 날짜
                var version_first = json.version_first ; //첫버전
                var firstYN = json.firstYN ; //첫버전
                
                //fdate = '2016-02-15';
                //point_date = 0;
                
                //구매 날짜
                if(point_date != "0"){
                
                    point_date = point_date.substring(0,10);
                    point_date = point_date.replace(/-/gi, '');
                    
                    
                    yy = point_date.substring(0,4);
                    mm = point_date.substring(4,6);
                    dd = point_date.substring(6,8);
                
                    point_date = new Date(mm+"/"+dd+"/"+yy);
                    point_date.setDate(point_date.getDate());
                    
                }
                
                if(fdate != "0"){
                    
                    fdate = fdate.substring(0,10);
                    fdate = fdate.replace(/-/gi, '');
                
                    yy = fdate.substring(0,4);
                    mm = fdate.substring(4,6);
                    dd = fdate.substring(6,8);
                
                    fixDate = new Date(mm+"/"+dd+"/"+yy);
                    fixDate.setDate(fixDate.getDate()+30);
                    
                    fdate = new Date(mm+"/"+dd+"/"+yy);
                    
                }
                
                //alert("version_first:"+version_first +"== point_date"+point_date + "===fdate:"+fdate );
                //alert("today : "+today+ "===fixDate" +fixDate );
                today = new Date();
                //fdate = new Date("2016/02/30");
                
                //fixDate = new Date("2016/03/10");
                
                //point_date = new Date("2016/03/05");
                
                //console.log("fixDate : "+fixDate);
                //console.log("point_date : "+point_date);
                //console.log("today : "+today);
                //console.log("fdate : "+fdate);
                
                if(firstYN > 0 ){
                     
                     if(json.nomieeYN){ //친구 추천 여부
                     
                        if(cartRealPrice >= 10000){
                           
                            var html ="<a href=\"javascript:///\" class=\"close\" onclick=\"onoff('first')\">창닫기</a>";
                             html +="<p>추천 첫구매 축하! 5000점이 적립 되었습니다.</p>";
                             html +="<p class=\"btn_close\"><button type=\"button\" id='goEmoney' onclick=\"goEmoney()\">e머니 교환 상품 보기</button></p>";
                            $("#first_shopping").html(html);
                           
                        }else{
                            
                            var html ="<a href=\"javascript:///\" class=\"close\" onclick=\"onoff('first')\">창닫기</a>";
                             html +="<p>고객님은 첫 구매 혜택 3,000점 받으셨습니다.</p>";
                             html +="<p class=\"btn_close\"><button type=\"button\" id='goEmoney' onclick=\"goEmoney()\">e머니 교환 상품 보기</button></p>";
                            $("#first_shopping").html(html);
                                                
                        }
                     
                     }else{
                                                             
                         var html ="<a href=\"javascript:///\" class=\"close\" onclick=\"onoff('first')\">창닫기</a>";
                         html +="<p>고객님은 첫 구매 혜택 3,000점 받으셨습니다.</p>";
                         html +="<p class=\"btn_close\"><button type=\"button\" id='goEmoney' onclick=\"goEmoney()\">e머니 교환 상품 보기</button></p>";
                        $("#first_shopping").html(html);
                     
                     }
                     
                } else if( fdate <  new Date("2016/02/15")  ){
                    
                    var html ="<a href=\"javascript:///\" class=\"close\" onclick=\"onoff('first')\">창닫기</a>";
                     html +="<p>아쉽게도<br/> 첫 구매 혜택 대상자가 아닙니다.</p>";
                    $("#first_shopping").html(html);    
                    
                }else if( fdate >= new Date("2016/02/15") &&  today >=  fixDate || point_date >= fixDate ){ // 첫설치 날짜 +30 보다 오늘 날짜가 더 크면
                    
                    var html ="<a href=\"javascript:///\" class=\"close\" onclick=\"onoff('first')\">창닫기</a>";
                    html +="<p>아쉽게도<br/> 첫 구매 혜택 대상자가 아닙니다.</p>";
                    html +="<p>첫 설치 후 30일 이내 구매하고 신청하셔야<br/> 혜택 받으실 수 있습니다.</p>";
                    $("#first_shopping").html(html);
                
                }else if( fdate >= new Date("2016/02/15") && point_date ==  "0" ){
                    
                    yy = fdate.getFullYear();
                    mm = fdate.getMonth()+1;
                    dd = fdate.getDate();
                    
                    var shoppingDate = new Date(mm+"/"+dd+"/"+yy);
                    shoppingDate.setDate(shoppingDate.getDate()+30);
                    
                    yy_2 = shoppingDate.getFullYear();
                    mm_2 = (shoppingDate.getMonth()+1);
                    dd_2 = shoppingDate.getDate();
                    
                    if(json.nomieeYN){
                        
                        var html ="<a href=\"javascript:///\" class=\"close\" onclick=\"onoff('first')\">창닫기</a>";
                        html +="<p>고객님은 <em class=\"blue\"> "+yy+"년"+mm+"월"+dd+"일 </em><br />첫 설치해 주셨습니다.</p>";
                        html +="<p><em class=\"blue\">"+yy_2+"년 "+mm_2+"월 "+dd_2+"일</em> 까지 첫 구매 후 신청하고";
                        html +="<br /><span class='e'>머니</span><em class=\"blue\">5,000점</em> 받으세요~</p>";
                        $("#first_shopping").html(html);
                                            
                    }else{
                        var html ="<a href=\"javascript:///\" class=\"close\" onclick=\"onoff('first')\">창닫기</a>";
                        html +="<p>고객님은 <em class=\"blue\"> "+yy+"년"+mm+"월"+dd+"일 </em><br />첫 설치해 주셨습니다.</p>";
                        html +="<p><em class=\"blue\">6월30일</em> 까지 첫 구매 후 신청하고";
                        html +="<br /><span class='e'>머니</span><em class=\"blue\">3,000점</em> 받으세요~</p>";
                        $("#first_shopping").html(html);    
                    }
                    
                } else if( fdate >= new Date("2016/02/15") && point_date  <=  fixDate  ){ //첫 설치 30 이내 물건을 구입했을 경우
                    
                    var chkId = "<%=chkId%>";
        
                    $.ajax({ 
                        type: "POST",
                        url: "/mobilefirst/ajax/eventAjax/ajax_FirstShopping_proc.jsp",
                        async: false,
                        data: { chkid: chkId },
                        dataType:"JSON",
                        success: function(json){
                            
                            if(json.result){
                                var html ="<a href=\"javascript:///\" class=\"close\" onclick=\"onoff('first')\">창닫기</a>";
                                 html +="<p>첫 구매해 주셔서<br />진심으로 감사 드립니다</p>";
                                 html +="<p>확정구매(결제일로부터 10일) 후<br /><span class='e'>머니</span> <em class=\"blue\">적립</em>되며 push 알림 됩니다.</p>";
                                 html +="<p class=\"btn_close\"><button type=\"button\" id='goEmoney' onclick=\"goEmoney()\">e머니 교환 상품 보기</button></p>";
                                $("#first_shopping").html(html);    
                            }else{
                                alert("시스템 오류 입니다. 새로고침 후 다시 시도 하세요");
                            }
                        }
                    });
                    
                }else{
                
                    var html ="<a href=\"javascript:///\" class=\"close\" onclick=\"onoff('first')\">창닫기</a>";
                     html +="<p>아쉽게도<br/> 첫 구매 혜택 대상자가 아닙니다.</p>";
                    $("#first_shopping").html(html);
                    
                }
                
                $("#first").show();
                
            }
        
        });
        
    

}



function setLog(){

        var strGkind = '<%=strGkind%>'+'';
        var strGno = '<%=strGno%>'+'';
        
        if(strGkind == "42") ga('send', 'event', 'mf_event', '설치이벤트_WEB', 'SA 42 M_Naver');
        else if(strGkind == "43") ga('send', 'event', 'mf_event', '설치이벤트_WEB', 'SA 43 M_Daum');
        else if(strGkind == "44") ga('send', 'event', 'mf_event', '설치이벤트_WEB', 'SA 44 M_Google');
        else if(strGkind == "68" && strGno == "2900868") ga('send', 'event', 'mf_event', '설치이벤트_WEB', '모비온_첫설치');
        else if(strGno == '2663152') ga('send', 'event', 'mf_event', '설치이벤트_WEB', '쉘위애드_S_띠첫구매');
        else if(strGno == '2666901') ga('send', 'event', 'mf_event', '설치이벤트_WEB', '쉘위애드_S_띠첫구매_2');
        else if(strGno == '2666902') ga('send', 'event', 'mf_event', '설치이벤트_WEB', '쉘위애드_S_띠출첵1');
        else if(strGno == '2666903') ga('send', 'event', 'mf_event', '설치이벤트_WEB', '쉘위애드_S_띠리뷰1');
        else if(strGno == '2666904') ga('send', 'event', 'mf_event', '설치이벤트_WEB', 'shallwe_S_전면2');
        else if(strGno == '2666905') ga('send', 'event', 'mf_event', '설치이벤트_WEB', 'shallwe_S_전면3');
        else if(strGno == '2666906') ga('send', 'event', 'mf_event', '설치이벤트_WEB', '이노캐시_S_전면2');
        else if(strGno == '2666907') ga('send', 'event', 'mf_event', '설치이벤트_WEB', '이노캐시_S_전면3');
        else if(strGno == '2666908') ga('send', 'event', 'mf_event', '설치이벤트_WEB', 'Mcloud_S2');
        else if(strGno == '2666909') ga('send', 'event', 'mf_event', '설치이벤트_WEB', 'Mcloud_S3');
        else if(strGno == '2685388') ga('send', 'event', 'mf_event', '설치이벤트_WEB', 'shallwe_S_띠첫구매3');
        else if(strGno == '2685389') ga('send', 'event', 'mf_event', '설치이벤트_WEB', 'shallwe_S_띠리뷰2');
        else if(strGno == '2685390') ga('send', 'event', 'mf_event', '설치이벤트_WEB', 'Mcloud_S4_첫구매');
        else if(strGno == '2685391') ga('send', 'event', 'mf_event', '설치이벤트_WEB', 'Mcloud_S5_리뷰');
        else if(strGno == '2685392') ga('send', 'event', 'mf_event', '설치이벤트_WEB', '이노캐시_S_전면4');
        else if(strGno == '2685394') ga('send', 'event', 'mf_event', '설치이벤트_WEB', '이노캐시_S_전면5');
        else if(strGno == '2757159') ga('send', 'event', 'mf_event', '설치이벤트_WEB', '이노캐시_S_전면6');
        else if(strGno == '2757160') ga('send', 'event', 'mf_event', '설치이벤트_WEB', '이노캐시_S_전면7');
        else if(strGno == '2757162') ga('send', 'event', 'mf_event', '설치이벤트_WEB', 'Mcloud_S6');
        else if(strGno == '2757163') ga('send', 'event', 'mf_event', '설치이벤트_WEB', 'Mcloud_S7');
        else if(strGno == '2775484') ga('send', 'event', 'mf_event', '설치이벤트_WEB', '이노캐시_E4_1');
        else if(strGno == '2775485') ga('send', 'event', 'mf_event', '설치이벤트_WEB', '이노캐시_E4_2');
        else if(strGno == '2775486') ga('send', 'event', 'mf_event', '설치이벤트_WEB', '이노캐시_E4_3');
        
}


</script>
<script language="JavaScript" src="http://imgenuri.enuri.gscdn.com/common/js/Log_Tail_Mobile.js"></script>