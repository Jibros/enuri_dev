<%@ page contentType="text/html; charset=utf-8"%>
<link rel="stylesheet" type="text/css" href="/css/gnb.css?v=20210107" >
<link rel="stylesheet" type="text/css" href="/css/gnb_navigation.css?v=2020122242">
<link rel="stylesheet" type="text/css" href="http://img.enuri.info/common/css/eb/default_main.css?v=20190304">
<link rel="stylesheet" type="text/css" href="/common/css/eb/common_main.css?v=20190304">
<script type="text/javascript" src="/common/js/eb/gnb_2020.js?v=5"></script>
<div class="gnbwrap" id="gnb" datavalue="0">
                    <!-- 대대/대/중/소 카테고리 펼쳐보기 -->
                    <div class="gnbwrap__inner" id="gnbwrap__inner_cate">
                        <!-- 메뉴 전체보기 - 클릭 시, is-on -->
                        <!-- <a class="menu-trigger" id="gnbAllBtn1" href="javascript:///">
                            <span class="line line1"></span> 
                            <span class="line line2"></span>
                            <span class="line line3"></span>
                        </a> -->
                        <ul class="gmenu" id="gnbMenu">
                            <li class="gmenu__item menu__item-0">
                                <a href="javascript:///" class="submenu-trigger js-trigger"><em>가전/TV</em></a>
                                <!-- 대대메뉴 서브메뉴 보임 = is-shown, 숨김 = is-hidden -->
                                <div class="submenu is-hidden">
                                    <div class="submenu__box">
                                        <!-- [대 > 중 > 소] 카테 -->
                                        <ul class="onelist" id="first_depth0"></ul>
                                        <div class="gnbanner">
                                            <div class="gnbanner__inner">
                                            	<ul class="bannerlist"></ul>
                                            	<div class="bannerdot"></div>
                                            </div>
                                        </div>
                                        <%@ include file="/common/jsp/include/gnbDataSeq1.jsp"%>
                                        <%@ include file="/common/jsp/include/gnbFooter.jsp"%>
                                    </div>
                                </div>
                            </li>
                            <li class="gmenu__item menu__item-1">
                                <a href="javascript:///" class="submenu-trigger js-trigger"><em>컴퓨터/노트북/조립PC</em></a>
                                <div class="submenu is-hidden">
                                    <div class="submenu__box">
                                        <ul class="onelist" id="first_depth1"></ul>
                                        <div class="gnbanner">
                                            <div class="gnbanner__inner">
                                            	<ul class="bannerlist"></ul>
                                            	<div class="bannerdot"></div>
                                            </div>
                                        </div>
                                        <%@ include file="/common/jsp/include/gnbDataSeq2.jsp"%>
                                        <%@ include file="/common/jsp/include/gnbFooter.jsp"%>
                                    </div>
                                </div>
                            </li>
                            <li class="gmenu__item menu__item-2">
                                <a href="javascript:///" class="submenu-trigger js-trigger"><em>태블릿/모바일/디카</em></a>
                                <div class="submenu is-hidden">
	                                <div class="submenu__box">
	                                    <ul class="onelist" id="first_depth2"></ul>
	                                    <div class="gnbanner">
	                                        <div class="gnbanner__inner">
	                                        	<ul class="bannerlist"></ul>
	                                        	<div class="bannerdot"></div>
	                                        </div>
	                                    </div>
	                                    <%@ include file="/common/jsp/include/gnbDataSeq3.jsp"%>
	                                    <%@ include file="/common/jsp/include/gnbFooter.jsp"%>
	                                </div>
                                </div>
                            </li>
                            <li class="gmenu__item menu__item-3">
                                <a href="javascript:///" class="submenu-trigger js-trigger"><em>스포츠/자동차/공구</em></a>
                                
                                <div class="submenu is-hidden">
                                    <div class="submenu__box">
                                        <ul class="onelist" id="first_depth3"></ul>                                        
                                        <div class="gnbanner">
                                            <div class="gnbanner__inner">
                                            	<ul class="bannerlist"></ul>
                                            	<div class="bannerdot"></div>
                                            </div>
                                        </div>
                                        <%@ include file="/common/jsp/include/gnbDataSeq4.jsp"%>          
                                        <%@ include file="/common/jsp/include/gnbFooter.jsp"%>                              
                                    </div>
                                </div>
                            </li>
                            <li class="gmenu__item menu__item-4">
                                <a href="javascript:///" class="submenu-trigger js-trigger"><em>가구/유아동</em></a>
                               
                                <div class="submenu is-hidden">
                                    <div class="submenu__box">
                                        <ul class="onelist" id="first_depth4"></ul>
                                        
                                        <div class="gnbanner">
                                            <div class="gnbanner__inner">
                                            	<ul class="bannerlist"></ul>
                                            	<div class="bannerdot"></div>
                                            </div>
                                        </div>
                                        <%@ include file="/common/jsp/include/gnbDataSeq5.jsp"%>
                                        <%@ include file="/common/jsp/include/gnbFooter.jsp"%>
                                    </div>
                                </div>
                            </li>
                            <li class="gmenu__item menu__item-5">
                                <a href="javascript:///" class="submenu-trigger js-trigger"><em>식품/건강</em></a>
                                <div class="submenu is-hidden">
                                    <div class="submenu__box">
                                        <ul class="onelist" id="first_depth5"></ul>
                                        
                                        <div class="gnbanner">
                                            <div class="gnbanner__inner">
                                            	<ul class="bannerlist"></ul>
                                            	<div class="bannerdot"></div>
                                            </div>
                                        </div>
                                        <%@ include file="/common/jsp/include/gnbDataSeq6.jsp"%>
                                        <%@ include file="/common/jsp/include/gnbFooter.jsp"%>
                                    </div>
                                </div>
                            </li>
                            <li class="gmenu__item menu__item-6">
                                <a href="javascript:///" class="submenu-trigger js-trigger"><em>생활/주방/반려</em></a>
                                <div class="submenu is-hidden">
                                    <div class="submenu__box">
                                        <ul class="onelist" id="first_depth6"></ul>
                                        
                                        <div class="gnbanner">
                                            <div class="gnbanner__inner">
                                            	<ul class="bannerlist"></ul>
                                            	<div class="bannerdot"></div>
                                            </div>
                                        </div>
                                        <%@ include file="/common/jsp/include/gnbDataSeq7.jsp"%>
                                        <%@ include file="/common/jsp/include/gnbFooter.jsp"%>
                                    </div>
                                </div>
                            </li>
                            <li class="gmenu__item menu__item-7">
                                <a href="javascript:///" class="submenu-trigger js-trigger"><em>명품/패션/화장품</em></a>
                                <div class="submenu is-hidden">
                                    <div class="submenu__box">
                                        <ul class="onelist" id="first_depth7"></ul>
                                        
                                        <div class="gnbanner">
                                            <div class="gnbanner__inner">
                                            	<ul class="bannerlist"></ul>
                                            	<div class="bannerdot"></div>
                                            </div>
                                        </div>
                                        <%@ include file="/common/jsp/include/gnbDataSeq8.jsp"%>
                                        <%@ include file="/common/jsp/include/gnbFooter.jsp"%>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <!-- //대대/대/중/소 카테고리 펼쳐보기 -->
                    <div class="gnbwrap__inner" id="gnbwrap__inner_all" style="display:none;">
                        <!-- <a href="javascript:///" id="gnbAllBtn2" class="menu-trigger">
                            <span class="line line1"></span>
                            <span class="line line2"></span>
                            <span class="line line3"></span>
                        </a> -->
                        <ul class="gmenu" id="gnbAllMenu"></ul>
                    </div>
                    <a href="javascript:///" class="menu-trigger" >
                        <span class="line line1"></span>
                        <span class="line line2"></span>
                        <span class="line line3"></span>
                    </a>
</div>