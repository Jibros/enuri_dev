<%
	boolean bIsMain = false;
	if(request.getServletPath().indexOf("Index.jsp") >= 0 || request.getServletPath().indexOf("Index1002.jsp") >= 0){
		bIsMain = true;
	}
	boolean bIsNewMain = false;
	if(request.getServletPath().indexOf("Index1002.jsp") >= 0){
		bIsNewMain = true;
	}
	
	int intAutoComWidth = 293;
	String strSearchBtn = ConfigManager.IMG_ENURI_COM + "/2014/layout/btn_search.gif";
	int intBgTopPos = -2;
	if (bIsNewMain){
		strSearchBtn = ConfigManager.IMG_ENURI_COM + "/2014/main/images/btn_search.gif";
		intAutoComWidth = 361;
		intBgTopPos = 9;
	}
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
    
	String enuri_bi_add = "";
	if(com.enuri.util.date.DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2014.08.25. 00:00")>=0 && com.enuri.util.date.DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2014.09.10. 00:00")<0){
		enuri_bi_add = "_chu";
	}
%>
			<div class="skipMenu">
				<a href="#">ìë¨ ë©ë´ ë°ë¡ê°ê¸°</a>
				<a href="#">ë³¸ë¬¸ ë°ë¡ê°ê¸°</a>
			</div>
			<div class="utilMenu"> 
				<ul style='position:relative'>
					<li id='utilMenuLogin'  style="<%=cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0 ? "display:none;" : ""%>"><a href="#" onclick="setLogintopMygoods(4);Cmd_Login('');document.getElementById('divLoginLayer').style.zIndex='99997';insertLog(4661);">ë¡ê·¸ì¸</a></li>
                    <li id="loginDiv2" style="background-color:#f3f4f5;height:28px;vertical-align:top;overflow:hidden;<%=cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0 ? "":"display:none;"%>">
                        <iframe id="frmMainLogin" name="frmMainLogin" src="/login/Loginstatus_2010.jsp?logintop_menu=top" frameborder=0 style="background-color:#f3f4f5;width:100px;height:20px;overflow:hidden;margin-right:7px;margin-top:7px;display:none" scrolling="no" onload="this.style.display=''"></iframe>
                    </li>					
					<li id='utilMenuJoin'   style="<%=cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0 ? "display:none;" : ""%>"><a href="#" onclick="insertLog(10519);goJoin()">íìê°ì</a></li>
					<li id='utilMenuLogout' style="<%=cb.GetCookie("MEM_INFO","USER_ID").trim().length()> 0 ? "" : "display:none;"%>"><a href="#" onclick="javascript:document.getElementById('frmMainLogin').contentWindow.logout();">ë¡ê·¸ìì</a></li>
					<li><a href="#" onclick="insertLog(5759);top.location.href='/knowbox/List.jsp';return false;">ì§ìíµ</a></li>
					<li><a href="#" onclick="insertLog(10071);top.location.href='/knowbox/List.jsp?kbcate=kbALL&kbcode=kc9';return false;">ì¼íQ&amp;A</a></li>
					<li><a href="#" onclick="insertLog(9963);top.location.href='/tour2012/Tour_Index.jsp';return false;">ì¬í</a></li>
					<li><a href="#" onclick="insertLog(1502);window.open('/car/Index.jsp?stp=4','','width=1005px, left=0,top=0,toolbar=no,directories=no,status=yes,scrollbars=no,resizable=yes,menubar=no');return false;">ì ì°¨ë¹êµ</a></li>
					<li><a href="#" onclick="insertLog(10072);More_layerShow();return false;" id='viewMore'>ëë³´ê¸°</a></li>
				</ul>			
			</div>
			<div style='position:absolute;display:none;width:302px;height:103px;padding:10px 5px 7px 10px;font-size:9pt;top:29px;border:1px solid #a0a0a0;z-index:99999;background-color:#fff;line-height:20px' id='divViewMore'>
			    <div style='margin-bottom:7px;'>
			        <table cellpadding=0 border=0 cellspacing=0 style='width:100%;font-weight:bold;font-size:11pt'>
			             <tr>
			                 <td style='text-align:left'>ìëë¦¬ ìë¹ì¤ ëë³´ê¸°</td>
			                 <td onclick="document.getElementById('divViewMore').style.display = 'none'" style='cursor:pointer;text-align:right;padding-right:7px'>X</td>
			             </tr>
			        </table>
			    </div>
                <a style='width:90px;float:left;cursor:pointer' href="/event/Resell.jsp">ê°ë´ìí íë§¤</a>
                <a style='width:90px;float:left;cursor:pointer' href="/view/Insurance_Insvalley.jsp">ë³´íë¹êµ</a>
                <a style='width:90px;float:left;cursor:pointer' href="/view/Insurance_Insvalley.jsp?rtnurl=http://insvalley.enuri.com/join_site/layout/compare/compare_main.jsp?">ìëì°¨ ë³´íë¹êµ</a>
                <a style='width:90px;float:left;cursor:pointer' href="/event/EventReviewAll.jsp?status=">ì²´íë¨</a>
                <a style='width:90px;float:left;cursor:pointer' href="/view/move_mall.jsp">ì´ì¬ê²¬ì </a>
                <a style='width:90px;float:left;cursor:pointer' href="/view/Listbrand.jsp?cate=2112">ì°¨ì¢ë³ ì ì©ìí</a>
                <a style='width:90px;float:left;cursor:pointer' href="/view/Flower365.jsp">ê½ë°°ë¬</a>                
            </div>			     
<%
	String strExpPageList = "/event/Resell.jsp,/knowbox/List.jsp,/knowbox/IssueList.jsp,/knowbox/planList.jsp,/event/EventReviewAll.jsp,/event/EventReview.jsp,/event/EventReviewAllBbs.jsp,/event/EventResellBbs.jsp,/sdul/mallregister/SellerMain.jsp";
	String arrExpPageList[] = strExpPageList.split(",");
	String strExpStyle = "";
	int intCustWidth = 0;
	for (int i=0;i<arrExpPageList.length;i++){
		if (request.getServletPath().trim().indexOf(arrExpPageList[i]) >= 0){
			strExpStyle = "style='min-width:initial;max-width:initial;margin-right:initial;width:1000px;'";
			intCustWidth = 1000;
		}	
	}
	/*
	String strExpPageList1 = "/view/Tour_Tourjockey.jsp";
	String arrExpPageList1[] = strExpPageList1.split(",");
	strExpStyle = "";
	for (int i=0;i<arrExpPageList1.length;i++){
		if (request.getServletPath().trim().indexOf(arrExpPageList1[i]) >= 0){
			strExpStyle = "style='min-width:initial;max-width:initial;margin-right:initial;width:980px;'";
		}	
	}	
	String strExpPageList2 = "/tour2012/Tour_Hotel.jsp";
	String arrExpPageList2[] = strExpPageList1.split(",");
	strExpStyle = "";
	for (int i=0;i<arrExpPageList2.length;i++){
		if (request.getServletPath().trim().indexOf(arrExpPageList2[i]) >= 0){
			strExpStyle = "style='min-width:initial;max-width:initial;margin-right:initial;width:850px;'";
		}	
	}
	*/
	int intRanSearch2 = RandomMain.getRandomValue(8)+1;
	strRanSearchImage = ConfigManager.IMG_ENURI_COM + "/images/event/banner/search_tx_"+intRanSearch2+".gif";		
    if (request.getRequestURI().indexOf("Smilecat.jsp") >= 0 || request.getRequestURI().indexOf("Paxinsu.jsp") >= 0 || request.getRequestURI().indexOf("Flower_Easyflower.jsp") >= 0){
        bExLink = true;
        strExLink = "?exlink=Y";
    }

	String strPageNm = ChkNull.chkStr(request.getParameter("pagenm")); 		//íì´ì§êµ¬ë¶
	if (request.getRequestURI().indexOf("Index.jsp") >= 0){
		strPageNm = "main";
	}  
	//if (strPageNm.equals("main")){
%>
<!--ìëìì± ê¸°ë¥-->
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

//ìëìì± ì°¾ê¸° ë° ì´ë²¤í¸ ì²´í¬.
function Tom(){
	this.version="1.0";
	this.name = "AutoComplete Tom";
	this.oForm = null;							//ê²ìì´ ìë ¥ Formê°ì²´
	this.sCollection = null; //ì½ëì ì ë³´.		//ìëìì± í´ë¹ ì½ëì

	this.oKeyword = null;						//ê²ìí¤ìë ìë ¥ Textê°ì²´
	this.sOldkwd = "";							//ì´ì ê²ìì´
	this.sNewkwd = "";							//ì ê·ê²ìì´
	this.oAc_lyr = null;						//ìëìì± ì ì²´ë ì´ì´ê°ì²´

	this.oAc_ifr = null;						//ìëìì±ì²ë¦¬ íë ìê°ì²´

	this.oImg_Toggle = null;					//ê²ìí¤ìë ìë ¥ Textê°ì²´ì ì°ì¸¡ í ê¸ì´ë¯¸ì§ê°ì²´
	this.sImg_Toggle_on = "http://img.enuri.gscdn.com/images/main_2007/search_arr_off.gif";
	this.sImg_Toggle_off = "http://img.enuri.gscdn.com/images/main_2007/search_arr_on.gif"; 
	this.sSkipWrd = "ã±ã´ã·ã¹ãããããããããã";	//ìëìì± skipë¨ì´
	this.bSkipTF = false;						//ìëìì± skipë¨ì´ ê¸°ë¥ì ì¬ì©í ì§ ì¬ë¶
	this.TimerInterval = 200; 					//ìëìì± ì²´í¬ì£¼ê¸°1000ì´ 1ì´

	this.act =0; 								//ìëìì± ì¤íì¤ì¸ì§ ì¬ë¶ (0:ì í´, 1:ì¤í)
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
	o.oAc_lyr.style.top  = ($(".searchForm").position().top+$(".searchForm").height()+9)+"px";;

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
	
	if (schWrd == "ìëë¦¬ ì¤íë§ì¼"){
		window.open("http://www.enuri.com/minishop/Ms_List_Solo_All_Main.jsp","_blank","width="+window.screen.availWidth+",height="+window.screen.availHeight+",toolbar=yes,directories=no,status=yes,scrollbars=yes,resizable=yes,menubar=yes,location=yes");
		return false;
	}	
	if (obj.nosearchkeyword.value != "Y"){
		if(schLen < 2 && obj.searchkind.value != "4" ){
			if (schLen == 1 && obj.searchkind.value == "" && varExpKeyWord.indexOf(schWrd) >= 0 ){
				obj.searchkind.value = "1";
			}else{
				alert("2ì ì´ìì ê²ìì´ë¥¼ ë£ì¼ì¸ì.\t\t\r\n\í¹ìë¬¸ìë ì ì¸ ë©ëë¤.");
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
		if (<%=intRanSearch2%> == 1 ){
			insertLog(11084); 
			top.location.href = "/event/EventReview.jsp?event_idx=1448";			
		}else if (<%=intRanSearch2%> == 2 ){
			insertLog(11083);
			top.location.href = "/event/EventReview.jsp?event_idx=1447";
		}else if (<%=intRanSearch2%> == 3 ){
			insertLog(11082);
			top.location.href = "/event/EventReview.jsp?event_idx=1444";
		}else if (<%=intRanSearch2%> == 4 ){
			insertLog(11075);
			top.location.href = "/event/EventReview.jsp?event_idx=1446";
		}else if (<%=intRanSearch2%> == 5 ){
			insertLog(11081);
			top.location.href = "/event/EventReview.jsp?event_idx=1443";
		}else if (<%=intRanSearch2%> == 6 ){
			insertLog(11074);
			top.location.href = "/event/EventReview.jsp?event_idx=1445";
		}else if (<%=intRanSearch2%> == 7 ){
			insertLog(11044);
			top.location.href = "/event/EventReview.jsp?event_idx=1442";
		}else if (<%=intRanSearch2%> == 8 ){
			insertLog(11073);
			top.location.href = "/event/EventReview.jsp?event_idx=1441";
		}
		insertLog(4986);
		return false;
	}
}
function changeStyleMainSearch(obj,onoff){
	if (onoff =='off'){
		if (document.fmMainSearch.keyword.value.trim().length == 0 ){
			obj.style.backgroundImage ='url(<%=strRanSearchImage%>)';
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
//ë©ì¸ìì ê²ìë°ì¤ì ì»¤ìê° ê°ê²ëë©´ ë¡ê·¸ì¸ ë ì´ì´ë¥¼ ì¨ê¸´ë¤(ë ì´ì´ì ì»¤ìê° ê²¹ì¹¨ 2009.03.20 toodoo)
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
	if (top.document.body.scrollTop){
		top.document.body.scrollTop = "0px";
	}else{
		top.document.documentElement.scrollTop = "0px";
	}		
	jQuery("#gnb > ul > .allMenuBtn > a").trigger("click");	
}
-->
</script>
<style>
div.nowrap {white-space:nowrap;margin:0;padding:0;position:relative;overflow:hidden;}
#adbox{margin:0px;height:75px;text-align:right;}
bannerList div {display:none;}
</style>
<%
	//}
%>
			<div class="enuriBi" <%=strExpStyle%>>
				<h1 class="<%=enuri_bi_add%>"><a href="#" onclick="insertLog(10520);top.location.href='/Index.jsp?fromLogo=Y';return false" title="ìëë¦¬ íì¼ë¡ ë°ë¡ì´ë"><img src="<%=ConfigManager.IMG_ENURI_COM %>/2014/layout/logo_enuri<%=enuri_bi_add%>.gif" alt="eNuri ì¸ìì ëª¨ë  ìµì ê° ìëë¦¬ ê°ê²©ë¹êµ" /></a></h1>
				<div class="search">
					<span class="searchForm">
						<form name="fmMainSearch"  method="get" onsubmit="return Cmd_formMainSearch();" style="margin:0px;padding:0px;">
						<input type="hidden" name="nosearchkeyword" value="">
		                <input type="hidden" name="issearchpage" value=''>
		                <input type="hidden" name="searchkind" value="">
		                <input type="hidden" name="es" value="">
		                <input type=hidden name="c" value="">
		                <input type=hidden name="ismodelno" value="">
		                <input type="hidden" id="hyphen_2" name="hyphen_2" value="">                        
		                <input type="hidden" id="from" name="from" value="">						
		                <input type="hidden" id="owd" name="owd" value="">
						<input name="keyword"  id="keyword" type="text" autocomplete="off"
<%
		if(request.getServletPath().indexOf("Searchlist.jsp") >= 0 ){
%>
							value="<%= CutStr.cutStr(ChkNull.chkStr(request.getParameter("keyword"),""),2).equals("%u") ? CvtStr.unescape(ChkNull.chkStr(request.getParameter("keyword"),""))  : ChkNull.chkStr(request.getParameter("keyword"),"") %>"
<%
		}else{
%>
							value=""
<%		
		}
%>
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
							style="background-image:url(<%=strRanSearchImage%>);background-repeat:no-repeat;background-position:10px <%=intBgTopPos%>px; "
<%
		}
%>
						>	
						<a href="#" class="keywordDel">ê²ìì´ ì­ì </a>
						<a href="#" class="toggleAuto" style="margin-left:-20px" ><img id="imgToggleAutoMake" src="<%=ConfigManager.IMG_ENURI_COM %>/2014/layout/bg_arrow6.gif"  /></a>
<%
        if(bExLink){
%>
                		<input type=hidden name="exlink" value="Y">
<%
        }
%>
						</form>
										</span>
					<a href="#" onclick="insertLog(10521);Cmd_MainSearchSubmit();return false;"><img src="<%=strSearchBtn%>" alt="ê²ì" /></a>
					<div id="ac_layer_main" name="ac_layer_main" border="0" style="position:absolute;top:41px;left:0;width:<%=intAutoComWidth%>px;background:#fff;border:1px solid #0081e6;display:none">
					<iframe id="ifr_ac_main" name="ifr_ac_main" src="/search/Autocom_MainSearch_2010.jsp" frameborder="0" marginwidth="0" marginheight="0" topmargin="0" scrolling="no" style="width:100%;height:100%"></iframe>
					</div>
					<iframe name="ifrmMainSearch" id="ifrmMainSearch" frameborder="0" style="height:0;width:0;z-index:0;"></iframe>
				</div>
				<div class="headBanner">
                        <!-- ë°°ë ìì­ -->
                    <div id="adbox">
                        <div id='bannerList' class="nowrap" style='overflow:hidden;height:78px'><%=StrBannerHTML%></div>
                        <div style='position:relative;display:block;right:10px;top:-17px;font-size:0px;'>
                            <span id='move_banner_left'  style='cursor:pointer;display:inline-block;background:url(<%=ConfigManager.IMG_ENURI_COM %>/images/main/2014/btn_left.gif) no-repeat;width:15px;height:14px'></span>
                            <span id='move_banner_right' style='cursor:pointer;display:inline-block;background:url(<%=ConfigManager.IMG_ENURI_COM %>/images/main/2014/btn_right.gif) no-repeat;width:15px;height:14px'></span>
                        </div>                        
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

                var thisimg = 1;
                var maximg = <%=intBnrCount%>;
<%
				if(request.getServletPath().indexOf("Tour_Index.jsp") >= 0 ){
%>
				jQuery(document).ready(function(){              
				    //setInterval(imgrotation, 3000);
				    document.getElementById("mainTopBanner01").style.display = "";
				
				    // ë°°ë ì¢ë¡ ì´ë
				    jQuery("#move_banner_left").click(function(){
				        document.getElementById("mainTopBanner0" + currImgNum).style.display = "none";
				        currImgNum = (currImgNum-1 < 1 ? document.getElementById('bannerList').getElementsByTagName("div").length : (currImgNum-1));
				
				        document.getElementById("mainTopBanner0" + currImgNum).style.display = "";
				    });
				
				    // ë°°ë ì°ë¡ ì´ë
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
                    jQuery("#mainTopBanner0"+thisimg).fadeOut('slow', function(){
                        nextimg = getnextimg(thisimg);
                        jQuery("#mainTopBanner0"+nextimg).fadeIn('slow');
                        thisimg = nextimg;
                    });
                }                
<%
				}else{
%>
                jQuery(document).ready(function(){            	
                    //setInterval(imgrotation, 3000);
                    document.getElementById("mainTopBanner01").style.display = "";

                    // ë°°ë ì¢ë¡ ì´ë
                    jQuery("#move_banner_left").click(function(){
                        document.getElementById("mainTopBanner0" + currImgNum).style.display = "none";
                        currImgNum = (currImgNum-1 < 1 ? document.getElementById('bannerList').getElementsByTagName("div").length : (currImgNum-1));

                        document.getElementById("mainTopBanner0" + currImgNum).style.display = "";
                    });

                    // ë°°ë ì°ë¡ ì´ë
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
                    jQuery("#mainTopBanner0"+thisimg).fadeOut('slow', function(){
                        nextimg = getnextimg(thisimg);
                        jQuery("#mainTopBanner0"+nextimg).fadeIn('slow');
                        thisimg = nextimg;
                    });
                }                
<%
				}
%>

                </script>
            </div>
			<div id="gnb" >
				<ul id="gnbMenu" class="gnbMenu" <%=strExpStyle%>>
<%if(request.getServerName().trim().equals("124.243.126.151") || request.getServerName().trim().equals("dev.enuri.com")){%>
				<jsp:include page="/common/jsp/Ajax_Gnb_Src_2014.jsp" flush="true"></jsp:include>
				<script type="text/javascript">
				<jsp:include page="/common/jsp/Ajax_Gnb_Src_2014.jsp" flush="true">
				<jsp:param name="stype" value="banner"/>
				</jsp:include>
				</script>
<%}else{%>
				<%//@ include file="/common/jsp/Ajax_Gnb_Default.jsp"%>
				<jsp:include page="/common/jsp/Ajax_Gnb_Src_2014.jsp" flush="true"></jsp:include>
<%}%>
				</ul>
				<!-- 3depth ìì¸íë³´ê¸° ìì­ -->
				<div id="depth3Detail">
					<ul id="depth3Detail_1" seq="1"></ul>
					<ul id="depth3Detail_2" seq="2"></ul>
					<ul id="depth3Detail_3" seq="3"></ul>
					<ul id="depth3Detail_4" seq="4"></ul>
					<ul id="depth3Detail_5" seq="5"></ul>
					<ul id="depth3Detail_6" seq="6"></ul>
					<p class="detailClose"><a href="#">ìì¸íë³´ê¸° ë«ê¸°</a></p>
				</div>
				<!-- //3depth ìì¸íë³´ê¸° ìì­ -->
				<!-- ì ì²´ë©ë´ -->
				<div id="allMenu"></div>
				<!-- //ì ì²´ë©ë´ -->
<%
		if (intCustWidth > 0 ){
%>
				<script language="javascript">
					$("#allMenu").css("minWidth","initial");
					$("#allMenu").css("maxWidth","initial");
					$("#allMenu").css("marginRight","initial");
					$("#allMenu").css("width","<%=intCustWidth%>px");
				</script>
<%
		}
%>
			</div>
			<div style="background-color:#f3f4f5;border-bottom:1px solid #e7e7e7;width:4px;height:29px;position:absolute;left:0px;top:0px;"></div>