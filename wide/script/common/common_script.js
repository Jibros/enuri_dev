var blIE = false; // 익스 인지
var agent = navigator.userAgent.toLowerCase();
if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
	blIE = true;
}

// position: fixed 사용시 ie 떨림 현상 방지
if( navigator.userAgent.match(/Trident\/7\./) ){
	$('body').on("mousewheel", function(){
		event.preventDefault();
		var wheelDelta = event.wheelDelta,
		currentScrollPosition = window.pageYOffset;
		window.scrollTo(0, currentScrollPosition - wheelDelta);
	});
	$('body').keydown(function(e){
	//	e.preventDefault();
		var currentScrollPosition = window.pageYOffset;
		switch (e.which){
			case 38: //up
				window.scrollTo(0, currentScrollPosition - 120);
				break;
			case 40: //down
				window.scrollTo(0, currentScrollPosition + 120);
				break;
			default: return;
		}
	});
}

// 로그인 여부 체크
function Islogin() {
	var cName = "LSTATUS";
	var s = document.cookie.indexOf(cName +'=');

	if(s!=-1) {
		s += cName.length + 1;
		e = document.cookie.indexOf(';',s);

		if(e==-1) {
			e = document.cookie.length;
		}

		if(unescape(document.cookie.substring(s,e))=="Y") {
			return true;
		} else {
			return false;
		}
	} else {
		return false;
	}
}

//상품비교 레이어
function prodCompLayer(){
	var prodArr = getCookie("compProdList");
	console.log(prodArr);

	if(prodArr!=null && prodArr.length>0) {
		$.ajax({
			type : "get", 
			url : "/lsv2016/ajax/getCompareProdList_ajax.jsp", 
			data : {"goodsNumList" : prodArr}, 
			dataType : "json", 
			success : function(result) {
				console.log(result);
				var prodHtml = "";
				var pordCnt = 0;
				
				prodHtml += "<div class=\"lay-comm__inner\">";
				prodHtml +=	"	<div class=\"compare-prod__wrap\">";
				prodHtml += "		<ul class=\"compare-prod__list\">";
				if(result.goodsList && result.goodsList.length > 0){
					pordCnt = result.goodsList.length;
					
					result.goodsList.forEach(function (v,i){
						prodHtml += "	<li prodno=\""+v.prodNo+"\" class=\"compare-prod__item\">";
						prodHtml += "		<input type=\"checkbox\" id=\"chkCP_0"+i+"\" class=\"input--checkbox-item\"><label for=\"chkCP_0"+i+"\"></label>";
						prodHtml += "		<a href=\"#\">";
						prodHtml += "			<div class=\"compare-prod__thumb\">";
						// prodHtml += "				<span class=\"compare-prod__tag--ad\">AD</span>";
						prodHtml += "				<img src=\""+v.smallImageUrl+"\" alt=\"\">";
						prodHtml += "			</div>";
						prodHtml += "			<div class=\"compare-prod__info\">";
						prodHtml += "				<span class=\"compare-prod__name\">"+v.modelnm+"</span>";
						prodHtml += "				<span class=\"compare-prod__price\"><em>"+v.minprice3.format()+"</em>원</span>";
						prodHtml += "			</div>";
						prodHtml += "		</a>";
						prodHtml += "	</li>";
					});
				}
				prodHtml += "		</ul>";
				prodHtml += "	</div>";
				prodHtml += "</div>";

				$('#compareProdBoxDiv .lay-comm--head .compCntSpan').text("("+pordCnt+")");
				$('#compareProdBoxDiv .lay-comm--body').html(prodHtml);
				
				
				
				$('#compareProdBoxDiv').addClass("is--fold");
				$('#compareProdBoxDiv').show();
			}
		});
	} else {
	}
}

//쿠키 읽어오기
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

// 로고이미지 액박 시 텍스트 처리
function logoImgNotFound(_this) {
	var shopName = $(_this).attr("alt");
	$(_this).parent().text(shopName);
}

// 로고이미지 액박 시 해당 아이템 제거 처리
function logoImgNotFoundRemoveItem(_this) {
	if($(_this).closest("li").length>0) {
		$(_this).closest("li").remove();
	}
}

// desc TBL_SEARCH_KEYWORD_LOG; // procType=1
var logKeywordCheck = "";
function insertSearchKeywordLog(keyword) {
	if(logKeywordCheck==keyword) return;

	logKeywordCheck = keyword;

	var sr_type = "";
	if(listType=="list") sr_type = "L";
	if(listType=="search") sr_type = "S";

	var param = {
		"random_seq" : random_seq,
		"procType" : "1", 
		"keyword" : keyword, 
		"sr_type" : sr_type 
	}

	$.ajax({
		type: "GET",
		url: "/lsv2016/ajax/insertSearchListLog_ajax.jsp",
		data: param
	});
}

//desc TBL_SEARCH_KEYWORD_VIEW_LOG; // procType=2
//SR_TYPE CHAR(1) S' : SRP, 'L' : LP
//VIEW_TYPE CHAR(1) 1' : 가격비교, '2' : 일반상품, '3' : 소셜, '4' : 백화점
//rank : 순위
function insertSearchKeywordViewLog_Wide(view_type, modelno, pl_no, rank) {

	var sr_type = "";
	var logKeyword = "";
	if(listType=="list") {
		sr_type = "L";
		logKeyword = param_inKeyword;
		if(Synonym_From == "search" && Synonym_Keyword.length > 0) {
			logKeyword = Synonym_Keyword;
		}
	} else if(listType=="search") {
		sr_type = "S";
		logKeyword = param_keyword;
	}
	
	if(logKeyword.length>0) {
		var param = {
			"random_seq" : random_seq,
			"procType" : "2", 
			"keyword" : logKeyword, 
			"sr_type" : sr_type, 
			"view_type" : view_type, 
			"modelno" : modelno, 
			"pl_no" : pl_no,
			"rank" : rank
		}
		
		$.ajax({
			type: "GET",
			url: "/lsv2016/ajax/insertSearchListLog_ajax.jsp",
			data: param
		});
	}
}

// SMS보내가
function sendDetailSms(obj, part, modelno, modelnm) {
    var thisObj = $(obj);
	var myphone = thisObj.siblings(".sendsms__form--inp").val();
	var rurl = "";
    var title = "";

	if(myphone=="") {
		alert("휴대폰 번호가 입력되지않았습니다.");
		return;
	}

	var rgEx = /(01[016789])(\d{4}|\d{3})\d{4}$/g;
	var chkFlg = rgEx.test(myphone);

	if(!chkFlg) {
		alert("잘못된 형식의 휴대폰 번호입니다.");
		return;
	}

    if(part == "detail"){
        rurl = encodeURIComponent("http://m.enuri.com/m/vip.jsp?_qr=y&modelno="+modelno+"&hoticon=-1");
        title = encodeURIComponent(modelnm);
    }else if(part == "enuri"){
        rurl = "http://goo.gl/O8CUnn";
        title = "에누리가격비교";
    }

	if(rurl!="") {
		rurl = rurl.replace(/\?/ig, "--***--");
		rurl = rurl.replace(/\&/ig, "--**--");
		document.getElementById("hFrame").src = "/common/jsp/Ajax_ListHeader_Sms_Proc.jsp?part="+part+"&rurl="+rurl+"&phoneno="+myphone+"&title="+title;
        thisObj.siblings(".sendsms__form--inp").val("");
	} else {
		alert("주소를 읽어오지 못했습니다.");
	}
}

// 모델에서 휴대폰 아이콘 클릭시 qr코드를 생성함
function setQrCodeImg(modelno) {
	var mobileSendProdDivObj = $(".lay-mobile-min");
	$(".ph--qr").hide();
    mobileSendProdDivObj.find(".lay-mobile__qr img").attr("src","/view/qrcode/qr_model_"+modelno+".png?v="+(new Date()).getTime());
    
	mobileSendProdDivObj.find(".lay-mobile__qr img").on("error",function(){
        mobileSendProdDivObj.find(".lay-mobile__qr img").unbind("error");
		makeQr(modelno);
    });
}

function makeQr(modelno){
	var mobileSendProdDivObj = $(".lay-mobile-min");
	var newDate = new Date();
	var qrName = newDate.getTime();
    var aUrl = "/view/make_qr2.jsp";
    var param = "";

    param += "&url="+encodeURIComponent("http://m.enuri.com/m/vip.jsp?_qr=y&modelno="+modelno+"&hoticon=-1");
    param = param + "&t=qr_model_"+modelno;
	$(".ph--qr").show();
	mobileSendProdDivObj.find(".lay-mobile__qr img").hide();
    $.ajax({
        type : "get", 
        url : aUrl, 
        async: true, 
        data : param, 
        dataType : "json", 
        success: function(json) {
            setTimeout(function() {
                mobileSendProdDivObj.find(".lay-mobile__qr img").attr("src","/view/qrcode/qr_model_"+modelno+".png?v="+qrName);
				$(".ph--qr").hide();
				mobileSendProdDivObj.find(".lay-mobile__qr img").show();
			},5000);
        },
        error: function (xhr, ajaxOptions, thrownError) {
            //alert(xhr.status);
            //alert(thrownError);
        }
    });
}
