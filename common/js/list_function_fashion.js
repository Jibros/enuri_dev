/*
************************************************
------------List.jsp에서 뺀 Script-------------
************************************************
*/
var ImageServer = "http://img.enuri.com";
//브라우저 종류와 버전 체크하는 객체 생성자 함수
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

//현재 활성화된 버튼을 추적하기 위한 전역 변수.
var gvActiveButton = null;

//버튼이 아닌 다른 곳에 마우스를 클릭하면 활성화된 버튼을 비활성화로 변경.

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
function OpenWindow(OpenFile,name,nWidth,nHeight,ScrollYesNo,ResizeYesNo)
{
	var newWin = window.open(OpenFile,name,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars="+ ScrollYesNo +",resizable="+ ResizeYesNo +",menubar=no");
		newWin.focus();
}
function OpenWindowYes(OpenFile,winname,nWidth,nHeight)
{
	var newWin = window.open(OpenFile,winname,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");
		newWin.focus();
}
function OpenWindowNo(OpenFile,winname,nWidth,nHeight)
{
	var newWin = window.open(OpenFile,winname,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars=no,resizable=no,menubar=no");
		newWin.focus();
}
function OpenWindowPosition(OpenFile,name,nWidth,nHeight,ScrollYesNo,ResizeYesNo,lleft,ttop)
{
	var newWin = window.open(OpenFile,name,"width="+nWidth+",height="+nHeight+",left="+lleft+",top="+ttop+",toolbar=no,directories=no,status=no,scrollbars="+ ScrollYesNo +",resizable="+ ResizeYesNo +",menubar=no");
		newWin.focus();
}	
function fnGetCount(param)
{	
	try{		
		if ( param > 0 ) {
			document.frmList.keyword.value = document.frmCount.keyword.value;
			document.frmList.page.value = '';
			document.frmList.search.value = 'YES';
			document.frmList.cmdChg.value = 'YES';				
			document.frmList.submit();
		}
		else {			
			alert("입력하신 검색어에 대한 상품 정보가 없습니다.      \n \n검색어의 일부만 입력하여 다시 검색해보세요.");
			document.frmCount.keyword.select();
			return false;
			//OpenWindowPosition('/Search/NoInSearch_popup1.asp','towcheck','355','150','NO','NO','450','450')			
		}	
		/*
		document.frmList.keyword.value = document.frmCount.keyword.value;
		document.frmList.page.value = '';
		document.frmList.search.value = 'YES';
		document.frmList.cmdChg.value = 'YES';				
		document.frmList.submit();
		*/
	}
	catch(e)
	{ 
		window.status ="해당 카테고리를 다시 선택하십시오.";	
	}
	
}
function fnGetCountBySearchKeyWord(param)
{	
	try{		
		if ( param > 0 ) {
			document.frmList.keyword.value = document.frmCount.keyword.value;
			document.frmList.page.value = '';
			document.frmList.search.value = 'YES';
			document.frmList.cmdChg.value = 'YES';				
			document.frmCount.keyword.value = "";
			document.frmList.submit();
		}
		else {			
			alert("입력하신 검색어에 대한 상품 정보가 없습니다.      \n \n키워드 선택 수를 줄여서 다시 검색해보세요.");
			document.frmCount.keyword.value = '';
			document.frmCount.keyword.style.color='#FF0000';
			return false;
			//OpenWindowPosition('/Search/NoInSearch_popup1.asp','towcheck','355','150','NO','NO','450','450')			
		}	
		/*
		document.frmList.keyword.value = document.frmCount.keyword.value;
		document.frmList.page.value = '';
		document.frmList.search.value = 'YES';
		document.frmList.cmdChg.value = 'YES';				
		document.frmList.submit();
		*/
	}
	catch(e)
	{ 
		window.status ="해당 카테고리를 다시 선택하십시오.";	
	}
	
}	
function SaveChecked(seqno)
{	

	var i, j;
	var strSaveChk, strTmpSaveChk;
	var astrSaveChk;
	var strDelModelno;
	var maxCompareNo=5;
	strSaveChk = frmList.chk_modelno.value;
	
	if (frmCompare.length > 1)
	{
		
		if (frmCompare.compare_chk[seqno].checked == true)
		{
			if (strSaveChk == "") 
				strSaveChk = frmCompare.compare_chk[seqno].value;
			else 
				strSaveChk = strSaveChk +","+ frmCompare.compare_chk[seqno].value;
			
			// 3개 까지만
			astrSaveChk = strSaveChk.split(",");
			j = astrSaveChk.length;
			
			if ( j > maxCompareNo)
			{
				// uchecked
				for( i=0; i<frmCompare.compare_chk.length ; i++)
				{
					if(frmCompare.compare_chk[i].value == astrSaveChk[0]) 
						frmCompare.compare_chk[i].checked = false;
				}
				// save
				strTmpSaveChk = "";
				for(i=1;i<=maxCompareNo;i++)
				{
					if(strTmpSaveChk.length==0)	
					{	strTmpSaveChk= astrSaveChk[i];	}
					else
					{   strTmpSaveChk = strTmpSaveChk + "," + astrSaveChk[i];	}
				}	
				
				strSaveChk = strTmpSaveChk;
			}
			
		}
		else
		{
			astrSaveChk = strSaveChk.split(",");
			strDelModelno = frmCompare.compare_chk[seqno].value;
			j = astrSaveChk.length;
			strTmpSaveChk = "";
			for ( i=0; i < j; i++)
			{
				if (strDelModelno != astrSaveChk[i])
				{
					if (strTmpSaveChk == "" || i == 0) 
					{	strTmpSaveChk = astrSaveChk[i];	}
					else 
					{	strTmpSaveChk = strTmpSaveChk +","+ astrSaveChk[i];	}
				}
			}
			strSaveChk = strTmpSaveChk;
		}

		frmList.chk_modelno.value = strSaveChk;
	} else {
	
		frmList.chk_modelno.value = frmCompare.compare_chk.value;
	}
	
	// form save
	//window.status = strSaveChk;
	//alert(frmList.chk_modelno.value);
	
}	


function CalcListEtcMenu(intMoveLeft, intMoveTop)
{ 
	wndListEtcMenu.style.posLeft = event.x - event.offsetX + document.body.scrollLeft + intMoveLeft * 1;
	wndListEtcMenu.style.posTop = event.y - event.offsetY + document.body.scrollTop + intMoveTop * 1 + 16 ;
} 
function OpenListEtcMenu(intTableW, intRowCnt, strPart)
{ 
	var text, str;
	var intTbWidth, intLaHeight, intLaWidth;
	str = document.frmTmpEtc.ListEtc.value;;
	if (str != "")
	{
		intTableW = intTableW * 1 - 2 + 18;
		intRowCnt = intRowCnt * 1;
		
		if (strPart == "factory")
		{
			if (intRowCnt > 10)
			{
				intTbWidth = intTableW - 16;
				intLaWidth = intTableW + 2;
				intLaHeight = 283;
			}
			else
			{
				intTbWidth = intTableW;
				intLaWidth = intTableW + 2;
				intLaHeight = intRowCnt * 20 + 130;
			}
		}
		else if (strPart == "sort")
		{
			intTbWidth = intTableW;
			intLaWidth = intTableW + 2;
			intLaHeight = 126;
			if(bIsKnowboxService == "1") intLaHeight += 20;
		}
		// sung35 신규상품군 인기상품 제외 처리 2004.1.26
		else if (strPart == "sort_etc")
		{
			intTbWidth = intTableW;
			intLaWidth = intTableW + 2;
			intLaHeight = 113;
		}
		else if (strPart == "listcnt")
		{
			intTbWidth = intTableW;
			intLaWidth = intTableW + 2;
			intLaHeight = 142;
		//	intLaHeight = 95;
		}
		else if (strPart == "srchCategory")
		{			
			if (intRowCnt > 10)
			{
				intTbWidth = intTableW - 16;
				intLaWidth = intTableW + 2;
				intLaHeight = 330;
			}
			else
			{
				intTbWidth = intTableW;
				intLaWidth = intTableW + 2;
				intLaHeight = intRowCnt * 20 + 90;
			}			
		}
		else if ( strPart == "srchKOrder")
		{
				intTbWidth = intTableW - 16;
				intLaWidth = intTableW + 2;
				intLaHeight = 65;
		}
		else
		{
			intTbWidth = 10;
			intLaHeight = 10;
			intLaWidth = 10;
		}
		wndListEtcMenu.style.width = intLaWidth;
		wndListEtcMenu.style.height = intLaHeight;
		
		text = '<table align=left width="'+ intTbWidth +'" height=100% border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" style="font-size:9pt; border-width:0; border-color:#7F9DB9; border-style:solid;">';
		text += '<tr><td>' + str + '</td></tr></table>';
		
	
		wndListEtcMenu.style.borderColor = "#7F9DB9";
		
		wndListEtcMenu.innerHTML=text ;
		ShowListEtcMenu();
	}
	// hide layer x, y
	intSavePageX = intPageX;
	intSavePageY = intPageY;

	intWndWidth = wndListEtcMenu.style.width;
	intWndHeight = wndListEtcMenu.style.height;
	intWndWidth = intWndWidth.replace("px","") * 1 + 50;
	intWndHeight = intWndHeight.replace("px","") * 1 + 50;
	
	//window.status = "intSavePageX:"+intSavePageX+", intSavePageX:"+intSavePageX;
} 
function HideListEtcMenu()
{ 
	wndListEtcMenu.style.borderColor = "#FFFFFF";
	wndListEtcMenu.style.visibility = "hidden";
	fEtcMenu = "false";
} 
function ShowListEtcMenu()
{ 
	wndListEtcMenu.style.visibility = "visible";
	fEtcMenu = "true";
}
function TdMiceOut(obj)
{
	obj.color="#000000";
	obj.backgroundColor="#FFFFFF";
}
function TdMiceOver(obj)
{
	obj.color="#FFFFFF";
	obj.backgroundColor="#08246B";
}


function OneFactorySubmit(theForm, intIndexOf)
{	
	frmList.bFactoryBtnClick.value=true;
	document.getElementById("FactoryChk_"+intIndexOf).checked=true;
	frmList.page.value="";
	frmList.factory.value=document.getElementById("FactoryChk_"+intIndexOf).value;
	submitList(ConstServer+"/view/fashion/Fashion_Sub.jsp");

}
function OneFactorySubmitHandPhone(theForm, intIndexOf)
{	
	frmList.bFactoryBtnClick.value=true;
	document.getElementById("FactoryChk_"+intIndexOf).checked=true;
	frmList.page.value="";
	frmList.factory.value=document.getElementById("FactoryChk_"+intIndexOf).value;
	submitList(ConstServer+"/view/Listhandphone.jsp");
}
function OneFactorySubmitMP3(theForm, intIndexOf)
{	
	frmList.bFactoryBtnClick.value=true;
	document.getElementById("FactoryChk_"+intIndexOf).checked=true;
	frmList.page.value="";
	frmList.factory.value=document.getElementById("FactoryChk_"+intIndexOf).value;
	submitList(ConstServer+"/view/Listmp3.jsp");

}
function MutliFactorySubmit(theForm, intMaxIndexOf)
{
	var k;
	var isChked;
	var strSelectFactory;
	
	isChked = false;
	strSelectFactory = "";
	for(k=0; k<frmCount.FactoryChk.length; k++)
	{
		frmList.factory.value = "";
		if(frmCount.FactoryChk[k].checked == true)
		{
			isChked = true;
			if (strSelectFactory != "")
			{
				strSelectFactory = strSelectFactory + ",";
			}
			strSelectFactory = strSelectFactory + frmCount.FactoryChk[k].value;
		}
	}
	if(isChked == true)
	{
		frmList.page.value="";
		frmList.factory.value = strSelectFactory;
		frmList.bFactoryBtnClick.value=true;
		submitList(ConstServer+"/view/fashion/Fashion_Sub.jsp");
	}
	else
	{
		alert("2개 이상의 제조사를 체크하신 후 클릭하세요.");
	}
}
function MutliFactorySubmitHandPhone(theForm, intMaxIndexOf)
{
	var k;
	var isChked;
	var strSelectFactory;
	
	isChked = false;
	strSelectFactory = "";
	for(k=0; k<frmCount.FactoryChk.length; k++)
	{
		frmList.factory.value = "";
		if(frmCount.FactoryChk[k].checked == true)
		{
			isChked = true;
			if (strSelectFactory != "")
			{
				strSelectFactory = strSelectFactory + ",";
			}
			strSelectFactory = strSelectFactory + frmCount.FactoryChk[k].value;
		}
	}
	if(isChked == true)
	{
		frmList.page.value="";
		frmList.factory.value = strSelectFactory;
		frmList.bFactoryBtnClick.value=true;
		submitList(ConstServer+"/view/Listhandphone.jsp");
	}
	else
	{
		alert("2개 이상의 제조사를 체크하신 후 클릭하세요.");
	}
}
function MutliFactorySubmitMP3(theForm, intMaxIndexOf)
{
	var k;
	var isChked;
	var strSelectFactory;
	
	isChked = false;
	strSelectFactory = "";
	for(k=0; k<frmCount.FactoryChk.length; k++)
	{
		frmList.factory.value = "";
		if(frmCount.FactoryChk[k].checked == true)
		{
			isChked = true;
			if (strSelectFactory != "")
			{
				strSelectFactory = strSelectFactory + ",";
			}
			strSelectFactory = strSelectFactory + frmCount.FactoryChk[k].value;
		}
	}
	if(isChked == true)
	{
		frmList.page.value="";
		frmList.factory.value = strSelectFactory;
		frmList.bFactoryBtnClick.value=true;
		submitList(ConstServer+"/view/Listmp3.jsp");
	}
	else
	{
		alert("2개 이상의 제조사를 체크하신 후 클릭하세요.");
	}
}
function OnePriceSubmit(price)
{	
	frmList.page.value="";
	frmList.m_price.value=price;
	frmList.key.value="mmprice";	
	submitList(ConstServer+"/view/fashion/Fashion_Sub.jsp");
	
}
function checkPriceRange()
{
	var checkedK = -1;
	for(k=0; k<frmCount.chk_price.length; k++)
	{
		frmList.m_price.value = "";
		if(frmCount.chk_price[k].checked == true)
		{
			if (checkedK == -1)
			{
				checkedK = k
			}
			else
			{
				if (( checkedK+1) != k)
				{
					alert("쇼핑몰 검색에서 가격대 검색은 연속된 가격대 검색만 할수 있습니다");
					frmCount.chk_price[k].checked = false;
				}
				else
				{
					checkedK = k;
				}
			}
		}
	}	
}
function MutliPriceSubmitWebList(theForm, intMaxIndexOf)
{
	var k;
	var isChked;
	var strStartPrice;
	var strEndPrice;
	
	isChked = false;
	strStartPrice = "";
	strEndPrice = "";
	for(k=0; k<frmCount.chk_price.length; k++)
	{
		frmList.m_price.value = "";
		if(frmCount.chk_price[k].checked == true)
		{
			isChked = true;
			if (strStartPrice != "")
			{
				strStartPrice = frmCount.chk_price[k].value.split(",")[0];
			}
			else
			{
				strEndPrice = frmCount.chk_price[k].value.split(",")[1];
			}
		}
	}
	if(isChked == true)
	{
		frmList.page.value="";
		frmList.m_price.value = strStartPrice+","+strEndPrice;
		frmList.key.value="mmprice";	
		submitList(ConstServer+"/view/fashion/Fashion_Sub.jsp");
	}
	else
	{
		alert("2개 이상의 가격을 체크하신 후 클릭하세요.");
	}
}
function MutliPriceSubmit(theForm, intMaxIndexOf)
{
	var k;
	var isChked;
	var strSelectPrice;
	
	isChked = false;
	strSelectPrice = "";
	for(k=0; k<frmCount.chk_price.length; k++)
	{
		frmList.m_price.value = "";
		if(frmCount.chk_price[k].checked == true)
		{
			isChked = true;
			if (strSelectPrice != "")
			{
				strSelectPrice = strSelectPrice + "_";
			}
			strSelectPrice = strSelectPrice + frmCount.chk_price[k].value;
		}
	}
	if(isChked == true)
	{
		frmList.page.value="";
		frmList.m_price.value = strSelectPrice;
		frmList.key.value="mmprice";	
		submitList(ConstServer+"/view/fashion/Fashion_Sub.jsp");
	}
	else
	{
		alert("2개 이상의 가격을 체크하신 후 클릭하세요.");
	}
}
function MutliPriceSubmitHandPhone(theForm, intMaxIndexOf)
{
	var k;
	var isChked;
	var strSelectPrice;
	
	isChked = false;
	strSelectPrice = "";
	for(k=0; k<frmCount.chk_price.length; k++)
	{
		frmList.m_price.value = "";
		if(frmCount.chk_price[k].checked == true)
		{
			isChked = true;
			if (strSelectPrice != "")
			{
				strSelectPrice = strSelectPrice + "_";
			}
			strSelectPrice = strSelectPrice + frmCount.chk_price[k].value;
		}
	}
	if(isChked == true)
	{
		frmList.page.value="";
		frmList.m_price.value = strSelectPrice;
		frmList.key.value="mmprice";	
		submitList(ConstServer+"/view/Listhandphone.jsp");
	}
	else
	{
		alert("2개 이상의 가격을 체크하신 후 클릭하세요.");
	}
}
function MutliPriceSubmitMP3(theForm, intMaxIndexOf)
{
	var k;
	var isChked;
	var strSelectPrice;
	
	isChked = false;
	strSelectPrice = "";
	for(k=0; k<frmCount.chk_price.length; k++)
	{
		frmList.m_price.value = "";
		if(frmCount.chk_price[k].checked == true)
		{
			isChked = true;
			if (strSelectPrice != "")
			{
				strSelectPrice = strSelectPrice + "_";
			}
			strSelectPrice = strSelectPrice + frmCount.chk_price[k].value;
		}
	}
	if(isChked == true)
	{
		frmList.page.value="";
		frmList.m_price.value = strSelectPrice;
		frmList.key.value="mmprice";	
		submitList(ConstServer+"/view/Listmp3.jsp");
	}
	else
	{
		alert("2개 이상의 가격을 체크하신 후 클릭하세요.");
	}
}
function chk(frm)
{

	if ((event.button==2) || (event.button==3)) 
	{
		document.all("tipNote").innerHTML = "<table bgcolor='#eee8aa' cellpadding='0' cellspacing='0' border='1' bordercolorlight='black' bordercolordark='white'><tr><td style='font-size:9pt'>&nbsp;붙여넣기는 ctrl+v&nbsp;를 사용하세요.</td></tr></table>";
		tipNote.style.left = event.x+document.body.scrollLeft
		tipNote.style.top = event.y+document.body.scrollTop;
		tipNote.style.visibility = "visible";
	}
	else
	{
		tipNote.style.visibility = "hidden";
	}
}			


function testOne()
{
	//alert( document.getElementById('divSpaceForDCate').style.display );
	document.getElementById('divSpaceForDCate').style.display = "none";
}


function fnClose()
{	
	document.all["wndCategoryPopup"].style.visibility = "hidden";		
}
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
function GoNextPage(pageNo)
{
	frmList.cmdChg.value = "NO";	
	frmList.page.value = pageNo;
	submitList(ConstServer+"/view/fashion/Fashion_Sub.jsp");
}					
function SetUpdate()
{
	window.status ="";
}	
/*
************************************************
------------List.jsp에서 뺀 Script 끝-------------
************************************************
*/

/*
************************************************
----------Incdrawlistgoods.jsp에서 뺀 Script 
************************************************
*/

function showTopBorder()
{

	document.getElementById("td_border1").style.borderBottom="1px solid #444444";
	document.getElementById("td_border2").style.borderBottom="1px solid #444444";
	document.getElementById("td_border3").style.borderBottom="1px solid #444444";
	document.getElementById("td_border4").style.borderBottom="1px solid #444444";
	document.getElementById("td_border5").style.borderBottom="1px solid #444444";

	
	//document.getElementById("td_border1").style.borderLeft="1px solid #444444";
	//document.getElementById("td_border2").style.borderRight="1px solid #444444";
	//document.getElementById("td_border3").style.borderBottom="1px solid #444444";
	
	if (document.getElementById("td_border6") != null)
	{
		document.getElementById("td_border6").style.borderBottom="1px solid #444444";
	}
	/*
	if (document.getElementById("divKeywordTitle").style.display == "none" && document.getElementById("divPriceTitle").style.display == "none" )
	{
		//document.getElementById("td_borderKeyword").style.display = "inline";
		//document.getElementById("td_borderKeyword").style.borderBottom="1px solid #444444";
	}
	*/
	if (document.getElementById("divPriceTitle").style.display == "none")
	{
		document.getElementById("td_borderPrice").style.display = "inline";
		document.getElementById("td_borderPrice").style.borderBottom="1px solid #444444";		
	}
	document.getElementById("td_blank").style.borderBottom="1px solid #444444";	
}
function hideTopBorder()
{
	/*	
	document.getElementById("td_border1").style.borderLeft="";
	document.getElementById("td_border2").style.borderRight="";
	document.getElementById("td_border3").style.borderBottom="";
	*/

	document.getElementById("td_border1").style.borderBottom="";	
	document.getElementById("td_border2").style.borderBottom="";
	document.getElementById("td_border3").style.borderBottom="";	
	document.getElementById("td_border4").style.borderBottom="";
	document.getElementById("td_border5").style.borderBottom="";
	if (document.getElementById("td_border6") != null)
	{
		document.getElementById("td_border6").style.borderBottom="";
	}
	//document.getElementById("td_borderKeyword").style.borderBottom="";
	document.getElementById("td_borderPrice").style.borderBottom="";
	document.getElementById("td_blank").style.borderBottom="";		

}					
function showFactory()
{
	/*
	if (document.getElementById("LayerKeywordSelect").style.display == "inline")
	{
		document.getElementById("LayerKeywordSelect").style.display = "none";
	}
	*/					
	if (document.getElementById("LayerFactorySelect").style.display == "inline")
	{
		document.getElementById("LayerFactorySelect").style.display = "none";
		if (document.getElementById("divFactioryTitle").src.indexOf("tab_jejosa") > -1)
		{
			document.getElementById("divFactioryTitle").src = ImageServer+"/images/view/fashion/tab_jejosa.gif";
		}
		else
		{
			document.getElementById("divFactioryTitle").src = ImageServer+"/images/view/fashion/tab_mall.gif";
		}
		document.getElementById("divPriceTitle").src = ImageServer+"/images/view/fashion/tab_price.gif";
		hideTopBorder();
	}
	else
	{
		document.getElementById("LayerFactorySelect").style.display = "inline";
		if (document.getElementById("divFactioryTitle").src.indexOf("tab_jejosa") > -1)
		{
			document.getElementById("divFactioryTitle").src = ImageServer+"/images/view/fashion/tab_jejosa_1.gif";
		}
		else
		{
			document.getElementById("divFactioryTitle").src = ImageServer+"/images/view/fashion/tab_mall_1.gif";
		}
		document.getElementById("divPriceTitle").src = ImageServer+"/images/view/fashion/tab_price_2.gif";				
		showTopBorder();
	}
	if (document.getElementById("LayerPriceSelect").style.display == "inline")
	{
		document.getElementById("LayerPriceSelect").style.display = "none";
	}			
	var objCheckBox = document.getElementsByName("FactoryChk");
	var varChecked = 0;
	for (i=0;i<objCheckBox.length;i++)
	{
		objCheckBox[i].checked = false
	}	
		
	//document.getElementById("divKeywordTitle").src = ImageServer+"/images/button/tab_keyword.gif";		
	//이미지 변경 필요						
	hideMiddelParPreviewGoods();
}
function hideMiddelParPreviewGoods()
{
	if (document.getElementById("divMiddlebarpreviewgoods") != null )
	{
     	if (document.getElementById("LayerFactorySelect").style.display  == "inline" || document.getElementById("LayerPriceSelect").style.display == "inline" )
	    {
    		document.getElementById("divMiddlebarpreviewgoods").style.display = "none"
     	}
     	else
     	{
    		document.getElementById("divMiddlebarpreviewgoods").style.display = "inline"	
     	}	
   }
}
function hideKeywordandFactory()
{
	if (document.getElementById("LayerFactorySelect").style.display == "inline")
	{
		document.getElementById("LayerFactorySelect").style.display = "none";
	}			
	/*				
	if (document.getElementById("LayerKeywordSelect").style.display == "inline")
	{
		document.getElementById("LayerKeywordSelect").style.display = "none";
	}
	*/		
	if (document.getElementById("LayerPriceSelect").style.display == "inline")
	{
		document.getElementById("LayerPriceSelect").style.display = "none";
	}	
		if (document.getElementById("divFactioryTitle").src.indexOf("tab_jejosa") > -1)
		{
			document.getElementById("divFactioryTitle").src = ImageServer+"/images/view/fashion/tab_jejosa.gif";
		}
		else
		{
			document.getElementById("divFactioryTitle").src = ImageServer+"/images/view/fashion/tab_mall.gif";
		}
	//document.getElementById("divKeywordTitle").src = ImageServer+"/images/button/tab_keyword.gif";
	//이미지 변경 필요						
	document.getElementById("divPriceTitle").src = ImageServer+"/images/view/fashion/tab_price.gif";		
		
	hideTopBorder();
}

							
function showKeyword()
{
	if (document.getElementById("LayerFactorySelect").style.display == "inline")
	{
		document.getElementById("LayerFactorySelect").style.display = "none";
		hideTopBorder();		
	}							
	/*
	if (document.getElementById("LayerKeywordSelect").style.display == "inline")
	{
		document.getElementById("LayerKeywordSelect").style.display = "none";
		//document.getElementById("divKeywordTitle").src = ImageServer+"/images/button/tab_keyword.gif";				
		hideTopBorder();
	}
	else
	{
		document.getElementById("LayerKeywordSelect").style.display = "inline";
		//document.getElementById("divKeywordTitle").src = ImageServer+"/images/button/tab_keyword_1.gif";													
		showTopBorder();
	}
	*/
	if (document.getElementById("LayerPriceSelect").style.display == "inline")
	{
		document.getElementById("LayerPriceSelect").style.display = "none";
	}		
	var objCheckBox = document.getElementsByTagName("INPUT");
	var varChecked = 0;
	for (i=0;i<objCheckBox.length;i++)
	{
		if (objCheckBox[i].type =="checkbox")
		{
			if (objCheckBox[i].id.indexOf("chk_keyword_") > -1)
			{
				objCheckBox[i].checked = false
			}
		}
	}				
	if (document.getElementById("divFactioryTitle").src.indexOf("tab_jejosa") > -1)
	{
		document.getElementById("divFactioryTitle").src = ImageServer+"/images/view/fashion/tab_jejosa.gif";
	}
	else
	{
		document.getElementById("divFactioryTitle").src = ImageServer+"/images/view/fashion/tab_mall.gif";
	}
	//이미지 변경 필요						
	document.getElementById("divPriceTitle").src = ImageServer+"/images/view/fashion/tab_price.gif";	
	
}
function showPrice(msg)
{
	if (msg == "")
	{
    	if (document.getElementById("LayerFactorySelect").style.display == "inline")
    	{
    		document.getElementById("LayerFactorySelect").style.display = "none";
    	}							
    	/*
    	if (document.getElementById("LayerKeywordSelect").style.display == "inline")
    	{
    		document.getElementById("LayerKeywordSelect").style.display = "none";
    	}
    	*/
    	if (document.getElementById("LayerPriceSelect").style.display == "inline")
    	{
    		document.getElementById("LayerPriceSelect").style.display = "none";
    		document.getElementById("divPriceTitle").src = ImageServer+"/images/view/fashion/tab_price.gif";	
			if (document.getElementById("divFactioryTitle").src.indexOf("tab_jejosa") > -1)
			{
				document.getElementById("divFactioryTitle").src = ImageServer+"/images/view/fashion/tab_jejosa.gif";
			}
			else
			{
				document.getElementById("divFactioryTitle").src = ImageServer+"/images/view/fashion/tab_mall.gif";
			}
    		hideTopBorder();
    	}				
    	else
    	{
    		document.getElementById("LayerPriceSelect").style.display = "inline";
    		document.getElementById("divPriceTitle").src = ImageServer+"/images/view/fashion/tab_price_1.gif";
			if (document.getElementById("divFactioryTitle").src.indexOf("tab_jejosa") > -1)
			{
				document.getElementById("divFactioryTitle").src = ImageServer+"/images/view/fashion/tab_jejosa_2.gif";
			}
			else
			{
				document.getElementById("divFactioryTitle").src = ImageServer+"/images/view/fashion/tab_mall_2.gif";
			}
    		showTopBorder();		
    	}
    
    	var objCheckBox = document.getElementsByTagName("INPUT");
    	var varChecked = 0;
    	for (i=0;i<objCheckBox.length;i++)
    	{
    		if (objCheckBox[i].type =="checkbox")
    		{
    			if (objCheckBox[i].id.indexOf("chk_price_") > -1)
    			{
    				objCheckBox[i].checked = false
    			}
    		}
    	}			
    
    	//document.getElementById("divKeywordTitle").src = ImageServer+"/images/button/tab_keyword.gif";		
    }
    else
    {
    	var sLeft = screen.width/2-200;
    	var sTop = screen.height/2-50;
		var newWin = window.open("/include/Incpricerangemsg.jsp",null,"width=400,height=100,top="+sTop+",left="+sLeft+",status=no,toolbar=no,menubar=no,location=no");
		newWin.focus();
    }
	hideMiddelParPreviewGoods();    
}
function showComment(strKeyword,strComment)
{
	/*
	if (strComment != "")
	{

		var varDivTop = document.getElementById("LayerKeywordSelect").offsetTop;
		var varDivLeft = document.getElementById("LayerKeywordSelect").offsetLeft + document.getElementById("LayerKeywordSelect").offsetWidth + 10;
		
		var divTag = "";
		divTag = divTag + "<div id='divKeywordComment' style='position:absolute;top:"+varDivTop+";left:"+varDivLeft+";width:100;height:120;border:1px solid #000000;z-index:0;'>";
		divTag = divTag + "</div>";								

		var divElement = document.createElement(divTag);
		document.body.insertBefore(divElement);
		
		var divTable = "";
		divTable = divTable + "<table border=0 cellpadding=0 cellspacing=0 width=100 >";
		divTable = divTable + "<tr>";					
		divTable = divTable + "<td align='center' height='25' style='color:#000000;font-weight:bold;background-color:beige;'>"+strKeyword+"</td>";
		divTable = divTable + "</tr>";										
		divTable = divTable + "<tr>";					
		divTable = divTable + "<td align='left' height='95' valign='top' style='padding-left:2px;padding-right:2px;background-color:#FEFEF2;'>"+strComment+"</td>";
		divTable = divTable + "</tr>";		
		divTable = divTable + "</table>";									

		document.getElementById("divKeywordComment").innerHTML = divTable;

	
	}
	*/
}
function hideComment()
{
	if (typeof(document.getElementById("divKeywordComment")) != "undefined")
	{
		if (document.getElementById("divKeywordComment") != null)
		{
			document.getElementById("divKeywordComment").outerHTML = "";
		}
	}
}
function setKeywordChk(strK_No)
{
	if (document.getElementById("chk_keyword_"+strK_No).checked)
	{
		arrCheck[arrCheck.length] = strK_No;
		var objCheckBox = document.getElementsByTagName("INPUT");
		var varChecked = 0;
		for (i=0;i<objCheckBox.length;i++)
		{
			if (objCheckBox[i].type =="checkbox")
			{
				if (objCheckBox[i].id.indexOf("chk_keyword_") > -1)
				{
					if (objCheckBox[i].checked)
					{
						varChecked++;
					}
				}
			}
		}
		//alert(varChecked);
		if (varChecked > 3)
		{
			var bChecked = false;
			for (i=0;i<arrCheck.length;i++)
			{
				if (arrCheck[i] != "")
				{
					document.getElementById("chk_keyword_"+arrCheck[i]).checked = false;
					arrCheck[i] = "";
					break;
				}
			}
		}
	}
	else
	{
		for (i=0;i<arrCheck.length;i++)
		{
			if (arrCheck[i] == strK_No)
			{
				arrCheck[i] = "";
				break;
			}
		}				
	}
}
/*
************************************************
----------Incdrawlistgoods.jsp에서 뺀 Script 끝 
************************************************
*/
