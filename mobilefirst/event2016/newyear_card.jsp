<%@ page contentType="text/html; charset=utf-8" %>
<%@include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@page import="com.enuri.bean.event.every.Newyear_2017"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.simple.*"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%
int cardSeq = ChkNull.chkInt(request.getParameter("card_seq"));
JSONArray cardDataList = new JSONArray();
JSONObject cardJson = new JSONObject();

Newyear_2017 event_proc = new Newyear_2017();
cardDataList = event_proc.getCard(cardSeq);

String from;
String dear;
String msg;
String img;

cardJson=(JSONObject)cardDataList.get(0);
from = (String)cardJson.get("card_from");
dear = (String)cardJson.get("card_dear");
msg = (String)cardJson.get("card_msg");
img = (String)cardJson.get("card_img");
//out.println(msg);

if(msg != null && msg.length() > 0){
	msg = msg.replaceAll("\n", "<br/>")
			//.replaceAll("<", "&lt;")
			//.replaceAll(">", "&gt;")
			.replaceAll("&", "&amp;")
			.replaceAll("\'", "&apos;")
			.replaceAll("\"", "&quot;");
}
//out.println(cardJson.toString());
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">   
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />   
    <meta property="og:title" content="에누리 가격비교">
    <meta property="og:description" content="에누리 모바일 가격비교">
    <meta property="og:image" content="http://imgenuri.enuri.gscdn.com/images/mobilenew/images/logo_enuri.png">
    <meta name="format-detection" content="telephone=no" />
    <!--<link rel="stylesheet" type="text/css" href="sul.css"/>-->
    <link rel="stylesheet" type="text/css" href="http://m.enuri.com/mobilefirst/css/event/sul.css">
    <link rel="stylesheet" type="text/css" href="http://m.enuri.com/mobilefirst/css/lib/slick.css"/>
    <script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
    <script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/slick.min.js"></script>
    <script type="text/javascript">
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
          (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
          m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
          })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
          //런칭할때 UA-52658695-3 으로 변경
          ga('create', 'UA-52658695-3', 'auto');

    var _TRK_CC = 17;

    $(function(){
    	
    	<%-- 
    	document.getElementById('dear').innerText = "<%=dear%>";
		document.getElementById('msg').innerText = "<%=msg%>";
		document.getElementById('from').innerText = "<%=from%>";
 		--%>
 		ga('send', 'pageview', {
            'page': '/mobilefirst/event2016/newyear_card.jsp',
            'title': '설날카드PV '
        });
 		
		$('#dear').text("<%=dear%>");
		$('#msg').html("<%=msg%>");
		$('#from').text("<%=from%>");
		
		var tabId = "<%=img%>";
		var imgName = "";
		switch(tabId){
		case "tab02":
			imgName = "card_img02.jpg";
			break;
		case "tab03":
			imgName = "card_img03.jpg";
			break;
		case "tab04":
			imgName = "card_img04.jpg";
			break;
		case "tab01":
		default:
			imgName = "card_img01.jpg";
			break;
		}
		var sul2017_baseImgUrl = "http://imgenuri.enuri.gscdn.com/images/event/2017/sul/";
		var cardImgUrl = sul2017_baseImgUrl + imgName;
		$('#card_img').attr('src', cardImgUrl);
    });
    </script>
</head>

<body style="background:#f3ebd7">

<div class="msg_card">
    <div class="con_view">
        <h2 class="blind">새해카드가 도착했어요!</h2>

        <div class="box">
            <img src="http://imgenuri.enuri.gscdn.com/images/event/2017/sul/card_img01.jpg" id="card_img"/>
            <div class="msgarea" id="msgarea">
                <strong><span id="dear"></span></strong>
                <p id="msg"></p>
                <strong><span id="from"></span><strong>
            </div>
        </div>
        <button class="evt_send" onclick="window.open('/mobilefirst/event2016/newyear_2017.jsp')">이벤트 바로가기</button>
    </div>
</div>

</body>
</html>
