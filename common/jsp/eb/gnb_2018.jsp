<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<link rel="stylesheet" type="text/css" href="/css/gnb.css?v=20200107" >
<link rel="stylesheet" type="text/css" href="/css/gnb_navigation.css?v=20201022" />
<script type="text/javascript" src="/common/js/eb/gnb_2018.js?v=25"></script>
<script>
// 전체보기 toggle
jQuery("#menu-trigger").click(function(){
	jQuery(this).toggleClass("is-on");
	if(jQuery(this).hasClass("is-on"))  jQuery(".submenu-all").addClass("is-shown").removeClass("is-hidden");
	else    							jQuery(".submenu-all").addClass("is-hidden").removeClass("is-shown");
});
</script>
<%
String gnbFooterLink = "";
gnbFooterLink += "<div class='service__inner'>";
	gnbFooterLink += "<ul class='service__list'>";
	gnbFooterLink += "<li><a href='javascript:///' onclick='goGnbFooterLink(1);'><span class='icon icon-1'>아이콘</span> 컴퓨터/노트북</a></li>";
	gnbFooterLink += "<li><a href='javascript:///' onclick='goGnbFooterLink(2);'><span class='icon icon-2'>아이콘</span> 쇼핑지식<span class=\"icon new\">NEW</span></a></li>";
	gnbFooterLink += "<li><a href='javascript:///' onclick='goGnbFooterLink(3);'><span class='icon icon-3'>아이콘</span> 소셜가격비교</a></li>";
	gnbFooterLink += "<li><a href='javascript:///' onclick='goGnbFooterLink(4);'><span class='icon icon-4'>아이콘</span> 여행</a></li>";
	gnbFooterLink += "<li><a href='javascript:///' onclick='goGnbFooterLink(5);'><span class='icon icon-5'>아이콘</span> 꽃배달</a></li>";
	gnbFooterLink += "<li><a href='javascript:///' onclick='goGnbFooterLink(6);'><span class='icon icon-6' onclick=\"insertLog(16612);\">아이콘</span> 이사</a></li>";
	gnbFooterLink += "<li><a href='javascript:///' onclick='goGnbFooterLink(8);'><span class='icon icon-8'>아이콘</span> 조립PC</a></li>";
	gnbFooterLink += "</ul>";
gnbFooterLink += "</div>";
%>
<div class="gnbwrap" id="gnb" datavalue="0">
    <div class="gnbwrap__inner" id="gnbwrap__inner_cate" >
    	<!-- 메뉴 전체보기 - 클릭 시, is-on -->
    	<A class=menu-trigger id=gnbAllBtn1 href="javascript:///">
			<SPAN class="line line1"></SPAN>
			<SPAN class="line line2"></SPAN>
			<SPAN class="line line3"></SPAN>
		</A>
        <ul class="gmenu" id="gnbMenu">
			<li class="gmenu__item menu__item-1" >
			    <a href="javascript:///" class="submenu-trigger js-trigger"><em>가전/해외직구</em></a>
				<!-- 대대메뉴 서브메뉴 보임 = is-shown, 숨김 = is-hidden -->
			    <div class="submenu is-hidden">
			    	<div class="submenu__box">
						<ul class="onelist" id="first_depth0"></ul>
						<div class="gnbanner">
			                <div class="gnbanner__inner">
			                	<!-- 배너이미지 -->
			                    <ul class="bannerlist"></ul>
			                    <!-- 배너닻 -->
			                    <div class="bannerdot"></div>
			                </div>
			            </div>
			            <div class="service"><%=gnbFooterLink%></div>
					</div>
				</div>
			</li>
			<li class="gmenu__item menu__item-2">
			    <a href="javascript:///" class="submenu-trigger js-trigger"><em>TV/영상/디카</em></a>
				<!-- 대대메뉴 서브메뉴 보임 = is-shown, 숨김 = is-hidden -->
			    <div class="submenu is-hidden">
			    	<div class="submenu__box">
						<ul class="onelist" id="first_depth1"></ul>
						<div class="gnbanner">
			                <div class="gnbanner__inner">
			                	<!-- 배너이미지 -->
			                    <ul class="bannerlist"></ul>
			                    <!-- 배너닻 -->
			                    <div class="bannerdot"></div>
			                </div>
			            </div>
			            <div class="service"><%=gnbFooterLink%></div>
					</div>
				</div>
			</li>
			<li class="gmenu__item menu__item-3">
			    <a href="javascript:///" class="submenu-trigger js-trigger"><em>컴퓨터/노트북</em></a>
				<!-- 대대메뉴 서브메뉴 보임 = is-shown, 숨김 = is-hidden -->
			    <div class="submenu is-hidden">
			    	<div class="submenu__box">
						<ul class="onelist" id="first_depth2"></ul>
						<div class="gnbanner">
			                <div class="gnbanner__inner">
			                	<!-- 배너이미지 -->
			                    <ul class="bannerlist"></ul>
			                    <!-- 배너닻 -->
			                    <div class="bannerdot"></div>
			                </div>
			            </div>
			            <div class="service"><%=gnbFooterLink%></div>
					</div>
				</div>
			</li>
			<li class="gmenu__item menu__item-4">
			    <a href="javascript:///" class="submenu-trigger js-trigger"><em>태블릿/모바일</em></a>
				<!-- 대대메뉴 서브메뉴 보임 = is-shown, 숨김 = is-hidden -->
			    <div class="submenu is-hidden">
			    	<div class="submenu__box">
						<ul class="onelist" id="first_depth3"></ul>
						<div class="gnbanner">
			                <div class="gnbanner__inner">
			                	<!-- 배너이미지 -->
			                    <ul class="bannerlist"></ul>
			                    <!-- 배너닻 -->
			                    <div class="bannerdot"></div>
			                </div>
			            </div>
			            <div class="service"><%=gnbFooterLink%></div>
					</div>
				</div>
			</li>
			<li class="gmenu__item menu__item-5">
			    <a href="javascript:///" class="submenu-trigger js-trigger"><em>스포츠/자동차</em></a>
				<!-- 대대메뉴 서브메뉴 보임 = is-shown, 숨김 = is-hidden -->
			    <div class="submenu is-hidden">
			    	<div class="submenu__box">
						<ul class="onelist" id="first_depth4"></ul>
						<div class="gnbanner">
			                <div class="gnbanner__inner">
			                	<!-- 배너이미지 -->
			                    <ul class="bannerlist"></ul>
			                    <!-- 배너닻 -->
			                    <div class="bannerdot"></div>
			                </div>
			            </div>
			            <div class="service"><%=gnbFooterLink%></div>
					</div>
				</div>
			</li>
			<li class="gmenu__item menu__item-6">
			    <a href="javascript:///" class="submenu-trigger js-trigger"><em>유아/식품</em></a>
				<!-- 대대메뉴 서브메뉴 보임 = is-shown, 숨김 = is-hidden -->
			    <div class="submenu is-hidden">
			    	<div class="submenu__box">
						<ul class="onelist" id="first_depth5"></ul>
						<div class="gnbanner">
			                <div class="gnbanner__inner">
			                	<!-- 배너이미지 -->
			                    <ul class="bannerlist"></ul>
			                    <!-- 배너닻 -->
			                    <div class="bannerdot"></div>
			                </div>
			            </div>
			            <div class="service"><%=gnbFooterLink%></div>
					</div>
				</div>
			</li>
			<li class="gmenu__item menu__item-7">
			    <a href="javascript:///" class="submenu-trigger js-trigger"><em>가구/생활</em></a>
				<!-- 대대메뉴 서브메뉴 보임 = is-shown, 숨김 = is-hidden -->
			    <div class="submenu is-hidden">
			    	<div class="submenu__box">
						<ul class="onelist" id="first_depth6"></ul>
						<div class="gnbanner">
			                <div class="gnbanner__inner">
			                	<!-- 배너이미지 -->
			                    <ul class="bannerlist"></ul>
			                    <!-- 배너닻 -->
			                    <div class="bannerdot"></div>
			                </div>
			            </div>
			            <div class="service"><%=gnbFooterLink%></div>
					</div>
				</div>
			</li>
			<li class="gmenu__item menu__item-8">
			    <a href="javascript:///" class="submenu-trigger js-trigger"><em>패션/화장품</em></a>
				<!-- 대대메뉴 서브메뉴 보임 = is-shown, 숨김 = is-hidden -->
			    <div class="submenu is-hidden">
			    	<div class="submenu__box">
						<ul class="onelist" id="first_depth7"></ul>
						<div class="gnbanner">
			                <div class="gnbanner__inner">
			                	<!-- 배너이미지 -->
			                    <ul class="bannerlist"></ul>
			                    <!-- 배너닻 -->
			                    <div class="bannerdot"></div>
			                </div>
			            </div>
			            <div class="service"><%=gnbFooterLink%></div>
					</div>
				</div>
			</li>
			<!-- <li class="all"><a href="javascript:///"><em>전체보기</em></a></li>  -->
       </ul>
    </div>

	<div class="gnbwrap__inner" id="gnbwrap__inner_all" style="display:none;">
			<!-- <ul id="gnbAllMenu" class="menuList"></ul>  -->
			<ul class="gmenu" id="gnbAllMenu"></ul>
			<a href="javascript:///" id="gnbAllBtn2" class="menu-trigger">
    		<SPAN class="line line1"></SPAN>
			<SPAN class="line line2"></SPAN>
			<SPAN class="line line3"></SPAN>
    		</a>
 	</div>

</div>