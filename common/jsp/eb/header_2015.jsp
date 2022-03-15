<%
    boolean bIsMain = false;

    if(request.getServletPath().indexOf("Index.jsp") >= 0 ){
        bIsMain = true;
    }

    int intAutoComWidth = 293;
    String strSearchBtn = ConfigManager.IMG_ENURI_COM + "/2014/layout/btn_search.gif";
    int intBgTopPos = -2;

    strSearchBtn = ConfigManager.IMG_ENURI_COM + "/2014/main/images/btn_search.gif";
  	//cpc 광고 영역 추가로 인한 width 변경
	//intAutoComWidth = 361;
 	intAutoComWidth = 454;
    intBgTopPos = 9;

    Bnr_List_Proc Bnr_list_proc = new Bnr_List_Proc();
    Bnr_List_Data[] Bnr_list_data = null; // level:1
    Bnr_list_data = Bnr_list_proc.getBnr_List_Ran(165);

    int intBnrCount = 0;

    String StrBannerHTML = "";

    if (Bnr_list_data != null){
        if (Bnr_list_data != null && Bnr_list_data.length > 0 ){
            for (int i=0;i<Bnr_list_data.length;i++){
				StrBannerHTML += "<div id=\"mainTopBanner0" + (i+1) + "\">";
				StrBannerHTML += "    <a href=\"JavaScript:insertLog(10516);goBannerLink('" + Bnr_list_data[i].getBanner_linktype() + "', '" + Bnr_list_data[i].getBanner_link() + "')\"><img src=\"" + Bnr_list_data[i].getBanner_img() + "\" border=\"0\"><br/></a>";
				StrBannerHTML += "</div>";

                intBnrCount++;
            }
        }
    }

    int intRanSearch2 = RandomMain.getRandomValue(9)+1;

    strRanSearchImage = ConfigManager.IMG_ENURI_COM + "/images/event/banner/search_tx_20150605_"+intRanSearch2+".gif";

    if (request.getRequestURI().indexOf("Smilecat.jsp") >= 0 || request.getRequestURI().indexOf("Paxinsu.jsp") >= 0 || request.getRequestURI().indexOf("Flower_Easyflower.jsp") >= 0){
        bExLink = true;
        strExLink = "?exlink=Y";
    }

    String strPageNm = ChkNull.chkStr(request.getParameter("pagenm"));      //페이지구분

    if (request.getRequestURI().indexOf("Index.jsp") >= 0){
        strPageNm = "main";
    }

    boolean onevent = false;
	if(com.enuri.util.date.DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2015.08.06. 00:00")>=0 && com.enuri.util.date.DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2015.09.02. 00:00")<0){
		onevent = true;
	}
%>
<!--자동완성 기능-->
<script language="javaScript">
<!--
var thisimg = 1;
var maximg = <%=intBnrCount%>;
var intRanSearch2 = <%=intRanSearch2%>;
var arrExperience = new Array();

arrExperience.push([12625,'1633']);
arrExperience.push([12624,'1632']);
arrExperience.push([12623,'1631']);
arrExperience.push([12622,'1630']);
arrExperience.push([12603,'1629']);
arrExperience.push([12602,'1628']);
arrExperience.push([12601,'1627']);
arrExperience.push([12600,'1626']);
arrExperience.push([12579,'1624']);

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

jQuery(document).ready(function(){
    document.getElementById("mainTopBanner01").style.display = "";

    // 배너 좌로 이동
    jQuery("#move_banner_left").click(function(){
    	//insertLog(12472);
        document.getElementById("mainTopBanner0" + currImgNum).style.display = "none";
        currImgNum = (currImgNum-1 < 1 ? document.getElementById('bannerList').getElementsByTagName("div").length : (currImgNum-1));

        document.getElementById("mainTopBanner0" + currImgNum).style.display = "";
    });

    // 배너 우로 이동
    jQuery("#move_banner_right").click(function(){
    	//insertLog(12472);
        document.getElementById("mainTopBanner0" + currImgNum).style.display = "none";
        currImgNum = (currImgNum+1 > document.getElementById('bannerList').getElementsByTagName("div").length ? 1 : (currImgNum+1));

        document.getElementById("mainTopBanner0" + currImgNum).style.display = "";
    });

    jQuery("#keyword").keydown(function(){
        changeStyleMainSearch(this,'on');
        oT_Main_search(event);
    }).keyup(function(){
        toggleRemoveKeywodBtn();
    }).mousedown(function(){
        changeStyleMainSearch(this,'on');
        oT_Main_search(event);
    }).blur(function(){
        changeStyleMainSearch(this,'off');
    }).focus(function(){
        cmdLoginLayerHide();
    }).val("<%=request.getServletPath().indexOf("Searchlist.jsp") >= 0 ? (CutStr.cutStr(ChkNull.chkStr(request.getParameter("keyword"),""),2).equals("%u") ? CvtStr.unescape(ChkNull.chkStr(request.getParameter("keyword"),""))  : ChkNull.chkStr(request.getParameter("keyword"),"")) : "" %>")
    <%if(ChkNull.chkStr(request.getParameter("keyword"),"").trim().length() == 0){%>
    .css({"background-image":"url(" + IMG_ENURI_COM + "/images/event/banner/tx_" + arrExperience[intRanSearch2-1][1] + ".gif)","background-repeat":"no-repeat","background-position":"10px <%=intBgTopPos%>px"});
    <%} else {%>
    .css("");
    <%}%>

    <%if(strPageNm.equals("event")){%>
        var $menuList = jQuery("#gnbMenu > li");

        $menuList.each(function(idx){
            $this = jQuery(this);

            if($menuList.length-1 != idx)
                $this.find("a > img").attr("src","<%=ConfigManager.IMG_ENURI_COM %>/2015/gnb_event/gnb_menu0" + (idx+1) + ".gif")
                .parent().mouseenter(function(){
                    $this = $(this).find("img");
                    if($this.attr("src").indexOf("_on")<0) $this.attr("src",$this.attr("src").replace(".gif","_on.gif"));
                })
                .mouseleave(function(){
                    $this = jQuery(this).find("img");
                    $this.attr("src",$this.attr("src").replace("_on.gif",".gif"));
                });
            else
                $this.find("a > img").attr("src","<%=ConfigManager.IMG_ENURI_COM %>/2015/gnb_event/gnb_allmenu.gif");
        });

    <%}%>

    var enuribi = document.getElementById("enuriBi").offsetLeft;
    //심플헤더 가운데 정렬분기
    if(enuribi > 10){
    	if(jQuery(".headerArea"))
    		jQuery(".headerArea").css("margin","0 auto");
    }

    if(jQuery(".toggleAuto")){
    	jQuery('.toggleAuto').click(function(){
	        toggleAutoMake();
	        return false;
	    });
    }
});

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
    this.sImg_Toggle_on = "http://img.enuri.gscdn.com/images/main_2007/search_arr_off.gif";
    this.sImg_Toggle_off = "http://img.enuri.gscdn.com/images/main_2007/search_arr_on.gif";
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

    <%/*if(strPageNm.equals("main")) {%>
    if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 7){
        o.oAc_lyr.style.left  = (calculateOffsetLeft(o.oKeyword) - varAutoComSearchLeft ) + "px";
    }else{
        o.oAc_lyr.style.left  = ((getCumulativeOffset(document.getElementById("keyword"))[0]) - varAutoComSearchLeft ) + "px";
    }
    <%} else {%>
    o.oAc_lyr.style.left  = ((getCumulativeOffset(document.getElementById("keyword"))[0]) - varAutoComSearchLeft) + "px";
    <%}*/%>

    o.oAc_lyr.style.left  = $(".searchForm").position().left+"px";
    o.oAc_lyr.style.top   = $(".searchForm").position().top+$(".searchForm").height()-2+"px";

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

    o.oAc_lyr.style.left  = $(".searchForm").position().left;

    <%/*if(strPageNm.equals("main")) {%>
    if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 7){
        o.oAc_lyr.style.left  = (calculateOffsetLeft(o.oKeyword) - varAutoComSearchLeft ) + "px";
    }else{
        o.oAc_lyr.style.left  = ((getCumulativeOffset(document.getElementById("keyword"))[0]) - varAutoComSearchLeft ) + "px";
    }
    <%} else {%>
    o.oAc_lyr.style.left  = ((getCumulativeOffset(document.getElementById("keyword"))[0]) - varAutoComSearchLeft) + "px";
    <%}*/%>
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
function check2Hyphen(keyword){
    var bReturn = false;
    if (keyword.length >= 2){
        if (keyword.substring(1,2) == "-" || keyword.substring(1,2) == "_" || keyword.substring(1,2) == " "){
            bReturn = true;
        }
    }
    return bReturn;
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
    if (document.fmMainSearch.keyword.style.backgroundImage == "none" || document.fmMainSearch.keyword.style.backgroundImage == ""){
        if(Cmd_formMainSearch()){
            document.fmMainSearch.submit();
        }
    }else{
        insertLog(4986);

        if(intRanSearch2<=arrExperience.length){
            insertLog(arrExperience[(intRanSearch2>arrExperience.length ? 0 : (intRanSearch2-1))][0]);
            top.location.href = "/event/EventReview.jsp?event_idx=" + arrExperience[(intRanSearch2 > arrExperience.length ? 0 : (intRanSearch2-1))][1];
        }

        return false;
    }
}

function changeStyleMainSearch(obj,onoff){
    if (onoff =='off'){
        if (document.fmMainSearch.keyword.value.trim().length == 0 ){

            obj.style.backgroundImage = "url(" + IMG_ENURI_COM + "/images/event/banner/tx_" + arrExperience[(intRanSearch2-1)][1] + ".gif)";
            obj.style.backgroundPosition = "10px <%=intBgTopPos%>px";
            obj.style.backgroundRepeat="no-repeat";

        }
    }else{
        obj.style.backgroundImage ='none';
    }
}
function replace2(src, delWrd){
    var newSrc;
        newSrc = "";
    var i;
    for(i=0;i<src.length;i++){
        if(src.charAt(i) == delWrd) {
            newSrc = newSrc + " ";
        }else{
            newSrc = newSrc + src.charAt(i);
        }
    }
    return newSrc;
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

//메인에서 검색박스에 커서가 가게되면 로그인 레이어를 숨긴다(레이어와 커서가 겹침 2009.03.20 toodoo)
function cmdLoginLayerHide(){
    hideLoginLayer();
}
function removeSearchKeyword(){
    document.fmMainSearch.keyword.value="";
    toggleRemoveKeywodBtn();
    document.fmMainSearch.keyword.focus();
    document.getElementById("ac_layer_main").style.display = "none";

    document.getElementById("btn_search_main_").src = "<%=ConfigManager.IMG_ENURI_COM%>/2012/search/autocom_0724/btn1.gif";

    if (navigator.userAgent.toLowerCase().indexOf('trident') < 0 && BrowserDetect.browser == "Explorer" && BrowserDetect.version ==  7 ){
        document.getElementById("ifr_ac_main").contentWindow.document.location.reload();
    }else{
        oT_Main_search();
    }
}
function toggleRemoveKeywodBtn(){
    if (document.fmMainSearch.keyword.value.trim().length == 0 ){
        document.getElementById("imgToggleAutoMake").style.cursor="default";
    }else{
        var varNowSearchKeyword = document.fmMainSearch.keyword.value.trim();
        var varPrevSearchKeyword = setSearchKeywordByAutocom.varSearchKeywordByAutocom;
        if (typeof(varPrevSearchKeyword) != "undefined"){
            if (varNowSearchKeyword != varPrevSearchKeyword){
                document.fmMainSearch.from.value = ""
                document.getElementById("btn_search_main_").src = "<%=ConfigManager.IMG_ENURI_COM%>/2012/search/autocom_0724/btn1.gif";
            }
        }
    }
}
function toggleAutoMake(){
    if (document.getElementById("ac_layer_main").style.display != "none"){
        document.getElementById("ac_layer_main").style.display = "none";
        document.getElementById("imgToggleAutoMake").src = var_img_enuri_com+"/2014/layout/ico_arrow_down.gif";
    }else{
        oT_Main_search();
        document.getElementById("imgToggleAutoMake").src = var_img_enuri_com+"/2014/layout/ico_arrow_up.gif";
    }
}
function setSearchKeywordByAutocom(keyword,from){
    setSearchKeywordByAutocom.varSearchKeywordByAutocom = keyword;
    document.fmMainSearch.from.value = from;
    document.getElementById("imgToggleAutoMake").src = var_img_enuri_com+"/2014/layout/ico_arrow_down.gif";
}
function setSearchKeywordFocus(keyword,from){
    document.fmMainSearch.keyword.value=keyword;
    document.fmMainSearch.keyword.style.backgroundImage = "none";
    document.fmMainSearch.from.value = from;
    Cmd_MainSearchSubmit();
}
function CmdShowAllMenuHeader(){
   if (top.document.body.scrollTop){
        top.document.body.scrollTop = "0px";
    }else{
        top.document.documentElement.scrollTop = "0px";
    }

    top.document.getElementById("header").scrollIntoView(true);
    loadGnbAllMenu(1);
/*     jQuery("#gnbMenu > li:last-child").trigger("click"); */
}
function goMyPage(url){
    parent.top.location.href=url;
}
-->
</script>
<style>
    div.nowrap {white-space:nowrap;margin:0;padding:0;position:relative;overflow:hidden;}
    #adbox{margin:0px;height:75px;text-align:right;}
    bannerList div {display:none;}
</style>
            <div id='topBannerNew' class="top_banner" style="display:none;">
                <a class="banner_inner" href="javascript://">
                    <button class="btn_close" id="top_banner_closer">닫기</button>
                </a>
            </div>
            <div class="skipMenu">
                <a href="#">상단 메뉴 바로가기</a>
                <a href="#">본문 바로가기</a>
            </div>
            <div class="utilMenu" id="utilMenu">
                <div class="headerArea"><!-- div 추가_simple hearder -->
                    <ul class="sp_header">
                        <li><a href="/deal/newdeal/index.deal"           target="_blank" onclick="insertLog(12160);">소셜비교</a></li>
                        <li><a href="/department/index.jsp"     target="_blank" onclick="insertLog(12160);">백화점비교</a></li>
                        <li><a href="javascript://" class="enuriApp" onclick="onoff('simpleHeader')">에누리 앱 다운로드<%if(onevent){%><span></span><%}%></a></li>
                    </ul>
                    <!-- 심플헤더 -->
                    <%@ include file="/common/jsp/eb/header_app.jsp" %>
                    <!-- 심플헤더 끝-->
                    <ul class="right_navi" id="right_navi">
                        <li id='utilMenuLogin'  style="<%=cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0 ? "display:none;" : ""%>"><a href="#" onclick="setLogintopMygoods(4);Cmd_Login('');document.getElementById('divLoginLayer').style.zIndex='99997';insertLog(4661);">로그인</a></li>
                        <li id="loginDiv2" style="/*background-color:#f3f4f5;*/height:28px;vertical-align:top;overflow:hidden;<%=cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0 ? "":"display:none;"%>">
                            <iframe id="frmMainLogin" name="frmMainLogin" src="/login/Loginstatus_2010.jsp?logintop_menu=top" frameborder=0 style="/*background-color:#f3f4f5;*/width:100px;height:20px;overflow:hidden;margin-right:7px;margin-top:7px;display:none" scrolling="no" onload="this.style.display=''"></iframe>
                        </li>
                        <li id='utilMenuJoin'   style="<%=cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0 ? "display:none;" : ""%>"><a href="#" onclick="insertLog(10519);goJoin()">회원가입</a></li>
                        <li id='utilMenuLogout' style="<%=cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0 ? "" : "display:none;"%>"><a href="#" onclick="javascript:document.getElementById('frmMainLogin').contentWindow.logout();">로그아웃</a></li>
                        <li><a href="#" onclick="insertLog(12165);top.location.href='/knowbox2/index.jsp';return false;">쇼핑지식</a></li>
                        <li><a href="#" class="more" onclick="insertLog(12182);More_layerShow();return false;" id='viewMore'>더보기</a></li>
                    </ul>
                </div><!-- div 추가_simple hearder 끝-->
            </div>
            <!-- 더보기 레이어 -->
            <div class="s_more" id="divViewMore" style="display:none;">
                <a href="#n" class="ly_close" onclick="onoff('divViewMore')">close</a>
                <h2>주요서비스</h2>
                <ul class="service_list first">
                     <li><a href="http://www.enuri.com/department/index.jsp" target="_new">백화점비교</a></li>
                     <li><a href="http://www.enuri.com/deal/main.deal" target="_new">소셜비교</a></li>
                     <!-- <li><a href="#" onclick="insertLog(1502);window.open('/car/Index.jsp?stp=4','','width=1005px, left=0,top=0,toolbar=no,directories=no,status=yes,scrollbars=no,resizable=yes,menubar=no');return false;" href="#">신차비교</a></li> -->
                </ul>
                <ul class="service_list">
                     <li><a href="http://soho.enuri.com/" target="_new">소호스타일</a></li>
                     <li><a href="http://mrkoon.enuri.com/" target="_new">해외직구</a></li>
                     <li><a href="http://itvstyle.enuri.com/" target="_new">TV속 상품</a></li>
                     <li><a href="http://enuri.com/view/move_mall.jsp">이사견적</a></li>
                     <li><a href="http://www.enuri.com/view/Flower365.jsp">꽃배달</a></li>
                     <li><a  href="http://www.enuri.com/view/Insurance_Insvalley.jsp?rtnurl=https://enuri.insvalley.com/join_site/layout/enuri/insu_main.jsp?h_targetPage=/goods/gallerylist.jsp||market_cd=D04||market_point_cd=PLA_20100825004&ac=SNU_B_2010082500003">보험비교</a></li>
                     <li><a href="http://www.enuri.com/tour2012/Tour_Index.jsp">여행비교</a></li>
                </ul>
                <h2>커뮤니티</h2>
                <ul class="service_list">
                     <li><a href="http://www.enuri.com/knowbox/List.jsp">지식통</a></li>
                     <li><a href="http://www.enuri.com/knowbox/List.jsp?kbcate=kbALL&kbcode=kc9">쇼핑Q&A</a></li>
                     <li><a href="http://www.enuri.com/knowbox/planList.jsp">쇼핑기획전</a></li>
                     <li><a href="http://www.enuri.com/knowbox/List.jsp?kbcate=&kbcode=kc8&kbsort=regdate&kbno=0&smart_tap_menu=1&modelno=0&kb_keyword=&page=0&menuno=&iskc9flag=false&iscar=&isGuide=false" >블로그</a></li>
                     <li><a href="http://www.enuri.com/event/EventReviewAll.jsp?status=">체험단</a></li>
                </ul>
                <p class="all_view"><a href="http://www.enuri.com/etc/Site_map.jsp">에누리 서비스 전체보기</a></p>
            </div>
            <!--// 더보기 레이어 -->
            <div id="enuriBi" class="enuriBi">
                <H1 class=logoArea><A onclick="insertLog(10520);top.location.href='/Index.jsp?fromLogo=Y';return false" title="에누리 가격비교" href="#">에누리 가격비교</A></H1>
                <div class="search_new">
                    <span class="searchForm">
                        <form name="fmMainSearch"  method="get" onsubmit="return Cmd_formMainSearch();" style="margin:0px;padding:0px;">
                        <input type="hidden"    name="nosearchkeyword"  value="">
                        <input type="hidden"    name="issearchpage"     value=''>
                        <input type="hidden"    name="searchkind"       value="">
                        <input type="hidden"    name="es"               value="">
                        <input type="hidden"    name="c"                value="">
                        <input type="hidden"    name="ismodelno"        value="">
                        <input type="hidden"    name="hyphen_2"         value="" id="hyphen_2" >
                        <input type="hidden"    name="from"             value="" id="from" >
                        <input type="hidden"    name="owd"              value="" id="owd" >
                        <input name="keyword"  id="keyword" type="text" autocomplete="off" tabIndex="1" class="txt">
                        <a href="#" class="keywordDel">검색어 삭제</a>
                        <a href="#" class="toggleAuto" style="margin-left:-20px" ><img id="imgToggleAutoMake" src="<%=ConfigManager.IMG_ENURI_COM %>/2014/layout/ico_arrow_down.gif"  /></a>
                        <%=(bExLink ? "<input type=hidden name=\"exlink\" value=\"Y\">" : "")%>
                        </form>
                    </span>
                    <a class="searchbtn" href="#" onclick="<%=bIsMain ? "insertLog(10780);" : "" %>insertLog(10521);Cmd_MainSearchSubmit();return false;"></a>
                    <div id="ac_layer_main" name="ac_layer_main" border="0" style="position:absolute;top:44px;left:0;width:<%=intAutoComWidth%>px;background:#fff;border:1px solid #0081e6;display:none">
                        <iframe id="ifr_ac_main" name="ifr_ac_main" src="/search/Autocom_MainSearch_2010.jsp" frameborder="0" marginwidth="0" marginheight="0" topmargin="0" scrolling="no" style="width:100%;height:100%"></iframe>
                    </div>
                    <iframe name="ifrmMainSearch" id="ifrmMainSearch" frameborder="0" style="height:0;width:0;z-index:0;"></iframe>
                </div>
                <div class="headBanner">
                        <!-- 배너 영역 -->
                    <div id="adbox">
                        <div id='bannerList' class="nowrap" style='overflow:hidden;height:75px'><%=StrBannerHTML%></div>
                        <div class=bnr_bullet><span id=move_banner_left>이전</span><span id=move_banner_right>다음</span> </div>
                    </div>
                </div>
            </div>
