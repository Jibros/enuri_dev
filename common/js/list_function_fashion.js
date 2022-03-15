/*
************************************************
------------List.jsp���� �� Script-------------
************************************************
*/
var ImageServer = "http://img.enuri.com";
//������ ������ ���� üũ�ϴ� ��ü ������ �Լ�
function objDetectBrowser() {
var strUA, s, i;
this.isIE = false;  // ���ͳ� �ͽ��÷η������� ��Ÿ���� �Ӽ�
this.isNS = false;  // �ݽ������������� ��Ÿ���� �Ӽ�
this.version = null; // ������ ������ ��Ÿ���� �Ӽ�
// Agent ������ ��� �ִ� ���ڿ�.
// �� ���� �ñ��� ����� alert ���� �̿��Ͽ� strUA ���� Ȯ���ϱ� �ٶ���!
strUA = navigator.userAgent; 

s = "MSIE";
// Agent ���ڿ�(strUA) "MSIE"�� ���ڿ��� ��� �ִ��� üũ
if ((i = strUA.indexOf(s)) >= 0) {
 this.isIE = true;
 // ���� i���� strUA ���ڿ� �� MSIE�� ���۵� ��ġ ���� ����ְ�,
 // s.length�� MSIE�� ���� ��, 4�� ��� �ִ�.
 // strUA.substr(i + s.length)�� �ϸ� strUA ���ڿ� �� MSIE ������ 
 // ������ ���ڿ��� �߶�´�.
 // �� ���ڿ��� parseFloat()�� ��ȯ�ϸ� ������ �˾Ƴ� �� �ִ�.
 this.version = parseFloat(strUA.substr(i + s.length));
 return;
}

s = "Netscape6/";
// Agent ���ڿ�(strUA) "Netscape6/"�̶� ���ڿ��� ��� �ִ��� üũ
if ((i = strUA.indexOf(s)) >= 0) {
 this.isNS = true;
 this.version = parseFloat(strUA.substr(i + s.length));
 return;
}

// �ٸ� "Gecko" �������� NS 6.1�� ���.

s = "Gecko";
if ((i = strUA.indexOf(s)) >= 0) {
 this.isNS = true;
 this.version = 6.1;
 return;
}
}

var objDetectBrowser = new objDetectBrowser();

//���� Ȱ��ȭ�� ��ư�� �����ϱ� ���� ���� ����.
var gvActiveButton = null;

//��ư�� �ƴ� �ٸ� ���� ���콺�� Ŭ���ϸ� Ȱ��ȭ�� ��ư�� ��Ȱ��ȭ�� ����.

if (objDetectBrowser.isIE)
document.onmousedown = mousedownPage;
if (objDetectBrowser.isNS)
document.addEventListener("mousedown", mousedownPage, true);

function mousedownPage(event) {

var objElement;

// Ȱ��ȭ�� ��ư�� ������ ������ ���� ����.
if (!gvActiveButton)
 return;

// ���� ���õ� ��ü ��Ҹ� ��� ��.
if (objDetectBrowser.isIE)
 objElement = window.event.srcElement;
if (objDetectBrowser.isNS)
 objElement = (event.target.className ? event.target : event.target.parentNode);

	

// ���� ���� Ȱ��ȭ�� ��ư�� Ŭ���ߴٸ� �׳� ������ ���� ����.
if (objElement == gvActiveButton)
 return;

// ���� Ŭ���� ��Ұ� �޴� ��ư, �޴� ������ ���� �ƴϸ� Ȱ��ȭ�� �޴��� ��Ȱ��ȭ ��Ŵ.

if (objElement.className != "menuButton"  && objElement.className != "menuItem" && objElement.className != "menuItem2" &&
   objElement.className != "menuItemSep" && objElement.className != "menu")
 resetButton(gvActiveButton);

}

function mouseoverButton(objMnuButton, strMenuName) {

// ���� �ٸ� �޴� ��ư�� Ȱ��ȭ�Ǿ� �ִٸ� ��Ȱ��ȭ ��Ų ��
// ���� ���콺 ������ �޴��� Ȱ��ȭ ��Ų��.

if (gvActiveButton && gvActiveButton != objMnuButton) {
 resetButton(gvActiveButton);
 
if (strMenuName)
 clickButton(objMnuButton, strMenuName);
}
}

function clickButton(objMnuButton, strMenuName) {

// ��ũ �ֺ��� �ƿ������� ����.
objMnuButton.blur();

// �� �޴� ��ư�� ���� Ǯ�ٿ� �޴� ��ü�� ������
// menu �� �̸��� ��ü ����
if (!objMnuButton.menu)
 objMnuButton.menu = document.getElementById(strMenuName);


// ���� Ȱ��ȭ�� �޴� ��ư�� ó�� ���·� �ǵ���.
if (gvActiveButton && gvActiveButton != objMnuButton)
   resetButton(gvActiveButton);	
	



// �޴� ��ư Ȱ��ȭ ���ο� ���� Ȱ��ȭ/��Ȱ��ȭ ���.
if (gvActiveButton)
 resetButton(objMnuButton);
else
 pulldownMenu(objMnuButton);
			
return false;
}

function pulldownMenu(objMnuButton) {

// ���� ���õ� ��ü�� Ŭ������ "Ȱ��ȭ" Ŭ������ ����
objMnuButton.className = "menuButtonActive";

// �ͽ��÷η��� ���, ù ��° �޴� �����ۿ� ���� ��Ȯ�� ���� ����� �ֵ��� �Ѵ�.
// ���� �� �κ��� �������� ������ ���콺�� �޴� ������ ������ �ؽ�Ʈ ���� �÷����� ����
// �����ȴ�. ���� �ؽ�Ʈ�� �ƴ� �޴� ������ ���� ���θ� ���� ���� ������Ű����
// �� �κ��� ������ ��� �Ѵ�.
if (objDetectBrowser.isIE && !objMnuButton.menu.firstChild.style.width) {
 objMnuButton.menu.firstChild.style.width = objMnuButton.menu.firstChild.offsetWidth + "px";
}

// ���������� ���� ȯ�濡 �´� ��� �ٿ� �޴��� ��ġ�� 
// ������ ��� �Ѵ�.
x = objMnuButton.offsetLeft;
y = objMnuButton.offsetTop + objMnuButton.offsetHeight;
if (objDetectBrowser.isIE) {
 x += -1;
 y += 1;
}
if (objDetectBrowser.isNS && objDetectBrowser.version < 6.1)
 y--;

// ��ġ ���� �� Ǯ�ٿ� �޴��� ������

objMnuButton.menu.style.left = x + "px";
objMnuButton.menu.style.top  = y + "px";
objMnuButton.menu.style.visibility = "visible";

// ���� Ȱ��ȭ�� �޴� ��ü�� �����ϴ� �������� gvActiveButon��
// ���� ���õ� �޴� ��ü�� ����
gvActiveButton = objMnuButton;
}

function resetButton(objMnuButton) {

// ���� ��Ÿ�Ϸ� �ǵ���
objMnuButton.className = "menuButton";

// ������ Ǯ�ٿ� �޴��� ������
if (objMnuButton.menu)
 objMnuButton.menu.style.visibility = "hidden";

// ���� Ȱ��ȭ�� �޴� ��ư�� ���� ������ ����
gvActiveButton = null;
}

function resetButton2(obj) {

// ���� ��Ÿ�Ϸ� �ǵ���
//obj.className = "menuButton";


 obj.style.display = "none";

// ���� Ȱ��ȭ�� �޴� ��ư�� ���� ������ ����
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
			alert("�Է��Ͻ� �˻�� ���� ��ǰ ������ �����ϴ�.      \n \n�˻����� �Ϻθ� �Է��Ͽ� �ٽ� �˻��غ�����.");
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
		window.status ="�ش� ī�װ��� �ٽ� �����Ͻʽÿ�.";	
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
			alert("�Է��Ͻ� �˻�� ���� ��ǰ ������ �����ϴ�.      \n \nŰ���� ���� ���� �ٿ��� �ٽ� �˻��غ�����.");
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
		window.status ="�ش� ī�װ��� �ٽ� �����Ͻʽÿ�.";	
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
			
			// 3�� ������
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
		// sung35 �űԻ�ǰ�� �α��ǰ ���� ó�� 2004.1.26
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
		alert("2�� �̻��� �����縦 üũ�Ͻ� �� Ŭ���ϼ���.");
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
		alert("2�� �̻��� �����縦 üũ�Ͻ� �� Ŭ���ϼ���.");
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
		alert("2�� �̻��� �����縦 üũ�Ͻ� �� Ŭ���ϼ���.");
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
					alert("���θ� �˻����� ���ݴ� �˻��� ���ӵ� ���ݴ� �˻��� �Ҽ� �ֽ��ϴ�");
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
		alert("2�� �̻��� ������ üũ�Ͻ� �� Ŭ���ϼ���.");
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
		alert("2�� �̻��� ������ üũ�Ͻ� �� Ŭ���ϼ���.");
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
		alert("2�� �̻��� ������ üũ�Ͻ� �� Ŭ���ϼ���.");
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
		alert("2�� �̻��� ������ üũ�Ͻ� �� Ŭ���ϼ���.");
	}
}
function chk(frm)
{

	if ((event.button==2) || (event.button==3)) 
	{
		document.all("tipNote").innerHTML = "<table bgcolor='#eee8aa' cellpadding='0' cellspacing='0' border='1' bordercolorlight='black' bordercolordark='white'><tr><td style='font-size:9pt'>&nbsp;�ٿ��ֱ�� ctrl+v&nbsp;�� ����ϼ���.</td></tr></table>";
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
------------List.jsp���� �� Script ��-------------
************************************************
*/

/*
************************************************
----------Incdrawlistgoods.jsp���� �� Script 
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
	//�̹��� ���� �ʿ�						
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
	//�̹��� ���� �ʿ�						
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
	//�̹��� ���� �ʿ�						
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
----------Incdrawlistgoods.jsp���� �� Script �� 
************************************************
*/
