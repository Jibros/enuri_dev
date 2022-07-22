<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
Cookie[] carr = request.getCookies();
String appYN = ChkNull.chkStr(request.getParameter("app"));
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
	<%@ include file="/mobilefirst/include/common.html" %>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="/js/swiper.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
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
			<ul class="event_won_list">
			</ul>
			<!-- 버튼 : 더보기 -->
	        <button class="btn_list_more">
	            <span class="btn__txt_more">더보기</span>
	        </button>
	        <!-- // -->
		</section>

		<%@ include file="/my/include/m_appDownload.jsp"%>
		<%@ include file="/my/include/m_footer.jsp"%>
	</div>
</body>
<script>
var vApp = "<%=strAppyn%>";
jQuery(document).ready(function($) {
	getWonList();

	$("body").on('click', 'ul > li', function(e) {
		var seq = $(this).attr('data-id');
		ga('send', 'event', 'mf_plan_event', 'event_board', 'board_'+seq);
	});

	if(vApp == "Y"){
		$('header').show();
		$('#wrap').addClass("isApp");
	}

	$("#header .btn__sr_back").click(function(){
		if(vApp != 'Y' ){	// 웹에서 호출
			history.back(-1);
		}else{
			// 앱에서 호출
			if(window.android){		// 안드로이드
				window.location.href = "close://";
			}else{					// 아이폰에서 호출
				window.location.href = "close://";
			}
		}
	});

	$(".btn__txt_more").click(function(){
		$(".event_won_list > li").show();
		$(".btn_list_more").hide();
	});
});

function getWonList(){
	$won_list_template = $('#won_list_template');
	var loadUrl = "/mobilefirst/ajax/main/ajax_to_json_won_list.jsp";
	$.ajax({
		url: loadUrl,
		dataType: 'json',
		async: false,
		success: function(json){
			var makeHtml = "";
			var cnt = Object.keys(json.wonList).length;
			$.each(json.wonList,function(i,v){
				if(i < 20){
					makeHtml +="<li id='list' data-id='"+v.SEQ+"'><a href='javascript:///' >"+v.TITLE+"<span class='date'>"+v.INS_DATE+"</span></a></li>";
				}else{
					makeHtml +="<li id='list' data-id='"+v.SEQ+"' style='display:none' ><a href='javascript:///' >"+v.TITLE+"<span class='date'>"+v.INS_DATE+"</span></a></li>";
				}
			});
			if(cnt == 0){
				makeHtml += "<li class=\"no_result\">";
				makeHtml += "<span class=\"comm__sprite ico_caution\">!</span>";
				makeHtml += "<span class=\"txt_result\">";
				makeHtml += "	등록된 당첨자 / 공지글이 없습니다.";
				makeHtml += "</span>";
				makeHtml += "</li> ";
			}
			$(".event_won_list").html(makeHtml);
			if(cnt > 20){
				$(".btn__txt_more").show();
			}
		},
		complete: function(){
            var $content = $('.m_plan_cont');
            var $list = $(".event_won_list");
            var $btn = $list.find("li:not('.no_result')");
            $btn.on("click",function(){
                var $this = $(this);
                var _id = $this.attr('data-id'); // 게시글 순서
                if (vApp == "Y"){ // 모바일웹일때
                    window.location = '/mobilefirst/event/eventWonView.jsp?freetoken=event&seq='+_id;
                }else{ // 앱일때
                var _distance = ( $this.offset().top - $content.offset().top - $(window).scrollTop() ) * -1;
	                $content.css("transform","translateY("+_distance+"px)")
	                $list.stop(true,false).animate({"padding-bottom":$(window).height()},200);
	                $this.addClass("selected").siblings().css("opacity",0);
                    setTimeout(function(){ // 페이지 전환 효과 뒤 이동
                        window.location = '/mobilefirst/event/eventWonView.jsp?freetoken=event&seq='+_id;
                    },600)
                }
            });
		}
	});
}
</script>
<script>
    function goFooterTop(){
		$('html,body').scrollTop(0);
	}
</script>
</html>
