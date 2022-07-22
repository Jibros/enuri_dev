<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
	String ConstServer = ConfigManager.ConstServer(request);

	// 1:최근본, 2:찜
	// showModelnos가 들어오면 그냥 리스트를 보여줌
	String listType = ChkNull.chkStr(request.getParameter("listType"), "1");
	String loadPageNum = ChkNull.chkStr(request.getParameter("pageNum"), "1");
	int listShowType = 1; // 2번, 3번은 리스트 형태가 똑같음
	if(listType.equals("2")) listShowType = 2;
	if(1==1){
		if(listType.equals("1")){
			response.sendRedirect("/m/recent/recentList.jsp");
			return;
		}else{
			response.sendRedirect("/m/zzim/zzimList.jsp");
			return;
		}
	}
	String showModelnos = ChkNull.chkStr(request.getParameter("showModelnos"), "");

	String titleStr = "";
	if(listShowType==1) titleStr = "최근 본 상품";
	if(listShowType==2) titleStr = "찜 상품";

	String strID = cb.GetCookie("MEM_INFO","USER_ID");

	// 검색관련 변수 선언
	HttpSession Mobilesession = request.getSession(true);

	String strKeyword = ChkNull.chkStr(request.getParameter("keyword"),"");//키워드
	String strInKeyword = ChkNull.chkStr(request.getParameter("in_keyword"),"");//키워드

	String strPageType = ChkNull.chkStr(request.getParameter("pagetype"),"todaylist");
	String strQrcode = ChkNull.chkStr(request.getParameter("_qr"),"");
	String strFromNaver = ChkNull.chkStr((String)Mobilesession.getAttribute("fromNaver"),"");

	String strApp = ChkNull.chkStr(request.getParameter("app"),"");	 //	Y일때 앱
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>에누리(가격비교) eNuri.com</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
	<meta property="og:title" content="에누리 가격비교">
	<meta property="og:description" content="에누리 모바일 가격비교">
	<meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM%>/images/mobilefirst/images/logo_enuri.png">
	<meta name="format-detection" content="telephone=no" />

	<%@ include file="/mobilefirst/renew/include/common.html" %>
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/default.css">
	<link rel="stylesheet" type="text/css" href="/mobilefirst/css/home/lp.css"/>
	<!-- <script type="text/javascript" src="http://m.enuri.com/mobilefirst/js/lib/jquery-2.1.3.min.js"></script> -->
</head>
<body>
 <% if(strApp.equalsIgnoreCase("Y")){ %>

<% }else{	%>
	<%@include file="/mobilefirst/renew/include/gnb.html"%>
<% } %>
<!--***************************-->
<!-- <div id='wrap'> -->
<div id="main">
	<!-- 서브 -->
	<nav class="lp_top">
	<h2>
		<% if(!strApp.equalsIgnoreCase("Y")){ %>
		<a href="javascript:history.back();" class="ico_m">뒤로가기</a>
		<% } %>
		<%=titleStr%></h2>
	</nav>
	<!--// 서브 -->
	<!--// 헤더영역 -->

	<section id="container">
		<%if(listShowType==2) {%>
		<p class="choiceTop">
			<select id="zzimFolderSel" onclick="">
				<!-- <option value="1" selected="">찜폴더1 (40)</option>
				<option value="2">찜폴더2 (10)</option>
				<option value="3">찜폴더3 (2)</option> -->
			</select>
			<button type="button"  id="folderManager" class="btn_folder" onclick="">폴더관리</button>
		</p>
		<%}%>
		<p class="utilTxt">
			<label class="left listTotalNum">
				<input id="allCheckBox" type="checkbox" title="전체 선택" class="move_chk" onclick="ga_log(listType,1);">
				<%if(listShowType==2) {%>
				<em class="showCnt"></em>
				<%}%>
				<em class="allCnt"></em>
			</label>
			<%if(!listType.equals("1")) {%>
			<span class="folder_move" id="modelMoveBtn" onclick="ga_log(2,5);">폴더이동</span>
			<!-- <span class="folder_move" onclick="$('#zzimMoveLayerSec').show();">폴더이동</span> -->
			<%}%>
			<span class="folder_del" id="modelDeleteBtn" onclick="ga_log(listType,2);">폴더삭제</span>
		</p>
		<!-- 찜폴더선택 레이어 -->
		<div class="dim" id="zzimMoveLayerSec" style="display:none;">
			<div class="layerzzim">
				<div class="layerPopCont">
					<h1>찜폴더 선택</h1>
					<button id="zzimMoveLayerX" class="btnClose" onclick="$('#zzimMoveLayerSec').hide();">닫기</button>
					<ul class="zzimlist">
						<!-- <li><a href="JavaScript:" id="selMoveFolder2" folderid="2" class="selMoveFolder">찜폴더2 (0)</a></li>
						<li><a href="JavaScript:" id="selMoveFolder3" folderid="3" class="selMoveFolder">찜폴더3 (1)</a></li>
						<li><a href="JavaScript:" id="selMoveFolder3" folderid="3" class="selMoveFolder">찜폴더4 (1)</a></li> -->
					</ul>
					<div class="layerBtn">
						<div id="zzimMoveLayerCancel" class="btnTxt2 btnSpec" style="float:left;">취소</div><div id="zzimMoveLayerOk" class="btnTxt2 btnCloseSpec" style="float:right;" onclick="ga_log(2,7);">확인</div>
					</div>
				</div>
			</div>
		</div>
		<!--// 찜 폴더선택 레이어 -->

		<p class="no_txt" style="display: none;">폴더에 찜한 상품이 없습니다.</p>

		<!-- 상품리스트 -->
		<div class="lp_list grid">
			<ul class="prodList">
				<!-- <li>
					<div class="listarea">
						<a href="javascript:///">
							<input type="checkbox" title="선택" />
							<button class="btnzzim">찜하기<div class="zzimarea"><span class="zzimly fade-out">찜 되었습니다</span></div></button>
							<span class="thum" ><img src="http://photo3.enuri.com/data/images/service/middle/14779000/14779377.jpg" alt="" /></span>
							<strong class="tit">삼성 갤럭시 노트5 64G (KT)</strong>
							<span class="price"><span class="min">최저가</span> <em>8,279,000</em>원</span>
						</a>
						<div class="more_info"><span class="date">등록일 16년 09월</span></div>
					</div>
				</li>
				<li>
					<div class="listarea">
						<a href="javascript:///">
							<input type="checkbox" title="선택" />
							<button class="btnzzim">찜하기<div class="zzimarea"><span class="zzimly fade-out">찜 되었습니다</span></div></button>
							<span class="thum" ><img src="http://photo3.enuri.com/data/images/service/middle/12461000/12461148.jpg" alt="" /></span>
							<strong class="tit">삼성 갤럭시 노트5 64G (KT)</strong>
							<span class="price"><span class="min">최저가</span> <em>79,000</em>원</span>
						</a>
						<div class="more_info"><span class="date">등록일 16년 09월</span></div>
					</div>
				</li>
				<li>
					<div class="listarea">
						<a href="javascript:///">
							<input type="checkbox" title="선택" />
							<button class="btnzzim">찜하기<div class="zzimarea"><span class="zzimly fade-out">찜 되었습니다</span></div></button>
							<span class="thum" ><img src="http://photo3.enuri.com/data/images/service/middle/14779000/14779377.jpg" alt="" /></span>
							<strong class="tit">삼성 갤럭시 노트5 64G (KT)</strong>
							<span class="price"><span class="min">최저가</span> <em>8,279,000</em>원</span>
						</a>
						<div class="more_info"><span class="date">등록일 16년 09월</span></div>
					</div>
				</li>
				<li>
					<div class="listarea">
						<a href="javascript:///">
							<input type="checkbox" title="선택" />
							<button class="btnzzim">찜하기<div class="zzimarea"><span class="zzimly fade-out">찜 되었습니다</span></div></button>
							<span class="thum" ><img src="http://photo3.enuri.com/data/images/service/middle/12461000/12461148.jpg" alt="" /></span>
							<strong class="tit">삼성 갤럭시 노트5 64G (KT)</strong>
							<span class="price"><span class="min">최저가</span> <em>79,000</em>원</span>
						</a>
						<div class="more_info"><span class="date">등록일 16년 09월</span></div>
					</div>
				</li> -->
			</ul>
		</div>
		<!--// 상품리스트 -->
	</section>
	<%@ include file="/mobilefirst/renew/include/footer.jsp"%>
</div>
</body>
<%@ include file="/mobilefirst/login/login_check.jsp"%>
<%@ include file="/mobilefirst/resentzzim/zzimListInc.jsp"%>

<!--찜 템플릿-->
<script id="zzim_template" type="x-tmpl-mustache">
<li>
	<div class="listarea" onclick="ga_log(listType,3);">
	{{#eGood}}
	<a modelnoid="{{modelnoID}}" shopcode="{{gb1_no}}" goodscode="{{goodscode}}" instance_price="{{instance_price}}" ca_code="{{ca_code}}" url="{{url1}}" price="{{viewminprice}}" href='JavaScript:;' >
		<input type="checkbox" title="선택" id="{{modelnoID}}" name="chk"/>
		<button class="btnzzim">찜하기
			<div class="zzimarea">
				<span class="zzimly fade-out">찜 되었습니다</span>
			</div>
		</button>
		<span class='prodThum' adultimageflag='N'>
			<span class="thum">
				<img style="width:125px;height:125px;" src="{{middleImageUrl}}" onerror="this.src='{{smallImageUrl}}'" alt="{{modelnm}}" id="{{modelnm}}"  />
			</span>
			<strong class="tit">{{modelnm}}</strong>
			{{#minLabel}}
			<span class="price">
				{{{minLabel}}}
				<!-- <span class="min">최저가</span>  -->
				<em>
					{{#viewminprice}}{{viewminprice}}
					<em>원</em>
					{{/viewminprice}}{{^viewminprice}}{{minPriceText}}{{/viewminprice}}
				</em>
			</span>
			{{/minLabel}}
			{{^minLabel}}
				<em class="mall">{{factory}}</em>
				<span class="price shop_p">{{#viewminprice}}<em>{{{viewminprice}}}<em>원</em>
				{{/viewminprice}}{{^viewminprice}}{{{minPriceText}}}{{/viewminprice}}</em></span>
			{{/minLabel}}
	</a>
	<div class="more_info">
		<span class="date">{{c_dateStr}}</span>
	</div>
	{{/eGood}}

	<!--일반상품-->
	{{^eGood}}
	<a modelnoid="{{modelnoID}}" shopcode="{{gb1_no}}" goodscode="{{goodscode}}" instance_price="{{instance_price}}" ca_code="{{ca_code}}" url="{{url1}}" price="{{viewminprice}}" href='JavaScript:;'>
		<input type="checkbox" title="선택" id="{{modelnoID}}" name="chk"/>
		<button class="btnzzim">찜하기
			<div class="zzimarea">
				<span class="zzimly fade-out">찜 되었습니다</span>
			</div>
		</button>
		<span class='prodThum' adultimageflag='N'>
		<span class="thum">
			<img style="width:125px;height:125px;" src="{{middleImageUrl}}" onerror="this.src='{{smallImageUrl}}'" alt="{{modelnm}}" id="{{modelnm}}"  />
		</span>
		<strong class="tit">{{modelnm}}</strong>
		{{#minLabel}}
			<span class="price">
			{{{minLabel}}}
			<em>
				{{#viewminprice}}{{viewminprice}}
				<em>원</em>
				{{/viewminprice}}{{^viewminprice}}{{minPriceText}}{{/viewminprice}}
			</em>
		</span>
		{{/minLabel}}
		{{^minLabel}}
			<em class="mall">{{factory}}</em>
			<span class="price shop_p">{{#viewminprice}}<em>{{{viewminprice}}}<em>원</em>
			{{/viewminprice}}{{^viewminprice}}{{{minPriceText}}}{{/viewminprice}}</em></span>
		{{/minLabel}}
	</a>
	<div class="more_info">
	</div>
	{{/eGood}}
	</div>
</li>
</script>
<!--최근 본 상품 템플릿-->
<script id="goods_template" type="x-tmpl-mustache">
<li>
	<div class="listarea" onclick="ga_log(listType,3);">
		{{#eGood}}
		<a modelnoid="{{modelnoID}}" shopcode="{{gb1_no}}" goodscode="{{goodscode}}" instance_price="{{instance_price}}" ca_code="{{ca_code}}" url="{{url1}}" price="{{viewminprice}}" href='JavaScript:;' >
			<input type="checkbox" title="선택" id="{{modelnoID}}" name="chk"/>
			<button class="btnzzim">찜하기
				<div class="zzimarea">
					<span class="zzimly fade-out">찜 되었습니다</span>
				</div>
			</button>
			<span class='prodThum' adultimageflag='N'>
			<span class="thum">
				<img style="width:125px;height:125px;" src="{{middleImageUrl}}" onerror="this.src='{{smallImageUrl}}'" alt="{{modelnm}}" id="{{modelnm}}"  />
			</span>

			<strong class="tit">{{modelnm}}</strong>
			{{#minLabel}}
			<span class="price">
				{{{minLabel}}}
				<!-- <span class="min">최저가</span>  -->
				<em>
					{{#viewminprice}}{{viewminprice}}
					<em>원</em>
					{{/viewminprice}}{{^viewminprice}}{{minPriceText}}{{/viewminprice}}
				</em>
			</span>
			{{/minLabel}}
			{{^minLabel}}
					<em class="mall">{{factory}}</em>
					<span class="price shop_p">{{#viewminprice}}<em>{{{viewminprice}}}<em>원</em>
					{{/viewminprice}}{{^viewminprice}}{{{minPriceText}}}{{/viewminprice}}</em></span>
			{{/minLabel}}
		</a>
		<div class="more_info">
			<span class="date">{{c_dateStr}}</span>
		</div>
		{{/eGood}}
		<!--일반상품-->
		{{^eGood}}
		<a modelnoid="{{modelnoID}}" shopcode="{{gb1_no}}" goodscode="{{goodscode}}" instance_price="{{instance_price}}" ca_code="{{ca_code}}" url="{{url1}}" price="{{viewminprice}}" href='JavaScript:;' >
		<input type="checkbox" title="선택" id="{{modelnoID}}" name="chk"/>
		<button class="btnzzim">찜하기
			<div class="zzimarea">
				<span class="zzimly fade-out">찜 되었습니다</span>
			</div>
		</button>
		<span class='prodThum' adultimageflag='N'>
		<span class="thum">
			<img style="width:125px;height:125px;" src="{{middleImageUrl}}" onerror="this.src='{{smallImageUrl}}'" alt="{{modelnm}}" id="{{modelnm}}"  />
		</span>
		<strong class="tit">{{modelnm}}</strong>
		{{#minLabel}}
		<span class="price">
			{{{minLabel}}}
			<em>
				{{#viewminprice}}{{viewminprice}}
				<em>원</em>
				{{/viewminprice}}{{^viewminprice}}{{minPriceText}}{{/viewminprice}}
			</em>
		</span>
		{{/minLabel}}
		{{^minLabel}}
			<em class="mall">{{factory}}</em>
			<span class="price shop_p">{{#viewminprice}}<em>{{{viewminprice}}}<em>원</em>
			{{/viewminprice}}{{^viewminprice}}{{{minPriceText}}}{{/viewminprice}}</em></span>
		{{/minLabel}}
	</a>
	<div class="more_info">
	</div>
	{{/eGood}}
	</div>
</li>
</script>
<!--백화점 찜 템플릿-->
<script id="zzim_dept_template" type="x-tmpl-mustache">
<li>
	<div class="listarea" onclick="ga_log(listType,3);">
	{{#eGood}}
	<a modelnoid="{{modelnoID}}" shopcode="{{gb1_no}}" goodscode="{{goodscode}}" instance_price="{{instance_price}}" ca_code="{{ca_code}}" url="{{url1}}" price="{{viewminprice}}" href="javascript:goDetail('{{modelno}}')">
		<input type="checkbox" title="선택" id="{{modelnoID}}" name="chk"/>
		<button class="btnzzim">찜하기
			<div class="zzimarea">
				<span class="zzimly fade-out">찜 되었습니다</span>
			</div>
		</button>
		<span class='prodThum' adultimageflag='N'>
			<span class="thum">
				<img style="width:125px;height:125px;" src="{{middleImageUrl}}" onerror="this.src='{{smallImageUrl}}'" alt="{{modelnm}}" id="{{modelnm}}"  />
			</span>
			<strong class="tit">{{modelnm}}</strong>
			{{#minLabel}}
			<span class="price">
				{{{minLabel}}}
				<!-- <span class="min">최저가</span>  -->
				<em>
					{{#viewminprice}}{{viewminprice}}
					<em>원</em>
					{{/viewminprice}}{{^viewminprice}}{{minPriceText}}{{/viewminprice}}
				</em>
			</span>
			{{/minLabel}}
			{{^minLabel}}
				<em class="mall">{{factory}}</em>
				<span class="price shop_p">{{#viewminprice}}<em>{{{viewminprice}}}<em>원</em>
				{{/viewminprice}}{{^viewminprice}}{{{minPriceText}}}{{/viewminprice}}</em></span>
			{{/minLabel}}
	</a>
	<div class="more_info">
		<span class="date">{{c_dateStr}}</span>
	</div>
	{{/eGood}}

	<!--일반상품-->
	{{^eGood}}
	<a modelnoid="{{modelnoID}}" shopcode="{{gb1_no}}" goodscode="{{goodscode}}" instance_price="{{instance_price}}" ca_code="{{ca_code}}" url="{{url1}}" price="{{viewminprice}}" href="javascript:goDetail('{{modelno}}')">
		<input type="checkbox" title="선택" id="{{modelnoID}}" name="chk"/>
		<button class="btnzzim">찜하기
			<div class="zzimarea">
				<span class="zzimly fade-out">찜 되었습니다</span>
			</div>
		</button>
		<span class='prodThum' adultimageflag='N'>
		<span class="thum">
			<img style="width:125px;height:125px;" src="{{middleImageUrl}}" onerror="this.src='{{smallImageUrl}}'" alt="{{modelnm}}" id="{{modelnm}}"  />
		</span>
		<strong class="tit">{{modelnm}}</strong>
		{{#minLabel}}
			<span class="price">
			{{{minLabel}}}
			<em>
				{{#viewminprice}}{{viewminprice}}
				<em>원</em>
				{{/viewminprice}}{{^viewminprice}}{{minPriceText}}{{/viewminprice}}
			</em>
		</span>
		{{/minLabel}}
		{{^minLabel}}
			<em class="mall">{{factory}}</em>
			<span class="price shop_p">{{#viewminprice}}<em>{{{viewminprice}}}<em>원</em>
			{{/viewminprice}}{{^viewminprice}}{{{minPriceText}}}{{/viewminprice}}</em></span>
		{{/minLabel}}
	</a>
	<div class="more_info">
	</div>
	{{/eGood}}
	</div>
</li>
</script>
<script type="text/javascript" src="/mobilefirst/js/resentzzimList_new.js?v=20191107"></script>
<script language="JavaScript">

var listType = <%=listType%>;
var showModelnos = "<%=showModelnos%>";
if(showModelnos.length > 0){
	paramModelShow = true;
}
var strApp = "<%=strApp%>";
var loadPageNum = <%=loadPageNum%>;

var vAppyn = getCookie("appYN");

if(vAppyn == "Y"){
	$(".m_top_sub .back").hide();
	//$(".m_top_sub h2").addClass("a_center");
}


function ga_log(listType, param){
	var vGa_label = "";
	if(listType=="1"){
		if(param == 1){
			vGa_label = "click_전체체크";
		}else if(param == 2){
			vGa_label = "click_삭제";
		}else if(param == 3){
			vGa_label = "click_최근본상품";
		}
		ga("send", "event", "mf_recent", "click", vGa_label);
	}else{
		if(param == 1){
			vGa_label = "click_전체체크";
		}else if(param == 2){
			vGa_label = "click_삭제";
		}else if(param == 3){
			vGa_label = "click_찜상품";
		}else if(param == 4){
			vGa_label = "click_폴더관리";
		}else if(param == 5){
			vGa_label = "click_폴더이동";
		}else if(param == 6){
			vGa_label = "click_찜폴더 변경";
		}else if(param == 7){
			vGa_label = "click_찜폴더 이동";
		}
		ga("send", "event", "mf_zzim", "click", vGa_label);
	}
}

if(listType=="1") {
	ga('send', 'pageview', {
		'page': '/mobilefirst/resentzzim/resentzzimList.jsp?listType=1',
		'title': 'mf_recent'
		});
} else {
	ga('send', 'pageview', {
		'page': '/mobilefirst/resentzzim/resentzzimList.jsp?listType=2',
		'title': 'mf_zzim'
		});
}

</script>
<%@ include file="/mobilefirst/resentzzim/zzimListInc.jsp"%>
<%@ include file="/mobilefirst/include/inc_ctu.jsp"%>

<%@include file="/mobilefirst/include/common_logger.html"%>
</html>
