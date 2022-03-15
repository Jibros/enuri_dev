	function OpenMoveLink(OpenFile,names,nWidth,nHeight,ScrollYesNo,ResizeYesNo,LocationYesNo,MenubarYesNo){
		var winsobj = window.open("",names,"width="+nWidth+",height="+nHeight+",toolbar=yes,location="+ LocationYesNo +",directories=no,status=no,scrollbars="+ ScrollYesNo +",resizable="+ ResizeYesNo +",menubar="+MenubarYesNo);
			winsobj.moveTo(20,20);		
			winsobj.location.href=OpenFile;
			
	}
	
	function OpenWindow(OpenFile,names,nWidth,nHeight,ScrollYesNo,ResizeYesNo){
		var winsobj = window.open("",names,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars="+ ScrollYesNo +",resizable="+ ResizeYesNo +",menubar=no");
			winsobj.moveTo(1,1);		
			winsobj.location.href=OpenFile;
			
	}
	
	function OpenWindow_escorw(OpenFile,name,nWidth,nHeight,ScrollYesNo,ResizeYesNo)
	{
		var newWin
		newWin = window.open(OpenFile,name,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars="+ ScrollYesNo +",resizable="+ ResizeYesNo +",menubar=no");
		newWin.focus();
	}
		
	function OpenWindow2(OpenFile,name,nWidth,nHeight,ScrollYesNo,ResizeYesNo){
		var k = window.open("",name,"width="+nWidth+",height="+nHeight+",toolbar=yes,directories=yes,status=yes,location=yes,scrollbars="+ ScrollYesNo +",resizable="+ ResizeYesNo +",menubar=yes");
			k.moveTo(0,0);	
			k.location.href=OpenFile;
	}
	function OpenWindowNo(OpenFile,winname,nWidth,nHeight)
	{
		var newWin
		newWin = window.open(OpenFile,winname,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars=no,resizable=no,menubar=no");
		newWin.focus();
	}
	//'### shwoo 2005.01.24. 에버몰관련
	function OpenWindowEver(OpenFile,name,nWidth,nHeight,ScrollYesNo,ResizeYesNo){
		window.open(OpenFile,name,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars="+ ScrollYesNo +",resizable="+ ResizeYesNo +",menubar=no");
	}

	function BigImgViewDetail(ModelNo)
	{
		Main_OpenWindow('/view/Viewbigimg.jsp?modelno='+ModelNo+'&filefrom=detailmulti','img'+ModelNo+'','500','500','YES','YES',0,0);
	}

	function BigImgView(ModelNo)
	{
		Main_OpenWindow('/view/Viewbigimg.jsp?modelno='+ModelNo+'','img'+ModelNo+'','500','500','YES','YES',0,0);
	}		
	
	//단축보기
	function showHideMallDetail(tmp_id){

		alert('test');
		var more;
		var less;
		more="<img src=" + strUrl + "/images/detail/detail_icon_plus.gif>";
		less="<img src=" + strUrl + "/images/detail/detail_icon_minus.gif>";
		moreName = eval("moreLine_"+tmp_id+".style");
		moreLess = eval("moreLess_"+tmp_id);
		
		if (moreName.display=="none") {
			
			document.getElementById("ShopName_Plus_"+tmp_id).style.display="none";
			document.getElementById("ShopName_Minus_"+tmp_id).style.display="inline";
			moreName.display="inline";
			/*
			moreLess.innerHTML = less;
			alert("열림 : " + moreLess.innerHTML);
			*/
			document.getElementById('IMG_'+tmp_id).src = strUrl + '/images/detail/detail_icon_minus.gif';
		}else {
			document.getElementById("ShopName_Plus_"+tmp_id).style.display="inline";
			document.getElementById("ShopName_Minus_"+tmp_id).style.display="none";
			moreName.display="none";
			/*
			moreLess.innerHTML = more;
			alert("닫힘 : " + moreLess.innerHTML);
			*/
			document.getElementById('IMG_'+tmp_id).src = strUrl + '/images/detail/detail_icon_plus.gif';
		}
	}
	
	//표준보기(+,-)
	function showHideMoreGoods(tmp_id){
		var more;
		var less;
		more="<img src=" + strUrl + "/images/detail/detail_icon_plus.gif REQUIRED_IMG>&nbsp;&nbsp;";
		less="<img src=" + strUrl + "/images/detail/detail_icon_minus.gif REQUIRED_IMG>&nbsp;&nbsp;";
		moreName = eval("moreLine_"+tmp_id+".style");
		moreLess = eval("moreLess_"+tmp_id);
		if (moreLess.innerHTML.match(/plus.gif/g)) {
			document.getElementById("Normal_Plus_"+tmp_id).style.display="none";
			document.getElementById("Normal_Minus_"+tmp_id).style.display="inline";

			moreName.display="none";
			moreLess.innerHTML = less;
			//document.getElementById("VIEW_DETAIL_"+tmp_id).style.padding = "1.5px";
			//document.getElementById("VIEW_DETAIL_"+tmp_id).style.borderWidth='1.5px';
			//document.getElementById("VIEW_DETAIL_"+tmp_id).style.borderColor='#0370CD';
			//document.getElementById("VIEW_DETAIL_"+tmp_id).style.borderStyle='solid';
			//document.getElementById("VIEW_DETAIL_"+tmp_id).style.background = "#F4FBFF";
			document.getElementById("VIEW_DETAIL_"+tmp_id).style.background = "";
		}else {
			document.getElementById("Normal_Plus_"+tmp_id).style.display="inline";
			document.getElementById("Normal_Minus_"+tmp_id).style.display="none";

			moreName.display="inline";
			moreLess.innerHTML = more;
			//document.getElementById("VIEW_DETAIL_"+tmp_id).style.padding = '';
			//document.getElementById("VIEW_DETAIL_"+tmp_id).style.borderWidth='';
			//document.getElementById("VIEW_DETAIL_"+tmp_id).style.borderColor='';
			//document.getElementById("VIEW_DETAIL_"+tmp_id).style.borderStyle='';
			//document.getElementById("VIEW_DETAIL_"+tmp_id).style.background = "";
			document.getElementById("VIEW_DETAIL_"+tmp_id).style.background = "";
		  document.all['ch_color2'].value = "#DEEDF8";		    
		  document.all['total_color'].value = "#ffffff";
		}
	}
	//전체보기(펼쳐보기, 줄여보기)
	function showHideScroll(vcode){
		//document.getElementById('SHOP_SCROLL_'+vcode).runtimeStyle.overflow='hidden';this.innerHTML='줄여보기';
		obj = document.getElementById('SHOP_SCROLL_IMG_'+vcode);
		if(obj.innerHTML.match(/_out.gif/g)){//펼쳐보기
			showScroll(vcode)
			/*
				obj.innerHTML = "<img src=/images/view/butt_in.gif border=0 alt=줄여보기>";
				document.getElementById('SHOP_SCROLL_'+vcode).runtimeStyle.overflow='hidden';
				document.getElementById('SHOP_SCROLL_'+vcode).runtimeStyle.height='100%';
				//eval("document.all.SHOP_LOC_"+vcode).scrollIntoView(true) //펼쳐보기 클릭시 해당 몰영역을 페이지 상단으로 이동 //정재웅과장님이 반영 취소하셨서 주석처리 wookki25 200.11.11
			*/	
		}else{ //줄여보기
			hideScroll(vcode)
			/*
				obj.innerHTML = "<img src=/images/view/butt_out.gif border=0 alt=펼쳐보기>";
				document.getElementById('SHOP_SCROLL_'+vcode).runtimeStyle.overflow='';			
				document.getElementById('SHOP_SCROLL_'+vcode).runtimeStyle.height='';
			*/	
		}
	}
	function showScroll(vcode){
		//document.getElementById('SHOP_SCROLL_IMG_'+vcode).innerHTML = "<img src=/images/view/butt_in.gif border=0 alt=줄여보기>"
		document.getElementById('SHOP_SCROLL_'+vcode).runtimeStyle.overflow='hidden';
		document.getElementById('SHOP_SCROLL_'+vcode).runtimeStyle.height='100%';
		//eval("document.all.SHOP_LOC_"+vcode).scrollIntoView(true) //펼쳐보기 클릭시 해당 몰영역을 페이지 상단으로 이동 //정재웅과장님이 반영 취소하셨서 주석처리 wookki25 200.11.11
	}
	function hideScroll(vcode){
		//document.getElementById('SHOP_SCROLL_IMG_'+vcode).innerHTML = "<img src=/images/view/butt_out.gif border=0 alt=펼쳐보기>"
		document.getElementById('SHOP_SCROLL_'+vcode).runtimeStyle.overflow='';			
		document.getElementById('SHOP_SCROLL_'+vcode).runtimeStyle.height='';
	}
	function showHideScrollAll(IsLeftRight){
		arrAll		= document.getElementsByName("SHOP_SCROLL_ALL_SHOW_HIDE");
		arrEarch	= document.getElementsByName("SHOP_SCROLL");		
		if(arrAll[0].innerHTML.match(/bt_eachallview_d.gif/g)){//펼쳐보기
			for(i=0;i<arrAll.length;i++){
				arrAll[i].innerHTML = "<img src=" + strUrl + "/images/view/bt_eachview.gif border=0 style='cursor:hand;' alt='클릭하면 쇼핑몰별로 스크롤바가\n발생되어 창의 길이가 줄어듭니다.'>";
			}
			for(i=0;i<arrEarch.length;i++){
				showScroll(arrEarch[i].getAttribute("vcode"));
			}
		}else if(arrAll[0].innerHTML.match(/bt_eachview.gif/g)){//줄여보기
			for(i=0;i<arrAll.length;i++){
				arrAll[i].innerHTML = "<img src=" + strUrl + "/images/view/bt_eachallview_d.gif border=0 style='cursor:hand;' alt='클릭하면 쇼핑몰별 스크롤바가\n없어지고 모든 상품명이 펼쳐집니다.'>";
			}
			for(i=0;i<arrEarch.length;i++){
				hideScroll(arrEarch[i].getAttribute("vcode"));
			}	
		}
		if(IsLeftRight == "right"){
			document.all.BottTitleLoc.scrollIntoView(true);
		}
	}
	//자세히보기 풍선말
	function showMallDetailBalloon(tmp_id){

		var more;
		var less;
		
		moreName = eval("Balloon_"+tmp_id+".style");
		if (moreName.display=="none") {
			moreName.display="block";
			//moreName.pixelLeft=event.x - event.offsetX +document.body.scrollLeft-100; 
			moreName.pixelLeft=event.x - event.offsetX +document.body.scrollLeft-230;	
			moreName.pixelTop=event.y  - event.offsetY +document.body.scrollTop+15;
			}else {
			moreName.display="none";
		}
	}
	function SortPosition(sortname)	//정렬 위치 세팅 2003.3 sung35 
	{
		var nLeft,nTop;


		nLeft = event.x - event.offsetX - 4 + document.body.scrollLeft;
		nTop = event.y - event.offsetY + 14 + document.body.scrollTop;
			
	//	alert(sortname)
		eval(sortname+".style").posLeft = nLeft;
		eval(sortname+".style").posTop = nTop;
	}
	
	function SortPositionButton(sortname) //정렬 위치 세팅(이미지) 2003.3 sung35 
	{
		var nLeft,nTop

		nLeft = event.x - event.offsetX - 275 + document.body.scrollLeft;
		nTop = event.y - event.offsetY + 16 + document.body.scrollTop;
			
	//	alert(sortname)
		eval(sortname+".style").posLeft = nLeft;
		eval(sortname+".style").posTop = nTop;
	}

	function CmdMyFavoriteInsertProc(n,m)
	{
		FrmFavoriteProc.modelno.value=n;
		FrmFavoriteProc.shop_vcode.value=m;
		FrmFavoriteProc.target = "ifrmForLogin";
		FrmFavoriteProc.action = "Myfavoriteinsertproc.jsp";
		FrmFavoriteProc.submit();
	}
	function initPos(){
	//	window.moveTo(0,0);
	}
	initPos();
	
	function ShowTipMsgLeft(callDataOpt){
		var msg = "";
		var objMsg = document.getElementById("TipMsgLeft");
			objMsg.style.left = 280;
			objMsg.style.top = 58;
			objMsg.style.height = 90;
			objMsg.style.width = 240;
			objMsg.style.zIndex = 1;
			switch(callDataOpt){
				case "opt_term" : 
					msg	= "* 좌우쇼핑몰 구분: <font color=blue><b>배송료 조건</b></font><br>쇼핑몰의 배송료 정책에 따른 구분입니다.<br>좌측의 배송료 무료 쇼핑몰이며, 우측은 배송료가 조건별 혹은 금액별 유무료인 쇼핑몰입니다." ;  
					break;
				case "opt_term_left" : 
					msg	= "" ;  
					break;
				case "opt_term_right" : 
					msg	= "" ;  
					break;
					
					
				case "opt_scale" : 
					msg	= "* 좌우쇼핑몰 구분: <font color=blue><b>대형몰:일반몰</b></font><br>대형 쇼핑몰과 제조사 직영 쇼핑몰, 에누리&trade;를 통한 매출액등을 기준으로 하여 에누리&trade; 자체적으로 구분한 기준입니다." ;  
					break;
				case "opt_scale_left" : 
					msg	= "" ;  
					break;
				case "opt_scale_right" : 
					msg	= "" ;  
					break;
				case "opt_auth" : 
					msg	= "* 좌우쇼핑몰 구분: <font color=blue><b>정품(인증)</b></font><br>공식 판매 및 유통법인이 직접 인증하는 방식으로의 인증을 받은 쇼핑몰을 기준으로 구분되어 있습니다. 업체 중에는 미확인 쇼핑몰도 포함되어 있습니다." ;  
					break;
				case "opt_auth_left" : 
					msg	= "" ;  
					break;
				case "opt_auth_right" : 
					msg	= "" ;  
					break;
										
//				case "opt_escro" : 
//					msg	= "* 좌우쇼핑몰 구분: <font color=blue><b>안심구매</b></font>" ;  
//					break;
				case "opt_ansim_left" : 
					msg	= "" ;  
					break;
				case "opt_ansim_right" : 
					msg	= "" ;  
					break;
				default :
					msg	= "" ;
					HideTipMsg() ; 
					break;
			}
			objMsg.innerHTML = msg;
			objMsg.style.display = "block";
			
			ShowTipMsgRight();
	}
	
	function HideTipMsg(){
		document.getElementById("TipMsgLeft").style.display = "none";
		document.getElementById("TipMsgRight").style.display = "none";
	}
	function js_replace(str, oldStr, newStr)
	{
		for(var i=0;i<str.length;i++)
		{
			if(str.substring(i, i+oldStr.length) == oldStr)
			{
				str = str.substring(0, i) + newStr + str.substring(i+oldStr.length, str.length)
			}
		}

		return str
	}
	
	// 에버몰 로그인 체크후 주문팝업창 띄우기 by hsw 2004.12.01
	function CmdEverMallMainProc(cmd, sCode, sName, mNo, mName, mFactory, mPrice, multiFlag, iPlNo, sPlGoodsNm, sUrl)	
	{
		//alert("sPlGoodsNm : "+sPlGoodsNm);
		//var k = window.open ("","everWin"+iPlNo+"","width=1010 height=680 scrollbars=yes "); 원래 사이즈
		var k = window.open ("","everWin"+iPlNo+"","width=990 height=680 scrollbars=yes ");
		fmEverProc.cmd.value=cmd;
		fmEverProc.frmshopcode.value=sCode;
		fmEverProc.frmshopnm.value=sName;
		fmEverProc.frmmodelno.value=mNo;
		fmEverProc.frmmodelnm.value=mName;
		fmEverProc.frmfactory.value=mFactory;
		fmEverProc.frmmprice.value=mPrice;
		fmEverProc.frmmultiflag.value=multiFlag;
		fmEverProc.frmpl_no.value=iPlNo;
		fmEverProc.frmpl_goodsnm.value=sPlGoodsNm;
		fmEverProc.frmurl.value= sUrl;
		fmEverProc.target = "everWin"+iPlNo;
		fmEverProc.action = "/evermall/Everordermain.jsp";
		
		fmEverProc.submit();
		return;
	}
	
						
	function altDesc(obj){
		var strTbl ="\
			<table cellpadding=1 cellspacing=0 style='background-color:#FEFFCB;border:1 solid #000000;'>\
			<tr>\
				<td style=font-size:9pt;>"+ obj.getAttribute("deliveryDesc") +" <span style=font-size:9pt;text-align:right;cursor:hand; onClick=altDelivery.style.display='none'>[닫기]</span></td>\
			</tr>\
			</table>"
		altDelivery.style.top = event.y + document.body.scrollTop +5
		altDelivery.style.left = event.x + document.body.scrollLeft + 10
		altDelivery.innerHTML = strTbl
		altDelivery.style.display="inline"
	}
	
// 브라우저 종류와 버전 체크하는 객체 생성자 함수
function objDetectBrowser() {
  var strUA, s, i;
  this.isIE = false;  // 인터넷 익스플로러인지를 나타내는 속성
  this.isNS = false;  // 넷스케이프인지를 나타내는 속성
  this.version = null; // 브라우저 버전을 나타내는 속성
  // Agent 정보를 담고 있는 문자열.
  // 이 값이 궁금한 사람은 alert 문을 이용하여 strUA 값을 확인하기 바란다!
  strUA = navigator.userAgent; 
 
  s = "MSIE";
  // Agent 문자열(strUA) "MSIE"란 문자열이 들어 있는지 체크
  if ((i = strUA.indexOf(s)) >= 0) {
    this.isIE = true;
    // 변수 i에는 strUA 문자열 중 MSIE가 시작된 위치 값이 들어있고,
    // s.length는 MSIE의 길이 즉, 4가 들어 있다.
    // strUA.substr(i + s.length)를 하면 strUA 문자열 중 MSIE 다음에 
    // 나오는 문자열을 잘라온다.
    // 그 문자열을 parseFloat()로 변환하면 버전을 알아낼 수 있다.
    this.version = parseFloat(strUA.substr(i + s.length));
    return;
  }
 
  s = "Netscape6/";
  // Agent 문자열(strUA) "Netscape6/"이란 문자열이 들어 있는지 체크
  if ((i = strUA.indexOf(s)) >= 0) {
    this.isNS = true;
    this.version = parseFloat(strUA.substr(i + s.length));
    return;
  }
 
  // 다른 "Gecko" 브라우저는 NS 6.1로 취급.
 
  s = "Gecko";
  if ((i = strUA.indexOf(s)) >= 0) {
    this.isNS = true;
    this.version = 6.1;
    return;
  }
}

var objDetectBrowser = new objDetectBrowser();

// 현재 활성화된 버튼을 추적하기 위한 전역 변수.
var gvActiveButton = null;

// 버튼이 아닌 다른 곳에 마우스를 클릭하면 활성화된 버튼을 비활성화로 변경.

if (objDetectBrowser.isIE)
  document.onmousedown = mousedownPage;
if (objDetectBrowser.isNS)
  document.addEventListener("mousedown", mousedownPage, true);

function mousedownPage(event) {

  var objElement;

  // 활성화된 버튼이 없으면 밖으로 빠져 나감.
  if (!gvActiveButton)
    return;

  // 현재 선택된 객체 요소를 얻어 옴.
  if (objDetectBrowser.isIE)
    objElement = window.event.srcElement;
  if (objDetectBrowser.isNS)
    objElement = (event.target.className ? event.target : event.target.parentNode);

	

  // 만일 현재 활성화된 버튼을 클릭했다면 그냥 밖으로 빠져 나감.
  if (objElement == gvActiveButton)
    return;

  // 만일 클릭한 요소가 메뉴 버튼, 메뉴 아이템 등이 아니면 활성화된 메뉴를 비활성화 시킴.
  
  if (objElement.className != "menuButton"  && objElement.className != "menuItem" && objElement.className != "menuItem2" &&
      objElement.className != "menuItemSep" && objElement.className != "menu")
    resetButton(gvActiveButton);
  
}

function mouseoverButton(objMnuButton, strMenuName) {

  // 만일 다른 메뉴 버튼이 활성화되어 있다면 비활성화 시킨 후
  // 현재 마우스 오버된 메뉴를 활성화 시킨다.

  if (gvActiveButton && gvActiveButton != objMnuButton) {
    resetButton(gvActiveButton);
    
  if (strMenuName)
    clickButton(objMnuButton, strMenuName);
  }
}

function clickButton(objMnuButton, strMenuName) {

  // 링크 주변의 아웃라인을 없앰.
  objMnuButton.blur();
  
  // 이 메뉴 버튼에 하위 풀다운 메뉴 객체를 관장할
  // menu 란 이름의 객체 생성
  if (!objMnuButton.menu)
    objMnuButton.menu = document.getElementById(strMenuName);


  // 현재 활성화된 메뉴 버튼을 처음 상태로 되돌림.
  if (gvActiveButton && gvActiveButton != objMnuButton)
      resetButton(gvActiveButton);	
	
   
  

  // 메뉴 버튼 활성화 여부에 따라 활성화/비활성화 토글.
  if (gvActiveButton)
    resetButton(objMnuButton);
  else
    pulldownMenu(objMnuButton);

  return false;
}

function pulldownMenu(objMnuButton) {

  // 현재 선택된 객체의 클래스를 "활성화" 클래스로 변경
  objMnuButton.className = "menuButtonActive";
  
  // 익스플로러의 경우, 첫 번째 메뉴 아이템에 대한 명확한 폭을 명시해 주도록 한다.
  // 만일 이 부분을 설정하지 않으면 마우스로 메뉴 아이템 오버시 텍스트 위에 올려놓을 때만
  // 반전된다. 만일 텍스트가 아닌 메뉴 아이템 영역 위로만 갖다 놔도 반전시키려면
  // 이 부분을 설정해 줘야 한다.
  if (objDetectBrowser.isIE && !objMnuButton.menu.firstChild.style.width) {
    objMnuButton.menu.firstChild.style.width = objMnuButton.menu.firstChild.offsetWidth + "px";
  }
  
  // 브라우저마다 각자 환경에 맞는 드롭 다운 메뉴의 위치를 
  // 결정해 줘야 한다.
  x = objMnuButton.offsetLeft;
  y = objMnuButton.offsetTop + objMnuButton.offsetHeight;
  if (objDetectBrowser.isIE) {
    x += -1;
    y += 1;
  }
  if (objDetectBrowser.isNS && objDetectBrowser.version < 6.1)
    y--;

  // 위치 결정 및 풀다운 메뉴를 보여줌

  objMnuButton.menu.style.left = x + "px";
  objMnuButton.menu.style.top  = y + "px";
  objMnuButton.menu.style.visibility = "visible";
  
  // 현재 활성화된 메뉴 객체를 저장하는 전역변수 gvActiveButon에
  // 현재 선택된 메뉴 객체를 설정
  gvActiveButton = objMnuButton;
}

function resetButton(objMnuButton) {

  // 원래 스타일로 되돌림
  objMnuButton.className = "menuButton";

  // 펼쳐진 풀다운 메뉴를 감춰줌
  if (objMnuButton.menu)
    objMnuButton.menu.style.visibility = "hidden";

  // 현재 활성화된 메뉴 버튼이 없는 것으로 설정
  gvActiveButton = null;
}

function resetButton2(obj) {

  // 원래 스타일로 되돌림
  //obj.className = "menuButton";

  
    obj.style.display = "none";

  // 현재 활성화된 메뉴 버튼이 없는 것으로 설정
  gvActiveButton = null;
}



function CmdMouseOver(Obj,n)
{
	if(n==1)//onmouseover
	{
		Obj.style.backgroundColor="#08246B";
		Obj.style.color="#FFFFFF";
	}
	else
	{
		Obj.style.backgroundColor="#FFFFFF";
		Obj.style.color="#000000";
	}
}
function moveTopLeft(){
	try{	
		window.moveTo(0,0); 
	}catch(e){
		//alert(e);
		return false;
	}
}

function replace2(src, delWrd){
	var newSrc;
		newSrc = "";
	var i;
	for(i=0;i<src.length;i++){
		if (src.charAt(i) == "-" || src.charAt(i) == ","){
			newSrc = newSrc + " ";
		}else{
			if(src.charAt(i) == delWrd) {
			}else{
				newSrc = newSrc + src.charAt(i);
			}
		}
	}
	return newSrc;
}

function fnGoSearch(){
	var schWrd;
	schWrd = document.formSearch.keyword.value;
	
	var newStc = "";
	
	for(i=0;i<schWrd.length;i++)
	{
		if (schWrd.charAt(i) == "(")
		{
			for(j=i+1;j<schWrd.length;j++)
			{
  			if(schWrd.charAt(j) == ")")
  			{
  				i = j+1;	
  				break;
  			}
			}
			newStc = newStc + schWrd.charAt(i);
		}
		else
		{
			newStc = newStc + schWrd.charAt(i);
		}
	}

	schWrd = newStc;
	document.formSearch.detailkeyword.value = schWrd;	
		
	schWrd = replace2(schWrd, "`");
	schWrd = replace2(schWrd, "~");
	schWrd = replace2(schWrd, "!");
	schWrd = replace2(schWrd, "@");
	schWrd = replace2(schWrd, "#");
	schWrd = replace2(schWrd, "$");
	schWrd = replace2(schWrd, "%");
	schWrd = replace2(schWrd, "^");
	schWrd = replace2(schWrd, "&");
	schWrd = replace2(schWrd, "*");
	schWrd = replace2(schWrd, "+");
	schWrd = replace2(schWrd, "=");
	schWrd = replace2(schWrd, "|");
	schWrd = replace2(schWrd, "\\");
	schWrd = replace2(schWrd, "{");
	schWrd = replace2(schWrd, "}");
	schWrd = replace2(schWrd, "[");
	schWrd = replace2(schWrd, "]");
	schWrd = replace2(schWrd, ":");
	schWrd = replace2(schWrd, ";");
	schWrd = replace2(schWrd, "\"");
	schWrd = replace2(schWrd, "<");
	schWrd = replace2(schWrd, ">");
	schWrd = replace2(schWrd, ".");
	schWrd = replace2(schWrd, ",");
	schWrd = replace2(schWrd, "?");
	schWrd = replace2(schWrd, "/");
	schWrd = replace2(schWrd, "(");
	schWrd = replace2(schWrd, ")");
	schWrd = replace2(schWrd, "'");
	schWrd = replace2(schWrd, "_");
	schWrd = replace2(schWrd, "-");

	document.formSearch.keyword.value = schWrd;
}

function fnSaveValueDesc(chk1, disVal, gubun, chk2)
{
	if(gubun == 'over')
	{
    var col = document.all.tags("span");
						        
	  if(col != null)
	  {
	 		for(i=0; i<col.length; i++)
			{
				if(col[i].getAttribute(chk1) != null)
			  {
			  	col[i].style.display = 'none';
			 	}  	
				if(col[i].getAttribute(chk2) != null)
			  {
			  	col[i].style.display = 'inline';
			 	}  	
		 	}
		}
		
  	arrAll = document.getElementsByName(chk2);
  	for(i=0;i<arrAll.length;i++)
  	{
  		arrAll[i].innerHTML = "<font style='height:24;border:1px solid black;padding-top:5;background-color:#FFFFCC;'>" + disVal + "</font>"
  	}		
	}
	else
	{
    var col = document.all.tags("span");
						        
	  if(col != null)
	  {
	 		for(i=0; i<col.length; i++)
			{
				if(col[i].getAttribute(chk2) != null)
			  {
			  	col[i].style.display = 'none';
			 	}  	
				if(col[i].getAttribute(chk1) != null)
			  {
			  	col[i].style.display = 'inline';
			 	}  	
		 	}
		}		
	}
}	

