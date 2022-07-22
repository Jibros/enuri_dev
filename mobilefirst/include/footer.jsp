<%@ page contentType="text/html; charset=utf-8" %>
<%
Date dtToday = new Date();

//테스트를 위한 코드 추가.
//여기서 날짜 세팅시 서버 시간 무시하고 request 값으로 시간 대체함. 형식은 yyyy-MM-dd
boolean issetdatetodayfromrequest = ChkNull.chkStr(request.getParameter("datetoday") , "" ).equals("") == false ? true : false; 

if (issetdatetodayfromrequest){ 
    dtToday = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("datetoday"));
}
String dateToday = new SimpleDateFormat("yyyy-MM-dd").format(dtToday);

Calendar c = Calendar.getInstance();
// 7월 12일까지.
c.set(2016, 6-1, 30 + 1, 0, 0, 0);
// 이벤트 종료 여부 플래그
boolean iseventend = dtToday.getTime() >= c.getTimeInMillis() ? true : false;
%>
<link rel="stylesheet" type="text/css" href="/mobilefirst/css/footer.css?ver=20190913"/>
<div class="justgo">
			<!-- 에누리 설치 -->
			<div class="install" style="display:none;"><!-- web일 때만 보임-->
				<ul>
					<li><a href="javascript:goLinkInstall();"><em>WEB</em><span>바로가기 설치</span></a></li>
					<li><a href="javascript:goAppInstall();"><em>APP</em><span>에누리앱설치</span></a></li>
				</ul>
			</div>
			<!-- //에누리 설치 -->

			<!-- 애누리 패밀리 앱 -->
			<div class="familyapp">
				<h3 class="maintit">에누리 패밀리 앱</h3>
				<ul>
					<li><a href="javascript:goSmartInstall();">스마트택배</a></li>
					<li><a href="javascript:goHomeShoppingInstall();">홈쇼핑가격비교</a></li>
					<li><a href="javascript:goHotDealInstall();">소셜가격비교</a></li>
					<!--<li><a href="javascript:golfInstall();">골프예약</a></li>-->
					<li><a href="javascript:directBuyInstall();">해외직구</a></li>
				</ul>
			</div>
			<!-- //애누리 패밀리 앱 -->
			<%
			 String urlfooter = request.getRequestURL().toString(); 
			 if( urlfooter.indexOf("/mobilefirst/trend_news.jsp") > -1  ){ 
			 %>
			<section class="evtbanner_btm ad_news" id="footerBannerAD">
            <script>
                var ttx_pub_code="1485011387";
                if("undefined"==typeof ttx_area_info||"null"==typeof ttx_area_info)var ttx_area_info=[];
                ttx_area_info.push({area_code:"1174991515",pag:"PAG"});
                var ttx_page_url="";
                var ttx_total_cookie_name="",ttx_total_result="";
                (function(){ttx_total_cookie_name="ttx_t_r";""==ttx_page_url&&(ttx_page_url=document.URL);var b=document.location.protocol+"//cdn-exchange.toastoven.net/cdn/adx/js/rta_all.js";
                var a=document.createElement("script");a.type="text/javascript";a.src=b;a.async=!0;
                0<document.getElementsByTagName("head").length?document.getElementsByTagName("head")[0].appendChild(a):0<document.getElementsByTagName("body").length&&document.getElementsByTagName("body")[0].appendChild(a)})();var ttx_cb_func=function(){};
                (function(){var ttx_pub_code="1485011387";
                var ttx_ad_area_code="1174991515";
                var ttx_ad_area_pag="PAG";
                var ttx_page_url="", ttx_direct_url="";
                var ttx_total_cookie_name="ttx_t_r";
                var e=function(a){a+="=";for(var c=document.cookie.split(";"),d=0;d<c.length;d++){for(var b=c[d];" "==b.charAt(0);)b=b.substring(1);if(0==b.indexOf(a))return b.substring(a.length,b.length)}return""},f="";try{f=JSON.stringify(JSON.parse(e(ttx_total_cookie_name))[ttx_ad_area_code])}catch(g){}var c="";""==ttx_page_url&&(ttx_page_url=document.URL);""==c&&document.referrer&&(c=document.referrer);var a="//adx-exchange.toast.com/a_request";
                a+="?pub_code="+ttx_pub_code+"&area_code="+ttx_ad_area_code+"&pag="+encodeURIComponent(ttx_ad_area_pag);a+="&site_url="+encodeURIComponent("")+"&page_url="+encodeURIComponent(ttx_page_url)+"&refer="+encodeURIComponent(c);a+="&result="+encodeURIComponent(f)+"&bnrs_e="+encodeURIComponent(e("ttx_bnrs_e"))+"&du="+encodeURIComponent(ttx_direct_url);a+="&rndm="+Math.random()+"&cst=";
                document.write("<script type='text/javascript' src='"+a+"' ><\/script>")})()
                </script>
            </section>
            <section class="evtbanner_btm" ><a href="javascript:///"><img src="http://storage.enuri.info/Web_Storage/pic_upload/mobile/banner/KING_FOOTER.jpg" alt=""></a></section>
			<%}else{%>
			<section class="evtbanner_btm" ><a href="javascript:///"><img src="http://storage.enuri.info/Web_Storage/pic_upload/mobile/banner/KING_FOOTER.jpg" alt=""></a></section>
			<%}%>
</div>
<footer>
<nav class="new_footer">
        <ul>
             <li class="com_info"><a href="javascript:///" id="comInfo"><span>사업자 정보</span></a></li>
             <li><a href="javascript:goPcEnuri();" target="_blank">PC버전</a></li>
        </ul>
   </nav>
	<div class="cominfo_txt" style="display:none" id="moreview">
		<section>
		에누리닷컴㈜는 통신판매 정보제공자이며, 상품의 주문/배송/환불에 대한 의무와 책임은 각 쇼핑몰에 있습니다.
		<p><strong><a href="/mobilefirst/Index.jsp">에누리닷컴㈜</a></strong>
			대표이사 : 최문석<span>|</span>사업자등록번호 : 206-81-18164<br />
			통신판매신고 : 2015-서울중구-1046호<br />
			서울시 중구 퇴계로 18(남대문로5가) 9 층 <br />
			문의 : 02-6354-3601<span>|</span>master@enuri.com
		</p>
		</section>
		<ul class="rule">
			<li><a href="javascript:openTermsWrap()" id="agree">이용약관</a></li>
			<li><a href="javascript:openPrivacyWrap()">개인정보취급방침</a></li>
			<li><a href="javascript:openRuleWrap()">법적고지</a></li>
		</ul>
	</div>
	<div class="newquick" id='aaaa'>
		<p class="TBtn" style="display:none"/>
		<%
			if(urlfooter.indexOf("mobilefirst") > -1) out.println("<p class='cateBtn gift'/>'");
			//if(urlfooter.indexOf("mobilefirst") > -1) out.println("<p class='cateBtn'/>'");
		%>
	</div>
    <%
       int ran = (int) (Math.random() * (2 - 0 + 1)) + 0;
       //int ran = 0;
	       if(ran == 0){
	    %>
        <div class="app_miniPop"  id="app_miniPop_F"  style="display:none" onclick="goFooterLink(1)">
            <div class=" olympic_mini"><a href="javascript:///" class="evtgo">응원하고 치킨먹자!</a></div>
        </div>
	    <%}else{%>
            <div class="app_miniPop"  id="app_miniPop_F"  style="display:none"  onclick="goFooterLink(3)">
                <div class="movie2_mini"><a href="javascript:///" class="evtgo">영화배너</a></div>
            </div>  
	    <%}%>
</footer>
<script type="text/javascript">
/*
 * jQuery throttle / debounce - v1.1 - 3/7/2010
 * http://benalman.com/projects/jquery-throttle-debounce-plugin/
 * 
 * Copyright (c) 2010 "Cowboy" Ben Alman
 * Dual licensed under the MIT and GPL licenses.
 * http://benalman.com/about/license/
 */
(function(b,c){var $=b.jQuery||b.Cowboy||(b.Cowboy={}),a;$.throttle=a=function(e,f,j,i){var h,d=0;if(typeof f!=="boolean"){i=j;j=f;f=c}function g(){var o=this,m=+new Date()-d,n=arguments;function l(){d=+new Date();j.apply(o,n)}function k(){h=c}if(i&&!h){l()}h&&clearTimeout(h);if(i===c&&m>e){l()}else{if(f!==true){h=setTimeout(i?k:l,i===c?e-m:e)}}}if($.guid){g.guid=j.guid=j.guid||$.guid++}return g};$.debounce=function(d,e,f){return f===c?a(d,e,false):a(d,f,e!==false)}})(this);

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
function gogogoversion(){
	alert(getCookie("verand"));
}
function goLinkInstall(){
	ga('send', 'event', 'mf_home', 'mf_family', 'famliy_웹_바로가기');
	// 접속 핸드폰 정보
	var userAgent = navigator.userAgent.toLowerCase();
	// 모바일 홈페이지 바로가기 링크 생성
	if(userAgent.match('iphone')) {
	    document.write('<link rel="apple-touch-icon" href="/mobile/image/apple-touch-icon.png" />') 
	} else if(userAgent.match('ipad')) {
	    document.write('<link rel="apple-touch-icon" sizes="72*72" href="/mobile/image/apple-touch-icon-ipad.png" />')
	} else if(userAgent.match('ipod')) {
	    document.write('<link rel="apple-touch-icon" href="/mobile/image/apple-touch-icon.png" />')  
	} else if(userAgent.match('android')) {
		
		var url = ["intent://addshortcut?version=18",
                    "&title=",
                    "가격비교&url=http://m.enuri.com",
                    "&icon=http://img.enuri.info/images/mobilefirst/ic_launcher.png",
                    "&serviceCode=2493",
                    "#Intent;",
                    "scheme=naversearchapp;",
                    "action=android.intent.action.VIEW;",
                    "category=android.intent.category.BROWSABLE;",
                    "package=com.nhn.android.search;",
                    "end"
                ];
                location.href = url.join("");
	} 
}
function goAppInstall(){
	ga('send', 'event', 'mf_home', 'mf_family', 'famliy_앱_설치');
	
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
		window.location.href = 'https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8'; 
	}else if(navigator.userAgent.indexOf("Android") > -1){
		location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_web_click%26utm_campaign%3Dfamilyapp20151209";
	}
}
//스마트택배
function goSmartInstall(){
		
		ga('send', 'event', 'mf_home', 'mf_family', 'famliy_스마트택배');
		
		if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
			location.href = "http://appstore.com/%EC%8A%A4%EB%A7%88%ED%8A%B8%ED%83%9D%EB%B0%B0%EB%AA%A8%EB%93%A0%ED%83%9D%EB%B0%B0%EC%A1%B0%ED%9A%8C%EC%87%BC%ED%95%91%EA%B4%80%EB%A6%AC?freetoken=outlink";
		}else if(navigator.userAgent.indexOf("Android") > -1){
			if(getCookie("appYN") == 'Y') location.href = "market://details?id=com.sweettracker.smartparcel&referrer=utm_source%Enuri%26utm_medium%app_banner%26utm_campaign%3Dinstall_promotion_from_Enuri";
			else location.href = "market://details?id=com.sweettracker.smartparcel&referrer=utm_source%Enuri%26utm_medium%app_banner%26utm_campaign%3Dinstall_promotion_from_Enuri_Web";			
		}
}
//홈쇼핑
function goHomeShoppingInstall(){
		
		ga('send', 'event', 'mf_home', 'mf_family', 'famliy_홈쇼핑_가격비교');
		if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
			location.href = "http://appstore.com/%EC%8A%A4%EB%A7%88%ED%8A%B8%ED%99%88%EC%87%BC%ED%95%91?freetoken=outlink";
		}else if(navigator.userAgent.indexOf("Android") > -1){
			if(getCookie("appYN") == 'Y') location.href = "market://details?id=com.enuri.homeshopping&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_app_click%26utm_campaign%3Dfamilyapp20151209";
			else location.href = "market://details?id=com.enuri.homeshopping&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_web_click%26utm_campaign%3Dfamilyapp20151209";
		}
}
//핫딜
function goHotDealInstall(){
		ga('send', 'event', 'mf_home', 'mf_family', 'famliy_소셜가격비교');
	
		if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
			location.href = "http://appstore.com/%EC%86%8C%EC%85%9C%EA%B0%80%EA%B2%A9%EB%B9%84%EA%B5%90%ED%95%AB%EB%94%9C%EA%B0%80%EA%B2%A9%EB%B9%84%EA%B5%90%EC%B5%9C%EC%A0%80%EA%B0%80%EC%86%8C%EC%85%9C%EC%BB%A4%EB%A8%B8%EC%8A%A4%EB%B0%98%EA%B0%92?freetoken=outlink";
		}else if(navigator.userAgent.indexOf("Android") > -1){
			if(getCookie("appYN") == 'Y') location.href = "market://details?id=com.enuri.deal&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_app_click%26utm_campaign%3Dfamilyapp20151209";
			else location.href = "market://details?id=com.enuri.deal&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_web_click%26utm_campaign%3Dfamilyapp20151209";
		}
}
//신차비교
function goCarInstall(){
		ga('send', 'event', 'mf_home', 'mf_family', 'famliy_신차비교');
		
		if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
			location.href = "http://appstore.com/%EC%97%90%EB%88%84%EB%A6%AC%EC%8B%A0%EC%B0%A8%EB%B9%84%EA%B5%90?freetoken=outlink";
		}else if(navigator.userAgent.indexOf("Android") > -1){
			if(getCookie("appYN") == 'Y') location.href = "market://details?id=com.enuri_car.android&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_app_click%26utm_campaign%3Dfamilyapp20151209";
			else location.href = "market://details?id=com.enuri_car.android&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_web_click%26utm_campaign%3Dfamilyapp20151209";
		}
}
function golfInstall(){
		ga('send', 'event', 'mf_home', 'mf_family', 'famliy_골프예약');
		
		if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
			//xgolfLog(1);
			location.href = "http://appstore.com/XGOLFBOOKING?freetoken=outlink";
		}else if(navigator.userAgent.indexOf("Android") > -1){
			if(getCookie("appYN") == 'Y'){
				//xgolfLog(2);
				 location.href = "market://details?id=com.xgolf.booking&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_app_click%26utm_campaign%3Dfamilyapp20151221";
			}else{
				 //xgolfLog(0);
			 	 location.href = "market://details?id=com.xgolf.booking&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_web_click%26utm_campaign%3Dfamilyapp20151221";
			}
		}
}
function directBuyInstall(){
        ga('send', 'event', 'mf_home', 'mf_family', 'famliy_해외직구');
        if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
            location.href = "https://itunes.apple.com/kr/app/swiun-haeoejiggu-swibges-shipget/id992420740?mt=8";
        }else if(navigator.userAgent.indexOf("Android") > -1){
            if(getCookie("appYN") == 'Y'){
                 location.href = "market://details?id=com.megabrain.modagi&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_app_click%26utm_campaign%3Dfamilyapp20160705";
            }else{
                 location.href = "market://details?id=com.megabrain.modagi&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_web_click%26utm_campaign%3Dfamilyapp20160705";
            }
        }
}
function xgolfLog(type){
		var xurl = "http://app.xgolf.com/banner/applink.asp?b_code=24223&type_loading=click&bannerOS=";
		if(type == 0)	xurl += "0";
		else if(type == 1)  xurl += "1";
		else if(type == 2)  xurl += "2";
		$.ajax({
	        type: "POST",
	        async : false,
	        dataType: 'json',
	        url: xurl,		        
	        success: function(data){},
			error: function (xhr, ajaxOptions, thrownError) {}
		});
}
$(document).ready(function(){
	//if(datePopUpSet("2016/03/31","popup")){
		//$(".evtbanner_btm").hide();	
	//}
	
	$(".evtbanner_btm").click(function(){
		ga('send', 'event', 'mf_common', 'footerBanner', 'footer_배너');
		location.href = "/mobilefirst/event2016/allpayback_201609.jsp?freetoken=event";
	});
	
		if(getCookie("appYN") == 'Y'){
		    
				if(document.location.href.indexOf("/mobilefirst/Index.jsp") > 0  || document.location.href.indexOf("/mobilefirst/trend_news.jsp") > 0 || document.location.href.indexOf("/mobilefirst/best.jsp") > 0){
					if(document.location.href.indexOf("/mobilefirst/list.jsp?") > 0){
						
				    }else{
						$("#app_miniPop_F").show();	    
				    }	
		    	}
	}else{
		// 접속 핸드폰 정보
		var userAgent = navigator.userAgent.toLowerCase();
		if(userAgent.match('android')) {
			$(".install").show();
		}
	}
	//boolean result = true;
	$(window).scroll(function(){
        $(".TBtn").show();
        if ( $(window).scrollTop() < 50 ){
        	$(".TBtn").hide();
        }
    });
try{
	$(window).scroll($.debounce( 250, true, function(){
		$( "#app_miniPop_F" ).hide();
	}));
}catch(e){
	 $(document).on('touchstart', function() {
	    	setTimeout(function(){
	    		$("#app_miniPop_F").hide();
	    	},300);	
	});
}
    $("body").on('click', '.TBtn', function(event) {
		scrollTo(0,0);    
		$("#app_miniPop_F").hide();
    });
	//푸터 메뉴 클릭
	/*
	$(".cateBtn").click(function(){
		if(getCookie("appYN") == 'Y'){
			//안드로이드 일경우
			if(window.android){
				try{
					android.onMenu();
				}catch(e){
					console.e('no onMenu send android');
				}
			}else{ // 아이폰 일 경우
				window.location = "appcall:openCate";
			}	
		}else{
		var nowUrl = document.location.href;
		var sel = "";
		if(nowUrl.indexOf("/mobilefirst/best_list.jsp") > -1){
			sel = "best_list";
		}else if(nowUrl.indexOf("/mobilefirst/list.jsp") > -1){
			sel = "list";
		}else if(nowUrl.indexOf("/mobilefirst/search.jsp") > -1){
			sel = "search";
		}else if(nowUrl.indexOf("/mobilefirst/detail.jsp") > -1){
			sel = "detail";
		}else if(nowUrl.indexOf("/mobilefirst/trend_news.jsp") > -1){
			sel = "trend_news";
		}else if(nowUrl.indexOf("/mobilefirst/Index.jsp") > -1){
			sel = "main";
		}else if(nowUrl.indexOf("/mobilefirst/plan_list.jsp") > -1){
			sel = "plan_list";
		}else{
			sel = "etc";
		} 
			ga('send', 'event', 'mf_common', 'cate_button', 'footer_category_'+sel);
			//$(".cate_menu").trigger('click');
		var cateType = getCookie("cateType");
		// 카테고리 버전이 커튼일 경우
		if(cateType == 'B'){
			cateCurtainLoading();
		}else{// 카테고리 버전이 리스트일 경우
			cateListLoading();
		}
		getPoint = getTop();
		setCookie("c1dept", "");
		}
	});
	*/
	//푸터 메뉴 클릭
	$(".cateBtn.gift").click(function(){
			ga('send', 'event', 'mf_footer', 'footer', 'footer_선물박스');
			//location.href = "/mobilefirst/event2016/benefit.jsp?freetoken=event";
			location.href = "/mobilefirst/event2016/allpayback_201608.jsp?freetoken=event";
	});
	$('#comInfo').click(function(){
		if ($(this).hasClass("allview_close")) {
			$(this).removeClass("allview_close");
			ga('send', 'event', 'm_footer', 'footer', 'footer_사업자정보');
		} else {
			$(this).addClass("allview_close");
			$("body,html").animate({scrollTop: $(this).offset().top}, 500);
		}
		ga('send', 'event', 'mf_footer', 'footer', 'footer_사업자정보');
	$('#moreview').toggle();
		 if($('#moreview').is(':visible')) {
			$(this).val('Hide');
		} else {
			$(this).val('Show');
		}
	});
	// PC 이동
	$("#goPcBtn").on('click', function(){
		location.href = "http://www.enuri.com/Index.jsp?from=mo";
	});
	if(document.location.href.indexOf("/mobilefirst/Index.jsp") > 0){
		$(".new_footer > ul > li").first().removeClass();
		$(".cominfo_txt").show();
	}
});
function goFooterLink(type){
	if(type == 1){
		ga('send', 'event', 'mf_common', 'floatingbanner', '올림픽_하단배너');
		location.href = "/mobilefirst/event2016/olympic_201608.jsp?freetoken=event";
	}else if(type ==2){
		ga('send', 'event', 'mf_common', 'floatingbanner', '출석체크_하단배너');
		location.href = "/mobilefirst/event2016/visit_201608.jsp?freetoken=event";
	}else if(type ==3){
        ga('send', 'event', 'mf_common', 'floatingbanner', '영화_하단배너');
        location.href = "/mobilefirst/event2016/movie_201608.jsp?freetoken=event";
    }
}
//법적고지
function openRuleWrap(){
	var nowUrl = document.URL;
	var cssType = "";
	if(nowUrl.indexOf("/mobiledepart/") > -1)		cssType = "mobiledepart";
	else	    cssType = "agreeWrap";
	
	ga('send', 'event', 'mf_footer', 'footer', 'footer_법적고지');
	window.open("/mobilefirst/login/ruleWrap.jsp?cssType="+cssType);
}
//개인정보 취급방침
function openPrivacyWrap(){
	var nowUrl = document.URL;
	var cssType = "";
	if(nowUrl.indexOf("/mobiledepart/") > -1)		cssType = "mobiledepart";
	else		cssType = "agreeWrap";
	ga('send', 'event', 'mf_footer', 'footer', 'footer_개인정보취급방침');
	window.open("/mobilefirst/login/privacyWrapFooter.jsp?cssType="+cssType);
}
//이용약관
function openTermsWrap(){

	var nowUrl = document.URL;
	var cssType = "";
	if(nowUrl.indexOf("/mobiledepart/") > -1)		cssType = "mobiledepart";
	else	   cssType = "agreeWrap";
	
	ga('send', 'event', 'mf_footer', 'footer', 'footer_이용약관');

	window.open("/mobilefirst/login/termsWrap.jsp?cssType="+cssType);
}
//PC 이동
function goPcEnuri(){
	ga('send', 'event', 'mf_footer', 'footer', 'footer_pc');
	location.href = "http://www.enuri.com/Index.jsp?from=mo";
}
</script>
<!-- //푸터 -->
<%
	String mDepartUrl = request.getRequestURL().toString();
	if(mDepartUrl.contains("mobiledepart")){
%>
<script language="javascript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
<%}%>