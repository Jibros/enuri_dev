<%@ page contentType="text/html;charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%
	
	String chkId   = ChkNull.chkStr(request.getParameter("chk_id"),"");
	String cUserId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
	String cUserNick = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK"),"");
	String strEventId = ChkNull.chkStr(request.getParameter("event_id"),"");
	String eventName = "";
	
	if(strEventId.equals("")){
		response.sendRedirect("/mobilefirst/index.jsp");
		return;
	}
	
	if( ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > -1
	        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1
	        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > -1
	        || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > -1 ){
	}else{
		//response.sendRedirect("/evt/trendExhibition.jsp?event_id="+strEventId);
		//return ;
	}
	
	JSONParser parser = new JSONParser();
	JSONObject jsonObj = new JSONObject();
	try {
		
	  	Object obj2 = parser.parse( new InputStreamReader(new FileInputStream("/was/lena/1.3/depot/lena-application/ROOT/jca/trendEx/json/trend_ex_"+strEventId+".json"),"UTF8"));
		jsonObj = (JSONObject)obj2;
		eventName = (String)jsonObj.get("exh_nm");
	}
	catch (FileNotFoundException e) { System.out.println("FileNotFoundException : " +e.getMessage()); } 
	catch (IOException e) { System.out.println("IOException  : " + e.getMessage()); }
	catch (ParseException  e) { System.out.println("ParseException   : " ); } 
	
	Members_Proc members_proc = new Members_Proc();
	String cUsername = members_proc.getUserName(cUserId);
	String userArea = cUsername;
	
	if(!cUserId.equals("")){
		cUsername = members_proc.getUserName(cUserId);
		userArea=cUsername;
		
		if(cUsername.equals("")) userArea = cUserNick;
		if(userArea.equals("")) userArea = cUserId;
	}
	//config ????????? ??????
	String shareImg = ConfigManager.ConstStorage+"trendExhibition/share/share_face_"+strEventId+".png";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
<meta property="og:title" content="[????????? ????????????]"/>
<meta property="og:description" content="<%=eventName%>"/>
<meta property="og:image" content="<%=shareImg%>" />
<meta property="og:type" content="article" />      
<meta property="og:url" content="http://m.enuri.com/mobilefirst/evt/trendExhibition.jsp?event_id=<%=strEventId %>" />
<meta name="format-detection" content="telephone=no" />
<link rel="stylesheet" type="text/css" href="/css/event/y2018/trend_m.css" />
<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css" />
<script type="text/javascript" src="/common/js/lib/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
<script type="text/javascript" src="/common/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="/common/js/function.js"></script>
<script type="text/javascript" src="/mobilefirst/js/lib/kakao.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/ga.js"></script>

</head>

<body>
<!-- ??????????????? -->
	<div class="myarea">
		<%if(cUserId.equals("")){%>	
		<p class="name">?????? e????????? ?????????????<button type="button" class="btn_login">?????????</button></p>	
		<%}else{%>
		<p class="name"><%=userArea%> ???<span id="my_emoney"></span></p>
		<%}%>
		<a href="javascript:;" class="win_close">?????????</a>
	</div>
<!-- //??????????????? -->
<div class="wrap">
	<!-- visual -->
	<div class="visual">
		<div class="sns">
			<span class="sns_share evt_ico" onclick="onoff('snslayer')">sns ????????????</span>
			<ul id="snslayer" style="display:none;">
				<li id="face">????????????</li>
				<li id="kakao">????????????</li>
			</ul>
		 </div>
		<h1 id="topimg" class="imgbox"></h1>
		<div class="floattab">
		<!-- floattab__list -->
			<div id="floatTabSlick" class="floattab__list">
			</div>
		<!-- //floattab__list -->
		</div>
		<!-- //floattab__list -->
	</div>
      <!-- //visual -->
<%-- 20191209 ???????????? ?????? --%>
	<div id="cpnarea" class="coupon_area" style="display:none;"></div>
	<div id="trendCouponNoti" class="layer_back" style="display:none">
		<!-- popup_box -->
		<div class="lay_coupon">
			<h4>????????????</h4>
			<a href="javascript:void(0);" class="close" onclick="$('#trendCouponNoti').hide();">?????????</a>
			<div class="inner">
				<ul></ul>				   
			</div>
		
		</div>
		<!-- //popup_box -->
	</div>
    <!-- ?????? ????????? -->
    <div class="common contentwrap">
            <div class="imgbox"></div>
    </div>
    <!-- //?????? ????????? -->

	<div class="bannerwrap" style = "display:none;" >
		<div class="contents">
			<!-- ?????? ???????????? -->
			<div class="slide--banner">
				<!-- ???????????? ?????? -->
				<div id="bannerSlide" class="banner__list">
				</div>	
				<!-- //???????????? ?????? -->
			</div>
			<!-- //?????? ???????????? -->
		</div>
	</div>
</div>
<span class="go_top"><a href="javascript:void(0);" onclick="window.scrollTo(0,0);return false;">TOP</a></span>
<!-- ???????????????-->
<div class="layer_back" id="app_only" style="display:none;">
        <div class="appLayer">
                <h4>????????? ??? ?????? ?????????</h4>
                <a href="javascript:///" class="close" onclick="$('#app_only').hide();">?????????</a>
                <p class="txt">
                        <strong>???????????? ??????!</strong>
                        <em>?????? ?????? ??????</em>??? ????????????
                        <br />??????????????? ???????????????.</p>
                <p class="btn_close">
                        <button type="button" onclick="install_btt();">????????????</button>
                </p>
        </div>
</div>

<!-- //???????????????-->
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>

<script type="text/javascript">
<%-- var json = "<%=jsonObj%>"; --%>
var username = "<%=userArea%>"; //??????????????? ??????
var vChkId = "<%=chkId%>";
var event_id = "<%=strEventId%>";
var app = getCookie("appYN");
var shareImg = "<%=shareImg%>";
var vTabBscBkg = "";
var vTabBscFnt = "";
var vTabSctBkg = "";
var vTabSctFnt = ""; 
Kakao.init('5cad223fb57213402d8f90de1aa27301');
var $navtop = 0;
var pageUrl = "/mobilefirst/evt/trendExhibition.jsp?event_id="+event_id;
var vodIndex = 0;
var isClick = true;


function onoff(id){
        var mid = $("#"+id);
        if(mid.css("display") !== "none"){
                mid.css("display","none");
        }else{
                mid.css("display","");
        }
}
// VOD ?????? ?????? ??????
function vodAreaSet(){
	$.each($(".imgHeight"), function(i,v){
		var imgHgt = $(this).height();
	     $("#vodBox"+i).height(imgHgt);		 
	})
};
$(function(){
		getList();
		$(".btn_login").click(function() {
			goLogin();
		});
	    $(".win_close").click(function() {
			if(app=='Y'){
				window.location.href = "close://";
			}else{
				window.location.replace("/mobilefirst/index.jsp");
			}
		});
		if(islogin()){
			getPoint();
		}
        // ????????? ????????? ??????
        $(".lazyimg").lazyload({
                effect: 'fadeIn',
                effectTime: 2000
        });
});

function setCoupon(){
	if(!islogin()){
		alert("????????? ??? ????????? ??? ????????????.");
		if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
			location.href = "/mobilefirst/login/login.jsp";
		}else if(navigator.userAgent.indexOf("Android") > -1){
			location.href = "/mobilefirst/login/login.jsp?backUrl=/mobilefirst/evt/firstbuy100_event.jsp?freetoken=event&chk_id="+vChkId;
		}
		return false;
	}
	
	if(!isClick){
		return false;
	}
	isClick = false;

	$.ajax({
		type: "POST",
		url: "/mobilefirst/evt/ajax/trendExhibition_setlist.jsp",
		async: false,
		dataType:"JSON",
		success: function(json){
			var result = json.result;
			if(result == -99){
				alert("App?????? ?????? ???????????????.");
			}else if(result == -5){
				alert("???????????? ??? ?????? ???????????????.");
				location.href = "https://dev.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
			} else if ( result == -1 ) {
				alert("?????? ??? ?????? ???????????????!");
			} else if (result == 2601) {
				alert("?????? ????????????????????????! ??? ?????? ???????????? ????????? ???????????? ?????? ?????? ???????????? ???????????????.");
			} else if(result == 1){
				alert("?????? ??????! ????????? ???????????? ??????????????????!");
			}
			
		}, complete : function() {	isClick=true;	}
	});
}
function getList(){

	$.ajax({
		type: "GET",
		url:"/jca/trendEx/json/trend_ex_"+event_id+".json",
		cache : false,
		global: false,
		dataType : "JSON",
		success : function(json){
			
			 vExhNm = json["exh_nm"];
			var vTabView = json["tab_view_yn"];
			var vTopMImg = json["top_m_img"];
			var pubListArray = json["mainContent"]["con_list"];
			var banListArray = json["mainContent"]["ban_list"];
			var tabListArray = json["mainContent"]["tab_list"];
			var cpnListArray = json["mainContent"]["cpn_list"];
			var tabContentArray = json["tabContent"];
			 vTabBscBkg = json["tab_bsc_bkg_colr"];
			 vTabBscFnt = json["tab_bsc_fnt_colr"];
			 vTabSctBkg = json["tab_sct_bkg_colr"];
			 vTabSctFnt = json["tab_sct_fnt_colr"];
			$("#topimg").html("<img class=\"lazyimg\" data-original=\""+vTopMImg+"\" src=\""+vTopMImg+"\" alt=\"????????? ????????? ??????\" />");
			if(vTabView=="Y"){
				makeTabList(tabListArray);	
			}else{
				$(".floattab").hide();
			}
			
			makePubContents(pubListArray);
			makeCpnContents(cpnListArray);
			makeTabContents(tabContentArray);
			makeBanContents(banListArray);
			
			$("#snslayer li").click(function(){
	        	var vThisId = $(this).attr("id");
	        	event_share(vThisId,vExhNm);
		    });
			
			$("#bannerSlide").slick({lazyLoad: "ondemand", lazyLoadBuffer: 0, infinite: true, speed: 150, variableWidth: true, autoplay: true, autoplaySpeed: 2000});
			// ?????????, VOD ?????? ?????? ??????vodAreaSet();
			// ???????????? SLICK ?????? ?????? 
			$(".onexone__list").slick({lazyLoad: "ondemand", lazyLoadBuffer: 0, infinite: true, speed: 150, variableWidth: true});

			// ???????????? SLICK ?????? ??????  
			$(".twoxtwo__list").slick({lazyLoad: "ondemand", lazyLoadBuffer: 0, speed: 150, variableWidth: true, arrows: false, dots: true, rows: 2, slidesToScroll: 2, slidesToShow: 2, infinite: true});
			ga('send', 'pageview', {'page': pageUrl,'title': vExhNm +" > ???????????? "});
	        
			$(".onexone__list").on("click",function(){
	        	var tabno= $(this).attr("tabno");
	        	ga('send', 'event', 'mf_event', vExhNm , vExhNm + " > ???"+tabno+"_????????????");
	        });
	        $(".twoxtwo__list").on("click",function(){
	        	var tabno= $(this).attr("tabno");
	        	ga('send', 'event', 'mf_event', vExhNm , vExhNm + " > ???"+tabno+"_????????????");
	        });
	      	$(".contentWrap .imgbox a").on("click",function(){
	      		var tabno= $(this).attr("tabno");
	      		var conno= $(this).attr("conno");
	        	ga('send', 'event', 'mf_event', vExhNm , vExhNm + " > ???"+tabno+"_?????????"+conno);
	      	});
	      	$(".banner__item").on("click",function(){
	        	ga('send', 'event', 'mf_event', vExhNm , vExhNm + " > ????????????");
	      	});
	    //	console.log("succuss");
		},
		complete : function(e,request){
		//	console.log("complete");
			if(request == "success" && e.status == "200"){
				setTimeout(function(){ //?
					$navtop = $("#topimg").height() + $(".myarea").height();
		        	vodAreaSet();
		    	    // ????????? landscape ???, VOD ?????? ?????? ?????????
		    	    $(window).resize(function(){
		    	            var winWid = $(window).width(),
		    	           	winHgt = $(window).height();
		    	            if(winWid < winHgt)     vodAreaSet(); // ??????
		    	            else if(winWid > winHgt) vodAreaSet(); //??????
		    	    });	
				},1000);
				var floatTabSlick = $("#floatTabSlick"),	// ??? SLICK
				tabNum = $(".floattab__item").length,	// ??? ??????	
				slickOpt;								// ??? ????????? ?????? ????????? SLICK ?????? ?????????
		 	
				if(tabNum <= 4){ // ??? ?????? 4??? ????????? ???, SLICK ?????? ??????
					slickOpt = {arrows: false, dots: false, infinite: false, slidesToShow: tabNum, speed:150};
				}else{ // ??? ?????? 4??? ????????? ???, SLICK ?????? ??????
					slickOpt = {arrows: false, dots: false, swipeToSlide: true, infinite: false, slidesToShow: 4, slidesToScroll: 1, focusOnSelect: true, asNavFor: "#floatTabSlick", speed:150};
				}
				floatTabSlick.slick(slickOpt); // SLICK ??????	
			
				// ?????? ??????
				var $nav = $('.floattab'), 					// ?????? ??????
					$menu = $('.floattab .floattab__item'),	// ??? ??????
					$contents = $('.scroll'),				// ????????? ??? ??????
					$navheight = $nav.outerHeight() - 1; 		// ?????? ?????? ??????
				// ?????? ???????????? ????????? ?????? 
				$menu.on('click', 'a', function (e) {
					var currtab = $(this).attr("data-idx");
					var curentCursor = Math.ceil($(window).scrollTop());
					var	offsetTop = Math.ceil($contents.eq(currtab).offset().top);	// ?????? ?????? ????????? ???????????? ?????? ??????
					var targetTop = Math.ceil($contents.eq(currtab).offset().top-$navheight);
					var prt = 0; // ?????????
				 	if($navtop > curentCursor){
						targetTop = Math.ceil(targetTop - $navheight-1);
					}
					$('html, body').stop(true).animate({ scrollTop: targetTop }, 500); // ???????????? ????????? ??????
					
					return false;
				});
				
				// ????????? ????????? ???, ??? ????????? ?????? ?????? ?????? ??? ??? ?????????
				$(window).scroll(function () {
					var $scltop = Math.ceil($(window).scrollTop()); // ?????? scroll			
					if ($scltop > $navtop) {
						if(!$nav.hasClass("is-fixed")){
							$nav.addClass("is-fixed");
							$("#floatTopMargin").css("margin-top", $navheight + 1);	
						}
					} else {
						if($nav.hasClass("is-fixed")){
							$nav.removeClass("is-fixed");
							$menu.children("a").removeClass('is-on');
							$("#floatTopMargin").css("margin-top", 0);	
						}
					}
					
					$.each($contents, function (idx, item) {
						var $target = $contents.eq(idx),								// ????????? ??????
							i = $target.index();										// ????????? INDEX
						var	targetTop = Math.ceil($target.offset().top - $navheight);	// ??????????????? ??????????????? ????????? ?????? ??????
	
						// ???????????? ?????? ?????? ?????????
						if (targetTop <= $scltop) {
							$menu.children("a").removeClass('is-on');
							$menu.eq(idx).children("a").addClass('is-on');
							//$(".floattab__item .floattab__a").css({"background-color" : vTabBscBkg,"color" : vTabBscFnt});
							$(".floattab__item .floattab__a").css({"background-color" : vTabBscBkg,"color" : vTabBscFnt});
							$(".floattab__item .floattab__a.is-on").css({"background-color" : vTabSctBkg,"color" : vTabSctFnt});
						}
						
						if (!($navheight <= $scltop)) {
							$menu.children("a").removeClass('is-on');
							$(".floattab__item .floattab__a").css({"background-color" : vTabBscBkg,"color" : vTabBscFnt});
						}
					});
					// ?????? ??? ???????????? ?????? ???, ?????? ??????
					var lastTab = tabNum - 2,
						currtab = $menu.children("a.is-on").attr("data-idx");	// ?????? ????????? ??? INDEX
					if(currtab < tabNum){
						if(currtab <= lastTab){
							floatTabSlick.slick('slickGoTo', currtab - 1);
						}else if(currtab > lastTab){
							floatTabSlick.slick('slickGoTo', currtab - 1);
						}
					}
					
					
				});
				$(".floattab").css("background-color",vTabBscBkg);
				
				var url = location.href;
				var anchorId = "";
				if(url.indexOf("#") > -1 ){
					anchorId = url.substring(url.indexOf("#")+1,url.length)
					location.href = "#"+anchorId;
	
				}
			}
			
		},
		error : function(){
			window.location.replace("/mobilefirst/Index.jsp");
		}
	});
}
function makeCpnContents(cpn_list){
	var cpnJSON = cpn_list;
	var cpnhtml = "";
	var cpnnotihtml = "";
	if(typeof(cpnJSON) != "undefined" && cpnJSON != null ){
		var cpn_bkg_colr = cpnJSON["cpn_bkg_colr"];
		var cpn_btn_img_url = cpnJSON["cpn_btn_img_url"];
		var cpn_img_url = cpnJSON["cpn_img_url"];
		var cpn_note = cpnJSON["cpn_note"];
		var cpn_view_yn = cpnJSON["cpn_view_yn"];
		
		if(cpn_view_yn=="Y"){
			cpnhtml +="<div class=\"coupon_img\"><img src=\""+cpn_img_url+"\"></div>";
			if(app=="Y"){
				cpnhtml +="<div class=\"coupon_btn\"><a href=\"javascript:void(0);\" onclick=\"setCoupon();return false;\" ><img src=\""+cpn_btn_img_url+"\"></a></div>";	
			}else{
				cpnhtml +="<div class=\"coupon_btn\"><a href=\"javascript:void(0);\" onclick=\"onoff('app_only');return false;\" ><img src=\""+cpn_btn_img_url+"\"></a></div>";
			}
			cpnhtml +="<div class=\"coupon_noti\"><a href=\"javascript:void(0);\" class=\"btn_coupon_noti\" onclick=\"onoff('trendCouponNoti');return false;\" >??????????????? ???! ???????????????</a></div>";
			if(cpn_note !="" ){
				var cpn_note_ary = new Array();
				var tmp_note = "";
				
				cpn_note_ary = cpn_note.split("\n");
				$.each(cpn_note_ary,function(index,notiData){
					tmp_note = notiData ; 
					if(notiData !=""){
						tmp_note = tmp_note.replace(/(<\.>)(.+?)(<n>)/gi,"<li class=\"tx_dot\">$2</li>");
						tmp_note = tmp_note.replace(/(<\->)(.+?)(<n>)/gi,"<li class=\"tx_bar\">$2</li>");
						tmp_note = tmp_note.replace(/(<b>)(.+?)(<n>)/gi,"<li class=\"tx_tit\">$2</li>");
						tmp_note = tmp_note.replace(/(<r>)(.+?)(<\/r>)/gi,"<em>$2</em>");
						tmp_note = tmp_note.replace(/<n>/gi,"<br>");
						cpnnotihtml += tmp_note;
					}
				});
				$("#trendCouponNoti").find("ul").html(cpnnotihtml);
			}
			$("#cpnarea").html(cpnhtml);
			$("#cpnarea").css("background-color",cpn_bkg_colr);
			$("#cpnarea").show();
		}else{
			$("#trendCouponNoti").hide();
		}
	}	
}
function makeTabList(tablist){
	var html ="";
	var vTabNm = "";
	var vTabNo = "";
	var vTabSort = "";
	$.each(tablist,function(index,tabData){
		vTabNm = tabData["tab_nm"];
		vTabNo = tabData["tab_no"];
		html +="<div class=\"floattab__item\"><a href=\"#evt"+(index)+"\" class=\"floattab__a\" data-idx=\""+(index)+"\">"+vTabNm+"</a></div>";
	});
	$("#floatTabSlick").html(html);
}
function makePubContents(contents){
	//console.log("makePubContents");
	var vMimgUrl = "";
	var vMlanUrl = "";
	var html = "";
	$.each(contents,function(index,contData){
		vMimgUrl = contData["m_img_url"];
		vMlanUrl = contData["m_lan_url"];
		html+="<div class=\"imgbox\">";
		if(vMlanUrl !=""){
			html+="		<a href=\""+vMlanUrl+"\" target=\"_blank\"><img class=\"lazyimg\" data-original=\""+vMimgUrl+"\" src=\""+vMimgUrl+"\" alt=\"???????????????\" /></a>";
		}else{
			html+="		<img class=\"lazyimg\" data-original=\""+vMimgUrl+"\" src=\""+vMimgUrl+"\" alt=\"???????????????\" />";
		}
		html+="</div>";
	});

	$(".common.contentwrap").html(html);
}
function makeTabContents(contentsObj){
	//console.log("makeTabContents");
	var html = "";
	var vTabNo = 0;
 	var vContObj = new Object();
	var vGoodsObj = new Object();
	var vMainGoodsArray = new Array();
	var vRelGoodsObjArray = new Array();
	var vMainTopTitle = "";
	var vMainBtmTitle = "";
	var vRelTopTitle = "";
	var vRelBtmTitle = "";
	var vMimgUrl = "";
	var vMlanUrl = "";
	var vMtvBckUrl = "";
	var vConSort = 0;
	var vMainGoodsFlag = false;
	//???????????? 2019-01-22
	var vTop_model_bkg_colr = "";
	var vTop_model_fnt_colr = "";
	var vBtm_model_bkg_colr = "";
	var vBtm_model_fnt_colr = "";
	$.each(contentsObj,function(index,tabData){
		vMainTopTitle = tabData["main_top_title"];
 		vMainBtmTitle = tabData["main_btm_title"];
		vRelTopTitle = tabData["rel_top_title"];
		vRelBtmTitle = tabData["rel_btm_title"];

		vTop_model_bkg_colr  = tabData["top_model_bkg_colr"];
		vTop_model_fnt_colr  = tabData["top_model_fnt_colr"];
		vBtm_model_bkg_colr  = tabData["btm_model_bkg_colr"];
		vBtm_model_fnt_colr  = tabData["btm_model_fnt_colr"];
	
		vTabNo = tabData["tab_no"];
		//alert(vTop_model_bkg_colr);
		//alert(vTop_model_fnt_colr);
		//alert(vBtm_model_bkg_colr);
		//alert(vBtm_model_fnt_colr);
		vMainGoodsArray = [];
		vRelGoodsObjArray = [];
		vContObj = tabData["con_list"];
		vGoodsObj = tabData["goods_list"];
		vMainGoodsFlag = false;
		for(var i=0;i<vGoodsObj.length;i++){
			if(vGoodsObj[i]["type"] == "M"){
				vMainGoodsArray.push(vGoodsObj[i]);
			}else{
				vRelGoodsObjArray.push(vGoodsObj[i]);
			}
		}
		
		
		html+="	<div id=\"evt"+vTabNo+"\"  class=\"contentWrap scroll\">";
		for(var i=0;i<vContObj.length;i++){
			vConSort = vContObj[i]["sort"];
			vMimgUrl = vContObj[i]["m_img_url"];
			vMlanUrl = vContObj[i]["m_lan_url"];
			vMtvBckUrl = vContObj[i]["cts_bkg_img_url"];
			if(vConSort==1){
				html += makeImgBox(vMimgUrl,vMlanUrl,vMtvBckUrl,vConSort,index);
			}else if(vConSort==2 || vMainGoodsFlag==false ){
				html += makeProduct(vMainTopTitle,vMainBtmTitle,"M",vMainGoodsArray,index,vTop_model_bkg_colr,vTop_model_fnt_colr);
				vMainGoodsFlag = true;
			}
			if(vConSort > 1){
				if(!(vMimgUrl.indexOf("7_4_scm_20190510111956.gif") > 0  || vMimgUrl.indexOf("7_5_scm_20190510112019.gif") > 0 )){
					html += makeImgBox(vMimgUrl,vMlanUrl,vMtvBckUrl,vConSort,index);	
				}
			}
		}
		html += makeProduct(vRelTopTitle,vRelBtmTitle,"R",vRelGoodsObjArray,index,vBtm_model_bkg_colr,vBtm_model_fnt_colr);
		html +="	</div>";
	});
	$(".common.contentwrap").after(html);	
}
function makeBanContents(contents){
	//console.log("makeBanContents");
	var html = "";
	var vMbanImg = "";
	var vMbanUrl = "";
	
	$.each(contents,function(index,banData){
		vMbanImg = banData["m_ban_img"];
		vMbanUrl = banData["m_ban_url"];
		html+="<div class=\"banner__item\">";
		html+="		<a href=\""+vMbanUrl+"\" target=\"_blank\">";
		html+="			<img data-lazy=\""+vMbanImg+"\" src=\""+vMbanImg+"\" alt=\"?????? ?????????\" class=\"thumb\" />";
		html+="		</a>";
		html+="</div>";
	});
	
	$("#bannerSlide").html(html);
	if(contents.length>0){
		$(".bannerwrap").show();
	}
}
function makeImgBox(imgurl,lanurl,tvbckurl,conno,tabno){
	//console.log("makeImgBox");
	var html = "";
	var videoFlag = false;
	var vLanUrl = lanurl;
	var vImgUrl = imgurl;
	var vTokenUrl = "";
	var vTvBckUrl = tvbckurl;
	var vVideoUrl = "";
	if(vLanUrl.indexOf("freetoken=news")>-1 || vLanUrl.indexOf("freetoken=shoppingknow") >-1){
		vTokenUrl= vLanUrl.replace("freetoken=shoppingknow","freetoken=news");
	}else{
		vTokenUrl = vLanUrl + "&freetoken=news";
	}
	if(vLanUrl.indexOf("youtube") > -1 || vLanUrl.indexOf("naver") > -1 || vLanUrl.indexOf("kakao") > -1){
		videoFlag = true;
	}
	
	if(videoFlag){
		if(vLanUrl.indexOf("?") > -1){
			vVideoUrl = vLanUrl + "&playsinline=1";
		}else{
			vVideoUrl = vLanUrl + "?playsinline=1";
		}
	
		html+="	<div id=\"vodBox"+vodIndex+"\" class=\"vodbox\" style=\"background : url("+vTvBckUrl+"); \" >";
		html+="    <div class=\"contents\">";
		html+="        <div class=\"imgbox backimg\"><img class=\"imgHeight\" src=\""+vImgUrl+"\" alt=\"????????? ????????? ????????? ??????\" /></div>";
		html+="            <div class=\"vodframe\">";
		html+="        		<!-- 640 ?????? ???????????? ?????? -->";
		html+="             <iframe width=\"600\" height=\"338\" class=\"show-max\" src=\""+vVideoUrl+"\" frameborder=\"0\" allowfullscreen=\"\"></iframe>";
		html+="           	<!-- 640 ?????? ???????????? ?????? -->";
		html+="           	<iframe width=\"300\" height=\"169\" class=\"show-min\" src=\""+vVideoUrl+"\" frameborder=\"0\" allowfullscreen=\"\"></iframe>";
		html+="            </div>";
		html+="		</div>";
		html+="</div>";
		
		vodIndex++;
	}else{
		html+="		<div class=\"imgbox\">";
		if(vLanUrl !=""){
			html+="		<a href=\""+vTokenUrl+"\" target=\"_blank\" conno=\""+conno+"\" tabno=\""+(tabno+1)+"\" ><img class=\"lazyimg\" data-original=\""+vImgUrl+"\" src=\""+vImgUrl+"\" alt=\"???????????????\" /></a>";
		}else{
			html+="		<img class=\"lazyimg\" data-original=\""+vImgUrl+"\" src=\""+vImgUrl+"\" alt=\"???????????????\" />";
		}
		html+="		</div>";	
	}
	
	return html;
}
function makeProduct(toptitle,btmtitle,type,modellist,index,model_bkg, model_fnt){
	//console.log("makeImgBox");
	var html = "";
	var vModelArray = modellist;
	html+="<div class=\"products\" style=\"background:"+ model_bkg +"\" >";
	html+="		<div class=\"contents\" >";
	if(btmtitle !=""){
		html+="		<h2 class=\"products__tit\" style=\"color:"+ model_fnt +"\">"+toptitle+"<br />"+btmtitle+"</h2>";	
	}else{
		html+="		<h2 class=\"products__tit\" style=\"color:"+ model_fnt +"\">"+toptitle+"</h2>";
	}
	if(type == "M"){
		html+="		<div class=\"slide--onexone\">";
		html+="			<div class=\"onexone__list\" tabno=\""+(index+1)+"\">";
	}else if(type=="R"){
		html+="		<div class=\"slide--twoxtwo\">";
		html+="			<div class=\"twoxtwo__list\" tabno=\""+(index+1)+"\">";
	}
	$.each(vModelArray,function(index,modelData){
		var vModeldftImg = modelData["gd_dft_img_url"];
		var vModelImg = modelData["gd_img_url"];
		var vModelTopNm = modelData["gd_top_nm"];
		var vModelBtmNm = modelData["gd_btm_nm"];
		var vMinPrice = modelData["minprice"];
		var vModelno = modelData["gd_cd"];
		var vSoldout = modelData["soldout"];
		var vViewyn = modelData["view_yn"];
		var vModelNm = vModelTopNm+vModelBtmNm;
		if(vViewyn == "Y"){
			if(type=="M"){
				html+="				<div class=\"onexone__item\">";	
			}else if(type=="R"){
				html+="				<div class=\"twoxtwo__item\">";
			}
			
	        html+="					<a href=\"/mobilefirst/detail.jsp?modelno="+vModelno+"\" target=\"_blank\">";
			if(vModelImg !=""){
				html+="        				<img class=\"thumb\" data-lazy=\""+vModelImg+"\" src="+vModelImg+" alt=\"?????? ?????????\" />";	
			}else{
				html+="        				<img class=\"thumb\" data-lazy=\""+vModeldftImg+"\" src="+vModeldftImg+" alt=\"?????? ?????????\" />";
			}
	        
	        html+="        				<span class=\"pname\"  style=\"color:"+ model_fnt +"\">"+vModelTopNm+"<br />"+vModelBtmNm+"</span>";
	        html+="        				<span class=\"minprice\"  style=\"color:"+ model_fnt +"\">????????? <b>"+vMinPrice.NumberFormat()+"</b>???</span>";
	        if(vSoldout==1){
	        	html+="        				<span class=\"soldout\">SOLDOUT</span>";	
	        }
	        html+="					</a>";
	    	html+="				</div>";
		}
	});
	html+="				</div>";
    html+="			</div>";
	html+="		</div>";
	html+="</div>";
	return html;
}
function goLogin(){
	var backUrl = location.href;
	
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
        if(app =='Y'){
        	location.href = "/mobilefirst/login/login.jsp";          	
       }
        else{
        	location.href = "/mobilefirst/login/login.jsp?backUrl="+ backUrl;          	
        }
    }else if(navigator.userAgent.indexOf("Android") > -1){
        location.href = "/mobilefirst/login/login.jsp?backUrl="+backUrl+"?freetoken=event&chk_id="+vChkId;
    }       
}
function getPoint(){
	$.ajax({
		type: "GET",
		url: "/mobilefirst/emoney/emoney_get_point.jsp",
		async: false,
		dataType:"JSON",
		success: function(json){
			$("#my_emoney").html(json.POINT_REMAIN.NumberFormat()+"???");
			$("#my_emoney").on("click",function(){
				if(getCookie("appYN") == 'Y'){
						location.href = "/mobilefirst/emoney/emoney.jsp?freetoken=emoney";
				}else{
						onoff('app_only');
				}
			});		
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
function event_share(part,title){
	
	var share_title = "[????????? ????????????]\n"+title;
	var share_eventid = "<%=strEventId%>";
	var share_url ="http://m.enuri.com/mobilefirst/evt/trendExhibition.jsp?event_id="+share_eventid;
	ga('send', 'event', 'mf_event', title , title + " > SNS ??????");
	if(part == "kakao"){
	 	try{
			Kakao.Link.sendDefault({
				//container: '#kakao',
				objectType: 'feed',
				content: {
			        title: share_title,
			        imageUrl: "http://storage.enuri.gscdn.com/pic_upload/trendExhibition/share/share_kakao_"+share_eventid+".png",
			        imageWidth : 800,
			        imageHeight : 400,
			        link: {
			          webUrl: share_url,
			          mobileWebUrl: share_url
			        }
				},
				buttons: [
							{
								title: '????????? ???????????? ??????',
								link: {
										mobileWebUrl: share_url,
								}
			        		}
				],
				fail : function() {
						alert("??????????????? ?????? ?????? ???????????????.");
				}
			});
		}catch(e){
			alert("??????????????? ?????? ?????? ???????????????.");
			alert(e.message);
		}  
	}else if(part == "face"){
		try{   
			window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
		}catch(e){
			window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
		} 	
	}
}
//???????????????
function install_btt(){
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
        window.location.href = 'https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8';
    }else if(navigator.userAgent.indexOf("Android") > -1){
    	window.location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3DTop_banner%26utm_campaign%3Ddowloadbanner_201504";
    }
}

</script>
</body>
