var oT = null;
function oT_Init(){
    try{
        if(oT == null){
            oT = new Tom();
        }
        var o = oT;
        if(o.oForm==null){
            o.oForm = document.fmMainSearch;
        }
        if(o.sCollection==null){
            //o.sCollection = o.oForm.c.value;
            o.sCollection = "enuri";
        }
        if(o.oKeyword==null){
            o.oKeyword = o.oForm.keyword;//document.getElementById("keyword");
        }
        o.oKeyword.setAttribute("autocomplete","off");
        if(o.oAc_lyr==null){
            o.oAc_lyr = document.getElementById("ac_layer");
        }
        if(o.oAc_ifr==null){
            o.oAc_ifr = document.getElementById("ifr_ac");
        }

        var varAddHeight = 0;
        var varAw = 32;

        var varAl = (calculateOffsetLeft(o.oKeyword) - 8 );

        varAw = 33;
        if (BrowserDetect.browser == "Explorer" && (BrowserDetect.version == 6 || BrowserDetect.version == 7 || BrowserDetect.version == 7)){
            varAddHeight = 2;
        }else{
            if (document.URL.indexOf("Searchlist.jsp") < 0 ){
                varAddHeight = 2;
            }else{
                varAddHeight = 3;
            }
        }
        if(BrowserDetect.browser == "Explorer" && BrowserDetect.version == 7 && navigator.userAgent.toLowerCase().indexOf("trident/6.0") >= 0){
            varAddHeight += 2;
        }

        varAl = varAl - 20;
        varAw = varAw + 13;
        o.oAc_lyr.style.left  = varAl+ "px";
        o.oAc_lyr.style.top   = (calculateOffsetTop(o.oKeyword)+ o.oKeyword.offsetHeight + varAddHeight)+ "px";
        o.oAc_lyr.style.width = (o.oKeyword.offsetWidth+varAw) + "px";
        o.oAc_lyr.style.display = "none" ;
        o.oAc_ifr.style.width = (o.oKeyword.offsetWidth+varAw) + "px";
        o.oAc_ifr.style.display = "block";
        o.sSubmitFunctionName = "Cmd_MainSearchSubmit()";
    }catch(e){
        setTimeout("oT_Init()", 1000);
    }
}
function oT_search(objEvt){
    //try{
        if(oT==null){
            oT_Init();
        }

        //CmdHideMenu();
        var o = oT;
        var e = null;
        if (o.oAc_lyr == null){
            oT_Init();
        }
        var varAl = (calculateOffsetLeft(o.oKeyword) - 8 );
        varAl = (calculateOffsetLeft(o.oKeyword) - 8 );

        if (document.getElementById("li_search_7").style.display != "none"){
            varAl = varAl - 17;
        }
        varAl = varAl - 4;
        o.oAc_lyr.style.left  = varAl+ "px";

        if (typeof(objEvt) == "undefined"){
            e = window.event;
        }else{
            e = objEvt;
        }
        var varKeyCode;
        try{
            varKeyCode = e.keyCode;
        }catch(e){
            varKeyCode = 0;
        }
        if (typeof(varKeyCode) == "undefined"){
            varKeyCode = 0;
        }

        var obj = o.oAc_ifr.contentWindow
        if(varKeyCode==40){
            obj.Jerry_next();
        }else if(varKeyCode==38){
            obj.Jerry_prev();
        }else if(varKeyCode==37){
        }else if(varKeyCode==39){
        }else if(varKeyCode==13){
        }else{
            setTimeout("oT.find()", o.TimerInterval);
        }
    //}catch(e){
    //}
}
function changeStyle(obj,onoff){
    if (onoff == 'on'){
        if (obj.value.trim().length == 0 ){
            obj.style.color ="#FF0000";
            obj.style.backgroundImage ='none';
        }
    }else{
        if (obj.value.trim().length == 0 ){
            obj.style.backgroundImage ='url('+strRanSearchImage+')';
            obj.style.backgroundRepeat = 'no-repeat';
        }
    }
    //obj.style.imeMode = "auto";
}
function changeStyleNew(obj,onoff){
    if (onoff == 'on'){
        if (obj.value.trim().length == 0 ){
            obj.style.color ="#FF0000";
            obj.style.backgroundImage ='none';
        }

        if (document.getElementById("ac_layer").style.display == "none"){
            if (document.getElementById("n_search_5").src != (var_img_enuri_com + "/2012/search/autocom_0724/search_05_ov.png")){
                document.getElementById("n_search_5").src = var_img_enuri_com + "/2012/search/autocom_0724/search_05_ov.png";
                document.getElementById("n_search_6").style.backgroundImage="url("+var_img_enuri_com+"/2012/search/autocom_0724/search_03_ov.png)";
            }
            if (document.fmMainSearch.keyword.value.trim().length == 0 ){
                if (document.getElementById("li_search_7")){
                    document.getElementById("li_search_7").style.display = "none";
                }
            }
        }else{
            if (document.fmMainSearch.keyword.value.trim().length == 0 ){
                if (document.getElementById("li_search_7")){
                    document.getElementById("li_search_7").style.display = "none";
                }
            }else{
                if (document.getElementById("li_search_7")){
                    document.getElementById("li_search_7").style.display = "";
                }
            }
        }
    }else{
        if (obj.value.trim().length == 0 ){
            obj.style.backgroundImage ='url('+strRanSearchImage+')';
            obj.style.backgroundRepeat = 'no-repeat';
        }
        if (document.getElementById("ac_layer").style.display == "none"){
            if (document.fmMainSearch.keyword.value.trim().length == 0 ){
                if (document.getElementById("n_search_5").src != (var_img_enuri_com + "/2012/search/autocom_0724/search_05.png")){
                    document.getElementById("n_search_5").src = var_img_enuri_com + "/2012/search/autocom_0724/search_05.png";
                    document.getElementById("n_search_6").style.backgroundImage="url("+var_img_enuri_com+"/2012/search/autocom_0724/search_03.png)";
                    if (document.getElementById("li_search_7")){
                        document.getElementById("li_search_7").style.display = "none";
                    }
                }
            }
        }
    }
    obj.style.imeMode = "deactivated";
}

function Cmd_MainSearchSubmit(){
    var obj = document.fmMainSearch;
    schWrd = obj.keyword.value;
    obj.searchkind.value = "";
    setDefaultSearchBtn();
    if (varRanSearch == 0 ){
            var return_a = Cmd_MainSearch1();
            if(return_a){
                document.fmMainSearch.submit();
            }
    }else{
        if (document.fmMainSearch.keyword.style.backgroundImage == "none" || document.fmMainSearch.keyword.style.backgroundImage == ""){
            var return_a = Cmd_MainSearch1();
            if(return_a){
                if (document.getElementById("n_search_2")){
                    document.getElementById("n_search_2").src = var_img_enuri_com + "/2012/search/autocom_0724/search_02.png";
                    document.getElementById("n_search_3").style.backgroundImage="url("+var_img_enuri_com+"/2012/search/autocom_0724/search_03.png)";
                    //document.getElementById("n_search_4").src = var_img_enuri_com + "/2012/search/autocom_0724/search_04.gif";
                    document.getElementById("select_search_area").style.display = "none";
                    document.getElementById("search_btn_go").style.display = "none";
                    document.getElementById("sarea_arrow_btn").style.display = "";
                }
                hideAutoComLayer();
                document.fmMainSearch.submit();
            }
        }else{
            if (varRanSearch == 1 ){
                insertLog(10785);
                top.location.href = "/event/EventReview.jsp?event_idx=1416";
            }else if (varRanSearch == 2 ){
                insertLog(10784);
                top.location.href = "/event/EventReview.jsp?event_idx=1415";
            }else if (varRanSearch == 3 ){
                insertLog(10664);
                top.location.href = "/event/EventReview.jsp?event_idx=1411";
            }else if (varRanSearch == 4 ){
                insertLog(10783);
                top.location.href = "/event/EventReview.jsp?event_idx=1414";
            }else if (varRanSearch == 5 ){
                insertLog(10663);
                top.location.href = "/event/EventReview.jsp?event_idx=1410";
            }else if (varRanSearch == 6 ){
                insertLog(10782);
                top.location.href = "/event/EventReview.jsp?event_idx=1413";
            }else if (varRanSearch == 7 ){
                insertLog(10662);
                top.location.href = "/event/EventReview.jsp?event_idx=1409";
            }else if (varRanSearch == 8 ){
                insertLog(10781);
                top.location.href = "/event/EventReview.jsp?event_idx=1412";
            }else if (varRanSearch == 9 ){
                insertLog(10661);
                top.location.href = "/event/EventReview.jsp?event_idx=1408";
            }else if (varRanSearch == 10 ){
                insertLog(10660);
                top.location.href = "/event/EventReview.jsp?event_idx=1407";
            }
            insertLog(4986);
            return false;
        }
    }
}

function schKeyword(schWrd){
    document.fmMainSearch.ismodelno.value = checkModelNoFormat(schWrd);
    var schWrdExp;
    schWrdExp = schWrd;

    schWrdExp = replace2(schWrdExp,"'");
    schWrdExp = replace2(schWrdExp,"\\");
    schWrdExp = replace2(schWrdExp,"^");
    //schWrdExp = replace2(schWrdExp,"&");
    schWrdExp = replace2(schWrdExp,"~");
    schWrdExp = replace2(schWrdExp,"!");
    schWrdExp = replace2(schWrdExp,"@");
    schWrdExp = replace2(schWrdExp,"$");
    schWrdExp = replace2(schWrdExp,"%");
    schWrdExp = replace2(schWrdExp,"*");
    schWrdExp = replace2(schWrdExp,"+");
    schWrdExp = replace2(schWrdExp,"=");
    schWrdExp = replace2(schWrdExp,"\\");
    schWrdExp = replace2(schWrdExp,"{");
    schWrdExp = replace2(schWrdExp,"}");
    schWrdExp = replace2(schWrdExp,"[");
    schWrdExp = replace2(schWrdExp,"]");
    //schWrdExp = replace2(schWrdExp,":");
    schWrdExp = replace2(schWrdExp,";");
    schWrdExp = replace2(schWrdExp,"/");
    schWrdExp = replace2(schWrdExp,"<");
    schWrdExp = replace2(schWrdExp,">");
    //schWrdExp = replace2(schWrdExp,".");
    schWrdExp = replace2(schWrdExp,",");
    schWrdExp = replace2(schWrdExp,"?");
    schWrdExp = replace2(schWrdExp,"(");
    schWrdExp = replace2(schWrdExp,")");
    schWrdExp = replace2(schWrdExp,"'");
    schWrdExp = replace2(schWrdExp,"_");
    schWrdExp = replace2(schWrdExp,"-");
    schWrdExp = replace2(schWrdExp,"`");
    schWrdExp = replace2(schWrdExp,"|");
    schWrdExp = replace2(schWrdExp,"\"");
    schWrdExp = schWrdExp.trim();

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
    return schWrdExp;
}
function check2Hyphen(keyword){
    var bReturn = false;
    if (keyword.length >= 2){
        if (keyword.substring(1,2) == "-" || keyword.substring(1,2) == "_" || keyword.substring(1,2) == " "){
            bReturn = true;
        }
    }
    return bReturn;
}
function Cmd_MainSearch1(){
    //alert("현재 검색 시스템 점검 중입니다.\r\n\r\n최대한 빠른 시간 내에 정상화 되도록 최선을 다하겠습니다. ");
    //return false;

    if(oT != null){
        if (typeof(oT.lktype) == "function"){
            oT.lktype();
            return false;
        }
    }
    var schWrd;
    var obj = document.fmMainSearch;
    schWrd = obj.keyword.value;
    obj.searchkind.value = "";
    var schWrdExp = schKeyword(schWrd);
    schLen = schWrdExp.length;
    if(schLen < 2 ){
        if (!(schLen == 1 && varExpKeyWord.indexOf(schWrd) >= 0 )){
            alert("2자 이상의 검색어를 넣으세요.\t\t\r\n\특수문자는 제외 됩니다.");
            obj.searchkind.value = "";
            obj.keyword.focus();
            return false;
        }
    }
    if (document.getElementById("img_close_auto")){
        document.getElementById("img_close_auto").src = var_img_enuri_com + "/2012/search/main_sc1.gif"
        document.getElementById("img_close_auto").style.cursor="default";
    }
    if (document.getElementById("n_search_7")){
        if (selectSearchArea._f_area == 0){
            alert("1개 이상을 선택하셔야 합니다.")
            return false;
        }
        hideSearchSelectArea();
    }
    obj.hyphen_2.value = check2Hyphen(obj.keyword.value);

    obj.keyword.value = schWrdExp;
    if (document.URL.indexOf("Searchlist.jsp") >= 0 ){
        if (document.getElementById("div_catekeyword_layer")){
            document.getElementById("div_catekeyword_layer").style.display = "none";
        }
        Cmd_MainSearch1._cateKeyword = true;
    }
    var varReturnValue = false;
    /*
     * 검색 페이지의 이전 검색어의 분류검색어를 클릭했을때
     * 분류검색어 역활을 하기 위하여 from 값을 삭제
     */
    if (obj.from.value == "search"){
        obj.from.value = "";
    }
    obj.target = "_top";
    obj.action = "/search.jsp";
    varReturnValue = true;

    insertLog(3231);
    hideAutoComLayer();

    function getIsCateKeyword(originalRequest){
        try{
            //var searchKeywordCate = originalRequest.responseText.trim();
            if (libType() == "PR"){
                var searchKeywordCate = originalRequest.responseText.trim();
            }else{
                var searchKeywordCate = originalRequest.trim();
                //searchKeywordCate = $.trim(searchKeywordCate);
            }
            if (searchKeywordCate.length > 0 ){
                top.location.href = searchKeywordCate;
            }else{
                varReturnValue = true;
            }
        }catch(e){
        }
    }



    if (!varReturnValue){
        var checkCateKeyword = new Ajax.Request(
            "/search/getRedirecPage.jsp",
            {
                method:'get',asynchronous:false,parameters:("keyword="+encodeURIComponent(top.document.fmMainSearch.keyword.value)+"&getlink=y"),onComplete:getIsCateKeyword
            }
        );

    	/*
        var url = "/search/getRedirecPage.jsp";
        var param = "keyword="+encodeURIComponent(top.document.fmMainSearch.keyword.value)+"&getlink=y";
        commonAjaxRequest_async(url,param,getIsCateKeyword);
        */
    }
    return varReturnValue;


}

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
    this.lktype="";
    this.lklink=null;
    this.toggle = function(){
        if(this.oAc_ifr!=null){
            obj = document.getElementById("ifr_ac").contentWindow;
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
            obj = document.getElementById("ifr_ac").contentWindow;
            if(this.sOldkwd!=this.sNewkwd){
            	obj.Jerry_AutoSearch(this);
            }
            this.sOldkwd = this.sNewkwd;
            this.act=0;
        }
    };
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
function fnGetCountSearchAll(varCount,varSearchkind){
    var obj = document.fmMainSearch;
    obj.target = "_top";
    obj.searchkind.value = varSearchkind;
    if (varSearchkind == "3"){
        obj.es.value = "no";
    }
    obj.action = "/search.jsp";
    obj.submit();
}
function hideAutoComLayer(){
    document.getElementById('ac_layer').style.display='none';
    checkAutoCom();
}
function stopSearch(){
    if (document.getElementById("searchlist_reloading")){
        document.getElementById("searchlist_reloading").style.display = "none";
    }
    document.getElementById("searchListFrame").src = "/search/stopSearch.jsp?keyword="+encodeURIComponent(document.fmMainSearch.keyword.value);
}
function removeSearchKeyword(){
    insertLog(8620);
    document.fmMainSearch.keyword.value="";
    if (document.getElementById("li_search_7")){
        document.getElementById("li_search_7").style.display = "none";
    }
    document.fmMainSearch.keyword.focus();
    toggleAutoMake();
    //document.getElementById("imgToggleAutoMake").src = var_img_enuri_com + "/2012/search/autocom_1010/amt_none.png";
    //document.getElementById("imgToggleAutoMake").style.cursor="default";
    setDefaultSearchBtn();
    //document.getElementById("btn_search_main_").src = var_img_enuri_com + "/2012/search/autocom_0724/btn1.gif";
    if (navigator.userAgent.toLowerCase().indexOf('trident') < 0 && BrowserDetect.browser == "Explorer" && BrowserDetect.version ==  7 ){
        document.getElementById("ifr_ac").contentWindow.document.location.reload();
    }else{
        oT_search();
    }
}
function checkEmptySearchKeyword(){
    if (document.fmMainSearch.keyword.value.trim().length == 0 ){
        if (document.getElementById("li_search_7")){
            document.getElementById("li_search_7").style.display = "none";
        }
    }else{
        if (document.getElementById("li_search_7")){
            document.getElementById("li_search_7").style.display = "";
        }
        var varNowSearchKeyword = document.fmMainSearch.keyword.value.trim();
        var varPrevSearchKeyword = setSearchKeywordByAutocom.varSearchKeywordByAutocom;
        if (typeof(varPrevSearchKeyword) != "undefined"){
            if (varNowSearchKeyword != varPrevSearchKeyword){
                document.fmMainSearch.from.value = "";
                document.getElementById("btn_search_main").src = var_img_enuri_com + "/2012/search/autocom_0724/btn2.png";
            }
        }
    }
    setDefaultSearchBtn();
}
/*
function toggleAutoMake(){
    if (document.getElementById("imgToggleAutoMake").src == (var_img_enuri_com + "/2012/search/autocom_1010/amt_none.png")){
        if (document.getElementById("ac_layer").style.display != "none"){
            document.getElementById("ac_layer").style.display = "none";
        }
        return;
    }
    if (document.getElementById("ac_layer").style.display != "none"){
        document.getElementById("ac_layer").style.display = "none";
        document.getElementById("imgToggleAutoMake").src = var_img_enuri_com+"/2012/search/autocom_1010/search_down.png";
        insertLog(8621);
    }else{
        insertLog(8622);
        oT_search();
        document.getElementById("imgToggleAutoMake").src = var_img_enuri_com+"/2012/search/autocom_1010/search_up.png";
    }
}
*/
function checkAutoCom(){
    function toggleAutoCom(originalRequest){
        if (libType() == "PR"){
            var tempResponse = originalRequest.responseText;
        }else{
            var tempResponse = originalRequest;
        }
        try{
            if (tempResponse.trim().length > 0 ){
               // document.getElementById("imgToggleAutoMake").src = var_img_enuri_com + "/2014/layout/bg_arrow6.gif";
            	document.getElementById("imgToggleAutoMake").src = var_img_enuri_com + "/2014/layout/ico_arrow_down.gif";
                document.getElementById("imgToggleAutoMake").style.cursor="pointer";
            }else{
            	toggleAutoMake();
            }
        }catch(e){
        }
    }
    var str = document.fmMainSearch.keyword.value;
    if(str.length>0 && str.trim().length<15){
        /*var checkMakeCom = new Ajax.Request(
                "/search/Makecom_2010.jsp",
                {
                    method:'get',parameters:("c=enuri&q="+encodeURIComponent(document.fmMainSearch.keyword.value)),onComplete:toggleAutoCom
                }
        );  */
        var url = "/search/Makecom_2010.jsp";
        //var url = "/search/Makecom_2014.jsp";
        var param = "c=enuri&q="+encodeURIComponent(document.fmMainSearch.keyword.value);
        var checkMakeCom = commonAjaxRequest(url,param,toggleAutoCom);
    }
}
function setSearchKeywordFocus(keyword,from){
    document.fmMainSearch.keyword.value=keyword;
    document.fmMainSearch.keyword.style.backgroundImage = "none";
    if (document.getElementById("li_search_7")){
        document.getElementById("li_search_7").style.display = "";
    }
    document.fmMainSearch.from.value = from;
    setSearchKeywordFocus._selected = true;
    Cmd_MainSearchSubmit();
    /*
    document.fmMainSearch.keyword.focus();
    checkEmptySearchKeyword();
    if (top.document.getElementById("btn_search_main")){
        top.document.getElementById("btn_search_main").src = var_img_enuri_com + "/2012/search/autocom_0724/btn2_ov.gif";
    }
    setSearchKeywordByAutocom(keyword,from);
    if (document.getElementById("ac_layer").style.display != "none"){
        document.getElementById("ac_layer").style.display = "none";
        document.getElementById("imgToggleAutoMake").src = var_img_enuri_com+"/2012/search/autocom_1010/search_down.png";
    }
    */
}
function setSearchKeywordByAutocom(keyword,from){
    setSearchKeywordByAutocom.varSearchKeywordByAutocom = keyword;
    document.fmMainSearch.from.value = from;
    document.getElementById("imgToggleAutoMake").src = var_img_enuri_com+"/2012/search/autocom_1010/search_down.png";
}
function setDefaultSearchBtn(){
    if (top.document.getElementById("btn_search_main_")){
        if (top.document.getElementById("btn_search_main_").src == (var_img_enuri_com+"/2012/search/autocom_0724/bg2_ov.gif") ){
            top.document.getElementById("btn_search_main_").src = var_img_enuri_com + "/2012/search/autocom_0724/btn1.gif";
        }
    }
    if (top.document.getElementById("btn_search_main")){
        if (top.document.getElementById("btn_search_main").src == (var_img_enuri_com+"/2012/search/autocom_0724/btn2_ov.gif") ){
            top.document.getElementById("btn_search_main").src = var_img_enuri_com + "/2012/search/autocom_0724/btn2.png";
        }
    }
}