<%@page import="com.enuri.util.common.ChkNull"%>
<%
	try{
		String tempIdccYongcom = cb.GetCookie("MEM_INFO","USER_ID");
		if(tempIdccYongcom.equals("yongcom")){
			out.println("<script>alert('로그인 한 ID로 이벤트 부정참여가 발견되었습니다. \\n\\n법적 손해배상청구를 진행예정이오니 신속히 고객센터로 연락주십시오.\\n\\n[고객센터 02-6354-3601]')</script>");
		}
	}catch(Exception e){}
	String urlfooter = request.getRequestURL().toString();
%>
<!-- 푸터 -->
    <footer class="footer">
        <div class="newquick">
            <p class="TBtn" style="display:none" onclick="javascript:goFooterTop()">TOP</p>
        </div>
        <ul class="family_app">
        	<%if( urlfooter.indexOf("smarthome.jsp") > -1 ) { %>
            <li><a href="javascript:goEnuriInstall();">에누리 가격비교</a></li>
            <%} else { %>
            <li><a href="javascript:goSmartInstall();">스마트택배</a></li>
            <%} %>
            <li><a href="javascript:goHotDealInstall();">소셜가격비교</a></li>
            <!--
            <li><a href="javascript:goHomeShoppingInstall();">홈쇼핑 가격비교</a></li>
            <li><a href="javascript:directBuyInstall();">해외직구</a></li>
             -->
        </ul>
        <nav class="new_footer">
        </nav>
        <div class="cominfo_txt" >
            <section>
				<p class="law_tit">법적고지</p>
				<p class="info">㈜써머스플랫폼은 통신판매 정보제공자로서 통신판매의 거래당사자가 아니며, 상품의 주문/배송/환불에 대한 의무와 책임은 각 쇼핑몰(판매자)에게 있습니다.</p>
				<p><strong>㈜써머스플랫폼</strong>
					대표이사 : 김기범<span>|</span>사업자등록번호 : 206-81-18164<br>
					통신판매신고 : 2015-서울중구-1046호<br>
					서울특별시 중구 퇴계로 18(남대문로5가) 9층<br>
					문의 : 02-6354-3601<span>|</span><a href="mailto:master@enuri.com">master@enuri.com</a>
				</p>
			</section>
            <ul class="rule">
	            <li><a href="javascript:openTermsWrap()" id="agree">이용약관</a></li>
	            <li><a href="javascript:openPrivacyWrap()">개인정보처리방침</a></li>
	            <li><a href="javascript:openRuleWrap()">법적고지</a></li>
	            <%
	            String fromST = ChkNull.chkStr(cb.getCookie_One("FROM"));
	            if( !"swt".equals(fromST)  ){
	            %>
	            <li><a href="javascript:goPcEnuri();insertLog('11004')">PC버전</a></li>
	            <%} %>
            </ul>
        </div>
    </footer>
    <!-- //푸터 -->
<script type="text/javascript" src="/mobilefirst/js/utils.js?v=20191007"></script>
<script type="text/javascript">
$(window).scroll(function(){
    $(".TBtn").show();
    if ( $(window).scrollTop() < 50 ){
        $(".TBtn").hide();
    }
});
function goTest(){
    //location.href='/mobilefirst/event2016/friend.jsp';
}
function goFooterTop(){
    $(window).scrollTop( 0 );
}
var nowVer =  "0";
if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
    nowVer = getCookie("verios");
    if(typeof(nowVer) =="undefined" ) nowVer ="0";
}else{
    nowVer = getCookie("verand");
    if(typeof(nowVer) =="undefined" ) nowVer ="0";
}
if(nowVer != "undefined" || nowVer != "" ){
    nowVer = nowVer.replace(/\./gi, "");
    if( nowVer.length > 4 ){
        nowVer = nowVer.substring(0,3);
    }
    nowVer = Number(nowVer);
}
function goEnuriInstall(){
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
		location.href = "https://itunes.apple.com/kr/app/id476264124?freetoken=outlink";
	}else{
		location.href = "market://details?id=com.enuri.android&com.enuri.android&referrer=utm_source%3Dst%26utm_medium%3Denuri_footer%26utm_campaign%3Dinstall%2520from_st";
	}
}
//스마트택배
function goSmartInstall(){
        ga('send', 'event', 'mf_home', 'mf_family', 'famliy_스마트택배');
        if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){

            if(getCookie("appYN") == 'Y'){
                if(nowVer >= 310){
                    location.href = "enuriappcall://goEnuriFamilyApp?scheme=smartparcel%3A%2F%2F&url=https%3A%2F%2Fitunes.apple.com%2Fkr%2Fapp%2Fid523045854%3Ffreetoken%3Doutlink";
                }else{
                    location.href = "https://itunes.apple.com/kr/app/id523045854?freetoken=outlink";
                }
            }else{
                    location.href = "https://itunes.apple.com/kr/app/id523045854?freetoken=outlink";
            }

        }else if(navigator.userAgent.indexOf("Android") > -1){
            if(getCookie("appYN") == 'Y') {
                if(nowVer >= 310){
                    window.android.goFamilyApp("smartparcel://","market://details?id=com.sweettracker.smartparcel&referrer=utm_source%Enuri%26utm_medium%app_banner%26utm_campaign%3Dinstall_promotion_from_Enuri");
                }else{
                    location.href = "market://details?id=com.sweettracker.smartparcel&referrer=utm_source%Enuri%26utm_medium%app_banner%26utm_campaign%3Dinstall_promotion_from_Enuri";
                }
            } else {
                location.href = "market://details?id=com.sweettracker.smartparcel&referrer=utm_source%Enuri%26utm_medium%app_banner%26utm_campaign%3Dinstall_promotion_from_Enuri";
            }
        }
}
//홈쇼핑
function goHomeShoppingInstall(){
        ga('send', 'event', 'mf_home', 'mf_family', 'famliy_홈쇼핑_가격비교');
        if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){

            if(getCookie("appYN") == 'Y'){
                if(nowVer >= 310){
                    location.href = "enuriappcall://goEnuriFamilyApp?scheme=enurihomeshopping%3a%2f%2f&url=https%3a%2f%2fitunes.apple.com%2fkr%2fapp%2fid1053348835%3ffreetoken%3doutlink";
                }else{
                    location.href = "https://itunes.apple.com/kr/app/id1053348835?freetoken=outlink";
                }
            }else{
                location.href = "https://itunes.apple.com/kr/app/id1053348835?freetoken=outlink";
            }

        }else if(navigator.userAgent.indexOf("Android") > -1){
            if(getCookie("appYN") == 'Y'){
                if(nowVer >= 310){
                    window.android.goFamilyApp("enurihomeshopping://","market://details?id=com.enuri.homeshopping&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_app_click%26utm_campaign%3Dfamilyapp20151209");
                }else{
                    location.href = "market://details?id=com.enuri.homeshopping&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_app_click%26utm_campaign%3Dfamilyapp20151209";
                }
            }else{
                location.href = "market://details?id=com.enuri.homeshopping&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_app_click%26utm_campaign%3Dfamilyapp20151209";
            }

        }
}
//핫딜
function goHotDealInstall(){
        ga('send', 'event', 'mf_home', 'mf_family', 'famliy_소셜가격비교');
        if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
            //location.href = "http://appstore.com/%EC%86%8C%EC%85%9C%EA%B0%80%EA%B2%A9%EB%B9%84%EA%B5%90%ED%95%AB%EB%94%9C%EA%B0%80%EA%B2%A9%EB%B9%84%EA%B5%90%EC%B5%9C%EC%A0%80%EA%B0%80%EC%86%8C%EC%85%9C%EC%BB%A4%EB%A8%B8%EC%8A%A4%EB%B0%98%EA%B0%92?freetoken=outlink";

            if(getCookie("appYN") == 'Y'){
                if(nowVer >= 310){
                    location.href = "enuriappcall://goEnuriFamilyApp?scheme=enurideal%3a%2f%2f&url=https%3a%2f%2fitunes.apple.com%2fkr%2fapp%2fid944887654%3ffreetoken%3doutlink";
                }else{
                    location.href = "https://itunes.apple.com/kr/app/id944887654?freetoken=outlink";
                }
            }else{
                location.href = "https://itunes.apple.com/kr/app/id944887654?freetoken=outlink";
            }

        }else if(navigator.userAgent.indexOf("Android") > -1){
            if(getCookie("appYN") == 'Y'){
                if(nowVer >= 310){
                    window.android.goFamilyApp("enurideal://","market://details?id=com.enuri.deal&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_app_click%26utm_campaign%3Dfamilyapp20151209");
                }else{
                    location.href = "market://details?id=com.enuri.deal&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_app_click%26utm_campaign%3Dfamilyapp20151209";
                }
             } else {
                location.href = "market://details?id=com.enuri.deal&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_app_click%26utm_campaign%3Dfamilyapp20151209";
             }

        }
}
//해외직구
function directBuyInstall(){
        ga('send', 'event', 'mf_home', 'mf_family', 'famliy_해외직구');

        if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
            if(getCookie("appYN") == 'Y'){
                if(nowVer >= 310){
                    location.href = "enuriappcall://goEnuriFamilyApp?scheme=shipget%3a%2f%2f&url=https%3a%2f%2fitunes.apple.com%2fkr%2fapp%2fid992420740%3ffreetoken%3doutlink";
                }else{
                    location.href = "https://itunes.apple.com/kr/app/id992420740?freetoken=outlink";
                }
            }else{
                location.href = "https://itunes.apple.com/kr/app/id992420740?freetoken=outlink";
            }
        }else if(navigator.userAgent.indexOf("Android") > -1){
            if(getCookie("appYN") == 'Y'){
                if(nowVer >= 310){
                    window.android.goFamilyApp("mbmdg://shipget.co.kr/main ","market://details?id=com.megabrain.modagi&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_app_click%26utm_campaign%3Dfamilyapp20160705");
                 }else{
                    location.href = "market://details?id=com.megabrain.modagi&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_web_click%26utm_campaign%3Dfamilyapp20160705";
                 }
            }else{
                 location.href = "market://details?id=com.megabrain.modagi&referrer=utm_source%3Denuri%26utm_medium%3Dfamily_web_click%26utm_campaign%3Dfamilyapp20160705";
            }
        }
}
//법적고지
function openRuleWrap(){
    var nowUrl = document.URL;
    var cssType = "";
    if(nowUrl.indexOf("/mobiledepart/") > -1)       cssType = "mobiledepart";
    else        cssType = "agreeWrap";

    ga('send', 'event', 'mf_footer', 'footer', 'footer_법적고지');
    if(  document.URL.indexOf("smarthome.jsp") > -1 ){
    	window.open("/mobilefirst/login/ruleWrap.jsp?cssType="+cssType+"&from=swt");
    }else{
    	window.open("/mobilefirst/login/ruleWrap.jsp?cssType="+cssType);
    }

    //window.open("/mobilefirst/login/ruleWrap.jsp?cssType="+cssType);
}
//개인정보 취급방침
function openPrivacyWrap(){
    //var nowUrl = document.URL;
    //var cssType = "";
    //if(nowUrl.indexOf("/mobiledepart/") > -1)       cssType = "mobiledepart";
    //else        cssType = "agreeWrap";
    ga('send', 'event', 'mf_footer', 'footer', 'footer_개인정보취급방침');
    //window.open("/mobilefirst/login/privacyWrapFooter.jsp?cssType="+cssType);
    //window.open("/mobilefirst/login/policy.jsp?param=2&from=st");

    if(  document.URL.indexOf("smarthome.jsp") > -1 ){
    	window.open("/mobilefirst/login/policy.jsp?param=2&from=swt");
    }else{
    	window.open("/mobilefirst/login/policy.jsp?param=2");
    }
}
//이용약관
function openTermsWrap(){
    //var nowUrl = document.URL;
    //var cssType = "";
    //if(nowUrl.indexOf("/mobiledepart/") > -1)       cssType = "mobiledepart";
    //else       cssType = "agreeWrap";
    //window.open("/mobilefirst/login/termsWrap.jsp?cssType="+cssType);
    ga('send', 'event', 'mf_footer', 'footer', 'footer_이용약관');

    if(  document.URL.indexOf("smarthome.jsp") > -1 ){
    	window.open("/mobilefirst/login/policy.jsp?param=1&from=swt");
    }else{
    	window.open("/mobilefirst/login/policy.jsp?param=1");
    }
}
//PC 이동
function goPcEnuri_old(){
    ga('send', 'event', 'mf_footer', 'footer', 'footer_pc');
    location.href = "http://www.enuri.com/Index.jsp?from=mo";
}
function goPcEnuri(){
    ga('send', 'event', 'mf_footer', 'footer', 'footer_pc');

    var nowUrl = document.URL;
    var tmpUrl = "";

    if(nowUrl.indexOf("/mobilefirst/list.jsp?") > -1){
    	tmpUrl = nowUrl.substring(nowUrl.indexOf("/mobilefirst/list.jsp?")+22, nowUrl.length);
    	location.href = "http://www.enuri.com/list.jsp?"+tmpUrl;
    }else  if(nowUrl.indexOf("/mobilefirst/search.jsp?") > -1){
    	tmpUrl = nowUrl.substring(nowUrl.indexOf("/mobilefirst/search.jsp?")+24, nowUrl.length);
    	location.href = "http://www.enuri.com/search.jsp?"+tmpUrl;
    }else  if(nowUrl.indexOf("/mobilefirst/detail.jsp?") > -1){
    	tmpUrl = nowUrl.substring(nowUrl.indexOf("/mobilefirst/detail.jsp?")+24, nowUrl.length);
    	location.href = "http://www.enuri.com/detail.jsp?"+tmpUrl;
    }else{
    	location.href = "http://www.enuri.com/Index.jsp?from=mo";
    }
}
function gofooterBannerLink(url){

    ga('send', 'event', 'mf_footer', 'footer', 'footerBanner');

    if("<%=fromST%>" == "swt"){
    	location.href = url+"&from=swt";
    }else{
    	location.href = url;
    }
}
//가로스크롤바 숨기기
function loaded(){
    try{
	    var iscroll = new iScroll("iscroll", {
	    vScroll:false,
	    hScrollbar:false
	    });
	    var nowUrl = document.URL;
	    if(nowUrl.indexOf("trend_news.jsp") > -1  || nowUrl.indexOf("best") > -1){
	       iscroll.scrollTo(iscroll.maxScrollX,0,0);
            $(".grd_next").remove();
	    }
    }catch(e){}
}
document.addEventListener('DOMContentLoaded', loaded, false);
</script>
<script id="footerBanner" type="text/x-jquery-tmpl">
<section class="evtbanner_btm"><a href="javascript:///" onclick="javascript:gofooterBannerLink('\${JURL1}')"><img src="\${IMG1}" alt="\${ALT}"></a></section>
</script>
<script type="text/javascript" src="/mobilefirst/js/lib/swiper.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/mustache.js"></script>
<%
    if(urlfooter.indexOf("mobiledepart") > -1){
%>
<script>
footerBannerLoading();
function footerBannerLoading(){
      $.getJSON( "/mobilefirst/http/json/banner_list.json", function(json) {
      //footer 배너
      if(json.footer.banner){
          var bannerJson = new Array();
           $.each(json.footer.banner, function(i, v){
                  var sdate = replaceAll(v.sdate,"-" ,"/");
                  sdate = new Date(sdate);

                  var edate = replaceAll(v.edate,"-" ,"/");
                  edate = new Date(edate);

                  if(dateComparison(sdate,edate)){
                      bannerJson.push(v);
                  }
           });
          var webFooter = shuffle(bannerJson);
          var bannerObj = webFooter[0];

          if(bannerObj){
              $(".family_app").after($("#footerBanner").tmpl(bannerObj));
          }
      }
  });
}
function dateComparison(sdate , edate){
    var nowDate = new Date();
    var result = false;
    if(sdate < nowDate && edate > nowDate)        result = true;
    return result;
}
</script>
<%
    }
    if( urlfooter.indexOf("mobilefirst") > -1 || urlfooter.indexOf("cpp_m") > -1 || urlfooter.indexOf("/m/") > -1 ){
%>
<script type="text/javascript" src="/mobilefirst/js/banner_list.js"></script>
<script type="text/javascript" src="/mobilefirst/renew/js/gnb.js?v=201910081"></script>
<script type="text/javascript" src="/mobilefirst/renew/js/gnbSearch.js?v=201906114"></script>
<script type="text/javascript" src="/mobilefirst/js/resentzzimStorage.js"></script>
<script>(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)})(window,document,'script','//www.google-analytics.com/analytics.js','ga');ga('create', 'UA-52658695-3', 'auto');</script>
<% } %>