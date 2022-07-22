Kakao.init('5cad223fb57213402d8f90de1aa27301');

(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	//런칭할때 UA-52658695-3 으로 변경
	ga('create', 'UA-52658695-3', 'auto');


function install_btt_1(){
    
    var link =  document.location.href;
    
    if (link.indexOf("/mobilefirst/event2016/event_firstexp.jsp") > -1){
        go_install();
        
    }else if(link.indexOf("/mobilefirst/event2016/allpayback_201608.jsp") > -1){
    	
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
    	
    }else{
        
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
		
function onoff(id) {
	if(id == "benefit_layer" && app == "Y"){
		location.href = "/mobilefirst/emoney/emoney.jsp";
		return false;
	}else if(id == "app_only" && app == "Y"){
		ga('send', 'event', 'mf_event', '프로모션공통영역', '무빙탭_개인화영역');
		location.href="/mobilefirst/emoney/emoney.jsp?&freetoken=emoney";
		return false;
	}else{
		if(id == "app_only"){
			ga('send', 'event', 'mf_event', '프로모션공통영역', '무빙탭_개인화영역');
		}
		var mid=document.getElementById(id);
		if(mid.style.display=='') {
			mid.style.display='none';
		}else{
			mid.style.display='';
		} 
		
		if(id=="win"){
			location.reload();
		}
	}
}

function goEmoneygoods(url){
	if(app == "Y"){
		window.open(url);
	}else{
		onoff('benefit_layer');
	}
	setLog('mf_event','프로모션공통영역','하단_스토어상품');
}

//탭top스크롤
$(document).ready(function() {
	
	var nav = $('.nav'); 
	$(window).scroll(function () {
		if ($(this).scrollTop() > 180) {
			nav.addClass("topnav");
		} else {
			nav.removeClass("topnav");
		}
	});
	
});

//탭영역 플리킹 iscroll
function loaded(){
	var iscroll = new iScroll("trd_scroll", {
		vScroll:false,
		hScrollbar:false
	});
}

document.addEventListener('DOMContentLoaded', loaded, false);

function getPoint(){
	$.ajax({ 
		type: "GET",
		url: "/mobilefirst/emoney/emoney_get_point.jsp",
		async: false,
		dataType:"JSON",
		success: function(json){
			remain = json.POINT_REMAIN;	//적립금
			
			$(".name").empty();
			$(".name").html(username+" 님<span onclick=\"onoff('app_only')\">"+commaNum(json.POINT_REMAIN)+"점</span></p>");
			
		}
	});
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
		share_title = "[에누리 가격비교]\n매일 당첨되는 출석 이벤트\n500가지 생활 쿠폰으로 교환 할 수 있는 ‘현금같은 e머니’를 모으세요!";
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
				vTxt += "<a href=\"javascript:///\" onclick=\"goEmoneygoods('http://m.enuri.com/mobilefirst/emoney/emoney_detail.jsp?freetoken=emoney_sub&code="+ item.gift_code +"&seq="+ item.gift_seq +"&item="+ item.item_seq +"');\">";
					vTxt += "<img src=\"http://imgenuri.enuri.gscdn.com/images/mobilefirst/emoney/item/@"+ item.item_seq +".jpg\" alt=\"\">";
						vTxt += "<em class=\"ellipsis\">"+ item.item_name +"</em>";
					vTxt += "<span>"+ commaNum(item.gift_price) +"</span>";
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