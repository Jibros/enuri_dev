<%
String nowUrl = request.getRequestURL().toString();
String navType = ChkNull.chkStr(request.getParameter("type"));
boolean pick1 = false;
boolean pick2 = false;
if(nowUrl.indexOf("trend_news")>-1){
	if(navType.equals("pickup")) pick2 = true;
	else pick1 = true;
}
%>
<li><a href="javascript:///" <%if(nowUrl.indexOf("IndexNew")> -1) out.println("class='on'");%> onclick="javascript:goNavLink('/mobilefirst/IndexNew.jsp');">홈</a></li>
<li><a href="javascript:///" <%if(nowUrl.indexOf("hotShop.jsp")> -1) out.println("class='on'");%> onclick="javascript:goNavLink('/mobilefirst/renew/hotShop.jsp');">핫딜베스트</a></li>
<li><a href="javascript:///" <%if(nowUrl.indexOf("mart")> -1) out.println("class='on'");%> onclick="javascript:goNavLink('/mobilefirst/renew/mart.jsp');">마트핫픽#</a></li>
<li><a href="javascript:///" <%if(nowUrl.indexOf("plan")> -1) out.println("class='on'");%> onclick="javascript:goNavLink('/mobilefirst/renew/plan.jsp');">기획전</a></li>
<li><a href="javascript:///" <%if(pick1) out.println("class='on'");%> onclick="javascript:goNavLink('/mobilefirst/renew/trend_news.jsp');">쇼핑팁+</a></li>
<li><a href="javascript:///" <%if(pick2) out.println("class='on'");%> onclick="javascript:goNavLink('/mobilefirst/renew/trend_news.jsp?type=pickup');">트렌드픽업</a></li>
<li><a href="javascript:///" <%if(nowUrl.indexOf("best")> -1) out.println("class='on'");%> onclick="javascript:goNavLink('/mobilefirst/renew/best.jsp');">특가모음</a></li>
<script>
function goNavLink(url){
    var navType = "<%=navType%>";
    var type = "";
    
    if(url.indexOf("IndexNew") > -1 )       type = "홈";
    else if(url.indexOf("hotShop") > -1) type = "핫딜베스트";
    else if(url.indexOf("mart") > -1) type = "마트";
    else if(url.indexOf("plan") > -1) type = "이벤트기획전";
    else if(url.indexOf("best") > -1) type = "특가모음";
    
    if(url.indexOf("trend_news") > -1){
        if(url.indexOf('pickup') > -1 )  type = "트렌드픽업";
        else type = "쇼핑팁";
    }

    ga('send', 'event', 'mf_home', 'tab', 'tab_'+type);
    location.href = url;
}
</script>