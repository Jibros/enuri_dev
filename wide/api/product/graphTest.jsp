<%@ page contentType="text/html; charset=utf-8" %>\
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>\

<%
    String strModelno = ChkNull.chkStr(request.getParameter("modelno"),"");
    String strMinprice = ChkNull.chkStr(request.getParameter("minprice"),"");
%>



<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8"/>
	<meta http-equiv="x-ua-compatible" content="ie=edge"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>	
	<meta property="og:title" content="에누리 가격비교"/>
	<meta property="og:description" content="에누리 모바일 가격비교"/>
	<meta property="og:image" content="http://img.enuri.info/images/mobilefirst/logo_enuri.png"/>
	<meta name="format-detection" content="telephone=no"/>	
	<script type="text/javascript" src="/mobilefirst/js/lib/jquery-2.1.3.min.js"></script>
    <script type="text/javascript" src="/js/highcharts.js?v=20180123"></script>	
    <link rel="stylesheet" href="/css/default.css" type="text/css">
   <%--  <link rel="stylesheet" href="/css/vip.css?v=20190306" type="text/css"> --%>
    <style>
        /* .prdcgraph {margin-top:40px;} */
        .prdcgraph__head {/* overflow:hidden; */position:relative;height:14px; padding-top:1px; /* margin-bottom:20px; */margin-bottom:9px;}
        .prdcgraph__head:after {content:"";display:table;clear:both;}
        .prdcgraph--tit {float:left;position:relative;top:-1px;width:62px;margin-left:0;font-weight:500;font-size:14px;color:#333;line-height:1;vertical-align:top;}
        .prdcgraph--filter {float:right;position:relative;list-style:none;}
        .prdcgraph--filter li {float:left;margin-right:15px;}
        .prdcgraph--filter li:last-child {margin-right:0;}
        .prdcgraph--filter li .custom--rdobox {display:inline-block;position:relative;height:12px;padding-left:15px;font-size:12px;color:#666;line-height:12px;letter-spacing:-0.5px;vertical-align:top;cursor:pointer;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;}
        .prdcgraph--filter li .custom--rdobox .checkmark {position:absolute;top:1px;left:0;height:12px;width:12px;background-position:-40px -650px;}
        .prdcgraph--filter li .custom--rdobox.checked {color:#333;}
        .prdcgraph--filter li .custom--rdobox.checked .checkmark {background-position:-55px -650px;}
        .monthgraph {width:auto;min-height:120px;}
        .monthgraph img {width:100%;height:100%;}
        .nostate {width:auto;min-height:120px;background-color:#F9F9F9}
        .nostate .monthgraph__nodata {display:block;font-size:11px;color:#999;text-align:center;letter-spacing:-.5px;line-height:120px;vertical-align:middle;}
        .nostate .monthgraph__ie8 {display:block;font-size:11px;color:#999;text-align:center;letter-spacing:-.5px;line-height:120px;vertical-align:middle;}
        .vsprite {display:block;font-size:0;text-indent:-9999px;background:url(http://img.enuri.info/images/home/icon_pack_vip_v2.png) no-repeat;}
        .prdcdetail__side{font-family:"Noto Sans KR","Malgun Gothic","Segoe UI",Verdana,gulim,dotum,"Helvetica",Helvetica,"tahoma",tahoma,sans-serif;font-weight:400;}
    </style>
</head>
<body>
    <div class="prdcdetail__side">
        <div class="sidebox">
            <div class="prdcgraph">
                <div class="prdcgraph__head"  id="graphTermBtnsSpan" style="display:none;">
                    <ul class="prdcgraph--filter">
                        <li class="chk__month1">
                            <!-- 선택시 클래스 추가, checked -->
                            <p class="custom--rdobox" gtype="1">1개월
                                <span class="vsprite checkmark"></span>
                            </p>
                        </li>
                        <li class="chk__month3">
                            <p class="custom--rdobox checked" gtype="3">3개월
                                <span class="vsprite checkmark"></span>
                            </p>
                        </li>
                        <li class="chk__month6">
                            <p class="custom--rdobox" gtype="6">6개월
                                <span class="vsprite checkmark"></span>
                            </p>
                        </li>
                    </ul>
                </div>
                <div class="monthgraph"  id="vip_graph_container" ></div>
            </div>
        </div>
    </div>
    
    
</body>
<script>
$(document).ready(function(){
    loadDatailGraph(3);
});
var gModelno = '<%=strModelno%>';
var lngMinprice = '<%=strMinprice%>';
var maxGraphTick = 2;
var varIe8Chk = "N";

function loadDatailGraph(showType) {
var test = "1,2,3,4,5";
var testData = test.split(",");
console.log(testData);
var chart = Highcharts.chart('vip_graph_container', {
    chart: {
        width: $(window).outerWidth(),
        height: $(window).outerHeight(),
        backgroundColor: '#f9f9f9',
        type: 'spline',
        marginRight: 10
    },
    credits: { // 왼쪽 하단                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                라벨 제거
        enabled: false
    },
    title: {
        text: null
    },
    subtitle: {
        text: ''
    },
    xAxis: {
        tickWidth: 0,
        categories: ["2020-01-01","2020-01-02"], // 하단 달짜 지정
        labels: {
            step: 1,
            style: {
                tickPixelInterval: 50,
                fontSize: "10px"
            }
        }
    },
    plotOptions: {
        series: {
            animation: {
                duration: 2000
            },
            marker: { // 점
                enabled: true,
                radius: 3

            }
        },
        spline : {
            color : '#cccccc'
        }
    },
    yAxis: {
        title: null,
        opposite: true,
        offset: 10,
        gridLineWidth: 0.5
    },
    tooltip: {
        style: {
            fontSize: "10px",
            fontWeight: ''
        },
    },
    series: [{
        name: '',
        data: ["1","2"],
        lineWidth: 1,
       
    }],

}); // End : Highcharts.chart
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
    } catch (e) {}

    try {
        if (month == "08") {
            intMonth = 8;
        } else if (month == "09") {
            intMonth = 9;
        } else {
            intMonth = parseInt(month);
        }
    } catch (e) {}

    var sunDayCnt = 0;
    for (var i = 1; i <= 31; i++) {
        var vn_day1 = new Date(year, month - 1, i);
        var dayOfWeek = vn_day1.getDay(); //현재 요일을 구한다.( 0:일요일, 1:월요일, 2:화요일, 3:수요일, 4:목요일, 5:금요일, 6:토요일 )
        if (dayOfWeek == 0) sunDayCnt++;

        if (intWeekCnt == sunDayCnt) {
            intDay = i;
            break;
        }
    }
    var rtnDate = intMonth + "." + intDay;

    return rtnDate;
}

//콤마 옵션
function commaNum(num) {
    var len, point, str;

    num = num + "";
    point = num.length % 3;
    len = num.length;

    str = num.substring(0, point);
    while (point < len) {
        if (str != "") str += ",";
        str += num.substring(point, point + 3);
        point += 3;
    }
    return str;
}
</script>
</html>




