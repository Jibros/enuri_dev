var spin_opts = {
	lines: 5, // The number of lines to draw
	length: 30, // The length of each line
	width: 4, // The line thickness
	radius: 10, // The radius of the inner circle
	corners: 1, // Corner roundness (0..1)
	rotate: 0, // The rotation offset
	color: '#000', // #rgb or #rrggbb
	speed: 1, // Rounds per second
	trail: 60, // Afterglow percentage
	shadow: false, // Whether to render a shadow
	hwaccel: false, // Whether to use hardware acceleration
	className: 'spinner', // The CSS class to assign to the spinner
	zIndex: 2e9, // The z-index (defaults to 2000000000)
	top: 'auto', // Top position relative to parent in px
	left: 'auto' // Left position relative to parent in px
};

$.fn.spin = function(spin_opts) {
	this.each(function() {
		var $this = $(this),
			data = $this.data();

		if (data.spinner) {
			data.spinner.stop();
			delete data.spinner;
		}
		if (spin_opts !== false) {
			data.spinner = new Spinner($.extend({color: $this.css('color')}, spin_opts)).spin(this);
		}
	});
	return this;
};

String.prototype.isnumber = function() {  if (this.search(/[^0-9]/) == -1)     return true;  else     return false;};
String.prototype.DeNumberFormat = function() {	var str = this.replace(/,/g,"");	return str;};
String.prototype.NumberFormat = function() {
	var str = this.replace(/,/g,"");
	var strLength = str.length;

	if (strLength<=3) return str;

    var strOutput = "";
    var mod = 3 - (strLength % 3);
	var i;

    for (i=0; i<strLength; i++)
	{
		strOutput+=str.charAt(i);
        if (i < strLength - 1)
		{
			mod++;
            if ((mod % 3) == 0)
			{
				strOutput +=",";
                mod = 0;
			}
		}
	}
	return strOutput;
};
//검색어 특수 문자 제거
function schKeyword(schWrd){
	var schWord;
	schWord = schWrd;
	$keyword = schWord;
	schWord = replace2(schWord,"'");
	schWord = replace2(schWord,"\\");
	schWord = replace2(schWord,"^");
	//schWord = replace2(schWord,"&");
	schWord = replace2(schWord,"~");
	schWord = replace2(schWord,"!");
	schWord = replace2(schWord,"@");
	schWord = replace2(schWord,"$");
	schWord = replace2(schWord,"%");
	schWord = replace2(schWord,"*");
	schWord = replace2(schWord,"+");
	schWord = replace2(schWord,"=");
	schWord = replace2(schWord,"{");
	schWord = replace2(schWord,"}");
	schWord = replace2(schWord,"[");
	schWord = replace2(schWord,"]");
	//schWord = replace2(schWord,":");
	schWord = replace2(schWord,";");
	schWord = replace2(schWord,"/");
	schWord = replace2(schWord,"<");
	schWord = replace2(schWord,">");
	schWord = replace2(schWord,",");
	schWord = replace2(schWord,"?");
	schWord = replace2(schWord,"(");
	schWord = replace2(schWord,")");
	schWord = replace2(schWord,"'");
	schWord = replace2(schWord,"_");
	schWord = replace2(schWord,"-");
	schWord = replace2(schWord,"`");
	schWord = replace2(schWord,"|");
    schWord = jQuery.trim(schWord);
    if (schWord == "상품 검색" || schWord == "검색어 입력" ){
    	schWord = "";
    }
	function replace2(src, delWrd){
		var newSrc = "";
		for(var i=0;i<src.length;i++){
			if(src.charAt(i) == delWrd) {
				newSrc = newSrc + " ";
			}else{
				newSrc = newSrc + src.charAt(i);
			}
		}
		return newSrc;
	}
    return schWord;
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
function insertLog(logNum){
	$.ajax({
		type: "GET",
		url: "/view/Loginsert_2010.jsp",
		data: "kind="+logNum,
		success: function(result){
		}
	});
}
function insertLogCate(logNum,cate){
	$.ajax({
		type: "GET",
		url: "/view/Loginsert.jsp",
		data: "kind="+logNum+"&cate="+cate,
		success: function(result){
		}
	});
}
function CmdSpinLoading(){
	$("#cm_loading").css("top",$(window).height()/2);
	$("#cm_loading").css("left",$(window).width()/2);
	$("#cm_loading").fadeIn("fast");
	$("#cm_loading").spin();
}
function CmdSetCookie(param_gubun, param_modelno){
	var param = "type="+param_gubun+"&modelnos="+param_modelno;
	$.ajax({
		type: "POST",
		url: "/mobilefirst/include/m4_cookie.jsp",
		data: param,
		success: function(result){
		}
	});
}
function IsLogin() {
	var cName = "LSTATUS";
	var s = document.cookie.indexOf(cName +'=');
	if (s != -1){
		s += cName.length + 1;
		e = document.cookie.indexOf(';',s);
		if (e == -1){
			e = document.cookie.length;
		}
		if( unescape(document.cookie.substring(s,e))=="Y"){
			try {
				if(window.android){
					if(vCheckfirst){
						window.android.isLogin("true");
						vCheckfirst = false;
					}
				}
			} catch(e) {}
			return true;
		}else{
			try {
				if(window.android){
					window.android.isLogin("false");
				}
			} catch(e) {}
			return false;
		}
	}else{
		try {
			if(window.android){
				window.android.isLogin("false");
			}
		} catch(e) {}
		return false;
	}
}
// 로그인 링크
function goLogin() {
	document.location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent(document.location.href);
}
function goLogin2() {
	document.location.href = "/mobilefirst/login/login.jsp?backUrl="+encodeURIComponent("https://www.enuri.com/my/my_enuri_m.jsp");
}

// 성인 인증 로그인 링크
function goALogin() {
	document.location.href = "/mobilefirst/login/adult.jsp?backUrl="+encodeURIComponent(document.location.href);
}
// 회원가입 링크
function goJoin() {
	document.location.href = "/mobilefirst/login/join.jsp?backUrl="+encodeURIComponent(document.location.href);
}
// 회원수정 링크
function goModify() {
	document.location.href = "/mobilefirst/login/modify.jsp?backUrl="+encodeURIComponent(document.location.href);
}
function checkNumberFormat(priceObj){
	var varInputPrice = priceObj.value.DeNumberFormat();
	var bAllZero = true;
	for (i=0;i<varInputPrice.length;i++){
		if (varInputPrice.charAt(i) != "0"){
			bAllZero = false;
		}
	}
	if (bAllZero){
		priceObj.value = "";
	}else{
		if (varInputPrice != "0"){
			var varOutputPrice = "";
			var bZero = false;
			for (i=0;i<varInputPrice.length;i++){
				if (varInputPrice.charAt(i) == "0"){
					if (bZero){						varOutputPrice += varInputPrice.charAt(i);					}
				}else{					bZero = true;					varOutputPrice += varInputPrice.charAt(i);				}
			}
			priceObj.value = varOutputPrice.NumberFormat();
		}
	}
}
function inputPriceCheck(){
	var varReturn = true;
	var startPrice = $("#srhPrice").val().trim();
	var endPrice = $("#srhPrice2").val().trim();

	if (startPrice.length == 0 ){
		varReturn = false;
	}
	if (endPrice.length == 0 ){
		varReturn = false;
	}
	startPrice = startPrice.DeNumberFormat();
	endPrice = endPrice.DeNumberFormat();

	if (!startPrice.isnumber()){
		varReturn = false;
	}
	if (!endPrice.isnumber()){
		varReturn = false;
	}
	if (parseInt(startPrice) >= parseInt(endPrice)){
		varReturn = false;
	}

	if (varReturn){
		inputPriceCheck._f_start = $("#srhPrice").val().trim();
		inputPriceCheck._f_end = $("#srhPrice2").val().trim();
	}else{
		inputPriceCheck._f_start = "";
		inputPriceCheck._f_end = "";
	}

}

function fnGetCookie2010( name ){
	var nameOfCookie = name + "=";
	var x = 0;
	while ( x <= document.cookie.length ){
		var y = (x+nameOfCookie.length);
		if ( document.cookie.substring( x, y ) == nameOfCookie ) {
			if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
				endOfCookie = document.cookie.length;
			return unescape( document.cookie.substring( y, endOfCookie ) );
		}
		x = document.cookie.indexOf( " ", x ) + 1;
		if ( x == 0 )
		break;
	}
   return "";
}
function replaceAll(str, searchStr, replaceStr) {    return str.split(searchStr).join(replaceStr);}
//+ Jonas Raoni Soares Silva
//@ http://jsfromhell.com/array/shuffle [v1.0]
function shuffle(o){ //v1.0
    for(var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
    return o;
};
//preOpen이 없음
function preOpen(objName, url) {
	if(url.indexOf("Index.jsp")>-1) {
		window.open("/Index.jsp?from=mo");
	} else {
		window.open(url);
	}
}
function setCookie(c_name, value, exdays) {
    var exdate=new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
    c_value += "; domain=" + document.domain;
    c_value += "; path=/ ";
    document.cookie=c_name + "=" + c_value;
}
//쿠키 날짜 대로
function fnEverSetCookie(name, value, expiredays) {
    var todayDate = new Date();
    todayDate.toGMTString();
    todayDate.setDate(todayDate.getDate() + expiredays);
    document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";";
}
function datePopUpSet(setDate,setFct){
    var now = new Date();
    var todayAtMidn = new Date(now.getFullYear(),now.getMonth(),now.getDate());
    var specificDate = new Date(setDate);
    if(specificDate.getTime() < todayAtMidn.getTime()){
        return true;
    }else{
        return false;
    }
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
function agentCheck(){

    var iphoneAndroid = "";

    if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
        iphoneAndroid ="I";
    }else if(navigator.userAgent.indexOf("Android") > -1){
        iphoneAndroid ="A";
    }

    return iphoneAndroid;

}
function shopcodeToMall(shopcode){
	var snm =  "";
	if("536"  ==  shopcode) snm = "G마켓"    ;
	else if("5910" ==  shopcode) snm = "11번가" ;
	else if("4027" ==  shopcode) snm = "옥션";
	else if("55"   ==  shopcode) snm = "인터파크";
	else if("57"   ==  shopcode) snm = "현대Hmall";
	else if("75"   ==  shopcode) snm = "GS SHOP";
    else if("663"  ==  shopcode) snm = "롯데홈쇼핑";
    else if("47"   ==  shopcode) snm = "신세계몰";
    else if("6640" ==  shopcode) snm = "쿠팡";
    else if("7861" ==  shopcode) snm = "쿠팡";
    else if("6508" ==  shopcode) snm = "위메프";
    else if("6641" ==  shopcode) snm = "티몬";
    else if("806"  ==  shopcode) snm = "CJmall";
    else if("49"   ==  shopcode) snm = "롯데닷컴";
    else if("90"   ==  shopcode) snm = "AKmall";
    else if("974"  ==  shopcode) snm = "nsmall";
    else if("6547" ==  shopcode) snm = "엘롯데";
    else if("6664" ==  shopcode) snm = "SSG.com";
    else if("6361" ==  shopcode) snm = "홈플러스";
    else if("374"  ==  shopcode) snm = "이마트몰";
    else if("7455" ==  shopcode) snm = "롯데마트몰";
    else if("6588" ==  shopcode) snm = "홈앤쇼핑";
    else if("6620" ==  shopcode) snm = "갤러리아몰";
    else if("143"  ==  shopcode) snm = "현대백화점";
    else if("7851" ==  shopcode) snm = "더현대닷컴";
    else if("7692" ==  shopcode) snm = "g9";
    else if("5438" ==  shopcode) snm = "우체국쇼핑";
    else if("6603" ==  shopcode) snm = "보리보리";
    else if("6252" ==  shopcode) snm = "하이마트";
    else if("6729" ==  shopcode) snm = "한샘몰";
    else if("1634" ==  shopcode) snm = "컴퓨존";
    else if("273"  ==  shopcode) snm = "아이코다";
    else if("6095" ==  shopcode) snm = "제로투세븐닷컴";
    else if("6193" ==  shopcode) snm = "동원몰";
    else if("7695" ==  shopcode) snm = "토이저러스";
    else if("5962" ==  shopcode) snm = "1200M";
    else if("5978" ==  shopcode) snm = "바보사랑";
    else if("6389" ==  shopcode) snm = "패션플러스";
    else if("6634" ==  shopcode) snm = "LF mall";
    else if("6644" ==  shopcode) snm = "하프클럽";
    else if("6657" ==  shopcode) snm = "아디다스";
    else if("6414" ==  shopcode) snm = "나이키온라인스토어";
    else if("6427" ==  shopcode) snm = "오케이몰";
    else if("6711" ==  shopcode) snm = "인터파크 도서";
    else if("3367" ==  shopcode) snm = "YES24";
    else if("4861" ==  shopcode) snm = "알라딘";
    else if("4858" ==  shopcode) snm = "반디앤루니스";
    else if("6367" ==  shopcode) snm = "교보문고";
    else if("834"  ==  shopcode) snm = "이노마트";
    else if("1783" ==  shopcode) snm = "카페뮤제오";
    else if("2086" ==  shopcode) snm = "현대오피스";
    else if("2287" ==  shopcode) snm = "나라홈";
    else if("2970" ==  shopcode) snm = "AV하모니";
    else if("4841" ==  shopcode) snm = "조이젠";
    else if("5215" ==  shopcode) snm = "이데이몰";
    else if("5829" ==  shopcode) snm = "AK골프";
    else if("5889" ==  shopcode) snm = "마이티월드";
    else if("5923" ==  shopcode) snm = "파워베스트";
    else if("5925" ==  shopcode) snm = "오피스바이";
    else if("5949" ==  shopcode) snm = "메가커피";
    else if("6062" ==  shopcode) snm = "고캠프";
    else if("6063" ==  shopcode) snm = "유니온모바일";
    else if("6073" ==  shopcode) snm = "티켓타운";
    else if("6082" ==  shopcode) snm = "스매싱스포츠";
    else if("6104" ==  shopcode) snm = "빵상텔레콤";
    else if("6165" ==  shopcode) snm = "CJONmart";
    else if("6174" ==  shopcode) snm = "영웅컴퓨터";
    else if("6199" ==  shopcode) snm = "상품권가게";
    else if("6275" ==  shopcode) snm = "리빙전자";
    else if("6368" ==  shopcode) snm = "영풍문고";
    else if("6377" ==  shopcode) snm = "가방팝";
    else if("6387" ==  shopcode) snm = "블루밍홈";
    else if("6505" ==  shopcode) snm = "HP온라인스토어";
    else if("6688" ==  shopcode) snm = "CJ오클락";
    else if("6695" ==  shopcode) snm = "멸치쇼핑";
    else if("6780" ==  shopcode) snm = "인터파크 아이토이즈";
    else if("7857" ==  shopcode) snm = "Qoo10";
    else if("7852" ==  shopcode) snm = "K쇼핑";
    else if("6611" ==  shopcode) snm = "온그린골프";
    else if("6143" ==  shopcode) snm = "빅골프";
    else if("6673" ==  shopcode) snm = "땡큐골프";
    else if("7685" ==  shopcode) snm = "스토어팜";
    else if("7910" ==  shopcode) snm = "위즈위드";
    else if("7908" ==  shopcode) snm = "이랜드몰";
    else if("9999" ==  shopcode) snm = "기타";
	return snm;
}