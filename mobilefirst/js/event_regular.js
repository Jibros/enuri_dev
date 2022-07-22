(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	//런칭할때 UA-52658695-3 으로 변경
	ga('create', 'UA-52658695-3', 'auto');

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
//로그인페이지 이동
function goLogin(){
	var app = getCookie("appYN"); //app인지 여부
	var backUrl = location.href;

	if( navigator.userAgent.indexOf("iPhone") > -1 || navigator.userAgent.indexOf("iPod") > -1 || navigator.userAgent.indexOf("iPad") > -1){
      if(app =='Y'){
      	location.href = "/mobilefirst/login/login.jsp";
     }else{
      	location.href = "/mobilefirst/login/login.jsp?backUrl="+ backUrl;
      }
  }else if(navigator.userAgent.indexOf("Android") > -1){
      location.href = "/mobilefirst/login/login.jsp?backUrl="+backUrl+"&freetoken=event&chk_id="+vChkId;
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
			$(".name").html(username+" 님<span id=\"myArea\" onclick='myArea();return false;'>"+commaNum(json.POINT_REMAIN)+"점</span></p>");
		}
	});
}
function myArea(){
	location.href = "https://m.enuri.com/my/my_emoney_m.jsp?freetoken=emoney";
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
function shuffle(o){ //v1.0
    for(var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
    return o;
};
function getPlanBanner(){
	var loadUrl = "/mobilefirst/http/json/plan_banner_list.json";
	$.ajax({
		url: loadUrl,
		dataType: 'json',
		async: false,
		success: function(json){
			json.planList = shuffle(json.planList);
			$.each(json.planList , function(i, v){
                var html = "";
			    html +="<li><a href=\"javascript:goPlanView('"+v.TODAY_ID+"')\" target=\"_new\">";
                html +=    "<img src=\""+v.IMGSRC+"\" alt=\"\" style=\"width: 298.828px;\">";
                html += "</a>";
                html += "</li>";
				$(".innder_scroll .thumb").append(html);
                if(i==5){
                	return false;
                }
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
	}else if(dataid == '20170921070707'){
		ga('send', 'event', 'mf_plan_event', 'plan', "월동준비");
		goUrl = "/mobilefirst/evt/seasonWinter.jsp?freetoken=event";
		location.href = goUrl;
	}else{
	    ga('send', 'event', 'mf_plan_event', 'plan', 'plan_'+dataid);
    	location.href = goUrl;
	}
	return false;
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
            location.href="/mobilefirst/index.jsp#evt";
        }else{
            onoff('app_only2');
        }
    }
}
function getOsType(){
    var osType = "";
    if(getCookie("appYN") =='Y'){
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
if(typeof(MSLOG_var)=="undefined"){
	var MSLOG_var = "";
	document.writeln("<scr"+"ipt language='javascript' src='"+document.location.protocol+"//log1.makeshop.co.kr/js/msfunc.js'></scr"+"ipt>");
}