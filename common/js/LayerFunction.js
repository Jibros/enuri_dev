<!-- Layer ���� �Լ���..  -->
<!-- 

	function fnChangeSrchType(param1,param2)
	{
		document.all["btn_SearchType"].value = param2;
		document.frmList.wordtype.value = param1;
		HideListEtcMenu();
	}
	
	function fnChangeSrchKind(param1,param2)
	{
		
		//document.all["btn_SearchKind"].value = param2;		
		document.frmList.searchkind.value = param1;
		
//		if ( param1 == "1" ) {
//			document.frmList.searchkind[0].checked = true;			
//		}
//		else {
//			document.frmList.searchkind[parseInt(param1)-1].checked = true;
//		}
		
		document.frmList.cmdchg.value = "NO";			
		document.frmList.page.value = "";
		document.frmList.pagesize.value = "";
		document.frmList.factory.value = "";					
		document.frmList.lcate.value = "";
		document.frmList.lcatename.value = "";
		//document.frmList.const_keyword.value = "";			
		document.frmList.key.value = "";	
		document.frmList.prevSearch.value="YES";
		document.frmList.submit();			
	}
	
	// ������ ��ǰ �˻�����  ��з� ���� ��
	function fnLCateSelect(param1, param2)
	{		
		// param1 : ������ ��з� �ڵ�		
		// ������ ��з��� ���� �ߺз� ����Ʈ �����־�� ��
		
		if ( param1 == "" ) {
			trMCate.style.visibility = "hidden";
			document.all["btn_MCategory"].value = "��ü��ǰ�߿���";
			document.frmList.mcate.value = "";
			document.frmList.mcatename.value = "��ü��ǰ�߿���";			
		}
		else {			
			document.ifrmGetSubData.location.href = "GetSubCategory.asp?code=" + param1;				
		}	
		document.all["btn_LCategory"].value = param2;						
		document.frmList.lcate.value = param1;
		document.frmList.lcatename.value = param2;
		HideListEtcMenu();
	}
	
	// ������ ��ǰ�˻����� �ߺз� ���� ��
	function fnMCateSelect(param1, param2)
	{		
		// param1 : ������ �ߺз� �ڵ�		
								
		document.all["btn_MCategory"].value = param2;						
		document.frmList.mcate.value = param1;
		document.frmList.mcatename.value = param2;
		HideListEtcMenu();
	}	
	
	// ������ �˻�����  ��з� ���� ��
	function fnLKnowCategory(param1, param2)
	{			
		document.all["btn_LCategory"].value = param2;						
		document.frmList.lcate.value = param1;
		document.frmList.lcatename.value = param2;
		HideListEtcMenu();
	}
	
	// ������ �˻�����  ������з� ���� ��
	function fnKnowKind(param1, param2)
	{
		document.all["btn_KnowKind"].value = param2;						
		document.frmList.kkcode.value = param1;
		document.frmList.kkname.value = param2;
		HideListEtcMenu();
	}
	
	// ������ �˻����� ���ļ��� ���� ��
	function fnKnowOrder(param1,param2)
	{
		document.all["btn_KOrder"].value = param2;						
		document.frmList.korder.value = param1;
		document.frmList.kordername.value = param2;		
		fnSendData2("Searchlist.jsp");
		//HideListEtcMenu();		
	}	
		
	function CalcListEtcMenu(intMoveLeft, intMoveTop)
	// ��ϼ�, ����, ������ ���̾� Left, Top ��ǥ ����
	{ 
		wndListEtcMenu.style.posLeft = event.x - event.offsetX + document.body.scrollLeft + intMoveLeft * 1;
		wndListEtcMenu.style.posTop = event.y - event.offsetY + document.body.scrollTop + intMoveTop * 1 + 16 ;
	} 
	
	function CalcListEtcMenu1(intMoveLeft, intMoveTop)
	// ��ϼ�, ����, ������ ���̾� Left, Top ��ǥ ����
	{ 
		wndListEtcMenu.style.posLeft = event.x - event.offsetX + document.body.scrollLeft + intMoveLeft * 1;
		wndListEtcMenu.style.posTop = event.y - event.offsetY + document.body.scrollTop + intMoveTop * 1 + 14 ;
	} 
	
	function OpenListEtcMenu(intTableW, intRowCnt, strPart)
	// ��ϼ�, ����, ������ ���̾� With, Height ����
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
					intLaHeight = 330;
				}
				else
				{
					intTbWidth = intTableW;
					intLaWidth = intTableW + 2;
					intLaHeight = intRowCnt * 20 + 130;
				}
			}
			if (strPart == "srchfactory")
			{
				if (intRowCnt > 10)
				{
					intTbWidth = intTableW - 16;
					intLaWidth = intTableW + 2;
					intLaHeight = 270;
				}
				else
				{
					intTbWidth = intTableW;
					intLaWidth = intTableW + 2;
					intLaHeight = intRowCnt * 20 + 70;
				}
			}
			else if (strPart == "sort")
			{
				intTbWidth = intTableW;
				intLaWidth = intTableW + 2;
				intLaHeight = 146;
			}
			else if (strPart == "Exsort")
			{
				intTbWidth = intTableW;
				intLaWidth = intTableW + 2;
				intLaHeight = 62;
			}
			else if (strPart == "listcnt")
			{
				intTbWidth = intTableW;
				intLaWidth = intTableW + 2;				
				intLaHeight = 162;
			}	
			else if (strPart == "Exlistcnt")
			{
				intTbWidth = intTableW;
				intLaWidth = intTableW + 2;				
				intLaHeight = 60;
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
					intLaHeight = intRowCnt * 20 ;
				}			
			}
			else if ( strPart == "srchKOrder")
			{
					intTbWidth = intTableW - 16;
					intLaWidth = intTableW + 2;
					intLaHeight = 65;
			}
			else if ( strPart == "srchKind")
			{
					intTbWidth = intTableW; // - 16;
					intLaWidth = intTableW + 2;					
					intLaHeight = 42;
			}
			else if ( strPart == "srchKind1")
			{
					intTbWidth = intTableW; // - 16;
					intLaWidth = intTableW -1;
					intLaHeight = 50;
			}
			else if (strPart == "category")
			{				
				if (intRowCnt < 6)
				{
					intTbWidth = intTableW; 
					intLaWidth = intTableW + 2;
					intLaHeight = intRowCnt * 18 + 10;
				}
				else
				{
					intTbWidth = intTableW;
					intLaWidth = intTableW + 2;
					intLaHeight = intRowCnt * 18;
				}
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
	} 
	
	function HideListEtcMenu()
	// ��ϼ�, ����, ������ ���̾� ����
	{ 
		wndListEtcMenu.style.borderColor = "#FFFFFF";
		wndListEtcMenu.style.visibility = "hidden";
		fEtcMenu = "false";
	} 
	function ShowListEtcMenu()
	// ��ϼ�, ����, ������ ���̾� ����
	{ 
		wndListEtcMenu.style.visibility = "visible";
		fEtcMenu = "true";
	}
	function TdMiceOut(obj)
	// ��ϼ�, ����, ������ MouseOut�� �� ���������� ����
	{
		obj.color="#000000";
		obj.backgroundColor="#FFFFFF";
	}
	function TdMiceOver(obj)
	// ��ϼ�, ����, ������ MouseOver�� �� ������
	{
		obj.color="#FFFFFF";
		obj.backgroundColor="#08246B";
	}
	
	function OneFactorySubmit(theForm, intIndexOf, intTotCount)
	{
		frmList.page.value="";		
		
		if ( intTotCount == 1 ) {
			frmList.factory.value=frmCount.FactoryChk.value;
		}
		else {
			frmList.factory.value=frmCount.FactoryChk[intIndexOf].value;
		}
		fnSendData2("Searchlist.jsp");
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
			fnSendData2("Searchlist.jsp");
		}
		else
		{
			alert("2�� �̻��� �����縦 üũ�Ͻ� �� Ŭ���ϼ���.");
		}
	}
	
	function OneShopSubmit(theForm, intIndexOf, intTotCount)
	{
		frmList.page.value="";
		if ( intTotCount == 1 ) {
			frmList.shopcode.value=frmExList.ShopChk.value;
		}
		else {
			frmList.shopcode.value=frmExList.ShopChk[intIndexOf].value;
		}
		fnSendData2("Searchlist.jsp");
	}
	
	function MutliShopSubmit(theForm, intMaxIndexOf)
	{
		var k;
		var isChked;
		var strSelectShop;
		
		isChked = false;
		strSelectShop = "";
		for(k=0; k<frmExList.ShopChk.length; k++)
		{
			frmList.shopcode.value = "";
			if(frmExList.ShopChk[k].checked == true)
			{
				isChked = true;
				if (strSelectShop != "")
				{
					strSelectShop = strSelectShop + ",";
				}
				strSelectShop = strSelectShop + frmExList.ShopChk[k].value;
			}
		}
		if(isChked == true)
		{
			frmList.page.value="";
			frmList.shopcode.value = strSelectShop;
			fnSendData2("Searchlist.jsp");
		}
		else
		{
			alert("2�� �̻��� ���θ��� üũ�Ͻ� �� Ŭ���ϼ���.");
		}
	}	
	
	function chgColor(titleNo){
	// ���б� Ŭ���� ���ñ� ���� ���������� ����
		document.cookie = "chkKbNo=;path=/"
		if(kbTitle.length > 0){
			for(i=0;i<kbTitle.length;i++){
				kbTitle[i].style.backgroundColor = ""
				kbTitle[i].style.color = ""
			}
			kbTitle[titleNo].style.backgroundColor = "#000000"
			kbTitle[titleNo].style.color = "#ffffff"
		}else{
			kbTitle.style.backgroundColor = "#000000"
			kbTitle.style.color = "#ffffff"
		}
	}
//--> 
