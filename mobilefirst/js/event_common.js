

Kakao.init('5cad223fb57213402d8f90de1aa27301');

(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	//런칭할때 UA-52658695-3 으로 변경
	ga('create', 'UA-52658695-3', 'auto');

$(document).ready(function() {
	var app = getCookie("appYN");

    $(".btn_login").click(function(){
        if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
            if(app =='Y'){
            	location.href = "/mobilefirst/login/login.jsp";
           }
            else{
            	location.href = "/mobilefirst/login/login.jsp?backUrl="+vEvent_page;
            }
        }else if(navigator.userAgent.indexOf("Android") > -1){
            location.href = "/mobilefirst/login/login.jsp?backUrl="+vEvent_page+"?freetoken=event&chk_id="+vChkId;
        }
    });
});

Date.prototype.format = function(f) {
    if (!this.valueOf()) return " ";

    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var d = this;

    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
        switch ($1) {
            case "yyyy": return d.getFullYear();
            case "yy": return (d.getFullYear() % 1000).zf(2);
            case "MM": return (d.getMonth() + 1).zf(2);
            case "dd": return d.getDate().zf(2);
            case "E": return weekName[d.getDay()];
            case "HH": return d.getHours().zf(2);
            case "hh": return d.getHours().zf(2);
            case "mm": return d.getMinutes().zf(2);
            case "ss": return d.getSeconds().zf(2);
            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
            default: return $1;
        }
    });
};

String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);};

function install_btt_1(){

    var link =  document.location.href;

    if (link.indexOf("/mobilefirst/event2016/event_firstexp.jsp") > -1){
        go_install();

    }else if(link.indexOf("/mobilefirst/event2016/allpayback_event.jsp") > -1){

    		if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
                window.location.href = 'https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8';
            }else if(navigator.userAgent.indexOf("Android") > -1){
            	if(gno == "2920138" && gkind == "65"){
            		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=2130226&sub_referral=7413823';
            	}else if(gkind == "42"){
            		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6332234&sub_referral=8820367';
            	}else if(gkind == "43"){
            		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6332234&sub_referral=9238355';
            	}else if(gkind == "44"){
            		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6332234&sub_referral=2709994';
            	}else{
            		window.location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3DTop_banner%26utm_campaign%3Ddowloadbanner_201504";
            	}
            }else{
                location.href = "http://m.enuri.com/mobilefirst/event2016/event_firstexp.jsp";
            }

    }else if(link.indexOf("/mobilefirst/event2016/allpayback_201609.jsp") > -1){

		if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
            window.location.href = 'https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8';
        }else if(navigator.userAgent.indexOf("Android") > -1){
        	if(gno == "2920138" && gkind == "65"){
        		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=2130226&sub_referral=7413823';
        	}else if(gkind == "42"){
        		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6332234&sub_referral=8820367';
        	}else if(gkind == "43"){
        		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6332234&sub_referral=9238355';
        	}else if(gkind == "44"){
        		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6332234&sub_referral=2709994';
        	}else{
        		window.location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3DTop_banner%26utm_campaign%3Ddowloadbanner_201504";
        	}
        }else{
            location.href = "http://m.enuri.com/mobilefirst/event2016/event_firstexp.jsp";
        }

    }
    else if(link.indexOf("/mobilefirst/event2016/purchase_event.jsp") > -1){

		if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
            window.location.href = 'https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8';
        }else if(navigator.userAgent.indexOf("Android") > -1){
        	if(gkind == "42"){
        		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6332234&sub_referral=8820367';
        	}else if(gkind == "43"){
        		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6332234&sub_referral=9238355';
        	}else if(gkind == "44"){
        		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=6332234&sub_referral=2709994';
        	}else if(gkind=="72"){
        		window.location.href = 'https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=9999961&sub_referral=5642519';
        	}
        	else if(gkind=="71"){
        		window.location.href="https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=9999961&sub_referral=1319566";
        	}
        	else{
        		window.location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3DTop_banner%26utm_campaign%3Ddowloadbanner_201504";
        	}
        }else{
            location.href = "http://m.enuri.com/mobilefirst/event2016/event_firstexp.jsp";
        }

    }
    else{

        if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
            window.location.href = 'https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8';
        }else if(navigator.userAgent.indexOf("Android") > -1){
            window.location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3DTop_banner%26utm_campaign%3Ddowloadbanner_201504";
        }else{
            location.href = "http://m.enuri.com/mobilefirst/event2016/event_firstexp.jsp";
        }
    }
	onoff('app_only');
}

function install_btt_2(){
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
		window.location.href = 'https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8';
	}else if(navigator.userAgent.indexOf("Android") > -1){
		window.location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3DTop_banner%26utm_campaign%3Ddowloadbanner_201504";
	}else{
		location.href = "http://m.enuri.com/mobilefirst/event2016/event_firstexp.jsp";
	}

	onoff('benefit_layer');
}

//레이어
function onoff(id) {
	var mid=document.getElementById(id);
	if(mid.style.display=='') {
		mid.style.display='none';
	}else{
		if(id=="app_only"){
			ga('send', 'event', 'mf_event', '프로모션공통영역', '무빙탭_개인화영역');
		}
		mid.style.display='';
	}
}


function goEmoneygoods(url){
	if(app == "Y"){
		if(islogin())
			window.open(url);
		else
        	location.href = "/mobilefirst/login/login.jsp";
	}else{
		onoff('benefit_layer');
	}
	setLog('mf_event','프로모션공통영역','하단_스토어상품');
}

//탭영역 플리킹 iscroll
/*
function loaded(){
	var iscroll = new iScroll("trd_scroll", {
		vScroll:false,
		hScrollbar:false
	});
}
document.addEventListener('DOMContentLoaded', loaded, false);
*/

function goLogin() {
	if(app != 'Y'){
		document.location.href = "/mobilefirst/login/login.jsp?app=&backUrl="+encodeURIComponent(document.location.href);
	}else{
	   	if(window.android){		// 안드로이드
	   		document.location.href = "/mobilefirst/login/login.jsp?app=&backUrl="+encodeURIComponent(document.location.href);
	   	}else{					// 아이폰에서 호출
	   		document.location.href = "/mobilefirst/login/login.jsp";
	   	}
	}
	return false;
}

function getPoint(){
	$.ajax({
		type: "GET",
		url: "/mobilefirst/emoney/emoney_get_point.jsp",
		async: false,
		dataType:"JSON",
		success: function(json){
			remain = json.POINT_REMAIN;	//적립금

			$(".name").empty();
			$(".name").html(username+" 님<span onclick='myArea()'>"+commaNum(json.POINT_REMAIN)+"점</span></p>");

		}
	});
}

function myArea(){
    if(getCookie("appYN") == 'Y'){
        location.href = "/mobilefirst/emoney/emoney.jsp?freetoken=emoney";
    }else{
        onoff('app_only');
    }

}

//콤마 옵션
function commaNum(num) {
    var len, point, str;

    num = num + "";
    point = num.length % 3  ;
    len = num.length;

    str = num.substring(0, point);
    while (point < len) {
        if (str != "") str += ",";
        str += num.substring(point, point + 3);
        point += 3;
    }
    return str;
}


function islogin() {
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
						window.android.isLogin("true");
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

function event_share(part){
	var share_url =  "";	//공유할 URL
	var share_title =  ""; 	//공유할 title

	if(vEvent == "Benefit"){
		share_url = "http://m.enuri.com/mobilefirst/event2016/benefit.jsp";
		share_title = "[에누리 가격비교]\n언제나 좋은 혜택\n500가지 생활쿠폰으로 교환할 수 있는 ‘현금같은 e머니’를 모으세요!";
	}else if(vEvent == "Welcome"){
		share_url = "http://m.enuri.com/mobilefirst/event2016/event_firstexp.jsp";
		share_title = "[에누리 가격비교]\n앱이 처음이세요? 아낌없이 드려요~\n500가지 생활쿠폰으로 교환할 수 있는 ‘현금같은 e머니’를 모으세요!";
	}else if(vEvent == "Attend"){
		share_url = "http://m.enuri.com/mobilefirst/event2016/visit_201606.jsp";
		share_title = "[에누리 가격비교]\n매일 당첨되는 출석 이벤트\n1,000가지 쿠폰으로 교환 할 수 있는 ‘현금같은 e머니’를 모으세요!";
	}else if(vEvent == "Buy"){
		share_url = "http://m.enuri.com/mobilefirst/event2016/allpayback_201606.jsp";
		share_title = "[에누리 가격비교]\n구매한만큼 돌려드리는 이벤트!\n500가지 생활쿠폰으로 교환할 수 있는 ‘현금같은 e머니’를 받으세요!";
	}else if(vEvent == "Recommend"){
		//share_url = "http://m.enuri.com/mobilefirst/event/friend_promotion.jsp";
	}

	if(part == "kakao"){
	 	try{
			Kakao.Link.sendTalkLink({
				label: share_title,
				image: {
					//src: $("#d_img").attr("src"),
					src: "http://imgenuri.enuri.gscdn.com/images/mobilenew/images/enuri_logo_facebook200.gif",
					width: '400',
					height: '209'
			    },
			    webButton: {
			    	text: "에누리 가격비교 열기",
					url: share_url
				},
				fail : function() {
				    alert("카카오 톡이 설치 되지 않았습니다.");
				}
		    });
		}catch(e){
			alert("카카오 톡이 설치 되지 않았습니다.");
		}
		/*
		if(window.android){
			ga("send", "event", "mf_event", vEvent_title +"_APP", "공유하기_카카오톡");
		}else{
			ga("send", "event", "mf_event", vEvent_title +"_WEB", "공유하기_카카오톡");
		}
		*/
		setLog("mf_event", "프로모션공통영역", "공유하기_카카오톡");

	}else if(part == "face"){
		setLog("mf_event", "프로모션공통영역", "공유하기_페이스북");
		try{
			window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
			//ga("send", "event", "mf_event", vEvent_title +"_APP", "공유하기_페이스북");
		}catch(e){
			//url = "http://m.enuri.com";
			window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
			//ga("send", "event", "mf_event", vEvent_title +"_WEB", "공유하기_페이스북");
		}
	}

}

//2016용 생성
function go_event(part,value){	//파라메터에 chk_id 꼭 넣어야함.
	if(part == "Benefit"){
		location.href = "/mobilefirst/event2016/benefit.jsp?freetoken=event&chk_id="+vChkId;
		setLog("mf_event", "프로모션공통영역", "무빙탭_1혜택");
	}else if(part == "Welcome"){
		location.href = "/mobilefirst/event2016/event_firstexp.jsp?freetoken=event&chk_id="+vChkId;
		setLog("mf_event", "프로모션공통영역", "무빙탭_2웰컴");
	}else if(part == "Attend"){
		location.href = "/mobilefirst/event2016/visit_201606.jsp?freetoken=event&chk_id="+vChkId;
		setLog("mf_event", "프로모션공통영역", "무빙탭_3출석");
	}else if(part == "Buy"){
		location.href = "/mobilefirst/event2016/allpayback_201606.jsp?freetoken=event&chk_id="+vChkId;
		setLog("mf_event", "프로모션공통영역", "무빙탭_4구매");
	}else if(part == "Recommend"){
		//location.href = "/mobilefirst/event/friend_promotion.jsp?freetoken=event&chk_id="+vChkId;
		//setLog("mf_event", "프로모션공통영역", "무빙탭_5친추");
	}
}



function event_share_1608(part){
	var share_url =  "";	//공유할 URL
	var share_title =  ""; 	//공유할 title

	if(vEvent == "Attend"){
		share_url = "http://m.enuri.com/mobilefirst/event2016/visit_201608.jsp";
		share_title = "[에누리 가격비교]\n매일 당첨되는 출석 이벤트\n500가지 생활 쿠폰으로 교환 할 수 있는 ‘현금같은 e머니’를 모으세요!";
	}else if(vEvent == "Buy"){
		share_url = "http://m.enuri.com/mobilefirst/event2016/allpayback_201608.jsp";
		share_title = "[에누리 가격비교]\n도전! 구매왕! 구매왕이 되어 현금같은 e머니 100만점 받으세요!";
	}

	if(part == "kakao"){
	 	try{
			Kakao.Link.sendTalkLink({
				label: share_title,
				image: {
					//src: $("#d_img").attr("src"),
					src: "http://imgenuri.enuri.gscdn.com/images/mobilenew/images/enuri_logo_facebook200.gif",
					width: '400',
					height: '209'
			    },
			    webButton: {
			    	text: "에누리 가격비교 열기",
					url: share_url
				},
				fail : function() {
				    alert("카카오 톡이 설치 되지 않았습니다.");
				}
		    });
		}catch(e){
			alert("카카오 톡이 설치 되지 않았습니다.");
		}
		/*
		if(window.android){
			ga("send", "event", "mf_event", vEvent_title +"_APP", "공유하기_카카오톡");
		}else{
			ga("send", "event", "mf_event", vEvent_title +"_WEB", "공유하기_카카오톡");
		}
		*/
		setLog("mf_event", "프로모션공통영역", "공유하기_카카오톡");

	}else if(part == "face"){
		setLog("mf_event", "프로모션공통영역", "공유하기_페이스북");
		try{
			window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
			//ga("send", "event", "mf_event", vEvent_title +"_APP", "공유하기_페이스북");
		}catch(e){
			//url = "http://m.enuri.com";
			window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
			//ga("send", "event", "mf_event", vEvent_title +"_WEB", "공유하기_페이스북");
		}
	}

}

function event_share_1609(part){
	var share_url =  "";	//공유할 URL
	var share_title =  ""; 	//공유할 title

	if(vEvent == "Attend"){
	    share_url = "http://m.enuri.com/mobilefirst/event2016/visit_event.jsp";
	    share_title = "[에누리 가격비교]\n매일 당첨되는 출석 이벤트\n1,000가지 생활쿠폰으로 교환할 수 있는 ‘현금같은 e머니’를 모으세요!";
	}
	else if(vEvent == "Buy"){
	    share_url = "http://m.enuri.com/mobilefirst/event2016/allpayback_event.jsp";
	    share_title = "[연말정산 받자!]\n열심히 쓴 당신, 받아라!!\n앱에서 쇼핑하고 최대 300만점 돌려받자!";
	}

	if(part == "kakao"){
	 	try{
			Kakao.Link.sendTalkLink({
				label: share_title,
				image: {
					//src: $("#d_img").attr("src"),
					src: "http://imgenuri.enuri.gscdn.com/images/mobilenew/images/enuri_logo_facebook200.gif",
					width: '400',
					height: '209'
			    },
			    webButton: {
			    	text: "에누리 가격비교 열기",
					url: share_url
				},
				fail : function() {
				    alert("카카오 톡이 설치 되지 않았습니다.");
				}
		    });
		}catch(e){
			alert("카카오 톡이 설치 되지 않았습니다.");
		}
		/*
		if(window.android){
			ga("send", "event", "mf_event", vEvent_title +"_APP", "공유하기_카카오톡");
		}else{
			ga("send", "event", "mf_event", vEvent_title +"_WEB", "공유하기_카카오톡");
		}
		*/
		setLog("mf_event", "프로모션공통영역", "공유하기_카카오톡");

	}else if(part == "face"){
		setLog("mf_event", "프로모션공통영역", "공유하기_페이스북");
		try{
			window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
			//ga("send", "event", "mf_event", vEvent_title +"_APP", "공유하기_페이스북");
		}catch(e){
			//url = "http://m.enuri.com";
			window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
			//ga("send", "event", "mf_event", vEvent_title +"_WEB", "공유하기_페이스북");
		}
	}

}

function event_share_1701(part){
	var share_url =  "";	//공유할 URL
	var share_title =  ""; 	//공유할 title

	if(vEvent == "Attend"){
	    share_url = "http://m.enuri.com/mobilefirst/event2016/visit_event.jsp";
	    share_title = "[에누리 가격비교]\n매일 당첨되는 출석 이벤트\n1,000가지 생활쿠폰으로 교환할 수 있는 ‘현금같은 e머니’를 모으세요!";
	}
	else if(vEvent == "Buy"){
	    share_url = "http://m.enuri.com/mobilefirst/event2016/allpayback_event.jsp";
	    share_title = "[에누리 가격비교]\n돈 버는 쇼핑혜택!\n앱에서 구매하고 최대 300만점 \n받자!";
	}

	if(part == "kakao"){
	 	try{
			Kakao.Link.sendTalkLink({
				label: share_title,
				image: {
					//src: $("#d_img").attr("src"),
					src: "http://imgenuri.enuri.gscdn.com/images/mobilenew/images/enuri_logo_facebook200.gif",
					width: '400',
					height: '209'
			    },
			    webButton: {
			    	text: "에누리 가격비교 열기",
					url: share_url
			    	},
				fail : function() {
				    alert("카카오 톡이 설치 되지 않았습니다.");
				}
		    });
		}catch(e){
			alert("카카오 톡이 설치 되지 않았습니다.");
			alert(e.message);
		}
		/*
		if(window.android){
			ga("send", "event", "mf_event", vEvent_title +"_APP", "공유하기_카카오톡");
		}else{
			ga("send", "event", "mf_event", vEvent_title +"_WEB", "공유하기_카카오톡");
		}
		*/
		setLog("mf_event", "프로모션공통영역", "공유하기_카카오톡");

	}else if(part == "face"){
		setLog("mf_event", "프로모션공통영역", "공유하기_페이스북");
		try{
			window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
			//ga("send", "event", "mf_event", vEvent_title +"_APP", "공유하기_페이스북");
		}catch(e){
			//url = "http://m.enuri.com";
			window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+share_url);
			//ga("send", "event", "mf_event", vEvent_title +"_WEB", "공유하기_페이스북");
		}
	}

}

function go_event_1608(part,value){	//파라메터에 chk_id 꼭 넣어야함.
	if(part == "Attend"){
		location.href = "/mobilefirst/event2016/visit_201608.jsp?freetoken=event&chk_id="+vChkId;
		setLog("mf_event", "프로모션공통영역", "무빙탭_1_출석");
	}else if(part == "Buy"){
		location.href = "/mobilefirst/event2016/allpayback_201608.jsp?freetoken=event&chk_id="+vChkId;
		setLog("mf_event", "프로모션공통영역", "무빙탭_2_구매");
	}else if(part == "Buy_sub"){
		location.href = "/mobilefirst/event2016/allpayback_201608.jsp?loc=con04&freetoken=event&chk_id="+vChkId;
		setLog("mf_event", "프로모션공통영역", "무빙탭_3_첫구매");
	}
}

function go_event_1609(part,value){	//파라메터에 chk_id 꼭 넣어야함.
	if(part == "Attend"){
		location.href = "/mobilefirst/event2016/visit_201609.jsp?freetoken=event&chk_id="+vChkId;
		setLog("mf_event", "프로모션공통영역", "무빙탭_1_출석");
	}else if(part == "Buy"){
		location.href = "/mobilefirst/event2016/allpayback_201609.jsp?freetoken=event&chk_id="+vChkId;
		setLog("mf_event", "프로모션공통영역", "무빙탭_2_구매");
	}else if(part == "Friend"){
		location.href = "/mobilefirst/event2016/friend.jsp?freetoken=event&chk_id="+vChkId;
		setLog("mf_event", "프로모션공통영역", "무빙탭_3_친구초대");
	}else if(part == "Buy_sub"){
		location.href = "/mobilefirst/event2016/allpayback_201609.jsp?loc=con04&freetoken=event&chk_id="+vChkId;
		setLog("mf_event", "프로모션공통영역", "무빙탭_3_자동적립");
	}
}

//ga 로그
function setLog(nm1, nm2, nm3){
	ga("send", "event", nm1, nm2, nm3);
}

function goEvent_benefit(no){
	if(no == 1){
		location.href = "/mobilefirst/event2016/event_firstexp.jsp?freetoken=event&chk_id="+vChkId;
		setLog("mf_event", "생활혜택", "1반가워서혜택");
	}else if(no == 2){
		location.href = "/mobilefirst/event2016/visit_201606.jsp?freetoken=event&chk_id="+vChkId;
		setLog("mf_event", "생활혜택", "2또만나서혜택");
	}else if(no == 3){
		location.href = "/mobilefirst/event2016/allpayback_201606.jsp?freetoken=event&chk_id="+vChkId;
		setLog("mf_event", "생활혜택", "3고마워서혜택");
	}else if(no == 4){
		//location.href = "/mobilefirst/event/friend_promotion.jsp?freetoken=event&chk_id="+vChkId;
		//setLog("mf_event", "생활혜택", "4함께해서혜택");
	}else if(no == 5){
		if(app == "Y"){
			location.href = "/mobilefirst/emoney/emoney_store.jsp?freetoken=emoney";
		}else{
			onoff('app_only');
		}
		setLog("mf_event", "생활혜택", "5혜택의완성");
	}
}

//get random list
function getStore_random(){
	$.ajax({
		type: "GET",
		url: "/mobilefirst/emoney/emoney_get_random.jsp",
		async: false,
		dataType:"JSON",
		success: function(data){
		$("#benefit_list").html(null);

			var vTxt = "";

			$.each(data.itemlist, function(i, item) {
				vTxt += "<li>";
				vTxt += "<a href=\"javascript:///\" onclick=\"goEmoneygoods('https://m.enuri.com/mobilefirst/emoney/emoney_detail.jsp?freetoken=emoney_sub&code="+ item.gift_code +"&seq="+ item.gift_seq +"&item="+ item.item_seq +"');\">";
					vTxt += "<img src=\"http://imgenuri.enuri.gscdn.com/images/mobilefirst/emoney/item/@"+ item.item_seq +".jpg\" alt=\"\">";
						vTxt += "<em class=\"ellipsis\">"+ item.item_name +"</em>";
					vTxt += "<span><em class=\"e\">e머니</em>"+ commaNum(item.gift_price) +"</span>";
				vTxt += "</a>";
				vTxt += "</li>";
			});

			$("#benefit_list").html(vTxt);
		}
	});
}


function event_resize(){
	if(vEvent == "Attend"){
		$(".moving").show();
	}

	function bg01(){
		if(vEvent == "Attend"){
			$(".txt_area .moving").animate({"bottom":"-90px"},2000,"swing");
		}else{
			$(".evtop01").animate({backgroundPositionX:"46%"}, 2000, "swing");
		}
	}
	var bg01 = setTimeout(bg01, 1500);
}
function event_resize_temp(){

	var ht = $(".top_visual").height();
	$(".top_visual .txt_area").height(ht);
	$(".top_visual .txt_area").css("margin",-ht+"px auto 0px");

	if(vEvent == "Attend"){
		//$("#event_txt_attend_1").show();
		//$("#event_txt_attend_2").show();
	}else if(vEvent == "Buy"){
		//$("#event_txt_1").show();
		//$("#event_txt_2").show();
	}
	/*
	//setTimeout(function(){
		$("#event_txt_1").animate({"opacity":"1"}, 500);
		$("#event_txt_2").animate({"left":"-10px"},10,function(){
			$("#event_txt_2").animate({"opacity":"1","left":"10px"}, 2000,function(){
				$("#event_txt_2").animate({"opacity":"0"},1000,function(){
					$("#event_txt_4").animate({"left":"40px"},10,function(){
						$("#event_txt_4").animate({"opacity":"1","left":"-=25px"}, 2000);
						if(vEvent == "Attend"){
							$("#event_txt_1").animate({"opacity":"1","left":"-=20px"}, 1000);
						}
					});
				});
			});
		});
	//},2000);
	*/
}


$.fn.randomize = function(selector){
    var $elems = selector ? $(this).find(selector) : $(this).children(),
        $parents = $elems.parent();

    $parents.each(function(){
        $(this).children(selector).sort(function(){
            return Math.round(Math.random()) - 0.5;
        // }). remove().appendTo(this); // 2014-05-24: Removed `random` but leaving for reference. See notes under 'ANOTHER EDIT'
        }).detach().appendTo(this);
    });

    return this;
};

function getPlanBanner(){
	var loadUrl = "/mobilefirst/http/json/plan_banner_list.json";
	$.ajax({
		url: loadUrl,
		dataType: 'json',
		async: false,
		success: function(json){
			$.each(json.planList , function(i, v){
                var html = "";

			    html +="<li><a href=\"javascript:goPlanView('"+v.TODAY_ID+"')\" target=\"_new\">";
                html +=    "<img src=\"http://img.enuri.info/images/mobilefirst/planlist/B_"+v.TODAY_ID+"/B_"+v.TODAY_ID+"_main.png\" alt=\"\" style=\"width: 298.828px;\">";
                html += "</a>";
                html += "</li>";
				$(".innder_scroll .thumb").append(html);

		    });
		}
	});
}

function goPlanView(dataid){
	var goUrl = "/mobilefirst/planlist.jsp?t=B_"+dataid;

	if(dataid == '' ){
	   ga('send', 'event', 'mf_plan_event', 'plan', "히트브랜드");
	   goUrl = "/mobilefirst/event2016/hitBrand_201607.jsp";
	   location.href = goUrl;
	}else{
	    ga('send', 'event', 'mf_plan_event', 'plan', 'plan_'+dataid);
	       location.href = goUrl;
	}
}


function getEnuriDeal(){
	var loadUrl = "/mobilefirst/http/json/mobile_deal_list.json";
	$.ajax({
		url: loadUrl,
		dataType: 'json',
		async: false,
		success: function(json){
			var seq = [];
			var num = 0;
			var type = 0;
			var total = 0;
			var random = 0;
			var temp = "";
			var template = "";
			var todayAtMidn = new Date().format("yyyyMMddhhmmss");
			todayAtMidn = todayAtMidn * 1;
			var todayAtMidnDay = new Date().format("yyyyMMdd");
			todayAtMidnDay = todayAtMidnDay * 1;

			if(json){
				if( !seq.length ){
					for(var i=0; i<json.length; i++){
						if(todayAtMidnDay == json[i].GOODS_ST_SELLDATE_DIF.substring(0,8)){
							if(
								(todayAtMidn > json[i].GOODS_ST_EXPODATE_DIF)
								&& (todayAtMidn < json[i].GOODS_END_EXPODATE_DIF)
								&& (json[i].GOODS_EXPO_FLAG == "Y")
								&& (json[i].GOODS_URL_TYPE == 1)){
								type = json[i].GOODS_URL_TYPE;
							}
							if((todayAtMidn > json[i].GOODS_ST_EXPODATE_DIF)
								&& (todayAtMidn < json[i].GOODS_END_EXPODATE_DIF)
								&& (todayAtMidn < json[i].GOODS_END_SELLDATE_DIF)
								&& (json[i].GOODS_EXPO_FLAG == "Y")
								&& (json[i].GOODS_URL_TYPE == 1)
								&& (json[i].GOODS_SOLD_FLAG == "N")){
								seq[seq.length] = json[i].SEQ;
								break;
							}
						}
					}
				}
				if(!seq.length && type == 1){
					for(var i=0; i<json.length; i++){
						if(
							(todayAtMidn > json[i].GOODS_ST_EXPODATE_DIF)
								&& (todayAtMidn < json[i].GOODS_END_EXPODATE_DIF)
								&& (json[i].GOODS_EXPO_FLAG == "Y")
							&& (todayAtMidnDay < json[i].GOODS_ST_SELLDATE_DIF.substring(0,8))
							&& (json[i].GOODS_URL_TYPE == 1)
							&& (json[i].GOODS_SOLD_FLAG == "N")){
							seq[seq.length] = json[i].SEQ;
							break;
						}
					}
				}
				if(!seq.length && type != 1){
					seq = [];
					for(var i=0; i<json.length; i++){
						if(
							(todayAtMidn > json[i].GOODS_ST_EXPODATE_DIF)
								&& (todayAtMidn < json[i].GOODS_END_EXPODATE_DIF)
								&& (json[i].GOODS_EXPO_FLAG == "Y")
							&& (json[i].GOODS_SOLD_FLAG == "N")
							&& (json[i].GOODS_URL_TYPE == 2)){
							seq[seq.length] = json[i].SEQ;
						}
					}
					for(var i=0; i<json.length; i++){
						if(
							(todayAtMidn > json[i].GOODS_ST_EXPODATE_DIF)
								&& (todayAtMidn < json[i].GOODS_END_EXPODATE_DIF)
								&& (json[i].GOODS_EXPO_FLAG == "Y")
							&& (todayAtMidnDay < json[i].GOODS_ST_SELLDATE_DIF.substring(0,8))
							&& (json[i].GOODS_URL_TYPE == 1)
							&& (json[i].GOODS_SOLD_FLAG == "N")){
							seq[seq.length] = json[i].SEQ;
							break;
						}
					}
				}

				if( seq.length ){
					random = seq[Math.floor(Math.random() * seq.length)];
				}


				for(var i=0; i<json.length; i++){
					if((todayAtMidn > json[i].GOODS_ST_EXPODATE_DIF) && (todayAtMidn < json[i].GOODS_END_EXPODATE_DIF) && (json[i].GOODS_EXPO_FLAG == "Y")){
						if(json[i].GOODS_SOLD_FLAG == "Y" || todayAtMidn > json[i].GOODS_END_SELLDATE_DIF || json[i].GOODS_QUANTITY == 0){
							temp += "<li class='soldout'>";
							temp += "<a href='javascript:////' onclick='javascript:deal_click()' value=\""+ num++ +"\">";
							temp += "<input type='hidden' name='seq' id='seq' class='seq' value=\""+json[i].SEQ+"\">";
							temp += "<span class='soldout'>SOLD OUT</span>";
						}else{
							if(todayAtMidn <= json[i].GOODS_ST_SELLDATE_DIF){
								temp += "<li class='soon'>";
								temp += "<a href='javascript:////'  onclick='javascript:deal_click()' value=\""+ num++ +"\">";
								temp += "<input type='hidden' name='seq' id='seq' class='seq' value=\""+json[i].SEQ+"\">";
								temp += "<span class='soon'>"+json[i].GOODS_TAG+"</span>";
							}else{
								temp += "<li class='attand'>";
								temp += "<a href='javascript:////' onclick='javascript:deal_click()' value=\""+ num++ +"\">";
								temp += "<input type='hidden' name='seq' id='seq' class='seq' value=\""+json[i].SEQ+"\">";
							}
						}
						temp += "<div id='zoom_img'>";
						temp += "<img src=\"http://storage.enuri.gscdn.com/Web_Storage"+json[i].GOODS_BIG_IMG+"\" alt=\"\" class=\"thum\" />";

						temp += "<strong>"+json[i].GOODS_NAME+"</strong>";
						temp += "<div class='price'>";

						if(json[i].GOODS_SALE_PER != ""){
							temp += "<span class='sale'><b>"+json[i].GOODS_SALE_PER+"</b>%</span>";
						}
						if(json[i].GOODS_SALE_PRICE != ""){
							temp += "<span class='prc'><b>"+numberWithCommas(json[i].GOODS_SALE_PRICE)+"</b>원</span>";
						}
						if(json[i].GOODS_PRICE != ""){
							temp += "<del><b>"+numberWithCommas(json[i].GOODS_PRICE)+"</b>원</del>";
						}
						temp += "</div>";
						temp += "</a>";
						temp += "</li>";
					}else{

					}
				}
			}
			$(".deal_goods").html(temp);

			$('.deal_goods').slick({
            dots: false,
            infinite: true,
            speed: 300,
            slidesToShow: 1,
            adaptiveHeight: true,
            autoplay: true,
            autoplaySpeed: 3000
            });

		},
		error: function (xhr, ajaxOptions, thrownError) {

		}
	});

	$(".deal_sm").on('touchstart', function(e){
		if(window.android && android.onTouchStart){
			window.android.onTouchStart();
		}else if( $("#ios").val()){

		}
	});

}

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function deal_click(){
	$("li.soldout").unbind();
	$("li.soldout").click(function(){
		ga('send', 'event', 'mf_mobile_eal', '프로모션공통영역', 'eDEAL');
		location.href = "/mobilefirst/event2016/mobile_eal.jsp";
	});
	$("li.soon").unbind();
	$("li.soon").click(function(){
		ga('send', 'event', 'mf_mobile_eal', '프로모션공통영역', 'eDEAL');
		location.href = "/mobilefirst/event2016/mobile_eal.jsp";
	});
	$("li.attand").unbind();
	$("li.attand").click(function(){
		ga('send', 'event', 'mf_mobile_eal', '프로모션공통영역', 'eDEAL');
		location.href = "/mobilefirst/event2016/mobile_eal.jsp";
	});
}
