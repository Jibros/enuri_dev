<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
	Cookie[] carr = request.getCookies();
	String seq = ChkNull.chkStr(request.getParameter("seq"),"");
	String pushYN = ChkNull.chkStr(request.getParameter("push"),"");
	String reward = ChkNull.chkStr(request.getParameter("reward"),"");
	String strAppyn = "";
	String strVerios = "";
	String strAd_id = "";

	try {
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
	          if(carr[i].getName().equals("adid")){
	           strAd_id = carr[i].getValue();
	           break;
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
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
    <link rel="stylesheet" type="text/css" href="/css/mobile_v2/common.css"/>
    <link rel="stylesheet" type="text/css" href="/css/mobile_v2/cs.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/js/swiper.min.js"></script>
	<%@ include file="/mobilefirst/include/common.html" %>
</head>
<body>
<div id="wrap">
	<header id="header" class="page_header" style="display:none;">
		<div class="header_top">
			<div class="wrap">
				<button class="btn__sr_back comm__sprite2"><i class="icon_arrow_back comm__sprite2">뒤로</i></button>
				<div class="header_top_page_name">당첨자/공지</div>
			</div>
		</div>
	</header>

    <section id="container" class="m_plan_cont">
    	<div class="event_won_view">
		</div>

		<!-- 버튼 : 목록으로 -->
        <button class="btn_list">
            <span class="btn__txt">목록으로</span>
        </button>
        <!-- // -->

        <script>
            $(window).load(function(){ // 페이지 로드후 fadeIn
                var $view = $(".event_won_view");
                $view.addClass("loaded");
            });
        </script>
	</section>

	<%@ include file="/my/include/m_appDownload.jsp"%>
	<%@ include file="/my/include/m_footer.jsp"%>
</div>
</body>
<script>
jQuery(document).ready(function($) {
	var appYN = getCookie("appYN");
	getWonView();

	if(appYN == "Y"){
		$('header').show();
		$('#wrap').addClass("isApp");
	}

	$(".btn__sr_back, .btn_list").click(function(){
		if(appYN != 'Y' ){	// 웹에서 호출
			window.location.href = "/mobilefirst/event/eventWonList.jsp";
		}else{
			// 앱에서 호출
			if(window.android){		// 안드로이드
				window.location.href = "close://";
			}else{					// 아이폰에서 호출
				window.location.href = "close://";
			}
		}
	});
});
function getWonView(){
	$won_View_template = $('#won_View_template');
	var seq =  '<%=seq%>';
	var loadUrl = "/mobilefirst/ajax/main/ajax_to_json_won_view.jsp?seq="+seq;
	var makeHtml = "";
	$.ajax({
		url: loadUrl,
		dataType: 'json',
		async: false,
		success: function(json){
			makeHtml += "<div class=\"view_head\">";
			makeHtml += "	<span class=\"txt__head\">"+json.TITLE+"<span class=\"date\">"+json.INS_DATE+"</span></span>";
			makeHtml += "</div>";
			makeHtml += "<div class=\"view_cont\">"+json.CONTENT+"</div>";

			$(".event_won_view").html(makeHtml);
		}
	});
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
<script>
    function goFooterTop(){
		$('html,body').scrollTop(0);
	}
</script>
</html>