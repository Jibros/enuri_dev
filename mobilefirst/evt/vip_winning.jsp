<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%
String cUserId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String cUserNick = cb.GetCookie("MEM_INFO","USER_NICK");

Members_Proc members_proc = new Members_Proc();
String cUsername = "";
String userArea = "";

if(!cUserId.equals("")){
    cUsername = members_proc.getUserName(cUserId);
    userArea = cUsername;

    if(cUsername.equals(""))      userArea = cUserNick;
    if(userArea.equals(""))        userArea = cUserId;
    
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<title>에누리(가격비교) eNuri.com</title>
<meta property="og:title" content="에누리 가격비교">
<meta property="og:description" content="에누리 모바일 가격비교">
<meta property="og:image" content="http://img.enuri.com/images/event/2019/coupang/coupang_sns_1200_630.jpg">
<meta name="format-detection" content="telephone=no" />
<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css">
<link rel="stylesheet" href="/css/event/com.enuri.event.m.css" type="text/css">
<link rel="stylesheet" href="/css/event/y2020/vipaward_m.css" type="text/css">
<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/event_regular.js?v=20200825"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/js/swiper.min.js"></script>
<script src="/mobilefirst/js/lib/clipboard.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Nanum+Myeongjo&amp;display=swap" rel="stylesheet">
</head>
<body>
<!-- 나눔명조 웹폰트 -->
<div class="wrap">
	<button type="button" class="btn_close">창닫기</button>

	<div class="privilege_wrap">
		<div class="privilege">
			<div class="p_inner">
				<div class="envelope">				
					<div class="obj_paper">
						<div class="paper_cont">
							<p class="username"><span><%=cUserId %></span> 고객님</p>
						</div>
					</div>
					<span class="obj_envelope"><!-- 봉투 --></span>
					<span class="obj_envelope_flip"><!-- 봉투 플립 --></span>

					<span class="obj_flower"><!-- 꽃 --></span>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	// 상단 타이들 등장 모션
	$(window).load(function(){
		var $visual = $(".privilege_wrap");
		$visual.addClass("intro");
		setTimeout(function(){
			$visual.addClass("end");
		},3100)
	})
	
	// X 클릭
	$(".btn_close").click(function(){
		if(confirm("e머니 적립내역으로 이동하시겠습니까?")) {
			$(this).parent().click();
			location.href="https://m.enuri.com/my/my_emoney_m.jsp?freetoken=emoney";
			return false;
		} else {
			location.href="https://m.enuri.com/m/index.jsp";
			return false;
		}
	});
</script>




<script language="JavaScript" src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail_Mobile.js"></script>
</body>
</html>