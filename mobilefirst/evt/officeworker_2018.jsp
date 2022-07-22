<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.diquest.ir.util.common.StringUtil"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%

String strEventId = ChkNull.chkStr(request.getParameter("event_id"),"");
if("".equals(strEventId)){
	response.sendRedirect("/mobilefirst/index.jsp");
	return;
}

String strFb_img = "http://img.enuri.info/images/event/favorite/sns_off_v39.jpg";

if(
	(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Linux") >= 0 ) ||
	(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||
	(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||
	(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0)){
}else{
	response.sendRedirect("http://www.enuri.com/event/officeworker/officeworker_2018.jsp?event_id="+strEventId);
	return;
}

String chkId = ChkNull.chkStr(request.getParameter("chk_id"));
String strApp = ChkNull.chkStr(request.getParameter("app"),"");
String cUserId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
String cUserNick = "";

Members_Proc members_proc = new Members_Proc();
String cUsername = "";
if(!cUserId.equals(""))	cUsername = members_proc.getUserName(cUserId);
String userArea = cUsername;
if(cUsername.equals(""))     userArea = cUserNick;
if(userArea.equals(""))     userArea = cUserId;

String snsType = ChkNull.chkStr(cb.GetCookie("MEM_INFO","SNSTYPE"));
if( "K".equals(snsType) ||  "N".equals(snsType) ){//sns 계정일 경우 닉네임을 넣어준다
	userArea = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK")); //로그인 닉네임
}

if(strApp.isEmpty()){
     strApp = "N";
     try{
           Cookie[] cookies = request.getCookies();
           if(cookies!=null){
                for(int i=0; i<cookies.length; i++){
                     if(cookies[i].getName().equals("appYN")){
                           strApp =cookies[i].getValue();
                           break;
                     }
                }
           }
     }catch(Exception e){
           strApp = "N";
     }finally{     }
}else{
     strApp = "Y";
}
String strGno     = ChkNull.chkStr(cb.GetCookie("GATEP","GNO"),"");
String strGkind     = ChkNull.chkStr(cb.GetCookie("GATEP","GKIND"),"");
String referer = ChkNull.chkStr(request.getHeader("referer"),"");
long cTime = System.currentTimeMillis();
SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmmss");
String nowDt = dayTime.format(new Date(cTime));

String szRemoteHost = request.getRemoteHost().trim();
boolean enuriLocalMemberFlag = false;
if((szRemoteHost.length()>=11 && szRemoteHost.substring(0, 11).equals("211.206.100")) || (szRemoteHost.length()>=11 && szRemoteHost.substring(0, 11).equals("211.116.248"))) {
	if(szRemoteHost.equals("211.116.248.46") || szRemoteHost.equals("211.116.248.48") || szRemoteHost.equals("211.116.248.55") ||
		szRemoteHost.equals("211.116.248.61") || szRemoteHost.equals("211.116.248.72") || szRemoteHost.equals("211.116.248.74") ||
		szRemoteHost.equals("211.116.248.141")) {
		enuriLocalMemberFlag = false;
	} else {
		enuriLocalMemberFlag = true;
	}
}
%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<META NAME="description" CONTENT="에누리 가격비교">
	<META NAME="keyword" CONTENT="에누리 가격비교">
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 가격비교">
	<meta property="og:image" id="ogimg" content="<%=strFb_img%>">
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="/css/event/y2018/office_workers_m.css?v=2018110520"/>
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/lib/slick.css"/>
	<script type="text/javascript" src="/common/js/lib/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery.cookie.js"></script>
	<script type="text/javascript" src="/mobilefirst/js/lib/slick.min.js"></script>
	<script type="text/javascript" src="/common/js/function.js?v=20190102"></script>
	<script src="/mobilefirst/js/lib/jquery.easy-paging.js"></script>
	<script src="/mobilefirst/js/lib/jquery.paging.min.js"></script>
	<script src="/mobilefirst/js/utils.js"></script>
	<script src="/mobilefirst/js/lib/ga.js"></script>
</head>

<body>
<div class="wrap">

		<!-- 개인화영역 -->
		<div class="myarea">
			<a href="javascript:///" class="win_close">창닫기</a>
		    <%if(cUserId.equals("")){%>
		    	<p class="name">나의 e머니는 얼마일까?<button type="button" class="btn_login">로그인</button></p>
		   	<%}else{%>
		    	<p class="name"><%=userArea%> 님<span id="my_emoney"></span></p>
		   	<%}%>
		</div>
		<!-- //개인화영역 -->

	<div class="content_box">

		<!-- 상단 타이틀 영역 -->
		<div class="top_area">
			<h1 class="change_img" id="top">
				<img src="" alt="1번이미지">
			</h1>
		</div>
		<!-- //상단 타이틀 영역 -->

		<!-- 직장인 테스트 영역 -->
		<div class="cont_area">

			<!-- 딤레이어 : 선택결과 레이어 01 -->
			<div class="layer_back npix" id="result_01" style="display:none;">
				<div class="dim"></div>
				<div class="appLayer re_Layer">
					<h4>결과 확인</h4>
					<a href="javascript:///" class="close" onclick="onoff('result_01')">창닫기</a>
                    <div class="result"></div>
					<div class="recom_prod">
						<div class="pro_box">
							<a href="" target="_blank" title="새 탭에서 열립니다." class="url">
								<div class="imgs">
									<img src="http://photo3.enuri.com/data/images/service/middle/13127000/13127623.jpg" alt="" />
								</div>
								<div class="info">
									<p class="pname"></p>
									<p class="price"><span class="lowst"></span></p>
								</div>
							</a>
						</div>
						<div class="more_btn"></div>
					</div>
				</div>
			</div>
			<!-- //딤레이어 : 선택결과 레이어 01-->


			<div class="change_img">
				<img src="" id="main_contents" alt="2번이미지">
				<ol>
					<li>
						<a href="javascript:void(0)" onclick="openPopup('1')" title="선택1번"></a>
					</li>
					<li>
						<a href="javascript:void(0)" onclick="openPopup('2')" title="선택2번"></a>
					</li>
					<li>
						<a href="javascript:void(0)" onclick="openPopup('3')" title="선택3번"></a>
					</li>
					<li>
						<a href="javascript:void(0)" onclick="openPopup('4')" title="선택4번"></a>
					</li>
				</ol>
			</div>

		</div>
		<!-- //직장인 테스트 영역 -->

		<!-- 경품안내 영역-->
		<h3 class="change_img" id="write_image">
			<img src="" alt="3번이미지">
		</h3>
		<!-- //경품안내 영역-->

	</div>

	<!-- 게시판 영역 -->
	<div class="board_wrap">
		<div class="write_area">
		<!-- 로그인 전 class="logout", 로그인 후 class="login" -->
		<%if(cUserId.equals("")){%>
			<div class="input logout">
				<textarea id="" class="txt_area" maxlength="150" placeholder="글을 입력해 주세요."></textarea>
				<button id="" class="btn regist stripe" onclick="goEnter()">등록하기</button>
			</div>
		<%}else{%>
		<!-- 로그인 후 -->
			<div class="input login">
				<div class="box1">
					<p class="user"><%=userArea%></p>
					<textarea id="txt_area" class="txt_area" maxlength="150" placeholder="이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다.&#10;한 번 등록된 댓글은 수정이 불가하오니 등록 전 확인 부탁드립니다."></textarea>
				</div>
				<div class="box2">
					<p class="word_num"><span>0</span>/150</p>
					<button id="" class="btn regist stripe" onclick="goEnter()">등록하기</button>
				</div>
			</div>
		<%}%>
	</div>
	<div class="view_area"><ul></ul></div>
		<div class="paging">
			<ul class="list" id="paging">
				 <li></li>
                 <li>#n</li>
                 <li>#n</li>
                 <li>#c</li>
                 <li>#n</li>
                 <li>#n</li>
                 <li></li>
			</ul>
		</div>
		<button type="button" class="btn__caution" onclick="$('#notetxt1').show();">꼭 확인하세요</button>
	</div>
	<!-- 게시판 영역 -->

	<!-- 추천 아이템 타이틀 -->
	<div class="content_box" id="recommand_title">
		<h3 class="change_img" id="recommand">
			<img src="" alt="4번이미지">
		</h3>
	</div>
	<!-- //추천 아이템 타이틀 -->

	<!-- //추천 아이템 영역 -->
	<div class="recom_prod" id="recommand_prod">
		<div class="contents">
			<!-- items_area -->
			<div class="items_area p-bgc">
				<ul class="itemlist"></ul>
			</div>
			<!-- items_area -->
		</div>
	</div>
	<!-- //추천 아이템 영역 -->

	<!-- 더 많은 공감하기 -->
	<div class="other_list">
		<h2 class="tit stripe">더 많은 공감하기</h2>

		<div class="ol_wrap" id="ol_wrap">
			<ul class="slick_area" id="slick_area"></ul>
		</div>
	</div>
	<!-- //더 많은 공감하기 -->

<!-- 푸터 -->
<%@ include file="/mobilefirst/event2016/event_footer.jsp" %>
<!--// 푸터 -->
</div>

	<!-- top버튼 영역 -->
	<!-- <span class="go_top"><a href="#">TOP</a></span> -->

</div>

<!-- 앱전용 이벤트 LAYER -->
<div class="layer_back" id="app_only" style="display:none;">
	<div class="appLayer">
		<h4>모바일 앱 전용 쇼핑 혜택</h4>
		<a href="javascript:///" class="close" onclick="onoff('app_only')">창닫기</a>
		<p class="txt">에누리 앱(APP) 설치 후<br />e머니 적립내역 확인 및<br />다양한 e쿠폰 상품으로 교환할 수 있습니다.</p>
		<p class="btn_close"><button type="button" onclick="install_btt();">설치하기</button></p>
	</div>
</div>
<!-- //앱전용 이벤트 LAYER -->
<%if(strEventId.equals("2019100100")) {%>
<div class="layer_back" id="notetxt1" style="display:none;">
	<div class="appLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt1')">창닫기</a>
		<div class="txtlist">
			<ul>
				<li>해당 질문에 해당하는 댓글을 남길시 추첨을 통해 경품증정</li>
				<li>이벤트기간 : <em class="stress">10월 1일 ~ 10월 31일</em></li>
				<li>당첨자 혜택: [스타벅스] 초콜릿 크림 프라푸치노(e머니 5,100점) - 100명</li>
				<li>e쿠폰스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립해드립니다. <br />(제휴처 사정에 따라 해당 쿠폰 품절, 단종,가격 변동 있을 수 있습니다.)</li>
				<li>당첨자 발표:  <em class="stress">11월 18일 당첨자발표 페이지 내 공지</em></li>
				<li>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
				<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
			</ul>
		</div>
	</div>
</div>
<%}else if(strEventId.equals("2019082600")) {%>
<div class="layer_back" id="notetxt1" style="display:none;">
	<div class="appLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt1')">창닫기</a>
		<div class="txtlist">
			<ul>
				<li>해당 질문에 해당하는 댓글을 남길시 추첨을 통해 경품증정</li>
				<li>이벤트기간 : <em class="stress">8월 26일 ~ 9월 30일</em></li>
				<li>당첨자 혜택: [스타벅스] 아이스 카페라떼 Tall (e머니 4,600점) - 100명</li>
				<li>e쿠폰스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립해드립니다. <br />(제휴처 사정에 따라 해당 쿠폰 품절, 단종,가격 변동 있을 수 있습니다.)</li>
				<li>당첨자 발표:  <em class="stress">10월 16일 당첨자발표 페이지 내 공지</em></li>
				<li>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
				<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
			</ul>
		</div>
	</div>
</div>
<%}else if(strEventId.equals("2019070109")) {%>
<!-- 유의사항 -->
<div class="layer_back" id="notetxt1" style="display:none;">
	<div class="appLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt1')">창닫기</a>
		<div class="txtlist">
			<ul>
				<li>해당 질문에 해당하는 댓글을 남길시 추첨을 통해 경품증정</li>
				<li>이벤트기간 : <em class="stress">7월 1일 ~ 7월 31일</em></li>
				<li>당첨자 혜택: [할리스] 콜드브루라떼R (e머니 5,000점) - 100명</li>
				<li>e쿠폰스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립해드립니다. <br />(제휴처 사정에 따라 해당 쿠폰 품절, 단종,가격 변동 있을 수 있습니다.)</li>
				<li>당첨자 발표:  <em class="stress">8월 19일 당첨자발표 페이지 내 공지</em></li>
				<li>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
				<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
			</ul>
		</div>
	</div>
</div>
<%}else if(strEventId.equals("2019051800")) {%>
<!-- 유의사항 -->
<div class="layer_back" id="notetxt1" style="display:none;">
	<div class="appLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt1')">창닫기</a>
		<div class="txtlist">
			<ul>
				<li>해당 질문에 해당하는 댓글을 남길시 추첨을 통해 경품증정</li>
				<li>이벤트기간 : <em class="stress">5월 18일 ~ 6월 30일</em></li>
				<li>당첨자 혜택: [이디야] 우리 함께해 세트(스노우쿠키슈+아메리카노) (e머니 5,000점) - 100명</li>
				<li>e쿠폰스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립해드립니다. <br />(제휴처 사정에 따라 해당 쿠폰 품절, 단종,가격 변동 있을 수 있습니다.)</li>
				<li>당첨자 발표:  <em class="stress">7월 19일 당첨자발표 페이지 내 공지</em></li>
				<li>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
				<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
			</ul>
		</div>
	</div>
</div>
<%}else if(strEventId.equals("2019020109")) {%>
<!-- 유의사항 -->
<div class="layer_back" id="notetxt1" style="display:none;">
	<div class="appLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt1')">창닫기</a>
		<div class="txtlist">
			<ul>
				<li>해당 질문에 해당하는 댓글을 남길시 추첨을 통해 경품증정</li>
				<li>이벤트기간 : <em class="stress">2월 1일 ~ 3월 18일</em></li>
				<li>당첨자 혜택: [파스쿠찌] 아이스 카페모카(R) (e머니 5,000점) - 100명</li>
				<li>e쿠폰스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립해드립니다. <br />(제휴처 사정에 따라 해당 쿠폰 품절, 단종,가격 변동 있을 수 있습니다.)</li>
				<li>당첨자 발표:  <em class="stress">4월 8일 당첨자발표 페이지 내 공지</em></li>
				<li>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
				<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
			</ul>
		</div>
	</div>
</div>

<%}else if(strEventId.equals("2018111600")) {%>
<!-- 유의사항 -->
<div class="layer_back" id="notetxt1" style="display:none;">
	<div class="appLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt1')">창닫기</a>
		<div class="txtlist">
			<ul>
				<li>해당 질문에 해당하는 댓글을 남길시 추첨을 통해 경품증정</li>
				<li>이벤트기간 : <em class="stress">11월 19일 ~ 12월 31일</em></li>
				<li>당첨자 혜택: [롯데리아] 데리버거세트(e머니 4,700점) - 100명</li>
				<li>e쿠폰스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립해드립니다. <br />(제휴처 사정에 따라 해당 쿠폰 품절, 단종,가격 변동 있을 수 있습니다.)</li>
				<li>당첨자 발표:  <em class="stress">1월 17일 당첨자발표 페이지 내 공지</em></li>
				<li>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
				<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
			</ul>
		</div>
	</div>
</div>
<%}else if(strEventId.equals("2019010108")) { %>
<div class="layer_back" id="notetxt1" style="display:none;">
	<div class="appLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt1')">창닫기</a>
		<ul class="txtlist">
			<li>해당 질문에 해당하는 댓글을 남길시 추첨을 통해 경품증정</li>
			<li>이벤트기간 : <em class="stress">1월 1일 ~ 1월 31일</em></li>
			<li>당첨자 혜택: 해피머니 온라인 상품권 5천원권(e머니 5,000점) - 100명</li>
			<li>e쿠폰스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립해드립니다. <br />(제휴처 사정에 따라 해당 쿠폰 품절, 단종,가격 변동 있을 수 있습니다.)</li>
			<li>당첨자 발표:  <em class="stress">2월 8일 당첨자발표 페이지 내 공지</em></li>
			<li>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
			<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
		</ul>
	</div>
</div>
<%}else if(strEventId.equals("2019031900")) { %>
<div class="layer_back" id="notetxt1" style="display:none;">
	<div class="appLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt1')">창닫기</a>
			<ul class="txtlist">
				<li>해당 질문에 해당하는 댓글을 남길시 추첨을 통해 경품증정</li>
				<li>이벤트기간 : <em class="stress">3월 19일 ~ 5월 17일</em></li>
				<li>당첨자 혜택: [맥도날드] 맥너겟세트 (e머니 5,000점) - 100명</li>
				<li>e쿠폰스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립해드립니다. <br />(제휴처 사정에 따라 해당 쿠폰 품절, 단종,가격 변동 있을 수 있습니다.)</li>
				<li>당첨자 발표: <em class="stress">6월 5일 당첨자발표 페이지 내 공지</em></li>
				<li>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
				<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
			</ul>
	</div>
</div>
<%}else if(strEventId.equals("2019110100")) { %>
<div class="layer_back" id="notetxt1" style="display:none;">
	<div class="appLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt1')">창닫기</a>
			<ul class="txtlist">
				<li>해당 질문에 해당하는 댓글을 남길시 추첨을 통해 경품증정</li>
				<li>이벤트기간 : <em class="stress">11월 1일 ~ 11월 30일</em></li>
				<li>당첨자 혜택: [GS25] 모바일 금액권 (e머니 5,000점) - 100명</li>
				<li>e쿠폰스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립해드립니다. <br />(제휴처 사정에 따라 해당 쿠폰 품절, 단종,가격 변동 있을 수 있습니다.)</li>
				<li>당첨자 발표: <em class="stress">12월 17일 당첨자발표 페이지 내 공지</em></li>
				<li>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
				<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
			</ul>
	</div>
</div>

<%}else if(strEventId.equals("2019120200")) { %>
<div class="layer_back" id="notetxt1" style="display:none;">
	<div class="appLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt1')">창닫기</a>
			<ul class="txtlist">
				<li>해당 질문에 해당하는 댓글을 남길시 추첨을 통해 경품증정</li>
				<li>이벤트기간 : <em class="stress">2019년 12월 2일 ~ 2019년 12월 31일</em></li>
				<li>당첨자 혜택: 폴 바셋 룽고 (Standard) (e4700점)- 100명</li>
				<li>e쿠폰스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립해드립니다. <br />(제휴처 사정에 따라 해당 쿠폰 품절, 단종,가격 변동 있을 수 있습니다.)</li>
				<li>당첨자 발표:  <em class="stress">2020년 1월 21일 당첨자발표 페이지 내 공지</em></li>
				<li>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
				<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다<br></li>
			</ul>
	</div>
</div>

<%}else if(strEventId.equals("2020010200")) { %>
<div class="layer_back" id="notetxt1" style="display:none;">
	<div class="appLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt1')">창닫기</a>
			<ul class="txtlist">
				<li>해당 질문에 해당하는 댓글을 남길시 추첨을 통해 경품증정</li>
				<li>이벤트기간 : <em class="stress">2020년 1월 2일 ~ 2020년 1월 31일</em></li>
				<li>당첨자 혜택: 맥도날드 불고기버거 세트 (Standard) (e4600점)- 100명</li>
				<li>e쿠폰스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립해드립니다. <br />(제휴처 사정에 따라 해당 쿠폰 품절, 단종,가격 변동 있을 수 있습니다.)</li>
				<li>당첨자 발표:  <em class="stress">2020년 2월 24일 당첨자발표 페이지 내 공지</em></li>
				<li>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
				<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다<br></li>
			</ul>
	</div>
</div>
<%}else if(strEventId.equals("2020031600")) { %>
<div class="layer_back" id="notetxt1" style="display:none;">
	<div class="appLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt1')">창닫기</a>
			<ul class="txtlist" >
				<li>해당 질문에 해당하는 댓글을 남길시 추첨을 통해 경품증정</li>
				<li>이벤트기간 : <em class="stress">2020년 3월 16일 ~ 2020년 4월 12일</em></li>
				<li>당첨자 혜택: [스타벅스] 아이스 아메리카노 Tall (e머니 4,100점) - 100명</li>
				<li>e쿠폰스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립해드립니다. <br />(제휴처 사정에 따라 해당 쿠폰 품절, 단종,가격 변동 있을 수 있습니다.)</li>
				<li>당첨자 발표:  <em class="stress">2020년 6월 18일 당첨자발표 페이지 내 공지</em></li>
				<li>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
				<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다<br></li>
			</ul>
	</div>
</div>
<%}else if(strEventId.equals("2020042900")) { %>
<div class="layer_back" id="notetxt1" style="display:none;">
	<div class="appLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt1')">창닫기</a>
			<ul class="txtlist" >
				<li>해당 질문에 해당하는 댓글을 남길시 추첨을 통해 경품증정</li>
				<li>이벤트기간 : <em class="stress">5월 11일 ~ 6월 19일</em></li>
				<li>당첨자 혜택: 맥도날드 에그 불고기 버거 세트 (e머니 4,500점) - 100명</li>
				<li>e쿠폰스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립해드립니다. <br />(제휴처 사정에 따라 해당 쿠폰 품절, 단종,가격 변동 있을 수 있습니다.)</li>
				<li>당첨자 발표:  <em class="stress">2020년 7월 23일 당첨자발표 페이지 내 공지</em></li>
				<li>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
				<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다<br></li>
			</ul>
	</div>
</div>
		<%}else if(strEventId.equals("2020062200")) {%>
		<div class="layer_back" id="notetxt1" style="display:none;">
	<div class="appLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt1')">창닫기</a>
			<ul class="txtlist" >
				<li>해당 질문에 해당하는 댓글을 남길시 추첨을 통해 경품증정</li>
				<li>이벤트기간 : <em class="stress">2020년 6월 22일 ~ 2020년 7월 26일</em></li>
				<li>당첨자 혜택: 스타벅스_아이스 카페라떼 Tall (e머니 4,600점) - 100명</li>
				<li>e쿠폰스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는 e머니를 적립해드립니다. <br />(제휴처 사정에 따라 해당 쿠폰 품절, 단종,가격 변동 있을 수 있습니다.)</li>
				<li>당첨자 발표:  <em class="stress">2020년 8월 20일 당첨자발표 페이지 내 공지</em></li>
				<li>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
				<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다<br></li>
				
			</ul>
	</div>
</div>

<%}else if(strEventId.equals("20200731")) {%>
	<div class="layer_back" id="notetxt1" style="display:none;">
		<div class="appLayer">
			<h4>유의사항</h4>
			<a href="javascript:///" class="close" onclick="onoff('notetxt1')">창닫기</a>
			<div class="txtlist">
				<ul>
					<li>해당 질문에 해당하는 댓글을 남길시 추첨을 통해 경품증정</li>
					<li>이벤트기간 : <em class="stress">7월 31일 ~ 8월31일</em></li>
					<li>당첨자 혜택: 배스킨라빈스 더블주니어 아이스크림 (e머니 4,300점) - 100명</li>
					<li>e쿠폰스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는     e머니를 적립해드립니다. (제휴처 사정에 따라 해당 쿠폰 품절, 단종,</li> 
					<li>가격 변동 있을 수 있습니다.</li>
					<li>당첨자 발표: <em class="stress">9월 23일 당첨자발표 페이지 내 공지</em></li>
					<li>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
					<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
				</ul>
			</div>
		</div>
	</div>
<%}else if(strEventId.equals("2020090100")) { %>
<div class="layer_back" id="notetxt1" style="display:none;">
	<div class="appLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt1')">창닫기</a>
		<div class="txtlist">
			<ul>
				<li>해당 질문에 해당하는 댓글을 남길시 추첨을 통해 경품증정</li>
				<li>이벤트기간 : <em class="stress">9월 1일 ~ 10월5일</em></li>
				<li>당첨자 혜택: 해피머니 온라인 상품권 5천원권 (e머니 5,000점) - 100명</li>
				<li>e쿠폰스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는     e머니를 적립해드립니다. (제휴처 사정에 따라 해당 쿠폰 품절, 단종,</li> 
				<li>가격 변동 있을 수 있습니다.</li>
				<li>당첨자 발표: <em class="stress">11월 12일 당첨자발표 페이지 내 공지</em></li>
				<li>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
				<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
			</ul>
		</div>
	</div>
</div>
<%}else if(strEventId.equals("2020100700")) { %>
<div class="layer_back" id="notetxt1" style="display:none;">
	<div class="appLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt1')">창닫기</a>
		<div class="txtlist">
			<ul>
				<li>해당 질문에 해당하는 댓글을 남길시 추첨을 통해 경품증정</li>
				<li>이벤트기간 : <em class="stress">10월 7일 ~ 11월4일</em></li>
				<li>당첨자 혜택: 나는 행복해 세트 (e머니 4,400점) - 100명
				<li>e쿠폰스토어를 적립해드립니다.(제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격 변동 있을 수 있습니다.)</li> 
				<li>당첨자 발표: <em class="stress">12월 10일 당첨자발표 페이지 내 공지</em></li>
				<li>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
				<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
			</ul>
		</div>
	</div>
</div>
<%}else if(strEventId.equals("2020112700")) { %>
<div class="layer_back" id="notetxt1" style="display:none;">
	<div class="appLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt1')">창닫기</a>
		<div class="txtlist">
			<ul>
				<li>해당 질문에 해당하는 댓글을 남길시 추첨을 통해 경품증정</li>
				<li>이벤트기간 : <em class="stress">11월 27일 ~ 12월 31일</em></li>
				<li>당첨자 혜택: 스타벅스 카페라ㅔ Tall (e머니 4,600점) - 100명
				<li>
					e쿠폰스토어에서 해당 경품 외 다양한 e쿠폰으로 교환할 수 있는  e머니를 적립해드립니다. <br>(제휴처 사정에 따라 해당 쿠폰 품절, 단종, 
					가격 변동 있을 수 있습니다.)
				</li> 
				<li>당첨자 발표: <em class="stress">1월 20일 당첨자발표 페이지 내 공지</em></li>
				<li>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
				<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
			</ul>
		</div>
	</div>
</div>
<%}else if(strEventId.equals("2020110500")) { %>
<div class="layer_back" id="notetxt1" style="display:none;">
	<div class="appLayer">
		<h4>유의사항</h4>
		<a href="javascript:///" class="close" onclick="onoff('notetxt1')">창닫기</a>
		<div class="txtlist">
			<ul>
				<li>해당 질문에 해당하는 댓글을 남길시 추첨을 통해 경품증정</li>
				<li>이벤트기간 : <em class="stress">11월 5일 ~ 11월 26일</em></li>
				<li>당첨자 혜택: 베이컨 토마토 머핀세트 (e머니 4,200점) - 100명
				<li>e쿠폰스토어를 적립해드립니다.(제휴처 사정에 따라 해당 쿠폰 품절, 단종, 가격 변동 있을 수 있습니다.)</li> 
				<li>당첨자 발표: <em class="stress">12월 22일 당첨자발표 페이지 내 공지</em></li>
				<li>e머니 유효기간: 적립일로부터 15일 (미사용시 자동소멸)</li>
				<li>본 이벤트는 당사 사정에 따라 사전고지없이 변경 또는 종료 될 수 있습니다</li>
			</ul>
		</div>
	</div>
</div>
<%} %>
<!-- //유의사항 -->
<script>
var pageno = 1;
var pagesize = 4;
var totalcnt = 0;
var event_id = <%=strEventId%>;
var vOs_type = "";
var logNm = "";

if($.cookie('appYN') == 'Y' && '<%=strApp %>' == 'Y'){
     logNm = "APP";
     if(navigator.userAgent.indexOf("Android") > -1)           vOs_type = "MAA";
     else           vOs_type = "MAI";
}else{
     logNm = "Web";
     if(navigator.userAgent.indexOf("Android") > -1)           vOs_type = "MWA";
     else           vOs_type = "MWI";
}

$(".btn_login").click(function(){
    if($.cookie('appYN') != 'Y' && '<%=strApp %>' != 'Y'){
          document.location.href = "/mobilefirst/login/login.jsp?app=&backUrl="+encodeURIComponent(document.location.href);
    }else{
         if(window.android){        // 안드로이드
               document.location.href = "/mobilefirst/login/login.jsp?app=&backUrl="+encodeURIComponent(document.location.href);
         }else{                          // 아이폰에서 호출
               document.location.href = "/mobilefirst/login/login.jsp";
         }
    }
    return false;
});

$( ".win_close" ).click(function(){
    if("<%=strApp %>" == 'Y')    window.location.href = "close://";
    else                     window.location.replace("/mobilefirst/IndexNew.jsp");
});

$("#my_emoney").click(function(){
   /*  ga('send', 'event', 'mf_event', '2017_직장공감', '2017 직장공감_개인화_emoney'); */
    if($.cookie('appYN') != 'Y' && '<%=strApp %>' != 'Y')           $('#app_only').show();
    else  window.location.href = "/mobilefirst/emoney/emoney.jsp?freetoken=emoney";   //e머니 적립내역
});

/*레이어*/
function onoff(id) {
	var mid=document.getElementById(id);
	if(mid.style.display=='') {
		mid.style.display='none';
	}else{
		mid.style.display='';
	}
}

function goOtherUrl(url){
	window.open(url);
}

$(document).ready(function(){

	ga('send', 'pageview', {
		'page': '/mobilefirst/evt/officeworker_2018.jsp',
		'title': '직장공감21탄'
	});

	var main_contents = ajaxData["main_contents"];
	$("#main_contents").attr('src', main_contents);
	if(main_contents == null) {
		alert("잘못된 접근입니다");
		location.href="/mobilefirst/index.jsp";
	}
	recommendItem(); //추천상품
	footerBannerLoading(); //공감하기
	getPoint(); //내 포인트
	getEventlist(); //게시판

	 $("#txt_area").bind({
         keydown:function(event){},
	     keyup:function(){

			var cnt = fnCut($(this).val(),150);

        	 textCnt = cnt;

        	 var kEvt = window.event;
             if (kEvt.keyCode == 13){
             }else{
           		 $(".word_num > span").empty();
    	   	 	 $(".word_num > span").append($(this).val().length);
             }
         },
         blur:function(){
         },
         focus:function(){
         }
     });

	 $("#top img").attr("src", ajaxData["office_event_img1"]);
	 $("#write_image img").attr("src", ajaxData["office_event_img3"]);
	 $("#recommand img").attr("src", ajaxData["office_event_img4"]);
});

var ajaxUrl1 = "/mobilefirst/evt/officeworker_getlist.jsp?p=1&event_id="+event_id;

//팝업 데이터
var ajaxData = (function() {
	var json = new Array();
	$.ajax({
		async: false,
		cache: false,
		global: false,
		url: ajaxUrl1,
		dataType: "json",
		success: function(data) {
			json = data;
		},
		error: function() {
		}
	});
	return json;
})();

//탭데이터
var ajaxUrl3 = "/mobilefirst/evt/officeworker_getlist.jsp?p=3&event_id="+event_id;

var ajaxTab = (function() {
	var Tabjson = new Array();
	$.ajax({
		async: false,
		cache: false,
		global: false,
		url: ajaxUrl3,
		dataType: "json",
		success: function(data){
			Tabjson = data;
		},
		error: function(){
		}
	});
	return Tabjson;
})();


function openPopup(result) {
	ga('send', 'event', 'mf_event', '직장공감21탄', '콘텐츠클릭');
	var popup1 = ajaxData["popup1"];
	var popup2 = ajaxData["popup2"];
	var popup3 = ajaxData["popup3"];
	var popup4 = ajaxData["popup4"];

	var popup_link1 = ajaxData["popup_link1"];
	var popup_link2 = ajaxData["popup_link2"];
	var popup_link3 = ajaxData["popup_link3"];
	var popup_link4 = ajaxData["popup_link4"];

	var pophtml = "";
	var linkhtml = "";

	if(result == "1"){
		pophtml += "        <img src='"+popup1+"'   />";
		linkhtml += "       <a href='"+popup_link1+"'  target='_blank' onclick='ga1();'><b>보러가기</b></a>";
	}else if(result == "2"){
		pophtml += "        <img src='"+popup2+"'   />";
		linkhtml += "       <a href='"+popup_link2+"'  target='_blank' onclick='ga1();'><b>보러가기</b></a>";
	}else if(result == "3"){
		pophtml += "        <img src='"+popup3+"'   />";
		linkhtml += "       <a href='"+popup_link3+"'  target='_blank' onclick='ga1();'><b>보러가기</b></a>";
	}else if(result == "4"){
		pophtml += "        <img src='"+popup4+"'   />";
		linkhtml += "       <a href='"+popup_link4+"'  target='_blank' onclick='ga1();'><b>보러가기</b></a>";
	}
	$(".result").html(pophtml);
	$(".more_btn").html(linkhtml);
	$("#result_01").show();
	makeGD(result);
}

//팝업 상품
function makeGD(result){
	var tabList = ajaxTab["data"];
	var tab_no = tabList[0]["tab_no"];
	var ajaxUrl = "/mobilefirst/evt/officeworker_getlist.jsp?p=2&event_id="+event_id+"&tab_no="+tab_no;

	var ajaxGD = (function() {
		var GDjson = new Array();
		$.ajax({
			async: false,
			cache: false,
			global: false,
			url: ajaxUrl,
			dataType: "json",
			success: function(data){
				GDjson = data;
			},
			error: function(){
			}
		});
		return GDjson;
	})();

	var ord = parseInt(result-1);
	var GDjson = ajaxGD["data"];

	var view_yn = GDjson[ord]["view_yn"];
	var modelno = GDjson[ord]["model_no"];
	var gd_nm1 = GDjson[ord]["gd_nm1"];
	var gd_nm2 = GDjson[ord]["gd_nm2"];
	var image = GDjson[ord]["image"];
	var price = GDjson[ord]["price"];

	var imghtml = "";
	var url = "/mobilefirst/detail.jsp?modelno="+modelno;
    imghtml += "<img src='"+image+"'/>";


    $(".pro_box .imgs").html(imghtml);
    $(".pro_box .pname").html(gd_nm1+"<br>"+gd_nm2);
    $(".lowst").html("최저가 " +"<b>"+numberFormat(price)+"</b><span>원</span>");
    $(".url").attr('href', url);

}

//추천상품
function recommendItem() {
	var tabList = ajaxTab["data"];
	var tab_no = tabList[1]["tab_no"];
	var ajaxUrl = "/mobilefirst/evt/officeworker_getlist.jsp?p=2&event_id="+event_id+"&tab_no="+tab_no;

	var ajaxGD = (function() {
		var GDjson = new Array();
		$.ajax({
			async: false,
			cache: false,
			global: false,
			url: ajaxUrl,
			dataType: "json",
			success: function(data){
				GDjson = data;
			},
			error: function(){
			}
		});
		return GDjson;
	})();

	var GDList = ajaxGD["data"];
	if(GDList == "") {
		$('div').remove('#recommand_title');
		$('div').remove('#recommand_prod');
	}
	var makehtml = "";

	$.each(GDList, function(index, list){
		var modelno = list["model_no"];
		var image = list["image"];
		var price = list["price"];
		var gd_nm1 = list["gd_nm1"];
		var gd_nm2 = list["gd_nm2"];
		var url = "/mobilefirst/detail.jsp?modelno="+modelno;

		makehtml += "	<li>";
		makehtml += "		<a href='"+url+"' target='_blank' title='새 탭에서 열립니다.' class='btn' onclick='ga2();'>";
		makehtml += " 			<div class='imgs'>";
		makehtml += "				<img src='"+image+"'/>";
		if(price == 0){
			makehtml += "			<span class='soldout'>SOLD OUT</span>";
		}
		makehtml += "			</div>";
		makehtml += "     		<div class='info'>";
		makehtml += "   			<p class='pname'>"+gd_nm1+"<br/>"+gd_nm2+"</p>";
		makehtml += " 				<p class='price'><span class='lowst1'>최저가</span><b>"+numberFormat(price)+"</b>원</p>";
		makehtml += "  			</div>";
		makehtml += "  		</a>";
		makehtml += "	</li>";
	});
	$(".items_area .itemlist").html(makehtml);
}

//더 많은 공감하기
function footerBannerLoading(){
$.ajax({
          type: "GET",
          url: "/mobilefirst/api/officeBanner.json",
          dataType: "JSON",
          success: function(json){
                if(json.promotionList){
                    var listTemp = "";
                    $.each( json.promotionList , function(i , v){
                        listTemp += "<li data-link='"+v.mobile_url+"'>";
	                    listTemp += "	<a onclick=\"javascript:goOtherUrl('"+v.mobile_url+"')\">";
	                    listTemp += "		<div class='img_box'>";
	                    listTemp += "			<img src='"+v.img_src+"' alt='' />";

	                    						var title = v.title;
	                   							 if (title.length > 6) { // title
			                						title = v.title.substring(0, 6) + "<br>" + v.title.substring(6, 12)
			                						+ "<br>" + v.title.substring(12, 18);
			            						}
	                    listTemp += "				<span class='copy'>"+title+"</span>";
	                    listTemp += "				<span class='dim'></span>";
	                    listTemp += "		</div>";
	                    listTemp += "	</a>";
	                    listTemp += "</li>";
                    });
                    $("#slick_area").html(listTemp);
                    slickLoading();
                }
          },error: function (xhr, ajaxOptions, thrownError) {}
     });
}

function getEventlist(){
	$.ajax({
	          type: "GET",
	          url: "/mobilefirst/event2016/xmas_getlist.jsp",
	          data: "pageno="+pageno+"&pagesize="+pagesize+"&eventId="+event_id,
	          dataType: "JSON",
	          success: function(json){
	                $("#xams_msg").html(null);

	                if(json.eventlist){

	                     var template = "";
	                     for(var i=0;i<json.eventlist.length;i++){

	                        if(i==0) totalcnt = json.eventlist[i].totalcnt;
	                        var userId = json.eventlist[i].user_id;
	                        if(userId.length>9)       id = userId.substring(0,4)+"**"+"..";
	                        else                           id = userId.substring(0, userId.length-2)+"**";

							var reply_date = json.eventlist[i].reply_date;
							var year = reply_date.substring(0,4);
							var month = reply_date.substring(6,4);
							var day = reply_date.substring(8,6);
							var date = year+"-"+month+"-"+day;

	                        template += "<li>";
		                        template += "<div class='head'>";
		                        template += "	<p class='user'>"+id+"</p>";
		                        template += "	<p class='date'>"+date+"</p>";
		                        template += "</div>";
		                        template += "<p class='cont'>"+json.eventlist[i].reply_msg+"</p>";
	                        template += "</li>";

	                     }
	                     $(".view_area > ul").html(template);
	                     $("#paging").easyPaging(totalcnt, {    perpage : 4,    onSelect: function(page) {    perpage = 4;    pageno = page; getEventlist2();   }   });
	                }
	          },error: function (xhr, ajaxOptions, thrownError) {}
	     });
	}

function getEventlist2(){
	$.ajax({
		
	          type: "GET",
	          //url: "/mobilefirst/event2016/xmas_getlist.jsp",
	          //data: "pageno="+pageno+"&pagesize="+pagesize+"&eventId="+event_id,
	          url: "/event2016/mobile_award_getlist.jsp",
        	  data: "pageno="+pageno+"&pagesize="+pagesize+"&event_id="+event_id+"&del_yn=N",
	          dataType: "JSON",
	          success: function(json){
	                $("#xams_msg").html(null);
	                if(json.eventlist){
	                     var template = "";

	                     for(var i=0;i<json.eventlist.length;i++){
	                        var userId = json.eventlist[i].user_id;
							//if(userId.length>9)       id = userId.substring(0,4)+"**"+"..";
							//else                           id = userId.substring(0, userId.length-2)+"**";

							var reply_date = json.eventlist[i].reply_date;
							var year = reply_date.substring(0,4);
							var month = reply_date.substring(6,4);
							var day = reply_date.substring(8,6);
							var date = year+"-"+month+"-"+day;

							if(i==0) totalcnt = json.eventlist[i].totalcnt;

	                        template += "<li>";
	                        template += "<div class='head'>";
	                        template += "	<p class='user'>"+userId+"</p>";
	                        template += "	<p class='date'>"+date+"</p>";
	                        template += "</div>";
	                        template += "<p class='cont'>"+json.eventlist[i].reply_msg+"</p>";
	                    	template += "</li>";
	                     }
	                     $(".view_area > ul").html(template);
	                }
	          },error: function (xhr, ajaxOptions, thrownError) {}
	     });
	}

//게시판
function goEnter(){
	  if(!IsLogin()){
        alert("로그인 후 참여 가능합니다.");
        goLogin();
        return false;
    }else{
    	$.ajax({
	  		type: "GET",
	  		url: "/member/ajax/getMemberCetify.jsp",
	  		async: false,
	  		dataType:"JSON",
	  		success: function(json){
	  			
	  			if(!json.certify){
	  				var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
	  				if(r){
	  					location.href = "/mobilefirst/member/myAuth.jsp?cmdType=&f=m";
	  					return false;	
	  				}else{
	  					return false;	
	  				}
	  				return false;
	  			}else{
	  				goReplay();
	  			}
	  		}
	  	});
    }
	  	
}

function goReplay(){
	
  var txtcnt = $("#txt_area").val().length;
	
  if(txtcnt > 150){
	  alert("150글자 까지만 입력 가능합니다.");
	  return false;
  }

  var reply = $(".txt_area").val();
  var count = reply.length;

  if(reply == "이벤트와 무관한 부적절한 글은 관리자에 의해 삭제될 수 있습니다"){
    alert("내용을 입력해주세요!");
    $(".txt_area").focus();
    return false;
  }

  var blank_pattern = /^\s+|\s+$/g;
  if( $("#txt_area").val().replace( blank_pattern, '' ) == "" ){
      alert(' 내용을 입력해주세요! ');
      return false;
  }

  if(count == 0)             alert("내용을 입력해주세요!");
  else{
       var vData = {replyMsg:reply, osType:vOs_type, eventId:event_id,replyType:"O"};
       $("#wish_reply").val("");
       $.ajax({
          type: "POST",
          url: "./ajax/reply_setlist.jsp",
          data : vData ,
          dataType: "JSON",
          success: function(json){
               if( json.result == "true"){
                getEventlist2();
                alert("등록되었습니다!");
                $(".txt_area").val("");
                $(".word_num > span").text("0");
               
               }else if(json.result==-5){
					
	        	   var r = confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?");
				   if(r){
						location.href = "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
				   }
		           
               }else{
                alert("이미 참여하셨습니다. \n1일 1회 참여가능합니다.");
               }
          },
            error: function (xhr, ajaxOptions, thrownError) {}
       });
   }
	
}

function fnCut(str,lengths) // str은 inputbox에 입력된 문자열이고,lengths는 제한할 문자수 이다.
{
      var len = 0;
      var newStr = '';

      for (var i=0;i<str.length; i++)
      {
        var n = str.charCodeAt(i); // charCodeAt : String개체에서 지정한 인덱스에 있는 문자의 unicode값을 나타내는 수를 리턴한다.
        // 값의 범위는 0과 65535사이이여 첫 128 unicode값은 ascii문자set과 일치한다.지정한 인덱스에 문자가 없다면 NaN을 리턴한다.

       var nv = str.charAt(i); // charAt : string 개체로부터 지정한 위치에 있는 문자를 꺼낸다.


        if ((n>= 0)&&(n<256)) len ++; // ASCII 문자코드 set.
        else len += 2; // 한글이면 2byte로 계산한다.

        if (len>lengths) break; // 제한 문자수를 넘길경우.
        else newStr = newStr + nv;
      }
      return len;
}

function numberFormat(num) {
	num += ''; // 문자열로 치환
	var pattern = /(-?[0-9]+)([0-9]{3})/;
	while(pattern.test(num)) {
		num = num.replace(pattern,"$1,$2");
	}
	return num;
}

$(".url").click(function() {
	ga('send', 'event', 'mf_event', '직장공감21탄', '콘텐츠상품클릭');
});

function ga1(){
	ga('send', 'event', 'mf_event', '직장공감21탄', '콘텐츠상품더보기');
}

function ga2(){
	ga('send', 'event', 'mf_event', '직장공감21탄', '하단상품클릭');
}

function slickLoading(){
	$('.slick_area').slick({
		infinite: false,
		slidesToShow: 3,
		swipeToSlide: true,
		speed: 150,
		cssEase : "ease-in"
	});
	$('.slick_area').on('afterChange', function(event, slick, direction){
		var e = event,
			s = slick,
			d = direction,
			total = s.slideCount - 1;
		if(d == 0){
			alert("첫 페이지입니다!");
		}else if(d == total){
			alert("마지막 페이지입니다!");
		}
	});
}

function getPoint(){
    $.ajax({
         type: "GET",
         url: "/mobilefirst/emoney/emoney_get_point.jsp",
         async: false,
         dataType:"JSON",
         success: function(json){
               remain = json.POINT_REMAIN;     //적립금
              $("#my_emoney").html(commaNum(remain) +""+json.POINT_UNIT);
              
         }
    });
}

function install_btt(){
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
        window.location.href = 'https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8';
    }else if(navigator.userAgent.indexOf("Android") > -1){
    	window.location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3DTop_banner%26utm_campaign%3Ddowloadbanner_201504";
    }
}
</script>
</body>
<script language="JavaScript" src="http://imgenuri.enuri.gscdn.com/common/js/Log_Tail_Mobile.js"></script>
</html>