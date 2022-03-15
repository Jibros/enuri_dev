	var isDev = (top.location.href.indexOf("dev.enuri.com") > -1 || top.location.href.indexOf("stagedev.enuri.com") > -1 || top.location.href.indexOf("100.100.100.234") > -1)
			|| top.location.href.indexOf("100.100.100.151") > -1 || top.location.href.indexOf("27.122.133.189") > -1 || top.location.href.indexOf("localhost") > -1;
			
	if (navigator.userAgent.indexOf('Firefox') >= 0) {
	    var eventNames = [ "mousedown", "mouseover", "mouseout",
	            "mousemove", "mousedrag", "click", "dblclick",
	            "keydown", "keypress", "keyup" ];

	    for ( var i = 0; i < eventNames.length; i++) {
	        window.addEventListener(eventNames[i], function(e) {
	            window.event = e;
	        }, true);
	    }
	}
	// 기존 회원가입
	function goJoin(){
	    if (location.pathname=="/view/SaveGoodsList_2010.jsp" || location.pathname=="/knowbox/List_read.jsp"){
	        CmdJoin(1);
	        hideLoginLayer();
	    }else{
	        if (location.pathname == "/event/EventFavorite.jsp"){
	            insertLog(3391);
	        }
	        CmdJoin(1); //회원가입페이지 레이어 호출(join/join2009/IncJoin2009_2010.jsp)
	        hideLoginLayer(); //로그인레이어 숨김
	    }
	}
	// 새로운 회원가입
	function goJoin2017(){
		location.href = "/member/join/join.jsp";
	}

	var TimeHandler;    //setTimeout()의 리턴 핸들러

	function CmdHideMenu() {
		// #36275 관련 불필요 메소드 삭제
		if (clearTimeout) {
			clearTimeout(TimeHandler);
		}
	}

	//브라우져 버전 확인
	var useragent 	= navigator.userAgent;
	var appversion 	= navigator.appVersion;
	var ieVer 		= getBrowserType();

	function getBrowserType() {
	    var trident = useragent.match(/Trident\/(\d.\d)/i);
	    var rtnValue = "";

	    if(useragent.toLowerCase().indexOf("safari")>-1) {
	        rtnValue = "safari";
	    }
	    if(useragent.toLowerCase().indexOf("firefox")>-1) {
	        rtnValue = "firefox";
	    }
	    if(useragent.toLowerCase().indexOf("chrome")>-1) {
	        rtnValue = "chrome";
	    }
	    if(useragent.toLowerCase().indexOf("msie 7.0")>-1) {
	        rtnValue = "ie7";
	    }
	    if(trident != null && trident[1] == "4.0") {
	        if(useragent.toLowerCase().indexOf("msie 8.0")>-1) {
	            rtnValue = "ie8";
	        }
	    }
	    if(trident != null && trident[1] == "5.0") {
	        rtnValue = "ie9";
	    }
	    if(trident != null && trident[1] == "6.0") {
	        rtnValue = "ie10";
	    }

	    return rtnValue;
	}


	function fnGetCookie( name ){
	    var nameOfCookie = name + "=";
	    var x = 0;

	    while( x <= document.cookie.length ){
			var y = (x+nameOfCookie.length);

			if ( document.cookie.substring( x, y ) == nameOfCookie ) {
		        if((endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
		        	endOfCookie = document.cookie.length;

		        return unescape( document.cookie.substring( y, endOfCookie ));
			}

			x = document.cookie.indexOf( " ", x ) + 1;

			if ( x == 0 )
				break;
	    }

	    return "";
	}

	function fnSetCookie(maxage){
	    var todayDate = new Date();

	    todayDate.toGMTString()
	    todayDate.setDate( todayDate.getDate() + maxage );

	    document.cookie = "DetailInfo" + "=" + escape( "CHECKED" ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	    document.getElementById("div_map_detail_info").style.display = "none";
	}

	if(fnGetCookie("DetailInfo") == "" ){
	    if (document.getElementById("div_map_detail_info") != null){
	        try{
	            var url = "/include/ajax/AjaxRecentRight_2010.jsp";
	            var param = "";
	            var getRecentRight = new Ajax.Request(
	                url,
	                {
	                    method:'get',parameters:param,onComplete:showDetailInfo
	                }
	            );
	            function showDetailInfo(originalRequest){
	                if (originalRequest.responseText.indexOf("최근 본 상품 없음") < 0 ){
	                    document.getElementById("div_map_detail_info").style.display = "none";
	                }
	            }
	        }catch(e){
	        }
	    }
	}

	var logolayerTimer = null;

	function fnSetCookie_MainLogo( name, value ){
	    if (typeof(expiredays) == "undefined" || expiredays == null) {
	        expiredays = "";
	    }
	    if (expiredays == ""){
	        document.cookie = name + "=" + escape( value ) + "; path=/;"
	    }else{
	        var todayDate = new Date();
	        todayDate.toGMTString();
	        todayDate.setDate( todayDate.getDate() + expiredays );
	        document.cookie = name + "=" + escape( value ) + "; path=/;"
	    }

	}

    function resentZzimOpen(listType) {
         var openUrl = "/view/resentzzim/resentzzimList.jsp?listType="+listType;
         var resentZzimWin = window.open(openUrl,"resentZzimWin","width=804,height="+window.screen.height+",left=0,top=0,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");

         resentZzimWin.focus();
    }

    // 최근본, 찜상품 전체보기
    function showMyAllList(type) {
        if(type=="today") {
            insertLog(2668);
            resentZzimOpen(1);
        }

        if(type=="save") {
            insertLog(2668);
            resentZzimOpen(2);
        }
    }

    var timerAccountLayer;

    function showNonbanking_site() {
        if (timerAccountLayer != null && typeof(timerAccountLayer) != "undefined"){
            clearTimeout(timerAccountLayer)
        }
        if (document.getElementById("nonbanking_site1").style.display == "none"){
            document.getElementById("nonbanking_site1").style.left = (document.getElementById("aside").offsetLeft + 3)+"px";
            document.getElementById("nonbanking_site1").style.top = getBodyScrollTop() + "px";
            document.getElementById("nonbanking_site1").style.display = "";
        }
    }

    function hideNonbanking_site() {
        timerAccountLayer = setTimeout("hideAccountLayer()", 500);
    }

    function hideAccountLayer(){
        document.getElementById("nonbanking_site1").style.display = "none";
        try {
            if($("frmMainLogin").contentWindow.document.getElementById("div_loginid")) {
                $("frmMainLogin").contentWindow.document.getElementById("div_loginid").style.display = "";
            }
        } catch(e) {}
    }

    function goBannerLink(type, link) {
        if(type=="1") {
            window.open(link);
        }else if(type=="2") {
            top.location.href=link;
        }else if(type=="3") {
            window.detailWin = window.open(link,"detailMultiWin","width=804,height="+window.screen.height+",left=0,top=0,toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");
            window.detailWin.focus();
        }
    }

    function getnextimg(ix){
        if(ix+1>maximg) return 1;
        return ix+1;
    }

    function imgrotation(){
        jQuery("#mainTopBanner0"+thisimg).fadeOut('slow', function(){
            nextimg = getnextimg(thisimg);
            jQuery("#mainTopBanner0"+nextimg).fadeIn('slow');
            thisimg = nextimg;
        });
    }

    var currImgNum = 1;

    function calculateOffsetLeft(field) {
        return calculateOffset(field, "offsetLeft");
    }

    function calculateOffsetTop(field) {
        return calculateOffset(field, "offsetTop");
    }

    function calculateOffset(field, attr) {
        var offset = 0;
        while(field) {
            offset += field[attr];
            field = field.offsetParent;
        }
        return offset;
    }

    //로그인 여부
	function islogin(){
		var cName = "LSTATUS";
		var s = document.cookie.indexOf(cName +'=');
		if (s != -1){
			s += cName.length + 1;
			e = document.cookie.indexOf(';',s);
			if (e == -1){
				e = document.cookie.length
			}
			if( unescape(document.cookie.substring(s,e))=="Y"){
				return true;
			}else{
				return false;
			}
		}else{
			return false;
		}
	}
    
    if(islogin()){
    	CmdMyArea();
    	CmdMyEmoney();
    }
    
    function CmdMyArea(){
    	loadUrl = "/main/main2018/ajax/get_main_myarea.jsp";

    	jQuery.ajax({
    		url: loadUrl,
    		dataType: 'json',
    		async: true,
    		success: function(result){
    			jQuery.each(result.MyInfo, function(i,v){
    				if(result.MyInfo[i].MyText){
    					jQuery("#myid").html(result.MyInfo[i].MyText);
    				}
    				if(result.MyInfo[i].MyNewArticle == "Y"){
    					jQuery(".icon__new").show();
    				}
    				if(result.MyInfo[i].MyKbcom){
    					jQuery.each(result.MyInfo[i].MyKbcom, function(i2,v2){
    						var vGrade_eng = "";
    						if(result.MyInfo[i].MyKbcom[i2].member_grade == "1"){
    							vGrade_eng = "bronze";
    						}else if(result.MyInfo[i].MyKbcom[i2].member_grade == "2"){
    							vGrade_eng = "silver";
    						}else if(result.MyInfo[i].MyKbcom[i2].member_grade == "3"){
    							vGrade_eng = "gold";
    						}else if(result.MyInfo[i].MyKbcom[i2].member_grade == "4"){
    							vGrade_eng = "platinum";
    						}else if(result.MyInfo[i].MyKbcom[i2].member_grade == "5"){
    							vGrade_eng = "diamond";
    						}else if(result.MyInfo[i].MyKbcom[i2].member_grade == "6"){
    							vGrade_eng = "green";
    						}else if(result.MyInfo[i].MyKbcom[i2].member_grade == "7"){
    							vGrade_eng = "family";
    						}else if(result.MyInfo[i].MyKbcom[i2].member_grade == "8"){
    							vGrade_eng = "vip";
    						}

    						jQuery("#myinfo_score").text(CommaFormattedN(result.MyInfo[i].MyKbcom[i2].score_sum));
    						jQuery("#menu__tx--act").text(CommaFormattedN(result.MyInfo[i].MyKbcom[i2].score_sum));
    						jQuery("#myinfo_ranking").text(result.MyInfo[i].MyKbcom[i2].member_ranking==""?"-":result.MyInfo[i].MyKbcom[i2].member_ranking);
    						jQuery("#myinfo_grade").text(result.MyInfo[i].MyKbcom[i2].grade_name);
    						jQuery("#myinfo_grade").addClass("ico-grade--"+vGrade_eng);
    						jQuery("#header-top_grade").text(result.MyInfo[i].MyKbcom[i2].grade_name);
    						jQuery("#header-top_grade").addClass("ico-grade--"+vGrade_eng);
    						
    					});
    					if(result.MyInfo[i].MyKbcom.length == 0){
    						jQuery("#myinfo_score").text("0");
    						jQuery("#menu__tx--act").text("0");
    						jQuery("#myinfo_ranking").text("-");
    						jQuery("#myinfo_grade").text("누리그린");
    						jQuery("#myinfo_grade").addClass("ico-grade--green");
    						jQuery("#header-top_grade").text("누리그린");
    						jQuery("#header-top_grade").addClass("ico-grade--green");
    					}
    				}
    			});
    		}
    	});
    }

    function CmdMyEmoney(){
    	jQuery.ajax({
    		type: "GET",
    		url: "/mobilefirst/emoney/emoney_get_point.jsp",
    		async: true,
    		dataType:"JSON",
    		success: function(json){
    			remain = json.POINT_REMAIN;	//적립금
    			jQuery("#myinfo_emoney").text(CommaFormattedN(remain));
    			jQuery("#menu__tx--emoney").text(CommaFormattedN(remain));
    			
    		}
    	});
    }
    
  	//콤마 옵션
    function CommaFormattedN(amount) {
        var delimiter = ",";
        var i = parseInt(amount);
        if(isNaN(i)) { return ''; }
        var minus = '';
        if (i < 0) { minus = '-'; }
        i = Math.abs(i);
        var n = new String(i);
        var a = [];
        while(n.length > 3)
        {
            var nn = n.substr(n.length-3);
            a.unshift(nn);
            n = n.substr(0,n.length-3);
        }

        if (n.length > 0) { a.unshift(n); }
        n = a.join(delimiter);
        amount = minus + (n+ "");
        return amount;
    }
	
	//주요 카테고리
	//loadGnbViewCate();
	
	function loadGnbViewCate(){
    	jQuery.ajax({
    		url : isDev ? "/common/jsp/Ajax_Gnb_ViewCate.jsp" : "/wide/main/ajax/TopViewCate_2021.html",
    		data : "html",
    		success:function(data){
				if(data){
					jQuery(".header-cate__list").html(data);
				}else{
					jQuery(".header-cate__list").hide();
				}
    		}
    	});
    }
    
    var allGnbObj = null;
    function allMenuLayer(){
    	loadGnbAllMenu();
		jQuery(".header-cate__btn--all").addClass("is--on");
		insertLog(24249);
    }

	function cls_cate_all(){
    	jQuery('.lay-cate-all').addClass('is--hide');
    	jQuery(".header-cate__btn--all").removeClass("is--on");
    }
   
    //gnb
    function loadGnbAllMenu(){
		
    	if(allGnbObj==null){
	    	jQuery.ajax({
	    		//url : isDev ? "/common/jsp/Ajax_Gnb_AllMenu_2021.jsp" : "/wide/main/ajax/TopAllCate_2021.html",
	    		url : isDev ? "/common/jsp/Ajax_Gnb_AllMenu_2022.jsp" : "/wide/main/ajax/TopAllCate_2022.html",
	    		data : "html",
	    		success:function(data){
	    			
	    			allGnbObj = data;
	    			landGnbAllMenu(allGnbObj);
					
	    		}
	    	});
    	}else{
    		landGnbAllMenu(allGnbObj);
    	}
    }

    
    
    function landGnbAllMenu(allGnbObj){
    	jQuery("#gnbAllMenu").html(allGnbObj);
    	
    	var $depth1 = jQuery(".cate-all-old .cate-item--depth1");
        var delayTimer;
        var delayTime = 100;
        $depth1.on({
            "mouseenter" : function(){
                var $t = jQuery(this);
                delayTimer = setTimeout(function(){
                    $t.addClass("is--on").siblings().removeClass("is--on");
                },delayTime)
            },"mouseleave" : function(){
                clearTimeout(delayTimer);
            }
        })
        jQuery('.lay-cate-all').removeClass('is--hide');
		jQuery('.lay-cate-all__inner .cate-all').show();
		
		//lp에서는 네비 대대카테 기준으로 
		if (typeof param_cate !== "undefined") {
			var vDepth1Text = $("p.location__tit").find("button.depth1").text();
			if (typeof vDepth1Text !== "undefined" && vDepth1Text.length > 0) {
				var $cateDepth1 = $("li.cate-item--depth1");
				$cateDepth1.removeClass("is--on");
				$cateDepth1.each(function(i, v) {
					if (vDepth1Text === $("p.cate__tit").eq(i).text()) {
						$(v).addClass("is--on");
						return false;
					}
				});
			}
		}
    }
    
    function landGnbAllMenu(allGnbObj){
    	jQuery("#gnbAllMenu").html(allGnbObj);
    	
    	var $depth1 = jQuery(".cate-all-old .cate-item--depth1");
        var delayTimer;
        var delayTime = 100;
        $depth1.on({
            "mouseenter" : function(){
                var $t = jQuery(this);
                delayTimer = setTimeout(function(){
                    $t.addClass("is--on").siblings().removeClass("is--on");
                },delayTime)
            },"mouseleave" : function(){
                clearTimeout(delayTimer);
            }
        })
        jQuery('.lay-cate-all').removeClass('is--hide');
		jQuery('.lay-cate-all__inner .cate-all').show();
		
		//lp에서는 네비 대대카테 기준으로 
		if (typeof param_cate !== "undefined") {
			var vDepth1Text = $("p.location__tit").find("button.depth1").text();
			if (typeof vDepth1Text !== "undefined" && vDepth1Text.length > 0) {
				var $cateDepth1 = $("li.cate-item--depth1");
				$cateDepth1.removeClass("is--on");
				$cateDepth1.each(function(i, v) {
					if (vDepth1Text === $("p.cate__tit").eq(i).text()) {
						$(v).addClass("is--on");
						return false;
					}
				});
			}
		}
    }
    
    // 쿠키 읽어오기
    function getCookieCommon(c_name) {
    	var i,x,y,ARRcookies = document.cookie.split(";");
    	for(var i=0; i<ARRcookies.length; i++) {
    		x = ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
    		y = ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
    		x = x.replace(/^\s+|\s+$/g,"");
    		if(x==c_name) {
    			return unescape(y);
    		}
    	}
    }

    // 쿠키 입력
    function setCookieCommon(c_name, value, exdays) {
    	var exdate=new Date();
    	exdate.setDate(exdate.getDate() + exdays);
    	var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
    	c_value += "; domain=" + document.domain;
    	c_value += "; path=/ ";

    	document.cookie=c_name + "=" + c_value;
    }
    
    //숫자에서 콤마찍기
    Number.prototype.format = function() {
    	if(this==0) return 0;

    	var r = /(^[+-]?\d+)(\d{3})/;
    	var n = (this + '');

    	while (r.test(n)) n = n.replace(r, '$1' + ',' + '$2');

    	return n;
    };
    
    //자바스크립트 숫자로 된 문자열에서 콤마찍기
    String.prototype.format = function() {
    	var n = parseFloat(this);
    	if(isNaN(n)) return "0";
    	
    	return n.format();
    };
    
    var noImageStr = "http://img.enuri.info/images/home/thum_none.jpg";