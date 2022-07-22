<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>

<%
	String strGcate = ChkNull.chkStr(request.getParameter("gcate"	    ),""); //  CPP카테고리

	if(strGcate.indexOf("gcate=") > -1){
		strGcate = strGcate.substring(strGcate.indexOf("gcate=")+6, strGcate.length());
	}

	if(strGcate.equals("")){
		strGcate = "1";
	}

	//컴퓨터 CPP 카테고리가 3으로 바뀜
 	if(strGcate.equals("3")){
		response.sendRedirect("/cpp/cpp_m.jsp");
	} else {
		// 스마트쇼핑 from=st 처리
		String strfrom = ChkNull.chkStr(request.getParameter("from"),"");
		if(strfrom.equals("swt")){
			cb.setCookie_One("FROM",strfrom);
			cb.SetCookieExpire("FROM",-1);
			cb.responseAddCookie(response);
		}
	}

%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="http://img.enuri.info/images/mobilefirst/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />
	<%@include file="/mobilefirst/renew/include/common.html"%>
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/main.css"/>
	<link rel="stylesheet" type="text/css" href="http://m.enuri.com/mobilefirst/css/lib/slick.css"/>
	<script type="text/javascript" src="/mobilefirst/js/lib/LazyLoad.1.9.3.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	ga('create', 'UA-52658695-3', 'auto');
	</script>
</head>
<body>
<%@ include file="/mobilefirst/include/common_top.jsp" %>
<div id="wrap">
<div id="main">
    <%if(!strApp.equals("Y")){%>
    <%@include file="/mobilefirst/renew/include/gnbCpp.html"%>

	<%}%>
	<!-- 서브 -->
	<nav class="m_top_sub">
		<!-- 20170209 cpp 메뉴 개선-->
		<div class="maincate">
			<ul id="cppcategory">
			</ul>
		</div>

		<div  class="sub_cata">
			<ul id="cppcategory_list">
			</ul>
			<p class="more_cata" id="more" onclick="click_more();"><a href="javascript:///"><span id="view_more" >더보기</span></a></p>
		</div>
		<!-- ///20170209 cpp 메뉴 개선-->

	</nav>
	<!--// 서브 -->
	<!--// 헤더영역 -->

	<div class="Maincontent">
		<!--<p class="cpp_bnr"><img src="http://img.enuri.info/images/m_home_2018/@cpp_bnr.png" alt=""  /></p>-->
        <div class="mainbnr" id="BannerListDiv">
        	<ul class="evtbnr" id="BannerList"></ul>
        </div>
		<!-- 쇼핑뉴스 -->
		<div class="con_box" id="con_box_news">
			<h3>쇼핑뉴스<!--<a href="javascript:goMore('news');" class="more">더보기</a>--></h3>
			<div class="top_news_box">
				<ul id="news_img"></ul>
			</div>
			<ul class="news_list" id="news_text">	</ul>
		</div>
		<!--// 쇼핑뉴스 -->

		<!-- 추천기획전 -->
		<div class="con_box"  id="con_box_plan">
			<h3>추천기획전</h3>
			<div class="mainbnr">
				<ul class="evtbnr" id="PlanList"></ul>
			</div>
		</div>
		<!--// 추천기획전 -->

		<!-- 쇼핑가이드 -->
		<div class="con_box"  id="con_box_guide">
			<h3>쇼핑가이드<!--<a href="javascript:goMore('guide');" class="more">더보기</a>--></h3>
			<div class="top_news_box">
				<ul id="shoppingGuideList"></ul>
			</div>
		</div>
		<!--// 쇼핑가이드 -->

		<!-- 소셜 인기상품 -->
		<div class="con_box"  id="con_box_social">
			<h3>소셜 인기상품<a href="javascript:goMore('social');" class="more">더보기</a></h3>

			<div class="hit_scroll">
				<div class="hit_List_area">
					<ul class="hit_product" id="socialList"></ul>
				</div>
			</div>

		</div>
		<!--// 소셜 인기상품 -->

		<!-- 오늘의 추천상품 -->
		 <div class="today_goods">
			<ul class="today_list" id="mainlist">	</ul>
		 </div>
		<!--// 오늘의 추천상품 -->

	</div>

	<div class="newquick">
		<!--<p class="cateBtn">카테고리</p>-->
		<p class="TBtn">TOP</p>
	</div>
	<%@ include file="/mobilefirst/resentzzim/zzimListInc.jsp"%>
	<%@ include file="/mobilefirst/include/inc_ctu.jsp"%>
	<!-- 푸터 -->
    <%@ include file="/mobilefirst/renew/include/footer.jsp"%>
	<!-- //푸터 -->
	</div>
</div>
</body>
</html>
<script>
$.ajaxSetup({
    async: false
});
$(document).ready(function() {
	var cpp_list ;
	var cppList ;
	var ShoppingGuideList;
	var NewsList ;
	var mainBanner ;
	var planList ;
	var socialGoods ;
	var gcate = '<%=strGcate%>';
	var bMainlist = false;
	$.getJSON('/mobilefirst/http/json/cppAppJson_2018_'+gcate+'.json', function(data) {
		cpp_list = data.cppHeadCate.cpp_list;
		cppList= data.cppJSon.cppList;
		ShoppingGuideList = data.getShoppingGuide;
		NewsList = data.getNews.NewsList;
		mainBanner = data.mainBanner;
		planList = data.getPlan;
		socialGoods = data.getSocial;
	});

	getBanner();
	getCategory();
	getNews();
	getPlan();
	getShoppingGuide();
	getSocial();

	$(window).scroll(function()
    {
		//if(jQuery(window).scrollTop() > 50 && $("#listarea").height() > 0){
		if(jQuery(window).scrollTop() + jQuery(window).height() >  Number($("#con_box_social").position().top) + 100){
			//if($("#mainlist").html().length  < 100 ){
			if(!bMainlist){
				getMainList();
			}
		}
	 });
	$(".srp").click(function(){
		$("#searchWrap").show();
		$(".sch_box_area").show();
		searchLockScroll();
	});

	function getCategory(){

		var loadUrl = "/mobilefirst/gnb/category/cppCategory_2018.json";
		var img_count = 0;
		var class_on ="";
		$.ajax({
			url: loadUrl,
			dataType: 'json',
			async: false,
			success: function(json){
					$.each(json.ONELEVEL, function(i, v){
						if(v.g_cate == gcate){
							$("#gCateNM").html(v.g_name);
						}
					});
					$.each(json.TWOLEVEL, function(i, v){

	                var html = "";
	                var catenm = "";
	                var html_list ="";

	                if(v.g_cate == "0243"){
	                	return ;
	                }

	                if(v.g_parent == gcate){
	                	if(img_count==0){
	                		html += "<li class=\"on\" id=\"cpp_"+v.g_parent+"_"+v.g_cate+"\" onclick=\"ga_log_cate_top('"+v.g_name+"');\"><img src=\"http://img.enuri.info/images/m_home_2018/cpp_"+v.g_parent+"_"+v.g_cate+"_on.png\" /><span class=\"dp\" >"+v.g_name+"</span></li>";
	                		class_on = v.g_seqno;
	                	}else{
	                		html += "<li id=\"cpp_"+v.g_parent+"_"+v.g_cate+"\" onclick=\"ga_log_cate_top('"+v.g_name+"');\"><img src=\"http://img.enuri.info/images/m_home_2018/cpp_"+v.g_parent+"_"+v.g_cate+".png\" /><span class=\"dp\">"+v.g_name+"</span></li>";
	                	}
	                	img_count = img_count+1;



	                	var threeCnt = 0;

		            	$.each(json.THREELEVEL, function(i, f) {
		            			catenm = v.g_name+"_"+f.g_name.replace(/<br>/gi," ");
		            			if(v.g_seqno==f.g_parent){
		             			//if(catenm != "여행_인기여행사" || f.g_cate != '11600'){
		             			if((catenm != "여행_인기여행사") && (f.g_cate != '11600')){
		             				html_list += "<li class=\""+v.g_seqno+"\" id=\""+v.g_seqno+"_"+threeCnt+"\" onclick=\"CmdCate('"+f.g_cate+"');CmdGA('gcate<%=strGcate%>_cate','"+catenm+"');\" >"+f.g_name.replace(/<br>/gi,"")+"</li>";
		 							threeCnt++;
		 						}
							}
						});
	            		if(threeCnt % 2 == 1) {
	            			html_list += "<li class=\""+v.g_seqno+"\" id=\""+v.g_seqno+"_"+threeCnt+"\" style=\"background-color: #FFFFFF;display: list-item;\" \">&nbsp</li>";
	            		}
	                }
                	$("#cppcategory").append(html);
                	$("#cppcategory_list").append(html_list);
                	$("#cppcategory_list li").hide();
			    });
					var li_cnt = $("#cppcategory li").length;
					var get_id = "";
					for(i=0; i<li_cnt; i++){
						get_id = $("#cppcategory li:eq("+i+")").attr('id');
						if($("#"+get_id).hasClass("on")){
							CmdCppCate(get_id);
						}
					}
					// var get_id = "cpp_2_04";
					//var get_id = $(".on").attr('id');


				for(var i=0; i<10; i++){
					$("#"+class_on+"_"+i).show();
				}
				if(img_count<5){
					var adminHtml = "";
 	                //console.log("cpp_list:");
 	                //console.log(cpp_list);
 	           		$.each(cpp_list, function(i, v) {
						if(v.EX_CPP_CATECODE == gcate){
							var onClickHTML = "";
							if(v.CPP_URL != '') {
								onClickHTML = "location.href='" + v.CPP_URL + "'";
							} else if(v.LINK_CATECODE_S != '') {
								onClickHTML = "CmdCate('" + v.LINK_CATECODE_S + "')";
							} else if(v.LINK_CATECODE_M != '') {
								onClickHTML = "CmdCate('" + v.LINK_CATECODE_M + "')";
							} else if(v.LINK_CATECODE_L != '') {
								onClickHTML = "CmdCate('" + v.LINK_CATECODE_L + "')";
							}

							adminHtml += "<li onclick=\"" + onClickHTML + "\">"
									+ 		"<span class=\"spm\" onclick=\"ga_log_cate_top('sub_'+'"+v.EX_TOP+"'+'"+v.EX_BOTTOM+"');\">"
									+ 			"<em class=\"sty1\" id=\"sty1\" style=\"background-color:"+v.EX_TAG_BG+"\">" + v.EX_TAG + "</em>"
									+			"<strong>"+v.EX_TOP+"<br />"+v.EX_BOTTOM+"</strong>"
									+		"</span>"
									+	"</li>";
						}
					});
 	               $("#cppcategory").append(adminHtml);
 	               click_li();
				}
				click_li();
				ga('send', 'pageview', {
					'page': '/mobilefirst/cpp.jsp',
					'title': 'mp_CPP_'+$("#gCateNM").html()
				});
			}
		});

	}
	function click_li(){
		$( ".maincate li").click(function() {
			$("#view_more").removeClass("on");
			$("#view_more").html("더보기");
			var change_on = this.id; //cpp_2_07
			//ga_log_cate_top(change_on);
				var make_class_on = 1 + change_on.substring(6,8);
				var html_list="";
				if(change_on !=''){
					 $(".maincate li").each(function () {
						 var change_off = this.id;
						 //이미지 off
						 if(change_off != ''){
							 $("#"+change_off+" img").attr("src","http://img.enuri.info/images/m_home_2018/"+ change_off +".png");
							 //클래스 off
							 $("#"+change_off).removeClass("on");
						 }
					 });
					 //선택된 이미지 on
					 $("#"+change_on+" img").attr("src","http://img.enuri.info/images/m_home_2018/"+ change_on +"_on.png");
					 //선택된 이미지 off
					 $("#"+change_on).addClass("on");
					 $("#cppcategory_list li").hide();
					//최대 5줄만 show.
					 for(var i=0; i<10; i++){
						$("#"+make_class_on+"_"+i).show();
					}
					 var li_cnt = $("#cppcategory li").length;
					 var get_id = "";
					 for(i=0; i<li_cnt; i++){
							get_id = $("#cppcategory li:eq("+i+")").attr('id');
							if($("#"+get_id).hasClass("on")){
								CmdCppCate(get_id);

							}
						}
			}

		});

	}

	function getNews(){

		$.each(NewsList , function(i, v){
            var html_img = "";
            var html_text = "";

            if( i < 2 && gcate <= 8){
            	html_img += "<li><a href=\"javascript:goNews('"+v.kb_no+"')\">";
            	html_img += "	<img src=\""+v.mn_img+"\" alt=\"\" class=\"thumb\" />";
            	html_img += "	<span class=\"tit\">"+v.mn_title+"</span>";
            	html_img += "</a></li>"
            }else{
		    	html_text +="<li><a href=\"javascript:goNews('"+v.kb_no+"')\">"+v.mn_title+"</a></li>";
		    }

			$("#news_img").append(html_img);
			$("#news_text").append(html_text);

	    });
	}

	function getBanner(){
        var vHtml = "";
		$.each(mainBanner, function(i, v){
            vHtml += "<li><a href="+v.JURL1+" title="+v.TXT1+"><img src="+v.TARGET+" alt="+v.ALT+" onclick=\"CmdGA('gcate<%=strGcate%>_banner','"+v.TXT1+"');\" /></a></li>";
	    });

		$("#BannerList").append(vHtml);

		$('#BannerList').slick({
			  dots: true,
			  infinite: true,
			  speed: 300,
			  slidesToShow: 1,
			  adaptiveHeight: true,
			  autoplay: true,
			  autoplaySpeed: 3000
		});

    	if($("#BannerList").html().length < 100) {
			$("#BannerListDiv").hide();
		}

		$.each(mainBanner, function(i, v){

            //광고 노출 count 호출
            var $iFrm = $('<iframe id="iFrm" name="iFrm" scrolling="no"  width="0" height="0" frameborder="0" ></IFRAME>');
            $iFrm.attr('src', v.IMG1);
            $iFrm.appendTo('body');

        });
	}

	function getShoppingGuide(){

		$shoppingGuide = $('#shoppingGuide');
		$("#shoppingGuideList").append(Mustache.render($shoppingGuide.html(), ShoppingGuideList));// 템플릿에 연동
		//$("img.lazy").lazyload();
		//console.log("ShoppingGuideList2lenght1:"+ShoppingGuideList.length);
		//console.log("lenght:"+$("#shoppingGuideList").html());
		if($("#shoppingGuideList").html().length < 100) {

			$("#con_box_guide").hide();
		}
		setTimeout(function() {
			//console.log("ShoppingGuideList2lenght2:"+ShoppingGuideList.length);
			var vHeightmin = "";
			$("#shoppingGuideList li").each(function () {
				var vHeightimg = $(this).find("img").css("height").replace("px","");
				if(vHeightmin == "" || vHeightmin > vHeightimg){
					vHeightmin = vHeightimg;
				}
			});
			$("#shoppingGuideList").find("img").css("height", vHeightmin);
		}, 500);
	}

	function getPlan(){

		$Plan = $('#Plan');
		$("#PlanList").append(Mustache.render($Plan.html(), planList));// 템플릿에 연동
		//$("img.lazy").lazyload();
		$('#PlanList').slick({
			  dots: true,
			  infinite: true,
			  speed: 300,
			  slidesToShow: 1,
			  adaptiveHeight: true,
			  autoplay: true,
			  autoplaySpeed: 3000
		});
		if($("#PlanList").html().length < 200) {
			$("#con_box_plan").hide();
		}
	}

	function getSocial(){

		$social = $('#social');
		$("#socialList").append(Mustache.render($social.html(), socialGoods));// 템플릿에 연동
	}

	function getMainList(){

		bMainlist = true;

		//var loadUrl = "/mobilefirst/ajax/cppAjax/getMainList.jsp?gcate="+gcate;
		items = shuffle(cppList);

		$.each(items, function(i, v){
            var vHtml = "";

            if(i < 50){
            	vHtml += "<li> ";
            	vHtml += "<a href=\"javascript:///\" onclick=\"CmdGo('C','"+v.modelno+"','"+v.pl_no+"','','"+v.url+"','"+v.shopcode+"','"+v.category+"');CmdGA('gcate<%=strGcate%>_goods_1', '"+v.modelno+"');\"> ";
				vHtml += "<div class=\"thum\"><img src=\""+v.img+"\" alt=\"\"  id=\"img_"+v.modelno+"\" onerror=\"CmdErrImg('"+v.modelno+"','"+v.img_err+"')\"  /></div> ";
				vHtml += "<span class=\"mall\" id=\"mall_"+v.modelno+"\" ><img src=\"http://img.enuri.info/images/view/ls_logo/2013/Ap_logo_"+v.shopcode+".png\" alt=\""+v.shopname+"\" onerror=\"this.style.display='none';CmderrLogo("+v.modelno+",'"+v.shopname+"');\"  /></span> ";
				vHtml += "<strong  id=\"goods_"+v.modelno+"_modelnm\">"+v.modelnm+"</strong> ";
				vHtml += "<input type=\"hidden\" id=\"goods_"+v.modelno+"_shopcode\" value=\""+v.shopcode+"\"> ";
				vHtml += "<div class=\"price\"> ";
				vHtml += "	<span class=\"sale\">최저가</span> ";
				vHtml += "	<span class=\"prc\"><b>"+commaNum(v.price)+"</b>원</span> ";
				vHtml += "	<span class=\"e_info\"> ";
				if(v.tag_txt){
					if(v.tag_txt.indexOf("무료배송") > -1){					vHtml += "		<em>무료배송</em> "	; }
					if(v.tag_txt.indexOf("카드할인") > -1){					vHtml += "		<em>카드할인</em> "	; }
					if(v.tag_txt.indexOf("쿠폰") > -1){						vHtml += "		<em>쿠폰</em> "		; }
				}
				vHtml += "	</span> ";
				vHtml += "</div> ";
				vHtml += "</a> ";
				vHtml += "<div class=\"info_btn\"> ";
				if(v.bbs_cnt > 0){
					vHtml += "	<span class=\"comt\" onclick=\"CmdBBS('"+v.modelno+"');CmdGA('gcate<%=strGcate%>_goods_2', '"+v.modelno+"');\">상품평("+commaNum(v.bbs_cnt)+")<span class=\"star_graph ico_m\"><span class=\"ico_m\" style=\"width:"+(v.bbs_staravg*2)+"%>">별점</span></span></span>";
				}else{
					vHtml += "	<span class=\"go_store\" onclick=\"CmdList('C','"+v.category+"');CmdGA('gcate<%=strGcate%>_goods_4', '"+v.categorynm+"');\"><em>"+v.categorynm+"</em></span> ";
				}
				vHtml += "	<span class=\"pr\"  onclick=\"CmdGo('C','"+v.modelno+"','"+v.pl_no+"','"+v.cp_id+"','','','');CmdGA('gcate<%=strGcate%>_goods_3', '"+v.modelno+"');\">가격비교<em>"+commaNum(v.mallcnt)+"</em></span>";

				vHtml += "</div> ";
				vHtml += "</li> ";
            }
			$("#mainlist").append(vHtml);

	    });
	}
});

//더보기
function click_more(){

	var li_cnt = $("#cppcategory li").length;
	var get_id = "";
	var get_id2 = "";
	for(i=0; i<li_cnt; i++){
		get_id2 = $("#cppcategory li:eq("+i+")").attr('id');
		if($("#"+get_id2).hasClass("on")){
 			get_id = $("#cppcategory li:eq("+i+")").attr('id');
		}
	}
	var get_class_on = 1 + get_id.substring(6,8);
	if($("#view_more").hasClass("on")){
		$("#view_more").removeClass("on");
		$("."+get_class_on).hide();
		for(var i=0; i<10; i++){
			$("#"+get_class_on+"_"+i).show();
		}
		$("#view_more").html("더보기");

	}else{
		var evAction = 'gcate<%=strGcate%>_cate';
		var evLabel = $('#gCateNM').text() + '_more';
		CmdGA(evAction, evLabel);



		$("#view_more").addClass("on");
		$("."+get_class_on).show();
		$("#view_more").html("접기");
	}
}
function CmdCate(param){
    if('10400' == param){ //pc 온라인 견적 예외처리 함 20161220 노병원
        window.open("http://m.enuripc.com?freetoken=outlink");
        return false;
    }else{
        location.href = "/mobilefirst/list.jsp?cate="+param;
        return false;
    }
}
function goNews(param){
	CmdGA("gcate<%=strGcate%>_news", param);
	//location.href = "/mobilefirst/news_detail.jsp?kbno="+param+"&verios=";
	window.open("/mobilefirst/news_detail.jsp?kbno="+param+"&verios=");
}
function goShoppingGuide(param){
	CmdGA("gcate<%=strGcate%>_guide", param);
	//location.href = "/mobilefirst/news_detail.jsp?kbno="+param+"&from=guide&verios=";
	window.open("/mobilefirst/news_detail.jsp?kbno="+param+"&from=guide&verios=");
}
function goPlan(param){
	CmdGA("gcate<%=strGcate%>_plan", param);
	location.href = "/mobilefirst/planlist.jsp?t=B_"+param;
}
function goSocial(url, cpid, company){
	CmdGA("gcate<%=strGcate%>_social", url);
 	window.open("/deal/move.html?freetoken=outlink&cpId="+cpid+"&cpUrl="+encodeURIComponent(url)+"&cpCompany="+company);
	//window.open("/deal/mobile/goods.deal?id="+param+"&referrer=core");
}
function goMore(param){
	if(param == "news"){
		location.href = "/mobilefirst/trend_news.jsp";
	}else if(param == "guide"){
		location.href = "/mobilefirst/trend_news.jsp?type=guide";
	}else if(param == "social"){
		CmdGA("gcate<%=strGcate%>_social", "more");
		<%if(strApp.equals("Y")){%>
			//window.open("/deal/mobile/main.deal?freetoken=social");
			window.open("/deal/newdeal/index.deal?freetoken=social");
		<%}else{%>
			//window.open("/deal/mobile/main.deal");
			window.open("/deal/newdeal/index.deal");
		<%}%>
	}
}

function commaNum(num) {
  var len, point, str;

  num = num + "";
  point = num.length % 3
  len = num.length;

  str = num.substring(0, point);
  while (point < len) {
      if (str != "") str += ",";
      str += num.substring(point, point + 3);
      point += 3;
  }
  return str;
}

function CmdGo(part, modelno, pl_no, cp_id, url, shopcode, category){
	if(part == "D"){
		location.href = "/mobiledepart/detail.jsp?modelno="+modelno+"&cate=&group=";
	}else if(part == "S"){
		location.href = "/deal/mobile/goods.deal?id="+cp_id+"&keyword=&referrer=core";
	}else{
		if(url == ""){
			location.href = "/mobilefirst/detail.jsp?modelno="+modelno;
		}else{
			var thisId = pl_no;
			var thisName = $("#goods_"+thisId+"_modelnm").text();

			addResentZzimItem(1, "P", thisId);

			<%if(strApp.equals("Y")){%>
				try{
					if(window.android){		// 안드로이드
			    		window.android.getRecentData(thisName , "P:"+thisId, $("#img_"+modelno).attr("src") , url);
			    	}else{							// 아이폰에서 호출
			    		window.location.href = "enuriappcall://getRecentData?name="+encodeURIComponent(thisName)+"&code=P:"+encodeURIComponent(thisId)+"&imageurl="+encodeURIComponent($("#img_"+modelno).attr("src"))+"&url="+encodeURIComponent(url)+"";
			    	}
				}catch(e){}
			<%}%>

			goShop(url, shopcode, thisId, '', '', category, '', '', '', '0');
			//window.open(url);
		}
	}
}
function CmdBBS(modelno){
	location.href = "/mobilefirst/detail.jsp?modelno="+modelno+"&tab=3";
}
function CmdList(part, cate){
	if(part == "D"){
		location.href = "/mobiledepart/list.jsp?ca_code="+cate;
	}else if(part == "S"){
		location.href = "/deal/mobile/main.deal#/shopping";
	}else{
		location.href = "/mobilefirst/list.jsp?cate="+cate.substring(0,4);
	}
}
function CmdErrImg(param, img){
	$("#img_"+param).error(function(){
		$(this).attr("src","http://img.enuri.info/images/mobilefirst/noimg_plan.png");
	}).attr("src", img);
}
function CmderrLogo(param, name){
	$("#mall_"+param).text(name);
}
function CmdGA(action, label){

	var labelTmp = "";
	var labelApp = "APP";
	var vModelnm = "";

	<%if(!strApp.equals("Y")){%>
		labelApp = "WEB";
	<%}%>

	if(action == "gcate<%=strGcate%>_banner"){
		labelTmp = "banner_"+label+"_"+labelApp;
	}else if(action == "gcate<%=strGcate%>_cate"){
		labelTmp = "cate_"+label;
	}else if(action == "gcate<%=strGcate%>_news"){
		labelTmp = "news_"+label+"_"+labelApp;
	}else if(action == "gcate<%=strGcate%>_plan"){
		labelTmp = "plan_"+label+"_"+labelApp;
	}else if(action == "gcate<%=strGcate%>_guide"){
		labelTmp = "guide_"+label+"_"+labelApp;
	}else if(action == "gcate<%=strGcate%>_social"){
		labelTmp = "social_"+label+"_"+labelApp;
	}else if(action == "gcate<%=strGcate%>_goods_1"){
		vModelnm = $("#goods_"+label+"_shopcode").val();
		action = "gcate<%=strGcate%>_goods";
		labelTmp = label+"_Click_"+vModelnm+"_"+labelApp;
	}else if(action == "gcate<%=strGcate%>_goods_2"){
		vModelnm = $("#goods_"+label+"_modelnm").text();
		action = "gcate<%=strGcate%>_goods";
		labelTmp = label+"_bbs_"+labelApp;
	}else if(action == "gcate<%=strGcate%>_goods_3"){
		vModelnm = $("#goods_"+label+"_modelnm").text();
		action = "gcate<%=strGcate%>_goods";
		labelTmp = label+"_VIP_"+labelApp;
	}else if(action == "gcate<%=strGcate%>_goods_4"){
		vModelnm = $("#goods_"+label+"_modelnm").text();
		action = "gcate<%=strGcate%>_goods";
		labelTmp = "LP_"+label+"_"+labelApp;
	}

	ga('send', 'event', 'mf_cpp', action, labelTmp);
}
function CmdCppCate(get_id){
	var get_class_on = 1 + get_id.substring(6,8);
	var get_class_on_id =$("."+get_class_on).length;
	if(get_class_on_id < 10){
		$('#more').hide();
	}else{
		$('#more').show();
	}
}
function goHome(){ga_log_gnb(2);window.location.replace("/mobilefirst/index.jsp");}
function ga_log_gnb(param){
	var vGa_label = "";

	if(param == 1){
		vGa_label = "GNB_카테고리 메뉴";
	}else if(param == 2){
		vGa_label = "GNB_home";
	}else if(param == 3){
		vGa_label = "GNB_검색";
	}else if(param == 4){
		vGa_label = "GNB_마이에누리";
	}
	ga("send", "event", "mf_cpp", "cpp_GNB", vGa_label);
}
function ga_log_cate_top(label){
	ga("send", "event", "mf_cpp", "gcate<%=strGcate%>_cate_top", "top_"+label);
}

</script>
<!--기획전 템플릿-->
<script id="Plan" type="x-tmpl-mustache">
{{#planList}}
	<li onclick="goPlan('{{{TODAY_ID}}}')"">
		<img src="http://img.enuri.info/images/mobilefirst/planlist/B_{{{TODAY_ID}}}/B_{{{TODAY_ID}}}_main.png" alt="" />
	</li>
{{/planList}}
</script>
<!--쇼핑가이드 템플릿-->
<script id="shoppingGuide" type="x-tmpl-mustache">
{{#ShoppingGuideList}}
	<li><a href="javascript:goShoppingGuide('{{{kb_no}}}')">
	<img src="{{{mo_img2}}}" alt="" class="thumb" />
	<span class="tit">{{{kb_title}}}</span>
	</a></li>
{{/ShoppingGuideList}}
</script>
<!--소셜 템플릿-->
<script id="social" type="x-tmpl-mustache">
{{#goods}}
	<li>
		<a href="javascript:goSocial('{{{url2}}}', '{{{cp_id}}}', '{{{company}}}')">
			<img src="{{{img2}}}" class="thum" />
			<span class="mall"><img src="http://img.enuri.info/images/view/ls_logo/2013/Ap_logo_{{{company}}}.png"
			onerror="if (this.src != 'http://img.enuri.info/images/board/big/logo_{{{company}}}b.gif') this.src = 'http://img.enuri.info/images/board/big/logo_{{{company}}}b.gif';"
			</span>
			<strong>{{{name}}}</strong>
			<div class="price"><span class="per">{{#rate_text}}{{{rate_text}}}{{/rate_text}}{{#rate}}{{{rate}}}<em>%</em>{{/rate}}</span>{{{price}}}<b>원</b></div>
		</a>
	</li>
{{/goods}}
</script>
<%@include file="/mobilefirst/include/common_logger.html"%>