<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%
	String strPagenm = ChkNull.chkStr(request.getParameter("pagenm"));
	String strCate = ChkNull.chkStr(request.getParameter("cate"));

	if(strPagenm.equals("main")){

%>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-53076228-1', 'auto');
  ga('set', 'forceSSL', true);
  ga('require', 'displayfeatures');
  ga('require', 'linkid', 'linkid.js');
  ga('send', 'pageview');
</script>
<script language=javascript src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail.js?v=202002191"></script>
<%/*%>
<script type="text/javascript" src="//static.criteo.net/js/ld/ld.js" async="true"></script>
<script type="text/javascript">
window.criteo_q = window.criteo_q || [];
window.criteo_q.push(
        { event: "setAccount", account: 17070 },
        { event: "setSiteType", type: "d" },
        { event: "viewHome" }
);
</script>
<%*/%>
<%
	}else if(strPagenm.equals("list") || strPagenm.equals("search") ){
	/* google-analytics */
	   if (strPagenm.equals("list")){
%>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-53076228-1', 'auto');
  ga('set', 'forceSSL', true);
  ga('require', 'displayfeatures');
  ga('require', 'linkid', 'linkid.js');
  ga('send', 'pageview');
</script>

<%
	   }else{
%>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-53076228-1', 'auto');
  ga('set', 'forceSSL', true);
  ga('require', 'displayfeatures');
  ga('require', 'linkid', 'linkid.js');
  ga('send', 'pageview');
</script>
<%
	   }
	}else if(strPagenm.equals("planevent")){
%>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-53076228-1', 'auto');
  ga('set', 'forceSSL', true);
  ga('require', 'displayfeatures');
  ga('require', 'linkid', 'linkid.js');
  ga('send', 'pageview');
</script>
<script language=javascript src="/common/js/Log_Tail.js?v=2018123102"></script>
<%
	}else if(strPagenm.equals("knowbox")){
%>
<script language=javascript src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail.js?v=2018123102"></script>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-53076228-1', 'auto');
  ga('set', 'forceSSL', true);
  ga('require', 'displayfeatures');
  ga('require', 'linkid', 'linkid.js');
  ga('send', 'pageview');
</script>
<%
	}else if(strPagenm.equals("tour")){
%>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-53076228-1', 'auto');
  ga('set', 'forceSSL', true);
  ga('require', 'displayfeatures');
  ga('require', 'linkid', 'linkid.js');
  ga('send', 'pageview');
</script>
<script language="JavaScript"> _TRK_CC=51 </script>
<script language=javascript src="<%=ConfigManager.IMG_ENURI_COM%>/common/js/Log_Tail.js?v=2018123102"></script>
<%
	}else if(strPagenm.equals("opengoods") || strPagenm.equals("eventreview") || strPagenm.equals("eventreviewall")){
%>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-53076228-1', 'auto');
  ga('set', 'forceSSL', true);
  ga('require', 'displayfeatures');
  ga('require', 'linkid', 'linkid.js');
  ga('send', 'pageview');
</script>

<%
	}
%>
<!-- 다음 DDN -->
<script type="text/javascript">
    var roosevelt_params = {
        retargeting_id:'7Nkvme4SXizvSOykgyChpQ00',
        tag_label:'JZryQWV0TKCJsqPbMCgNyg'
    };
</script>
<script type="text/javascript" src="//adimg.daumcdn.net/rt/roosevelt.js"></script>
<%
	if (CutStr.cutStr(strCate,4).equals("0801") ){
%>
<%/* Facebook Conversion Code for 에누리_화장품_0801 */%>
<script>(function() {
  var _fbq = window._fbq || (window._fbq = []);
  if (!_fbq.loaded) {
    var fbds = document.createElement('script');
    fbds.async = true;
    fbds.src = '//connect.facebook.net/en_US/fbds.js';
    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(fbds, s);
    _fbq.loaded = true;
  }
})();
window._fbq = window._fbq || [];
window._fbq.push(['track', '6017348819930', {'value':'0.00','currency':'KRW'}]);
</script>
<noscript><img height="1" width="1" alt="" style="display:none" src="https://www.facebook.com/tr?ev=6017348819930&amp;cd[value]=0.00&amp;cd[currency]=KRW&amp;noscript=1" /></noscript>
<%
	}else if(CutStr.cutStr(strCate,4).equals("1471")){
%>
<%/* Facebook Conversion Code for 에누리_패션_1471 */%>
<script>(function() {
  var _fbq = window._fbq || (window._fbq = []);
  if (!_fbq.loaded) {
    var fbds = document.createElement('script');
    fbds.async = true;
    fbds.src = '//connect.facebook.net/en_US/fbds.js';
    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(fbds, s);
    _fbq.loaded = true;
  }
})();
window._fbq = window._fbq || [];
window._fbq.push(['track', '6017348903730', {'value':'0.00','currency':'KRW'}]);
</script>
<noscript><img height="1" width="1" alt="" style="display:none" src="https://www.facebook.com/tr?ev=6017348903730&amp;cd[value]=0.00&amp;cd[currency]=KRW&amp;noscript=1" /></noscript>
<%
	}
%>
