<%
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

	String strExpStyle = "style='min-width:initial;max-width:initial;margin-right:initial;width:"+intHeaderWidth+"px;'";
	boolean bIe = false;
  	if(ChkNull.chkStr(request.getHeader("User-Agent")).toLowerCase().indexOf("msie")>-1 || ChkNull.chkStr(request.getHeader("User-Agent")).toLowerCase().indexOf("trident")>-1){
  		bIe = true;

   	}
    boolean bExLink = false;
    if (request.getRequestURI().indexOf("Smilecat.jsp") >= 0 || request.getRequestURI().indexOf("Paxinsu.jsp") >= 0 || request.getRequestURI().indexOf("Flower_Easyflower.jsp") >= 0){
        bExLink = true;
    }
	//int intRanSearch2 = RandomMain.getRandomValue(6)+1;
	//strRanSearchImage = ConfigManager.IMG_ENURI_COM + "/images/event/banner/search_tx_event_"+intRanSearch2+".gif";

	int intRanSearch2 = RandomMain.getRandomValue(6)+1;
	strRanSearchImage = ConfigManager.IMG_ENURI_COM + "/images/event/banner/search_tx_event_"+intRanSearch2+".gif";

	String enuri_bi_add = "";
	if(com.enuri.util.date.DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2014.08.25. 00:00")>=0 && com.enuri.util.date.DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2014.09.10. 00:00")<0){
		enuri_bi_add = "_chu";
	}
%>
<!--�ڵ��ϼ� ���-->
<script language="javaScript">
<!--

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

//�ڵ��ϼ� ã�� �� �̺�Ʈ üũ.
function Tom(){
	this.version="1.0";
	this.name = "AutoComplete Tom";
	this.oForm = null;							//�˻��� �Է� Form��ü
	this.sCollection = null; //�ݷ��� ����.		//�ڵ��ϼ� �ش� �ݷ���

	this.oKeyword = null;						//�˻�Ű���� �Է� Text��ü
	this.sOldkwd = "";							//�����˻���
	this.sNewkwd = "";							//�ű԰˻���
	this.oAc_lyr = null;						//�ڵ��ϼ� ��ü���̾ü

	this.oAc_ifr = null;						//�ڵ��ϼ�ó�� �����Ӱ�ü

	this.oImg_Toggle = null;					//�˻�Ű���� �Է� Text��ü�� ���� ����̹�����ü
	this.sImg_Toggle_on = "http://img.enuri.info/images/main_2007/search_arr_off.gif";
	this.sImg_Toggle_off = "http://img.enuri.info/images/main_2007/search_arr_on.gif";
	this.sSkipWrd = "����������������������������";	//�ڵ��ϼ� skip�ܾ�
	this.bSkipTF = false;						//�ڵ��ϼ� skip�ܾ� ����� ������� ����
	this.TimerInterval = 200; 					//�ڵ��ϼ� üũ�ֱ�1000�� 1��

	this.act =0; 								//�ڵ��ϼ� ���������� ���� (0:����, 1:����)
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
	/*
	if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 7){
		o.oAc_lyr.style.top   = (calculateOffsetTop(o.oKeyword)+ o.oKeyword.offsetHeight+1)+ "px";
	}else{
		o.oAc_lyr.style.top   = (calculateOffsetTop(o.oKeyword)+ o.oKeyword.offsetHeight+2)+ "px";
	}
	*/
	o.oAc_lyr.style.left  = $(".searchForm").position().left+"px";
	o.oAc_lyr.style.top  = ($(".searchForm").position().top+$(".searchForm").height()+11)+"px";;

	var varAutoW = 46;
	if (BrowserDetect.browser == "Explorer" ){
		varAutoW = 44;
	}

	//o.oAc_lyr.style.width = (o.oKeyword.offsetWidth+varAutoW) + "px";
	o.oAc_lyr.style.display = "none" ;
	//o.oAc_ifr.style.width = (o.oKeyword.offsetWidth+varAutoW) + "px";
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

	//if (document.getElementById("li_search_7").style.display != "none"){
	//	varAutoComSearchLeft = 29;
	//}
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
	//CmdHideMenu();
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

	if (schWrd == "������ ���¸���"){
		window.open("http://www.enuri.com/minishop/Ms_List_Solo_All_Main.jsp","_blank","width="+window.screen.availWidth+",height="+window.screen.availHeight+",toolbar=yes,directories=no,status=yes,scrollbars=yes,resizable=yes,menubar=yes,location=yes");
		return false;
	}
	if (obj.nosearchkeyword.value != "Y"){
		if(schLen < 2 && obj.searchkind.value != "4" ){
			if (schLen == 1 && obj.searchkind.value == "" && varExpKeyWord.indexOf(schWrd) >= 0 ){
				obj.searchkind.value = "1";
			}else{
				alert("2�� �̻��� �˻�� ��������.\t\t\r\n\Ư�����ڴ� ���� �˴ϴ�.");
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
	document.fmMainSearch.keyword.value = escape(schWrdExp);
	//document.fmMainSearch.keyword.value = schWrdExp;
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
	if (document.fmMainSearch.keyword.style.backgroundImage == "none"){
		if(Cmd_formMainSearch()){
			document.fmMainSearch.submit();
		}
	}else{
		if (<%=intRanSearch2%> == 1 ){
			insertLog(11478);
			top.location.href = "/event/EventReview.jsp?event_idx=1483";
		}else if (<%=intRanSearch2%> == 2 ){
			insertLog(11477);
			top.location.href = "/event/EventReview.jsp?event_idx=1482";
		}else if (<%=intRanSearch2%> == 3 ){
			insertLog(11316);
			top.location.href = "/event/EventReview.jsp?event_idx=1479";
		}else if (<%=intRanSearch2%> == 4 ){
			insertLog(11476);
			top.location.href = "/event/EventReview.jsp?event_idx=1481";
		}else if (<%=intRanSearch2%> == 5 ){
			insertLog(11315);
			top.location.href = "/event/EventReview.jsp?event_idx=1478";
		}else if (<%=intRanSearch2%> == 6 ){
			insertLog(11475);
			top.location.href = "/event/EventReview.jsp?event_idx=1480";
		}else if (<%=intRanSearch2%> == 7 ){
			insertLog(11314);
			top.location.href = "/event/EventReview.jsp?event_idx=1477";
		}else if (<%=intRanSearch2%> == 8 ){
			insertLog(11313);
			top.location.href = "/event/EventReview.jsp?event_idx=1476";
		}else if (<%=intRanSearch2%> == 8 ){
			insertLog(11312);
			top.location.href = "/event/EventReview.jsp?event_idx=1475";
		}
		insertLog(4986);
		return false;
	}
}
function changeStyleMainSearch(obj,onoff){
	if (onoff =='off'){
		if (document.fmMainSearch.keyword.value.trim().length == 0 ){
			obj.style.backgroundImage ='url(<%=strRanSearchImage%>)';
			obj.style.backgroundPosition = "10px -2px";
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
<%
	String strGoSearchRanUrl = "";
	String strLogNo = "";

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

%>
	insertLog(<%=strLogNo%>);
	location.href = "<%=strGoSearchRanUrl%>";
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
//���ο��� �˻��ڽ��� Ŀ���� ���ԵǸ� �α��� ���̾ �����(���̾�� Ŀ���� ��ħ 2009.03.20 toodoo)
function cmdLoginLayerHide(){
	hideLoginLayer();
}
function removeSearchKeyword(){
	document.fmMainSearch.keyword.value="";
	toggleRemoveKeywodBtn();
	document.fmMainSearch.keyword.focus();
	document.getElementById("ac_layer_main").style.display = "none";
	//document.getElementById("imgToggleAutoMake").src = var_img_enuri_com + "/2012/search/autocom_1010/amt_none.png";
	//document.getElementById("imgToggleAutoMake").style.cursor="default";
	document.getElementById("btn_search_main_").src = "<%=ConfigManager.IMG_ENURI_COM%>/2012/search/autocom_0724/btn1.gif";


	if (navigator.userAgent.toLowerCase().indexOf('trident') < 0 && BrowserDetect.browser == "Explorer" && BrowserDetect.version ==  7 ){
		document.getElementById("ifr_ac_main").contentWindow.document.location.reload();
	}else{
		oT_Main_search();
	}
}
function toggleRemoveKeywodBtn(){
	if (document.fmMainSearch.keyword.value.trim().length == 0 ){
		//document.getElementById("li_search_7").style.display = "none";
		//document.getElementById("imgToggleAutoMake").src = var_img_enuri_com + "/2012/search/autocom_1010/amt_none.png";
		document.getElementById("imgToggleAutoMake").style.cursor="default";
	}else{
		//document.getElementById("li_search_7").style.display = "";
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
	/*
	if (document.getElementById("imgToggleAutoMake").src == (var_img_enuri_com + "/2012/search/autocom_1010/amt_none.png")){
		if (document.getElementById("ac_layer_main").style.display != "none"){
			document.getElementById("ac_layer_main").style.display = "none";
		}
		return;
	}
	*/
	if (document.getElementById("ac_layer_main").style.display != "none"){
		document.getElementById("ac_layer_main").style.display = "none";
		document.getElementById("imgToggleAutoMake").src = var_img_enuri_com+"/2014/layout/bg_arrow6.gif";
	}else{
		oT_Main_search();
		document.getElementById("imgToggleAutoMake").src = var_img_enuri_com+"/2014/layout/bg_arrow7.gif";
	}
}
function setSearchKeywordByAutocom(keyword,from){
	setSearchKeywordByAutocom.varSearchKeywordByAutocom = keyword;
	document.fmMainSearch.from.value = from;
	document.getElementById("imgToggleAutoMake").src = var_img_enuri_com+"/2014/layout/bg_arrow6.gif";
}
function setSearchKeywordFocus(keyword,from){
	document.fmMainSearch.keyword.value=keyword;
	document.fmMainSearch.keyword.style.backgroundImage = "none";

	document.fmMainSearch.from.value = from;
	Cmd_MainSearchSubmit();
}
function CmdShowAllMenuHeader(){
	/*
    if (top.document.body.scrollTop){
        top.document.body.scrollTop = "0px";
    }else{
        top.document.documentElement.scrollTop = "0px";
    }
    */
    top.document.getElementById("header").scrollIntoView(true);
    jQuery("#gnb > ul > .allMenuBtn > a").trigger("click");
}
-->
</script>
<style>
div.nowrap {white-space:nowrap;margin:0;padding:0;position:relative;overflow:hidden;}
#adbox{margin:0px;height:75px;text-align:right;}
bannerList div {display:none;}
</style>
			<div id='topBannerNew' style='width:100%;display:none;'>
				<div style='background:url(<%=ConfigManager.IMG_ENURI_COM%>/images/event/2014/prd/top_banner.jpg) no-repeat 50% 0;position:relative;overflow:hidden;height:70px;cursor:pointer;z-index:1;' onclick="fnGoStampEventPage();">
					<div style='position:relative; width:1000px; height:70px; margin:0 auto;'><span style='position:absolute;right:5px;top:20px;width:27px;height:27px;border:0px;margin:0px;cursor:pointer;display:block;' onclick="fnCloseTopBanner();"></span></div>
				</div>
			</div>
			<div class="skipMenu">
				<a href="#">��� �޴� �ٷΰ���</a>
				<a href="#">���� �ٷΰ���</a>
			</div>
			<div class="utilMenu" >
				<ul <%=strExpStyle%>>
                    <li id='utilMenuLogin'><a href="#" onclick="setLogintopMygoods(4);Cmd_Login('new_top');document.getElementById('divLoginLayer').style.zIndex='99997';insertLog(4661);return false;">�α���</a></li>
					<li id='utilMenuJoin'   style="<%=cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0 ? "display:none;" : ""%>"><a href="#" onclick="insertLog(10519);goJoin()">ȸ������</a></li>
					<li id='utilMenuLogout' style="<%=cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0 ? "" : "display:none;"%>"><a href="#" onclick="javascript:document.getElementById('frmMainLogin').contentWindow.logout();">�α׾ƿ�</a></li>
					<li><a href="#" onclick="insertLog(5759);top.location.href='/knowbox/List.jsp';return false;">������</a></li>
					<li><a href="#" onclick="insertLog(10071);top.location.href='/knowbox/List.jsp?kbcate=kbALL&kbcode=kc9';return false;">����Q&amp;A</a></li>
					<li><a href="#" onclick="insertLog(1502);window.open('/car/Index.jsp?stp=4','','width=1005px menubar=no status=no resizable=yes');return false;">������</a></li>
					<li><a href="#" onclick="insertLog(10072);More_layerShow();return false;" id='viewMore'>������</a></li>
				</ul>
			</div>
			<div class="enuriBi" <%=strExpStyle%>>
				<h1 class="<%=enuri_bi_add%>"><a href="#" onclick="insertLog(10520);top.location.href='/Index.jsp?fromLogo=Y';return false" title="������"><img src="<%=ConfigManager.IMG_ENURI_COM %>/2014/layout/logo_enuri<%=enuri_bi_add%>.gif" alt="������" /></a></h1>
				<div class="search">
					<span class="searchForm">
						<form name="fmMainSearch"  method="get" OnSubmit="return Cmd_formMainSearch();" style="margin:0px;padding:0px;">
						<input type="hidden" name="nosearchkeyword" value="">
		                <input type="hidden" name="issearchpage" value=''>
		                <input type="hidden" name="searchkind" value="">
		                <input type="hidden" name="es" value="">
		                <input type=hidden name="c" value="">
		                <input type=hidden name="ismodelno" value="">
		                <input type="hidden" id="hyphen_2" name="hyphen_2" value="">
		                <input type="hidden" id="from" name="from" value="">
						<input name="keyword"  id="keyword" type="text" autocomplete="off" value=""
							tabIndex="1"
							onkeydown="changeStyleMainSearch(this,'on');oT_Main_search(event);"
							onkeyup="toggleRemoveKeywodBtn()";
							onmousedown = "changeStyleMainSearch(this,'on');oT_Main_search(event);"
							onBlur="changeStyleMainSearch(this,'off');"
							onfocus="cmdLoginLayerHide();"
							class="txt"
<%
		if(ChkNull.chkStr(request.getParameter("keyword"),"").trim().length() == 0){
%>
							style="background-image:url(<%=strRanSearchImage%>);background-repeat:no-repeat;background-position:10px -2px; "
<%
		}
%>
						>
						<a href="#" class="keywordDel">�˻��� ����</a>
						<a href="#" class="toggleAuto" style="margin-left:-20px"><img id="imgToggleAutoMake" src="<%=ConfigManager.IMG_ENURI_COM %>/2014/layout/bg_arrow6.gif"  /></a>
<%
        if(bExLink){
%>
                		<input type=hidden name="exlink" value="Y">
<%
        }
%>
						</form>
										</span>
					<a href="#" onclick="insertLog(10521);Cmd_MainSearchSubmit();return false;"><img src="<%=ConfigManager.IMG_ENURI_COM %>/2014/layout/btn_search.gif" alt="�˻�" /></a>
					<div id="ac_layer_main" name="ac_layer_main" border="0" style="position:absolute;top:41px;left:0;width:293px;background:#fff;border:1px solid #0081e6;display:none">
					<iframe id="ifr_ac_main" name="ifr_ac_main" src="/search/Autocom_MainSearch_2010.jsp" frameborder="0" marginwidth="0" marginheight="0" topmargin="0" scrolling="no" style="width:100%;height:100%"></iframe>
					</div>
					<iframe name="ifrmMainSearch" id="ifrmMainSearch" frameborder="0" style="height:0;width:0;z-index:0;"></iframe>
				</div>
                <div class="headBanner">
	                <!-- ��� ���� -->
	                <div id='bannerList' class="nowrap" style='overflow:hidden;height:78px'><%=StrBannerHTML%></div>
	                <div style='position:relative;display:block;right:10px;top:-17px;font-size:0px;text-align:right'>
	                    <span id='move_banner_left'  style='cursor:pointer;display:inline-block;background:url(<%=ConfigManager.IMG_ENURI_COM %>/images/main/2014/btn_left.gif) no-repeat;width:15px;height:14px'></span>
	                    <span id='move_banner_right' style='cursor:pointer;display:inline-block;background:url(<%=ConfigManager.IMG_ENURI_COM %>/images/main/2014/btn_right.gif) no-repeat;width:15px;height:14px'></span>
	                </div>
                </div>
                <script language="JavaScript">
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
				/** ��� **/

				var thisimg = 1;
				var maximg = <%=intBnrCount%>;
                jQuery(document).ready(function(){
                    //setInterval(imgrotation, 3000);
                    document.getElementById("mainTopBanner01").style.display = "";

                    // ��� �·� �̵�
                    jQuery("#move_banner_left").click(function(){
                        document.getElementById("mainTopBanner0" + currImgNum).style.display = "none";
                        currImgNum = (currImgNum-1 < 1 ? document.getElementById('bannerList').getElementsByTagName("div").length : (currImgNum-1));

                        document.getElementById("mainTopBanner0" + currImgNum).style.display = "";
                    });

                    // ��� ��� �̵�
                    jQuery("#move_banner_right").click(function(){
                        document.getElementById("mainTopBanner0" + currImgNum).style.display = "none";
                        currImgNum = (currImgNum+1 > document.getElementById('bannerList').getElementsByTagName("div").length ? 1 : (currImgNum+1));

                        document.getElementById("mainTopBanner0" + currImgNum).style.display = "";
                    });
                });

				function getnextimg(ix){
    				if(ix+1>maximg) return 1;
    				return ix+1;
				}

				function imgrotation(){
    				$("#mainTopBanner0"+thisimg).fadeOut('slow', function(){
        				nextimg = getnextimg(thisimg);
        				$("#mainTopBanner0"+nextimg).fadeIn('slow');
        				thisimg = nextimg;
    				});
				}
                </script>
			</div>
			<div id="gnb">
				<ul id="gnbMenu" class="gnbMenu" <%=strExpStyle%>>
<%if(request.getServerName().trim().equals("dev.enuri.com")){%>
				<jsp:include page="/common/jsp/Ajax_Gnb_Src_kr.jsp" flush="true"></jsp:include>
				<script type="text/javascript">
				<jsp:include page="/common/jsp/Ajax_Gnb_Src_kr.jsp" flush="true">
				<jsp:param name="stype" value="banner"/>
				</jsp:include>
				</script>
<%}else{%>
				<%@ include file="/common/jsp/Ajax_Gnb_Default_kr.jsp"%>
<%}%>
				</ul>
				<!-- 3depth �ڼ������� ���� -->
				<div id="depth3Detail">
					<ul id="depth3Detail_1" seq="1"></ul>
					<ul id="depth3Detail_2" seq="2"></ul>
					<ul id="depth3Detail_3" seq="3"></ul>
					<ul id="depth3Detail_4" seq="4"></ul>
					<ul id="depth3Detail_5" seq="5"></ul>
					<ul id="depth3Detail_6" seq="6"></ul>
					<p class="detailClose"><a href="#">�ڼ������� �ݱ�</a></p>
				</div>
				<!-- //3depth �ڼ������� ���� -->
				<!-- ��ü�޴� -->
				<div id="allMenu"></div>
				<!-- //��ü�޴� -->
				<script language="javascript">
					if($("#allMenu").length){
						$("#allMenu").css("minWidth","initial");
						$("#allMenu").css("maxWidth","initial");
						$("#allMenu").css("marginRight","initial");
						$("#allMenu").css("width","<%=intHeaderWidth%>px");
					}
					if($("#depth3Detail").length){
						$("#depth3Detail").css("minWidth","initial");
						$("#depth3Detail").css("maxWidth","initial");
						$("#depth3Detail").css("marginRight","initial");
						$("#depth3Detail").css("width","<%=intHeaderWidth%>px");
					}
				</script>
			</div>
			<div style="background-color:#f3f4f5;border-bottom:1px solid #e7e7e7;width:4px;height:29px;position:absolute;left:0px;top:0px;"></div>