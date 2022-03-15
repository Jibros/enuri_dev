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

	function QR_pop(){
	    var QR_pop2 = "var QR_POP=window.open('/mobile/popup.jsp','QR_pop2','width=361,height="+window.screen.availHeight+",left="+(window.screen.availWidth-361)+",top=0,toolbar=no,directories=no,status=no,scrollbars=no,resizable=no, menubar=no');QR_POP.focus();"
	    QR_pop2 = QR_pop2 + " ";

	    eval(QR_pop2);
	}

	function Cmd_Sitemap_All(){
	    if (top.document.body.scrollTop){
	        top.document.body.scrollTop = "0px";
	    }else{
	        top.document.documentElement.scrollTop = "0px";
	    }
	    $("#gnb > ul > .allMenuBtn > a").trigger("focusin");
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

    function More_layerClose() {
	    if((top.location.href.indexOf("Flower365.jsp") >= 0) || (top.location.href.indexOf("move_mall.jsp") >= 0 )|| (top.location.href.indexOf("Insurance_Insvalley.jsp") >= 0)){
	    	document.getElementById("More_layer_3").style.display = "none";
	    }else{
	    	document.getElementById("More_layer_2").style.display = "none";
	    }
    }

    function More_layerShow() {
        CmdHideMenu();

        var eObj = event.srcElement || event.target;

        if(top.location.href.indexOf("Flower365.jsp") >= 0 || top.location.href.indexOf("move_mall.jsp") >= 0 || top.location.href.indexOf("Insurance_Insvalley.jsp") >= 0){
            if(document.getElementById("More_layer_3").style.display=="none") {
                document.getElementById("More_layer_3").style.left =  $(eObj).offset().left-304 + "px";
                document.getElementById("More_layer_3").style.top = (parent.getBodyScrollTop() + getCumulativeOffset(parent.document.getElementById("right_navi"))[1]) + 26 + "px";
                document.getElementById("More_layer_3").style.display = "";
             }else{
                document.getElementById("More_layer_3").style.display ="none";
            }
        }else if (((top.location.href.indexOf("Index.jsp")>=0 && top.location.href.indexOf("Tour_Index.jsp")<0) || top.location.href.indexOf("PlanTravel.jsp") >= 0)){

           if(document.getElementById("More_layer_2").style.display=="none") {
               document.getElementById("More_layer_2").style.left = jQuery(eObj).offset().left - 302 - (document.getElementById("main_body") ? document.getElementById("main_body").offsetLeft : 0) + "px";
               document.getElementById("More_layer_2").style.top = (parent.getBodyScrollTop() + getCumulativeOffset(parent.document.getElementById("right_navi"))[1]) + document.getElementById("topBannerNew").offsetHeight+40+ "px";
               document.getElementById("More_layer_2").style.display = "";
            }else{
               document.getElementById("More_layer_2").style.display ="none";
           }
        }else if (top.location.href.indexOf("Tour_Index.jsp") >= 0 || top.location.href.indexOf("Jeju_Tour.jsp") >= 0){
           if(document.getElementById("More_layer_2").style.display=="none") {
               document.getElementById("More_layer_2").style.left = jQuery(eObj).offset().left - 304 - (document.getElementById("main_body") ? document.getElementById("main_body").offsetLeft : 0) + "px";
               document.getElementById("More_layer_2").style.top = (parent.getBodyScrollTop() + getCumulativeOffset(parent.document.getElementById("right_navi"))[1]) + 40 + "px";
               document.getElementById("More_layer_2").style.display = "";
            }else{
               document.getElementById("More_layer_2").style.display ="none";
           }
       }else{
            if(document.getElementById("More_layer_2").style.display=="none") {

            	var topBannerNew2018 = 0;

            	if(document.getElementById("topBannerNew")){
            		topBannerNew2018 =  document.getElementById("topBannerNew").offsetHeight;
            	}

                document.getElementById("More_layer_2").style.left = $(eObj).offset().left-304 + "px";
                document.getElementById("More_layer_2").style.top = (parent.getBodyScrollTop() + getCumulativeOffset(parent.document.getElementById("right_navi"))[1]) + topBannerNew2018+40+ "px";
                document.getElementById("More_layer_2").style.display = "";
             }else{
                document.getElementById("More_layer_2").style.display ="none";
            }
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

    function notice_more(n_type){
        var s_type = n_type;

        if (s_type == 6 ){
            s_type = 5;
        }

        function ShowInConv(originalRequest){
            if (libType() == "PR"){
                var rtnMenuData = originalRequest.responseText;
            }else{
                var rtnMenuData = originalRequest;
            }

            document.getElementById("div_inconv").innerHTML = rtnMenuData;

            if (n_type == 5 ){
                var posLeftTop = getCumulativeOffset(document.getElementById("More_layer_2"));
                document.getElementById("div_inconv").style.top = (document.getElementById("More_layer_2").offsetTop+document.getElementById("More_layer_2").offsetHeight+30) + "px";
                document.getElementById("div_inconv").style.left = document.getElementById("More_layer_2").offsetLeft+ "px";
            }else{
                var mainRightDivObj = $("#mainRightDiv");
                var topPos = mainRightDivObj.offset().top + mainRightDivObj.height() - 246;
                document.getElementById("div_inconv").style.top = topPos + "px";
                document.getElementById("div_inconv").style.left = "570px";
            }
            document.getElementById("div_inconv").style.display = "";
        }

        setTimeout(function(){
            if(document.getElementById("div_inconv").style.display == "none") {
                var url = "/include/ajax/AjaxInconv.jsp";
                var param = "type="+s_type;
                commonAjaxRequest(url,param,ShowInConv);
            }else{
                document.getElementById("div_inconv").style.display = "none";
            }
        },100);
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

    function Cmd_TopLayer_On(param_no, onoff){
        if(onoff == "on"){
            $("topLayer_"+param_no).src = IMG_ENURI_COM + "/images/topmenu/"+param_no+"_ov.gif";
        }else if(onoff == "off"){
            $("topLayer_"+param_no).src = IMG_ENURI_COM + "/images/topmenu/"+param_no+".gif";
        }
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

    //메인에서 검색박스에 커서가 가게되면 로그인 레이어를 숨긴다(레이어와 커서가 겹침 2009.03.20 toodoo)
    function cmdLoginLayerHide(){
        hideLoginLayer();
    }

    function CmdShowAllMenuHeader(){
       if (top.document.body.scrollTop){
            top.document.body.scrollTop = "0px";
        }else{
            top.document.documentElement.scrollTop = "0px";
        }

        top.document.getElementById("header").scrollIntoView(true);
        loadGnbAllMenu(1);
    }
    function goMyPage(url){
        parent.top.location.href=url;
    }

    function showLoginStatus() {
        if(islogin()) {
            try {
                if(document.getElementById("frmMainLogin") && document.getElementById("frmMainLogin").contentWindow.document.body.innerHTML.length<200) {
                    document.getElementById("frmMainLogin").src = "/login/Loginstatus_2010.jsp?main=Y&logintop_menu=top";
                }
            } catch(e) {}
            if(document.getElementById("list_login_btn")) document.getElementById("list_login_btn").style.display = "none";
            if(document.getElementById("loginDiv2")) document.getElementById("loginDiv2").style.display = "";
            if(document.getElementById("utilMenuLogin")) document.getElementById("utilMenuLogin").display = "none";
            if(document.getElementById("utilMenuLogout")) document.getElementById("utilMenuLogout").display = "";
        } else {
            if(document.getElementById("list_login_btn")) document.getElementById("#list_login_btn").style.display = "";
            if(document.getElementById("loginDiv2")) document.getElementById("loginDiv2").style.display = "none";
            if(document.getElementById("utilMenuLogin")) document.getElementById("utilMenuLogin").display = "";
            if(document.getElementById("utilMenuLogout")) document.getElementById("utilMenuLogout").display = "none";
        }
    }