    
	//자동완성 찾기 및 이벤트 체크.
    function Tom(){
        this.version="1.0";
        this.name = "AutoComplete Tom";
        this.oForm = null;                          //검색어 입력 Form객체
        this.sCollection = null; //콜랙션 정보.      //자동완성 해당 콜랙션

        this.oKeyword = null;                       //검색키워드 입력 Text객체
        this.sOldkwd = "";                          //이전검색어
        this.sNewkwd = "";                          //신규검색어
        this.oAc_lyr = null;                        //자동완성 전체레이어객체

        this.oAc_ifr = null;                        //자동완성처리 프레임객체

        this.oImg_Toggle = null;                    //검색키워드 입력 Text객체의 우측 토글이미지객체
        this.sImg_Toggle_on = "http://img.enuri.info/images/main_2007/search_arr_off.gif";
        this.sImg_Toggle_off = "http://img.enuri.info/images/main_2007/search_arr_on.gif";
        this.sSkipWrd = "ㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋㅌㅍㅎ";   //자동완성 skip단어
        this.bSkipTF = false;                       //자동완성 skip단어 기능을 사용할지 여부
        this.TimerInterval = 200;                   //자동완성 체크주기1000이 1초

        this.act =0;                                //자동완성 실행중인지 여부 (0:유휴, 1:실행)
        this.sSubmitFunctionName = "";
        this.isExistSkipwrd = function(){
            var ret = false;
            s = arguments[0];
            t = arguments[1];
            for(i=0;i<s.length;i++){
                if(t.indexOf(s.substring(i, i+1)) < 0){
                    ret = false;
                }else{
                    ret = true;
                    break;
                }
            }
            return ret;
        };

        this.toggle = function(){
            if(this.oAc_ifr!=null){
                obj = document.getElementById(this.oAc_ifr.name).contentWindow;
                obj.Jerry_on_off();
            }
        };
        this.find = function(){
            if(this.act){
                return;
            }else{
                if(this.bSkipTF){
                    if(this.isExistSkipwrd(this.oKeyword.value.trim(), this.sSkipWrd)){
                        return;
                    }
                }
                this.act=1;
                this.sNewkwd = this.oKeyword.value.trim();
                obj = document.getElementById(this.oAc_ifr.name).contentWindow;
                obj.Jerry_AutoSearch(this);
                this.sOldkwd = this.sNewkwd;
                this.act=0;
            }
        };
    }
    
    if (document.URL.indexOf("/search/Searchlist.jsp") < 0 && document.getElementById("keyword")){
        document.getElementById("keyword").value = "";
    }
    
    var oT_Main = null;

    function oT_Main_Init(){
        if(oT_Main == null){
            oT_Main = new Tom();
        }
        var o = oT_Main;
        if(o.oForm==null){
            o.oForm = document.fmMainSearch;
        }
        if(o.sCollection==null){
            o.sCollection = o.oForm.c.value;
        }
        if(o.oKeyword==null){
            o.oKeyword = o.oForm.keyword;
        }
        o.oKeyword.setAttribute("autocomplete","off");
        if(o.oAc_lyr==null){
            if (document.getElementById("ac_layer_main")){
                o.oAc_lyr = document.getElementById("ac_layer_main");
            }
        }
        if(o.oAc_ifr==null){
            if (document.getElementById("ifr_ac_main")){
                o.oAc_ifr = document.getElementById("ifr_ac_main");
            }
        }
        var varAutoComSearchLeft = 12;

        //o.oAc_lyr.style.left  = $(".searchForm").position().left+"px";
        //o.oAc_lyr.style.top   = $(".searchForm").position().top+$(".searchForm").height()-2+"px";

        var varAutoW = 46;
        if (BrowserDetect.browser == "Explorer" ){
            varAutoW = 44;
        }

        o.oAc_lyr.style.display = "none" ;
        o.oAc_ifr.style.display = "block";
        o.sSubmitFunctionName = "Cmd_MainSearchSubmit()";
    }

    function oT_Main_search(objEvt){
        if(oT_Main==null){
            oT_Main_Init();
        }

        var o = oT_Main;
        var e = null;
        var obj = document.getElementById(o.oAc_ifr.name).contentWindow;

        var varAutoComSearchLeft = 12;

        o.oAc_lyr.style.left  = jQuery(".searchForm").position().left;
        
        var varKeyCode;
        if (typeof(objEvt) == "undefined"){
            e = window.event;
        }else{
            e = objEvt;
        }

        try{
            varKeyCode = e.keyCode;
        }catch(e){
            varKeyCode = 0;
        }

        if(varKeyCode==40){
            obj.Jerry_next();
        }else if(varKeyCode==38){
            obj.Jerry_prev();
        }else if(varKeyCode==37){
        }else if(varKeyCode==39){
        }else if(varKeyCode==13){
        }else{
            setTimeout("oT_Main.find()", o.TimerInterval);
        }

    }

    function Cmd_formMainSearch(){
        if(oT_Main != null){
            if (typeof(oT_Main.lktype) == "function"){
                oT_Main.lktype();
                return false;
            }
        }
        var schWrd;

        var obj = document.fmMainSearch;
        schWrd = obj.keyword.value;
        schWrd = replace2(schWrd, "'");
        schWrd = replace2(schWrd, "\"");
        schWrd = schWrd.trim();
        document.fmMainSearch.ismodelno.value = checkModelNoFormat(schWrd);
        var schLen;
        var schWrdExp;
        schWrdExp = schWrd;
        obj.hyphen_2.value = check2Hyphen(obj.keyword.value);

        schWrdExp = replace2(schWrdExp, "^");
        //schWrdExp = replace2(schWrdExp, "&");
        schWrdExp = replace2(schWrdExp, "~");
        schWrdExp = replace2(schWrdExp, "!");
        schWrdExp = replace2(schWrdExp, "@");
        schWrdExp = replace2(schWrdExp, "document.getElementById");
        schWrdExp = replace2(schWrdExp, "%");
        schWrdExp = replace2(schWrdExp, "*");
        schWrdExp = replace2(schWrdExp, "+");
        schWrdExp = replace2(schWrdExp, "=");
        schWrdExp = replace2(schWrdExp, "\\");
        schWrdExp = replace2(schWrdExp, "{");
        schWrdExp = replace2(schWrdExp, "}");
        schWrdExp = replace2(schWrdExp, "[");
        schWrdExp = replace2(schWrdExp, "]");
        schWrdExp = replace2(schWrdExp, ";");
        schWrdExp = replace2(schWrdExp, "/");
        schWrdExp = replace2(schWrdExp, "<");
        schWrdExp = replace2(schWrdExp, ">");
        schWrdExp = replace2(schWrdExp, ",");
        schWrdExp = replace2(schWrdExp, "?");
        schWrdExp = replace2(schWrdExp, "(");
        schWrdExp = replace2(schWrdExp, ")");
        schWrdExp = replace2(schWrdExp, "'");
        schWrdExp = replace2(schWrdExp, "_");
        schWrdExp = replace2(schWrdExp, "-");
        schWrdExp = replace2(schWrdExp, "`");
        schWrdExp = replace2(schWrdExp, "|");
        schWrdExp = schWrdExp.trim();

        schLen = schWrdExp.length;

        if (schWrd == "에누리 오픈마켓"){
            window.open("http://www.enuri.com/minishop/Ms_List_Solo_All_Main.jsp","_blank","width="+window.screen.availWidth+",height="+window.screen.availHeight+",toolbar=yes,directories=no,status=yes,scrollbars=yes,resizable=yes,menubar=yes,location=yes");
            return false;
        }
        if (obj.nosearchkeyword.value != "Y"){
            if(schLen < 2 && obj.searchkind.value != "4" ){
                if (schLen == 1 && obj.searchkind.value == "" && varExpKeyWord.indexOf(schWrd) >= 0 ){
                    //obj.searchkind.value = "1";
                }else{
                    alert("2자 이상의 검색어를 넣으세요.\t\t\r\n\특수문자는 제외 됩니다.");
                    obj.searchkind.value = "";
                    obj.keyword.focus();
                    return false;
                }
            }
            obj.keyword.value = schWrd;
            obj.target = "_top";
            obj.action = "/search/Searchlist.jsp";
        }else{
            obj.target = "_top";
            obj.action = "/search/Searchlist.jsp";
        }
        insertLog(3231);
        document.fmMainSearch.keyword.value = schWrdExp;
        return true;
    }
    function checkModelNoFormat(schWord){
        if (schWord.length == 8 ){
            try{
                var f3Number = parseInt(schWord.substring(0,3));
                var l4Numver = parseInt(schWord.substring(4,8));
                if (schWord.substring(3,4) == "-"){
                    return true;
                }else{
                    return false;
                }
            }catch(e){
                return false;
            }
        }else{

            return false;
        }
    }
    
	function Cmd_MainSearchSubmit(){
		/* if (document.fmMainSearch.keyword.style.backgroundImage == "none" || document.fmMainSearch.keyword.style.backgroundImage == ""){*/
		if(jQuery(".keyword__txt--ad").css("display") == "none") {

            if(Cmd_formMainSearch()){
                document.fmMainSearch.submit();
            }
        }else{
            insertLog(4986);
            
            /*if(intRanSearch3<=arrExperience.length){*/
            if(banSrchKwdObj.LOG_NO) {
                insertLog(banSrchKwdObj.LOG_NO);
                top.location.href = banSrchKwdObj.LNK_URL;
            }
            return false;
        }
    }

    function fnGetCountSearchAll(varCount,varSearchkind){
        var obj = document.fmMainSearch;

        obj.target = "_top";
        obj.searchkind.value = varSearchkind;
        
        if (varSearchkind == "3"){
            obj.es.value = "no";
        }
        
        obj.action = "/search/Searchlist.jsp";
        obj.submit();
    }
    
    function goSearchRan(){
        var strGoSearchRanUrl = "";
        var strLogNo = "";

        if (intRanSearch2 == 1 ){
            strGoSearchRanUrl = "/view/Listmp3.jsp?cate=0810&menu=false&islist=";
        }else if (intRanSearch2 == 2){
            strGoSearchRanUrl = "/view/Flower_Easyflower.jsp?cate=&menu=false&flag=73";
        }else if (intRanSearch2 == 3){
            strGoSearchRanUrl = "/view/List.jsp?cate=040813&menu=false&flag=&islist=";
        }else if (intRanSearch2 == 4){
            strGoSearchRanUrl = "/view/Listmp3.jsp?cate=0212&menu=false&islist=";
        }else if (intRanSearch2 == 5){
            strGoSearchRanUrl = "/fashion/Fashion_SubList.jsp?cate=1451&from=topmenu";
        }
        
        strLogNo = "2121";

        insertLog(strLogNo);
        location.href = strGoSearchRanUrl;
    }
	function showRanSearchImage(){
        document.getElementById("div_ran_search_all").style.display = "";
        document.getElementById("div_ran_search_all").style.left = (getCumulativeOffset(document.getElementById("img_ran_search"))[0]) + "px";
        document.getElementById("div_ran_search_all").style.top = (getCumulativeOffset(document.getElementById("img_ran_search"))[1] + 20) + "px";
    }

    function showOrgSearchLayer(){
        document.getElementById('img_ran_search').style.display='none';
        document.getElementById('div_ran_search_all').style.display='none';
        document.getElementById('cms_search').style.display='';
        document.fmMainSearch.keyword.focus();
    }
	function removeSearchKeyword(){
        document.fmMainSearch.keyword.value="";
        toggleRemoveKeywodBtn();
        document.fmMainSearch.keyword.focus();
        document.getElementById("ac_layer_main").style.display = "none";

        document.getElementById("btn_search_main_").src = IMG_ENURI_COM + "/2012/search/autocom_0724/btn1.gif";

        if (navigator.userAgent.toLowerCase().indexOf('trident') < 0 && BrowserDetect.browser == "Explorer" && BrowserDetect.version ==  7 ){
            document.getElementById("ifr_ac_main").contentWindow.document.location.reload();
        }else{
            oT_Main_search();
        }
    }
	
    function toggleRemoveKeywodBtn(){
        if (document.fmMainSearch.keyword.value.trim().length == 0 ){
            //document.getElementById("imgToggleAutoMake").style.cursor="default";
        }else{
            var varNowSearchKeyword = document.fmMainSearch.keyword.value.trim();
            var varPrevSearchKeyword = setSearchKeywordByAutocom.varSearchKeywordByAutocom;
            if (typeof(varPrevSearchKeyword) != "undefined"){
                if (varNowSearchKeyword != varPrevSearchKeyword){
                    document.fmMainSearch.from.value = ""
                    document.getElementById("btn_search_main_").src = IMG_ENURI_COM + "/2012/search/autocom_0724/btn1.gif";
                }
            }
        }
    }
    
    function toggleAutoMake() {
    	var arrowArea = jQuery("#search_arrow_bar");

    	if(document.getElementById("ac_layer_main").style.display!="none") {
    		document.getElementById("ac_layer_main").style.display = "none";
    		//document.getElementById("imgToggleAutoMake").src = var_img_enuri_com+"/2014/layout/ico_arrow_down.gif";
    		arrowArea.attr("class", "serach__arrow serach__arrow--down");
    	} else {
    		oT_Main_search();
    		//document.getElementById("imgToggleAutoMake").src = var_img_enuri_com+"/2014/layout/ico_arrow_up.gif";
    		arrowArea.attr("class", "serach__arrow serach__arrow--up");
    	}
    }
    
    function setSearchKeywordByAutocom(keyword,from){
        setSearchKeywordByAutocom.varSearchKeywordByAutocom = keyword;
        document.fmMainSearch.from.value = from;
        //document.getElementById("imgToggleAutoMake").src = var_img_enuri_com+"/2014/layout/ico_arrow_down.gif";
    }
    
    function setSearchKeywordFocus(keyword,from){
        document.fmMainSearch.keyword.value=keyword;
        //document.fmMainSearch.keyword.style.backgroundImage = "none";
        jQuery(".keyword__txt--ad").hide();
        document.fmMainSearch.from.value = from;
        Cmd_MainSearchSubmit();
    }
    
	// 검색관련 함수
	function img_close_autoAction() {
	    if(jQuery("ac_layer")) jQuery("ac_layer").style.display = "none";
	    if(jQuery("img_close_auto")){
	    	jQuery("img_close_auto").style.backgroundImage = "url(" + IMG_ENURI_COM + "/2012/search/main_sc1.gif)";
	    	jQuery("img_close_auto").style.cursor="arrow";
	    }
	}