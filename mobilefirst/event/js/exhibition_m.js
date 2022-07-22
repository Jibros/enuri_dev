$(document).ready(function(){
	if(islogin()){
		$("#user_id").text(userId);
		getPoint();//개인e머니 내역 노출
	}

	//닫기버튼
	$(".win_close").click(function(){
		if(getCookie("appYN") == 'Y'){
			window.location.href = "close://";
		}else{
			window.location.replace("/mobilefirst/index.jsp");
		}
	});
});

//딜 상품 구매
function fnDeal(seq, exhId){
	if(islogin()){
		if(!getSnsCheck()){
			if (confirm("본인인증이 되지 않은 SNS 회원은\n이벤트 참여가 불가합니다.\n본인인증 화면으로 이동할까요?") == true){
				location.href= "https://m.enuri.com/mobilefirst/member/myAuth.jsp?cmdType=&f=m&freetoken=login_title";
			}else{
				return false;
			}
		}else{
			$.ajax({
				type : "GET",
				url  : "/eventPlanZone/ajax/getExhdealUrl.jsp",
				data : {
						"seq" : seq,
						"osTpCd" : getOsType()
					   },
			   async : false,
			   dataType : "JSON",
			   success  : function(result){
				   if(result.soldoutYN == "Y"){
					   alert("품절 되었습니다.");
				   }else if(result.moveUrl != ""){
					   window.open(result.moveUrl);
					   $.getJSON("/eventPlanZone/ajax/ctuExhDeal.jsp", {"exh_id":exhId, "goods_seq":seq , "shop_code":"55"}, function(data) {});
				   }else{
					   alert("다시 시도해주세요.");
				   }
				   return false;
			   },
			   error    : function(){
				   alert("잘못 된 접근입니다.");
			   }
			});
		}
	}else{
		alert("로그인 후 참여할 수 있습니다.");
		goLogin('emoneyPoint');
		return;
	}
}

//sns 인증
function getSnsCheck() {
	var snsCertify;
	$.ajax({
		type: "GET",
		url: "/member/ajax/getMemberCetify.jsp",
		dataType: "JSON",
		async : false,
		success: function(json){
			var snsdcd = json["snsdcd"]; //sns회원유무 K:카카오, N:네이버
			snsCertify = json["certify"];
			if(snsdcd==""){
				snsCertify = true;
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			//alert(xhr.status);
			//alert(thrownError);
		}
	});
	return snsCertify;
}

//상품 이미지 에러
function replaceImg(obj){
	$(obj).error(function(){
		$(obj).attr("src","http://img.enuri.info/images/home/recommend_none_300_m.jpg");
    });
	var imgsrc = $(obj).attr("src").replace("webimage_300","webimage2");
	$(obj).attr("src",imgsrc);
}

//탭상품 vip이동
function itemClick(modelNo, minprice) {
	if(minprice > 0){
		window.open('/mobilefirst/detail.jsp?modelno=' + modelNo + '&freetoken=vip');
	}else{
		alert("품절된 상품 입니다.");
		return false;
	}
}

//딜영역 날짜 노출
function YYYYMMDDHHMMSS(today) {
	function pad2(n){ return (n < 10 ? '0' : '') + n; }

	return	today.getFullYear() + pad2(today.getMonth() + 1) + pad2(today.getDate())
			+ pad2(today.getHours()) + pad2(today.getMinutes()) + pad2(today.getSeconds());
}

//딜 영역 요일 노출
function getWeek(date){
	var week = new Array('일','월','화','수','목','금','토');
	var date = new Date(date.substring(0,4)+"-"+date.substring(4,6)+"-"+date.substring(6,8)).getDay();
	var dayOfWeek = week[date];

	return dayOfWeek;
}

//앱설치버튼
function install_btn(){
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
        window.location.href = "https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8";
    }else if(navigator.userAgent.indexOf("Android") > -1){
    		window.location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3DTop_banner%26utm_campaign%3Ddowloadbanner_201504";
    }
}

////#타임특가 PV (애드브릭스)
function welcomeGa(strEvent){
	if(app == "Y"){
		try{
			if(window.android){ // 안드로이드
				window.android.igaworksEventForApp(strEvent);
			}else if(/iPhone|iPad|iPod/i.test(navigator.userAgent)){ // 아이폰에서 호출
				location.href = "enuriappcall://igaworksEventForApp?strEvent="+strEvent;
			}
		}catch(e){}
	}
}

//파라미터값 받아서 탭 이동(상단 탭 고정인 경우 $navHgt = 0)
function tabMove(tab, $navHgt){
	$('html, body').stop().animate({scrollTop: Math.ceil($('#evt' + tab).offset().top) - $navHgt}, 500);
}

function protabMove(protab, $navHgt){
	$('html, body').stop().animate({scrollTop: Math.ceil($('#pro_anc_0' + protab).offset().top) - $navHgt}, 500);
}

//ga로그
function ga_log(param){
	if(param == 1){
		ga('send', 'pageview', {'page': vEvent_page, 'title': gaLabel[0]});
	}else{
		ga('send', 'event', 'mf_event', vEvent_title, gaLabel[param - 1]);
	}
}

function Share_Sns(param){
	var varSNSURL = location.href;

	if(param == "face"){
		try{
			window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+varSNSURL);
		}catch(e){
			window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(share_title)+"&u="+varSNSURL);
		}
	}else if(param == "kakao"){
		Kakao.Link.sendDefault({
			objectType: 'feed',
			content: {
				title: share_title,
				//description: $('meta[property="og:description"]').attr('content'),
				imageUrl: $('meta[property="og:image"]').attr('content'),
				imageWidth: 380,
				imageHeight: 198,
				link: {
					webUrl: varSNSURL,
					mobileWebUrl: varSNSURL
				}
			}
		});
	}else if (param == "tw"){
		try {
			window.android
					.android_window_open("http://twitter.com/intent/tweet?text="
							+ encodeURIComponent(share_title)
							+ "&url=" + varSNSURL);
		} catch (e) {
			window.open("http://twitter.com/intent/tweet?text="
					+ encodeURIComponent(share_title) + "&url="
					+ varSNSURL);
		}
	}
}