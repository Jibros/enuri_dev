

Kakao.init('5cad223fb57213402d8f90de1aa27301');

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
	
//앱설치버튼
function install_btt(){
	
	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
        window.location.href = 'https://itunes.apple.com/kr/app/enuli-gagyeogbigyo/id476264124?mt=8';
    }else if(navigator.userAgent.indexOf("Android") > -1){
    	window.location.href = "market://details?id=com.enuri.android&referrer=utm_source%3Denuri%26utm_medium%3DTop_banner%26utm_campaign%3Ddowloadbanner_201504";
    }
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
//로그인페이지 이동
function goLogin(){
	var app = getCookie("appYN"); //app인지 여부

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
			$(".name").html(username+" 님<span onclick='myArea()'>e머니 "+commaNum(json.POINT_REMAIN)+"점</span></p>"); //#수정
			
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
				vTxt += "</a>";
				vTxt += "</li>";
			});
			
			$("#benefit_list").html(vTxt);
		}
	});
}
//get random BI list
function getBI_random(){
	
	$.ajax({ 
		type: "POST",
		url: "/mobilefirst/emoney/emoney_get_random.jsp",
		async: false,
		data:{isShop:"Y", cnt:3},
		dataType:"JSON",
		success: function(data){
			var vTxt = "";
			var randomNum = new Array();
			randomNum[0]=data.store_seq0;
			randomNum[1]=data.store_seq1;
			randomNum[2]=data.store_seq2;
			
			for(var i=0;i<randomNum.length;i++){
				vTxt += "<li>";
				vTxt += "<a href=\"javascript:///\" onclick=\"goEmoneyStore("+randomNum[i]+");\">";
					vTxt += "<img src=\"http://imgenuri.enuri.gscdn.com/images/mobilefirst/emoney/store/@"+ randomNum[i] +".jpg\" alt=\"\">";
				vTxt += "</a>";
				vTxt += "</li>";		
			}			
			$("#benefit_list").html(vTxt);
		}
	});
	
}
function goEmoneyStore(index){
	if(app == "Y"){
		location.href = "/mobilefirst/emoney/emoney_store.jsp?freetoken=emoney#"+index;
	}else{
		onoff('app_only');
	}
}
function goEmoney(index){
	var goUrl='';
	 if(getCookie("appYN") == 'Y'){
		 //적립내역보기
		 if(index==1){
			 goUrl="/mobilefirst/emoney/emoney.jsp?freetoken=emoney";
		 }
		 //이벤트보기
		 else if(index==2){
			 goUrl="/mobilefirst/renew/plan.jsp?freetoken=main_tab|event";
		 }
		 //스토어가기
		 else if(index==3){
			 goUrl="/mobilefirst/emoney/emoney_store.jsp?freetoken=emoney";
		 }
		 //쿠폰함 가기
		 else if(index==4){
			 goUrl="/mobilefirst/emoney/emoney_couponbox.jsp?freetoken=emoney";
		 }
	        location.href = goUrl;
	    }else{
	    	//웹에서 이벤트보기일땐 예외적으로 이벤트혜택탭으로 이동 
	    	if(index==2){
	    		location.href="/mobilefirst/renew/plan.jsp?menu=E";
	    	}else{
		        onoff('app_only2');	
	    	}    
	    }
}
//ga 로그
function setLog(nm1, nm2, nm3){
	ga("send", "event", nm1, nm2, nm3);
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
function ejs_render(ejsurl, data, bind_id){
	var retdata = null;
	$.ajax({
		type: "GET",
		url: ejsurl,
		async:false,
		dataType: "text",
		success: function(template){				
			//console.log(template);
			try{
				var html = ejs.render(template, data);
				if (typeof(bind_id) != 'undefined') $('#' + bind_id).html(html);
				retdata = html;
			}catch(e){}
			
		} // success
	}); // .ajax
	return retdata;
} 
// get 요청일 때만 사용함.
function ejs_render_data_by_url(ejsurl, dataurl, bind_id){
	var retdata = null;
	$.ajax({
		type: "GET",
		url: dataurl,
		async:false,
		dataType: "JSON",
		success: function(data){				
			var ejs_html = ejs_render(ejsurl, data, bind_id);
			retdata = {'ejs_html':ejs_html, 'data':data};				
		} // success
	}); // .ajax
	return retdata;
}
function move(url){
	var app = getCookie("appYN");
	
	if( app != "Y"){
		window.open(url);
	}else{
		location.href= url;	
	}
}
//콤마찍기
function commaNum(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}
function shuffle(o){ //v1.0
    for(var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
    return o;
}
function getOsType(){
	var app = getCookie("appYN"); //app인지 여부
    var osType = "";
    if(app =='Y'){
         if(navigator.userAgent.indexOf("Android") > -1)             
        	 osType = "MAA";
         else             
        	 osType = "MAI";
    }else {
         if(navigator.userAgent.indexOf("Android") > -1)             
        	 osType = "MWA";
         else             
        	 osType = "MWI";
    }
    return osType;
}

function event_share(part, vUrl, vTitle){
	var share_url =  "http://m.enuri.com"+vUrl;	//공유할 URL 
	
	if(part == "1"){
	 	try{
			Kakao.Link.sendTalkLink({
				label: vTitle,
				image: {
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
		setLog("mf_event", "프로모션공통영역", "공유하기_카카오톡");

	}else if(part == "2"){
		setLog("mf_event", "프로모션공통영역", "공유하기_페이스북");
		try{   
			window.android.android_window_open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(vTitle)+"&u="+share_url);
		}catch(e){
			window.open("http://www.facebook.com/sharer.php?t="+encodeURIComponent(vTitle)+"&u="+share_url);
		} 	
	}
}