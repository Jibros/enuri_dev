<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@page import="com.enuri.bean.main.Goods_Detail_Data"%>
<%@page import="com.enuri.bean.main.Goods_Detail_Proc"%>
<jsp:useBean id="Goods_Data" class="com.enuri.bean.main.Goods_Data" scope="page" />
<jsp:useBean id="Goods_Proc" class="com.enuri.bean.main.Goods_Proc" scope="page" />
<%
int nModelNo = ChkNull.chkInt(request.getParameter("modelno"),0);

if(nModelNo<=0) {
	return;
}

Goods_Data goods_data = Goods_Proc.Goods_Detailmulti_One(nModelNo, "Detailmulti");

if(goods_data == null) {
    return;
}

//기본정보
String cur_date = ReplaceStr.replace(DateStr.nowStr(),"-","");
long intRealMinPrice = goods_data.getMinprice();
String szCategory = goods_data.getCa_code();
String dDate = goods_data.getC_date();
long lngMinprice = goods_data.getMinprice();
String strConstrain = goods_data.getConstrain();
long lngMaxprice = goods_data.getMaxprice();

String strPriceString = "";
String outDate = "";
String tempDate = dDate;
if(tempDate.length() == 8) {
	tempDate = tempDate.substring(0,4) + "-" + tempDate.substring(4,6) + "-" + tempDate.substring(6,8);
}
if(!ChkNull.chkNumber(dDate) || (ChkNull.chkNumber(dDate) && (Integer.parseInt(dDate) <= Integer.parseInt(cur_date)))) { //출시완료
	String iY = DateStr.getYMD(tempDate,"Y");
	String iM = DateStr.getYMD(tempDate,"M");
	outDate = iY + "." + iM;
}else{ //출시예정
	outDate = "출시예정";
}

if(outDate.indexOf("예정") > -1){
	strPriceString = "출시예정";
}else if(lngMinprice == 0 && ( CutStr.cutStr(szCategory,4).equals("0304") || CutStr.cutStr(szCategory,4).equals("0305") || CutStr.cutStr(szCategory,4).equals("0353"))){
	//strPriceString = "별도확인";
	lngMinprice = 1;
	intRealMinPrice = 1;
	if(lngMaxprice==0){
		lngMaxprice = 1;
	}
}else if(strConstrain.equals("1") && lngMinprice == 0){
	strPriceString = "일시품절";
}else if(strConstrain.equals("2")){
	strPriceString = "단종";
}else{
	strPriceString = "";
}

int rootSize = 320;
int halfSize = -160;

int totalCnt = 0;
Goods_Detail_Proc goods_detail_proc = new Goods_Detail_Proc();
Goods_Detail_Data[] goods_detail_data = goods_detail_proc.Goods_Price_List_Showtype(nModelNo, 6);
if(goods_detail_data!=null){
	totalCnt = goods_detail_data.length;;
}
%>
<!DOCTYPE html>
<html lang="ko" xml:lang="ko" xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#" xmlns:fb="http://www.facebook.com/2008/fbml" style="overflow:hidden;">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<%=ConfigManager.ENURI_COMMON%>/common/js/lib/jquery-1.9.1.min.js"></script>
<style type='text/css'>
#div_inconv {position:absolute;z-index:150;width:280px;top:185px;left:3px;font-size:11px;}
#div_inconv * {font-family: "맑은 고딕";color:#000000;}
#epTop {height:50px;width:280px;background:url('http://img.enuri.info/2012/toolbar2/singo_bg_01.png') left top no-repeat;}
#epTop.formall {background:url('http://img.enuri.info/2012/toolbar2/singo_bg_01_1.png') left top no-repeat;}
#epTop * {display:none;}
#div_inconv .closeBtn {position:absolute;top:10px;right:10px;width:17px;height:16px;cursor:pointer;}
#epTitle {height:24px;font-size:14px;font-weight:bold;}
#epDetail {height:24px;line-height:16px;}
#epDetail span {color:#800000;}
#epMain {width:280px;background:url('http://img.enuri.info/2012/toolbar2/singo_bg_02.png') repeat;}
#epMallChk {display:none;}
#epMallChk ul {width:240px;list-style:none;margin:0 0 0 16px;padding:0;}
#epMallChk ul li {list-style:none;float:left;width:110px;height:20px;font-size:12px;font-weight:bold;}
#epFormTitle {clear:both;margin:0 0 0 18px;padding-top:5px;font-size:12px;line-height:16px;}
#epFormSubInfo {clear:both;margin:0 0 0 18px;font-size:11px;line-height:14px;display:none;}
#epFormSubInfo div {margin-top:4px;}
#epfTitle {font-weight:bold;}
.inconv_txt {width:244px;height:100px;border:1px solid black;margin:5px 0 5px 16px;font-size:12px;ime-mode:active;}
#epfDetail {margin-left:16px;width:244px;font-size:12px;}
#epNums { display:none;margin: 5px 0;padding-left:10px;background:url('http://img.enuri.info/2012/toolbar2/bu_g.gif') 0 50% no-repeat;}
#epNums * {color:#5A5A5A;}
#epnNums {font-weight:bold;}
#epNumsDummy {width:244px;height:20px;margin:12px 0 0 16px;text-align:right; }
#epfSubmit {cursor:pointer;}
#epBottom {width:280px;height:15px;background:url('http://img.enuri.info/2012/toolbar2/singo_bg_03.png') left top no-repeat;}
.anchors_off {overflow:hidden;margin-right:6px;display:inline-block;background:url(http://img.enuri.info/images/main/2014/icon_off.gif) no-repeat;width:8px;height:8px;font-size:0px;line-height:1px;cursor:pointer;}
.anchors_on {overflow:hidden;margin-right:6px;display:inline-block;background:url(http://img.enuri.info/images/main/2014/icon_on.gif) no-repeat;width:8px;height:8px;font-size:0px;line-height:1px;cursor:pointer;}
</style>
<!--[if IE 7]>
<link rel="stylesheet" type="text/css" href="/common/css/eb/common7.css">
<![endif]-->
<link class="include" rel="stylesheet" type="text/css" href="/view/graph/css/jquery.jqplot.css" />
<link type="text/css" rel="stylesheet" href="/view/graph/syntaxhighlighter/styles/shCoreDefault.min.css" />
<link type="text/css" rel="stylesheet" href="/view/graph/syntaxhighlighter/styles/shThemejqPlot.min.css" />
<script language="javascript" type="text/javascript" src="/view/graph/js/excanvas.js"></script>
<script class="include" type="text/javascript" src="/view/graph/js/jquery.jqplot.js"></script>
<script type="text/javascript" src="/view/graph/syntaxhighlighter/scripts/shCore.min.js"></script>
<script type="text/javascript" src="/view/graph/syntaxhighlighter/scripts/shBrushJScript.min.js"></script>
<script type="text/javascript" src="/view/graph/syntaxhighlighter/scripts/shBrushXml.min.js"></script>
<script class="include" language="javascript" type="text/javascript" src="/view/graph/plugins/jqplot.highlighter.js"></script>
<script class="include" language="javascript" type="text/javascript" src="/view/graph/plugins/jqplot.cursor.min.js"></script>
<script class="include" language="javascript" type="text/javascript" src="/view/graph/plugins/jqplot.canvasTextRenderer.js"></script>
<script class="include" language="javascript" type="text/javascript" src="/view/graph/plugins/jqplot.categoryAxisRenderer.min.js"></script>
<script class="include" language="javascript" type="text/javascript" src="/view/graph/plugins/jqplot.canvasAxisLabelRenderer.js"></script>
<script class="include" language="javascript" type="text/javascript" src="/view/graph/plugins/jqplot.canvasAxisTickRenderer.js"></script>
<script class="include" language="javascript" type="text/javascript" src="/view/graph/plugins/jqplot.pointLabels.js"></script>
<script class="include" language="javascript" type="text/javascript" src="/view/graph/plugins/jqplot.logAxisRenderer.min.js"></script>
<style>
/* common */
body{font-family:Dotum, "돋움", verdana, sans-serif;font-size:12px;color:#666666; font-size:12px;color:#666;}
body, ul, ol, li, dt, dl, dd, div, h1, h2, h3, h4, h5, h6, p, form, fieldset, blockquote, iframe, input, object, table, tr, th, td{margin:0;padding:0;}

/* 20150427 */
.detailGraphDiv {position:absolute; left:50%; width: <%=rootSize%>px; margin-left:<%=halfSize%>px;}
.detailGraphDiv .title {font-size:22px;}
.detailGraphDiv .title .space {display:inline-block; height:54px; vertical-align:middle; }
.detailGraphDiv .title .tit {display:inline-block;  vertical-align:middle; width:<%=(rootSize-2)%>px; margin-left:-5px;}

div { margin:0px;padding:0px;overflow:hidden; }

.detailGraphDiv .head {overflow:hidden; height:40px; padding:0 10px; border-bottom:1px solid #ced2d7;}
.detailGraphDiv .head .tit {float:left; font-size:14px; color:#333; line-height:40px; vertical-align:middle;}
.detailGraphDiv .head .radioChk {float:right;}
.detailGraphDiv .head .radioChk label {display:inline-block; position:relative; padding-left:20px; margin-right:5px; font-size:14px; color:#333; line-height:40px; vertical-align:middle;}
.detailGraphDiv .head .radioChk label:last-child {margin-right:0;}
input[type='radio'] {position:absolute; top:11px; left:0; width:18px;height:18px; margin-right:3px; border:0; background:url(http://img.enuri.info/images/mobilenew/images/bg_form.png) no-repeat -55px 0;background-size:100px;}
input[type='radio']:checked {background-position:-55px -18px;}
.detailGraphDiv .head .radioChk label span.graphTermEvt {font-weight:normal;}
</style>
<script language="JavaScript">
function Start() {
	loadDefaultDetailGraph();
}
</script>
</head>
<body style="margin:0px;padding:0px;overflow:hidden;" onload="Start();">
	<div id="detailGraphDiv" class="detailGraphDiv" style="position:relative;">
		<h3 class="head">
			<!-- //레이어 -->
			<p class="tit">가격추세</p>
			<div id="graphTermBtnsSpan" class="radioChk" style="display:none;">
				<label><input class="graphTermEvt" id="graphTerm1" name="graphTerm" type="radio" gType="1" value="1"><span id="graphTermSpan1" class="graphTermEvt" gType="1">1개월</span></label> 
				<label><input class="graphTermEvt" id="graphTerm3" name="graphTerm" type="radio" gType="3" value="3"><span id="graphTermSpan3" class="graphTermEvt" gType="3">3개월</span></label>
				<label><input class="graphTermEvt" id="graphTerm6" name="graphTerm" type="radio" gType="6" value="6"><span id="graphTermSpan6" class="graphTermEvt" gType="6">6개월</span></label>
			</div>
		</h3>
		<div id="graphBoxDiv" class="graphbox" style="display:none;position:relative;margin:6px 0px 0px 0px;">
			<!--  (현재) 표시 -->
			<div id="nowLabelDiv" style="z-index:102;position:absolute;text-align:center;width:80px;height:14px;font-family:돋움;font-size:11px;color:#777777;background-color:#ffffff;">(현재)</div>
			<!-- 맨 왼쪽 라인 지우기, jqplot로 잘 안지워짐 -->
			<div id="graphLeftWhiteLineDiv" style="z-index:100;position:absolute;left:1px;top:11px;width:10px;height:105px;background-color:#ffffff;"></div>
			<div id="detailGraphShowDiv" style="z-index:99;height:138px;width:<%=(rootSize-28)%>px;text-align:left;">
				<!-- 상단과 하단 라인은 색깔이 틀림 -->
				<div id="topGraphLineDiv" style="z-index:101;width:<%=(rootSize-28)%>px;height:1px;background-color:#ffffff;position:absolute;left:1px;top:10px;"></div>
				<div id="bottomGraphLineDiv" style="z-index:101;width:<%=(rootSize-28)%>px;height:1px;background-color:#bfbfbf;position:absolute;left:1px;top:117px;"></div>
			</div>
			<!-- 상단과 하단 라인은 색깔이 틀림 -->
			<div id="topGraphLineDivBg" style="z-index:98;width:<%=(rootSize-28)%>px;height:1px;background-color:#ffffff;position:absolute;left:1px;top:10px;"></div>
			<div id="bottomGraphLineDivBg" style="z-index:1000;width:<%=(rootSize)%>px;height:1px;background-color:#bfbfbf;position:absolute;left:1px;top:117px;"></div>
			<!-- 현재가 정보 밖에 없을 때 문구 표시 -->
			<div id="detailGraphNoDataTextDiv" style="display:none;z-index:110;top:125px;left:30px;width:<%=(rootSize-120)%>px;height:14px;position:absolute;font-family:'돋움';font-size:11px;color:#999999;">(최신모델로 최저가 추세 정보가 없습니다.)</div>
		</div>
		<div class="noinfo graph" style="display:none;">
			<p>상품 출시 전이거나 단종상품으로 <br />가격추세 정보가 없습니다</p>
		</div>
	</div>
<script type="text/javascript">
var modelno = <%=nModelNo%>;
var minprice = <%=intRealMinPrice%>;
var price_string = "<%=strPriceString%>";
var widthsize ="<%=(rootSize-28)%>";

var dataList = null;
var exDataList = new Array(); // 부가 정보 저장
var tot_graphcnt = <%=totalCnt%>;

function loadDefaultDetailGraph() {

	/*
	$("#graphQuestionA").click(function (e) {
		graphNoticeToogle();
	});

	$("#graphQuestionCloseA").click(function (e) {
		graphNoticeToogle();
	});
*/
	// 출시 예정이나 단종 상품의 경우는 그래프를 표시 안함
	if(price_string.indexOf("출시예정")>-1 || price_string.indexOf("단종")>-1 || price_string.indexOf("품절")>-1) {
		return;
	}

	loadDatailGraph("0");

	$("#graphTermBtnsSpan .graphTermEvt").click(function (e) {
//		var showType = document.graphTermForm.graphTerm.value;
		var showType = $(this).attr("gType");

		// 이전에 그린 그래프 삭제
		var detailGraphShowDivObj = $("#detailGraphShowDiv");
		detailGraphShowDivObj.empty( );
		detailGraphShowDivObj.append("<!-- 상단과 하단 라인은 색깔이 틀림 -->");
		detailGraphShowDivObj.append("<div id=\"topGraphLineDiv\" style=\"z-index:101;width:<%=(rootSize-28)%>px;height:1px;background-color:#ffffff;position:absolute;left:1px;top:10px;\"></div>");
		detailGraphShowDivObj.append("<div id=\"bottomGraphLineDiv\" style=\"z-index:101;width:<%=(rootSize-28)%>px;height:1px;background-color:#bfbfbf;position:absolute;left:1px;top:117px;\"></div>");

		document.getElementById("graphTerm"+showType).checked = true;
		loadDatailGraph(showType);
	});
}

//그래프 생성
var oldGraphShowType = "";
var graphBaseSize = <%=(rootSize-28)%>;
var maxGraphTick = 7;
var xGridLineCnt = 0;
var nowGraphWidth = 0;
/*
* Copyright ⓒ 2009-2011 Chris Leonello
* Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
* THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
function loadDatailGraph(showType) {
	var loadUrl = "/lsv2016/ajax/detail/detailGraphData_ajax.jsp?modelno="+modelno+"&minprice="+minprice+"&showType="+showType;
	
	//alert("loadUrl="+loadUrl);
	//plugins.pointLabels._labels = [];

	$.getJSON(loadUrl, null, function(data) {
		dataList = new Array();

		var jsonObj = data["graphDataList"];
		var graphDataCnt = data["graphDataCnt"];
		var graphShowType = data["graphShowType"];
		var showGraphCnt = data["showGraphCnt"];
		var showMaxPrice = data["showMaxPrice"];
		var showMinPrice = data["showMinPrice"];
		var intShowGraphCnt = 0;
		var intGraphDataCnt = 0;
		var graphTermBtnsSpanObj = $("#graphTermBtnsSpan");
		var intShowMaxPrice = 0;
		var intShowMinPrice = 0;

		try {
			intGraphDataCnt = parseInt(graphDataCnt);
		} catch(e) {}
		try {
			intShowMaxPrice = parseInt(showMaxPrice);
		} catch(e) {}
		try {
			intShowMinPrice = parseInt(showMinPrice);
		} catch(e) {}

		// 12주 이하의 데이터일때는 개월표시를 하지않음
		if(tot_graphcnt<12) {
			graphTermBtnsSpanObj.css("display", "none");
		} else {
			/*
			var graphQuestionAObj = $("#graphQuestionA");
			var zumvip_wrapObj = $(".zumvip_wrap");
			var topPos = graphQuestionAObj.offset().top - zumvip_wrapObj.offset().top - 34;

			graphTermBtnsSpanObj.css("top", topPos+"px");
			*/
			graphTermBtnsSpanObj.css("display", "block");
		}

		xGridLineCnt = 0;

		try {
			intShowGraphCnt = parseInt(showGraphCnt);
		} catch(e) {}
		//console.log("intShowGraphCnt="+intShowGraphCnt);

		if(graphShowType=="1") {
			maxGraphTick = 5;
		} else {
			maxGraphTick = 7;
		}

		var detailGraphShowDivObj = $("#detailGraphShowDiv");
		var graphLeftWhiteLineDivObj = $("#graphLeftWhiteLineDiv");

		//console.log("maxGraphTick="+maxGraphTick)

		detailGraphShowDivObj.css("padding-right", "30px");

		// 현재 보이는 그래프의 사이즈를 조절
		if(intShowGraphCnt<=maxGraphTick) {
			nowGraphWidth = intShowGraphCnt*(graphBaseSize/maxGraphTick);
			if(intShowGraphCnt==1) {
				nowGraphWidth += 57;

				// 현재 데이터 밖에 없을 경우, 문구 띄워줌
				$("#detailGraphNoDataTextDiv").css("display", "block");
				$("#topGraphLineDiv").css("width",  nowGraphWidth+"px");
				$("#bottomGraphLineDiv").css("width",  nowGraphWidth+"px");
			}
			//console.log("nowGraphWidth="+nowGraphWidth)
			detailGraphShowDivObj.css("width", nowGraphWidth+"px");
			detailGraphShowDivObj.css("margin-left", (graphBaseSize-nowGraphWidth)+"px");
			graphLeftWhiteLineDivObj.css("margin-left", (graphBaseSize-nowGraphWidth)+"px");
			//graphLeftWhiteLineDivObj.css("display", "none");
		} else {
			detailGraphShowDivObj.css("width", graphBaseSize+"px");
			detailGraphShowDivObj.css("margin-left", "0px");
			graphLeftWhiteLineDivObj.css("margin-left", "0px");
		}
		$("#bottomGraphLineDiv").css("width", "0px");

		// 개월 선택 표시
		//document.graphTermForm.graphTerm.value = graphShowType;
		if(document.getElementById("graphTerm"+graphShowType)) {
			document.getElementById("graphTerm"+graphShowType).checked = true;

			if(oldGraphShowType.length>0) {
				$("#graphTermSpan"+oldGraphShowType).css("font-weight", "normal");
			}
			//$("#graphTermSpan"+graphShowType).css("font-weight", "bold");

			oldGraphShowType = graphShowType;
		}

		//console.log("intShowMaxPrice1="+intShowMaxPrice+", intShowMinPrice1="+intShowMinPrice)

		// 상단 하단 여백을 위한 가격 범위
		var priceGap = (intShowMaxPrice-intShowMinPrice) / 4;
		intShowMaxPrice = intShowMaxPrice + priceGap;
		intShowMinPrice = intShowMinPrice - priceGap;
		if(intShowMaxPrice==intShowMinPrice) {
			intShowMaxPrice += intShowMaxPrice/4;
			intShowMinPrice -= intShowMinPrice/4;
		}

		//console.log("intShowMaxPrice2="+intShowMaxPrice+", intShowMinPrice2="+intShowMinPrice)

		var intShowCnt = 0;
		if(jsonObj) {
			$.each(jsonObj, function(indexI, listObj) {
				var itemAry = new Array();
				var exItemAry = new Array();

				var date = listObj["date"];
				var price = parseInt(listObj["price"]);
				var label = listObj["label"];
				var labelLoc = listObj["labelLoc"];
				var labelColor = listObj["labelColor"];
				var labelBackColor = listObj["labelBackColor"];
				var labelFontFamily = listObj["labelFontFamily"];
				var labelFontSize = listObj["labelFontSize"];
				var labelLetterSpacing = listObj["labelLetterSpacing"];
				var pointColor = listObj["pointColor"];
				/*
				if(console) {
					console.log("label"+indexI+" = "+label)
				}
				*/

				var tempDate = "";

				if(date.indexOf("-")>-1) {
					var dateAry = date.split("-");
					var tempDate = dateAry[0];
					var weekNum = 0;
					try {
						weekNum = parseInt(dateAry[1]);
					} catch(e) {}
					/*
					var dayNum = (weekNum-1) * 7 + 1;
					var dayStr = "";
					if(dayNum<10) dayStr = "0" + dayNum;
					else dayStr = "" + dayNum;
					tempDate = tempDate + dayStr;
					*/

					tempDate = get_WeekSunDayDate(date);
				} else {
					tempDate = date;
				}

				//console.log("date="+date+", tempDate="+tempDate)

				itemAry[0] = " "+tempDate + " ";
				itemAry[1] = price;
				if(label.length>0) {
					itemAry[2] = label;
				} else {
					itemAry[2] = null;
				}
				// 100만이 넘어가면 글자사이 간격을 줄임
				//if(price>=10000000) {
				//	labelLetterSpacing = "0px";
				//	labelFontFamily = "돋움";
				//}

				exItemAry[0] = pointColor; // 포인트마커의 색깔
				exItemAry[1] = labelLoc; // 포인트의 레이블 위치
				exItemAry[2] = labelColor; // 포인트 레이블의 색깔
				exItemAry[3] = labelBackColor; // 포인트 레이블의 배경색
				exItemAry[4] = labelFontFamily; // 포인트 레이블의 폰트
				exItemAry[5] = labelFontSize; // 포인트 레이블의 폰트 크기
				exItemAry[6] = labelLetterSpacing; // 포인트 레이블의 글자 사이 간격
				// 레이블이 있는 데이터의 가격을 저장, 레이블이 있는 포인트는 툴팁이 나오지 않게 하기 위해
				if(labelLoc.length>0) {
					exItemAry[7] = "N";
				} else {
					exItemAry[7] = "Y";
				}
//				console.log("indexI="+indexI+",labelLoc="+labelLoc+", exItemAry[7]="+exItemAry[7] );

				dataList[indexI] = itemAry;
				exDataList[indexI] = exItemAry;

				intShowCnt++;
				
				//(현재) 포인트레이블, 마커 색상변경
				if(indexI==(jsonObj.length-1)){
					exItemAry[0] = "#333333";
					exItemAry[2] = "#333333";
				}
			});

			// height:130px;width:470px;
			var nowLabelDivObj = $("#nowLabelDiv");
			var dGap = 20;
			var oneWidth = (<%=(rootSize-18)%> - dGap) / intShowCnt;
			//var labelX = (oneWidth-1) * intShowCnt - nowLabelDivObj.width()/2;
			//var labelX = oneWidth * (intShowCnt - 1) + 10 + oneWidth / 2 - nowLabelDivObj.width() / 2;
			var labelY = 125;
			var labelXGap = 0;
			if(graphShowType=="1") labelXGap = 20;
			var rightsize  = widthsize-((intShowCnt)*oneWidth);
			if(intShowCnt==1) {
				nowLabelDivObj.css("width", "80px");
				rightsize = rightsize +18;
			}else if(intShowCnt>=6) {
					nowLabelDivObj.css("width", "60px");
				//nowLabelDivObj.css("right", (labelXGap+20)+"px");
			}else {
				nowLabelDivObj.css("width", "70px");
				//nowLabelDivObj.css("right", (labelXGap+13)+"px");
			} 
				//nowLabelDivObj.css("width", (oneWidth-1)+"px");
			var topGraphLineDivWidth = $('#topGraphLineDiv').width();
			nowLabelDivObj.css("right", rightsize+"px");
			//}

			//nowLabelDivObj.css("margin-left", labelX);
			
			nowLabelDivObj.css("margin-top", labelY);

			var detailGraphDivObj = $("#detailGraphDiv .graphbox");
			var detailGraphNoDivObj = $("#detailGraphDiv .noinfo");
			
			var userAgent = navigator.userAgent;
			var ypaddingInt = 5;
			//if(userAgent.indexOf("Mozilla/4.0")>-1) {
			//	ypaddingInt = -1;
			//}

			if(dataList.length>0) {
				$(top.document).find(".sbox img").css("display", "none");
				detailGraphDivObj.css("display", "block");
				detailGraphNoDivObj.css("display", "none");

				var plot1 = $.jqplot('detailGraphShowDiv', [dataList], {
//					title:'가격추세',
					legendDefaults: {
						background: 'background-color:#ffffff;'
					},
					seriesDefaults: {
						showMarker: true,
						pointLabels:{
							show: true,
							location: 's',
							ypadding: ypaddingInt
						}
					},
					axesDefaults: {
						tickRenderer: $.jqplot.CanvasAxisTickRenderer ,
						tickOptions: {
							angle: 0,
							fontSize: '10pt'
						}
					},
			        grid: {
			            drawBorder: false,
			            shadow: false,
			            gridLineColor: '#ececec',
			            background: 'white'
			        },
					axes:{
						xaxis:{
							renderer: $.jqplot.CategoryAxisRenderer,
							tickRenderer: $.jqplot.CanvasAxisTickRenderer,
							tickOptions: {
								angle: 0,
								fontSize: '11px',
								//fontFamily: 'Georgia',
								//fontFamily: '궁서',
								//fontFamily: 'Calibri',
								fontFamily: '돋움',
								//fontFamily: '맑은 고딕',
								textColor: '#777777',
								showGridline: false
							}
						},
						yaxis:{
							min: intShowMinPrice,
			                max: intShowMaxPrice,
							show: false,
							showTicks: false,
							autoscale: true,
							size: 0,
							borderWidth: 0,
							borderColor: '#ffffff',
							//tickSpacing: 50,
							//ticks: [[10, '11'],[200, '22'],[500, '33'],[1400, '44']],
							tickRenderer: $.jqplot.CanvasAxisTickRenderer,
							tickOptions: {
								showGridline: true
							}
						}
					},
					highlighter: {
						show: true,
						sizeAdjust: 7.5,
						tooltipAxes: 'm', // m 타입은 콤마를 붙이고 원까지 자동으로 넣어줌
//					    formatString: '%s원',
					    tooltipLocation: 'n'
					},
					cursor: {
						show: false
					},
					series:[
						{
							lineWidth: 0.2,
					        shadow: false,
					        color: '#000000',
							//fillColor: '#cccccc',
							markerOptions: {
								style: "filledCircle",
								//color: '#00ff00',
								size: 5,
					            shadow: false
							}
						}
						/*
						 // 애니메이션 적용
						,{
			                rendererOptions: {
			                    animation: {
			                        speed: 3000
			                    }
			                }
			            }
			            */

					]

				});

				// 좌측의 모자란 부분의 그리드 라인 수동으로 그리기
				var graphBoxDivObj = $("#graphBoxDiv");
				var topGraphLineDivObj = $("#topGraphLineDiv");
				var bottomGraphLineDivObj = $("#bottomGraphLineDiv");
				var tbLineGap = bottomGraphLineDivObj.offset().top - topGraphLineDivObj.offset().top;

				var lineNum = 0;
				var maxLineNum = xGridLineCnt - 2;
				var maxHeight ="";
				var oneTbLineGap = tbLineGap / (maxLineNum+1);

				var gridInnerLineAry = $("#graphBoxDiv").children(".gridInnerLine");
				if(gridInnerLineAry && gridInnerLineAry.length>0) {
					for(var i=0; i<gridInnerLineAry.length; i++) {
						var gridInnerLineItem = $(gridInnerLineAry[i]);
						gridInnerLineItem.remove();
					}
				}

				var gridLineWidth = graphBaseSize - nowGraphWidth + 10;
				//console.log("gridLineWidth="+gridLineWidth)
				for(var i=0; i<maxLineNum; i++) {
					var lineDivItem = "";
					var posLeft = 0;
					var posTop = 10 + (i+1) * oneTbLineGap;

					lineDivItem += "<div class=\"gridInnerLine\" style=\"position:absolute;top:"+posTop+"px;left:"+posLeft+"px;height:1px;width:"+gridLineWidth+"px;background-color:#ececec;z-index:102\"></div>";

					graphBoxDivObj.append(lineDivItem);
				}

//				console.log("xGridLineCnt="+xGridLineCnt);
			}

		}
	});
}


//특정 날짜의 몇째주 정보에서 일요일 날짜로 변환
function get_WeekSunDayDate(dateStr) {
	var year = dateStr.substring(0, 4);
	var month = dateStr.substring(4, 6);
	var weekCnt = "";
	var intWeekCnt = 0;
	var intMonth = 0;
	var intDay = 0;

//	console.log("dateStr="+dateStr);

	var dateStrAry = dateStr.split("-");
	weekCnt = dateStrAry[1];

	try {
		intWeekCnt = parseInt(weekCnt);
	} catch(e) {}

	try {
		if(month=="08") {
			intMonth = 8;
		} else if(month=="09") {
			intMonth = 9;
		} else {
			intMonth = parseInt(month);
		}
	} catch(e) {}

	var sunDayCnt = 0;
	for(var i=1; i<=31; i++) {
		var vn_day1 = new Date( year, month-1, i);
		var dayOfWeek = vn_day1.getDay(); //현재 요일을 구한다.( 0:일요일, 1:월요일, 2:화요일, 3:수요일, 4:목요일, 5:금요일, 6:토요일 )
		if(dayOfWeek==0) sunDayCnt++;

		if(intWeekCnt==sunDayCnt) {
			intDay = i;
			break;
		}
	}


	var rtnDate = intMonth+"."+intDay;

	return rtnDate;
}

//$(document).ready(function(){
//	loadDefaultDetailGraph();
//});

</script>
</body>
</html>
