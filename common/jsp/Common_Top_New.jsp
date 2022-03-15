<%@ include file="/include/Base_Inc_New.jsp"%>
<style type="text/css">
#header{
	height:44px; 
	width:981px;
	background:url(<%=ConfigManager.IMG_ENURI_COM%>/images/main_2007/main_topbg.gif) no-repeat;overflow:hidden;
	clear:both;
}
#header_con_left {
	float:left;
	width:776;height:42;
}
#header_logo {
	float:left;
	margin-top:10px;margin-left:2px;
	display:inline;	
}
#header_logo_hana {
	float:left;
	margin-left:2px;
	display:inline;	
}
#header_center {
	float:left;
	margin:0 0 0 0;
	height:42;
}
#top_text {
	height:17;
    list-style:none;
    margin:0;
    padding:0
}
#top_text li{
  float:left;
  display:inline;  
}
#top_text .text1 {
	float:left;
} 
#top_text .text2 {
	float:left;
	margin:0 0 0 347;
}

#top_text .text3 {
	float:left;
	margin:0px;
}
#top_text .text4 {
	float:left;
	margin:0 0 0 210;
} 
#top_tabmenu {
    list-style:none;
    margin:0;
    padding:0
}
#top_tabmenu li{
  float:left;
  display:inline;  
}

#MainSearch1 ul{
    list-style:none;
    margin:0;
    padding:0;
}
#MainSearch1 li.01 {
	float:left;
	margin:0;
	padding:0 0 0 3;
}
#MainSearch1 li.02 {
	float:left;
	margin:0;
}
#LayerM_Menu{
	position:absolute; 
	left:-1px; 
	top:-1px; 
	width:0px; 
	height:0px; 
	z-index:99; 
	border-width:1px; 
	border-style:none;
}
#LayerS_Menu{
	position:absolute; 
	left:-1px; 
	top:-1px; 
	width:0px; 
	height:0px; 
	z-index:100; 
	border-width:1px; 
	border-style:none;
}
.hideRightLine{
	left:-1px; 
	top:-1px; 
	width:4;
	height:24;
	background:url(<%=ConfigManager.IMG_ENURI_COM%>/images/main_2007/sscate_bg_10.gif) no-repeat;
	position:absolute;
	z-index:110;
	display:none;
}
.hideRightLineNone{
	left:-1px; 
	top:-1px; 
	width:4;
	height:24;
	background:url(<%=ConfigManager.IMG_ENURI_COM%>/images/main_2007/sscate_bg_11.gif) no-repeat;
	position:absolute;
	z-index:110;
	display:none;
}
.hideRightLineNone_KB{
	left:-1px; 
	top:-1px; 
	width:4;
	height:24;
	background:url(<%=ConfigManager.IMG_ENURI_COM%>/images/main_2007/sscate_bg_12.gif) no-repeat;
	position:absolute;
	z-index:110;
	display:none;
}
.hideLeftLine{
	left:-1px; 
	top:-1px; 
	width:4;
	height:24;
	background:url(<%=ConfigManager.IMG_ENURI_COM%>/images/main_2007/sscate_bg_09.gif) no-repeat;
	position:absolute;
	z-index:110;
	display:none;
}
.mmenu {
    position:absolute;
	z-index:10;
	background-color:#F9FCFD;
	border-right:1px solid #7C9EC3;
	border-bottom:1px solid #7C9EC3;
	border-left:1px solid #7C9EC3;
}
.mmenu_left {
	margin:0;padding:0;
	float:left;
	font-size:12px;
}
.mmenu_left ul{
    list-style:none;
    margin:0;
    padding:0;
	line-height:20px;
	text-align:left;
}
.mmenu_left li.01 {
	color:#1948B4;
	margin:4 0 0 8;
	font-weight:bold;
	border:1px solid #F9FCFD;
}
.mmenu_left li.02 {
	margin:0 0 0 8;
	word-break:break-all;
	cursor:pointer;
	font-family:돋움;	
	color:#3E3E3E;
	border:1px solid #F9FCFD;	
}
.mmenu_left li.over {
	margin:0 5 0 8;
	word-break:break-all;
	cursor:pointer;
	font-family:돋움;	
	color:#3E3E3E;
	border-top:1px solid #3B6089;
	border-right:1px solid #3B6089;
	border-bottom:1px solid #3B6089;
	border-left:1px solid #E7F1FD;
}
.mmenu_right {
	margin:0;
	padding:0;
	float:right;
	font-size:12px;
}
.mmenu_right ul{
    list-style:none;
    margin:0;
    padding:0;
	line-height:20px;
	text-align:right;
}
.mmenu_right li.01 {
	color:#1948B4;
	margin:4 8 0 0;
	font-weight:bold;
	border:1px solid #F9FCFD;
}
.mmenu_right li.02 {
	margin:0 8 0 0;
	word-break:break-all;
	cursor:pointer;
	font-family:돋움;	
	color:#3E3E3E;
	border:1px solid #F9FCFD;
}
.mmenu_right li.over {
	margin:0 7 0 5;
	word-break:break-all;
	cursor:pointer;
	font-family:돋움;	
	color:#3E3E3E;
	border-top:1px solid #3B6089;
	border-left:1px solid #3B6089;
	border-bottom:1px solid #3B6089;
	border-right:1px solid #E7F1FD;
}
#pic_td{
    margin:4 0 0 0;
}
.mcate_text_select{
	/*margin-right:3px;*/
	color:#3E3E3E;
}
#header .size8{
	font-size:8pt;
}
.nsel_div{
    border:1px solid #F9FCFD;
}
.nsel_span{
    border:1px solid #F9FCFD;
}
.kb_nsel_div{
    border:1px solid #FFFFFF;
}
.kb_nsel_span{
    border:1px solid #FFFFFF;
}
.mcate_select{
	width:100%;
	height:100%;
	border-top:1px solid #ffffff;
	border-right:1px solid #C1D5EC;
	border-bottom:1px solid #ffffff;
	border-left:1px solid #E7F1FD;
	background-color:#E7F1FD;
}
.msmenu {

}
.msmenu ul {
	list-style:none;
	margin:0;
	padding:0;
	font-size:9pt;
	background-color:#E7F1FD;
}
.msmenu li {
	margin:0;
	padding:0;
	font-size:9pt;
	line-height:20px;
	font-family:돋움;
}
/*중카테고리-지식통*/
.kb_scate_left {
	z-index:10;
	background-color:#FFFFFF;
	border-right:1px solid #C28CBA;
	border-bottom:1px solid #C28CBA;
	border-left:1px solid #C28CBA;
	width:100%;
	margin:0;
	padding:0;
}
.kb_scate_left ul{
    list-style:none;
	margin:0;
    padding:0;
	font-size:12px;
	text-align:right;
}
.kb_scate_left li.01 {
	color:#D64377;
	margin:4 0 0 8;
	font-weight:bold;
	line-height:20px;
}
.kb_scate_left li.02 {
	cursor:pointer;
	font-family:돋움;	
	color:#3E3E3E;
	border:1px solid #FFFFFF;
	margin:0 8 0 0;
	line-height:20px;	
	background-color:#FFFFFF;
}
.kb_over {
	border-top:1px solid #813D77;
	border-left:1px solid #813D77;
	border-bottom:1px solid #813D77;

	font-family:돋움;	
	color:#3E3E3E;
	margin:0 5 0 8;
	line-height:20px;		
}
.kb_scate_over_bg_right2 {
	cursor:pointer;
	font-family:돋움;	
	color:#D64377;
	border:1px solid #FFFFFF;
	line-height:20px;	
	background:#FFF1FA;
	width:100%;
}

/*소카테고리-지식통*/
.kb_sscate_overline {
	left:-1px; 
	top:-1px; 
	width:4;
	height:24;
	background:url(<%=ConfigManager.IMG_ENURI_COM%>/images/main_2007/sscate_bg_09_pink.gif) no-repeat;
	position:absolute;
	z-index:110;
	display:none;	
}
.kb_sscate_right {
	z-index:11;
}
.kb_sscate_right ul {
	list-style:none;
	margin:0;
	padding:0;
	font-size:12px;
	background-color:#FFF1FA;
	text-align:left;
}
.kb_sscate_right li.txt{
	margin:0 5 0 0;
	cursor:pointer;
}
.kb_sscate_right li.overtxt{
	margin:0 5 0 0;
	color:#ff0000;
	background:url(<%=ConfigManager.IMG_ENURI_COM%>/images/main_2007/sscate_arr.gif) no-repeat center left;
	cursor:pointer;
}
.kbmcate_select{
	width:100%;
	height:100%;
	border-top:1px solid #ffffff;
	border-right:1px solid #FFF1FA;
	border-bottom:1px solid #ffffff;
	border-left:1px solid #EEC3E8;
	background-color:#FFF1FA;
}
.kbmcate_text_select{
	color:#3E3E3E;
}
.kb_sscate_right ul {
	list-style:none;
	margin:0;
	padding:0;
	font-size:12px;
}
.kb_sscate_right li {
	margin:0;
	padding:0;
	font-size:9pt;
	line-height:20px;
	font-family:돋움;
}
.overlay {
	behavior:url(/common/htc/iepngfix.htc);
}
</style>
<%
if (request.getServerName().trim().equals("pmpinside.enuri.com")){ //pmpinside 헤더
%>
<div id="div_pmpinside_header" style="position:absolute;left:0px;top:0px;width:981;background-color:#FFFFFF;"><script language="javascript" src="http://www.pmpinside.com/ws_root/pages/sub/inside_top_enuri.js"></script></div>
<!--상단메뉴-->
<div id=LayerMenu style="position:absolute;width:975;left:0px; top:64px; z-index:2;display:block">
<jsp:include page="/common/jsp/Topmenu.jsp"></jsp:include>
<jsp:include page="/common/jsp/Comm_Status.jsp" flush="true"></jsp:include>
</div>
<%
}else{
%>
<!--상단메뉴-->
<div id=LayerMenu style="position:absolute;width:975;left:0px; top:0px; z-index:2;display:block">
<jsp:include page="/common/jsp/Topmenu.jsp"></jsp:include>
<jsp:include page="/common/jsp/Comm_Status.jsp" flush="true"></jsp:include>
</div>
<%
}
if (request.getServletPath().trim().indexOf("Auto.jsp") < 0){
%>
<!--메인페이지-->
<fieldset id="FSETMAIN" name="FSETMAIN" style="width:100%;height:100%;z-index:1; overflow:auto; background:#ffffff; border:1px ;BORDER-COLOR=#d4d4d4;display:block;" >
<div id="div_fsetmain_blank" style="height:<%if (request.getServerName().trim().equals("pmpinside.enuri.com")){out.print("110");}else{out.print("46");}%>"></div>
<%
}
%>
