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
	//'### shwoo 2005.01.24. ����������
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
	
	//���ຸ��
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
			alert("���� : " + moreLess.innerHTML);
			*/
			document.getElementById('IMG_'+tmp_id).src = strUrl + '/images/detail/detail_icon_minus.gif';
		}else {
			document.getElementById("ShopName_Plus_"+tmp_id).style.display="inline";
			document.getElementById("ShopName_Minus_"+tmp_id).style.display="none";
			moreName.display="none";
			/*
			moreLess.innerHTML = more;
			alert("���� : " + moreLess.innerHTML);
			*/
			document.getElementById('IMG_'+tmp_id).src = strUrl + '/images/detail/detail_icon_plus.gif';
		}
	}
	
	//ǥ�غ���(+,-)
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
	//��ü����(���ĺ���, �ٿ�����)
	function showHideScroll(vcode){
		//document.getElementById('SHOP_SCROLL_'+vcode).runtimeStyle.overflow='hidden';this.innerHTML='�ٿ�����';
		obj = document.getElementById('SHOP_SCROLL_IMG_'+vcode);
		if(obj.innerHTML.match(/_out.gif/g)){//���ĺ���
			showScroll(vcode)
			/*
				obj.innerHTML = "<img src=/images/view/butt_in.gif border=0 alt=�ٿ�����>";
				document.getElementById('SHOP_SCROLL_'+vcode).runtimeStyle.overflow='hidden';
				document.getElementById('SHOP_SCROLL_'+vcode).runtimeStyle.height='100%';
				//eval("document.all.SHOP_LOC_"+vcode).scrollIntoView(true) //���ĺ��� Ŭ���� �ش� �������� ������ ������� �̵� //������������ �ݿ� ����ϼ̼� �ּ�ó�� wookki25 200.11.11
			*/	
		}else{ //�ٿ�����
			hideScroll(vcode)
			/*
				obj.innerHTML = "<img src=/images/view/butt_out.gif border=0 alt=���ĺ���>";
				document.getElementById('SHOP_SCROLL_'+vcode).runtimeStyle.overflow='';			
				document.getElementById('SHOP_SCROLL_'+vcode).runtimeStyle.height='';
			*/	
		}
	}
	function showScroll(vcode){
		//document.getElementById('SHOP_SCROLL_IMG_'+vcode).innerHTML = "<img src=/images/view/butt_in.gif border=0 alt=�ٿ�����>"
		document.getElementById('SHOP_SCROLL_'+vcode).runtimeStyle.overflow='hidden';
		document.getElementById('SHOP_SCROLL_'+vcode).runtimeStyle.height='100%';
		//eval("document.all.SHOP_LOC_"+vcode).scrollIntoView(true) //���ĺ��� Ŭ���� �ش� �������� ������ ������� �̵� //������������ �ݿ� ����ϼ̼� �ּ�ó�� wookki25 200.11.11
	}
	function hideScroll(vcode){
		//document.getElementById('SHOP_SCROLL_IMG_'+vcode).innerHTML = "<img src=/images/view/butt_out.gif border=0 alt=���ĺ���>"
		document.getElementById('SHOP_SCROLL_'+vcode).runtimeStyle.overflow='';			
		document.getElementById('SHOP_SCROLL_'+vcode).runtimeStyle.height='';
	}
	function showHideScrollAll(IsLeftRight){
		arrAll		= document.getElementsByName("SHOP_SCROLL_ALL_SHOW_HIDE");
		arrEarch	= document.getElementsByName("SHOP_SCROLL");		
		if(arrAll[0].innerHTML.match(/bt_eachallview_d.gif/g)){//���ĺ���
			for(i=0;i<arrAll.length;i++){
				arrAll[i].innerHTML = "<img src=" + strUrl + "/images/view/bt_eachview.gif border=0 style='cursor:hand;' alt='Ŭ���ϸ� ���θ����� ��ũ�ѹٰ�\n�߻��Ǿ� â�� ���̰� �پ��ϴ�.'>";
			}
			for(i=0;i<arrEarch.length;i++){
				showScroll(arrEarch[i].getAttribute("vcode"));
			}
		}else if(arrAll[0].innerHTML.match(/bt_eachview.gif/g)){//�ٿ�����
			for(i=0;i<arrAll.length;i++){
				arrAll[i].innerHTML = "<img src=" + strUrl + "/images/view/bt_eachallview_d.gif border=0 style='cursor:hand;' alt='Ŭ���ϸ� ���θ��� ��ũ�ѹٰ�\n�������� ��� ��ǰ���� �������ϴ�.'>";
			}
			for(i=0;i<arrEarch.length;i++){
				hideScroll(arrEarch[i].getAttribute("vcode"));
			}	
		}
		if(IsLeftRight == "right"){
			document.all.BottTitleLoc.scrollIntoView(true);
		}
	}
	//�ڼ������� ǳ����
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
	function SortPosition(sortname)	//���� ��ġ ���� 2003.3 sung35 
	{
		var nLeft,nTop;


		nLeft = event.x - event.offsetX - 4 + document.body.scrollLeft;
		nTop = event.y - event.offsetY + 14 + document.body.scrollTop;
			
	//	alert(sortname)
		eval(sortname+".style").posLeft = nLeft;
		eval(sortname+".style").posTop = nTop;
	}
	
	function SortPositionButton(sortname) //���� ��ġ ����(�̹���) 2003.3 sung35 
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
					msg	= "* �¿���θ� ����: <font color=blue><b>��۷� ����</b></font><br>���θ��� ��۷� ��å�� ���� �����Դϴ�.<br>������ ��۷� ���� ���θ��̸�, ������ ��۷ᰡ ���Ǻ� Ȥ�� �ݾ׺� �������� ���θ��Դϴ�." ;  
					break;
				case "opt_term_left" : 
					msg	= "" ;  
					break;
				case "opt_term_right" : 
					msg	= "" ;  
					break;
					
					
				case "opt_scale" : 
					msg	= "* �¿���θ� ����: <font color=blue><b>������:�Ϲݸ�</b></font><br>���� ���θ��� ������ ���� ���θ�, ������&trade;�� ���� ����׵��� �������� �Ͽ� ������&trade; ��ü������ ������ �����Դϴ�." ;  
					break;
				case "opt_scale_left" : 
					msg	= "" ;  
					break;
				case "opt_scale_right" : 
					msg	= "" ;  
					break;
				case "opt_auth" : 
					msg	= "* �¿���θ� ����: <font color=blue><b>��ǰ(����)</b></font><br>���� �Ǹ� �� ��������� ���� �����ϴ� ��������� ������ ���� ���θ��� �������� ���еǾ� �ֽ��ϴ�. ��ü �߿��� ��Ȯ�� ���θ��� ���ԵǾ� �ֽ��ϴ�." ;  
					break;
				case "opt_auth_left" : 
					msg	= "" ;  
					break;
				case "opt_auth_right" : 
					msg	= "" ;  
					break;
										
//				case "opt_escro" : 
//					msg	= "* �¿���θ� ����: <font color=blue><b>�Ƚɱ���</b></font>" ;  
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
	
	// ������ �α��� üũ�� �ֹ��˾�â ���� by hsw 2004.12.01
	function CmdEverMallMainProc(cmd, sCode, sName, mNo, mName, mFactory, mPrice, multiFlag, iPlNo, sPlGoodsNm, sUrl)	
	{
		//alert("sPlGoodsNm : "+sPlGoodsNm);
		//var k = window.open ("","everWin"+iPlNo+"","width=1010 height=680 scrollbars=yes "); ���� ������
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
				<td style=font-size:9pt;>"+ obj.getAttribute("deliveryDesc") +" <span style=font-size:9pt;text-align:right;cursor:hand; onClick=altDelivery.style.display='none'>[�ݱ�]</span></td>\
			</tr>\
			</table>"
		altDelivery.style.top = event.y + document.body.scrollTop +5
		altDelivery.style.left = event.x + document.body.scrollLeft + 10
		altDelivery.innerHTML = strTbl
		altDelivery.style.display="inline"
	}
	
// ������ ������ ���� üũ�ϴ� ��ü ������ �Լ�
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

// ���� Ȱ��ȭ�� ��ư�� �����ϱ� ���� ���� ����.
var gvActiveButton = null;

// ��ư�� �ƴ� �ٸ� ���� ���콺�� Ŭ���ϸ� Ȱ��ȭ�� ��ư�� ��Ȱ��ȭ�� ����.

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

