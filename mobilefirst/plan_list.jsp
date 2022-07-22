<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Today_Data"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Today_Proc"%>

<% 
	String strType = ChkNull.chkStr(request.getParameter("type"),"B");	
	String strImg   = ChkNull.chkStr(request.getParameter("type"),"B");	
	String strVersion   = ChkNull.chkStr(request.getParameter("version"),"");	
	String strApp_p   = ChkNull.chkStr(request.getParameter("app"),"");	
	String strDate = "";
	 
	if(strType.indexOf("_") > -1){
		String[] arrstrType = null;
		if (strType.trim().length() > 0 ){
			arrstrType = strType.split("_");
			strType = arrstrType[0]; 
			strDate = arrstrType[1]; 
		}	
	} 
	
	Mobile_Today_Proc mobile_today_proc = new Mobile_Today_Proc(); 
	Mobile_Today_Data plan_goods_data[] =  mobile_today_proc.get_plan_list2(strType, strDate); 
	
	String strAppYN = "";		
	
	try{
		Cookie[] cookies = request.getCookies();                		// 요청에서 쿠키를 가져온다.

		if(cookies!=null){                                                    	// 쿠키가 Null이 아닐때,
			for(int i=0; i<cookies.length; i++){                        	// 쿠키를 반복문으로 돌린다.
				if(cookies[i].getName().equals("appYN")){            // 쿠키의 이름이 id 일때
					strAppYN=cookies[i].getValue();                     // 해당 쿠키의 값을 id 변수에 저장한다.
				}
			} 
		}
	}catch(Exception e){}

	String strPartNo = "";
	String strTitle = "";
	String strWrap = "";
	String strFolder = "";
	
	if(strImg.equals("B_20150422")){
		strTitle = "어린이날 인기완구";
		strWrap = "child_wrap";
	}else if(strImg.equals("B_20150428")){
		strTitle = "가정의달 선물대전";
		strWrap = "familyday_wrap";
	}else if(strImg.equals("B_20150528")){
		strTitle = "여름시즌 신발대전";
		strWrap = "familyday_wrap";
		strFolder = "summer_shoes";
	}else if(strImg.equals("B_20150604")){
		strTitle = "물놀이용품 대전";
		strWrap = "swim_wrap";
		strFolder = "swim";
	} 
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta http-equiv="Cache-Control" Content="no-cache" />
<meta http-equiv="Pragma" Content="no-cache" />
<meta http-equiv="Expires" Content="0" />
<link href="/mobilenew/css/multiple-select.css" rel="stylesheet"/>
<link rel="stylesheet" type="text/css" href="/mobilefirst/css/default.css">
<link rel="stylesheet" type="text/css" href="/mobilefirst/css/gnb.css"/>
<link rel="stylesheet" type="text/css" href="/mobilefirst/css/footer.css">
<link rel="stylesheet" type="text/css" href="/mobilefirst/css/event/special_event.css"> 
<%@include file="/mobilefirst/include/common.html"%>   
<script>
//이미지 로더 
(function(e,t,n,r){e.fn.lazy=function(r){function u(n){if(typeof n!="boolean")n=false;s.each(function(){var r=e(this);var s=this.tagName.toLowerCase();if(f(r)||n){if(r.attr(i.attribute)&&(s=="img"&&r.attr(i.attribute)!=r.attr("src")||s!="img"&&r.attr(i.attribute)!=r.css("background-image"))&&!r.data("loaded")&&(r.is(":visible")||!i.visibleOnly)){var u=e(new Image);++o;if(i.onError)u.error(function(){d(i.onError,r);p()});else u.error(function(){p()});var a=true;u.one("load",function(){var e=function(){if(a){t.setTimeout(e,100);return}r.hide();if(s=="img")r.attr("src",u.attr("src"));else r.css("background-image","url("+u.attr("src")+")");r[i.effect](i.effectTime);if(i.removeAttribute)r.removeAttr(i.attribute);d(i.afterLoad,r);u.unbind("load");u.remove();p()};e()});d(i.beforeLoad,r);u.attr("src",r.attr(i.attribute));d(i.onLoad,r);a=false;if(u.complete)u.load();r.data("loaded",true)}}});s=e(s).filter(function(){return!e(this).data("loaded")})}function a(){if(i.delay>=0)setTimeout(function(){u(true)},i.delay);if(i.delay<0||i.combined){u(false);e(i.appendScroll).bind("scroll",h(i.throttle,u));e(i.appendScroll).bind("resize",h(i.throttle,u))}}function f(e){var t=l(),n=c(),r=e.offset().top,s=e.height();return t+n+i.threshold>r&&r+s>t-i.threshold}function l(){if(n.documentElement.scrollTop)return n.documentElement.scrollTop;return n.body.scrollTop}function c(){if(t.innerHeight)return t.innerHeight;if(n.documentElement&&n.documentElement.clientHeight)return n.documentElement.clientHeight;if(n.body&&n.body.clientHeight)return n.body.clientHeight;if(n.body&&n.body.offsetHeight)return n.body.offsetHeight;return i.fallbackHeight}function h(e,t){function s(){function o(){r=+(new Date);t.apply()}var s=+(new Date)-r;n&&clearTimeout(n);if(s>e||!i.enableThrottle)o();else n=setTimeout(o,e-s)}var n;var r=0;return s}function p(){--o;if(!s.size()&&!o)d(i.onFinishedAll,null)}function d(e,t){if(e){if(t!==null)e(t);else e()}}var i={bind:"load",threshold:500,fallbackHeight:2e3,visibleOnly:true,appendScroll:t,delay:-1,combined:false,attribute:"data-src",removeAttribute:true,effect:"show",effectTime:0,enableThrottle:false,throttle:250,beforeLoad:null,onLoad:null,afterLoad:null,onError:null,onFinishedAll:null};if(r)e.extend(i,r);var s=this;var o=0;if(i.bind=="load")e(t).load(a);else if(i.bind=="event")a();if(i.onError)s.bind("error",function(){d(i.onError,e(this))});return this};e.fn.Lazy=e.fn.lazy})(jQuery,window,document);
</script>
<script src="/mobilefirst/js/list_ui.js?v=1.0"></script>  
<title>에누리 가격비교</title>
<style type="text/css">
	a{ -webkit-user-select:none;}
	
	* {
		-webkit-tap-highlight-color: rgba(0, 0, 0, 0);  
	}		
	
	.my {background-color :#c1e0e5 !important;}
	
	html {
		-webkit-user-select: none;
		-webkit-touch-callout: none;
	}
</style>
</head>
<body> 
<div id="cm_loading" style="display:inline;position:absolute;z-index:999999;width:1px;height:1px;"></div>
<%@ include file="/mobilefirst/gnb/gnb.html" %> 
<div id="wrap">
	<nav class="m_top_sub">
	<h2><a href="javascript:history.back(-1)" class="back" <%if(strAppYN.equals("Y")){%> style="display:none;"<%}else{%><%}%>>뒤로가기</a><%=strTitle%></h2>
	</nav> 
		<!-- 201504210 기획전 시작 -->
		<section id="container" class="<%=strWrap%>">
			<div class="top_visual">
				<img src="<%=IMG_ENURI_COM%>/images/mobilefirst/planlist/<%=strImg%>_top.png"  />
			</div>
			<div class="tab_area"> 
				<img src="<%=IMG_ENURI_COM%>/images/mobilefirst/planlist/<%=strImg%>_tab.png" alt="" />
				<div  class="tab_list"> 
					<%if(strImg.equals("B_20150422")){%>
						<a href="javascript:///" class="tabs tab1" id="tab1">로봇</a>
						<a href="javascript:///" class="tabs tab2" id="tab2">과학완구</a>
						<a href="javascript:///" class="tabs tab3" id="tab3">레고</a> 
						<a href="javascript:///" class="tabs tab4" id="tab4">인형</a>
						<a href="javascript:///" class="tabs tab5" id="tab5">승용완구</a>
					<%}else if(strImg.equals("B_20150428")){%>
						<a href="javascript:///" class="tabs tab1" id="tab1">홍삼</a>
						<a href="javascript:///" class="tabs tab2" id="tab2">건강식품</a>
						<a href="javascript:///" class="tabs tab3" id="tab3">화장품</a>
						<a href="javascript:///" class="tabs tab4" id="tab4">지갑/벨트</a>
						<a href="javascript:///" class="tabs tab5" id="tab5">아웃도어</a>				
					<%}else if(strImg.equals("B_20150528")){%>
						<a href="javascript:///" class="tabs tab1" id="tab1">운동화</a>
						<a href="javascript:///" class="tabs tab2" id="tab2">스니커즈</a>
						<a href="javascript:///" class="tabs tab3" id="tab3">아쿠아슈즈</a>
						<a href="javascript:///" class="tabs tab4" id="tab4">샌들</a> 
						<a href="javascript:///" class="tabs tab5" id="tab5">젤리슈</a>	
					<%}else if(strImg.equals("B_20150604")){%>
						<a href="javascript:///" class="tabs tab1" id="tab1">래쉬가드</a>
						<a href="javascript:///" class="tabs tab2" id="tab2">수영복</a>
						<a href="javascript:///" class="tabs tab3" id="tab3">튜브/풀장</a>
						<a href="javascript:///" class="tabs tab4" id="tab4">구명조끼</a> 
						<a href="javascript:///" class="tabs tab5" id="tab5">물놀이완구</a>	
					<%}%>
				</div>  
			</div> 
			<!--
			<p class="cons_title">
				<img src="<%=IMG_ENURI_COM%>/images/mobilefirst/planlist/<%=strImg%>_title.png" alt="최저가 쿠폰 + 추가할인 적용 쇼핑몰 : 11번가, 인터파크" />
			</p>-->
			<% for (int i = 0 ; i < plan_goods_data.length; i++ ){
				String strImageUrl = ImageUtil.getImageSrc(CutStr.cutStr(plan_goods_data[i].getCa_code(),4), plan_goods_data[i].getModelno(), plan_goods_data[i].getImgchk(), plan_goods_data[i].getP_pl_no(), plan_goods_data[i].getP_imgurl(), plan_goods_data[i].getP_imgurlflag());
				String strImageUrl_middle = strImageUrl;
 
				String smallImgUrlFinder = "/data/images/service/small/";
				int smallFinderIdx = strImageUrl.indexOf(smallImgUrlFinder);
				// 500이미지로 변경
				if(smallFinderIdx>-1) {
					strImageUrl_middle = strImageUrl.substring(0, smallFinderIdx);
					strImageUrl_middle += "/data/images/service/middle/";
					strImageUrl_middle += strImageUrl.substring(smallFinderIdx + smallImgUrlFinder.length());

					int lastDotIdx = strImageUrl_middle.lastIndexOf(".");
					strImageUrl_middle = strImageUrl_middle.substring(0, lastDotIdx) + ".jpg";
				}
				
				String strKeyword2 = plan_goods_data[i].getKeyword2();
				strKeyword2 = ReplaceStr.replace(strKeyword2,"★","");
				strKeyword2 = ReplaceStr.replace(strKeyword2,"▶","");
				strKeyword2 = ReplaceStr.replace(strKeyword2,"\"","&quot;");
				
				if(!plan_goods_data[i].getPart_no().equals(strPartNo)){
					strPartNo = plan_goods_data[i].getPart_no();
				%>		
					<p id="title_<%=strPartNo%>" class="tab_cons">
						<img src="<%=IMG_ENURI_COM%>/images/mobileevent/<%=strFolder%>/txt<%=strPartNo%>.png"  />
					</p>
				<%}%>
				<%if(plan_goods_data[i].getMinprice() == 0 && plan_goods_data[i].getMallcnt() == 0){%>
				<%}else{%>
					<div class="goods" id="<%=plan_goods_data[i].getModelno()%>">
						<div class="thumb" style="">
						<img src="<%=strImageUrl_middle%>" onerror="this.src='<%=strImageUrl%>'" alt="" />
						</div>
						<div class="infobox"> 
							<p class="company"><%=plan_goods_data[i].getFactory()%></p> 
							<p class="product"><%=plan_goods_data[i].getModelnm()%></p>
							<p class="description"><%=strKeyword2%></p> 
							<p class="priceinfo">
								<%if(plan_goods_data[i].getMinprice() == 0 && plan_goods_data[i].getMallcnt() == 0){%>
								<span style="color:#1e67df">품절</span>
								<%}else{%> 
								<span class="lowest">최저가</span><span class="price"><%=FmtStr.moneyFormat(plan_goods_data[i].getMinprice3()+"")%></span><span class="won">원</span>
								<%}%>
							</p>
						</div>  
					</div>
				<%
					strPartNo = plan_goods_data[i].getPart_no();
				  }
				%>	
		<%}%>
		</section>
		<!-- //201504210 기획전 끝 -->

	</div>
	<%@ include file="/mobilefirst/include/footer.jsp"%>  
<%@ include file="/mobilefirst/resentzzim/zzimListInc.jsp"%> 	

</body>
<script>
	ga('send', 'pageview', {
		'page': '/mobilefirst/plan_list.jsp',
		<%if(strImg.equals("B_20150422")){ %>
		'title': 'mf_기획전_어린이날'
		<%}else if(strImg.equals("B_20150428")){ %>
		'title': 'mf_기획전_가정의달'
		<%}else if(strImg.equals("B_20150528")){ %>
		'title': 'mf_기획전_여름신발'
		<%}else if(strImg.equals("B_20150604")){ %>
		'title': 'mf_기획전_물놀이'
		<%}%> 
	});    
 
	jQuery(document).ready(function($) { 

		var vAppyn = getCookie("appYN");
		var vAppyn2 = '<%=strApp_p%>';

		if(vAppyn2 == "Y"){
			$(".top_Bnr").hide();
			$("header").hide();
		}
		/*if(vAppyn == "Y"){
			$(".m_top").hide();	 
		}else{
			$(".m_top").show();
		}*/
   
		if(vAppyn == "Y" || vAppyn2 == "Y"){
			$(".m_top_sub .back").hide();
		} 
		
	    $(".newgnb > li > a").on('click', function(){
	        var $this = $(this),
	            url = $(this).attr('href');
	        
	        if($this.is('.newWindow')){
	            window.open(url);
	        }else{
	            $(".newgnb > li > a.on").removeClass('on');
	            location.href = url;
	        }
	        
	        // log    
	        return false;
	    });    
	    
	    $(".tabs").click(function() { 
	    	var varId = this.id.replace("tab",""); 
	    	if(vAppyn == "Y"){
	    		scrollTo(0, $("#title_"+varId).position().top+$(".m_top_sub").height());
	    	}else{
	    		scrollTo(0, $("#title_"+varId).position().top+$("header").height()+$(".m_top_sub").height());
	    	}
	    }); 
	     
  		$(".goods").click(function() { 
  			var varId = this.id; 
  			location.href = "/mobilefirst/detail.jsp?modelno="+varId;
  		});
	});	
 
</script>
<%@ include file="/mobilefirst/include/common_logger.html"%>  
</html>
