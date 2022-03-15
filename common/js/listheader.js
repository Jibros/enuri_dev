var selectedMenu = ""; 
var var_image_enuri_com = "http://image.enuri.info";

var dcate_over = "";
var dcate_click = "";

var L_position1 = "";
var L_position2 = "";
var L_position3 = "";
var L_position4 = "";
var L_position5 = "";
 
var cate_org = "";
var spread_cate = "";
var spread_cate_org = "";

// 현재 선택된 패션 cate 
var currentCate = ""; 
var curStyle = ""; 

function init(){
	if (!top.document.getElementById("enuriMenuFrame")){
		var params = window.location.search.substring( 1 ).split( '&' );
		var cate;
		for( var i = 0, l = params.length; i < l; ++i ) {
			var parts = params[i].split( '=' );
			switch( parts[0] ) {
				case 'cate':
				cate =  parts[1];
				break;
			}
  		}
  		top.location.href = "List.jsp?cate="+cate
	}
	setPositionCategory();
}
function cmdClickMaterpiece_factory(strCate,factory,factory_length, select_factory){
	var var_keyword = "";
	var var_mprice = "";
	var var_Factory = "<%=strFactory%>"+"";
	if(var_Factory!=""){
		if(var_Factory==factory){
			var_keyword="<%=strKeyword%>";
			var_mprice = "<%=strMPrice%>";
		}
	}
	for(var i=0; i < factory_length; i++) {
		document.getElementById("cateByFactory_"+i).onmouseover = function(){
			this.style.color="#BD0F0E";
		}
		document.getElementById("cateByFactory_"+i).onmouseout = function(){
			this.style.color="#000000";
		}
		document.getElementById("cateByFactory_"+i).className = "no_sel_brand_masterpiece";
		document.getElementById("cateByFactory_"+i).style.color="#000000";
		document.getElementById("cateByFactory_"+i).style.fontWeight ="normal";
	}
	document.getElementById("cateByFactory_"+select_factory).onmouseover = function(){
		this.style.color="#BD0F0E";
	}
	document.getElementById("cateByFactory_"+select_factory).onmouseout = function(){
		this.style.color="#BD0F0E";
	}
	document.getElementById("cateByFactory_"+select_factory).className = "sel_brand_masterpiece";
	document.getElementById("cateByFactory_"+select_factory).style.color="#BD0F0E";
	document.getElementById("cateByFactory_"+select_factory).style.fontWeight ="bold";
	document.getElementById("enuriListFrame").src = "/view/Listbody_Fusion_Masterpiece.jsp?cate="+strCate+"&factory="+factory+"&selectFactory="+select_factory+"&keyword="+var_keyword+"&m_price="+var_mprice;
}

function getFactoryName(strCate,factory){
	/*
	for (i=1;i<9;i++){
		document.getElementById("span_ganada"+i).className = "no_sel_ganada";
		//document.getElementById("brand_arr"+i).style.display = "none";
	}
	document.getElementById("span_ganada"+ganada).className = "sel_ganada";
	*/

	//document.getElementById("brand_arr"+ganada).style.display = "inline";
	
	//if (document.getElementById("ganada"+ganada).innerHTML == ""){//스크롤 무조건 상위 가게 하려고 주석 처리했음
		var url_i = "/view/fusion/include/getFactoryNames_Fashion_Masterpiece.jsp";
		var param_i = "cate="+strCate+"&factory="+factory;
		var getAjaxProd = new Ajax.Request(
			url_i,
			{
				method:'get',parameters:param_i,onComplete:showFactory_Fashion_Masterpiece
			}
		);	
	/*
	}else{
		for (i=1;i<9;i++){
			document.getElementById("ganada"+i).style.display = "none";
			if(document..getElementById("div_dcatelayer")){
				alert("aaa1");
				document.getElementById("div_dcatelayer").scrollTop = 0;
			}
		}			
		document.getElementById("ganada"+ganada).style.display = "inline";
	}
	*/
	function showFactory_Fashion_Masterpiece(originalRequest){
		document.getElementById("div_brandlayer").innerHTML = originalRequest.responseText;
	}		
}


function setPositionCategory(){
	/*var varWidth = document.getElementById("category").offsetWidth - document.getElementById("category_title_box").offsetWidth - document.getElementById("category_img_box").offsetWidth - document.getElementById("category_desc_box").offsetWidth;

	if(document.getElementById("category").offsetWidth < 875){
		//document.getElementById("category_title_box").style.marginLeft = varWidth/4 - 20 + "px";
		//document.getElementById("category_title_box").style.paddingLeft = "55px";
	}else{
		//document.getElementById("category_title_box").style.paddingLeft = "0px";
		//document.getElementById("category_title_box").style.marginLeft = "0px";
	}
	*/
}
function setDcateLayer(){
	setScateBlankWidth();
	if(document.getElementById("dcate_layer").innerHTML != "" ){
		/*
		1 : document.getElementById("category").offsetWidth
		2 : Position.cumulativeOffset(document.getElementById("dcate_img_"+dcate_click))[0]
		5 : document.getElementById("dcate_layer").offsetWidth
		4 : Position.cumulativeOffset(document.getElementById("dcate_img_"+dcate_click))[0] + document.getElementById("dcate_layer").offsetWidth - document.getElementById("dcate_layer").offsetWidth;
		*/		
		setPositionDCateLayer(dcate_click,"","dcate_layer");

	}
	if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 6){
		if (document.getElementById("comment_layer") && document.getElementById("comment_layer_over")){
			document.getElementById("comment_layer").style.right = "100px";
			document.getElementById("comment_layer").style.right = "0px";
			document.getElementById("comment_layer_over").style.right = "100px";
			document.getElementById("comment_layer_over").style.right = "0px";
		}
	}
	if(selectedMenu=="spread_menu"){ 
		//if(document.getElementById("spread_div").style.width == Position.cumulativeOffset(document.getElementById("spread_menu_btn"))[0]+47+"px"){
		//alert(document.getElementById("spread_div").offsetWidth);
		
		if(document.getElementById("spread_div").offsetWidth == document.getElementById("wrap").offsetWidth){
		}else{
			setSpread();
			//setTimeout("setSpread()", 100);
		}
	}
	if (document.getElementById("qr_layer")){
		document.getElementById("qr_layer").style.display = "none";
	}
	
	if(selectedMenu=="spec_menu"){ 
		setSpec();
	}
	
}
var ObjSpaceCnt = 0;
var ObjSpaceCntA = 0;
var ObjSpaceCntB = 0;
var spreadA = 0; 
var spreadB = 0;
var spread_cate_bundle = "";
 
function setSpread(){
		if( cate_org.length > 6 ){
			if (document.getElementById("spread"+cate_org)){
				goCategory_Spread(cate_org,'','isgo');
			}
		}
		if( cate_org.length > 4 ){
			if (document.getElementById("Mspread"+cate_org)){
			goCategory_Spread(cate_org,'','isgo');
			}
		}

		if(!document.getElementById("spread_div")){
			setTimeout("setSpread()", 300);
		}
		//document.getElementById("spread_div").style.width = document.getElementById("category").offsetWidth - 50;

		//if(document.getElementById("spreadTB2")){
			var ObjSpace = document.getElementById("spread_menu").getElementsByTagName("p");

			if(spreadA < 1){
				spreadA = Number(document.getElementById("spreadTB1").offsetWidth);
			}
			if(spreadB < 1){
				if(document.getElementById("spreadTB2")){
					spreadB = Number(document.getElementById("spreadTB2").offsetWidth);
				}
			}
			if(ObjSpaceCnt < 1){
				for(var i = 0 ; i < ObjSpace.length ; i ++ ){
					if(spreadA > spreadB ){
						if( ObjSpace[i].id.indexOf("td_space1") > -1 ){
							ObjSpaceCnt = ObjSpaceCnt + 1;
						}
					}else{
						if(document.getElementById("spreadTB2")){
							if( ObjSpace[i].id.indexOf("td_space2") > -1 ){
								ObjSpaceCnt = ObjSpaceCnt + 1;
							}		
						}		
					} 
					if(ObjSpace[i].id.indexOf("td_space10304")  > -1  ){
						ObjSpaceCnt = 5;
					}
				}
			}
			for(var i = 0 ; i < ObjSpace.length ; i ++ ){
				ObjSpace[i].style.width = "2px";
			}
			document.getElementById("spread_div").style.width = document.getElementById("wrap").offsetWidth-30-5+"px";
 
			var spread1 = Number(document.getElementById("spreadTB1").offsetWidth);
			if(spreadA < spreadB){
				spread1 = Number(document.getElementById("spreadTB2").offsetWidth);
			}
			var spread2 = Number(document.getElementById("spread_div").style.width.replace("px",""));
			var spread3 = spread2 - spread1; 
 
			for(var i = 0 ; i < ObjSpace.length ; i ++ ){
				if(spread3 > 0 ){
					ObjSpace[i].style.width = spread3/ObjSpaceCnt + 2 + "px" ;
				}else{
					ObjSpace[i].style.width = "2px";
				}
			}
		//}
		setTimeout("setSpread_btn()", 100);
}
function setSpread_btn(){
	var spread1 = Number(document.getElementById("spreadTB1").offsetWidth);
	if(spreadA < spreadB){
		spread1 = Number(document.getElementById("spreadTB2").offsetWidth);
	}
	var spread2 = Number(document.getElementById("spread_div").style.width.replace("px",""));
	var spread3 = spread2 - spread1; 

	if(spread3 < 0){
		if(document.getElementById("spread_div").scrollLeft > 0){
			if (document.getElementById("spread_back")){
				document.getElementById("spread_back").style.display = "inline";
			}
		}else{
			if (document.getElementById("spread_next")){
				document.getElementById("spread_next").style.display = "inline";
			}
		}
	}else{ 
		if (document.getElementById("spread_back")){
			document.getElementById("spread_back").style.display = "none";
		}
		if (document.getElementById("spread_next")){
			document.getElementById("spread_next").style.display = "none";
		}
	}
}
function setPrsitionComment(){
/*
	var varWidth = document.getElementById("category").offsetWidth - document.getElementById("category_title_box").offsetWidth - document.getElementById("category_img_box").offsetWidth - document.getElementById("category_desc_box").offsetWidth;
	if(document.getElementById("category").offsetWidth < 875){

		if(document.getElementById("comment_layer")){
			document.getElementById("comment_layer").style.marginRight = varWidth/2 + 10 + "px";
		}
		if(document.getElementById("comment_layer_over")){
			document.getElementById("comment_layer_over").style.marginRight = varWidth/2 + 10  + "px";
			
		}
	}else{
		
		if(document.getElementById("comment_layer")){
			document.getElementById("comment_layer").style.marginRight = "90px";
		}
		if(document.getElementById("comment_layer_over")){
			document.getElementById("comment_layer_over").style.marginRight = "90px";
		}
	}
*/	
}
function initMenu(){
	var tempCate = "";
	try {
		var tmpUrl = document.location.href;
		if(tmpUrl.indexOf("cate=")>-1) {
			tmpUrl = tmpUrl.substring(tmpUrl.indexOf("cate="));
			var tmpUrlAry = tmpUrl.split("=");

			tmpUrl = tmpUrlAry[1];

			if(tmpUrl.length>4) {
				tmpUrl = tmpUrl.substring(0, 4);
			}
		}
		tempCate = tmpUrl;
	} catch(e) {}
	
	if(document.getElementById("image_menu_btn")){
		document.getElementById("image_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_onemenu_0_1205.gif";
	}
	if(document.getElementById("spread_menu_btn")){
		document.getElementById("spread_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_openmenu_0_1205.gif";
	}
	if(document.getElementById("spec_menu_btn")){
		if(document.getElementById("spec_menu_btn").style.display=="none") {
			document.getElementById("image_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_onemenu_0_1205.gif";
		} else {
			if (tempCate== "2115"){
				document.getElementById("spec_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_tirespec_1030.gif";
			}else if (tempCate== "1642"){
				document.getElementById("spec_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_PetSupplies_1642.gif";
				document.getElementById("spec_menu_btn").style.width="105px";
			}else if (tempCate== "1435"){				
				document.getElementById("spec_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_specmenu_10.gif";	
			}else{
				document.getElementById("spec_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_specmenu_1.gif";
			}
			
		}
	}

	if (document.getElementById("img_menu")){
		document.getElementById("img_menu").style.display = "none";
	}
	if (document.getElementById("brand_menu")){
		document.getElementById("brand_menu").style.display = "none";
	}
	if (document.getElementById("best_menu")){
		document.getElementById("best_menu").style.display = "none";
	}
	if (document.getElementById("spread_menu")){
		document.getElementById("spread_menu").style.display = "none";
	}	
	if (document.getElementById("spec_menu")){
		document.getElementById("spec_menu").style.display = "none";
	}
	if (document.getElementById("recom_menu")){
		document.getElementById("recom_menu").style.display = "none";
	}
	if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 7 && cate_org.substring(0,6) != "040207"){
		if (document.getElementById("dcate_layer_pointer")){
			document.getElementById("dcate_layer_pointer").innerHTML = "";
		}
		if (document.getElementById("dcate_layer_over_pointer")){
			document.getElementById("dcate_layer_over_pointer").innerHTML = "";
		}
	}
	document.getElementById("img_toggle_menu").style.display = "none";
	img_menu_leftbottom_imageSet();
	checkSpec._lastCheck = "";
	spread_cate = "";
	spread_cate_org = "";	
	oldCate1 = "";
	oldCate2 = "";	
	countSpecSearch._prevCheckedSpec = "";
}
function showMenuHelp(param1, param2){
	if(param1 == "1"){
		if(document.getElementById("image_menu_btn").src == var_img_enuri_com + "/2010/images/view/list_menu01.gif"){
			if(param2 == "1"){
				document.getElementById("menuhelp").style.paddingRight = "150px";
				document.getElementById("help2").style.display = "inline";
			}else if(param2 == "2"){
				document.getElementById("help2").style.display = "none";
			}				
		}
	}else if(param1 == "2"){
		if(document.getElementById("spread_menu_btn").src == var_img_enuri_com + "/2010/images/view/list_menu02.gif"){
			if(param2 == "1"){
				document.getElementById("menuhelp").style.paddingRight = "92px";
				document.getElementById("help1").style.display = "inline";
			}else if(param2 == "2"){
				document.getElementById("help1").style.display = "none";
			}						
		}	
	}else if(param1 == "3"){
		if(document.getElementById("rec_menu_btn").src == var_img_enuri_com + "/2010/images/view/list_menu03.gif"){
			if(param2 == "1"){
				document.getElementById("menuhelp").style.paddingRight = "37px";
				document.getElementById("help4").style.display = "inline";
			}else if(param2 == "2"){
				document.getElementById("help4").style.display = "none";
			}						
		}	
	}else if(param1 == "4"){
		if(document.getElementById("adv_menu_btn").src == var_img_enuri_com + "/2010/images/view/list_menu04.gif"){
			if(param2 == "1"){
				document.getElementById("menuhelp").style.paddingRight = "0px";
				document.getElementById("help3").style.display = "inline";
			}else if(param2 == "2"){
				document.getElementById("help3").style.display = "none";
			}						
		}	
	}
}
function Cmd_Spread_Back(){
	insertLog(4657);
	document.getElementById("spread_div").scrollLeft = 0;
	document.getElementById("spread_next").style.display = "inline";
	document.getElementById("spread_back").style.display = "none";
}
function Cmd_Spread_Next(){
	insertLog(4657);
	document.getElementById("spread_div").scrollLeft = document.getElementById("spreadTB1").offsetWidth;
	document.getElementById("spread_next").style.display = "none";
	document.getElementById("spread_back").style.display = "inline";
}
function hideMenuHelp(){
	document.getElementById("help1").style.display = "none";
	document.getElementById("help2").style.display = "none";
	document.getElementById("help3").style.display = "none";
	document.getElementById("help4").style.display = "none";
}
function showImageMenu(param){
	if(typeof(param) == "undefined"){
		param = '';
	}
	initMenu();
	selectedMenu = "img_menu";
	if(param =="0424"){
		document.getElementById("image_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_onemenu_defualt.gif";
	}else{
		document.getElementById("image_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_onemenu_2_on_1205.gif";
	}
	if(document.getElementById("brand_menu_btn")){
		document.getElementById("brand_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_brand_off_lefton_Rightoff.gif";
	}
	if(document.getElementById("best_menu_btn")){
		document.getElementById("best_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_bestmenu_0922.gif";
	}
	if(document.getElementById("spec_menu_btn")){
		if(document.getElementById("spec_menu_btn").style.display=="none") { // 사양선택 없음
			if(document.getElementById("brand_menu_btn")){
				document.getElementById("brand_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_brand_off_lefton_Rightoff.gif";				
			}
			if(document.getElementById("spread_menu_btn")){
				document.getElementById("spread_menu_btn").src = "http://img.enuri.info/2010/images/view/menu/tab_openmenu_0_1205.gif";	
			}
			
			if(document.getElementById("spec_menu_btn_lastbanner")){
				document.getElementById("spec_menu_btn_lastbanner").style.margin = "5px 0px 0px 2px";	
			}
		}else{
			if(document.getElementById("brand_menu_btn")){
				document.getElementById("brand_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_brand_off_lefton_Rightoff.gif";
			}
			if(param =="2115"){
				document.getElementById("spec_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_tirespec_1030.gif";
			}else if(param =="1642"){
				document.getElementById("spec_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_PetSupplies_1642.gif";
				document.getElementById("spec_menu_btn").style.width="105px";
			}else{
				if(document.getElementById("spread_menu_btn")){
					document.getElementById("spec_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_specmenu_10.gif";
					document.getElementById("spec_menu_btn").style.width="93px";	
				}
				
				if(document.getElementById("spec_menu_btn_lastbanner")){
					document.getElementById("spec_menu_btn_lastbanner").style.margin = "5px 0px 0px 2px";	
				}	
			}
			
		}
	}
	document.getElementById("img_menu").style.display = "";
	document.getElementById("category_menu_new").style.display = "inline";
	setDcateLayer();

	Resize_ImgMenu();
	try{
		document.getElementById("enuriListFrame").contentWindow.hideAllLayer();
	}catch(e){
	}
	setTimeout("top.syncHeightMenuFrame()", 50);
	insertLogCate(4655,cate_org);
	try{
		document.getElementById("enuriListFrame").contentWindow.document.getElementById('cate').value = param;
		document.getElementById("enuriListFrame").contentWindow.setSpecInit();
	}catch(e){
	}

}
function img_menu_leftbottom_imageSet() {
	try {
	document.getElementById("img_menu_leftbottom").style.top = (document.getElementById("img_menu_leftbottom").offsetTop - document.getElementById("img_menu_leftbottom").offsetHeight) + "px";
	} catch(e) {}
}
function showSpreadMenu(param){
	cate_org = "";

	//alert("param="+param);
	insertLog(4656);
	
	if(param == "9716"){			insertLog(5147);
	}else if(param == "0313"){		insertLog(5148);
	}else if(param == "0210"){		insertLog(5149);
	}else if(param == "0214"){		insertLog(5150);
	}else if(param == "0223"){		insertLog(5151);
	}else if(param == "0410"){		insertLog(5152);
	}else if(param == "0515"){		insertLog(5153);
	} 
	 
	initMenu();
	if(document.getElementById("image_menu_btn")){
		document.getElementById("image_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_onemenu_0_1205.gif";
	}
	selectedMenu = "spread_menu";
	if(document.getElementById("spec_menu_btn")){
		if(document.getElementById("spec_menu_btn").style.display=="none") { // 사양선택 없음.
			if(document.getElementById("spread_menu_btn")){
				document.getElementById("spread_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_openmenu_on_0329_1205.gif";	
			}
			
			if(document.getElementById("spec_menu_btn_lastbanner")){
				document.getElementById("spec_menu_btn_lastbanner").style.margin = "5px 0px 0px 0px";	
			}
		} else { // 사양선택 있음.
			document.getElementById("spread_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_openmenu_2_on_1205.gif";
			if(param == "2115"){
			  document.getElementById("spec_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_tirespec_1030_2.gif";
			}else if(param == "1642"){
				document.getElementById("spec_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_PetSupplies_1642_2.gif";
				document.getElementById("spec_menu_btn").style.width="105px";
			}else{ 
			// document.getElementById("spec_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_specmenu_0.gif";
			
				if(document.getElementById("spec_menu_btn")){	
					document.getElementById("spec_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_specmenu_10.gif";
					document.getElementById("spec_menu_btn").style.width="93px";
				}
				if(document.getElementById("spec_menu_btn_lastbanner")){
					document.getElementById("spec_menu_btn_lastbanner").style.margin = "5px 0px 0px 2px";	
				}
			}
		}
	}
	document.getElementById("category_menu_new").style.display = "none";

	if(navigator.appName == "Microsoft Internet Explorer") {
		var Agent = navigator.userAgent
		Agent = Agent.toLowerCase();
		if(Agent.indexOf("msie 6") > -1 && Agent.indexOf("msie 7") < 0 ) {
			if(Agent.indexOf("msie 8") > -1 ) {
				document.getElementById("category_menu_tab").style.top = "96px";
			}else{
				document.getElementById("category_menu_tab").style.top = "98px";
			}
		}else if(Agent.indexOf("msie 6") > -1 && Agent.indexOf("msie 7") > -1 ) {
			document.getElementById("category_menu_tab").style.top = "98px";
		}
	}

	document.getElementById("spread_menu").style.marginBottom = "0px";
	/*
	if (document.getElementById("spread_menu").innerHTML.trim().length >  0){
		document.getElementById("spread_menu").style.display = "";
	}else{
		insertHideLayer("/layer/IncSpreadMenu_New.jsp","cate="+param,"spread_menu");
	}
	*/
	insertHideLayer("/layer/IncSpreadMenu_New.jsp","cate="+param.substring(0,4),"spread_menu");
	
	//setSpread();
	if( param.length > 6 ){
		//alert(document.getElementById("spread"+param))
		if (document.getElementById("spread"+param)){
		goCategory_Spread(param,'','isgo');
		}
	}
	if( param.length > 4 ){
		//alert(document.getElementById("spread"+param))
		if (document.getElementById("Mspread"+param)){
		goCategory_Spread(param,'','isgo');
		}
	}
	setTimeout("setSpread()", 100);
	if(cate_org.length > 4){
		if(document.getElementById("Mspread"+cate_org.substring(0,6)) != null ){
			spread_cate = cate_org;
			spread_cate_org = cate_org;
			Cmd_Color_Spread(cate_org);
		}
	}
	oldShowCateId = null;
	try{
		document.getElementById("enuriListFrame").contentWindow.hideAllLayer();
	}catch(e){
	}
	try{
	  document.getElementById("enuriListFrame").contentWindow.document.getElementById('cate').value = param;
		document.getElementById("enuriListFrame").contentWindow.setSpecInit();
	}catch(e){
	}
	Cmd_Comment_Hide();

	try {
		oldShowCateId = document.getElementById("spread"+param);
	} catch(e) {}

}

function showBrandMenu(MCate, fbrand){
	initMenu();
	insertLogCate(12689,MCate);
	selectedMenu = "brand_menu";
	document.getElementById("brand_menu").style.display = "";
	
	document.getElementById("image_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_onemenu_0_1205.gif";
	if(document.getElementById("brand_menu_btn")){
		document.getElementById("brand_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_brand_on_leftoff_Rightoff_2.gif";
	}
	if(document.getElementById("best_menu_btn")){
		document.getElementById("best_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_bestmenu_0922.gif";
	}
	if(document.getElementById("spec_menu_btn")){
		if(document.getElementById("spec_menu_btn").style.display=="none") {
			if(!document.getElementById("best_menu_btn")){
				document.getElementById("brand_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_brand_on_leftoff.gif"; 
			}else{
				document.getElementById("brand_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_brand_on_leftoff_Rightoff_2.gif"; 
			}
		} else {
			document.getElementById("brand_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_brand_on_leftoff_Rightoff.gif";
			document.getElementById("spec_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_specmenu_11.gif";
			document.getElementById("spec_menu_btn").style.width="93px";
		}
	}

	try{
		document.getElementById("enuriListFrame").contentWindow.hideAllLayer();
	}catch(e){
	}
	try{
		document.getElementById("enuriListFrame").contentWindow.setSpecInit();
	}catch(e){
	}
	Cmd_Comment_Hide();
	if(fbrand==""){
		CmdGanareset(30);
	}
}

function showBestMenu(MCate, shop_code){
	initMenu();
	insertLogCate(12706,MCate);
	selectedMenu = "best_menu";
	var no = Math.floor(Math.random() * 3);
	var shopcods = ["536", "4027", "5910"];
	if(shop_code!=""){
		shop_code = shop_code;
	}else if(MCate!=1436 && shop_code==""){
		shop_code = shopcods[no];
	}else{
		shop_code = "536";
	}
		
	document.getElementById("best_menu").style.display = "";
	
	if(document.getElementById("image_menu_btn")){
		document.getElementById("image_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_onemenu_1_1205.gif";
	}
	
	if(document.getElementById("best_menu_btn")){
		document.getElementById("best_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_bestmenu_3_on.gif";
	}
	if(document.getElementById("brand_menu_btn")){
		document.getElementById("brand_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_brand_off_leftoff_Righton.gif";
	}
	if(document.getElementById("spec_menu_btn")){
		if(document.getElementById("spec_menu_btn").style.display=="none") {
			document.getElementById("brand_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_brand_off_leftoff_Righton.gif";
		}else{
			document.getElementById("brand_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_brand_0922.gif";
			document.getElementById("spec_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_specmenu_14.gif";
		}
	}

	try{
		document.getElementById("enuriListFrame").contentWindow.hideAllLayer();
	}catch(e){
	}
	try{
		document.getElementById("enuriListFrame").contentWindow.setBestInit(shop_code);
	}catch(e){
	}
	
	document.getElementById("shop_536").className = "";
	if(document.getElementById("shop_4027")){
		document.getElementById("shop_4027").className = "";
	}
	if(document.getElementById("shop_5910")){
		document.getElementById("shop_5910").className = "";
	}
	document.getElementById("shop_"+shop_code).className ="on";
	
	//CmdShopBestList(MCate, 536);
}

function getFashionCateName(cate, glname, orgbrand){
	var url_i = "/view/fashion/include/getCateNames_Fashion.jsp";
	var param_i = "cate="+cate+"&glname="+glname+"&orgbrand="+orgbrand;
	var getAjaxProd = new Ajax.Request(
		url_i,
		{
			method:'get',parameters:param_i,onComplete:showCate_Fashion_Masterpiece
		}
	);

	function showCate_Fashion_Masterpiece(originalRequest){
		document.getElementById("div_brandlayer").innerHTML = originalRequest.responseText;
	}
}

function cmdFashionMasterpieceCate(glname,brandcate,brandcatename,cate_length, select_cate){
	var var_keyword="";
	var var_mprice = "";
	var var_BrandDCaCode = "<%=strBrandcate%>"+"";
	if(var_BrandDCaCode!=""){
		if(var_BrandDCaCode==brandcate){
			var_keyword="<%=strKeyword%>";
			var_mprice = "<%=strMPrice%>";
		}
	}
	for(var i=0; i < cate_length; i++) {
		document.getElementById("brandCate_"+i).onmouseover = function(){
			this.style.color="#BD0F0E";
		}
		document.getElementById("brandCate_"+i).onmouseout = function(){
			this.style.color="#000000";
		}
		document.getElementById("brandCate_"+i).className = "no_sel_brand_masterpiece";
		document.getElementById("brandCate_"+i).style.color="#000000";

	}
	document.getElementById("brandCate_"+select_cate).onmouseover = function(){
		this.style.color="#BD0F0E";
	}
	document.getElementById("brandCate_"+select_cate).onmouseout = function(){
		this.style.color="#BD0F0E";
	}
	document.getElementById("brandCate_"+select_cate).className = "sel_brand_masterpiece";
	document.getElementById("brandCate_"+select_cate).style.color="#BD0F0E";

	document.getElementById("enuriListFrame").src = "/view/Listbody_Mp3.jsp?cate="+brandcate+"&isbrand=true&factory="+glname+"&brandcatename="+brandcatename+"&select_cate="+select_cate+"&keyword="+var_keyword+"&m_price="+var_mprice;
}
function CmdGanareset(brand_length){
	for(var i=0; i < brand_length; i++) {
		document.getElementById("spanBrand_"+i).style.color="#000000";
		document.getElementById("spanBrand_"+i).style.fontWeight="normal";
		document.getElementById("spanBrand_"+i).className = "no_sel_brand_masterpiece";
		
		document.getElementById("spanBrand_"+i).onmouseout = function(){
			this.style.color="#000000";
		}
	}
	if(document.getElementById("div_brandlayer")){
		document.getElementById("div_brandlayer").innerHTML = "";
	}
	
}
function CmdGanaList( glname, brand_length, select_brand, cate ){
	//var varForm = document.frmMsgList;
	//varForm.glname.value = glname ;
	//varForm.ganada.value = ganada ;
	//varForm.cate.value = "145920" ;

	//varForm.submit();
	for(var i=0; i < brand_length; i++) {
		document.getElementById("spanBrand_"+i).onmouseover = function(){
			this.style.color="#BD0F0E";
		}
		document.getElementById("spanBrand_"+i).onmouseout = function(){
			this.style.color="#000000";
		}
		document.getElementById("spanBrand_"+i).className = "no_sel_brand_masterpiece";
		document.getElementById("spanBrand_"+i).style.color="#000000";
		document.getElementById("spanBrand_"+i).style.fontWeight="normal";

	}
	document.getElementById("spanBrand_"+select_brand).onmouseover = function(){
		this.style.color="#BD0F0E";
	}
	document.getElementById("spanBrand_"+select_brand).onmouseout = function(){
		this.style.color="#BD0F0E";
	}
	document.getElementById("spanBrand_"+select_brand).className = "sel_brand_masterpiece";
	document.getElementById("spanBrand_"+select_brand).style.color="#BD0F0E";
	document.getElementById("spanBrand_"+select_brand).style.fontWeight="bold";

	/*
	document.getElementById("spanBrand_"+select_brand).onmouseout = function(){
		document.getElementById("spanBrand_"+select_brand+).style.color="#BD0F0E";
	};
	document.getElementById("spanBrand_"+select_brand).style.color = "#BD0F0E";
	document.getElementById("spanBrand_"+select_brand).style.fontWeight = "bold";
	*/
	//alert(glname);

	document.getElementById("enuriListFrame").src = "/view/Listbody_Mp3.jsp?cate="+cate+"&factory="+glname+"&isbrand=true";
}

function CmdShopBestList(cate, shop_code){
	document.getElementById("shop_536").className = "";
	if(document.getElementById("shop_4027")){
		document.getElementById("shop_4027").className = "";
	}
	if(document.getElementById("shop_5910")){
		document.getElementById("shop_5910").className = "";
	}
	document.getElementById("shop_"+shop_code).className ="on";
	document.getElementById("enuriListFrame").src = "/view/Listbody_Fs_ShopBest.jsp?cate="+cate+"&fs_shop_code="+shop_code+"&isbest=true";
}

function Cmd_Color_Spread3(param){
	if(spread_cate_org != ""){
		if(spread_cate_org.length < 8){ 
			document.getElementById("Mspread"+spread_cate_org).style.color = "#000000";
		}else{
			if(document.getElementById("spread"+spread_cate_org).className == "sml_n3"){
				document.getElementById("spread"+spread_cate_org).className = "sml_n1";	
			}else if(document.getElementById("spread"+spread_cate_org).className == "sml_n4"){
				document.getElementById("spread"+spread_cate_org).className = "sml_n2";
			}		
		}	
	}
	if(cate_org.length < 8){
		document.getElementById("Mspread"+param).style.color = "#BD0F0E";
	}else{
		if(document.getElementById("spread"+param).className == "sml_n1"){
			document.getElementById("spread"+param).className = "sml_n3";	
		}else if(document.getElementById("spread"+param).className == "sml_n2"){
			document.getElementById("spread"+param).className = "sml_n4";
		}		
	}
}

function checkHeightSpreadMenu(){
	if (document.getElementById("spread_menu").scrollHeight > 240 ){
		//document.getElementById("img_toggle_menu").style.top = (130+document.getElementById("spread_menu").offsetHeight)+"px"; 
		//document.getElementById("img_toggle_menu").style.display = "";
	}
	top.syncHeightMenuFrame();
}
function showRecMenu(){
	initMenu();
	selectedMenu = "recom_menu";
	document.getElementById("rec_menu_btn").src = var_img_enuri_com + "/2010/images/view/list_menu03_on.gif";
	document.getElementById("rec_menu_btn").height = 19;
	if (document.getElementById("recom_menu").innerHTML.trim().length >  0){
		document.getElementById("recom_menu").style.display = "";
	}else{
		insertHideLayer("/layer/IncRecommendationMenu.jsp","cate=0404","recom_menu");
	}
	setTimeout("checkHeightRecMenu()", 50);
}
function showRecMenu_text(param_r_no, param_i, param_length){
	if( param_r_no.length > 0 ){
		insertHideLayer("/layer/IncRecommendationMenu_Text.jsp","r_no="+param_r_no,"recom_menu_desc");
	}
	for(var i = 0 ; i < param_length ; i ++){
		if(document.getElementById("now_red_"+i).style.display == "inline"){
			document.getElementById("now_red_"+i).style.display = "none";
		}
		document.getElementById("now_red_"+param_i).style.display = "inline";
	}
}

function checkHeightRecMenu(){
	if (document.getElementById("recom_menu").scrollHeight > 240 ){
		document.getElementById("img_toggle_menu").style.top = (130+document.getElementById("recom_menu").offsetHeight)+"px"; 
		document.getElementById("img_toggle_menu").style.display = "";
	}
	top.syncHeightMenuFrame();
}

//var tid_dcate;
var cate_over = "";
var oldCate1 = "";
var oldCate2 = "";

function redCateLayer(cate,param){
	if(oldCate1==cate) {
		return;
	}
	if(cate == "101447"){
		return;
	}
	if(param == "red"){
		//document.getElementById("img_"+cate).src = var_img_enuri_com + "/images/view/test/shadow_left_on.gif";
		if(document.getElementById("img1_"+cate)) {
			document.getElementById("img1_"+cate).style.backgroundImage = "url("+var_img_enuri_com + "/images/view/test/shadow_left_on.gif)";
			document.getElementById("img2_"+cate).style.backgroundImage = "url("+var_img_enuri_com + "/images/view/test/shadow_top_on.gif)";
			document.getElementById("img3_"+cate).style.backgroundImage = "url("+var_img_enuri_com + "/images/view/test/shadow_b_01_on.gif)";
			document.getElementById("img4_"+cate).style.backgroundImage = "url("+var_img_enuri_com + "/images/view/test/shadow_b_02_on.gif)";
			document.getElementById("img5_"+cate).style.backgroundImage = "url("+var_img_enuri_com + "/images/view/test/shadow_right_on.gif)";
			document.getElementById("Stext_"+cate).style.color = "#d20000";
		}
		
		if(oldCate1!=""){
			if(document.getElementById("img1_"+oldCate1)) {
				//document.getElementById("img_"+cate).src = var_img_enuri_com + "/images/view/test/shadow_left_on.gif";
				document.getElementById("img1_"+oldCate1).style.backgroundImage = "url("+var_img_enuri_com + "/images/view/test/shadow_left.gif)";
				document.getElementById("img2_"+oldCate1).style.backgroundImage = "url("+var_img_enuri_com + "/images/view/test/shadow_top.gif)";
				document.getElementById("img3_"+oldCate1).style.backgroundImage = "url("+var_img_enuri_com + "/images/view/test/shadow_b_01.gif)";
				document.getElementById("img4_"+oldCate1).style.backgroundImage = "url("+var_img_enuri_com + "/images/view/test/shadow_b_02.gif)";
				document.getElementById("img5_"+oldCate1).style.backgroundImage = "url("+var_img_enuri_com + "/images/view/test/shadow_right.gif)";
				document.getElementById("Stext_"+oldCate1).style.color = "#000000";
			}
			
			oldCate1 = "";
		}
		if(oldCate2!=""){
			if(document.getElementById("dcate_img_"+oldCate2)) {
				document.getElementById("dcate_img_"+oldCate2).src = var_image_enuri_com + "/data/images/view/ls_rcate/"+oldCate2+".gif";
			}

			oldCate2 = "";
		}
		oldCate1 = cate;
	}
}

function redBundle(cate,param){
	//alert("cate"+cate);
	if(oldCate2==cate) {
		return;
	}
	if(param == "red"){
		if(document.getElementById("dcate_img_"+cate)) {
			document.getElementById("dcate_img_"+cate).src = var_image_enuri_com + "/data/images/view/ls_rcate/"+cate+"_location.gif";
		}
		if(oldCate2!=""){
			if(document.getElementById("dcate_img_"+oldCate2)) {
				document.getElementById("dcate_img_"+oldCate2).src = var_image_enuri_com + "/data/images/view/ls_rcate/"+oldCate2+".gif";
			}
			oldCate2 = "";
		}
		if(oldCate1!=""){
			if(document.getElementById("img1_"+oldCate1)) {
				document.getElementById("img1_"+oldCate1).style.backgroundImage = "url("+var_img_enuri_com + "/images/view/test/shadow_left.gif)";
				document.getElementById("img2_"+oldCate1).style.backgroundImage = "url("+var_img_enuri_com + "/images/view/test/shadow_top.gif)";
				document.getElementById("img3_"+oldCate1).style.backgroundImage = "url("+var_img_enuri_com + "/images/view/test/shadow_b_01.gif)";
				document.getElementById("img4_"+oldCate1).style.backgroundImage = "url("+var_img_enuri_com + "/images/view/test/shadow_b_02.gif)";
				document.getElementById("img5_"+oldCate1).style.backgroundImage = "url("+var_img_enuri_com + "/images/view/test/shadow_right.gif)";
				document.getElementById("Stext_"+oldCate1).style.color = "#000000";
			}

			oldCate1 = "";
		}
		oldCate2 = cate;
	}
}
function makeCateLayer(cate,param){ 
	if(cate=="221131"){
		cate = "221131";
	}
	if(cate=="031326"){
		cate = "221131";
	}
	makeCateLayer._f_cate = cate;
	if (AryCateComment[cate]){
		showCateLayer(cate,param);
	}else{
		if(param == "click"){
			insertHideLayer("/layer/IncCommentLayer.jsp","cate="+cate,"comment_layer");
		}else{
			insertHideLayer("/layer/IncCommentLayer.jsp","cate="+cate,"comment_layer_over");
		}
		showCateLayer(cate,param);
	}
}
function showCateLayer(cate,param){
	cmdOutCateStop();
	if(param == "out"){
		if(cate != dcate_click){
			cmdOutCateStart();
		}
	}else if(param == "over"){
		if(cate.substring(0,6) != dcate_click.substring(0,6)){
			document.getElementById("dcate_layer").style.display = "none";
			document.getElementById("dcate_layer_pointer").style.display = "none";
		}else{
			document.getElementById("dcate_layer").style.display = "inline";
			document.getElementById("dcate_layer_pointer").style.display = "";
		}
		if(typeof(AryCateComment[cate]) != "undefined" && AryCateComment[cate].length > 1180 ){
			if(cate_over != cate && makeCateLayer._f_cate == cate){
				document.getElementById("comment_layer_over").innerHTML = AryCateComment[cate];
				document.getElementById("comment_layer_over").style.display = "";
			}else{
				document.getElementById("comment_layer_over").style.display = "";
			}
			cate_over = cate;
		}else{
			document.getElementById("comment_layer_over").style.display = "none";
		}
	}else if(param == "dcate"){
		if(cate.substring(0,6) != dcate_click.substring(0,6)){
			document.getElementById("dcate_layer").style.display = "none";
			document.getElementById("dcate_layer_pointer").style.display = "none";
		}else{
			document.getElementById("dcate_layer").style.display = "";
			document.getElementById("dcate_layer_pointer").style.display = "";
		}
		if (typeof(AryCateComment[cate]) != "undefined"){
			document.getElementById("comment_layer_over").innerHTML = AryCateComment[cate];
			document.getElementById("comment_layer_over").style.display = "";
			cate_over = cate;
		}else{
			document.getElementById("comment_layer_over").innerHTML = "";
			document.getElementById("comment_layer_over").style.display = "none";			
		}
	}else{
		if (AryCateComment[cate]){
			if(AryCateComment[cate].length > 1180 ){
				document.getElementById("comment_layer").innerHTML = AryCateComment[cate];
				document.getElementById("comment_layer").style.display = "";
			}else{
				document.getElementById("comment_layer").style.display = "none";
			}
		}
	}
}

function Cmd_Dcate_Hide(){
	document.getElementById("dcate_layer_over").style.display = "none";
	document.getElementById("dcate_layer_over_pointer").style.display = "none";
	
	document.getElementById("comment_layer_over").style.display = "none";
	dcate_over = "";
	cate_over = "";
	//clearTimeout(tid_dcate);
}

function Cmd_Allab_Hide(){
	document.getElementById("comment_layer").style.display = "";
	document.getElementById("comment_layer_over").style.display = "none";
}

function showDCateLayer(cate,param){
	cmdOutCateStop();
	var cate = cate.substring(0,6);
	if(dcate_over == cate && param != "click"){
		if( dcate_click == cate ){
			document.getElementById("dcate_layer_over").style.display = "none";
			document.getElementById("dcate_layer_over_pointer").style.display = "none";
		}else{
			document.getElementById("dcate_layer_over").style.display = "";
			if(AryDCateLayer[cate].length > 500){
				document.getElementById("dcate_layer_over_pointer").style.display = "";
			}
		}
	}else{
		if (AryDCateLayer[cate]){
			if( dcate_click == cate ){
				document.getElementById("dcate_layer_over").style.display = "none";
				document.getElementById("dcate_layer_over_pointer").style.display = "none";
			}else{
				showDCateLayer2(cate,param);
			}
		}else{
			if(param == "click"){
				insertHideLayer("/layer/IncDcateLayer.jsp","cate="+cate,"dcate_layer");
			}else{
				insertHideLayer("/layer/IncDcateLayer.jsp","cate="+cate,"dcate_layer_over");
			}
			showDCateLayer2(cate,param);	
		}
	}
	dcate_over = cate;
}

function showDCateLayer2(cate,param){
	//alert("1="+document.getElementById("dcate_layer_over").clientWidth);
	//if (checkFusionCate(cate)){
	//	return;
	//}
	showDCateLayer2._blankDcate = false;
	var varLeftRight = getLeftRight(cate);
	
	var Layer_text;
	Layer_text = AryDCateLayer[cate];

	var ca_code = Layer_text.substring(Layer_text.indexOf("ca_code=")+8,Layer_text.indexOf("=ca_code")) ;
    
	if(AryDCateLayer[cate] && Layer_text.length > 990){
		var text;
		var top_left = Layer_text.substring(Layer_text.indexOf("top_img_left=")+13,Layer_text.indexOf("=top_img_left")) ;
			 
		if (Layer_text != "" ){
			text = '<table border="0" cellpadding="0" cellspacing="0" height="10"><tr><td>';
			if(Layer_text.length > 370 ){
				//text += '<div style="position:absolute;top:0px;left:'+top_left+'px;" id="pointer_img"><img src=http://img.enuri.info/images/blank.gif border=0 width="5" height="1"><img src=http://img.enuri.info/images/view/point2_n.gif border=0 width="11" height="10" onmouseover=showCateLayer("'+cate+'","over");showDCateLayer("'+cate+'","over","'+type+'");></div></td></tr></table>';
			}
			//text += '<table border="0" cellpadding="0" cellspacing="0" bgcolor="FFFFFF" style="border-bottom: 1px #A6A6A6 solid;"><tr><td>';
			text += '<table border="0" cellpadding="0" cellspacing="0" bgcolor="FFFFFF" onmouseover="cmdOutCateStop()" onmouseout="cmdOutCateStart()" style="border-width:1px; border-color:#d20000; border-style:solid;">';
			text += '<tr><td style="font-size:9pt;">'+Layer_text+'</td></tr></table>';
			//text += '<tr><td style="font-size:9pt;">'+Layer_text+'</td></tr></table></td></tr></table>';
		}
		if(param == "out"){ 
			document.getElementById("dcate_layer_over").style.display = "none";
			document.getElementById("dcate_layer_over_pointer").style.display = "none";
		}else if(param == ("over")){
			//alert("type="+type);
			if(varLeftRight=="R"){
			//3px
				document.getElementById("dcate_layer_over_pointer").innerHTML = "<img src=\""+var_img_enuri_com+"/images/view/arr_right_1004.gif\" border=\"0\" width=\"11\" height=\"12\" onmouseover=\"cmdOutCateStop()\" onmouseout=\"cmdOutCateStart()\">";
			}else if(varLeftRight=="L"){
				document.getElementById("dcate_layer_over_pointer").innerHTML = "<img src=\""+var_img_enuri_com+"/images/view/arr_left_1004.gif\" border=\"0\" width=\"11\" height=\"12\" onmouseover=\"cmdOutCateStop()\" onmouseout=\"cmdOutCateStart()\">";
			}
			//document.getElementById("dcate_layer_over_pointer").innerHTML = '<img src=http://img.enuri.info/images/blank.gif border=0 width="5" height="1"><img src=http://img.enuri.info/images/view/arr_right.gif border=0 width="11" height="10" onmouseover=showCateLayer("'+cate+'","over");showDCateLayer("'+cate+'","over");>';
			document.getElementById("dcate_layer_over").innerHTML = "";
			if ( dcate_click == cate ){
				text = text.replace(/E9ECEF/g, 'E0E4E9');
				text = text.replace('HideDcateLayer(2)', 'HideDcateLayer(1)');
				document.getElementById("dcate_layer_over").innerHTML = text;
			}else{
				if(cate.substring(0,4) == "1621" || cate.substring(0,4) == "0606" || cate.substring(0,4) == "0515" || cate.substring(0,4) == "1608" || cate.substring(0,4) == "1612" || cate.substring(0,4) == "0609" || cate.substring(0,4) == "2403"  || cate.substring(0,4) == "0608" || cate.substring(0,4) == "0602" || cate.substring(0,4) == "0903" || cate.substring(0,4) == "0621" || cate.substring(0,4) == "0606" || cate.substring(0,4) == "0604" ||  cate.substring(0,4) == "2407" || cate.substring(0,4) == "0603" || cate.substring(0,4) == "0602" || cate.substring(0,4) == "0611" ||  cate.substring(0,4) == "0507" || cate.substring(0,4) == "0920" || cate.substring(0,4) == "2406" || cate.substring(0,4) == "2401" || cate.substring(0,4) == "2405"  || cate.substring(0,4) == "0404"  || cate.substring(0,4) == "0401"  || cate.substring(0,4) == "0210"  || cate.substring(0,4) == "0691"  || cate.substring(0,4) == "0313"  || cate.substring(0,4) == "0363") {
					text = changeColorDcate(text,cate);
				}
				document.getElementById("dcate_layer_over").innerHTML = text;
			}
			
			setPositionDCateLayer(cate,varLeftRight,"dcate_layer_over");

		}else{
			dcate_click = cate;
			//text = text.replace(/E9ECEF/g, 'E0E4E9');
			//클릭한후
			//alert("type="+type);
			if(varLeftRight=="R"){
				document.getElementById("dcate_layer_pointer").innerHTML = '<img src=http://img.enuri.info/images/view/arr_right_1004.gif border=0 width="11" height="12" onmouseover=showCateLayer("'+cate+'","over","'+varLeftRight+'");showDCateLayer("'+cate+'","over","'+varLeftRight+'");>';
			}else if(varLeftRight=="L"){
				document.getElementById("dcate_layer_pointer").innerHTML = '<img src=http://img.enuri.info/images/view/arr_left_1004.gif border=0 width="11" height="12" onmouseover=showCateLayer("'+cate+'","over","'+varLeftRight+'");showDCateLayer("'+cate+'","over","'+varLeftRight+'");>';
			}
			if(cate.substring(0,4) == "1621" || cate.substring(0,4) == "0606"  || cate.substring(0,4) == "0515" || cate.substring(0,4) == "0608" || cate.substring(0,4) == "1608" || cate.substring(0,4) == "1612" || cate.substring(0,4) == "0609" || cate.substring(0,4) == "0903" ||  cate.substring(0,4) == "2403"  || cate.substring(0,4) == "0621"|| cate.substring(0,4) == "0603" || cate.substring(0,4) == "0602" || cate.substring(0,4) == "0611"  ||  cate.substring(0,4) == "0507" ||  cate.substring(0,4) == "2407" ||  cate.substring(0,4) == "0920" || cate.substring(0,4) == "0604" || cate.substring(0,4) == "2406" || cate.substring(0,4) == "2401" || cate.substring(0,4) == "2405"  || cate.substring(0,4) == "0404"  || cate.substring(0,4) == "0401"  || cate.substring(0,4) == "0210"  || cate.substring(0,4) == "0691"  || cate.substring(0,4) == "0313"   || cate.substring(0,4) == "0363") {
				text = changeColorDcate(text,cate);
			}
			document.getElementById("dcate_layer").innerHTML = text.replace('HideDcateLayer(1)', 'HideDcateLayer(2)').replace(/E9ECEF/g, 'E0E4E9');
			document.getElementById("dcate_layer").style.display = "";
			document.getElementById("dcate_layer_over").style.display = "none";
			document.getElementById("dcate_layer_pointer").style.display = "";
			document.getElementById("dcate_layer_over_pointer").style.display = "none";
			
			setPositionDCateLayer(cate,varLeftRight,"dcate_layer");
				
		}
		//showCateLayer(cate,param);
	}else if(Layer_text.length < 990){
		 if(param == "over"){
		 	document.getElementById("dcate_text_"+cate).title = "클릭!";
		 	document.getElementById("dcate_img_"+cate).title = "클릭!";
		 	//document.getElementById("small_img_bg_"+cate).title = "클릭!";
		 	document.getElementById("dcate_layer_over").innerHTML = "";
		 	document.getElementById("dcate_layer_over_pointer").innerHTML = "";
		 	dcate_over = "";
		 	showDCateLayer2._blankDcate = true;
		 }else  if(param == "click"){
			document.getElementById("dcate_layer").innerHTML = "";
			document.getElementById("dcate_layer_pointer").innerHTML = "";
			dcate_click = "";
		 } 
	}else{
	    //tid_dcate = setTimeout("Cmd_Dcate_Hide()", 500);    
		document.getElementById("dcate_layer_over").style.display = "";
		document.getElementById("dcate_layer_over_pointer").style.display = "";
		dcate_over = "";
    }
   // 			alert(document.getElementById("dcate_layer_over_pointer").style.left);
}
function showDCateLayer_Bundle(param){
	dcate_over = "";
	
	if(param == "over"){
		document.getElementById("dcate_layer_over").style.display = "none";
		document.getElementById("dcate_layer_over_pointer").style.display = "none";	
	}else if(param == "click"){
		dcate_click = "";
		document.getElementById("dcate_layer").style.display = "";
		document.getElementById("dcate_layer").style.display = "none";		
		document.getElementById("dcate_layer_over").style.display = "";
		document.getElementById("dcate_layer_over").style.display = "none";	
		document.getElementById("dcate_layer_pointer").style.display = "";
		document.getElementById("dcate_layer_pointer").style.display = "none";		
		document.getElementById("dcate_layer_over_pointer").style.display = "";
		document.getElementById("dcate_layer_over_pointer").style.display = "none";	
	}
} 
//묶음코드 
var bundle = "214020,214021,092423,040536,040537,160712,091231,213117,120527,023401,023423,023521,219816,219817,035701,035705,035740,035820,164219,164220,"+
"164222,164314,164316,164413,164515,164514,122522,122515,122713,122721,122612,122820,122808,122809,124313,124304,124314,124315,124316,"+
"051120,102010,103009,102210,102011,101115,101121,101113,181815,035111,035112,035113,150607,150212,051114,124201,124217,124208,"+
"034214,162316,090326,080124,080232,080234,020132,020138,020136,163809,181222,092416,181413,031809,020818,150511,120715,101447,101448,"+
"182211,181706,181712,210624,020111,034210,093508,021511,021528,020708,022101,020816,022007,022609,051005,182210,210325,210326,"+
"020818,060915,034911,034912,034913,080621,080629,093712,051524,050817,093312,024212,023526,023521,052620,062211,023525,062212,"+
"022013,030409,030707,030202,031801,031822,180210,180217,180218,240111,051418,051422,240516,050208,052609,052610,051424,"+
"050702,051108,060101,060116,060221,060217,060307,060911,062007,060716,062126,062130,024009,024012,120123,093213,080824,"+
"240421,061012,060405,145912,070204,070401,070408,240621,071201,090417,090108,210316,093011,060918,023828,024110,024114,221212,221312,222115,222113,222114,222211,101215,"+
"090321,101433,100809,101504,120201,120216,120217,121309,120512,103009,222312,222314,120523,161211,161212,162111,230410,230508,162611,222611,222711,224209,222421,"+
"160204,230208,163112,036328,036329,036330,211429,211610,971609,021709,020314,050205,163510,080419,050715,070911,070912,092415,092412,161315,122008,122009,120311,120318,210616,224311,"+
"020306,020402,020408,020925,069204,069203,069105,030447,211535,211536,211537,211523,230413,163808,100416,060502,071519,071518,092316,092317,"+ 
"040205,040208,051015,051014,240409,051309,051326,060501,240311,021121,060302,163808,092910,060823,240724,120839,121318,"+ 
"060524,060526,070307,070308,071306,071307,070509,070514,240724,070706,070707,145124,070809,030443,060627,060628,060711,"+
"070810,071009,071010,071101,071102,071409,071410,091215,092510,022312,080720,213111,213112,210816,210831,145519,"+
"092511,091509,091510,091301,091305,091802,091806,091925,090910,100506,101211,121519,090417,021901,150919,150920,"+
"100409,100411,164912,164913,100701,124013,124014,124015,100111,100109,224411,081319,120104,120415,120418,121509,181814,021905,093111,"+
"121510,162311,162312,161308,160613,163206,163207,036209,022015,036209,036218,036236,083418,083419,083420,"+
"036415,036417,021237,189001,189009,040818,040819,091614,091615,081311,034712,034713,034714,036413,"+
"091410,030428,031317,162709,162710,212209,212211,080411,181314,181316,162208,070150,070151,021423,"+
"100319,219816,219817,219818,163710,163711,082508,082509,975012,975013,050311,041412,041022,123012,123013,"+
"160811,160812,160813,080221,070618,070619,031901,031905,100720,081023,020824,042320,071519,"+
"161110,032808,032809,122104,122108,122112,210422,210423,210424,021428,070219,091113,020621,081311,061116,"+  
"240616,092111,160313,240305,160516,033209,033210,041801,061016,086602,086605,061116,082610,162020,040140,040136,"+
"052712,030440,101016,101022,163713,082811,082812,219613,219614,162115,210920,145123,071518,143715,143716,"+
"030512,030560,030561,030515,180308,120712,052114,052126,052115,052116,020323,081211,081212,100920,100921,"+ 
"169317,169309,169310,033510,975211,975212,975213,975214,975312,162614,975313,083109,083110,093810,150117,"+
"210906,210928,210927,033712,033713,033812,033813,033912,033913,034010,150815,034011,034110,034111,181219,181220,080914,"+
"033714,033814,033914,034014,034113,102312,102314,120310,034313,034314,034315,051520,021918,210840,210843,210844,"+
"036232,079011,222811,079012,083210,083211,083212,034409,034412,034410,150312,150313,150210,150211,060821,"+
"020303,100320,100321,100322,060819,080118,083411,083412,083413,042222,035941,036009,036010,023711,023721,"+
"092015,041019,087801,087808,040110,040111,034612,034613,124102,124106,124111,021134,021138,210622,210522,"+
"240519,040126,900312,900313,900314,150113,145496,145495,040135,221102,145497,145514,022501,040443,042010,"+
"180130,180131,124411,124412,124514,124515,124516,124517,124705,124709,124716,124713,080723,080728,122718," + 
"020829, 023309,023335" ;
  
// 인기 패션 분류 추가 
bundle = bundle + "14710420,14710421,14710120,14710121,14710720,14710721,14711120,14711121,14720191,"
			    + "14720192,14720193,14720194,14720691,14720692,14721091,14721092,14721093,14730191,"
			    + "14730192,14730193,14730194,14730591,14730592";
  
function changeCategory(cate){
	goCategory(cate, '');
}
function goCategory_location(cate, bundle_cates, isgo){
	if(cate.substring(0,2)=="14"){
		goFashionCategory_Spread(cate,'','');
	}
	if(cate=="030434"){
		cate = "03043404";
	}
	if(cate=="030522"){
		cate = "03052201";
	}
	if(cate.substring(0,6) != dcate_click){
		document.getElementById("dcate_layer").style.display = "none";			
		document.getElementById("dcate_layer_pointer").style.display = "none";
		document.getElementById("dcate_layer").innerHTML = "";
		dcate_click = "";
		dcate_over = "";
	}
	if(!goJumpCategory(cate)){
		var oObject_IMG  = document.getElementById("img_menu").getElementsByTagName("IMG");
		var oObject_TEXT = document.getElementById("img_menu").getElementsByTagName("dt");
		var oObject_DCATE= document.getElementById("img_menu").getElementsByTagName("div");
		
		// 소분류 이미지 모두 원래대로 _ 시작
		for(var i = 0 ; i < oObject_IMG.length ; i ++){
			var imgId = oObject_IMG[i].getAttribute("id");
			if( imgId == "" || imgId == "null" ){
			}else{
				if(document.getElementById(imgId) == "[object]" || document.getElementById(imgId) == "[object HTMLImageElement]"){
					if (document.getElementById("small_img_bg_"+imgId.substring(10,16))){
						document.getElementById("small_img_bg_"+imgId.substring(10,16)).style.display = "";
					}
					if (document.getElementById("small_img_bg2_"+imgId.substring(10,16))){
						document.getElementById("small_img_bg2_"+imgId.substring(10,16)).style.display = "none";
					}
				}
			}		
		}
		// 소분류 이미지 모두 원래대로 _ 끝
 
		 
		// 소분류명 모두 원래대로 _ 시작
		for(var i = 0 ; i < oObject_TEXT.length ; i ++){
			var textId = oObject_TEXT[i].getAttribute("id");
			if( textId == "" || textId == "null" ){
			}else{
				//if(document.getElementById(textId) == "[object]"  || document.getElementById(textId) == "[object HTMLElement]" || document.getElementById(textId) == "[object HTMLCollection]" ){	
					document.getElementById(textId).style.color = "#000000";
				//}
			}
		}
		
		// 소분류명 모두 원래대로 _ 끝

		
		// 미분류명 모두 원래대로 _ 시작
		if(cate.length > 4){
			for(var i = 0 ; i < oObject_DCATE.length ; i ++){
				var dcateId = oObject_DCATE[i].getAttribute("id");
				if (dcateId != null && dcateId != "" && dcateId.indexOf("Stext_") < 0 && dcateId.indexOf("img") < 0 && dcateId.indexOf("dcate_text_") < 0){
					if(document.getElementById(dcateId).className != "cate_text_ex1" && document.getElementById(dcateId).className != "cate_text_ex2"){
						if(document.getElementById(dcateId).className == "cate_text1" || document.getElementById(dcateId).className == "cate_text3"){
							if(document.getElementById(dcateId).className == "cate_text3"){
								document.getElementById(dcateId).className = "cate_text1";
							}
							document.getElementById(dcateId).style.color = "#000000";
						}else{
							if(document.getElementById(dcateId).className == "cate_text4"){
								document.getElementById(dcateId).className = "cate_text2";
							}
							document.getElementById(dcateId).style.color = "#5e5e5e";
						}
					}
				}
			}		
		}
		// 미분류명 모두 원래대로 _ 끝

		 
		// 현재 클릭한 소분류 테두리 빨간 이미지로(_location) _ 시작
		if(document.getElementById("dcate_img_"+cate.substring(0,6)) == "[object]" || document.getElementById("dcate_img_"+cate.substring(0,6)) == "[object HTMLImageElement]"){
			//document.getElementById("dcate_img_"+cate.substring(0,6)).src = var_image_enuri_com + "/images/view/ls_scate/"+cate.substring(0,6)+"_location.gif";
			//document.getElementById("dcate_img_"+cate.substring(0,6)).className = "scate_img_location";
			if (document.getElementById("small_img_bg_"+cate.substring(0,6))){
				document.getElementById("small_img_bg_"+cate.substring(0,6)).style.display = "none";
			}
			if (document.getElementById("small_img_bg2_"+cate.substring(0,6))){
				document.getElementById("small_img_bg2_"+cate.substring(0,6)).style.display = "";
			}
		}
		// 현재 클릭한 소분류 테두리 빨간 이미지로(_location) _ 끝  

		
		// 현재 클릭한 소분류명 빨간색으로 _ 시작
		//if(document.getElementById("dcate_text_"+cate.substring(0,6))  == "[object]" || document.getElementById("dcate_text_"+cate.substring(0,6)) == "[object HTMLElement]" || document.getElementById("dcate_text_"+cate.substring(0,6)) == "[object HTMLCollection]" ){
		if (cate.length > 4){
			document.getElementById("Stext_"+cate.substring(0,6)).style.color = "#BD0F0E";
		}
		//}
		// 현재 클릭한 소분류명 빨간색으로 _ 끝

		
		// 현재 클릭한 미분류명 빨간색으로 _ 시작
		if( cate.length > 6 ){
			if (document.getElementById("dlink_"+cate)){
				if(document.getElementById(dcateId).className != "cate_text_ex1" && document.getElementById(dcateId).className != "cate_text_ex2"){
					if(document.getElementById("dlink_"+cate).className == "cate_text1" ){
						document.getElementById("dlink_"+cate).className = "cate_text3";
						document.getElementById("dlink_"+cate).style.color = "#BD0F0E";
						document.getElementById("dcate_text_"+cate.substring(0,6)).style.backgroundColor = "red";
					}else if(document.getElementById("dlink_"+cate).className == "cate_text2" ){
						document.getElementById("dlink_"+cate).className = "cate_text4";
						document.getElementById("dlink_"+cate).style.color = "#BD0F0E";
					}
				}
			}
		}
		// 현재 클릭한 미분류명 빨간색으로 _ 끝

		
		//페이지 cate로 넘겨줌  _ 시작
		//Body 페이지에서 뒤로가기때문에 넘겨주는 파라미터가 있으면 프레임 이동하지 않는다.
		if (typeof(isgo) == "undefined"){
			//if(selectedMenu == "spread_menu"){ 
			if (document.getElementById("spread_menu").innerHTML.trim().length >  0){
				/*if(cate.substring(0,4) == "1459" || cate.substring(0,3) == "147"){
					goCategory_Spread_1459(cate,'',isgo);
				}else{*/
					goCategory_Spread(cate,'',isgo);
				//}
			}
			//if(cate != "092709" && cate != "091224"){ 
			if(cate != "092709" && cate != "091224"){
				/*if(cate.substring(0,2) == "14"){
					if(cate.substring(0,4) == "1459"){
						document.getElementById("enuriListFrame").src = "/view/Listbody_Fusion_Masterpiece.jsp?cate="+cate;
					}else if(cate.substring(0,3) == "147"){
						document.getElementById("enuriListFrame").src = "/fashion/clothes/include/Listbody_Style.jsp?cate="+cate;
					}else if(cate.substring(0,3) == "145"){
						document.getElementById("enuriListFrame").src = "/view/Listbody_Fusion.jsp?cate="+cate;
					}else{
						document.getElementById("enuriListFrame").src = "/view/Listbody_Fusion.jsp?cate="+cate;
					}else{
						document.getElementById("enuriListFrame").src = "/view/Listbody_Mp3.jsp?cate="+cate;
					}
				}else{*/
					document.getElementById("enuriListFrame").src = "/view/Listbody_Mp3.jsp?cate="+cate;
				//}
			}else{
				document.getElementById("img_menu").style.marginBottom = "0px";
			}
		}
		//페이지 cate로 넘겨줌  _ 끝

	}
    hideFavoriteLayer();
	
	if(bundle_cates.length > 0 || bundle.indexOf(cate+",")){
		goBundleCate(cate);
	}
	cate_org = cate;
}

function goCategory(cate, bundle_cates, isgo){
	var strCate6 = cate;
	var bSpreadMenu = false;
	if(cate == "101447"){
		return;
	}
	
	if (document.getElementById("spread_menu")){
		if (document.getElementById("spread_menu").style.display != "none"){
			bSpreadMenu = true;
		}
	}	
	if(strCate6.length>=6 && !bSpreadMenu) {
		strCate6 = strCate6.substring(0, 6);
		//alert(strCate6); //dcate_single, dcate_group
		
		if (document.getElementById("dcate_img_"+strCate6)){
			if (isMoblie()){
				var sccf = new String(document.getElementById("dcate_img_"+strCate6).parentNode.ontouchstart);
			}else{
				var sccf = new String(document.getElementById("dcate_img_"+strCate6).parentNode.onclick);
			}
			if (sccf != null){
				if (sccf.indexOf("redBundle") >= 0){
					redBundle(strCate6,'red');
				}else{
					redCateLayer(strCate6,'red');
				}
			}else{
				if (isMoblie()){
					var sccf = new String(document.getElementById("dcate_img_"+strCate6).ontouchstart);
				}else{
					var sccf = new String(document.getElementById("dcate_img_"+strCate6).onclick);
				}
				if (sccf != null){
					if (sccf.indexOf("redBundle") >= 0){
						redBundle(strCate6,'red');
					}else{
						redCateLayer(strCate6,'red');
					}				
				}
			}
		}else if(document.getElementById("Stext_"+strCate6)){
			if (isMoblie()){
				var sccf = new String(document.getElementById("Stext_"+strCate6).ontouchstart);
			}else{
				var sccf = new String(document.getElementById("Stext_"+strCate6).onclick);
			}
			if (sccf != null){
				if (sccf.indexOf("redCateLayer") >= 0){
					redCateLayer(strCate6,'red');
				}				
			}			
		}
		/*
		if(document.getElementById("dcate_img_"+strCate6).getAttribute("name")=="dcate_single"){
			//alert(111);
			redCateLayer(strCate6,'red');
		}
		
		if(document.getElementById("dcate_img_"+strCate6).getAttribute("name")=="dcate_group"){
			//alert(222);
			redBundle(strCate6,'red');
		}	
		*/
	}
	
	/*if(cate.substring(0,2)=="14" && cate.substring(0,3) !="145"){ 
		goFashionCategory_Spread(cate,'','');
	}*/
	if(cate=="030434"){
		cate = "03043404";
	} 
	if(cate=="030522"){
		cate = "03052201";
	}
	if(cate.substring(0,6) != dcate_click && document.URL.indexOf("/view/Sslist_2013.jsp") < 0){
		document.getElementById("dcate_layer").style.display = "none";			
		document.getElementById("dcate_layer_pointer").style.display = "none";
		document.getElementById("dcate_layer").innerHTML = "";
		dcate_click = "";
		dcate_over = "";
	}
	
	
	if(!goJumpCategory(cate) && document.URL.indexOf("/view/Sslist_2013.jsp") < 0 ){
		//var oObject_IMG  = document.getElementById("img_menu").getElementsByTagName("IMG");
		var oObject_TEXT = document.getElementById("img_menu").getElementsByTagName("dt");
		var oObject_DCATE= document.getElementById("img_menu").getElementsByTagName("div");
		var oObject_DIV= document.getElementById("img_menu").getElementsByTagName("DIV");
		
		// 소분류 이미지 모두 원래대로 _ 시작
		/*
		for(var i = 0 ; i < oObject_IMG.length ; i ++){
			var imgId = oObject_IMG[i].getAttribute("id");
			if( imgId == "" || imgId == "null" ){
			}else{
				if(document.getElementById(imgId) == "[object]" || document.getElementById(imgId) == "[object HTMLImageElement]"){
					if (document.getElementById("small_img_bg_"+imgId.substring(10,16))){
						document.getElementById("small_img_bg_"+imgId.substring(10,16)).style.display = "";
					}
					if (document.getElementById("small_img_bg2_"+imgId.substring(10,16))){
						document.getElementById("small_img_bg2_"+imgId.substring(10,16)).style.display = "none";
					}
				}	
			}		
		}
		*/
		//중분류 선택시 기 선택된 소분류 이미지,텍스트 색 변경
		if (cate.length == 4 ){
			for(var i = 0 ; i < oObject_DIV.length ; i ++){
				var imgId = oObject_DIV[i].getAttribute("id");
				if (imgId != null && imgId != "" ){
					if (imgId.indexOf("img1_") >= 0 ){
						document.getElementById(imgId).style.backgroundImage = "url("+var_img_enuri_com + "/images/view/test/shadow_left.gif)";
					}
					if (imgId.indexOf("img2_") >= 0 ){
						document.getElementById(imgId).style.backgroundImage = "url("+var_img_enuri_com + "/images/view/test/shadow_top.gif)";
					}
					if (imgId.indexOf("img3_") >= 0 ){
						document.getElementById(imgId).style.backgroundImage = "url("+var_img_enuri_com + "/images/view/test/shadow_b_01.gif)";
					}
					if (imgId.indexOf("img4_") >= 0 ){
						document.getElementById(imgId).style.backgroundImage = "url("+var_img_enuri_com + "/images/view/test/shadow_b_02.gif)";
					}
					if (imgId.indexOf("img5_") >= 0 ){
						document.getElementById(imgId).style.backgroundImage = "url("+var_img_enuri_com + "/images/view/test/shadow_right.gif)";
					}
					if (imgId.indexOf("Stext_") >= 0 ){
						document.getElementById(imgId).style.color="#000000";
					}								
				}
			}
		}
		// 소분류 이미지 모두 원래대로 _ 끝
 
		 
		// 소분류명 모두 원래대로 _ 시작
		for(var i = 0 ; i < oObject_TEXT.length ; i ++){
			var textId = oObject_TEXT[i].getAttribute("id");
			if( textId == "" || textId == "null" ){
			}else{
				//if(document.getElementById(textId) == "[object]"  || document.getElementById(textId) == "[object HTMLElement]" || document.getElementById(textId) == "[object HTMLCollection]" ){	
					document.getElementById(textId).style.color = "#000000";
				//}
			}
		}
		
		// 소분류명 모두 원래대로 _ 끝

		
		// 미분류명 모두 원래대로 _ 시작
		if(cate.length > 4){
			for(var i = 0 ; i < oObject_DCATE.length ; i ++){
				var dcateId = oObject_DCATE[i].getAttribute("id");
				if (dcateId != null && dcateId != ""  && dcateId.indexOf("Stext_") < 0 && dcateId.indexOf("img") < 0 && dcateId.indexOf("dcate_text_") < 0){	
					if(document.getElementById(dcateId).className != "cate_text_ex1" && document.getElementById(dcateId).className != "cate_text_ex2"){
						if(document.getElementById(dcateId).className == "cate_text1" || document.getElementById(dcateId).className == "cate_text3"){
							if(document.getElementById(dcateId).className == "cate_text3"){
								document.getElementById(dcateId).className = "cate_text1";
							}
							document.getElementById(dcateId).style.color = "#000000";
						}else{
							if(document.getElementById(dcateId).className == "cate_text4"){
								document.getElementById(dcateId).className = "cate_text2";
							}
							document.getElementById(dcateId).style.color = "#5e5e5e";
						}
					}
				}
			}		
		}
		// 미분류명 모두 원래대로 _ 끝
		
		 
		// 현재 클릭한 소분류 테두리 빨간 이미지로(_location) _ 시작
		if(document.getElementById("dcate_img_"+cate.substring(0,6)) == "[object]" || document.getElementById("dcate_img_"+cate.substring(0,6)) == "[object HTMLImageElement]"){
			//document.getElementById("dcate_img_"+cate.substring(0,6)).src = var_image_enuri_com + "/images/view/ls_scate/"+cate.substring(0,6)+"_location.gif";
			//document.getElementById("dcate_img_"+cate.substring(0,6)).className = "scate_img_location";
			if (document.getElementById("small_img_bg_"+cate.substring(0,6))){
				document.getElementById("small_img_bg_"+cate.substring(0,6)).style.display = "none";
			}
			if (document.getElementById("small_img_bg2_"+cate.substring(0,6))){
				document.getElementById("small_img_bg2_"+cate.substring(0,6)).style.display = "";
			}
		}
		// 현재 클릭한 소분류 테두리 빨간 이미지로(_location) _ 끝  

		
		// 현재 클릭한 소분류명 빨간색으로 _ 시작
		//if(document.getElementById("dcate_text_"+cate.substring(0,6))  == "[object]" || document.getElementById("dcate_text_"+cate.substring(0,6)) == "[object HTMLElement]" || document.getElementById("dcate_text_"+cate.substring(0,6)) == "[object HTMLCollection]" ){
		if (cate.length > 4){
			if (document.getElementById("Stext_"+cate.substring(0,6))){
				document.getElementById("Stext_"+cate.substring(0,6)).style.color = "#BD0F0E";
			}
		}
		//}
		// 현재 클릭한 소분류명 빨간색으로 _ 끝

		
		// 현재 클릭한 미분류명 빨간색으로 _ 시작 url넘어오면 빨간색!!!
		if( cate.length > 6 ){
			if (document.getElementById("dlink_"+cate)){
				if(document.getElementById("dlink_"+cate).className != "cate_text_ex1" && document.getElementById("dlink_"+cate).className != "cate_text_ex2"){
					if(document.getElementById("dlink_"+cate).className == "cate_text1" ){
						document.getElementById("dlink_"+cate).className = "cate_text3";
						document.getElementById("dlink_"+cate).style.color = "#BD0F0E";
					}else if(document.getElementById("dlink_"+cate).className == "cate_text2" ){
						document.getElementById("dlink_"+cate).className = "cate_text4";
						document.getElementById("dlink_"+cate).style.color = "#BD0F0E";
					}
				}
			}
		}
		// 현재 클릭한 미분류명 빨간색으로 _ 끝
		if(cate=="040207"){
			document.getElementById("enuriListFrame").src = "/view/Listbody_Printer.jsp?cate="+cate;
		}
		/*
		if(cate=="15090901"){ 
			top.location.href = "http://www.enuri.com/view/Listmp3.jsp?cate=150909&keyword=%ED%96%84+%EC%84%B8%ED%8A%B8"
		}

		if(cate=="15090903"){
			top.location.href = "http://www.enuri.com/view/Listmp3.jsp?cate=150909&keyword=%EC%B0%B8%EC%B9%98+%EC%84%B8%ED%8A%B8"
		}
		
		if(cate=="15090909"){
			top.location.href = "http://www.enuri.com/view/Listmp3.jsp?cate=150909&keyword=%EC%97%B0%EC%96%B4"
		}
		
		if(cate=="15090908"){
			top.location.href = "http://www.enuri.com/view/Listmp3.jsp?cate=150909&keyword=%EA%B8%B0%EB%A6%84%EC%84%B8%ED%8A%B8"
		}*/
		 
		//페이지 cate로 넘겨줌  _ 시작
		//Body 페이지에서 뒤로가기때문에 넘겨주는 파라미터가 있으면 프레임 이동하지 않는다.
		if (typeof(isgo) == "undefined"){
			//if(selectedMenu == "spread_menu"){ 
			if (document.getElementById("spread_menu").innerHTML.trim().length >  0){
				/*if(cate.substring(0,4) == "1459" || cate.substring(0,3) == "147"){
					goCategory_Spread_1459(cate,'',isgo);
				}else{*/
					goCategory_Spread(cate,'',isgo);
				//}
			}
			if(cate != "092709" && cate != "091224"){ 
				/*if(cate.substring(0,2) == "14"){
					if(cate.substring(0,4) == "1459"){
						document.getElementById("enuriListFrame").src = "/view/Listbody_Fusion_Masterpiece.jsp?cate="+cate;
					}else if(cate.substring(0,3) == "147"){
						document.getElementById("enuriListFrame").src = "/fashion/clothes/include/Listbody_Style.jsp?cate="+cate;
					}else if(cate.substring(0,3) == "145"){
						document.getElementById("enuriListFrame").src = "/view/Listbody_Fusion.jsp?cate="+cate;
					}else{
						document.getElementById("enuriListFrame").src = "/view/Listbody_Fusion.jsp?cate="+cate;
					}else{
						document.getElementById("enuriListFrame").src = "/view/Listbody_Mp3.jsp?cate="+cate;
					}
				}else{*/
					if(cate != "040207"){
					document.getElementById("enuriListFrame").src = "/view/Listbody_Mp3.jsp?cate="+cate;
					}
				//}
			}else{
				document.getElementById("img_menu").style.marginBottom = "0px";
			}
		}
		//페이지 cate로 넘겨줌  _ 끝

	}
    hideFavoriteLayer();
    if( cate.length == 4 ){
		var varSCateImg = $("img_menu").getElementsBySelector('img[class="cls_dcate_img"]');
		for (var i=0;i<varSCateImg.length;i++){
			if (varSCateImg[i].src.indexOf("_location.gif") >= 0 ){
				varSCateImg[i].src = varSCateImg[i].src.replace("_location","");
			}
		}    	
    	document.getElementById("dcate_layer_over").style.display = "none";
    	document.getElementById("dcate_layer_over_pointer").style.display = "none";
    	
    	document.getElementById("dcate_layer").style.display = "none";
    	document.getElementById("dcate_layer_pointer").style.display = "none";    	
    }
	if(bundle_cates.length > 0 || bundle.indexOf(cate+",")){
		goBundleCate(cate);
	}
	cate_org = cate;
}

function goCategoryBrand(cate, gb1,gb2){

	if(cate.substring(0,6) != dcate_click){
		document.getElementById("dcate_layer").style.display = "none";			
		document.getElementById("dcate_layer_pointer").style.display = "none";
		document.getElementById("dcate_layer").innerHTML = "";
		dcate_click = "";
		dcate_over = "";
	}
	if(!goJumpCategory(cate)){
		var oObject_IMG  = document.getElementById("img_menu").getElementsByTagName("IMG");
		var oObject_TEXT = document.getElementById("img_menu").getElementsByTagName("dt");
		var oObject_DCATE= document.getElementById("img_menu").getElementsByTagName("div");
		// 소분류 이미지 모두 원래대로 _ 시작
		for(var i = 0 ; i < oObject_IMG.length ; i ++){
			var imgId = oObject_IMG[i].getAttribute("id");
			if( imgId == "" || imgId == "null"){
			}else{
				if(document.getElementById(imgId) == "[object]" || document.getElementById(imgId) == "[object HTMLImageElement]"){
					//document.getElementById(imgId).src = var_image_enuri_com + "/images/view/ls_scate/"+imgId.substring(10,16)+".gif";
					if (document.getElementById("small_img_bg_"+imgId.substring(10,16))){
						document.getElementById("small_img_bg_"+imgId.substring(10,16)).style.display = "";
					}
					if (document.getElementById("small_img_bg2_"+imgId.substring(10,16))){
						document.getElementById("small_img_bg2_"+imgId.substring(10,16)).style.display = "none";
					}					
					
					//if(document.getElementById(imgId).className != "scate_img_bg_x"){
					//	document.getElementById(imgId).className = "scate_img";
					//}
				}	
			}		
		}
		// 소분류 이미지 모두 원래대로 _ 끝
 
		
		// 소분류명 모두 원래대로 _ 시작
		for(var i = 0 ; i < oObject_TEXT.length ; i ++){
			var textId = oObject_TEXT[i].getAttribute("id");
			if( textId == "" || textId == "null" ){
			}else{
				//if(document.getElementById(textId) == "[object]"  || document.getElementById(textId) == "[object HTMLElement]" || document.getElementById(textId) == "[object HTMLCollection]" ){	
					document.getElementById(textId).style.color = "#000000";
				//}
			}
		}
		
		// 소분류명 모두 원래대로 _ 끝

		
		// 미분류명 모두 원래대로 _ 시작
		if(cate.length > 4){
			for(var i = 0 ; i < oObject_DCATE.length ; i ++){
				var dcateId = oObject_DCATE[i].getAttribute("id");
				//document.getElementById(dcateId).style.color = "#000000";
				//alert(document.getElementById(dcateId).className)
				if (dcateId != null && dcateId != "" && dcateId.indexOf("Stext_") < 0 && dcateId.indexOf("img") < 0 && dcateId.indexOf("dcate_text_") < 0){	
					if(document.getElementById(dcateId).className != "cate_text_ex1" && document.getElementById(dcateId).className != "cate_text_ex2"){
						if(document.getElementById(dcateId).className == "cate_text1" || document.getElementById(dcateId).className == "cate_text3"){
							if(document.getElementById(dcateId).className == "cate_text3"){
								document.getElementById(dcateId).className = "cate_text1";
							}
							document.getElementById(dcateId).style.color = "#000000";
						}else{
							if(document.getElementById(dcateId).className == "cate_text4"){
								document.getElementById(dcateId).className = "cate_text2";
							}
							document.getElementById(dcateId).style.color = "#5e5e5e";
						}
					}
				}
				//document.getElementById(dcateId).style.color = "#000000";
			}		
		}
		// 미분류명 모두 원래대로 _ 끝

		
		// 현재 클릭한 소분류 테두리 빨간 이미지로(_location) _ 시작
		if(document.getElementById("dcate_img_"+cate.substring(0,6)) == "[object]" || document.getElementById("dcate_img_"+cate.substring(0,6)) == "[object HTMLImageElement]"){
			//document.getElementById("dcate_img_"+cate.substring(0,6)).src = var_image_enuri_com + "/images/view/ls_scate/"+cate.substring(0,6)+"_location.gif";
			//document.getElementById("dcate_img_"+cate.substring(0,6)).className = "scate_img_location";
			if (document.getElementById("small_img_bg_"+cate.substring(0,6))){
				document.getElementById("small_img_bg_"+cate.substring(0,6)).style.display = "none";
			}
			if (document.getElementById("small_img_bg2_"+cate.substring(0,6))){
				document.getElementById("small_img_bg2_"+cate.substring(0,6)).style.display = "inline";
			}
		}
		// 현재 클릭한 소분류 테두리 빨간 이미지로(_location) _ 끝

		 
		// 현재 클릭한 소분류명 빨간색으로 _ 시작
		//if(document.getElementById("dcate_text_"+cate.substring(0,6))  == "[object]" || document.getElementById("dcate_text_"+cate.substring(0,6)) == "[object HTMLElement]" || document.getElementById("dcate_text_"+cate.substring(0,6)) == "[object HTMLCollection]" ){
		if (cate.length > 4){
			document.getElementById("dcate_text_"+cate.substring(0,6)).style.color = "#BD0F0E";
		}
		//}
		// 현재 클릭한 소분류명 빨간색으로 _ 끝

		
		// 현재 클릭한 미분류명 빨간색으로 _ 시작
		if( cate.length > 6 ){
			if (document.getElementById("dlink_"+cate)){
				if(document.getElementById(dcateId).className != "cate_text_ex1" && document.getElementById(dcateId).className != "cate_text_ex2"){
					if(document.getElementById("dlink_"+cate).className == "cate_text1" ){
						document.getElementById("dlink_"+cate).className = "cate_text3";
						document.getElementById("dlink_"+cate).style.color = "#BD0F0E";
					}else if(document.getElementById("dlink_"+cate).className == "cate_text2" ){
						document.getElementById("dlink_"+cate).className = "cate_text4";
						document.getElementById("dlink_"+cate).style.color = "#BD0F0E";
					}
				}
			}
		}
		// 현재 클릭한 미분류명 빨간색으로 _ 끝

		
		//페이지 cate로 넘겨줌  _ 시작
		//Body 페이지에서 뒤로가기때문에 넘겨주는 파라미터가 있으면 프레임 이동하지 않는다.
		document.getElementById("enuriListFrame").src = "/view/Listbody_Mp3.jsp?cate="+cate+"&gb1="+gb1+"&gb2="+gb2;
	}
    hideFavoriteLayer();
	cate_org = cate;
}

function Resize_ImgMenu(){
	if(document.getElementById("dcate_layer")){
		if(document.getElementById("dcate_layer").offsetHeight > 10){
			if(enuriListFrame.document.getElementById("rec_middle_banner") || enuriListFrame.document.getElementById("middle_plan_cate") || enuriListFrame.document.getElementById("ep_t")){
				document.getElementById("img_menu").style.marginBottom = "0px";
				if (enuriListFrame.document.getElementById("rec_middle_banner")){
					if(document.getElementById("dcate_layer").offsetHeight > 105){
						enuriListFrame.document.getElementById("rec_middle_banner").style.marginBottom = document.getElementById("dcate_layer").offsetHeight - 94 +"px";
					}
				}
				if (enuriListFrame.document.getElementById("middle_plan_cate")){
					if(document.getElementById("dcate_layer").offsetHeight > 140){
						enuriListFrame.document.getElementById("middle_plan_cate").style.marginBottom = document.getElementById("dcate_layer").offsetHeight - 129 +"px";
					}
				}
				if (enuriListFrame.document.getElementById("ep_t")){
					if(document.getElementById("dcate_layer").offsetHeight > 105){
						enuriListFrame.document.getElementById("ep_t").style.marginBottom = document.getElementById("dcate_layer").offsetHeight - 94 +"px";
					}
				}				
			}else{
				if (!(cate_org.startsWith("1434") || cate_org.startsWith("1435") || cate_org.startsWith("1436"))){
					document.getElementById("img_menu").style.marginBottom = (document.getElementById("dcate_layer").offsetHeight-14) + "px";
				}else{
					document.getElementById("img_menu").style.marginBottom = "0px";
				}
			}
		}else{
			document.getElementById("img_menu").style.marginBottom = "0px";
		}
	}
}
function CmdDLinkColorChange(param_cate, param_gubun){
	if(param_gubun == "over"){
		if(document.getElementById("dlink_"+param_cate).className == "cate_text1"){
			document.getElementById("dlink_"+param_cate).className = "cate_text3";
			document.getElementById("dlink_"+param_cate).style.color = "#BD0F0E";
		}else if(document.getElementById("dlink_"+param_cate).className == "cate_text2"){
			document.getElementById("dlink_"+param_cate).className = "cate_text4";
			document.getElementById("dlink_"+param_cate).style.color = "#BD0F0E";
		}
		//document.getElementById("dlink_"+param_cbate).style.color = "#BD0F0E";
	}else{
		if(param_cate != cate_org){
			if(document.getElementById("dlink_"+param_cate).className == "cate_text3"){
				document.getElementById("dlink_"+param_cate).className = "cate_text1";
				document.getElementById("dlink_"+param_cate).style.color = "#000000";
			}else if(document.getElementById("dlink_"+param_cate).className == "cate_text4"){
				document.getElementById("dlink_"+param_cate).className = "cate_text2";
				document.getElementById("dlink_"+param_cate).style.color = "#5e5e5e";
			}
			//document.getElementById("dlink_"+param_cate).style.color = "#5e5e5e";
		}
	}
}
function CmdColorChange(param_cate, param_gubun){
	if(param_gubun == "over"){
		if (document.getElementById("Stext_"+param_cate)){
			document.getElementById("Stext_"+param_cate).style.color = "#BD0F0E";
	
		}
	}else{
		if(param_cate != cate_org.substring(0, param_cate.length)){
			if (document.getElementById("Stext_"+param_cate)){	
				document.getElementById("Stext_"+param_cate).style.color = "#000000";
			}
		}
	}
}
function goBundleCate(cate){ 
	var bundleCate = getBundleCateList(cate);
 
	var bundleCate_s = bundleCate;  
	var bundleCate_s_arr = bundleCate_s.split(",");	
	//alert("cate="+cate+", bundleCate_s="+bundleCate_s);
	if(bundleCate_s_arr.length > 1){
		for( var i = 0 ; i < bundleCate_s_arr.length ; i ++ ){
			//document.getElementById("dcate_img_"+bundleCate_s_arr[i]).src = var_image_enuri_com + "/images/view/ls_scate/"+bundleCate_s_arr[i]+"_location.gif";
			//document.getElementById("dcate_img_"+bundleCate_s_arr[i]).className = "scate_img_location";
			//document.getElementById("small_img_bg_"+bundleCate_s_arr[i]).style.display = "none";
			if (document.getElementById("small_img_bg_"+bundleCate_s_arr[i])){
				document.getElementById("small_img_bg_"+bundleCate_s_arr[i]).style.display = "none";
			}
			if (document.getElementById("small_img_bg2_"+bundleCate_s_arr[i])){
				document.getElementById("small_img_bg2_"+bundleCate_s_arr[i]).style.display = "";
			}
		}
	}
}

function getBundleCateList(cate) {
	var bundleCate = "";

	if(cate == "020111"){			bundleCate = "020103,020105,020104,020106,020112"
	}else  if(cate == "14710720"){	bundleCate = "14710701,14710702,14710703,14710705"
	}else  if(cate == "219816"){	bundleCate = "219824,219809,219810"
	}else  if(cate == "219817"){	bundleCate = "219808,219803,219823"
	}else  if(cate == "124313"){	bundleCate = "124301,124302,124303"
	}else  if(cate == "124304"){	bundleCate = "124317,124318"
	}else  if(cate == "124314"){	bundleCate = "124305,124306,124307"
	}else  if(cate == "124315"){	bundleCate = "124308,124319"
	}else  if(cate == "124316"){	bundleCate = "124310,124311"
	}else  if(cate == "023401"){	bundleCate = "023416,023417,023418,023419"
	}else  if(cate == "023423"){	bundleCate = "023421,023422"
	}else  if(cate == "023526"){	bundleCate = "023512,023513,023514"
	}else  if(cate == "035701"){	bundleCate = "035709,035706" 
	}else  if(cate == "210325"){	bundleCate = "210310,210319" 
	}else  if(cate == "210326"){	bundleCate = "210321,210322"  
	}else  if(cate == "035705"){	bundleCate = "035730,035731"
	}else  if(cate == "122522"){	bundleCate = "122506,122503,122501,122502"
	}else  if(cate == "162020"){	bundleCate = "162011,162012,162015,162016,162014,162019"
	}else  if(cate == "035740"){	bundleCate = "035741,035742"
	}else  if(cate == "035820"){	bundleCate = "035805,035803,035818,035819"
	}else  if(cate == "164219"){	bundleCate = "164213,164214,164215"
	}else  if(cate == "164220"){	bundleCate = "164216,164217,164218"
	}else  if(cate == "164222"){	bundleCate = "164209,164221"
	}else  if(cate == "164314"){	bundleCate = "164312,164302"
	}else  if(cate == "164316"){	bundleCate = "164301,164315"
	}else  if(cate == "093213"){	bundleCate = "093201,093211,093212"
	}else  if(cate == "164413"){	bundleCate = "164409,164402,164412"
	}else  if(cate == "164515"){	bundleCate = "164505,164502,164504,164503"
	}else  if(cate == "164514"){	bundleCate = "164511,164512,164513"
	}else  if(cate == "122515"){	bundleCate = "122514,122507"
	}else  if(cate == "122713"){	bundleCate = "122704,122720,122721"
	}else  if(cate == "122721"){	bundleCate = "122712,122705" 
	}else  if(cate == "122612"){	bundleCate = "122610,122615,122611,122613"
	}else  if(cate == "122808"){	bundleCate = "122801,122802,122821"
	}else  if(cate == "120123"){	bundleCate = "120120,120122,120126"
	}else  if(cate == "122809"){	bundleCate = "122805,122813,122806"
	}else  if(cate == "122820"){	bundleCate = "122816,122817,122818,122819"
	}else  if(cate == "14710420"){	bundleCate = "14710401,14710402"
	}else  if(cate == "051524"){	bundleCate = "051523,051513"
	}else  if(cate == "160712"){	bundleCate = "160709,160710,160711"
	}else  if(cate == "14710421"){	bundleCate = "14710411,14710412"
	}else  if(cate == "14710120"){	bundleCate = "14710102,14710104,14710105"
	}else  if(cate == "14710121"){	bundleCate = "14710111,14710112,14710113"
	}else  if(cate == "14710721"){	bundleCate = "14710711,14710712,14710713"
	}else  if(cate == "14711121"){	bundleCate = "14711111,14711112,14711113"
	}else  if(cate == "14720191"){	bundleCate = "14720101,14720102,14720103"
	}else  if(cate == "14720192"){	bundleCate = "14720111,14720112,14720113"
	}else  if(cate == "14720193"){	bundleCate = "14720124,14720123,14720122"
	}else  if(cate == "14720194"){	bundleCate = "14720125,14720126"
	}else  if(cate == "14720691"){	bundleCate = "14720601,14720602,14720603,14720604"
	}else  if(cate == "14720692"){	bundleCate = "14720611,14720612,14720613"
	}else  if(cate == "14721092"){	bundleCate = "14721011,14721012,14721024,14721013"
	}else  if(cate == "14730191"){	bundleCate = "14730101,14730102,14730104"
	}else  if(cate == "14730192"){	bundleCate = "14730111,14730112,14730113"
	}else  if(cate == "14730193"){	bundleCate = "14730121,14730122,14730123"
	}else  if(cate == "14730194"){	bundleCate = "14730131,14730132"
	}else  if(cate == "14730591"){	bundleCate = "14730501,14730502,14730503"
	}else  if(cate == "14730592"){	bundleCate = "14730511,14730512"
	}else  if(cate == "020925"){	bundleCate = "020922,020921,020923,020904,020927"
	}else  if(cate == "034210"){	bundleCate = "034201,034202,034203,034205,034212"
	}else  if(cate == "034214"){	bundleCate = "034208,034213,034215"
	}else  if(cate == "093508"){	bundleCate = "093501,093502,093503"
	}else  if(cate == "050715"){	bundleCate = "050711,050712,050713,050714"
	}else  if(cate == "070911"){	bundleCate = "070903,070906,070901,070908"
	}else  if(cate == "070912"){	bundleCate = "070905,070902,070910,070904"
	}else  if(cate == "092415"){	bundleCate = "092402,092414,092408,092406,092417"
	}else  if(cate == "092412"){	bundleCate = "092403,092420,092421,092422"
	}else  if(cate == "161315"){	bundleCate = "161314,161307"
	}else  if(cate == "023828"){	bundleCate = "023805,023827"
	}else  if(cate == "042222"){	bundleCate = "042220,042221,042203"
	}else  if(cate == "042320"){	bundleCate = "042311,042319"
	}else  if(cate == "221212"){	bundleCate = "221201,221202"
	}else  if(cate == "221312"){	bundleCate = "221301,221316,221302"
	}else  if(cate == "071519"){	bundleCate = "071509,071510,071511"
	}else  if(cate == "071518"){	bundleCate = "071513,071514"
	}else  if(cate == "222211"){	bundleCate = "222201,222202,222203"
	}else  if(cate == "222611"){	bundleCate = "222601,222602,222614"
	}else  if(cate == "224209"){	bundleCate = "224201,224202"
	}else  if(cate == "222711"){	bundleCate = "222701,222702,222714"
	}else  if(cate == "224311"){	bundleCate = "224301,224302,224303"
	}else  if(cate == "122008"){	bundleCate = "122001,122002,122003,122004,122010"
	}else  if(cate == "120311"){	bundleCate = "120314,120301,120315,120312"
	}else  if(cate == "120318"){	bundleCate = "120316,120319,120317,120301"
	}else  if(cate == "210616"){	bundleCate = "210608,210617" 
	}else  if(cate == "021134"){	bundleCate = "021128,021130,021132"
	}else  if(cate == "021138"){	bundleCate = "021139,021137,021136"
	}else  if(cate == "210624"){	bundleCate = "210620,210625"
	}else  if(cate == "210622"){	bundleCate = "210621,210623"
	}else  if(cate == "210522"){	bundleCate = "210523,210511"
	}else  if(cate == "020306"){	bundleCate = "020310,020308,020301,020318"
	}else  if(cate == "182210"){	bundleCate = "182201,182202,182203,182204,182212"
	}else  if(cate == "182211"){	bundleCate = "182205,182206,182207,182208,182209"
	}else  if(cate == "020816"){	bundleCate = "020810,020804"
	}else  if(cate == "020818"){	bundleCate = "020819,020820,020826"
	}else  if(cate == "020829"){	bundleCate = "020806,020830"
	}else  if(cate == "020824"){	bundleCate = "020823,020825,020822"
	}else  if(cate == "022015"){	bundleCate = "022003,022014"
	}else  if(cate == "021511"){	bundleCate = "021518,021507,021513,021517,021521"
	}else  if(cate == "021528"){	bundleCate = "021522,021523,021524,021525,021526,021527"
	}else  if(cate == "021237"){	bundleCate = "021225,021226,021246"
	}else  if(cate == "181706"){	bundleCate = "181702,181705"
	}else  if(cate == "023309"){	bundleCate = "023310,023311,023312,023313"
	}else  if(cate == "023335"){	bundleCate = "023302,023303,023301"
	}else  if(cate == "150511"){	bundleCate = "150501,150510,150512"
	}else  if(cate == "124201"){	bundleCate = "124202,124203,124205"
	}else  if(cate == "124217"){	bundleCate = "124215,124216"
	}else  if(cate == "124208"){	bundleCate = "124209,124210"
	}else  if(cate == "101215"){	bundleCate = "101205,101216"
	}else  if(cate == "181712"){	bundleCate = "181709,181710,181713"
	}else  if(cate == "022211"){	bundleCate = "022217,022218,022219,022220"
	}else  if(cate == "022221"){	bundleCate = "022214,022215,022216"
	}else  if(cate == "021709"){	bundleCate = "021701,021702,021703"
	}else  if(cate == "021710"){	bundleCate = "021704,021705"
	}else  if(cate == "120715"){	bundleCate = "120701,120714"
	}else  if(cate == "022101"){	bundleCate = "022116,022117,022118,022119"
	}else  if(cate == "020708"){	bundleCate = "020704,020707,020711"
	}else  if(cate == "020408"){	bundleCate = "020409,020410"
	}else  if(cate == "122515"){	bundleCate = "122507,122524,12225,122526"
	}else  if(cate == "020402"){	bundleCate = "020405,020406"
	}else  if(cate == "123012"){	bundleCate = "123001,123002,123016"
	}else  if(cate == "123013"){	bundleCate = "123005,123006,123007"
	}else  if(cate == "022007"){	bundleCate = "022001,022002,022016,022005,022008"
	}else  if(cate == "022609"){	bundleCate = "022610,022601,022602,022603"
	}else  if(cate == "022013"){	bundleCate = "022010,022011,022012"
	}else  if(cate == "030409"){	bundleCate = "030401,030403,030405"
	}else  if(cate == "030447"){	bundleCate = "030446,030445"
	}else  if(cate == "030428"){	bundleCate = "030424,030425,030426,030427"
	}else  if(cate == "030707"){	bundleCate = "030701,030702"
	}else  if(cate == "040536"){	bundleCate = "040530,040533"
	}else  if(cate == "040537"){	bundleCate = "040531,040534"
	}else  if(cate == "214020"){	bundleCate = "214001,214002,214003,214004,214005"
	}else  if(cate == "214021"){	bundleCate = "214006,214007,214008,214009,214010,214011"
	}else  if(cate == "069204"){	bundleCate = "069202,069201,069211"
	}else  if(cate == "069203"){	bundleCate = "069207,069205"
	}else  if(cate == "189001"){	bundleCate = "189002,189003,189004"
	}else  if(cate == "189009"){	bundleCate = "189010,189011,189012,189014"
	}else  if(cate == "069105"){	bundleCate = "069102,069106,069108"
	}else  if(cate == "240305"){	bundleCate = "240307,240308,240313,240309" 
	}else  if(cate == "213111"){	bundleCate = "213101,213102,213103" 
	}else  if(cate == "213125"){	bundleCate = "213120,213121" 
	}else  if(cate == "210816"){	bundleCate = "210809,210806" 
	}else  if(cate == "213117"){	bundleCate = "213110,213116" 
	}else  if(cate == "210831"){	bundleCate = "210819,210821" 
	}else  if(cate == "031317"){	bundleCate = "031314,031316,031306,031309,031320"
	}else  if(cate == "031801"){	bundleCate = "031802,031803,031816"
	}else  if(cate == "031822"){	bundleCate = "031811,031821"
	}else  if(cate == "031901"){	bundleCate = "031902,031903,031904"
	}else  if(cate == "120527"){	bundleCate = "120526,120509"
	}else  if(cate == "031905"){	bundleCate = "031906,031907,031908,031910"
	}else  if(cate == "180210"){	bundleCate = "180202,180209,180208"
	}else  if(cate == "180217"){	bundleCate = "180213,180215,180220"
	}else  if(cate == "180218"){	bundleCate = "180206,180216"
	}else  if(cate == "040818"){	bundleCate = "040811,040809,040812,040823,040824"
	}else  if(cate == "031809"){	bundleCate = "031814,031812"
	}else  if(cate == "040819"){	bundleCate = "040817,040820,040803"
	}else  if(cate == "080720"){	bundleCate = "080719,080703"
	}else  if(cate == "040205"){	bundleCate = "040210,040220,040209" 
	}else  if(cate == "040208"){	bundleCate = "040206,040201,040202"
	}else  if(cate == "212211"){	bundleCate = "212201,212204,212208,212205,212206"
	}else  if(cate == "240111"){	bundleCate = "240104,240102,240105,240120"
	}else  if(cate == "051418"){	bundleCate = "051409,051423,051419" 
	}else  if(cate == "051424"){	bundleCate = "051425,051426,051427" 
	}else  if(cate == "051422"){	bundleCate = "051420,051421"
	}else  if(cate == "240516"){	bundleCate = "240514,240502,240505,240524"
	}else  if(cate == "050208"){	bundleCate = "050209,050210"
	}else  if(cate == "062211"){	bundleCate = "062202,062203"
	}else  if(cate == "062212"){	bundleCate = "062204,062205"
	}else  if(cate == "023525"){	bundleCate = "023530,023531"
	}else  if(cate == "052609"){	bundleCate = "052601,052618,052619,052604"
	}else  if(cate == "052620"){	bundleCate = "052602,052621"
	}else  if(cate == "060823"){	bundleCate = "060802,060801"
	}else  if(cate == "052610"){	bundleCate = "052605,052617,052606"
	}else  if(cate == "051015"){	bundleCate = "051024,051002,051004,051017"
	}else  if(cate == "051014"){	bundleCate = "051011,051007"
	}else  if(cate == "240409"){	bundleCate = "240405,240406"
	}else  if(cate == "051114"){	bundleCate = "051109,051107"
	}else  if(cate == "050911"){	bundleCate = "050909,050907"
	}else  if(cate == "060711"){	bundleCate = "060701,060712"
	}else  if(cate == "051309"){	bundleCate = "051320,051321,051303"
	}else  if(cate == "051326"){	bundleCate = "051322,051323,051324,051325"
	}else  if(cate == "050702"){	bundleCate = "050705,050707,050716"
	}else  if(cate == "051108"){	bundleCate = "051111,051112,051103"
	}else  if(cate == "120830"){	bundleCate = "120824,120829,120820"
	}else  if(cate == "060116"){	bundleCate = "060113,060114,060115"
	}else  if(cate == "060101"){	bundleCate = "060110,060108"
	}else  if(cate == "041412"){	bundleCate = "041403,041408"
	}else  if(cate == "181815"){	bundleCate = "181805,181802,181803"
	}else  if(cate == "060221"){	bundleCate = "060202,060204,060220,060224,060225"
	}else  if(cate == "060217"){	bundleCate = "060214,060215,060216"
	}else  if(cate == "050817"){	bundleCate = "050801,050818,050819,050820"
	}else  if(cate == "060501"){	bundleCate = "060514,060515,060521"
	}else  if(cate == "240311"){	bundleCate = "240306,240312"
	}else  if(cate == "060524"){	bundleCate = "060508,060504,060532"
	}else  if(cate == "060526"){	bundleCate = "060527,060528,060531,060529"
	}else  if(cate == "060502"){	bundleCate = "060522,060523"
	}else  if(cate == "060628"){	bundleCate = "060601,060606,060630,060626"
	}else  if(cate == "060627"){	bundleCate = "060621,060617,060610,060611"
	}else  if(cate == "060307"){	bundleCate = "060308,060309,060310"
	}else  if(cate == "060302"){	bundleCate = "060311,060314,060304"
	}else  if(cate == "145124"){	bundleCate = "145114,145115,145124,145117,145121"
	}else  if(cate == "060915"){	bundleCate = "060907,060914"
	}else  if(cate == "051005"){	bundleCate = "051003,051006"
	}else  if(cate == "060911"){	bundleCate = "060908,060909,060912,060910"
	}else  if(cate == "062007"){	bundleCate = "062001,062002,062003,062009"
	}else  if(cate == "061012"){	bundleCate = "061004,061018,061013"
	}else  if(cate == "060405"){	bundleCate = "060401,060404,060402"
	}else  if(cate == "070204"){	bundleCate = "070224,070202,070203,070216" 
	}else  if(cate == "145912"){	bundleCate = "145901,145902" 
	}else  if(cate == "070401"){	bundleCate = "070402,070403,070411,070404"
	}else  if(cate == "071201"){	bundleCate = "071202,071203,071204,071205,071206"
	}else  if(cate == "070408"){	bundleCate = "070412,070413,070414"
	}else  if(cate == "070307"){	bundleCate = "070301,070302,070309,070340,070311"
	}else  if(cate == "070308"){	bundleCate = "070341,070310,070305,070304"
	}else  if(cate == "071306"){	bundleCate = "071301,071315,071302"
	}else  if(cate == "071307"){	bundleCate = "071303,071304,071312,071317"
	}else  if(cate == "071313"){	bundleCate = "071303,071304,071308"
	}else  if(cate == "070618"){	bundleCate = "070613,070614"
	}else  if(cate == "070619"){	bundleCate = "070609,070610,070611"
	}else  if(cate == "070509"){	bundleCate = "070511,070510"
	}else  if(cate == "023521"){	bundleCate = "023519,023515,023510"
	}else  if(cate == "070514"){	bundleCate = "070504,070507"
	}else  if(cate == "240724"){	bundleCate = "240714,240725"
	}else  if(cate == "070706"){	bundleCate = "070701,070702"
	}else  if(cate == "070707"){	bundleCate = "070703,070704,070705,070710" 
	}else  if(cate == "070809"){	bundleCate = "070801,070802,070803"
	}else  if(cate == "070810"){	bundleCate = "070804,070805,070806"
	}else  if(cate == "071009"){	bundleCate = "071002,071008,071003,071019"
	}else  if(cate == "071010"){	bundleCate = "071004,071005,071016"
	}else  if(cate == "071101"){	bundleCate = "071103,071111,071104,071115,071105"
	}else  if(cate == "071102"){	bundleCate = "071111,071108,071109,071110"
	}else  if(cate == "071409"){	bundleCate = "071401,071402"
	}else  if(cate == "164912"){	bundleCate = "164901,164902,164903,164904,164905"
	}else  if(cate == "164913"){	bundleCate = "164906,164907,164908,164909,164910,164911"
	}else  if(cate == "071410"){	bundleCate = "071403,071406,071404"
	}else  if(cate == "080411"){	bundleCate = "080405,080420,080409,080410"
	}else  if(cate == "091215"){	bundleCate = "091212,091213"
	}else  if(cate == "092416"){	bundleCate = "092405,092407,092413"
	}else  if(cate == "092510"){	bundleCate = "092512,092502,092503,092504"
	}else  if(cate == "092511"){	bundleCate = "092505,092506,092513,092514"
	}else  if(cate == "090608"){	bundleCate = "090601,090602,090610"
	}else  if(cate == "092412"){	bundleCate = "092403,092411"
	}else  if(cate == "092415"){	bundleCate = "092402,092414,092408"
	}else  if(cate == "092015"){	bundleCate = "092001,092014,092012"
	}else  if(cate == "091509"){	bundleCate = "091501,091512,091502,091516"
	}else  if(cate == "091510"){	bundleCate = "091513,091505,091506"
	}else  if(cate == "090108"){	bundleCate = "090115,090117"
	}else  if(cate == "091614"){	bundleCate = "091608,091609,091618,091619"
	}else  if(cate == "091615"){	bundleCate = "091612,091605,091617"
	}else  if(cate == "091301"){	bundleCate = "091302,091316,091317,091303,091304"
	}else  if(cate == "091305"){	bundleCate = "091306,091307,091308"
	}else  if(cate == "091802"){	bundleCate = "091809,091810"
	}else  if(cate == "091806"){	bundleCate = "091803,091804"
	}else  if(cate == "091925"){	bundleCate = "091920,091921,091922,091923,091924"
	}else  if(cate == "091113"){	bundleCate = "091103,091112"
	}else  if(cate == "090910"){	bundleCate = "090901,090902,090903"
	}else  if(cate == "101433"){	bundleCate = "101417,101437,101424,101421"
	}else  if(cate == "090321"){	bundleCate = "090308,090318,090331,090317,090318,090320"
	}else  if(cate == "090326"){	bundleCate = "090325,090310"
	}else  if(cate == "100506"){	bundleCate = "100511,100512,100513,100514"
	}else  if(cate == "100519"){	bundleCate = "100518,100501"
	}else  if(cate == "100409"){	bundleCate = "100408,100401,100412"
	}else  if(cate == "100411"){	bundleCate = "100410,100404"
	}else  if(cate == "100701"){	bundleCate = "100703,100707"
	}else  if(cate == "124013"){	bundleCate = "124001,124002,124003"
	}else  if(cate == "124015"){	bundleCate = "124008,124009"
	}else  if(cate == "143715"){	bundleCate = "143701,143702,143703,143704"
	}else  if(cate == "143716"){	bundleCate = "143705,143706,143707"
	}else  if(cate == "100725"){	bundleCate = "100702,100722,100712,100713,100715"
	}else  if(cate == "081023"){	bundleCate = "081009,081025"
	}else  if(cate == "101211"){	bundleCate = "101201,101213"
	}else  if(cate == "121519"){	bundleCate = "121515,121516,121517"
	}else  if(cate == "100809"){	bundleCate = "100807,100808"
	}else  if(cate == "101504"){	bundleCate = "101505,101512,101513"
	}else  if(cate == "100416"){	bundleCate = "100415,100403"
	}else  if(cate == "093111"){	bundleCate = "093102,093103,093104,093115"
	}else  if(cate == "034911"){	bundleCate = "034901,034902,034903"
	}else  if(cate == "034912"){	bundleCate = "034904,034905,034906"
	}else  if(cate == "034913"){	bundleCate = "034907,034908,034909"
	}else  if(cate == "100111"){	bundleCate = "100102,100110,100114"
	}else  if(cate == "100109"){	bundleCate = "100103,100101"
	}else  if(cate == "051120"){	bundleCate = "051118,051119,051110"
	}else  if(cate == "101113"){	bundleCate = "101108,101117,101111"
	}else  if(cate == "101121"){	bundleCate = "101119,101120"
	}else  if(cate == "102210"){	bundleCate = "102205,102206" 
	}else  if(cate == "222811"){	bundleCate = "222801,222802" 
	}else  if(cate == "024212"){	bundleCate = "024207,024208,024209,024210,024211" 
	}else  if(cate == "101115"){	bundleCate = "101110,101109,101114,101118"
	}else  if(cate == "035111"){	bundleCate = "035101,035102,035114"
	}else  if(cate == "035112"){	bundleCate = "035103,035104,035105"
	}else  if(cate == "035113"){	bundleCate = "035107,035106,035108,035109"
	}else  if(cate == "102010"){	bundleCate = "102001,102002,102003,102004,102012"
	}else  if(cate == "102011"){	bundleCate = "102013,102008,102009"	
	}else  if(cate == "100319"){	bundleCate = "100303,100316,100317"	 
	}else  if(cate == "120104"){	bundleCate = "120110,120111,120112,120113,120114"
	}else  if(cate == "120201"){	bundleCate = "120211,120212,120222"
	}else  if(cate == "120216"){	bundleCate = "120204,120214"
	}else  if(cate == "120217"){	bundleCate = "120205,120209" 
	}else  if(cate == "121309"){	bundleCate = "121307,121301,121302,121303,121314"
	}else  if(cate == "121318"){	bundleCate = "121307,121319"
	}else  if(cate == "120512"){	bundleCate = "120501,120524,120502,120518,120516"
	}else  if(cate == "120523"){	bundleCate = "120521,120504,120522"
	}else  if(cate == "081319"){	bundleCate = "081314,081315,081316,081317,081318"
	}else  if(cate == "120418"){	bundleCate = "120403,120410,120404,120407,120414"
	}else  if(cate == "120415"){	bundleCate = "120402,120406,120419,120408"
	}else  if(cate == "120405"){	bundleCate = "120403,120410,120404,120407,120414"
	}else  if(cate == "121509"){	bundleCate = "121501,121511,121502,121504,121512"
	}else  if(cate == "121510"){	bundleCate = "121505,121507"
	}else  if(cate == "120839"){	bundleCate = "120840,120842"	
	}else  if(cate == "211527"){	bundleCate = "211505,211522" 
	}else  if(cate == "122008"){	bundleCate = "122001,122002,122003,122004,122010"
	}else  if(cate == "122009"){	bundleCate = "122005,122006,122007"
	}else  if(cate == "051114"){	bundleCate = "051109,051107"
	}else  if(cate == "034214"){	bundleCate = "034208,034213"
	}else  if(cate == "162316"){	bundleCate = "162308,162315"
	}else  if(cate == "080232"){	bundleCate = "080226,080227"
	}else  if(cate == "080234"){	bundleCate = "080225,080201,080202,080203,080204"
	}else  if(cate == "150607"){	bundleCate = "150601,050602,150608,150609,150610"
	}else  if(cate == "161211"){	bundleCate = "161201,161203,161204,161215,161207"
	}else  if(cate == "224411"){	bundleCate = "224401,224402"
	}else  if(cate == "161212"){	bundleCate = "161213,161214"
	}else  if(cate == "162111"){	bundleCate = "162101,162102"
	}else  if(cate == "230410"){	bundleCate = "230401,230402,230408,230404,230406"
	}else  if(cate == "230413"){	bundleCate = "230411,230412,230414"
	}else  if(cate == "230508"){	bundleCate = "230505,230507,230511,230506"
	}else  if(cate == "162611"){	bundleCate = "162602,162616" 
	}else  if(cate == "222312"){	bundleCate = "222301,222302,222303" 
	}else  if(cate == "160204"){	bundleCate = "160207,160221,160201,160205"
	}else  if(cate == "145519"){	bundleCate = "145504,145508"
	}else  if(cate == "230208"){	bundleCate = "230201,230202,230205,230204"
	}else  if(cate == "162316"){	bundleCate = "162308,162315"
	}else  if(cate == "161308"){	bundleCate = "161309,161312,161310" 
	}else  if(cate == "163112"){	bundleCate = "163110,163111"
	}else  if(cate == "092316"){	bundleCate = "092302,092303,092318"
	}else  if(cate == "092317"){	bundleCate = "092319,092320,092321"
	}else  if(cate == "160613"){	bundleCate = "160604,160612,160605,160610"
	}else  if(cate == "163206"){	bundleCate = "163202,163201,163203,163210"
	}else  if(cate == "163207"){	bundleCate = "163211,163214,163213,163204"
	}else  if(cate == "162709"){	bundleCate = "162701,162702,162703,162704"
	}else  if(cate == "162710"){	bundleCate = "162705,162707,162708"
	}else  if(cate == "211535"){	bundleCate = "211510,211532"
	}else  if(cate == "211536"){	bundleCate = "211511,211533"
	}else  if(cate == "211537"){	bundleCate = "211512,211534"
	}else  if(cate == "211523"){	bundleCate = "211513,211514"
	}else  if(cate == "210616"){	bundleCate = "210617,210620,210608"
	}else  if(cate == "036328"){	bundleCate = "036315,036328"
	}else  if(cate == "036329"){	bundleCate = "036316,036327"
	}else  if(cate == "036330"){	bundleCate = "036325,036320"
	}else  if(cate == "036209"){	bundleCate = "036216,036208"
	}else  if(cate == "211429"){	bundleCate = "211424,211425,211426,211427,211428"
	}else  if(cate == "036415"){	bundleCate = "036402,036414,036420"
	}else  if(cate == "036413"){	bundleCate = "036422,036423"
	}else  if(cate == "036417"){	bundleCate = "036418,036416"
	}else  if(cate == "211610"){	bundleCate = "211601,211602"
	}else  if(cate == "219613"){	bundleCate = "219611,219608,219612"
	}else  if(cate == "219614"){	bundleCate = "219604,219605,219602"
	}else  if(cate == "971609"){	bundleCate = "971603,971604,971611,971605" 
	}else  if(cate == "036313"){	bundleCate = "036307,036311"
	}else  if(cate == "212209"){	bundleCate = "212202,212203"
	}else  if(cate == "219816"){	bundleCate = "219808,219820,219809,219810" 
	}else  if(cate == "219817"){	bundleCate = "219812,219821,219813"
	}else  if(cate == "219818"){	bundleCate = "219814,219822,219815"
	}else  if(cate == "163710"){	bundleCate = "163701,163702,163703,163704,163705"
	}else  if(cate == "163711"){	bundleCate = "163707,163708,163709"
	}else  if(cate == "083418"){	bundleCate = "083414,083415"
	}else  if(cate == "083419"){	bundleCate = "083405,083406,083407"
	}else  if(cate == "083420"){	bundleCate = "083416,083417,083404"
	}else  if(cate == "160811"){	bundleCate = "160801,160810"
	}else  if(cate == "160812"){	bundleCate = "160805,160802,160809"
	}else  if(cate == "160813"){	bundleCate = "160803,160806"
	}else  if(cate == "103009"){	bundleCate = "103002,103001"
	}else  if(cate == "103009"){	bundleCate = "103006,103007,103008"
	}else  if(cate == "080723"){	bundleCate = "080724,080725,080726,080727"
	}else  if(cate == "080728"){	bundleCate = "080729,080730,080731,080732,080733"
	}else  if(cate == "080232"){	bundleCate = "080226,080227"
	}else  if(cate == "080234"){	bundleCate = "080225,080230"
	}else  if(cate == "210422"){	bundleCate = "210421,210401"
	}else  if(cate == "210423"){	bundleCate = "210402.210404,210426"
	}else  if(cate == "210424"){	bundleCate = "210409.210408.210416"
	}else  if(cate == "082508"){	bundleCate = "082501,082502,082503"
	}else  if(cate == "082509"){	bundleCate = "082505,082506,082507"
	}else  if(cate == "161110"){	bundleCate = "161101,161102,161103"
	}else  if(cate == "030443"){	bundleCate = "030420,030442"
	}else  if(cate == "071519"){	bundleCate = "071509,071510,071511"
	}else  if(cate == "071518"){	bundleCate = "071513,071514"
	}else  if(cate == "032808"){	bundleCate = "032812,032801,032802,032803"
	}else  if(cate == "032809"){	bundleCate = "032805,032813,032806"  
	}else  if(cate == "122104"){	bundleCate = "122101,122102,122103"
	}else  if(cate == "122108"){	bundleCate = "122105,122106,122107"
	}else  if(cate == "122112"){	bundleCate = "122109,122110,122111"
	}else  if(cate == "240616"){	bundleCate = "240602,240601,240610"
	}else  if(cate == "092111"){	bundleCate = "092101,092108,092103,092102"
	}else  if(cate == "160313"){	bundleCate = "160302,160306,160303,160311"
	}else  if(cate == "160516"){	bundleCate = "160508,160515"
	}else  if(cate == "033209"){	bundleCate = "033201,033202,033203,033204"
	}else  if(cate == "145123"){	bundleCate = "145104,145108,145103"
	}else  if(cate == "033210"){	bundleCate = "033205,033206,033207"
	}else  if(cate == "041801"){	bundleCate = "041811,041803,041804,041805,041810"
	}else  if(cate == "061016"){	bundleCate = "061015,061011"
	}else  if(cate == "086602"){	bundleCate = "086603,086604"
	}else  if(cate == "086605"){	bundleCate = "086606,086607,086608" 
	}else  if(cate == "052712"){	bundleCate = "052701,052703,052714,052715"
	}else  if(cate == "030440"){	bundleCate = "030431,030432,030410,030434"
	}else  if(cate == "041022"){	bundleCate = "041003,041020,041021"
	}else  if(cate == "163510"){	bundleCate = "163505,163508,163511"
	}else  if(cate == "021121"){	bundleCate = "021105,021115"
	}else  if(cate == "101016"){	bundleCate = "101014,101019,101015,101002"
	}else  if(cate == "163713"){	bundleCate = "163712,163706"
	}else  if(cate == "082811"){	bundleCate = "071701,082802,082803"
	}else  if(cate == "082812"){	bundleCate = "082804,082805,082806,082807"
	}else  if(cate == "162115"){	bundleCate = "162114,162106"
	}else  if(cate == "081311"){	bundleCate = "081301,081309,081302,081312"
	}else  if(cate == "030560"){	bundleCate = "030551,030552,030553" 
	}else  if(cate == "030512"){	bundleCate = "030503,030504,030518"
	}else  if(cate == "030561"){	bundleCate = "030554,030555,030556,030557"
	}else  if(cate == "030515"){	bundleCate = "030516,030517"
	}else  if(cate == "221102"){	bundleCate = "221101,221121"
	}else  if(cate == "180308"){	bundleCate = "180301,180302,180313,180303,180312"
	}else  if(cate == "120712"){	bundleCate = "120703,120706,120704,120705"
	}else  if(cate == "052114"){	bundleCate = "052124,052101,052125,052117"
	}else  if(cate == "052126"){	bundleCate = "052105,052126"
	}else  if(cate == "052115"){	bundleCate = "052102,052112"
	}else  if(cate == "052116"){	bundleCate = "052110,052104"
	}else  if(cate == "070150"){	bundleCate = "070102,070103,070106,070109"
	}else  if(cate == "070151"){	bundleCate = "070120,070121,070122,070123,070119"
	}else  if(cate == "021423"){	bundleCate = "021405,021414,021404"
	}else  if(cate == "020314"){	bundleCate = "020309,020332,020315"
	}else  if(cate == "020323"){	bundleCate = "020321,020322"
	}else  if(cate == "036209"){	bundleCate = "036222,036223,036224"
	}else  if(cate == "036218"){	bundleCate = "036237,036238,036239,036240"
	}else  if(cate == "036236"){	bundleCate = "036233,036235"
	}else  if(cate == "061116"){	bundleCate = "061113,061114,061115" 
	}else  if(cate == "210316"){	bundleCate = "210302,210315"
	}else  if(cate == "240621"){	bundleCate = "240613,240620"
	}else  if(cate == "081211"){	bundleCate = "081202,081209"
	}else  if(cate == "081212"){	bundleCate = "081214,081202,081215"
	}else  if(cate == "163808"){	bundleCate = "163801,163812,163802"
	}else  if(cate == "163809"){	bundleCate = "163805,163813,163806"
	}else  if(cate == "022312"){	bundleCate = "022301,022302,022303"
	}else  if(cate == "092910"){	bundleCate = "092911,092912"
	}else  if(cate == "040140"){	bundleCate = "040113,040103,040107,040132"
	}else  if(cate == "040136"){	bundleCate = "040137,040138,040139"
	}else  if(cate == "090417"){	bundleCate = "090407,090408,090405"
	}else  if(cate == "181814"){	bundleCate = "181811,181812,181813"
	}else  if(cate == "975012"){	bundleCate = "975001,975002"
	}else  if(cate == "975013"){	bundleCate = "975007,975008,975009,975010,975011"
	}else  if(cate == "100920"){	bundleCate = "100918,100904,100927,100914,100913"
	}else  if(cate == "100921"){	bundleCate = "100919,100905,100925,100926"
	}else  if(cate == "060716"){	bundleCate = "060708,060709,060717" 
	}else  if(cate == "975020"){	bundleCate = "975005,975003,975018,975019" 
	}else  if(cate == "169317"){	bundleCate = "169315,169316"
	}else  if(cate == "169309"){	bundleCate = "169305,169301,169304"
	}else  if(cate == "169310"){	bundleCate = "169311,169312,169313,169314"
	}else  if(cate == "033510"){	bundleCate = "033501,033502,033503,033504,033505"
	}else  if(cate == "975211"){	bundleCate = "975201,975202"
	}else  if(cate == "975212"){	bundleCate = "975203,975204"
	}else  if(cate == "975213"){	bundleCate = "975205,975206"
	}else  if(cate == "975214"){	bundleCate = "975207,975208"
	}else  if(cate == "021428"){	bundleCate = "021405,021427"
	}else  if(cate == "975312"){	bundleCate = "975301,975302"
	}else  if(cate == "162614"){	bundleCate = "162610,162613"
	}else  if(cate == "080824"){	bundleCate = "080825,080826,080809"
	}else  if(cate == "093312"){	bundleCate = "093305,093313,093314"
	}else  if(cate == "222115"){	bundleCate = "222101,222102,222103"
	}else  if(cate == "222113"){	bundleCate = "222104,222105,222106"
	}else  if(cate == "222114"){	bundleCate = "222107,222108,222116,222110"
	}else  if(cate == "224311"){	bundleCate = "224301,224302,224303"
	}else  if(cate == "224312"){	bundleCate = "224304,224305,224306"
	}else  if(cate == "224313"){	bundleCate = "224307,224308,224309"
	}else  if(cate == "975313"){	bundleCate = "975308,975309,975310"
	}else  if(cate == "033712"){	bundleCate = "033701,033702,033705" 
	}else  if(cate == "210906"){	bundleCate = "210904,210912"
	}else  if(cate == "210928"){	bundleCate = "210907,210926"
	}else  if(cate == "210927"){	bundleCate = "210901,210923,210913"
	}else  if(cate == "240421"){	bundleCate = "240419,240420"
	}else  if(cate == "220810"){	bundleCate = "220802,024101,024103,024105,024112"
	}else  if(cate == "220814"){	bundleCate = "220808,024116,024113,024115"
	}else  if(cate == "024009"){	bundleCate = "024001,024002,024003"
	}else  if(cate == "024012"){	bundleCate = "024011,024010" 
	}else  if(cate == "033713"){	bundleCate = "033708,033709,033710"
	}else  if(cate == "033714"){	bundleCate = "033703,033704,033706,033707"
	}else  if(cate == "033812"){	bundleCate = "033801,033802,033805"
	}else  if(cate == "033813"){	bundleCate = "033808,033809,033810,033811"
	}else  if(cate == "150815"){	bundleCate = "150802,150809"
	}else  if(cate == "033814"){	bundleCate = "033803,033804,033806,033807"
	}else  if(cate == "033912"){	bundleCate = "033901,033902,033915"
	}else  if(cate == "033913"){	bundleCate = "033907,033908,033909,033910,033911"
	}else  if(cate == "033914"){	bundleCate = "033903,033904,033905"
	}else  if(cate == "034010"){	bundleCate = "034001,034002"
	}else  if(cate == "034011"){	bundleCate = "034007,034008,034009,034013"
	}else  if(cate == "034014"){	bundleCate = "034003,034004,034005"
	}else  if(cate == "034110"){	bundleCate = "034101,034102"
	}else  if(cate == "093810"){	bundleCate = "093805,093806"
	}else  if(cate == "034111"){	bundleCate = "034107,034108,034109,034112"
	}else  if(cate == "034113"){	bundleCate = "034103,034104,034105"
	}else  if(cate == "181219"){	bundleCate = "181213,181214,181215"
	}else  if(cate == "181220"){	bundleCate = "181216,181217,181218"
	}else  if(cate == "083109"){	bundleCate = "083102,083103,083104" 
	}else  if(cate == "083110"){	bundleCate = "083106,083107,083108" 
	}else  if(cate == "070219"){	bundleCate = "070213,070220" 
	}else  if(cate == "102312"){	bundleCate = "102301,102303,102308" 
	}else  if(cate == "102314"){	bundleCate = "102305,102310,102320,102309" 
	}else  if(cate == "120310"){	bundleCate = "120305,120306" 
	}else  if(cate == "034315"){	bundleCate = "034301,034302,034303" 
	}else  if(cate == "034313"){	bundleCate = "034304,034305,034306" 
	}else  if(cate == "034314"){	bundleCate = "034307,034308,034309,034310" 
	}else  if(cate == "020621"){	bundleCate = "020619,020620" 
	}else  if(cate == "081311"){	bundleCate = "081309,081302" 
	}else  if(cate == "051520"){	bundleCate = "051505,051502,051504,051501,051525" 
	}else  if(cate == "181314"){	bundleCate = "181312,181302" 
	}else  if(cate == "181316"){	bundleCate = "181301,181315" 
	}else  if(cate == "020138"){	bundleCate = "020139,020140,020141,020142,020143"
	}else  if(cate == "020136"){	bundleCate = "020146,020130,020137" 
	}else  if(cate == "020132"){	bundleCate = "020126,020125,020129" 
	}else  if(cate == "091231"){	bundleCate = "091229,091230" 
	}else  if(cate == "021918"){	bundleCate = "021908,021916" 
	}else  if(cate == "036232"){	bundleCate = "036228,036231" 
	}else  if(cate == "079011"){	bundleCate = "079001,079002,079003,079004,079005,079006" 
	}else  if(cate == "079012"){	bundleCate = "079007,079008,079009" 
	}else  if(cate == "083210"){	bundleCate = "083201,083202" 
	}else  if(cate == "083211"){	bundleCate = "083203,083204,083205" 
	}else  if(cate == "083212"){	bundleCate = "083206,083207,083208" 
	}else  if(cate == "034409"){	bundleCate = "034401,034402" 
	}else  if(cate == "034412"){	bundleCate = "034403,034404,034405" 
	}else  if(cate == "034410"){	bundleCate = "034406,034407,034408"  
	}else  if(cate == "150312"){	bundleCate = "150302,150310" 
	}else  if(cate == "150313"){	bundleCate = "150306,150311,150309" 
	}else  if(cate == "150210"){	bundleCate = "150202,150208" 
	}else  if(cate == "150211"){	bundleCate = "150203,150209" 
	}else  if(cate == "093011"){	bundleCate = "093002,093003,093004" 
	}else  if(cate == "100320"){	bundleCate = "100308,100307,100323,100324" 
	}else  if(cate == "181413"){	bundleCate = "181409,181402,181410,181407,181415"
	}else  if(cate == "100321"){	bundleCate = "100301,100310" 
	}else  if(cate == "100322"){	bundleCate = "100311,100312" 
	}else  if(cate == "060819"){	bundleCate = "060818,060803" 
	}else  if(cate == "060821"){	bundleCate = "060813,060820" 
	}else  if(cate == "062126"){	bundleCate = "062120,062119" 
	}else  if(cate == "062130"){	bundleCate = "062132,062133,062134,062135,062103" 
	}else  if(cate == "080124"){	bundleCate = "080120,080121,080122" 
	}else  if(cate == "083411"){	bundleCate = "083401,083402,083403" 
	}else  if(cate == "083412"){	bundleCate = "083405,083406,083407" 
	}else  if(cate == "083413"){	bundleCate = "083409,083410" 
	}else  if(cate == "150212"){	bundleCate = "150204,150207" 
	}else  if(cate == "041019"){	bundleCate = "041018,041005" 
	}else  if(cate == "087801"){	bundleCate = "087802,087803,087804,087805,087806,087807" 
	}else  if(cate == "087808"){	bundleCate = "087809,087810,087811,087812" 
	}else  if(cate == "040110"){	bundleCate = "040102,040106" 
	}else  if(cate == "040111"){	bundleCate = "040103,040107" 
	}else  if(cate == "034611"){	bundleCate = "034601,034602,034614"  
	}else  if(cate == "034612"){	bundleCate = "034603,034604,034605" 
	}else  if(cate == "034613"){	bundleCate = "034606,034607,034608,034609,034610" 
	}else  if(cate == "124102"){	bundleCate = "124103,124104,124105" 
	}else  if(cate == "124106"){	bundleCate = "124107,124108,124110" 
	}else  if(cate == "124111"){	bundleCate = "124112,124113,124114" 
	}else  if(cate == "061116"){	bundleCate = "061113,061115" 
	}else  if(cate == "040720"){	bundleCate = "040711,040719" 
	}else  if(cate == "181222"){	bundleCate = "181209,181221"
	}else  if(cate == "161315"){	bundleCate = "161314,161307" 
	}else  if(cate == "021901"){	bundleCate = "021902,021903,021904" 
	}else  if(cate == "021905"){	bundleCate = "021908,021909,021910" 
	}else  if(cate == "145514"){	bundleCate = "145510,145511,145512,145513" 
	}else  if(cate == "082610"){	bundleCate = "082609,082605" 
	}else  if(cate == "240519"){	bundleCate = "240508,240518" 
	}else  if(cate == "080419"){	bundleCate = "080404,080418,080422" 
	}else  if(cate == "034712"){	bundleCate = "034701,034702,034703" 
	}else  if(cate == "034713"){	bundleCate = "034706,034707,034704" 
	}else  if(cate == "034714"){	bundleCate = "034708,034709,034710,034711" 
	}else  if(cate == "042010"){	bundleCate = "042010,042001,042002,042003"
	}else  if(cate == "042011"){	bundleCate = "042006,042007,042008,042009" 
	}else  if(cate == "080914"){	bundleCate = "080917,080918"
	}else  if(cate == "900312"){	bundleCate = "900301,900308" 
	}else  if(cate == "035941"){	bundleCate = "035948,035953,035949,035937" 
	}else  if(cate == "036009"){	bundleCate = "036001,036002,036003" 
	}else  if(cate == "036010"){	bundleCate = "036018,036019,036005" 
	}else  if(cate == "023711"){	bundleCate = "023717,023718,023719,023720" 
	}else  if(cate == "023721"){	bundleCate = "023714,023715,023716" 
	}else  if(cate == "900313"){	bundleCate = "023714,023715,023716" 
	}else  if(cate == "101022"){	bundleCate = "101021,101014" 
	}else  if(cate == "900314"){	bundleCate = "900309,900310,900311" 
	}else  if(cate == "150113"){	bundleCate = "150116,150101" 
	}else  if(cate == "150117"){	bundleCate = "150105,150118" 
	}else  if(cate == "145495"){	bundleCate = "145403,145425" 
	}else  if(cate == "145496"){	bundleCate = "145401,145417,145415,145416" 
	}else  if(cate == "040135"){	bundleCate = "040114,040133"
	}else  if(cate == "210840"){	bundleCate = "210806,210841"
	}else  if(cate == "210843"){	bundleCate = "210830,210824,210809"
	}else  if(cate == "210844"){	bundleCate = "210810,210842"
	}else  if(cate == "145497"){	bundleCate = "145418,145402,145426,145422" 
	}else  if(cate == "101429"){	bundleCate = "101430,101431,101432" 
	}else  if(cate == "070911"){	bundleCate = "070903,070906,070901" 
	}else  if(cate == "070912"){	bundleCate = "070905,070902,070910,070904" 
	}else  if(cate == "034811"){	bundleCate = "034801,034802,034803" 
	}else  if(cate == "034812"){	bundleCate = "034804,034805,034806" 
	}else  if(cate == "034813"){	bundleCate = "034807,034808,034809,034810" 
	}else  if(cate == "040443"){	bundleCate = "040422,040442,040418,040419,040421,040427" 
	}else  if(cate == "022501"){	bundleCate = "022509,022512,022510,022511,022516,022513" 
	}else  if(cate == "080621"){	bundleCate = "080622,080624" 
	}else  if(cate == "080629"){	bundleCate = "080626,080627,080625" 
	}else  if(cate == "093712"){	bundleCate = "093701,093702,093703,093704,093705" 	
	}else  if(cate == "124411"){	bundleCate = "124401,124402,124403,124404,124405,124406" 	
	}else  if(cate == "124412"){	bundleCate = "124407,124408,124409" 	
	}else  if(cate == "124514"){	bundleCate = "124501,124502,124503,124504" 	
	}else  if(cate == "124515"){	bundleCate = "124505,124506,124507" 	
	}else  if(cate == "124516"){	bundleCate = "124508,124509" 	
	}else  if(cate == "124517"){	bundleCate = "124510,124511,124512" 	
	}else  if(cate == "101447"){	bundleCate = "101438,101439,101440,101441,101442" 	
	}else  if(cate == "101448"){	bundleCate = "101445,101446"
	}else  if(cate == "124705"){	bundleCate = "124701,124702,124703"
	}else  if(cate == "124709"){	bundleCate = "124717,124707"
	}else  if(cate == "124716"){	bundleCate = "124715,124710"
	}else  if(cate == "124713"){	bundleCate = "124711,124712"
	}else  if(cate == "124719"){	bundleCate = "124711,124712"
	}else  if(cate == "150919"){	bundleCate = "150901,150902,150907"
	}else  if(cate == "150920"){	bundleCate = "150909,150913,150912"
	}  
 
	return bundleCate; 
}

var oldShowCateId = null;
var oldShowCateClass = "";
var socialCateId = null;
function goCategory_Spread(cate,param_i,isgo){
	//var spread_line_bottom_colorList = document.getElementById("spread_color_cate_"+cate).value;
	//if(spread_line_bottom_colorList.indexOf(cate)>-1) {
	//	goCategory_Spread_pink(cate,param_i,isgo);
	//	return;
	//}
	cate_org = "";

	if (cate.length == 8 && cate.substring(6,8) == "00"){
		cate = cate.substring(0,6);
	}
	if(cate=="030434"){
		cate = "03043404";
	}
	if(cate=="030522"){
		cate = "03052201";
	}	
	if(cate == "101447"){
		return;
	}
	/*if(socialCateId != null){
		document.getElementById(socialCateId).parentElement.style.backgroundColor = "";
	}*/
	if(document.getElementById("spread"+cate)!=oldShowCateId) {
		if(oldShowCateId != null && oldShowCateId.parentElement) {
			oldShowCateId.parentElement.style.backgroundColor = "";
			if (oldShowCateClass != ""){ 
				oldShowCateId.className = oldShowCateClass;
			}	
		}
		oldShowCateId = document.getElementById("spread"+cate);
		if (oldShowCateId != null){
			oldShowCateClass = document.getElementById("spread"+cate).className;
		}else{
			oldShowCateClass = "";
		}
		
		if(cate.length==8) {
			if(oldShowCateId != null) oldShowCateId.parentElement.style.backgroundColor = "#EAD2DA";
		}
	}

	if(cate != "150908"){   
		var spread_log_cate = cate;
		if(cate.length > 4){  
			spread_log_cate = cate.substring(0,4);	
		}   
		insertLogCate(4658,spread_log_cate);

		spread_cate = cate; 

		if(spread_cate_org != "" && cate.length > 4){
			if(document.getElementById("Mspread"+spread_cate_org.substring(0,6)) != null ){
				/*if(cate.substring(0,4) == "1459" || cate.substring(0,3) == "147"){
					Cmd_Color_Spread_Group_1459(spread_cate_org.substring(0,6),'out');
				}else{*/
					Cmd_Color_Spread_Group(spread_cate_org.substring(0,6),'out');
				//}
			}
		}
			if(document.getElementById("Mspread"+spread_cate_org.substring(0,6)) != null ){
				document.getElementById("Mspread"+spread_cate_org.substring(0,6)).style.color = "#000000";
				//파랑으로 바꾸기 수정함 ju
				if(document.getElementById("nobundle_cate"+spread_cate_org.substring(0,6))) {document.getElementById("nobundle_cate"+spread_cate_org.substring(0,6)).style.backgroundColor = "#CBDEF2";}
				for(i=0; i<100; i++){
					if(document.getElementById("detail_c_"+spread_cate_org.substring(0,6)+"_"+i)) {
						document.getElementById("detail_c_"+spread_cate_org.substring(0,6)+"_"+i).style.borderColor = "#CBDEF2"; 
					}else{
						break;
					}
				}
				for(g=0; g<100; g++){
					if(document.getElementById("detail_d_"+spread_cate_org.substring(0,8)+"_"+g)) {
						document.getElementById("detail_d_"+spread_cate_org.substring(0,8)+"_"+g).style.borderColor = "#CBDEF2"; 
					}else{
						break;
					}
				}
				if(document.getElementById("group_span_blue1"+spread_cate_org.substring(0,6))) {document.getElementById("group_span_blue1"+spread_cate_org.substring(0,6)).style.backgroundColor = "#85AAD3";}
				if(document.getElementById("group_span_blue2"+spread_cate_org.substring(0,6))) {document.getElementById("group_span_blue2"+spread_cate_org.substring(0,6)).style.backgroundColor = "#85AAD3";}
				if(document.getElementById("group_span_blue3"+spread_cate_org.substring(0,6))) {document.getElementById("group_span_blue3"+spread_cate_org.substring(0,6)).style.backgroundColor = "#85AAD3";}
				if(document.getElementById("group_span_blue4"+spread_cate_org.substring(0,6))) {document.getElementById("group_span_blue4"+spread_cate_org.substring(0,6)).style.backgroundColor = "#85AAD3";}
			}
			if(spread_cate_bundle!=""){
				if(document.getElementById("Mspread"+cate.substring(0,6)) != null ){
					Cmd_Color_Spread_Bundle_Group(spread_cate_bundle,'', 'out');
				}
			}
			if(bundle.indexOf(spread_cate_org) > -1){
				if(document.getElementById("Mspread"+cate.substring(0,6)) != null && document.getElementById("Mspread"+spread_cate_org.substring(0,6)) != null ){
					Cmd_Color_Spread_Bundle_Group(spread_cate_org.substring(0,6),'', 'out');
				}
		}
		if(cate.length > 6){
			/*if(cate.substring(0,4) == "1459" || cate.substring(0,3) == "147"){
				Cmd_Color_Spread_1459(cate,"spread"+cate.substring(0,6),'on',param_i);
			}else{*/
				Cmd_Color_Spread(cate,"spread"+cate.substring(0,6),'on',param_i);
			//}
		}else{
			if(cate.length > 4){
				if(document.getElementById("Mspread"+cate.substring(0,6)) != null ){
					document.getElementById("Mspread"+cate).style.color = "#BD0F0E";
					//핑크로 바꾸기 수정함
					for(i=0; i<100; i++){
						if(document.getElementById("detail_c_"+cate.substring(0,6)+"_"+i)) {
							document.getElementById("detail_c_"+cate.substring(0,6)+"_"+i).style.borderColor = "#EAD2DA"; 
						}else{
							break;
						}
					}
					for(g=0; g<100; g++){
						if(document.getElementById("detail_d_"+cate.substring(0,8)+"_"+g)) {
							document.getElementById("detail_d_"+cate.substring(0,8)+"_"+g).style.borderColor = "#EAD2DA"; 
						}else{
							break;
						}
					}
					if(document.getElementById("nobundle_cate"+cate)) {document.getElementById("nobundle_cate"+cate).style.backgroundColor = "#EAD2DA";}
					if(document.getElementById("group_span_blue1"+cate)) {document.getElementById("group_span_blue1"+cate).style.backgroundColor = "#D9A5B7";}
					if(document.getElementById("group_span_blue2"+cate)) {document.getElementById("group_span_blue2"+cate).style.backgroundColor = "#D9A5B7";}
					if(document.getElementById("group_span_blue3"+cate)) {document.getElementById("group_span_blue3"+cate).style.backgroundColor = "#D9A5B7";}
					if(document.getElementById("group_span_blue4"+cate)) {document.getElementById("group_span_blue4"+cate).style.backgroundColor = "#D9A5B7";}
				}
			}else{
				if (spread_cate_org != ""){
					if(document.getElementById("Mspread"+cate.substring(0,6)) != null ){
						document.getElementById("Mspread"+spread_cate_org.substring(0,6)).style.color = "#000000";
					}
				}
			}
		}
		if(bundle.indexOf(cate) > -1){
			if(document.getElementById("Mspread"+cate.substring(0,6)) != null ){
				Cmd_Color_Spread_Bundle_Group(cate,'', 'over');
			}
		}
		if (cate.length == 8){
			if (cate.substring(6,8) == "00"){
				cate = cate.substring(0,6);
			}
		}
		//
		if(!goJumpCategory(cate)){
			
			if (typeof(isgo) == "undefined" && cate != "150908"){
				/*if(cate.substring(0,2) == "14"){
					if(cate.substring(0,4) == "1459"){
						document.getElementById("enuriListFrame").src = "/view/Listbody_Fusion_Masterpiece.jsp?cate="+cate;
					}else if(cate.substring(0,3) == "147"){
						document.getElementById("enuriListFrame").src = "/fashion/clothes/include/Listbody_Style.jsp?cate="+cate;
					}else if(cate.substring(0,3) == "145"){
						document.getElementById("enuriListFrame").src = "/view/Listbody_Fusion.jsp?cate="+cate;
					}else{
						document.getElementById("enuriListFrame").src = "/view/Listbody_Fusion.jsp?cate="+cate;
					}
				}else if(cate.substring(0,2) == "87"){
					if(cate == "87010102" || cate == "87010103" || cate == "87010104") {
						document.getElementById("enuriListFrame").src = "/view/Listbody_Social_2013.jsp?cate=87010101&order_type=all";
					}else{
						document.getElementById("enuriListFrame").src = "/view/Listbody_Social_2013.jsp?cate="+cate+"&order_type=all"; 
					}
				}else{*/
					if(cate == "04020701" || cate == "040207" ||  cate == "04020702" || cate == "04020703" || cate == "04020704" || cate == "04020705" || cate == "04020707" || cate == "04020708" || cate == "04020709"){
						document.getElementById("enuriListFrame").src = "/view/Listbody_Printer.jsp?cate="+cate;
					}else{
						document.getElementById("enuriListFrame").src = "/view/Listbody_Mp3.jsp?cate="+cate;
					}
				//}
			}else if (typeof(isgo) == "string"){
				if( isgo == 's' && cate.substring(0,4) == "1647"){
					document.getElementById("enuriListFrame").src = "/view/Listbody_Social.jsp?cate="+cate; 
				}			
			}
		}
		if(cate.length == 4){
			spread_cate_org = "";
		}else{
			spread_cate_org = spread_cate;
		}
	}

	if(cate.length==6) {
		var ObjSpread = new Array();
		var ObjSpreadAll = document.getElementById("spread_div").getElementsByTagName("DIV");
		for (var i=0;i<ObjSpreadAll.length;i++){
			if (ObjSpreadAll[i].id.indexOf("spread"+cate) >= 0 ){
				ObjSpread[ObjSpread.length] = ObjSpreadAll[i];
			}
		}

		if(document.getElementById("spread_color_cate_"+cate)) {
			var spread_line_bottom_colorList = document.getElementById("spread_color_cate_"+cate).value;

			for (var i=0;i<ObjSpreadAll.length;i++){
				var tempSpreadCate = ObjSpreadAll[i].id;
				tempSpreadCate = tempSpreadCate.split("spread").join("");
				
				if(tempSpreadCate.length>6 &&spread_line_bottom_colorList.indexOf(tempSpreadCate)>-1) {
					try {
						document.getElementById("spread"+tempSpreadCate).parentNode.parentNode.style.borderBottom = "1px solid #f7bed1";
					} catch(e) {}
				}
			}
			
		}
	}

	if(cate.length==8) {
		var spread_line_bottom_colorList = ""
		if(document.getElementById("spread_color_cate_"+cate)){
			spread_line_bottom_colorList = document.getElementById("spread_color_cate_"+cate.substring(0,6)).value;
		}
		if(cate.length>6 &&spread_line_bottom_colorList.indexOf(cate)>-1) {
			//document.getElementById("spread"+cate).parentNode.parentNode.style.borderBottom = "1px solid #f7bed1";
		}
	}
}

function printer_go(cate) {	
	document.getElementById("enuriListFrame").src = "/view/Listbody_Printer.jsp?cate="+cate;
}

var oldShowCateId1 = null; 
function goCategory_Spread1(cate,param_i,isgo){
	if (cate.length == 8 && cate.substring(6,8) == "00"){
		cate = cate.substring(0,6);
	}
	if(cate=="030434"){
		cate = "03043404";
	}
	if(cate=="030522"){
		cate = "03052201";
	}	
	if(document.getElementById("spread"+cate)!=oldShowCateId1) {
		if(oldShowCateId1 != null && oldShowCateId1.parentElement) {
			oldShowCateId1.parentElement.style.backgroundColor = "";
		}
		oldShowCateId1 = document.getElementById("spread"+cate);
		if(cate.length==8) {
			if(oldShowCateId1 != null) oldShowCateId1.parentElement.style.backgroundColor = "#EAD2DA";
		}
	}
	if(cate != "150908"){   
		var spread_log_cate = cate;
		if(cate.length > 4){ 
			spread_log_cate = cate.substring(0,4);	
		}
		insertLogCate(4658,spread_log_cate);

		spread_cate = cate; 

		if(spread_cate_org != "" && cate.length > 4){
			if(document.getElementById("Mspread"+spread_cate_org.substring(0,6)) != null ){
				/*if(cate.substring(0,4) == "1459" || cate.substring(0,3) == "147"){
					Cmd_Color_Spread_Group_1459(spread_cate_org.substring(0,6),'out');
				}else{*/
					Cmd_Color_Spread_Group(spread_cate_org.substring(0,6),'out');
				//}
			}
		}
			if(document.getElementById("Mspread"+spread_cate_org.substring(0,6)) != null ){
				document.getElementById("Mspread"+spread_cate_org.substring(0,6)).style.color = "#000000";
				//파랑으로 바꾸기 수정함 ju
				if(document.getElementById("nobundle_cate"+spread_cate_org.substring(0,6))) {document.getElementById("nobundle_cate"+spread_cate_org.substring(0,6)).style.backgroundColor = "#CBDEF2";}
				for(i=0; i<100; i++){
					if(document.getElementById("detail_c_"+spread_cate_org.substring(0,6)+"_"+i)) {
						document.getElementById("detail_c_"+spread_cate_org.substring(0,6)+"_"+i).style.borderColor = "#CBDEF2"; 
					}else{
						break;
					}
				}
				for(g=0; g<100; g++){
					if(document.getElementById("detail_d_"+spread_cate_org.substring(0,8)+"_"+g)) {
						document.getElementById("detail_d_"+spread_cate_org.substring(0,8)+"_"+g).style.borderColor = "#CBDEF2"; 
					}else{
						break;
					}
				}
				if(document.getElementById("group_span_blue1"+spread_cate_org.substring(0,6))) {document.getElementById("group_span_blue1"+spread_cate_org.substring(0,6)).style.backgroundColor = "#85AAD3";}
				if(document.getElementById("group_span_blue2"+spread_cate_org.substring(0,6))) {document.getElementById("group_span_blue2"+spread_cate_org.substring(0,6)).style.backgroundColor = "#85AAD3";}
				if(document.getElementById("group_span_blue3"+spread_cate_org.substring(0,6))) {document.getElementById("group_span_blue3"+spread_cate_org.substring(0,6)).style.backgroundColor = "#85AAD3";}
				if(document.getElementById("group_span_blue4"+spread_cate_org.substring(0,6))) {document.getElementById("group_span_blue4"+spread_cate_org.substring(0,6)).style.backgroundColor = "#85AAD3";}
			}
			if(spread_cate_bundle!=""){
				if(document.getElementById("Mspread"+cate.substring(0,6)) != null ){
					Cmd_Color_Spread_Bundle_Group(spread_cate_bundle,'', 'out');
				}
			}
			if(bundle.indexOf(spread_cate_org) > -1){
				if(document.getElementById("Mspread"+cate.substring(0,6)) != null && document.getElementById("Mspread"+spread_cate_org.substring(0,6)) != null ){
					Cmd_Color_Spread_Bundle_Group(spread_cate_org.substring(0,6),'', 'out');
				}
		}
		if(cate.length > 6){
			/*if(cate.substring(0,4) == "1459" || cate.substring(0,3) == "147"){
				Cmd_Color_Spread_1459(cate,"spread"+cate.substring(0,6),'on',param_i);
			}else{*/
				Cmd_Color_Spread(cate,"spread"+cate.substring(0,6),'on',param_i);
			//}
		}else{
			if(cate.length > 4){
				if(document.getElementById("Mspread"+cate.substring(0,6)) != null ){
					document.getElementById("Mspread"+cate).style.color = "#BD0F0E";
					//핑크로 바꾸기 수정함
					for(i=0; i<100; i++){
						if(document.getElementById("detail_c_"+cate.substring(0,6)+"_"+i)) {
							document.getElementById("detail_c_"+cate.substring(0,6)+"_"+i).style.borderColor = "#EAD2DA"; 
						}else{
							break;
						}
					}
					for(g=0; g<100; g++){
						if(document.getElementById("detail_d_"+cate.substring(0,8)+"_"+g)) {
							document.getElementById("detail_d_"+cate.substring(0,8)+"_"+g).style.borderColor = "#EAD2DA"; 
						}else{
							break;
						}
					}
					if(document.getElementById("nobundle_cate"+cate)) {document.getElementById("nobundle_cate"+cate).style.backgroundColor = "#EAD2DA";}
					if(document.getElementById("group_span_blue1"+cate)) {document.getElementById("group_span_blue1"+cate).style.backgroundColor = "#D9A5B7";}
					if(document.getElementById("group_span_blue2"+cate)) {document.getElementById("group_span_blue2"+cate).style.backgroundColor = "#D9A5B7";}
					if(document.getElementById("group_span_blue3"+cate)) {document.getElementById("group_span_blue3"+cate).style.backgroundColor = "#D9A5B7";}
					if(document.getElementById("group_span_blue4"+cate)) {document.getElementById("group_span_blue4"+cate).style.backgroundColor = "#D9A5B7";}
				}
			}else{
				if (spread_cate_org != ""){
					if(document.getElementById("Mspread"+cate.substring(0,6)) != null ){
						document.getElementById("Mspread"+spread_cate_org.substring(0,6)).style.color = "#000000";
					}
				}
			}
		}
		if(bundle.indexOf(cate) > -1){
			if(document.getElementById("Mspread"+cate.substring(0,6)) != null ){
				Cmd_Color_Spread_Bundle_Group(cate,'', 'over');
			}
		}
		if (cate.length == 8){
			if (cate.substring(6,8) == "00"){
				cate = cate.substring(0,6);
			}
		}
		
		if(cate.length == 4){
			spread_cate_org = "";
		}else{
			spread_cate_org = spread_cate;
		}
	}
}

function goCategory_Spread_1459(cate,param_i,isgo){
	if (cate.length == 8 && cate.substring(6,8) == "00"){
		cate = cate.substring(0,6);
	}
	if(cate=="030434"){
		cate = "03043404";
	}
	if(cate=="030522"){
		cate = "03052201";
	}	
	/*if(socialCateId != null){
		document.getElementById(socialCateId).parentElement.style.backgroundColor = "";
	}*/
	if(document.getElementById("spread"+cate)!=oldShowCateId) {
		if(oldShowCateId != null && oldShowCateId.parentElement) {
			oldShowCateId.parentElement.style.backgroundColor = "";
			if (oldShowCateClass != ""){ 
				oldShowCateId.className = oldShowCateClass;
			}	
		}
		oldShowCateId = document.getElementById("spread"+cate);
		if (oldShowCateId != null){
			oldShowCateClass = document.getElementById("spread"+cate).className;
		}else{
			oldShowCateClass = "";
		}
		
		if(cate.length==8) {
			if(oldShowCateId != null) oldShowCateId.parentElement.style.backgroundColor = "#EAD2DA";
		}
	}
	if(cate != "150908"){   
		var spread_log_cate = cate;
		if(cate.length > 4){ 
			spread_log_cate = cate.substring(0,4);	
		}
		insertLogCate(4658,spread_log_cate);

		spread_cate = cate; 

		if(spread_cate_org != "" && cate.length > 4){
			if(document.getElementById("Mspread"+spread_cate_org.substring(0,6)) != null ){
				Cmd_Color_Spread_Group_1459(spread_cate_org.substring(0,6),'out');
			}
		}
			if(document.getElementById("Mspread"+spread_cate_org.substring(0,6)) != null ){
				document.getElementById("Mspread"+spread_cate_org.substring(0,6)).style.color = "#000000";
				//파랑으로 바꾸기 수정함 ju
				if(document.getElementById("nobundle_cate"+spread_cate_org.substring(0,6))) {document.getElementById("nobundle_cate"+spread_cate_org.substring(0,6)).style.backgroundColor = "#CBDEF2";}
				for(i=0; i<100; i++){
					if(document.getElementById("detail_c_"+spread_cate_org.substring(0,6)+"_"+i)) {
						document.getElementById("detail_c_"+spread_cate_org.substring(0,6)+"_"+i).style.borderColor = "#CBDEF2"; 
					}else{
						break;
					}
				}
				for(g=0; g<100; g++){
					if(document.getElementById("detail_d_"+spread_cate_org.substring(0,8)+"_"+g)) {
						document.getElementById("detail_d_"+spread_cate_org.substring(0,8)+"_"+g).style.borderColor = "#CBDEF2"; 
					}else{
						break;
					}
				}
				if(document.getElementById("group_span_blue1"+spread_cate_org.substring(0,6))) {document.getElementById("group_span_blue1"+spread_cate_org.substring(0,6)).style.backgroundColor = "#85AAD3";}
				if(document.getElementById("group_span_blue2"+spread_cate_org.substring(0,6))) {document.getElementById("group_span_blue2"+spread_cate_org.substring(0,6)).style.backgroundColor = "#85AAD3";}
				if(document.getElementById("group_span_blue3"+spread_cate_org.substring(0,6))) {document.getElementById("group_span_blue3"+spread_cate_org.substring(0,6)).style.backgroundColor = "#85AAD3";}
				if(document.getElementById("group_span_blue4"+spread_cate_org.substring(0,6))) {document.getElementById("group_span_blue4"+spread_cate_org.substring(0,6)).style.backgroundColor = "#85AAD3";}
			}
			if(spread_cate_bundle!=""){
				if(document.getElementById("Mspread"+cate.substring(0,6)) != null ){
					Cmd_Color_Spread_Bundle_Group(spread_cate_bundle,'', 'out');
				}
			}
			if(bundle.indexOf(spread_cate_org) > -1){
				if(document.getElementById("Mspread"+cate.substring(0,6)) != null && document.getElementById("Mspread"+spread_cate_org.substring(0,6)) != null ){
					Cmd_Color_Spread_Bundle_Group(spread_cate_org.substring(0,6),'', 'out');
				}
		}
		if(cate.length > 6){
			/*if(cate.substring(0,4) == "1459" || cate.substring(0,3) == "147"){
				Cmd_Color_Spread_1459(cate,"spread"+cate.substring(0,6),'on',param_i);
			}else{*/
				Cmd_Color_Spread(cate,"spread"+cate.substring(0,6),'on',param_i);
			//}
		}else{
			if(cate.length > 4){
				if(document.getElementById("Mspread"+cate.substring(0,6)) != null ){
					document.getElementById("Mspread"+cate).style.color = "#BD0F0E";
					//핑크로 바꾸기 수정함
					for(i=0; i<100; i++){
						if(document.getElementById("detail_c_"+cate.substring(0,6)+"_"+i)) {
							document.getElementById("detail_c_"+cate.substring(0,6)+"_"+i).style.borderColor = "#EAD2DA"; 
						}else{
							break;
						}
					}
					for(g=0; g<100; g++){
						if(document.getElementById("detail_d_"+cate.substring(0,8)+"_"+g)) {
							document.getElementById("detail_d_"+cate.substring(0,8)+"_"+g).style.borderColor = "#EAD2DA"; 
						}else{
							break;
						}
					}
					if(document.getElementById("nobundle_cate"+cate)) {document.getElementById("nobundle_cate"+cate).style.backgroundColor = "#EAD2DA";}
					if(document.getElementById("group_span_blue1"+cate)) {document.getElementById("group_span_blue1"+cate).style.backgroundColor = "#D9A5B7";}
					if(document.getElementById("group_span_blue2"+cate)) {document.getElementById("group_span_blue2"+cate).style.backgroundColor = "#D9A5B7";}
					if(document.getElementById("group_span_blue3"+cate)) {document.getElementById("group_span_blue3"+cate).style.backgroundColor = "#D9A5B7";}
					if(document.getElementById("group_span_blue4"+cate)) {document.getElementById("group_span_blue4"+cate).style.backgroundColor = "#D9A5B7";}
				}
			}else{
				if (spread_cate_org != ""){
					if(document.getElementById("Mspread"+cate.substring(0,6)) != null ){
						document.getElementById("Mspread"+spread_cate_org.substring(0,6)).style.color = "#000000";
					}
				}
			}
		}
		if(bundle.indexOf(cate) > -1){
			if(document.getElementById("Mspread"+cate.substring(0,6)) != null ){
				Cmd_Color_Spread_Bundle_Group(cate,'', 'over');
			}
		}
		if (cate.length == 8){
			if (cate.substring(6,8) == "00"){
				cate = cate.substring(0,6);
			}
		}
		if(!goJumpCategory(cate)){
			if (typeof(isgo) == "undefined" && cate != "150908"){
				/*if(cate.substring(0,2) == "14"){
					if(cate.substring(0,4) == "1459"){
						document.getElementById("enuriListFrame").src = "/view/Listbody_Fusion_Masterpiece.jsp?cate="+cate;
					}else if(cate.substring(0,3) == "147"){
						document.getElementById("enuriListFrame").src = "/fashion/clothes/include/Listbody_Style.jsp?cate="+cate;
					}else if(cate.substring(0,3) == "145"){
						document.getElementById("enuriListFrame").src = "/view/Listbody_Fusion.jsp?cate="+cate;
					}else{
						document.getElementById("enuriListFrame").src = "/view/Listbody_Fusion.jsp?cate="+cate;
					}else{
						document.getElementById("enuriListFrame").src = "/view/Listbody_Mp3.jsp?cate="+cate;
					}
				}else if(cate.substring(0,2) == "87"){
					if(cate == "87010102" || cate == "87010103" || cate == "87010104") {
						document.getElementById("enuriListFrame").src = "/view/Listbody_Social_2013.jsp?cate=87010101&order_type=all";
					}else{
						document.getElementById("enuriListFrame").src = "/view/Listbody_Social_2013.jsp?cate="+cate+"&order_type=all"; 
					}
				}else{*/
					document.getElementById("enuriListFrame").src = "/view/Listbody_Mp3.jsp?cate="+cate;
				//}
			}else if (typeof(isgo) == "string"){
				if( isgo == 's' && cate.substring(0,4) == "1647"){
					document.getElementById("enuriListFrame").src = "/view/Listbody_Social.jsp?cate="+cate; 
				}			
			}
		}
		if(cate.length == 4){
			spread_cate_org = "";
		}else{
			spread_cate_org = spread_cate;
		}
	}
}


function Cmd_Color_Spread_Group_1459(param_cate, param_gubun){
	//curStyle = param_cate;
	//var ObjSpread = document.getElementsByName("spread"+param_cate);
	var ObjSpread = new Array();
	var ObjSpreadAll = document.getElementById("spread_div").getElementsByTagName("DIV");
	for (var i=0;i<ObjSpreadAll.length;i++){
		if (ObjSpreadAll[i].id.indexOf("spread"+param_cate) >= 0 ){
			ObjSpread[ObjSpread.length] = ObjSpreadAll[i];
		}
	}
	
	var ObjClass;
	
	var cate = param_cate;
	if(cate=="030434"){
		cate = "03043404";
	}
	if(cate=="030522"){
		cate = "03052201";
	}
	if(cate=="145514"){
		cate = "145514";
	}
	if(cate=="145414"){
		cate = "145414";
	}
//	showLog("param_cate="+param_cate + param_gubun);
	//if(ObjSpread.length < 1){
	//ju
	//alert("param_cate="+param_cate);
	if(param_cate!="150908"){
		if(param_gubun == "over"){
			Cmd_Color_Spread_Group._varPrevColor = document.getElementById("Mspread"+param_cate).style.color;
			document.getElementById("Mspread"+param_cate).style.color = "#BD0F0E";
			if(document.getElementById("nobundle_cate"+param_cate)) {
				document.getElementById("nobundle_cate"+param_cate).style.backgroundColor = "#EAD2DA";
				if(param_cate.substring(0,2) == "87"){
					document.getElementById("nobundle_cate"+cate).style.borderTop = "1px solid #D9A5B7";
				}
			}
			for(i=0; i<100; i++){
				if(document.getElementById("detail_c_"+param_cate.substring(0,6)+"_"+i)) {
					document.getElementById("detail_c_"+param_cate.substring(0,6)+"_"+i).style.borderColor = "#EAD2DA"; 
				}else{
					break;
				}
			}
			for(g=0; g<100; g++){
				if(document.getElementById("detail_d_"+param_cate.substring(0,8)+"_"+g)) {
					document.getElementById("detail_d_"+param_cate.substring(0,8)+"_"+g).style.borderColor = "#EAD2DA"; 
				}else{
					break;
				}
			}
			
			if(document.getElementById("group_span_blue1"+param_cate)) {document.getElementById("group_span_blue1"+param_cate).style.backgroundColor = "#D9A5B7";}
			if(document.getElementById("group_span_blue2"+param_cate)) {document.getElementById("group_span_blue2"+param_cate).style.backgroundColor = "#D9A5B7";}
			if(document.getElementById("group_span_blue3"+param_cate)) {document.getElementById("group_span_blue3"+param_cate).style.backgroundColor = "#D9A5B7";}
			if(document.getElementById("group_span_blue4"+param_cate)) {document.getElementById("group_span_blue4"+param_cate).style.backgroundColor = "#D9A5B7";}

		}else{ 
			if(spread_cate =="030434" || spread_cate =="030522"){
				
				document.getElementById("Mspread"+param_cate).style.color = "#000000";
				if(document.getElementById("nobundle_cate"+param_cate)) {
					document.getElementById("nobundle_cate"+param_cate).style.backgroundColor = "#CBDEF2";
				}
				for(i=0; i<100; i++){
					if(document.getElementById("detail_c_"+param_cate.substring(0,6)+"_"+i)) {
						document.getElementById("detail_c_"+param_cate.substring(0,6)+"_"+i).style.borderColor = "#CBDEF2"; 
					}else{
						break;
					}
				}    
				for(g=0; g<100; g++){
					if(document.getElementById("detail_d_"+param_cate.substring(0,8)+"_"+g)) {
						document.getElementById("detail_d_"+param_cate.substring(0,8)+"_"+g).style.borderColor = "#CBDEF2"; 
					}else{
						break;
					}
				}
				if(document.getElementById("group_span_blue1"+param_cate)) {document.getElementById("group_span_blue1"+param_cate).style.backgroundColor = "#85AAD3";}
				if(document.getElementById("group_span_blue2"+param_cate)) {document.getElementById("group_span_blue2"+param_cate).style.backgroundColor = "#85AAD3";}
				if(document.getElementById("group_span_blue3"+param_cate)) {document.getElementById("group_span_blue3"+param_cate).style.backgroundColor = "#85AAD3";}
				if(document.getElementById("group_span_blue4"+param_cate)) {document.getElementById("group_span_blue4"+param_cate).style.backgroundColor = "#85AAD3";}
			}else{
				if(spread_cate == param_cate || getBundleCateList(spread_cate).indexOf(param_cate)>-1 || Cmd_Color_Spread_Group._varPrevColor == "#BD0F0E"){
				//alert("spread_cate="+spread_cate);
					
				}else{
					
					document.getElementById("Mspread"+param_cate).style.color = "#000000";
					if(document.getElementById("nobundle_cate"+param_cate)) {
						document.getElementById("nobundle_cate"+param_cate).style.backgroundColor = "#CBDEF2";
						if(param_cate.substring(0,2) == "87"){
							document.getElementById("nobundle_cate"+cate).style.borderTop = "1px solid #85AAD3";
						}
					}
					
					for(i=0; i<100; i++){
						if(document.getElementById("detail_c_"+param_cate.substring(0,6)+"_"+i)) {
							document.getElementById("detail_c_"+param_cate.substring(0,6)+"_"+i).style.borderColor = "#CBDEF2"; 
						}else{
							break;
						}
					}    
					for(g=0; g<100; g++){
						if(document.getElementById("detail_d_"+param_cate.substring(0,8)+"_"+g)) {
							document.getElementById("detail_d_"+param_cate.substring(0,8)+"_"+g).style.borderColor = "#CBDEF2"; 
						}else{
							break;
						}
					}
					if(document.getElementById("group_span_blue1"+param_cate)) {document.getElementById("group_span_blue1"+param_cate).style.backgroundColor = "#85AAD3";}
					if(document.getElementById("group_span_blue2"+param_cate)) {document.getElementById("group_span_blue2"+param_cate).style.backgroundColor = "#85AAD3";}
					if(document.getElementById("group_span_blue3"+param_cate)) {document.getElementById("group_span_blue3"+param_cate).style.backgroundColor = "#85AAD3";}
					if(document.getElementById("group_span_blue4"+param_cate)) {document.getElementById("group_span_blue4"+param_cate).style.backgroundColor = "#85AAD3";}
				}
			}	
		}
	}
	//}
	//찾았당
	for(var i=0; i < ObjSpread.length; i++) {
		if("spread"+spread_cate == ObjSpread[i].id || "Mspread"+spread_cate == ObjSpread[i].id ){

		}else{
			if(param_gubun == "over"){
				if(param_cate!="150908" && param_cate.substring(0,2) != "87" && param_cate.legth<6){
					if(ObjSpread[i].className == "sml_n1"){
						ObjSpread[i].className = "sml_n3";
					}else if(ObjSpread[i].className == "sml_n2"){
						ObjSpread[i].className = "sml_n4";
					}/*else if(ObjSpread[i].className == "sml_n_ex1"){
						ObjSpread[i].className = "sml_n_ex3";
					}*/
				}else if(param_cate.substring(0,2) == "87" && param_cate.legth>6){
					if(ObjSpread[0].className == "sml_n1"){
						ObjSpread[0].className = "sml_n3";
					}else if(ObjSpread[0].className == "sml_n2"){
						ObjSpread[0].className = "sml_n4";
					}
				}
			}else{
				if((spread_cate=="030434" && ObjSpread[i].id=="spread03043404") || (spread_cate=="030522" && ObjSpread[i].id=="spread03052201")) {
					//if(document.getElementById("spread03043404")) {document.getElementById("spread03043404").style.backgroundColor = "#EAD2DA";}
					ObjSpread[0].className = "sml_n0";
					ObjSpread[1].className = "sml_nA";
					ObjSpread[0].parentElement.style.backgroundColor = "#EAD2DA";
				} else {
					if(ObjSpread[i].className == "sml_n3"){
						ObjSpread[i].className = "sml_n1";
					}else if(ObjSpread[i].className == "sml_n4"){
						ObjSpread[i].className = "sml_n2";
					}else if(ObjSpread[i].className == "sml_n_ex3"){
						ObjSpread[i].className = "sml_n_ex1";
					}
					/*
					if(ObjSpread[i].id=="spread03043404" || ObjSpread[i].id=="spread03052201") {
						ObjSpread[0].className = "sml_n1";
						ObjSpread[1].className = "sml_n1";
						ObjSpread[0].parentElement.style.backgroundColor = "#F9F9F9";
					}
					*/
				}
			}
		}
	}
}

function Cmd_Color_Spread(param_cate,param,param_gubun,paramClass){
	
	/*
	var ObjSpread = document.getElementsByName(param);
	var thisObj = document.getElementById("spread"+param_cate);
	if(ObjSpread.length>0){ //크롬,파폭등에서 getElementsByName 으로 개체를 못찾음
		for(var i=0; i < ObjSpread.length; i++) {
			ObjSpread[i].className == "sml_n1";
			if("spread"+spread_cate == ObjSpread[i].id){
				if(ObjSpread[i].className == "sml_n1"){
					ObjSpread[i].className = "sml_n3";
					if(oldShowCateId ==null) {
						thisObj.parentElement.style.backgroundColor = "#EAD2DA";
					}
				}else if(ObjSpread[i].className == "sml_n2"){
					ObjSpread[i].className = "sml_n4";
					if(oldShowCateId ==null) {
						thisObj.parentElement.style.backgroundColor = "#EAD2DA";
					}
				}
			}else{
			//ju0703
				if(paramClass == i ){
					if(param_gubun == "on" && paramClass != ""){
						if(ObjSpread[i].className == "sml_n1"){
						if(oldShowCateId ==null) {
							thisObj.parentElement.style.backgroundColor = "#EAD2DA";
						}
							ObjSpread[i].className = "sml_n3";
						}else if(ObjSpread[i].className == "sml_n2"){
							ObjSpread[i].className = "sml_n4";
							if(oldShowCateId ==null) {
								thisObj.parentElement.style.backgroundColor = "#EAD2DA"; 
							}
						}
					}else{
						if(ObjSpread[i].className == "sml_n4"){
							thisObj.parentElement.style.backgroundColor = "#F9F9F9";
							ObjSpread[i].className = "sml_n2";
						}else if(ObjSpread[i].className == "sml_n3"){
							ObjSpread[i].className = "sml_n1";
							 thisObj.parentElement.style.backgroundColor = "#F9F9F9";
						}			
					}
				}
			}
		}
	}else{
		if (thisObj){
			if(param_gubun == "on"){
	  			thisObj.parentElement.style.backgroundColor = "#EAD2DA";
			}else if(param_gubun == "out"){
	 			if(document.getElementById("spread"+param_cate)!=oldShowCateId) {
					thisObj.parentElement.style.backgroundColor = "#F9F9F9";
					if(param_gubun == "on"){
	  					thisObj.parentElement.style.backgroundColor = "#EAD2DA";
					}
				}
			}
		}
	}
	if(param_cate == "03042601"){ 
		//Cmd_Color_Spread2(param_gubun, "03042602,03042603,03042604");
	}
	*/
	
	var spread_line_bottom_colorList = ""
	if(document.getElementById("spread_color_cate_"+param_cate)){
		spread_line_bottom_colorList = document.getElementById("spread_color_cate_"+param_cate.substring(0,6)).value;
	}
	var thisObj = document.getElementById("spread"+param_cate);
	if (thisObj){
		if(param_gubun == "on"){
			if(thisObj.className == "sml_n1"){
				thisObj.className = "sml_n3";
			}else if(thisObj.className == "sml_n2"){
				thisObj.className = "sml_n4";
			}			
			if(oldShowCateId == null && oldShowCate2Id == null) {
				if (thisObj.className != "sml_n_ex1"){
					thisObj.parentElement.style.backgroundColor = "#EAD2DA";
					
				}
				if(param_cate.length>6 &&spread_line_bottom_colorList.indexOf(param_cate)>-1) {
					//document.getElementById("spread"+param_cate).parentNode.parentNode.style.borderBottom = "1px solid #f7bed1";
				}
			}
  		}else if(param_gubun == "out"){
			 
			if(document.getElementById("spread"+param_cate)!=oldShowCateId && document.getElementById("spread"+param_cate)!=oldShowCate2Id) {
				if(thisObj.className == "sml_n3"){
					thisObj.className = "sml_n1";
					if(param_cate.length>6 &&spread_line_bottom_colorList.indexOf(param_cate)>-1) {
						//document.getElementById("spread"+param_cate).parentNode.parentNode.style.borderBottom = "1px solid black";
					}
				}else if(thisObj.className == "sml_n4"){
					thisObj.className = "sml_n2";
					if(param_cate.length>6 &&spread_line_bottom_colorList.indexOf(param_cate)>-1) {
						//document.getElementById("spread"+param_cate).parentNode.parentNode.style.borderBottom = "1px solid red";
					}
				}			
				if (thisObj.className != "sml_n_ex1"){
					thisObj.parentElement.style.backgroundColor = "#F9F9F9";
					if(param_cate.length>6 &&spread_line_bottom_colorList.indexOf(param_cate)>-1) {
						document.getElementById("spread"+param_cate).parentNode.parentNode.style.borderBottom = "1px solid #afd6ff";
					}
				}
			}

			var spread_line_bottom_colorList = document.getElementById("spread_color_cate_"+param_cate.substring(0, 6)).value;
			if(spread_line_bottom_colorList.indexOf(param_cate)>-1) {
				var spreadFindFlag = false;
				/*
				var objGNames = document.getElementsByName("Mspreads"+spread_cate);
				if(objGNames!=null && objGNames.length>0) {
					for(var i=0; i < objGNames.length; i++) {
						var tempSpread_cate = objGNames[i].id;
						tempSpread_cate = tempSpread_cate.split("Mspread").join("spread");

						var objNames = document.getElementsByName(tempSpread_cate);
						if(objNames!=null) {
							for(var j=0; j < objNames.length; j++) {
								if(objNames[j].id=="spread"+param_cate) {
									spreadFindFlag = true;
									break;
								}
							}
						}
					}
				} else {
					var objNames = document.getElementsByName("spread"+spread_cate);
					if(objNames!=null) {
						for(var j=0; j < objNames.length; j++) {
							if(objNames[j].id=="spread"+param_cate) {
								spreadFindFlag = true;
								break;
							}
						}
					}
				}

				if(spreadFindFlag){   
					document.getElementById("spread"+param_cate).parentNode.parentNode.style.borderBottom = "1px solid #f7bed1";
				}
				*/

				var ObjSpreadAll = document.getElementById("spread_div").getElementsByTagName("TD");
				var ObjSpreadTitle = new Array();
				var titleCnt = 0;
				for (var i=0;i<ObjSpreadAll.length;i++){
					if (ObjSpreadAll[i].id.indexOf("titleCate_"+spread_cate) >= 0 ){
						var tempId = ObjSpreadAll[i].id;
						tempId = tempId.split("titleCate_"+spread_cate+"_").join("");
						ObjSpreadTitle[titleCnt] = tempId;
						titleCnt++;
					}
				}

				if(ObjSpreadTitle!=null && ObjSpreadTitle.length>0) {
					for(var i=0; i < ObjSpreadTitle.length; i++) {
						var tempSpread_cate = ObjSpreadTitle[i];
						for(var j=0; j<100; j++){
							if(document.getElementById("detail_c_"+tempSpread_cate+"_"+j) && document.getElementById("detail_c_"+tempSpread_cate+"_"+j).childNodes[0].childNodes[0].id.indexOf(param_cate)>-1) {
								spreadFindFlag = true;
								break;
							}
						}    
					}
				} else {
					for(var j=0; j<100; j++){
						if(document.getElementById("detail_c_"+spread_cate+"_"+j) && document.getElementById("detail_c_"+spread_cate+"_"+j).childNodes[0].childNodes[0].id.indexOf(param_cate)>-1) {
							spreadFindFlag = true;
							break;
						}
					}    
				}

				if(spreadFindFlag){  
					document.getElementById("spread"+param_cate).parentNode.parentNode.style.borderBottom = "1px solid #f7bed1";
				}
			}
  		}
	}
	/*
	if(param_cate.length==8) {
		if(document.getElementById("spread_color_cate_"+param_cate.substring(0,6))) {
			var spread_line_bottom_colorList = document.getElementById("spread_color_cate_"+param_cate.substring(0,6)).value;

			if(param_cate.length>6 &&spread_line_bottom_colorList.indexOf(param_cate)>-1) {
				try {
						if(param_gubun == "on") {
							document.getElementById("spread"+param_cate).parentNode.parentNode.style.borderBottom = "1px solid #f7bed1";
						}
						if(param_gubun == "out") {
							if(document.getElementById("spread"+param_cate)!=oldShowCateId && document.getElementById("spread"+param_cate)!=oldShowCate2Id) {
							document.getElementById("spread"+param_cate).parentNode.parentNode.style.borderBottom = "1px solid red";
							}else{
								document.getElementById("spread"+param_cate).parentNode.parentNode.style.borderBottom = "1px solid black";
							}
						}
					}catch(e) {}
			}
		}
	}
	*/
	/*
	if(param_cate.length==8) {
		if(document.getElementById("spread_color_cate_"+param_cate.substring(0,6))) {
			var spread_line_bottom_colorList = document.getElementById("spread_color_cate_"+param_cate.substring(0,6)).value;

			if(param_cate.length>6 &&spread_line_bottom_colorList.indexOf(param_cate)>-1) {
				try {
					if(param_gubun == "on") {
						document.getElementById("spread"+param_cate).parentNode.parentNode.style.borderBottom = "1px solid #f7bed1";
					}
					if(param_gubun == "out") {
						var spreadFindFlag = false;
						var objNames = document.getElementsByName("Mspreads"+spread_cate);
						if(objNames!=null) {
							for(var i=0; i<objNames.length; i++) {
								var tempName = objNames[i].id;
								tempName = tempName.split("Mspread").join("spread");

								var objNames2 = document.getElementsByName(tempName);
								
								for(var j=0; j<objNames2.length; j++) {
									
									if(objNames2[j].id=="spread"+param_cate) {
										spreadFindFlag = true;
										break;
									}
								}
							}
						}

						if(spreadFindFlag) {
							document.getElementById("spread"+param_cate).parentNode.parentNode.style.borderBottom = "1px solid #f7bed1";
	
						}else{
								document.getElementById("spread"+param_cate).parentNode.parentNode.style.borderBottom = "1px solid #afd6ff";
							//document.getElementById("spread"+param_cate).parentNode.parentNode.style.borderBottom = "1px solid #afd6ff";
						}
					}
				} catch(e) {}
			}
			
		}
	}
	*/
}

function Cmd_Color_Spread2(param_gubun,paramBundle){
	var spreadBundle = paramBundle;
	var spreadBundle_arr = spreadBundle.split(",");	

	for( var i = 0 ; i < spreadBundle_arr.length ; i ++ ){
		if(param_gubun == "on"){
			if(document.getElementById("spread"+spreadBundle_arr[i]).className == "sml_n1"){
				document.getElementById("spread"+spreadBundle_arr[i]).className = "sml_n3";	
			}else if(document.getElementById("spread"+spreadBundle_arr[i]).className == "sml_n2"){
				document.getElementById("spread"+spreadBundle_arr[i]).className = "sml_n4";
			}
		}else{
			if(document.getElementById("spread"+spreadBundle_arr[i]).className == "sml_n4"){
				document.getElementById("spread"+spreadBundle_arr[i]).className = "sml_n2";	
			}else if(document.getElementById("spread"+spreadBundle_arr[i]).className == "sml_n3"){
				document.getElementById("spread"+spreadBundle_arr[i]).className = "sml_n1";
			}			
		}

	}
}

function Cmd_Color_Spread_1459(param_cate,param,param_gubun,paramClass){
	/*
	var ObjSpread = document.getElementsByName(param);
	var thisObj = document.getElementById("spread"+param_cate);
	if(ObjSpread.length>0){ //크롬,파폭등에서 getElementsByName 으로 개체를 못찾음
		for(var i=0; i < ObjSpread.length; i++) {
			ObjSpread[i].className == "sml_n1";
			if("spread"+spread_cate == ObjSpread[i].id){
				if(ObjSpread[i].className == "sml_n1"){
					ObjSpread[i].className = "sml_n3";
					if(oldShowCateId ==null) {
						thisObj.parentElement.style.backgroundColor = "#EAD2DA";
					}
				}else if(ObjSpread[i].className == "sml_n2"){
					ObjSpread[i].className = "sml_n4";
					if(oldShowCateId ==null) {
						thisObj.parentElement.style.backgroundColor = "#EAD2DA";
					}
				}
			}else{
			//ju0703
				if(paramClass == i ){
					if(param_gubun == "on" && paramClass != ""){
						if(ObjSpread[i].className == "sml_n1"){
						if(oldShowCateId ==null) {
							thisObj.parentElement.style.backgroundColor = "#EAD2DA";
						}
							ObjSpread[i].className = "sml_n3";
						}else if(ObjSpread[i].className == "sml_n2"){
							ObjSpread[i].className = "sml_n4";
							if(oldShowCateId ==null) {
								thisObj.parentElement.style.backgroundColor = "#EAD2DA"; 
							}
						}
					}else{
						if(ObjSpread[i].className == "sml_n4"){
							thisObj.parentElement.style.backgroundColor = "#F9F9F9";
							ObjSpread[i].className = "sml_n2";
						}else if(ObjSpread[i].className == "sml_n3"){
							ObjSpread[i].className = "sml_n1";
							 thisObj.parentElement.style.backgroundColor = "#F9F9F9";
						}			
					}
				}
			}
		}
	}else{
		if (thisObj){
			if(param_gubun == "on"){
	  			thisObj.parentElement.style.backgroundColor = "#EAD2DA";
			}else if(param_gubun == "out"){
	 			if(document.getElementById("spread"+param_cate)!=oldShowCateId) {
					thisObj.parentElement.style.backgroundColor = "#F9F9F9";
					if(param_gubun == "on"){
	  					thisObj.parentElement.style.backgroundColor = "#EAD2DA";
					}
				}
			}
		}
	}
	if(param_cate == "03042601"){ 
		//Cmd_Color_Spread2(param_gubun, "03042602,03042603,03042604");
	}
	*/
	
	var thisObj = document.getElementById("spread"+param_cate);
	if (thisObj){
		if(param_gubun == "on"){
			if(thisObj.className == "sml_n1"){
				thisObj.className = "sml_n3";
			}else if(thisObj.className == "sml_n2"){
				thisObj.className = "sml_n4";
			}			
			if(oldShowCateId == null && oldShowCate2Id == null) {
				if (thisObj.className != "sml_n_ex1"){
					thisObj.parentElement.style.backgroundColor = "#EAD2DA";
				}
			}
		}else if(param_gubun == "out"){
			if(document.getElementById("spread"+param_cate)!=oldShowCateId && document.getElementById("spread"+param_cate)!=oldShowCate2Id) {
				if(thisObj.className == "sml_n3"){
					thisObj.className = "sml_n1";
				}else if(thisObj.className == "sml_n4"){
					thisObj.className = "sml_n2";
				}			
				if (thisObj.className != "sml_n_ex1"){
					thisObj.parentElement.style.backgroundColor = "#F9F9F9";
				}
			}
		}
	}
}

function Cmd_Color_Spread_Group(param_cate, param_gubun){
	
	//curStyle = param_cate;
	//var ObjSpread = document.getElementsByName("spread"+param_cate);
	var ObjSpread = new Array();
	var ObjSpreadAll = document.getElementById("spread_div").getElementsByTagName("DIV");
	for (var i=0;i<ObjSpreadAll.length;i++){
		if (ObjSpreadAll[i].id.indexOf("spread"+param_cate) >= 0 ){
			ObjSpread[ObjSpread.length] = ObjSpreadAll[i];
		}
	}
	
	var ObjClass;
	
	var cate = param_cate;
	if(cate=="030434"){
		cate = "03043404";
	}
	if(cate=="030522"){
		cate = "03052201";
	}
	if(cate=="145514"){
		cate = "145514";
	}
	if(cate=="145414"){
		cate = "145414";
	}
//	showLog("param_cate="+param_cate + param_gubun);
	//if(ObjSpread.length < 1){
	//ju
	//alert("param_cate="+param_cate);
	if(param_cate!="150908"){
		if(param_gubun == "over"){
			Cmd_Color_Spread_Group._varPrevColor = document.getElementById("Mspread"+param_cate).style.color;
			document.getElementById("Mspread"+param_cate).style.color = "#BD0F0E";
			if(document.getElementById("nobundle_cate"+param_cate)) {
				document.getElementById("nobundle_cate"+param_cate).style.backgroundColor = "#EAD2DA";
				if(param_cate.substring(0,2) == "87"){
					document.getElementById("nobundle_cate"+cate).style.borderTop = "1px solid #D9A5B7";
				}
			}
			for(i=0; i<100; i++){
				if(document.getElementById("detail_c_"+param_cate.substring(0,6)+"_"+i)) {
					document.getElementById("detail_c_"+param_cate.substring(0,6)+"_"+i).style.borderColor = "#EAD2DA"; 
				}else{
					break;
				}
			}
			for(g=0; g<100; g++){
				if(document.getElementById("detail_d_"+param_cate.substring(0,8)+"_"+g)) {
					document.getElementById("detail_d_"+param_cate.substring(0,8)+"_"+g).style.borderColor = "#EAD2DA"; 
				}else{
					break;
				}
			}
			
			if(document.getElementById("group_span_blue1"+param_cate)) {document.getElementById("group_span_blue1"+param_cate).style.backgroundColor = "#D9A5B7";}
			if(document.getElementById("group_span_blue2"+param_cate)) {document.getElementById("group_span_blue2"+param_cate).style.backgroundColor = "#D9A5B7";}
			if(document.getElementById("group_span_blue3"+param_cate)) {document.getElementById("group_span_blue3"+param_cate).style.backgroundColor = "#D9A5B7";}
			if(document.getElementById("group_span_blue4"+param_cate)) {document.getElementById("group_span_blue4"+param_cate).style.backgroundColor = "#D9A5B7";}

		}else{ 
			if(spread_cate =="030434" || spread_cate =="030522"){
				
				document.getElementById("Mspread"+param_cate).style.color = "#000000";
				if(document.getElementById("nobundle_cate"+param_cate)) {
					document.getElementById("nobundle_cate"+param_cate).style.backgroundColor = "#CBDEF2";
				}
				for(i=0; i<100; i++){
					if(document.getElementById("detail_c_"+param_cate.substring(0,6)+"_"+i)) {
						document.getElementById("detail_c_"+param_cate.substring(0,6)+"_"+i).style.borderColor = "#CBDEF2"; 
					}else{
						break;
					}
				}    
				for(g=0; g<100; g++){
					if(document.getElementById("detail_d_"+param_cate.substring(0,8)+"_"+g)) {
						document.getElementById("detail_d_"+param_cate.substring(0,8)+"_"+g).style.borderColor = "#CBDEF2"; 
					}else{
						break;
					}
				}
				if(document.getElementById("group_span_blue1"+param_cate)) {document.getElementById("group_span_blue1"+param_cate).style.backgroundColor = "#85AAD3";}
				if(document.getElementById("group_span_blue2"+param_cate)) {document.getElementById("group_span_blue2"+param_cate).style.backgroundColor = "#85AAD3";}
				if(document.getElementById("group_span_blue3"+param_cate)) {document.getElementById("group_span_blue3"+param_cate).style.backgroundColor = "#85AAD3";}
				if(document.getElementById("group_span_blue4"+param_cate)) {document.getElementById("group_span_blue4"+param_cate).style.backgroundColor = "#85AAD3";}
			}else{
				if(spread_cate == param_cate || getBundleCateList(spread_cate).indexOf(param_cate)>-1 || Cmd_Color_Spread_Group._varPrevColor == "#BD0F0E"){
				//alert("spread_cate="+spread_cate);
					
				}else{
					
					document.getElementById("Mspread"+param_cate).style.color = "#000000";
					if(document.getElementById("nobundle_cate"+param_cate)) {
						document.getElementById("nobundle_cate"+param_cate).style.backgroundColor = "#CBDEF2";
						if(param_cate.substring(0,2) == "87"){
							document.getElementById("nobundle_cate"+cate).style.borderTop = "1px solid #85AAD3";
						}
					}
					
					for(i=0; i<100; i++){
						if(document.getElementById("detail_c_"+param_cate.substring(0,6)+"_"+i)) {
							document.getElementById("detail_c_"+param_cate.substring(0,6)+"_"+i).style.borderColor = "#CBDEF2"; 
						}else{
							break;
						}
					}    
					for(g=0; g<100; g++){
						if(document.getElementById("detail_d_"+param_cate.substring(0,8)+"_"+g)) {
							document.getElementById("detail_d_"+param_cate.substring(0,8)+"_"+g).style.borderColor = "#CBDEF2"; 
						}else{
							break;
						}
					}
					if(document.getElementById("group_span_blue1"+param_cate)) {document.getElementById("group_span_blue1"+param_cate).style.backgroundColor = "#85AAD3";}
					if(document.getElementById("group_span_blue2"+param_cate)) {document.getElementById("group_span_blue2"+param_cate).style.backgroundColor = "#85AAD3";}
					if(document.getElementById("group_span_blue3"+param_cate)) {document.getElementById("group_span_blue3"+param_cate).style.backgroundColor = "#85AAD3";}
					if(document.getElementById("group_span_blue4"+param_cate)) {document.getElementById("group_span_blue4"+param_cate).style.backgroundColor = "#85AAD3";}
				}
			}	
		}
	}
	//}
	//찾았당
	for(var i=0; i < ObjSpread.length; i++) {
		if("spread"+spread_cate == ObjSpread[i].id || "Mspread"+spread_cate == ObjSpread[i].id ){

		}else{
			if(param_gubun == "over"){
				if(param_cate!="150908" && param_cate.substring(0,2) != "87" && param_cate.legth<6){
					if(ObjSpread[i].className == "sml_n1"){
						ObjSpread[i].className = "sml_n3";
					}else if(ObjSpread[i].className == "sml_n2"){
						ObjSpread[i].className = "sml_n4";
					}/*else if(ObjSpread[i].className == "sml_n_ex1"){
						ObjSpread[i].className = "sml_n_ex3";
					}*/
				}else if(param_cate.substring(0,2) == "87" && param_cate.legth>6){
					if(ObjSpread[0].className == "sml_n1"){
						ObjSpread[0].className = "sml_n3";
					}else if(ObjSpread[0].className == "sml_n2"){
						ObjSpread[0].className = "sml_n4";
					}
				}
			}else{
				if((spread_cate=="030434" && ObjSpread[i].id=="spread03043404") || (spread_cate=="030522" && ObjSpread[i].id=="spread03052201")) {
					//if(document.getElementById("spread03043404")) {document.getElementById("spread03043404").style.backgroundColor = "#EAD2DA";}
					ObjSpread[0].className = "sml_n0";
					ObjSpread[1].className = "sml_nA";
					ObjSpread[0].parentElement.style.backgroundColor = "#EAD2DA";
				} else {
					if(ObjSpread[i].className == "sml_n3"){
						ObjSpread[i].className = "sml_n1";
					}else if(ObjSpread[i].className == "sml_n4"){
						ObjSpread[i].className = "sml_n2";
					}else if(ObjSpread[i].className == "sml_n_ex3"){
						ObjSpread[i].className = "sml_n_ex1";
					}
					/*
					if(ObjSpread[i].id=="spread03043404" || ObjSpread[i].id=="spread03052201") {
						ObjSpread[0].className = "sml_n1";
						ObjSpread[1].className = "sml_n1";
						ObjSpread[0].parentElement.style.backgroundColor = "#F9F9F9";
					}
					*/
				}
			}
		}

		//var tempId = ObjSpread[i].id;
		//var 
		

	}

   	if(param_cate.length==6 && document.getElementById("spread_color_cate_"+param_cate)) {
		var spread_line_bottom_colorList = document.getElementById("spread_color_cate_"+param_cate).value;

		for (var i=0;i<ObjSpread.length;i++){
			var tempSpreadCate = ObjSpread[i].id;
			tempSpreadCate = tempSpreadCate.split("spread").join("");
			
			if(tempSpreadCate.length>6 &&spread_line_bottom_colorList.indexOf(tempSpreadCate)>-1) {
				try {
					if(param_gubun == "over"){
						//document.getElementById("spread"+tempSpreadCate).parentNode.parentNode.style.borderBottom = "1px solid #f7bed1";
					}else{
						
						/*
						var spreadFindFlag = false;
						var objNames = document.getElementsByName("Mspreads"+spread_cate);
						if(objNames!=null) {
							for(var j=0; j < objNames.length; j++) {
								if(objNames[j].id=="Mspread"+param_cate) {
									spreadFindFlag = true;
									break;
								}
							}
						}
						var spreadFindFlag = false;
							var objNames = document.getElementsByName("Mspreads"+spread_cate);
							if(objNames!=null) {
								for(var j=0; j<objNames.length; j++) {
									var tempName = objNames[j].id;
									tempName = tempName.split("Mspread").join("spread");

									var objNames2 = document.getElementsByName(tempName);
									alert(222)
									for(var h=0; h<objNames2.length; h++) {
										alert(111)
										if(objNames2[h].id=="spread"+param_cate) {
											spreadFindFlag = true;
											break;
										}
									}
								}
							}
						*/
						
						var spreadFindFlag = false;

						var ObjSpreadAll = document.getElementById("spread_div").getElementsByTagName("TD");
						var ObjSpreadTitle = new Array();
						var titleCnt = 0;
						for (var i=0;i<ObjSpreadAll.length;i++){
							if (ObjSpreadAll[i].id.indexOf("titleCate_"+spread_cate) >= 0 ){
								var tempId = ObjSpreadAll[i].id;
								tempId = tempId.split("titleCate_"+spread_cate+"_").join("");
								ObjSpreadTitle[titleCnt] = tempId;
								titleCnt++;
							}
						}

						if(ObjSpreadTitle!=null && ObjSpreadTitle.length>0) {
							for(var i=0; i < ObjSpreadTitle.length; i++) {
								var tempSpread_cate = ObjSpreadTitle[i];
								for(var j=0; j<100; j++){
									if(document.getElementById("detail_c_"+tempSpread_cate+"_"+j) && document.getElementById("detail_c_"+tempSpread_cate+"_"+j).childNodes[0].childNodes[0].id.indexOf(param_cate)>-1) {
										spreadFindFlag = true;
										break;
									}
								}    
							}
						} else {
							for(var j=0; j<100; j++){
								if(document.getElementById("detail_c_"+spread_cate+"_"+j) && document.getElementById("detail_c_"+spread_cate+"_"+j).childNodes[0].childNodes[0].id.indexOf(param_cate)>-1) {
									spreadFindFlag = true;
									break;
								}
							}    
						}
						/*
						var objNames = document.getElementsByName("Mspreads"+spread_cate);
						if(objNames!=null) {
							for(var j=0; j < objNames.length; j++) {
								if(objNames[j].id=="Mspread"+param_cate) {
									spreadFindFlag = true;
									break;
								}
							}
						}
						*/
							
						if(spreadFindFlag){   
							document.getElementById("spread"+tempSpreadCate).parentNode.parentNode.style.borderBottom = "1px solid #f7bed1";
						}else{
							if(spread_cate == param_cate){
								document.getElementById("spread"+tempSpreadCate).parentNode.parentNode.style.borderBottom = "1px solid #f7bed1";
							}else{
								document.getElementById("spread"+tempSpreadCate).parentNode.parentNode.style.borderBottom = "1px solid #afd6ff";
							}
							//document.getElementById("spread"+tempSpreadCate).parentNode.parentNode.style.borderBottom = "1px solid #afd6ff";
						}
						//document.getElementById("spread"+tempSpreadCate).parentNode.parentNode.style.borderBottom = "1px solid #f7bed1";
					}
				} catch(e) {}
			}
		}
	}

	//	if(param_cate.length==6) {
//		alert(spread_line_bottom_colorListAry)
//		alert(spread_line_bottom_colorListAry[param_cate])
//	}
	//alert(spread_line_bottom_colorList)
}

function Cmd_Color_Spread_Group_Fusion(param_cate, param_gubun){

	//curStyle = param_cate;
	//var ObjSpread = document.getElementsByName("spread"+param_cate);
	
	var ObjSpread = new Array();
	var ObjSpreadAll = document.getElementById("spread_div").getElementsByTagName("DIV");
	for (var i=0;i<ObjSpreadAll.length;i++){
		if (ObjSpreadAll[i].id.indexOf("spread"+param_cate) >= 0 ){
			ObjSpread[ObjSpread.length] = ObjSpreadAll[i];
		}
	}

	
	var ObjClass;

	
	var cate = param_cate;
	if(cate=="030434"){
		cate = "03043404";
	}
	if(cate=="030522"){
		cate = "03052201";
	}
	if(cate=="145514"){
	//alert("cate="+cate);
		cate = "145514";
	}
	if(cate=="145414"){
	//alert("cate="+cate);
		cate = "145414";
	}
	//if(ObjSpread.length < 1){
		if(param_cate!="150908"){
		if(param_gubun == "over"){
			Cmd_Color_Spread_Group._varPrevColor = document.getElementById("Mspread"+param_cate).style.color;
			if(document.getElementById("nobundle_cate"+param_cate)) {document.getElementById("nobundle_cate"+param_cate).style.backgroundColor = "#EAD2DA";}
			/*for(i=0; i<100; i++){
					if(document.getElementById("detail_c_"+param_cate.substring(0,6)+"_"+i)) {
						document.getElementById("detail_c_"+param_cate.substring(0,6)+"_"+i).style.borderColor = "#EAD2DA"; 
					}else{
						break;
					}
				}*/
			/*for(g=0; g<100; g++){
					if(document.getElementById("detail_d_"+param_cate.substring(0,8)+"_"+g)) {
						document.getElementById("detail_d_"+param_cate.substring(0,8)+"_"+g).style.borderColor = "#EAD2DA"; 
					}else{
						break;
					}
				}*/
			if(document.getElementById("group_span_blue1"+param_cate)) {document.getElementById("group_span_blue1"+param_cate).style.backgroundColor = "#D9A5B7";}
			if(document.getElementById("group_span_blue2"+param_cate)) {document.getElementById("group_span_blue2"+param_cate).style.backgroundColor = "#D9A5B7";}
			if(document.getElementById("group_span_blue3"+param_cate)) {document.getElementById("group_span_blue3"+param_cate).style.backgroundColor = "#D9A5B7";}
			if(document.getElementById("group_span_blue4"+param_cate)) {document.getElementById("group_span_blue4"+param_cate).style.backgroundColor = "#D9A5B7";}

		}else{ 
			if(spread_cate == param_cate || Cmd_Color_Spread_Group._varPrevColor == "#BD0F0E"){
			}else{
				if(document.getElementById("nobundle_cate"+param_cate)) {document.getElementById("nobundle_cate"+param_cate).style.backgroundColor = "#CBDEF2";}
				for(i=0; i<100; i++){
					if(document.getElementById("detail_c_"+param_cate.substring(0,6)+"_"+i)) {
						document.getElementById("detail_c_"+param_cate.substring(0,6)+"_"+i).style.borderColor = "#CBDEF2"; 
					}else{
						break;
					}
				}
				for(g=0; g<100; g++){
					if(document.getElementById("detail_d_"+param_cate.substring(0,8)+"_"+g)) {
						document.getElementById("detail_d_"+param_cate.substring(0,8)+"_"+g).style.borderColor = "#CBDEF2"; 
					}else{
						break;
					}
				}
				if(document.getElementById("group_span_blue1"+param_cate)) {document.getElementById("group_span_blue1"+param_cate).style.backgroundColor = "#85AAD3";}
				if(document.getElementById("group_span_blue2"+param_cate)) {document.getElementById("group_span_blue2"+param_cate).style.backgroundColor = "#85AAD3";}
				if(document.getElementById("group_span_blue3"+param_cate)) {document.getElementById("group_span_blue3"+param_cate).style.backgroundColor = "#85AAD3";}
				if(document.getElementById("group_span_blue4"+param_cate)) {document.getElementById("group_span_blue4"+param_cate).style.backgroundColor = "#85AAD3";}
			}
		}	
		}
	//}
	//찾았당
	for(var i=0; i < ObjSpread.length; i++) {
		if("spread"+spread_cate == ObjSpread[i].id){
		}else{
			if(param_gubun == "over"){
				if(param_cate!="150908"){
					/*if(ObjSpread[i].className == "sml_n1"){
						ObjSpread[i].className = "sml_n3";
					}else if(ObjSpread[i].className == "sml_n2"){
						ObjSpread[i].className = "sml_n4";
					}*/
				}
			}else{
				//if(param_cate!="150908" || param_cate!="03043405"){
					if(ObjSpread[i].className == "sml_n3"){
						ObjSpread[i].className = "sml_n1";
					}else if(ObjSpread[i].className == "sml_n4"){
						ObjSpread[i].className = "sml_n2";
					}
				//}
			}
		}
	}
}
function Cmd_Color_Spread_Fusion(param_cate, param_gubun){
	//curStyle = param_cate;
	//var ObjSpread = document.getElementsByName("spread"+param_cate);
	var ObjSpread = new Array();
	var ObjSpreadAll = document.getElementById("spread_div").getElementsByTagName("DIV");
	for (var i=0;i<ObjSpreadAll.length;i++){
		if (ObjSpreadAll[i].id.indexOf("spread"+param_cate) >= 0 ){
			ObjSpread[ObjSpread.length] = ObjSpreadAll[i];
		}
	}
	
	var ObjClass;

	
	var cate = param_cate;
	if(cate=="030434"){
		cate = "03043404";
	}
	if(cate=="030522"){
		cate = "03052201";
	}
	if(cate=="145514"){
	//alert("cate="+cate);
		cate = "145514";
	}
	if(cate=="145414"){
	//alert("cate="+cate);
		cate = "145414";
	}
	if(param_cate!="150908"){
		if(param_gubun == "over"){
			Cmd_Color_Spread_Group._varPrevColor = document.getElementById("spread"+param_cate).style.color;
			if(document.getElementById("spread_cate"+param_cate)) {document.getElementById("spread_cate"+param_cate).style.backgroundColor = "#EAD2DA";}
	
		}else{ 
			if(spread_cate == param_cate || Cmd_Color_Spread_Group._varPrevColor == "#F9F9F9"){
			}else{
				if(document.getElementById("spread_cate"+param_cate)) {document.getElementById("spread_cate"+param_cate).style.backgroundColor = "#F9F9F9";}
			}
		}	
	}
}
function Cmd_Color_Spread_Bundle_Group(param_cate,param_bundle_cate, param_gubun){
 
	if(param_gubun == "over"){
		document.getElementById("Mspread"+param_cate).style.color = "#BD0F0E";
		document.getElementById("Mspread"+param_cate).style.backgroundColor = "#EAD2DA";
		document.getElementById("Mspread"+param_cate).className = "group_span_pink";
		if(document.getElementById("group_div5"+param_cate)) {document.getElementById("group_div5"+param_cate).src = var_img_enuri_com + "/2010/images/view/menu/group_line_3_0408.gif";}
		if(document.getElementById("group_div7"+param_cate)) {document.getElementById("group_div7"+param_cate).src = var_img_enuri_com + "/2010/images/view/menu/group_line_3_0408.gif";}
		if(document.getElementById("group_div6"+param_cate)) {document.getElementById("group_div6"+param_cate).className = "group_div6_pink";}
	}else{
		if(spread_cate == param_cate){
		}else{
			document.getElementById("Mspread"+param_cate).style.color = "#000000";
			document.getElementById("Mspread"+param_cate).style.backgroundColor = "#CBDEF2";
			document.getElementById("Mspread"+param_cate).className = "group_span_re";
			if(document.getElementById("group_div6"+param_cate)) {document.getElementById("group_div6"+param_cate).className = "group_div6";}
			if(document.getElementById("group_div5"+param_cate)) {document.getElementById("group_div5"+param_cate).src = var_img_enuri_com + "/2010/images/view/menu/group_line_3.gif";}
			if(document.getElementById("group_div7"+param_cate)) {document.getElementById("group_div7"+param_cate).src = var_img_enuri_com + "/2010/images/view/menu/group_line_3.gif";}
		}
	}
		
	//var ObjSpread2 = document.getElementsByName("Mspreads"+param_cate);
	
	var ObjSpread2 = new Array();
	var ObjSpreadAll = document.getElementById("spread_div").getElementsByTagName("DIV");
	for (var i=0;i<ObjSpreadAll.length;i++){
		if (ObjSpreadAll[i].getAttribute("name") != null){
			if (ObjSpreadAll[i].getAttribute("name").indexOf("Mspreads"+param_cate) >= 0 ){
				ObjSpread2[ObjSpread2.length] = ObjSpreadAll[i];
			}
		}
	}
	
	for(var i=0; i < ObjSpread2.length; i++) {
 		var tempCate = ObjSpread2[i].id.substring(7);
//여기서 묶음
	 	if(param_gubun == "over"){
	 		document.getElementById(ObjSpread2[i].id).style.color = "#BD0F0E";
	 		if(document.getElementById("nobundle_cate"+tempCate)) {document.getElementById("nobundle_cate"+tempCate).style.backgroundColor = "#EAD2DA"; }
			if(document.getElementById("group_span_blue1"+tempCate)) {document.getElementById("group_span_blue1"+tempCate).style.backgroundColor = "#D9A5B7";}
			if(document.getElementById("group_span_blue2"+tempCate)) {document.getElementById("group_span_blue2"+tempCate).style.backgroundColor = "#D9A5B7";}
			if(document.getElementById("group_span_blue3"+tempCate)) {document.getElementById("group_span_blue3"+tempCate).style.backgroundColor = "#D9A5B7";}
			if(document.getElementById("group_span_blue4"+tempCate)) {document.getElementById("group_span_blue4"+tempCate).style.backgroundColor = "#D9A5B7";}
	 		for(j=0; j<100; j++){
				if(document.getElementById("detail_c_"+tempCate.substring(0,6)+"_"+j)) {
					document.getElementById("detail_c_"+tempCate.substring(0,6)+"_"+j).style.borderColor = "#EAD2DA"; 
				}else{
					break;
				}
			}
			for(g=0; g<100; g++){
				if(document.getElementById("detail_d_"+tempCate.substring(0,8)+"_"+g)) {
					document.getElementById("detail_d_"+tempCate.substring(0,8)+"_"+g).style.borderColor = "#EAD2DA"; 
				}else{
					break;
				}
			}
	 	}else{
	 		if(document.getElementById("Mspread"+spread_cate) == document.getElementById(ObjSpread2[i].id)){
	 		}else if(spread_cate == param_cate){
			}else{
	 			document.getElementById(ObjSpread2[i].id).style.color = "#000000";
	 			//document.getElementById(ObjSpread2[i].id).style.fontWeight = "normal";
	 			if(document.getElementById("nobundle_cate"+tempCate)) {document.getElementById("nobundle_cate"+tempCate).style.backgroundColor = "#CBDEF2";}
	 			if(document.getElementById("group_span_blue1"+tempCate)) {document.getElementById("group_span_blue1"+tempCate).style.backgroundColor = "#85AAD3";}
				if(document.getElementById("group_span_blue2"+tempCate)) {document.getElementById("group_span_blue2"+tempCate).style.backgroundColor = "#85AAD3";}
				if(document.getElementById("group_span_blue3"+tempCate)) {document.getElementById("group_span_blue3"+tempCate).style.backgroundColor = "#85AAD3";}
				if(document.getElementById("group_span_blue4"+tempCate)) {document.getElementById("group_span_blue4"+tempCate).style.backgroundColor = "#85AAD3";}
	 			for(j=0; j<100; j++){
				if(document.getElementById("detail_c_"+tempCate.substring(0,6)+"_"+j)) {
					document.getElementById("detail_c_"+tempCate.substring(0,6)+"_"+j).style.borderColor = "#CBDEF2"; 
				}else{
					break;
				}
				for(g=0; g<100; g++){
				if(document.getElementById("detail_d_"+tempCate.substring(0,8)+"_"+g)) {
					document.getElementById("detail_d_"+tempCate.substring(0,8)+"_"+g).style.borderColor = "#CBDEF2"; 
				}else{
					break;
				}
			}
			}
	 		}
				
	 		//if(document.getElementById("nobundle_cate"+spread_cate)) {document.getElementById("nobundle_cate"+spread_cate).style.backgroundColor = "#EAD2DA";}
	 	}
	}
	var ObjSpread = new Array();
	 var ObjSpreadAll = document.getElementById("spread_div").getElementsByTagName("DIV");
	 for (var i=0;i<ObjSpread2.length;i++){
		 if (ObjSpread2[i].id.indexOf("spread")>=0 && ObjSpread2[i].id.indexOf("Mspread")<0 ){
			 var tempSpreadId = ObjSpread2[i].id;
			 tempSpreadId = tempSpreadId.split("spread").join("");
			 
			 if(document.getElementById("spread_color_cate_"+tempSpreadId.substring(0, 6))) {
				 var spread_line_bottom_colorList = document.getElementById("spread_color_cate_"+tempSpreadId.substring(0, 6)).value;

				 if(tempSpreadId.length>6 && spread_line_bottom_colorList.indexOf(tempSpreadId)>-1) {
					 if(param_gubun == "over"){
						 document.getElementById("spread"+tempSpreadId).parentNode.parentNode.style.borderBottom = "1px solid #f7bed1";
					 }else{
						if(spread_cate == param_cate){
							document.getElementById("spread"+tempSpreadId).parentNode.parentNode.style.borderBottom = "1px solid #f7bed1";	 
						}else{
							document.getElementById("spread"+tempSpreadId).parentNode.parentNode.style.borderBottom = "1px solid #afd6ff";	
						}
					 }
				 }
			 }
		 } 
	  }
}

function Cmd_Fashion_Color_Spread_Bundle_Group(param_cate,param_bundle_cate, param_gubun){
	if(param_gubun == "over"){
		document.getElementById("Mspread"+param_cate).style.color = "#BD0F0E";
		if(document.getElementById("Mspreadi"+param_cate)) {document.getElementById("Mspreadi"+param_cate).style.backgroundColor = "#EAD2DA";}
		if(document.getElementById("Mspreadi"+param_cate)) {document.getElementById("Mspreadi"+param_cate).style.borderColor = "#D9A5B7";}
		if(document.getElementById("Mspreadi2"+param_cate)) {document.getElementById("Mspreadi2"+param_cate).style.color = "#D9A5B7";}
		if(document.getElementById("Mspreadi3"+param_cate)) {document.getElementById("Mspreadi3"+param_cate).style.color = "#D9A5B7";}
	}else{
		if(spread_cate == param_cate || getBundleCateList(spread_cate).indexOf(param_cate)>-1){
		}else{
			document.getElementById("Mspread"+param_cate).style.color = "#000000";
			if(document.getElementById("Mspreadi"+param_cate)) {document.getElementById("Mspreadi"+param_cate).style.backgroundColor = "#CBDEF2";}
			if(document.getElementById("Mspreadi"+param_cate)) {document.getElementById("Mspreadi"+param_cate).style.borderColor = "#85AAD3";}
			if(document.getElementById("Mspreadi2"+param_cate)) {document.getElementById("Mspreadi2"+param_cate).style.color = "#85AAD3";}
			if(document.getElementById("Mspreadi3"+param_cate)) {document.getElementById("Mspreadi3"+param_cate).style.color = "#85AAD3";}
			//document.getElementById("Mspread"+param_cate).style.fontWeight = "normal";
		}
	}
		
	//var ObjSpread2 = document.getElementsByName("Mspreads"+param_cate);
	
	var ObjSpread2 = new Array();
	var ObjSpreadAll = document.getElementById("spread_div").getElementsByTagName("DIV");
	for (var i=0;i<ObjSpreadAll.length;i++){
		if (ObjSpreadAll[i].getAttribute("name") != null){
			if (ObjSpreadAll[i].getAttribute("name").indexOf("Mspreads"+param_cate) >= 0 ){
				ObjSpread2[ObjSpread2.length] = ObjSpreadAll[i];
			}
		}
	}
	
	for(var i=0; i < ObjSpread2.length; i++) {
 		var tempCate = ObjSpread2[i].id.substring(7);
//여기서 묶음
	 	if(param_gubun == "over"){
	 		for(g=0; g<100; g++){ 
					if(document.getElementById("detail_d_"+tempCate.substring(0,8)+"_"+g)) { 
						document.getElementById("detail_d_"+tempCate.substring(0,8)+"_"+g).style.borderColor = "#EAD2DA"; 
					}else{ 
						break; 
					} 
				}  
	 		document.getElementById(ObjSpread2[i].id).style.color = "#BD0F0E";
	 		if(document.getElementById("nobundle_cate"+tempCate)) {document.getElementById("nobundle_cate"+tempCate).style.backgroundColor = "#EAD2DA";}
			if(document.getElementById("group_span_blue1"+tempCate)) {document.getElementById("group_span_blue1"+tempCate).style.backgroundColor = "#D9A5B7";}
			if(document.getElementById("group_span_blue2"+tempCate)) {document.getElementById("group_span_blue2"+tempCate).style.backgroundColor = "#D9A5B7";}
			if(document.getElementById("group_span_blue3"+tempCate)) {document.getElementById("group_span_blue3"+tempCate).style.backgroundColor = "#D9A5B7";}
			if(document.getElementById("group_span_blue4"+tempCate)) {document.getElementById("group_span_blue4"+tempCate).style.backgroundColor = "#D9A5B7";}
	 		
	 	}else{
	 		if(document.getElementById("Mspread"+spread_cate) == document.getElementById(ObjSpread2[i].id)){
	 		}else if(spread_cate == param_cate){
			}else{
	 			document.getElementById(ObjSpread2[i].id).style.color = "#000000";
	 			//document.getElementById(ObjSpread2[i].id).style.fontWeight = "normal";
	 			for(g=0; g<100; g++){
					if(document.getElementById("detail_d_"+tempCate.substring(0,8)+"_"+g)) {
						document.getElementById("detail_d_"+tempCate.substring(0,8)+"_"+g).style.borderColor = "#CBDEF2"; 
					}else{
						break;
					}
				}
	 			if(document.getElementById("nobundle_cate"+tempCate)) {document.getElementById("nobundle_cate"+tempCate).style.backgroundColor = "#CBDEF2";}
	 			if(document.getElementById("group_span_blue1"+tempCate)) {document.getElementById("group_span_blue1"+tempCate).style.backgroundColor = "#85AAD3";}
				if(document.getElementById("group_span_blue2"+tempCate)) {document.getElementById("group_span_blue2"+tempCate).style.backgroundColor = "#85AAD3";}
				if(document.getElementById("group_span_blue3"+tempCate)) {document.getElementById("group_span_blue3"+tempCate).style.backgroundColor = "#85AAD3";}
				if(document.getElementById("group_span_blue4"+tempCate)) {document.getElementById("group_span_blue4"+tempCate).style.backgroundColor = "#85AAD3";}
	 		}
				
	 		//if(document.getElementById("nobundle_cate"+spread_cate)) {document.getElementById("nobundle_cate"+spread_cate).style.backgroundColor = "#EAD2DA";}
	 	}
	}
	spread_cate_bundle = param_cate;
}
function changeColorDcate(dCateLayer,cate){
	//if(cate.substring(0,4) == "2406" || cate.substring(0,4) == "2401" || cate.substring(0,4) == "2405" ) {

		//var varReplace = [,"~49+19㎡","~66+19㎡","76+19㎡","~56+19+19㎡","~66+19+19㎡","76+19+19㎡","169㎡","~10㎡","~33㎡","33㎡","36㎡","69㎡","~66㎡","~132㎡","~198㎡","198㎡","202㎡","~20㎡","~29㎡","~38㎡","~42㎡","~20㎡","26㎡","42㎡","~49㎡","~60㎡","66㎡","~68㎡","~85㎡","~78㎡","95㎡","~92㎡","~104㎡","52㎡","114㎡","~121㎡","~161㎡","~282㎡","318㎡","~91㎡","~200㎡","223㎡","~165㎡","168㎡","168㎡","~99㎡","102㎡","~86㎡","~119㎡","264㎡","~59㎡"];
		//for (i=0;i<varReplace.length;i++){
			//if (dCateLayer.indexOf(varReplace[i]) >= 0 ){
				//dCateLayer = dCateLayer.replace(varReplace[i],"<span style='color:gray' onmouseover=\"this.style.color='#BD0F0E'\" onmouseout=\"this.style.color='gray'\">"+varReplace[i]+"</span>");	
				//if (varReplace[i] == "~33㎡"){
					//dCateLayer = dCateLayer.replace(/~33㎡/g,"<span style='color:gray' onmouseover=\"this.style.color='#BD0F0E'\" onmouseout=\"this.style.color='gray'\">"+varReplace[i]+"</span>");	
				//}else if (varReplace[i] == "~20㎡" ){
					//dCateLayer = dCateLayer.replace(/~20㎡/g,"<span style='color:gray' onmouseover=\"this.style.color='#BD0F0E'\" onmouseout=\"this.style.color='gray'\">"+varReplace[i]+"</span>");	
				//}
			//}
		//}
	//}
	if(cate.substring(0,4) == "0609" || cate.substring(0,4) == "2403"  || cate.substring(0,4) == "0903" || cate.substring(0,4) == "0608" || cate.substring(0,4) == "0606" || cate.substring(0,4) == "1621"|| cate.substring(0,4) == "0621"|| cate.substring(0,4) == "0606"|| cate.substring(0,4) == "0602" || cate.substring(0,4) == "0611"  ||  cate.substring(0,4) == "0507" || cate.substring(0,4) == "0920" ||  cate.substring(0,4) == "2407" || cate.substring(0,4) == "0603" || cate.substring(0,4) == "0604"  || cate.substring(0,4) == "1612"){
		dCateLayer = dCateLayer.replace(/ℓ/g,"<span style='font-size:10pt;'>ℓ</span>");
	}
	if(cate.substring(0,4) == "1608" ){
		dCateLayer = dCateLayer.replace(/㎖/g,"<span style='font-size:10pt;'>㎖</span>");
	}
	if(cate.substring(0,4) == "0515" ){
		dCateLayer = dCateLayer.replace(/㎕/g,"<span style='font-size:10pt;'>㎕</span>");
	}
	if(cate.substring(0,4) == "0363" ){
		dCateLayer = dCateLayer.replace(/↔/g,"<span style='font-size:10pt;'>↔</span>");
	}	 	
	if (cate.substring(0,4) == "0404_1" || cate.substring(0,4) == "0401_1"){
	
		var varReplace = ["(처리속도 순)","고속↓저속"];
		for (i=0;i<varReplace.length;i++){
			if (dCateLayer.indexOf(varReplace[i]) >= 0 ){
				dCateLayer = dCateLayer.replace(varReplace[i],"<span style='color:gray;font-weight:normal;' onmouseover=\"this.style.color='#BD0F0E'\" onmouseout=\"this.style.color='gray'\">"+varReplace[i]+"</span>");	
			}
		}	 

	}
	if (cate.substring(0,4) == "0691" ||  cate.substring(0,4) == "0363" ){
		var varReplace = ["micro SD"];
		
		if (dCateLayer.indexOf(varReplace) >= 0 ){
			dCateLayer = dCateLayer.replace(varReplace,"micro SD<br>");	
		}
	}
	if (cate.substring(0,4) == "0691" || cate.substring(0,4) == "0363" ){
		var varReplace2 = ["SD카드"];
		if (dCateLayer.indexOf(varReplace2) >= 0 ){
			dCateLayer = dCateLayer.replace(varReplace2,"SD카드<br>");	
		}
	}
	if (cate.substring(0,4) ==  "0313"){

		var varReplace = ["<b>미니 SD"];
	
		if (dCateLayer.indexOf(varReplace) >= 0 ){
			dCateLayer = dCateLayer.replace(varReplace,"<b>미니 SD<br>");	
		}
	}
	return dCateLayer;
}

function HideSLayer(){
	document.getElementById("dcate_layer_over").style.display = "none";
	document.getElementById("dcate_layer_over_pointer").style.display = "none";
}
function HideDcateLayer(param){
	if(param == "1"){
		document.getElementById("dcate_layer_over").style.display = "none";
		document.getElementById("dcate_layer_over_pointer").style.display = "none";
		document.getElementById("dcate_layer").style.display = "";
		document.getElementById("dcate_layer_pointer").style.display = "";		
		dcate_over = ""; 
	}else if(param == "3"){
		document.getElementById("dcate_layer").style.display = "none";
		document.getElementById("dcate_layer_pointer").style.display = "none";
	}else{
		document.getElementById("dcate_layer").style.display = "none";
		document.getElementById("dcate_layer").innerHTML = "";
		document.getElementById("dcate_layer_pointer").style.display = "none";
		document.getElementById("img_menu").style.marginBottom = "0px";
		dcate_click = "";
		if(enuriListFrame.document.getElementById("rec_middle_banner")){
			enuriListFrame.document.getElementById("rec_middle_banner").style.marginBottom = "0px";
		}
		if(enuriListFrame.document.getElementById("middle_plan_cate")){
			enuriListFrame.document.getElementById("middle_plan_cate").style.marginBottom = "0px";
		}		
	}
}
function showAdvMenu(){
	initMenu();
	selectedMenu = "adv_menu";
	document.getElementById("adv_menu_btn").src = var_img_enuri_com + "/2010/images/view/list_menu04_on.gif";
	document.getElementById("adv_menu_btn").height = 19;
	setTimeout("top.syncHeightMenuFrame()", 50);
}
function toggleMenu(){
	if (selectedMenu != ""){
		if (document.getElementById(selectedMenu).offsetHeight > 240 ){
			document.getElementById(selectedMenu).style.height = "210px";
			document.getElementById("img_toggle_menu").src = var_img_enuri_com + "/2010/images/view/"+selectedMenu+"_view.gif";
		}else{
			document.getElementById(selectedMenu).style.height = document.getElementById(selectedMenu).scrollHeight +"px";
			document.getElementById("img_toggle_menu").src = var_img_enuri_com + "/2010/images/view/"+selectedMenu+"_hide.gif"; 
		}
		document.getElementById("img_toggle_menu").style.top = (130+document.getElementById(selectedMenu).offsetHeight)+"px";
		top.syncHeightMenuFrame();
	}
}
function Cmd_Open_FavoriteLayer(){
	if(document.getElementById("incFavoriteLayer").innerHTML != enuriListFrame.document.getElementById("div_favorite").innerHTML){
		document.getElementById("incFavoriteLayer").innerHTML = enuriListFrame.document.getElementById("div_favorite").innerHTML;
	}
	if(document.getElementById("incFavoriteLayer").style.display == "none"){
		insertLog('1661');
		document.getElementById("incFavoriteLayer").style.display = "inline";
	}else{
		document.getElementById("incFavoriteLayer").style.display = "none";		
	}
}
function checkFusionCate(cate){
	var varReturn = false;
	if (cate.length >= 2 ){
		if (cate.substring(0,2) == "15"){
			varReturn = true;
		}
	}
	return varReturn;
}
function goFusionMiddleCate(cate){
	top.location.href = "Listmp3.jsp?cate="+cate;
}
function goFusionMiddleCate_Fashion(cate){
	//alert(cate);
	top.location.href = "/view/fusion/Fusion.jsp?cate="+cate;
}
function apple(){
	alert(0);
}

//function goFashionMiddleCate(cate,ismenutype){
	// 실서버
//	top.location.href = "/fashion/clothes/Clothes_StyleList.jsp?cate="+cate;
	// 작업중
	//var replacIframeUrl= "";
	//if(cate.length == 4){
	//	replacIframeUrl = "/fashion/clothes/include/Listbody_Home_Style.jsp?cate="+cate;
	//}else if(cate.length == 6){
	//	replacIframeUrl = "/fashion/clothes/include/Listbody_Style.jsp?cate="+cate;
	//}
	//document.getElementById("enuriListFrame").src = replacIframeUrl;
//}

var oldShowCate2Id = null;
function goFashionCategory_Spread(cate,param_i,isgo){
	//insertLog(4658);
	if(document.getElementById("spread"+cate)!=oldShowCate2Id) {
		if(oldShowCate2Id) oldShowCate2Id.parentElement.style.backgroundColor = "";
		oldShowCate2Id = document.getElementById("spread"+cate);
		if(cate.length == 10){
			if(oldShowCate2Id) oldShowCate2Id.parentElement.style.backgroundColor = "#EAD2DA";
		}
	}
	currentCate = cate;
	if(document.getElementById("currentCate")){
		document.getElementById("currentCate").value = currentCate;
	}
	spread_cate = cate; 
	if(spread_cate_org != "" && cate.length > 6){
		if(document.getElementById("Mspread"+spread_cate_org.substring(0,8)) != null ){
			/*if(cate.substring(0,4) == "1459" || cate.substring(0,3) == "147"){
				Cmd_Color_Spread_Group_1459(spread_cate_org.substring(0,8),'out');
			}else{*/
				Cmd_Color_Spread_Group(spread_cate_org.substring(0,8),'out');
			//}
		}
	}
	if(spread_cate_org!="" && cate.length > 6){
		if(document.getElementById("Mspread"+spread_cate_org.substring(0,8)) != null ){
			document.getElementById("Mspread"+spread_cate_org.substring(0,8)).style.color = "#000000";
		}
		if(spread_cate_bundle!=""){
			if(document.getElementById("Mspread"+cate.substring(0,8)) != null ){
				Cmd_Fashion_Color_Spread_Bundle_Group(spread_cate_bundle,'', 'out');
			}
		}
		if(bundle.indexOf(spread_cate_org) > -1){
			if(document.getElementById("Mspread"+cate.substring(0,8)) != null && document.getElementById("Mspread"+spread_cate_org.substring(0,8)) != null ){
				Cmd_Fashion_Color_Spread_Bundle_Group(spread_cate_org.substring(0,8),'', 'out');
			}
		}
	}
	
	if(cate.length > 8){
		/*if(cate.substring(0,4) == "1459" || cate.substring(0,3) == "147"){
			Cmd_Color_Spread_1459(cate,"spread"+cate,'on',param_i);
		}else{*/
			Cmd_Color_Spread(cate,"spread"+cate,'on',param_i);
		//}
	}else{
		if(cate.length > 6){
			if(document.getElementById("Mspread"+cate.substring(0,8)) != null ){
				document.getElementById("Mspread"+cate).style.color = "#BD0F0E";
			}
		}else{
			if (spread_cate_org != ""){
				//alert(cate+","+spread_cate_org.substring(0,8));
				if(document.getElementById("Mspread"+spread_cate_org.substring(0,8)) != null ){
					//alert("in");
					document.getElementById("Mspread"+spread_cate_org.substring(0,8)).style.color = "#000000";
				}
				/*if(cate.substring(0,4) == "1459" || cate.substring(0,3) == "147"){
					Cmd_Color_Spread_1459(spread_cate_org,"spread"+spread_cate_org.substring(0,8),'out',param_i);
				}else{*/
					Cmd_Color_Spread(spread_cate_org,"spread"+spread_cate_org.substring(0,8),'out',param_i);
				//}
			}
		}
	}
	if(bundle.indexOf(cate) > -1){
		if(document.getElementById("Mspread"+cate.substring(0,8)) != null ){
			Cmd_Fashion_Color_Spread_Bundle_Group(cate,'', 'over');
		}
	}
	if(!goJumpCategory(cate)){
		if (typeof(isgo) == "undefined" || isgo ==""){
			if(cate.substring(0,3) == "147"){
				//alert(cate);
				//alert(document.getElementById("ismenutype").value);
				//alert(enuriListFrame.frmList.pagesize.value);
				document.getElementById("enuriListFrame").src = "/fashion/clothes/include/Listbody_Style.jsp?cate="+cate+"&ismenutype="+document.getElementById("ismenutype").value;
			}
		}
	} 
	if(cate.length == 6){
		spread_cate_org = "";
	}else{
		spread_cate_org = spread_cate;
	}
}

function changeCurStyle(cate, isgo){
	if(currentCate != ""){
		if(String(currentCate).length == 8){
			if(document.getElementById(currentCate+"_img")){
				document.getElementById(currentCate+"_img").src = var_image_enuri_com + "/images/view/ls_fcate/2010/main_detail_img/"+currentCate+".gif";
			}
			
		}else if(String(currentCate).length == 10){
			if(document.getElementById("Mspread"+currentCate)){
				document.getElementById("Mspread"+currentCate).style.color = "#808080";
			}
			if(document.getElementById(currentCate+"_td")){
				document.getElementById(currentCate+"_td").className = "fashion_style_layout_off";
			}
		}
	}
	currentCate = cate;
	if(document.getElementById("currentCate")){
		document.getElementById("currentCate").value = currentCate;
	}
	//curStyle = cate;
	if(String(currentCate).length == 8){
		document.getElementById(currentCate+"_img").src = var_image_enuri_com + "/images/view/ls_fcate/2010/main_detail_img/"+currentCate+"_on.gif";
	}else if(String(currentCate).length == 10){
		document.getElementById("Mspread"+currentCate).style.color = "#BD0F0E";
		document.getElementById(currentCate+"_td").className = "fashion_style_layout_on";
	}
	if(typeof(isgo) == "undefined"){
		document.getElementById("enuriListFrame").src = "/fashion/clothes/include/Listbody_Style.jsp?cate="+cate+"&ismenutype="+document.getElementById("ismenutype").value;
	}
}

function cmdStyleImgResize(){
	var chkImgViewWidth;
	if(top.getBodyClientWidth()<1060){
		chkImgViewWidth = Math.floor(98/9*100)/100; 
	}else if(top.getBodyClientWidth()>=1060 && top.getBodyClientWidth()<1160){
		chkImgViewWidth = Math.floor(98/10*100)/100;
	}else{
		chkImgViewWidth = Math.floor(98/11*100)/100;
	}
	if (varImgViewWidth != chkImgViewWidth){  
		varImgViewWidth = chkImgViewWidth;
		if (styleObj.insertRule) {  
			styleObj.deleteRule(varRuleIndex);
			varRuleIndex = styleObj.cssRules.length;
			styleObj.insertRule(".fusion_style{width:"+varImgViewWidth+"%}",varRuleIndex);
		}else { /* IE */  
			styleObj.removeRule(0);
			styleObj.addRule(".fusion_style","width:"+varImgViewWidth+"%",0);
		}
	}
}
// 뒤로가기 버튼을 눌렀을때 상품 리스레이어 에서 스타일 목록 재 설정
function fashionInit(){
	//뒤로가기때문에 미분류 레이어및 선택된 소분류 처리를 여기서 다시 한번 해준다.
	//alert(varCate);
	//alert(parent.document.getElementById("ismenutype").value);
	if(parent.document.getElementById("ismenutype").value == 'T'){
		parent.goFashionCategory_Spread(varCate,'','Y');
	}else if(parent.document.getElementById("ismenutype").value == 'I'){
		parent.changeCurStyle(varCate,'Y');
	}
}
function goFashionMiddleCate(cate,ismenutype){ 
	// 실서버
	top.location.href = "/fashion/clothes/Clothes_StyleList.jsp?cate="+cate;
}
function smart_cate(cate){
	insertLog(6824);
	if (top.document.getElementById("div_brand_list").style.display != "none"){
		top.document.getElementById("div_brand_list").style.display = "none";
	}else{
		function showBrandLayer(originalRequest){
			top.document.getElementById("div_brand_list").innerHTML = originalRequest.responseText;
			var varAddHeight = 172;
			if (top.document.getElementById("topBannerNew")){
				varAddHeight = varAddHeight + top.document.getElementById("topBannerNew").offsetHeight+1;
			}
			top.document.getElementById("div_brand_list").style.left = (Position.cumulativeOffset(document.getElementById("ul_smart_cate"))[0]+0)+"px";
			top.document.getElementById("div_brand_list").style.top = (Position.cumulativeOffset(document.getElementById("ul_smart_cate"))[1]+varAddHeight)+"px";;
			top.document.getElementById("div_brand_list").style.display = "";
			setTimeout(
				function(){
					top.$("#access_tit_txt_in").html(document.getElementById("access_tit_txt").innerHTML);
					var objli = top.$("#ul_acc_brname > li > a");
					for (var i=0;i<objli.length;i++){
						if (objli[i].innerHTML.trim() == top.document.getElementById("access_tit_txt_in").innerHTML.trim()){
							objli[i].style.color = "#666666";
						}
					}
				}, 100);
			
		}	
		var url = "/include/ajax/AjaxGetBrand.jsp";
		var getBrand = new Ajax.Request(
			url,
			{
				method:'get',onComplete:showBrandLayer
			}
		);	
	}
}
function Cmd_Smart(param_gubun, param_cate){
	document.getElementById("smart_"+param_cate).src = var_img_enuri_com + "/images/view/header_image/2010/tx_"+param_cate+param_gubun+".gif";
}
function showAccNotice(cate){
	location.href = "/view/Listheader_Mp3.jsp?szCmd=&cate="+cate;
	top.accNotice = "Y";	
}
function Cmd_HpSaveBoard(){
	var objOpenerHpSave = window.open("/knowbox/List.jsp?kbcate=kb0&kbcode=kc7","HpSave", "top=0, left=0, channelmode=0, directories=1, fullscreen=0, location=1, menubar=1, resizable=1, scrollbars=1, status=1, titlebar=1, toolbar=1");
	objOpenerHpSave.focus();
	
}
function showSpecMenu(param,sel_spec,islog){
	if (selectedMenu != "spec_menu"){
		initMenu();
		//if (document.getElementById("spec_menu").innerHTML.trim().length >  0 && document.getElementById("spec_menu").style.display == "none"){
		//	document.getElementById("spec_menu").style.display = "";
		//}else{
			if (typeof(sel_spec) != "undefined" && sel_spec != ""){
				insertHideLayer("/layer/IncSpecMenu.jsp","cate="+param.substring(0,4)+"&preview=Y","spec_menu",setTimeout(function(){urlChkSpec(sel_spec)}, 100));
			}else{
				insertHideLayer("/layer/IncSpecMenu.jsp","cate="+param.substring(0,4)+"&preview=Y","spec_menu");
			}
		//}
		if(document.getElementById("spread_menu_btn")){
			document.getElementById("spread_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_openmenu_1_1205.gif";
		}
		if(param =="2115"){
			document.getElementById("spec_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_tirespec_on_1030.gif";
		}else if(param =="1642"){
				document.getElementById("spec_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_PetSupplies_on_1642.gif";
				document.getElementById("spec_menu_btn").style.width = "105px";
		}else{
			document.getElementById("spec_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_specmenu_2_on.gif";
			document.getElementById("spec_menu_btn").style.width = "96px";
		}
		document.getElementById("image_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_onemenu_1_1205.gif";
		if(document.getElementById("brand_menu_btn")){
			document.getElementById("brand_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_brand_off_leftoff_Righton.gif";
		}
		if(document.getElementById("best_menu_btn")){
			document.getElementById("best_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_bestmenu_3.gif";
			document.getElementById("spec_menu_btn").src = var_img_enuri_com + "/2010/images/view/menu/tab_specmenu_13.gif";
			document.getElementById("spec_menu_btn").style.width = "93px";
		}
		if(document.getElementById("spec_menu_btn_lastbanner")){
			document.getElementById("spec_menu_btn_lastbanner").style.margin = "5px 0px 0px 0px";	
		}
		
		
		
		setSpec();   
		//사양선택 줄이기버튼 없애기
		if(param =="0201" || param =="0408" || param =="0702"  || param =="0402" || param =="0908" || param =="0601"  || param =="0513" 
				|| param =="0418" || param =="1007" || param =="1004" || param =="2115"  || param =="2406"  || param =="2403" || param =="0502" 
				|| param =="0241" || param =="0203" || param =="1435" || param =="2405"  || param =="1642" || param =="2402" || param =="0605" || param=="0357"
				|| param == "0503" || param == "0215" || param == "0360"
		){
			CmdSpecHeight(1);
		}else{ 
			CmdSpecHeight(2); 
		}
		selectedMenu = "spec_menu";
		var varIsLog = true;
		if (typeof(islog) != "undefined"){
			varIsLog = islog;
		}
		if (varIsLog){
			insertLogCate(7568,param);
		}
	}
	try{
		if (typeof(sel_spec) == "undefined" ){
			document.getElementById("enuriListFrame").contentWindow.document.getElementById('cate').value = param;
			document.getElementById("enuriListFrame").contentWindow.setSpecInit();
		}
	}catch(e){
	}
	if (selectedMenu != "spec_menu"){
		Cmd_Comment_Hide();
	}
} 
function urlChkSpec(sel_spec){
	var varSelectedSpec = sel_spec.replace(/_/g,'');
	var arrSelectedSpec = varSelectedSpec.split(",");
	for (var i=0;i<arrSelectedSpec.length;i++){
		if (arrSelectedSpec[i] != ""){
			document.getElementById("spec_"+arrSelectedSpec[i]).checked = "checked"
			document.getElementById("spec_li_"+arrSelectedSpec[i]).className = "spec_text_on";
		}	
	}
	//document.getElementById("img_init").style.display = "";
}
function checkSpecName(gpno,gpsNo,specNo,bHide,cate){
	if (document.getElementById('spec_'+specNo).checked){
		document.getElementById('spec_'+specNo).checked=false;
	}else{
		document.getElementById('spec_'+specNo).checked=true;
	}
	checkSpec(gpno,gpsNo,specNo,bHide,cate);	
}
function checkSpec(gpno,gpsNo,specNo,bHide,cate){
	var chkBoxSpec = $("specMenuBody").getElementsBySelector('input[class="spec_chk"]');
	var varBtnShow = false;
	for (var i=0;i<chkBoxSpec.length;i++){
		if (chkBoxSpec[i].checked){
			varBtnShow = true;
		}
	} 
 	if(varBtnShow){  
 		var posLeftTop = Position.cumulativeOffset($("spec_"+specNo));
 		var posLeft = 0;
 		
 		if (posLeftTop[0] < 30){
 			posLeft = posLeftTop[0] + $($("spec_li_"+specNo).parentNode).offsetWidth ;
 		}else{
 			posLeft = posLeftTop[0] - 40;
 		} 
 		var posTop = posLeftTop[1] - 140;
 		var posSpecMenuLeftTop = Position.cumulativeOffset($("spec_menu"));
 		posLeft -= (posSpecMenuLeftTop[0]+10);
 		if ( (posLeft + 15 + posSpecMenuLeftTop[0]) > ( posSpecMenuLeftTop[0] + $("spec_menu").offsetWidth) ){
 			posLeft -= 155;
 		}
 		if (posTop > ($("specMenuBody").offsetHeight + $("specMenuBody").scrollTop - $("specTop").offsetHeight - $("specBottom").offsetHeight)){
 			posTop = ($("specMenuBody").offsetHeight + $("specMenuBody").scrollTop - $("specTop").offsetHeight - $("specBottom").offsetHeight)+10;
 		}
 		
 		document.getElementById("specMenuGo").style.top = posTop + "px";
 		document.getElementById("specMenuGo").style.left = posLeft + "px";
 		//$("img_init").style.display="";
		getSpecSearchCount(cate,getCheckedSpce(),true);
	}else{
 		$("specMenuGo").style.display="none";
 		//$("img_init").style.display="none";
 	}
	if (document.getElementById("spec_"+specNo).checked){
		document.getElementById("spec_li_"+specNo).className = "spec_text_on";
		if (document.getElementById("kbhelpimg_"+specNo)){
			document.getElementById("kbhelpimg_"+specNo).src = var_img_enuri_com+"/2012/list/q_icon_h.png";
		}
	}else{
		document.getElementById("spec_li_"+specNo).className = "spec_text";
		if (document.getElementById("kbhelpimg_"+specNo)){
			document.getElementById("kbhelpimg_"+specNo).src = var_img_enuri_com+"/2012/list/q_icon.png";
		}
	}
	document.getElementById("spec_"+specNo).blur();
	//insertLog(7569);
	insertLogCate(7569,cate_org);
	checkSpec._lastCheck = specNo;
} 
function uncheckSpecAll(){  
	var chkBoxSpec = $("specMenuBody").getElementsBySelector('input[class="spec_chk"]');
	for (var i=0;i<chkBoxSpec.length;i++){
		chkBoxSpec[i].checked = false;
		document.getElementById("spec_li_"+chkBoxSpec[i].value).className = "spec_text";	
	}
	document.getElementById("specMenuGo").style.display = "none";
	//document.getElementById("img_init").style.display = "none";
	document.getElementById("noresult").style.display = "none";
	insertLog(7571); 
	try{
		uncheckSpecAll._click = true;
		countSpecSearch._prevCheckedSpec = "";
		document.getElementById("enuriListFrame").contentWindow.setSpecInit();
	}catch(e){
	}  
}
function directCheckSpec(gpno,gpsNo,specNo,bHide,cate){
	
	uncheckSpecAll();
	document.getElementById("spec_"+specNo).checked = true;
	//checkSpec(gpno,gpsNo,specNo,bHide,cate);
	document.getElementById("spec_li_"+specNo).className = "spec_text_on";
	insertLogCate(10124,cate_org);
	checkSpec._lastCheck = specNo;	
	countSpecSearch(cate);
	//document.getElementById("img_init").style.display = "";
}
function getCheckedSpce(){
	var varPrecgpno = "";
	var varPrecgpsno = "";
	var varSelectedSpec = "";
	var chkBoxSpec = $("specMenuBody").getElementsBySelector('input[class="spec_chk"]');
	
	for (var i=0;i<chkBoxSpec.length;i++){
		if (chkBoxSpec[i].checked){
			var varSpecNo = chkBoxSpec[i].value;
			var varGpno = $("gpno_"+varSpecNo).value;
			var varGpsno = $("gpsno_"+varSpecNo).value;
			var varGpno_Aoflag = $("gpno_aoflag_"+varSpecNo).value;
			var varGpsno_Aoflag = $("gpsno_aoflag_"+varSpecNo).value;
			if ( varGpno_Aoflag == "0"){
				if (varPrecgpno.length > 0 && varGpno != varPrecgpno){
					varSelectedSpec = varSelectedSpec + "_";
				}
				varSelectedSpec = varSelectedSpec + varSpecNo + ",";
				varPrecgpno = varGpno;
			}else if (varGpno_Aoflag == "1"){
				if (varGpsno_Aoflag == "0"){
					if (varPrecgpno.length > 0 && varGpno != varPrecgpno){
						varSelectedSpec = varSelectedSpec + "_";
					}else{						
						if (varPrecgpsno.length > 0 && varGpsno != varPrecgpsno){
							varSelectedSpec = varSelectedSpec + "_";
						}
					}
					varSelectedSpec = varSelectedSpec + varSpecNo + ",";
				}else if (varGpsno_Aoflag == "1"){
					if (varPrecgpno.length > 0 ){
						varSelectedSpec = varSelectedSpec + "_";
					}
					varSelectedSpec = varSelectedSpec + varSpecNo + ",";
				}
				varPrecgpno = varGpno;
				varPrecgpsno = varGpsno; 
			}
		}
	}
	return varSelectedSpec;
}

function countSpecSearch(cate){
	document.getElementById('specMenuGo').style.display='none';
	document.getElementById('noresult').style.display='none';
	var varSpecCount = $("spec_count").innerHTML.stripTags().replace("개","");

	if (varSpecCount.isnumber()){
		var varCheckedSpec = getCheckedSpce();
		if (varCheckedSpec.trim().length > 0 ){
			if (countSpecSearch._prevCheckedSpec != varCheckedSpec ){
				countSpecSearch._prevCheckedSpec = varCheckedSpec;
				getSpecSearchCount(cate,varCheckedSpec,false)
			}
		}
	}else{
		getSpecSearchCount.showNoSpecResult();
	}
	//insertLog(7570);
	insertLogCate(7570,cate_org);
}
function getSpecSearchCount(cate,varCheckedSpec,bCount){
	if (!bCount){
		top.viewInLoadingBar("getSpecSearchCount");
		getSpecSearchCount._cate=cate;
		getSpecSearchCount._varCheckedSpec=varCheckedSpec;
	}
	var url = "/search/GetCountListSpec.jsp";
	var param = "cate="+cate+"&spec=y&sel_spec="+varCheckedSpec;
	var getFactoryInfo = new Ajax.Request(
		url,
		{
			method:'get',parameters:param,onComplete:runSpecSearch
		}
	);
	function runSpecSearch(originalRequest){
		eval("var specResultCnt = " + originalRequest.responseText);
		if (bCount){
			$("specMenuGo").style.display="block";
			if (specResultCnt.count > 0){
				if (specResultCnt.count < 10){
					$("spec_count").style.marginLeft = "13px";
				}else if(specResultCnt.count < 100){
					$("spec_count").style.marginLeft = "9px";
				}else if(specResultCnt.count < 1000){
					$("spec_count").style.marginLeft = "7px";
				}else if(specResultCnt.count < 10000){
					$("spec_count").style.marginLeft = "4px";
				}
				$("spec_count").innerHTML = specResultCnt.count + "<span style='font-family:바탕'>개</span>";
			}else{
				$("spec_count").innerHTML = "없음";
				$("spec_count").style.marginLeft = "11px";
			}
		}else{
			if (specResultCnt.count > 0 ){
				document.getElementById("enuriListFrame").src = "/view/Listbody_Mp3.jsp?"+param;
			}else{
				getSpecSearchCount.showNoSpecResult();
			}			
		}
	}		
	getSpecSearchCount.showNoSpecResult = function (){
		top.hideLoadingBar();
		document.getElementById("noresult").style.left = (document.getElementById("wrap").offsetWidth/2 - 210)+"px";
		document.getElementById("noresult").style.top = "350px";
		document.getElementById("noresult").style.display = "";	
	}
}
function regetSpecSearchCount(){
	getSpecSearchCount(getSpecSearchCount._cate,getSpecSearchCount._varCheckedSpec,false)
}
function Map_spec_close(){
	document.getElementById("specMenuGo").style.display = "none";
}

function setSpec(){ 
	setSpec.rePosSpec = function(){
		var line1_cnt 	= document.getElementById("line1_cnt").value;
		var line2_cnt 	= document.getElementById("line2_cnt").value;
		var group_cnt 	= document.getElementById("group_cnt").value;
		/*
		var line1_width = document.getElementById("line1_width").value;
		var line2_width = document.getElementById("line2_width").value;
		
		 
		var line_width = 0; 
		var line_cnt = 0; 
		var line_marginLeft_1 = 0; 
		var line_marginLeft_2 = 0;
		var line_scroll = 150;
		
		if(document.getElementById("specOpenbtn").src == var_img_enuri_com + "/2010/images/view/menu/btn_open_1114.gif"){
			line_scroll = 160;
		}
		     
		line_marginLeft_1 = (document.getElementById("wrap").offsetWidth-line1_width-line_scroll)/line1_cnt;
		if(line2_cnt > 0){
			line_marginLeft_2 = (document.getElementById("wrap").offsetWidth-line2_width-line_scroll)/line2_cnt;
		}
		for(var i = 0; i < Number(line1_cnt) ; i ++){
			if(line_marginLeft_1 < 0) {
				line_marginLeft_1 = 2;
			}
					
			document.getElementById("spec_blank_"+i).style.marginLeft = line_marginLeft_1 + "px";
	 	}
	 	 
		if(line2_cnt > 0){
			if(line_marginLeft_2 < 0) {
				line_marginLeft_2 = 2;
			}
			
			for(var i = Number(line1_cnt); i < Number(line1_cnt)+Number(line2_cnt) ; i ++){
				document.getElementById("spec_blank_"+i).style.marginLeft = line_marginLeft_2 + "px";
		 	} 
	 	}
	 	for(var ii =1 ; ii < Number(group_cnt)+1; ii++ ){
		 	if(document.getElementById("group_1_"+ii)){
		 		document.getElementById("group_1_"+ii).style.marginLeft = line_marginLeft_1 + "px";
		 	}
	 		if(document.getElementById("group_2_"+ii)){
	 			document.getElementById("group_2_"+ii).style.marginLeft = line_marginLeft_2 + "px";
	 		}
	 	}	
	 	*/
		var specBlankObj = $("line_1").getElementsBySelector('div[class="spec_blank_div_0"]')
		var spWh = 0;
		for(var i = 0; i < specBlankObj.length ; i ++){
			
			spWh += specBlankObj[i].offsetWidth;
	 	}		
		var marW = ( $("specMenuBody").offsetWidth - spWh-24)/(specBlankObj.length-1);
		for (var i=1;i<specBlankObj.length;i++){
			specBlankObj[i].style.marginLeft = marW + "px";
		}								

		
		var line2Selector = new Selector('div.line_2');
		var line2obj = line2Selector.findElements($("spec_menu"));
		
		if (line2obj.length){
			for(var ji=0;ji<line2obj.length;ji++){
				var specBlankObj2 = $(line2obj[ji]).getElementsBySelector('div[class="spec_blank_div_'+(ji+1)+'"]')
				var spWh2 = 0;

				for(var i = 0; i < specBlankObj2.length ; i ++){
					spWh2 += specBlankObj2[i].offsetWidth;
			 	}		
				var mar2W = ( $("specMenuBody").offsetWidth - spWh2-24)/(specBlankObj2.length-1);
				for (var i=1;i<specBlankObj2.length;i++){
					specBlankObj2[i].style.marginLeft = mar2W + "px";
				}								
				
				
				/*
				var spEs2 = $(line2obj[ji]).immediateDescendants()[0].immediateDescendants();
				var spWh2 = 0;
				for (var i=0;i<spEs2.length;i++){
					spWh2 += spEs2[i].offsetWidth;
				}
		
					
				var mar2W = ( $("specMenuBody").offsetWidth - spWh2-24)/(spEs2.length-1);
				for (var i=1;i<spEs2.length;i++){
					spEs2[i].style.marginLeft = mar2W + "px";
				}				
				*/
				

				
				
				/*
				for(var i = Number(line1_cnt); i < Number(line1_cnt)+Number(line2_cnt) ; i ++){
					document.getElementById("spec_blank_"+i).style.marginLeft = mar2W + "px";
			 	}
				*/
				/*
				var spEs2 = $("line_2").immediateDescendants();
				var spWh2 = 0;s
				for (var i=0;i<spEs2.length;i++){
					spWh2 += spEs2[i].offsetWidth;
				}
		
				var mar2W = ($("line_2").offsetWidth - spWh2-24)/4
		
				for(var i = Number(line1_cnt); i < Number(line1_cnt)+Number(line2_cnt) ; i ++){
					document.getElementById("spec_blank_"+i).style.marginLeft = mar2W + "px";
			 	}
			 	*/		
			}
		}
		showLog("marW="+marW);
		showLog("mar2W="+mar2W);
	 	for(var ii =1 ; ii < Number(group_cnt)+1; ii++ ){
		 	if(document.getElementById("group_1_"+ii)){
		 		document.getElementById("group_1_"+ii).style.marginLeft = marW + "px";
		 	}
	 		if(document.getElementById("group_2_"+ii)){
	 			document.getElementById("group_2_"+ii).style.marginLeft = mar2W + "px";
	 		}
	 	}				
	}
	setSpec.rePosSpecMenuGo = function(){
	 	if($("specMenuGo").style.display != "none"){
	 		if (typeof(checkSpec._lastCheck)!= "undefined" && checkSpec._lastCheck != ""){
		 		var goBtn_specNo = checkSpec._lastCheck;
		 		var posLeftTop = Position.cumulativeOffset($("spec_"+goBtn_specNo));
		 		var posLeft = 0;
		 		
		 		if (posLeftTop[0] < 30){
		 			posLeft = posLeftTop[0] + $($("spec_li_"+goBtn_specNo).parentNode).offsetWidth ;
		 		}else{
		 			posLeft = posLeftTop[0] + -45;
		 		} 
		 		var posSpecMenuLeftTop = Position.cumulativeOffset($("spec_menu"));
		 		posLeft -= (posSpecMenuLeftTop[0]+10);
		 		if ( (posLeft + 45 + posSpecMenuLeftTop[0]) > ( posSpecMenuLeftTop[0] + $("spec_menu").offsetWidth) ){
		 			posLeft -= 155;
		 		}
		 		document.getElementById("specMenuGo").style.left = posLeft + "px";
		 	}
	 		 		
		}
		if (document.getElementById("specDiminish")){
			if($("specDiminish").style.display != "none"){
				document.getElementById("specDiminish").style.left = (document.getElementById("specMenuBody").offsetWidth-25)+"px";
			}
		}		
	}
 	setSpec.rePosIe7 = function(){
		if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 7){
			document.getElementById("specMenuBody").style.width = (document.getElementById("spec_menu").offsetWidth)+"px";
			document.getElementById("specMenuBody").style.width = (document.getElementById("spec_menu").offsetWidth-3)+"px";
			
			var groupBox = $("specMenuBody").getElementsBySelector('div[class="group_box"]');
			for (i=0;i<groupBox.length;i++){
				$(groupBox[i]).getElementsBySelector('div[class="group_line"]')[0].style.width = "100%";
				$(groupBox[i]).getElementsBySelector('div[class="group_line"]')[0].style.width = ($(groupBox[i]).offsetWidth-2)+"px"; 
			}		
		} 	
 	}
	document.getElementById("specMenuBody").style.width = (document.getElementById("spec_menu").offsetWidth-3)+"px";
	//if( document.getElementById("specMenuBody").scrollHeight <= 260 && document.getElementById("specMenuBody").offsetHeight <= 260){
	//	CmdSpecHeight(1); //260보다 작을때 스크롤, 버튼 없이
	//}
	setSpec.rePosSpec();
	setSpec.rePosSpecMenuGo();
	setSpec.rePosIe7();
	
}  

function CmdSpecHeight(param){
	var bOpen = true;
	if (typeof(param) != "undefined"){
		if (typeof(CmdSpecHeight._openSt) != "undefined"){
			bOpen = CmdSpecHeight._openSt;
		}else{
			bOpen = true;
		}	
	}else{
		if (typeof(CmdSpecHeight._openSt) != "undefined"){
			bOpen = !CmdSpecHeight._openSt;
		}else{
			bOpen = false;
		}
	}

	if(bOpen){
		document.getElementById("specMenuBody").scrollTop = "0";
		document.getElementById("specMenuBody").style.height = "100%";
		document.getElementById("specMenuBody").style.overflowY="hidden"
		if(param =="1"){
			document.getElementById("specOpenbtn").src = var_img_enuri_com + "/2012/list/specmenu_r_bottom.gif";
			document.getElementById("specOpenbtn").className = "li_3";
			document.getElementById("specMenuBody").style.height = document.getElementById("specMenuBody").offsetHeight+"px";
            document.getElementById("specBottom").style.height = "8px"
            document.getElementById("spec_menu").style.height = (document.getElementById("specTop").offsetHeight + document.getElementById("specMenuBody").offsetHeight + document.getElementById("specBottom").offsetHeight) +"px";
            document.getElementById("specOpenbtn").onclick = function(){
            }          
		}else{
			document.getElementById("specOpenbtn").src = var_img_enuri_com + "/2010/images/view/menu/btn_hide_1114.gif";
			if (document.getElementById("specDiminish")){
				document.getElementById("specDiminish").style.top = (document.getElementById("specMenuBody").scrollHeight/2-33)+"px";
				document.getElementById("specDiminish").style.left = (document.getElementById("specMenuBody").offsetWidth-25)+"px";
				document.getElementById("specDiminish").style.display = "";			
			}
		}
		try{
			document.getElementById("enuriListFrame").contentWindow.hideAllLayer();
		}catch(e){
		}
		CmdSpecHeight._openSt = true;
		//document.getElementById("scrollImg").style.paddingTop = "0px"; 
	}else{
		if (document.getElementById("specDiminish")){ 
			document.getElementById("specDiminish").style.display = "none";
		}
		document.getElementById("specMenuBody").style.height = "260px";
		document.getElementById("specOpenbtn").src = var_img_enuri_com + "/2010/images/view/menu/btn_open_1114.gif";
		if (BrowserDetect.browser == "Chrome"){
			top.document.body.scrollTop = "0px";
		}else{
			top.document.documentElement.scrollTop = "0px";
		}				
		document.getElementById("specMenuBody").style.overflowY="scroll"
		CmdSpecHeight._openSt = false;
		document.getElementById("specMenuBody").scrollTop = document.getElementById("specMenuGo").offsetTop-130; 
		insertLog(7687);
	}
	//setSpec.rePosSpec();
	CmdSpecSlide._direction = false;
	if (typeof(param) == "undefined"){
		insertLog(7573);
	}
}  
/* 
var tid_scroll; 
var x;
var x_height;
var maxx;
var spec_direction = 0;
var spec_count;
*/
function CmdSpecSlide(){ 
	/*
	x  = document.getElementById("specMenuBody").scrollTop;
	x_height  = document.getElementById("specMenuBody").offsetHeight;
	maxx = document.getElementById("specMenuBody").scrollHeight;
	showLog("x="+x);
	showLog("x_height="+x_height);
	showLog("maxx="+maxx);
	showLog("spec_direction="+spec_direction);
	if(spec_direction == 0){
		document.getElementById("scrollImg").style.paddingTop = "40px";
	}else{
		document.getElementById("scrollImg").style.paddingTop = "00px";
	}
	if(spec_count != 1){
		CmdSpecTimer();
	}
	*/
	CmdSpecSlide._nowScrollEvent;
	if (CmdSpecSlide._direction){
 		document.getElementById("scrollImg").style.paddingTop = "0px";
		CmdSpecSlide._direction = false;
		var varScrollTo = document.getElementById("specMenuBody").scrollTop;
		CmdSpecSlide._nowScrollEvent = new Effect.Tween(null, varScrollTo, 0,{ duration: 1.0}, function(p){ $('specMenuBody').scrollTop=p });
	}else{
		document.getElementById("scrollImg").style.paddingTop = "40px";
		CmdSpecSlide._direction = true;
		var varScrollNowPos = document.getElementById("specMenuBody").scrollTop;
		var varScrollTo = document.getElementById("specMenuBody").scrollHeight;
		CmdSpecSlide._nowScrollEvent = new Effect.Tween(null, varScrollNowPos, varScrollTo,{ duration: 1.0}, function(p){ $('specMenuBody').scrollTop=p });
	
	}
}
function CmdSpecScrollFlag(){
	if (CmdSpecSlide._nowScrollEvent){
		CmdSpecSlide._nowScrollEvent.cancel();
	}
}

/*
function CmdSpecTimer(){
	if (spec_direction == 1) {
		if (x == 0) { 
			spec_direction = 0; 
			clearTimeout(tid_scroll);
			spec_count = 0;
		}else{
			document.getElementById("specMenuBody").scrollTop = x - 3;
			x = document.getElementById("specMenuBody").scrollTop;
			if (x+x_height < 0) x = 0;
			tid_scroll = setTimeout("CmdSpecTimer()", 10);
			spec_count = 1;
		} 
	}else if(x != maxx && spec_direction == 0){
		document.getElementById("specMenuBody").scrollTop = x + 3;
		x = document.getElementById("specMenuBody").scrollTop;
		if (x+x_height >= maxx) x = maxx;
		tid_scroll = setTimeout("CmdSpecTimer()", 10);
		spec_count = 1;
	}else{
		clearTimeout(tid_scroll); 
		spec_direction = 1;
		spec_count = 0;
	}   
}
function CmdSpecScrollFlag(){
	if(tid_scroll){
		clearTimeout(tid_scroll);
		spec_count = 0;
	}
}
*/
function showTerms(kb_no,clickedObj){
	document.getElementById("enuriListFrame").contentWindow.hideAllLayer("beginner");
	if (document.getElementById("enuriListFrame").contentWindow.getBeginnerDic._kb_no){
		if (document.getElementById("enuriListFrame").contentWindow.getBeginnerDic._kb_no == kb_no && top.document.getElementById("div_beginnerFrame").style.display !="none" ){
			top.document.getElementById("ifrmBeginnerFrame").src = "/html/etc/Blank.htm";
			top.document.getElementById("div_beginnerFrame").style.display = "none";
			document.getElementById("enuriListFrame").contentWindow.getBeginnerDic._kb_no = "";
			return;
		}
	}
	if (document.getElementById("enuriListFrame").contentWindow.getBeginnerDic._kb_no2){
		if (top.document.getElementById("div_beginnerFrame2").style.display !="none" ){
			top.document.getElementById("ifrmBeginnerFrame2").src = "/html/etc/Blank.htm";
			top.document.getElementById("div_beginnerFrame2").style.display = "none";
			document.getElementById("enuriListFrame").contentWindow.getBeginnerDic._kb_no2 = "";
		}
	}

	var posLeftTop = Position.cumulativeOffset($($(clickedObj).parentNode));
	var posLeft = 0;
	var posTop = posLeftTop[1]+80;	
	posTop -= $("specMenuBody").scrollTop;
	if (clickedObj.tagName == "IMG"){
		posLeft = posLeftTop[0] + $($($(clickedObj).parentNode).parentNode).offsetWidth ;
	}else{
		posLeft = posLeftTop[0] + $($(clickedObj).parentNode).offsetWidth+10;
	}
	if (posLeft > (document.getElementById("wrap").offsetWidth/2+100)){
		if (clickedObj.tagName == "IMG"){
			posLeft -= $($($(clickedObj).parentNode).parentNode).offsetWidth ;
		}else{
			posLeft -= $($(clickedObj).parentNode).offsetWidth-10;
		}	
		posLeft -= 500;
	}
	if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 7){
		posLeft = posLeftTop[0] - 800;
		if (posLeft > (document.getElementById("wrap").offsetWidth/2+100)){
			posLeft -= 600;
		}
	}	
	if (posLeft < 0) {
		posLeft = 20;
	}
	var mileObj = new Date();
	var vartCate = "";
	if (document.getElementById("enuriListFrame").contentWindow.document.getElementById("cate")){
		vartCate = document.getElementById("enuriListFrame").contentWindow.document.getElementById("cate").value
	}else{
		vartCate = cate_org;
	}
	var strUrl = "/include/IncBeginnerDic_2010.jsp?kb_no="+kb_no+"&cate="+vartCate+"&t="+mileObj.getMilliseconds();
	top.document.getElementById("ifrmBeginnerFrame").src = strUrl;
	top.document.getElementById("div_beginnerFrame").style.display = "";
	top.document.getElementById("div_beginnerFrame").style.left = posLeft+"px";
	top.document.getElementById("div_beginnerFrame").style.top = posTop+"px";
	document.getElementById("enuriListFrame").contentWindow.getBeginnerDic._kb_no = kb_no;
	insertLog(7572);
}
function getLeftRight(cate){
	
	if (typeof (getLeftRight._leftRight) == "undefined"){
		
		var varLeftRightTxt = "{'bindings': [{";
		var varReturn = "L";
		var varSCateImg = $("img_menu").getElementsBySelector('img[class="cls_dcate_img"]');
		getLeftRight._leftRight = new Array();
		for (var i=0;i<varSCateImg.length;i++){
			if ((varSCateImg.length - (i+1)) <= 2){
				varReturn = "R";
			}
			getLeftRight._leftRight[varSCateImg[i].id+""]=varReturn;
		}
	}
	
	return getLeftRight._leftRight["dcate_img_"+cate];	

}
function setPositionDCateLayer(cate,varLeftRight,objName){
	if (varLeftRight == ""){
		varLeftRight = getLeftRight(cate);
	}
	document.getElementById(objName).style.display = "";
	document.getElementById(objName+"_pointer").style.display = "";
	//5픽셀 올리기
	if (BrowserDetect.browser == "Explorer" && BrowserDetect.version == 7){
		document.getElementById(objName).style.top = "79px";
		document.getElementById(objName+"_pointer").style.top = "82px";
	}else{
		document.getElementById(objName).style.top = "79px";
		document.getElementById(objName+"_pointer").style.top = "82px";
	}

	var varPosTargetObj = $("dcate_img_"+cate).parentNode;
	L_position1 = document.getElementById("category").offsetWidth - 3;
	L_position2 = Position.cumulativeOffset(varPosTargetObj)[0] -7 + varPosTargetObj.offsetWidth/2 ;
	L_position3 = document.getElementById(objName).offsetWidth;
	if(varLeftRight=="R"){
		/*IE에서 미분류레이어가 오른쪽 영역을 벗어나면 가로폭이 벗어난만큼 적게 잡힘*/
		document.getElementById(objName+"_pointer").style.left = (L_position2)  + "px";
		document.getElementById(objName).style.left =  (L_position2-L_position3)+ "px";
		
		/*다시 한번 위치 잡아서 처리*/
		L_position2 = Position.cumulativeOffset(varPosTargetObj)[0] -7 + varPosTargetObj.offsetWidth/2 ;
		L_position3 = document.getElementById(objName).offsetWidth;		
		
		document.getElementById(objName+"_pointer").style.left = (L_position2-9)  + "px";
		document.getElementById(objName).style.left =  (L_position2-L_position3-9)+ "px";
		
	}else if(varLeftRight=="L"){
		document.getElementById(objName+"_pointer").style.left = (L_position2)  + "px";
		document.getElementById(objName).style.left =  (L_position2+11)+ "px";
	}
	
}
function setScateBlankWidth(){
	
	if (!document.getElementById("img_menu")){
		return;
	}
	if (document.getElementById("img_menu").style.display == "none"){
		return;
	}	
	if (typeof(setScateBlankWidth.varSCateBlank) == "undefined"){
		setScateBlankWidth.varSCateBlank = $("img_menu").getElementsBySelector('div[class="scate_blank"]');
		setScateBlankWidth.varSCateObj = $("img_menu").getElementsBySelector('div[class="img_menu_small"]');
	}
	
	var varAllWidth = 0;
	var varTotWidth = document.getElementById("img_menu").offsetWidth-5;
	for (var i=0;i<setScateBlankWidth.varSCateObj.length;i++){
		varAllWidth += setScateBlankWidth.varSCateObj[i].offsetWidth;
	}
	
	var varBlankWidth = Math.floor((varTotWidth -  varAllWidth)/(setScateBlankWidth.varSCateBlank.length-2));
	for (var i=0;i<setScateBlankWidth.varSCateBlank.length;i++){
		if (i==0 || i == (setScateBlankWidth.varSCateBlank.length-1)){
		    if (varBlankWidth > 5 ){
    			setScateBlankWidth.varSCateBlank[i].style.width = "5px";
    		}else{
    		    setScateBlankWidth.varSCateBlank[i].style.width = "0px";
    		}
		}else if (i == 1 || i == (setScateBlankWidth.varSCateBlank.length-2)){
		    if (varBlankWidth > 5 ){		    
    			setScateBlankWidth.varSCateBlank[i].style.width = (varBlankWidth-5)+"px";
    		}else{
    		    setScateBlankWidth.varSCateBlank[i].style.width = (varBlankWidth)+"px";
    		}
		}else{
			setScateBlankWidth.varSCateBlank[i].style.width = varBlankWidth+"px";
		}
	}
	
}
//var tid_dcate2;
function overScateBlank(){
	if (document.getElementById("dcate_layer_over").style.display != "none"){
	    //clearTimeout(tid_dcate);
	    //clearTimeout(tid_dcate2);
	
		document.getElementById("dcate_layer").style.display = "none";
		document.getElementById("dcate_layer_pointer").style.display = "none";
				
		document.getElementById("dcate_layer_over").style.display = "";
		document.getElementById("dcate_layer_over_pointer").style.display = "";        
	}else{
		if (document.getElementById("dcate_layer").innerHTML != ""){
			document.getElementById("dcate_layer").style.display = "";
			document.getElementById("dcate_layer_pointer").style.display = "";
		}
	}
}
function outScateBlank(){
	tid_dcate2 = setTimeout("Cmd_dcate_layer_hide()", 100);
}
function Cmd_dcate_layer_hide(){
	clearTimeout(tid_dcate);
	clearTimeout(tid_dcate2);
	if (document.getElementById("dcate_layer").innerHTML != ""){
		document.getElementById("dcate_layer").style.display = "";
		document.getElementById("dcate_layer_pointer").style.display = "";
	}
	document.getElementById("dcate_layer_over").style.display = "none";
	document.getElementById("dcate_layer_over_pointer").style.display = "none";	
}
function groupCateOver(cate){
	makeCateLayer(cate,'over');
	CmdColorChange(cate,'over');
	document.getElementById("dcate_layer_over").style.display = "none";
	document.getElementById("dcate_layer_over_pointer").style.display = "none";	
}
function groupCateOut(cate){
	showCateLayer(cate,'out');
	CmdColorChange(cate,'out');
}

var timerCateOut;
function cmdOutCateStart(){
    if (document.getElementById("dcate_layer").innerHTML != "" && document.getElementById("dcate_layer").style.display != "none" && timerCateOut == null){
		timerCateOut = setTimeout("cmdOutCateEnd()", 100);        
    }
	if ((document.getElementById("dcate_layer_over").style.display != "none" || (document.getElementById("dcate_layer_over").style.display == "none" && (showDCateLayer2._blankDcate || isBundleCate(cate_over))) ) && timerCateOut == null){
		timerCateOut = setTimeout("cmdOutCateEnd()", 100);
	}
	if (document.getElementById("spread_menu") && document.getElementById("spread_menu").style.display != "none"){
		timerCateOut = setTimeout("cmdOutCateEnd()", 100);
	}
    if (document.getElementById("dcate_layer").innerHTML == "" && document.getElementById("dcate_layer_over").innerHTML == "" && document.getElementById("dcate_layer").style.display == "none" && document.getElementById("dcate_layer_over").style.display == "none" && timerCateOut == null){
		timerCateOut = setTimeout("cmdOutCateEnd()", 100);        
    }	
}
function cmdOutCateEnd(){
	timerCateOut = null;
	Cmd_OverDcate_Hide();
	Cmd_OverComment_Hide();
}
function cmdOutCateStop(){
	clearTimeout(timerCateOut);
	timerCateOut = null;
}
function Cmd_OverDcate_Hide(){
	if (document.getElementById("dcate_layer").innerHTML != ""){
		document.getElementById("dcate_layer").style.display = "";
		document.getElementById("dcate_layer_pointer").style.display = "";
	}
	document.getElementById("dcate_layer_over").style.display = "none";
	document.getElementById("dcate_layer_over_pointer").style.display = "none";	
}
function Cmd_OverComment_Hide(){
	if (document.getElementById("comment_layer")){
		document.getElementById("comment_layer").style.display = "";
	}	
	if (document.getElementById("comment_layer_over")){
		document.getElementById("comment_layer_over").style.display = "none";
	}
}
function Cmd_Comment_Hide(){
	if (document.getElementById("comment_layer")){
		document.getElementById("comment_layer").innerHTML = "";
		document.getElementById("comment_layer").style.display = "none";
	}
	if (document.getElementById("comment_layer_over")){
		document.getElementById("comment_layer_over").innerHTML = "";
		document.getElementById("comment_layer_over").style.display = "none";
	}
}
function isBundleCate(cate){
    var varReturn = false;
    var varBundelCate= bundle + ",";
	if(varBundelCate.indexOf(cate+",") > 0){
		varReturn = true;
	}    
	return varReturn;
}
/*
function toggleTermDic(){
	var showTermBtn = $("spec_menu").getElementsBySelector('img[class="clsShowTerm"]');
	if (document.getElementById("img_toggleTerm").src.indexOf("_on") >= 0 ){
		document.getElementById("img_toggleTerm").src = var_img_enuri_com + "/2012/list/btn_spec_off.gif" 
		insertLog(10125); 
	}else{
		document.getElementById("img_toggleTerm").src = var_img_enuri_com + "/2012/list/btn_spec_on.gif"
		top.$("ifrmBeginnerFrame").src = "/html/etc/Blank.htm";
		top.$("div_beginnerFrame").style.display = "none";
		document.getElementById("enuriListFrame").contentWindow.getBeginnerDic._kb_no = "";
	}
	for (var i=0;i<showTermBtn.length;i++){
		showTermBtn[i].toggle();
	}
	
}
*/
function isMoblie(){
	var strAgent = navigator.userAgent
	strAgent = strAgent.toLowerCase();	
	var bMobile = false;
    if( (strAgent.indexOf("android") >= 0 && strAgent.indexOf("linux") >= 0 ) || (strAgent.indexOf("iphone") >= 0 && strAgent.indexOf("mac") >= 0) || (strAgent.indexOf("ipad") >= 0 && strAgent.indexOf("mac") >= 0) ){
        bMobile = true;
    }
    return bMobile;
}
