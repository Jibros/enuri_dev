<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%>
<%
	String verand = request.getParameter("verand");
	String verios = request.getParameter("veriosr");

	String ver;
	if (verand != null)
		ver = verand;
	else
		ver = verios;
	int version = 0;
	if (ver != null) {
		if (ver.length() >= 5) {
			try {
				version = Integer.parseInt(ver.substring(0, 1)) * 100 + Integer.parseInt(ver.substring(2, 3)) * 10 + Integer.parseInt(ver.substring(4, 5));
			} catch (Exception e) {
			}
		}
	}
	JSONObject makeJson = new JSONObject();
	
	
%>{"HOTDEAL":[{"logo":"\/mobilefirst\/hotdeal\/20160617\/20160617_hotdeal_superdeal.png","title":"슈퍼딜",
"deal":"\/view\/ls_logo\/2013\/Ap_logo_536_deal1.png",
"file":"superDeal","shopcode":"536","url":"\/http\/json\/superDeal.json","mall":"superdeal"},
{"logo":"\/mobilefirst\/hotdeal\/20160617\/20160617_hotdeal_allkill2.png",
"title":"올킬","deal":"\/view\/ls_logo\/2013\/Ap_logo_4027_deal1.png",
"file":"allKill","shopcode":"4027","url":"\/http\/json\/allKill.json","mall":"allkill"},
{"logo":"\/mobilefirst\/hotdeal\/20160617\/20160617_hotdeal_shocking.png",
"title":"쇼킹딜","deal":"\/view\/ls_logo\/2013\/Ap_logo_5910_deal1.png",
"file":"shocking","shopcode":"5910","url":"\/http\/json\/shocking.json","mall":"shocking"},
{"logo":"\/mobilefirst\/hotdeal\/20160617\/20160617_hotdeal_tmon.png","title":"티몬",
"deal":"\/view\/ls_logo\/2013\/Ap_logo_6641_deal1.png","file":"tmon",
"shopcode":"6641","url":"\/http\/json\/tmon.json","mall":"tmon"},
{"logo":"\/mobilefirst\/hotdeal\/20170330\/20170330_hotdeal_wemake.png","title":"위메프",
"deal":"\/view\/ls_logo\/2013\/Ap_logo_6508_deal1.png","file":"wemake","shopcode":"6508",
"url":"\/http\/json\/wemake.json","mall":"wemake"},

{"logo":"\/mobilefirst\/hotdeal\/20160617\/20170228_hotdeal_ssendeal.png","title":"쎈딜",
"deal":"\/view\/ls_logo\/2013\/Ap_logo_55_deal.png","file":"ssendeal","shopcode":"55","url":"\/http\/json\/ssenDeal.json",
"mall":"ssendeal"}],

"TABS":[{"INDEX":"1","SHOWA":"Y","START":"201701010000","NAME":"MAIN","END":"","SHOWI":"Y","TITLE":"홈"},
{"INDEX":"2","SHOWA":"Y","START":"201701010000","NAME":"HOTDEAL","END":"","SHOWI":"Y","TITLE":"핫딜베스트"},
{"INDEX":"3","SHOWA":"Y","START":"201701010000","NAME":"MART","END":"","SHOWI":"Y","TITLE":"마트핫픽#"},
{"INDEX":"4","SHOWA":"Y","START":"201701010000","NAME":"PLAN","END":"","SHOWI":"Y","TITLE":"기획전"},
{"INDEX":"5","SHOWA":"Y","START":"201701010000","NAME":"","END":"","SHOWI":"Y","TITLE":"기획탭"},
{"INDEX":"6","SHOWA":"Y","START":"201701010000","NAME":"SHOPPINGTIP","END":"","SHOWI":"Y","TITLE":"쇼핑팁+"},
{"INDEX":"7","SHOWA":"Y","START":"201701010000","NAME":"TRANDPICKUP","END":"","SHOWI":"Y","TITLE":"트렌드픽업"},
{"INDEX":"8","SHOWA":"Y","START":"201701010000","NAME":"BESTSHOP","END":"","SHOWI":"Y","TITLE":"특가모음"}<%
	if (false) {
%>,{"INDEX":"9","SHOWA":"Y","START":"201701010000","NAME":"ALLSHOP","END":"","SHOWI":"Y","TITLE":"종합몰"}<%
	}
%>],"BUF_TAB":{
"BUF_TAB_LINK_AOS":"market://details?id=com.enuri.deal&referrer=utm_source%3Denuri%26utm_medium%3Dhiddentab_click%26utm_campaign%3Dhiddentab_20170510",
"BUF_TAB_COLOR_AOS":"E4E4E4",
"BUF_TAB_IMAGE_IOS":"/images/mobilefirst/extra_tab/buftab/extratab_bg_20170510",
"BUF_TAB_COLOR_IOS":"E4E4E4",
"BUF_TAB_LINK_IOS":"https://itunes.apple.com/kr/app/id944887654?freetoken=outlink",
"BUF_TAB_IMAGE_AOS":"/images/mobilefirst/extra_tab/buftab/extratab_bg_20170510"
},"EVENT_BTN":{
"EVENT_BTN_LINK_URL_IOS":"http:\/\/m.enuri.com\/mobilefirst\/event2016\/allpayback_201608.jsp?freetoken=event",
"EVENT_BTN_LINK_URL_AOS":"http:\/\/m.enuri.com\/mobilefirst\/event2016\/allpayback_201608.jsp?freetoken=event",
"EVENT_BTN_YN":"Y",
"EVENT_BTN_IMAGE_URL":"\/images\/mobilefirst\/floating_event\/event_floating0627"
}}
