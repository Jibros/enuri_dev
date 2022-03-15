<%@ page contentType="text/html;charset=euc-kr" %>
<%@ include file="/include/Base_Inc.jsp"%>


<%@ page import="com.enuri.bean.log.Mem_myfavorite_Data"%>
<%@ page import="com.enuri.bean.log.Mem_myfavorite_Proc"%>
<%@ page import="com.enuri.bean.main.Myever_Data"%>
<%@ page import="com.enuri.bean.main.Myever_Proc"%>
<jsp:useBean id="Mem_myfavorite_Data" class="com.enuri.bean.log.Mem_myfavorite_Data" scope="page" />
<jsp:useBean id="Mem_myfavorite_Proc" class="com.enuri.bean.log.Mem_myfavorite_Proc" scope="page" />
<jsp:useBean id="Myever_Data" class="com.enuri.bean.main.Myever_Data" scope="page" />
<jsp:useBean id="Myever_Proc" class="com.enuri.bean.main.Myever_Proc" scope="page" />

<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<jsp:useBean id="Goods_Data" class="com.enuri.bean.main.Goods_Data" scope="page" />
<jsp:useBean id="Goods_Proc" class="com.enuri.bean.main.Goods_Proc" scope="page" />

<%
String sTEMP_ID = cb.GetCookie("MYINFO","TMP_ID");
String sUserID = cb.GetCookie("MEM_INFO","USER_ID");

//claudy 2005.03.25 에버몰 회원일 경우에 찜상품목록에 EDU 목록을 보여줌
String strAuth = cb.GetCookie("SDU","SHOP_AUTH");
String strShopCode = cb.GetCookie("SDU","SHOP_CODE");

%>

<html>
<head>
<link REL="stylesheet" HREF="/common/css/enuribase.css" TYPE="text/css">
<script language=javascript>
<!--
 
function MouseDown(e)
{	
	//window.event.ctrlKey = true;
	//event.keyCode=
	
}

function OpenWindow(OpenFile,name,nWidth,nHeight,ScrollYesNo,ResizeYesNo)
{
	window.open(OpenFile,name,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars="+ ScrollYesNo +",resizable="+ ResizeYesNo +",menubar=no");
}
function OpenWindowYes(OpenFile,winname,nWidth,nHeight)
{
	window.open(OpenFile,winname,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");
}
function OpenWindowNo(OpenFile,winname,nWidth,nHeight)
{
	window.open(OpenFile,winname,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars=no,resizable=no,menubar=no");
}
function OpenWindowPosition(OpenFile,name,nWidth,nHeight,ScrollYesNo,ResizeYesNo,lleft,ttop)
{
	window.open(OpenFile,name,"width="+nWidth+",height="+nHeight+",left="+lleft+",top="+ttop+",toolbar=no,directories=no,status=no,scrollbars="+ ScrollYesNo +",resizable="+ ResizeYesNo +",menubar=no");
}


var sMyFavoriteModelNo = new Array();
var sMyFavoriteModelNm = new Array();
var sMyFavoriteModelImgChk = new Array();
var sMyFavoriteEverNo = new Array();
var sMyFavoriteEverStatus = new Array();
var sMyFavoriteEverRegFlag = new Array();

//스크롤 제거 처리를 위한 변수값(지우지 마십시오)
//0:스크롤 미처리, 1: 스크롤 처리완료.
//document.domain ="enuri.com";

function CmdFrmaResize(name)
{
	
	try
	{		//oBody.scrollHeight 브라우져 5.5이하에서는 적용안됌...문제...
			var oBody 	= parent.document.frames(name).document.body;			
			var oFrame 	= parent.document.all(name);
			
			oFrame.style.width  = "88px";
			
			<%if (request.getHeader("USER-AGENT").indexOf("MSIE 6.0")>0){%>				
				oFrame.style.height = oBody.scrollHeight + (oBody.offsetHeight-oBody.clientHeight);
				if (oFrame.style.height == "0px" || oFrame.style.width == "0px"){
					oFrame.style.width = "88px";
					oFrame.style.height = ((sMyFavoriteModelNo.length *60)+130)+"px" //"3500px"; 
				}
			<% }else{%>
				if( typeof(sMyFavoriteModelNo.length)=="number"){
					oFrame.style.height = ((sMyFavoriteModelNo.length * 60)+130) +"px";
				}else{
					oFrame.style.height = "3500px";
				}
				
			<% }%>
			//window.status='정상';
	}
	catch(e)
	{
		try{
			if( typeof(sMyFavoriteModelNo)=="object")
			{
				oFrame.style.height = ((sMyFavoriteModelNo.length *60)+130)+"px" ; 
			}
			else
			{
				oFrame.style.height = "3500px";
			}
		}catch(e){
			window.status='';
		}
		//window.status='정상.';
			
	}
	
}


function CmdMyFavoriteGo()
{
	try{
		<% if (!sUserID.equals("")){%>
			parent.document.location.href="/view/Mysurfinglist.jsp"
		<% }else{%>
			parent.document.location.href="/view/Mysurfinglist.jsp";		<% }%>
	}catch(e){
		window.status='';
	}
}

var isUpdateStatus =<%=( ChkNull.chkStr("mslist","").equals("load") ?  "0" : "1")%>;	

function CmdUpdateOver()
{
	try{	
		if (isUpdateStatus==0)
		{	document.all("UpdateBtn").src="/images/blank.gif";	} //document.all("UpdateBtn").src="/images/view/MysurfingUpdate_1.gif";
		else
		{	document.all("UpdateBtn").src="/images/view/MysurfingUpdateAni.gif";	}
	}catch(e){
		window.status='';
	}
}
function CmdUpdateOut()
{
	try{
		if (isUpdateStatus==0)
		{	document.all("UpdateBtn").src="/images/blank.gif";	} //document.all("UpdateBtn").src="/images/view/MysurfingUpdate.gif";
		else
		{	document.all("UpdateBtn").src="/images/view/MysurfingUpdateAni.gif";	}
	}catch(e){
		window.status='';
	}
}

function SetUpdateImg()
{
	try{
	isUpdateStatus=1;
	document.all("UpdateBtn").src="/images/view/MysurfingUpdateAni.gif";
	}catch(e){
		window.status='';
	}
}

function CmdGotoList()
{	
	try{
		document.frmMainLogin.submit();
	}catch(e){
		window.status='';
	}
}

//
//-->
</script>
</head>
<script LANGUAGE="JavaScript" src="/common/js/function.js"></script>
<body onload="MyFavoriteInitialize();CmdFrmaResize('IFrameMyFavoriteList');" scroll=no topmargin=0 leftmargin=0>
<iframe name="MyfavorieteLoginFrm" id="MyfavorieteLoginFrm"  frameborder=0  style="height:0;width:0;z-index:0;"></iframe>
<span ID="MyFavoriteTitle" Name="MyFavoriteTitle" style="position:absolute;left:0;top:0px;width:70;z-index;0;display:block;">
<table cellpadding=0 cellspacing=0 border=0>
	<tr height=2 colspan=2><td></td></tr>
	<tr><td ><a href="javascript:;"><img id="UpdateBtn"
				src="/images/View/bt_myfavoritegolist.gif" border=0 
				onclick="CmdGotoList();"
				></a></td>
		<td valign=bottom style="padding-bottom:4"><% if ( !strAuth.equals("5")) { %><img src=/images/front/bt_myfavoritegolist_info.gif border=0 align=absbottom   style=cursor:hand
		onclick="Main_OpenWindow('/view/Myfavorite_Informationpop.jsp','MyFavorite_Info',392,562,'yes','no',0,0)"
		><% } %></td>
		
	</tr>
	
</table>
</span>

<span ID="MyFavoriteLayer"  Name="MyFavoriteLayer" style="position:absolute;left:0;top:42;z-index:0;width:70;display:block;" align=left>
<%
StringBuffer sBuffer= new StringBuffer();

if( !sUserID.equals(""))
{		
	if ( !strAuth.equals("5") )
	{
		Mem_myfavorite_Data[] mmd = Mem_myfavorite_Proc.getMyFavorite_List(sUserID);
		int icount=0;
		int i=0;
		if(mmd!=null){
  		for( i=0,icount=0; i < mmd.length ; i++ , icount++)
  		{
  		    if (i >= 20) break;
	  		  Goods_Data gd= Goods_Proc.Goods_One(  mmd[i].getG_modelno() );
	  		  if (gd !=null){
	  		  	mmd[i].setG_imgchk( gd.getImgchk());
	  		  }
  		    
  		    sBuffer.append("sMyFavoriteModelNo[sMyFavoriteModelNo.length] = '" + mmd[i].getG_modelno() + "';" + "\n");
  		    sBuffer.append("sMyFavoriteModelNm[sMyFavoriteModelNm.length] = '" + ReplaceStr.replace(ReplaceStr.replace(mmd[i].getG_modelnm(),"\"", "&quot;"),"'","&acute;") + "';" + "\n");
  		    sBuffer.append("sMyFavoriteModelImgChk[sMyFavoriteModelImgChk.length] = '" + mmd[i].getG_imgchk() + "';" + "\n");
  		}
		}
  	}
    else {    	
    	Myever_Data[] mmd2 = Myever_Proc.getData_List(Integer.parseInt(strShopCode));
    	int iever=0;
    	if(mmd2!=null){
    		
    		for (iever=0; iever < mmd2.length; iever++){
    			Goods_Data gd= Goods_Proc.Goods_One(  mmd2[iever].getModelno() );
	  	  		  if (gd !=null){
	  	  		  	mmd2[iever].setImgchk( gd.getImgchk());
	  	  		  }
      		    sBuffer.append("sMyFavoriteModelNo[sMyFavoriteModelNo.length] = '" + mmd2[iever].getModelno() + "';" + "\n");
      		    sBuffer.append("sMyFavoriteModelNm[sMyFavoriteModelNm.length] = '" + ReplaceStr.replace(ReplaceStr.replace(mmd2[iever].getEver_goodsnm(),"\"", "&quot;"),"'","&acute;") + "';" + "\n");
      		    sBuffer.append("sMyFavoriteModelImgChk[sMyFavoriteModelImgChk.length] = '" + mmd2[iever].getImgchk() + "';" + "\n");
      		    sBuffer.append("sMyFavoriteEverNo[sMyFavoriteEverNo.length] = '" + mmd2[iever].getEver_no() + "';" + "\n");
      		    sBuffer.append("sMyFavoriteEverStatus[sMyFavoriteEverStatus.length] = '" + mmd2[iever].getEver_status() + "';" + "\n");
      		    sBuffer.append("sMyFavoriteEverRegFlag[sMyFavoriteEverRegFlag.length] = '" + mmd2[iever].getEver_regflag() + "';" + "\n");
      		    			
    		}
    		
    	}
    	
    	
    }
}
%>
<script language=javascript>
<!--
<%= sBuffer.toString()%>

String.prototype.NumberFormat = function() {
		var str = this.replace(/,/g,"");
		var strLength = str.length;

		if (strLength<=3) return str;
	
		var strOutput = "";
		var mod = 3 - (strLength % 3);
		var i;

		for (i=0; i<strLength; i++) 
		{
			strOutput+=str.charAt(i); 
		    if (i < strLength - 1) 
			{
				mod++; 
		        if ((mod % 3) == 0) 
				{ 
					strOutput +=","; 
		            mod = 0; 
				}
			} 
		} 
		return strOutput;
	}

//사용자가 대량삭제할시 발생하는 문제 처리를 위한 전역변수
var IsProcessCompleted=0; //0:true(처리가능), 1:false 처리불가능;

	function CmdListDelProc()
	{
		var i;
		var szChkNo;
		var aszChkNo;
		
		//클릭된 상품번호
		szChkNo = document.frmTempCheck.Mno.value;

		if(szChkNo=="")
		{
			OpenWindowPosition('/view/Delwarning_Popup.jsp','delwarning','355','150','NO','NO','450','450')
		}else{
			
			aszChkNo = szChkNo.split(",");

		
					location.href="/view/Myfavoritedelproc.jsp?g_modelno="+szChkNo+"&GotoURL=<%=ConfigManager.JSP_SELF(request)%>" ;
			
		}
	}
	function DeleteFromMyFavorite(nos)
	{
		var TmpsMyFavoriteModelNo = new Array();
		var TmpsMyFavoriteModelNm = new Array();
		var TmpsMyFavoriteModelImgChk = new Array();
						
		for(i=0; i< sMyFavoriteModelNo.length ;i++)
		{		
			if ( parseInt(sMyFavoriteModelNo[i]) != parseInt(nos) )
			{	TmpsMyFavoriteModelNo[TmpsMyFavoriteModelNo.length] = sMyFavoriteModelNo[i];
				TmpsMyFavoriteModelNm[TmpsMyFavoriteModelNm.length] = sMyFavoriteModelNm[i];
				TmpsMyFavoriteModelImgChk[TmpsMyFavoriteModelImgChk.length] = sMyFavoriteModelImgChk[i];
			}
		}
		sMyFavoriteModelNo = TmpsMyFavoriteModelNo;
		sMyFavoriteModelNm = TmpsMyFavoriteModelNm;
		sMyFavoriteModelMinPrice = TmpsMyFavoriteModelPrice;
		sMyFavoriteModelImgChk = TmpsMyFavoriteModelImgChk;
		MyFavoriteInitialize();	
	}


	function imgFolder(modelno)
	{
		
		var TmpModelno;
	
		if ( isNaN(modelno)==false)
		{	
			TmpModelno = parseInt(modelno);
			
			if ( TmpModelno < 1000 )
			{	TmpModelno=1;	}
			else
			{	
				TmpModelno = modelno.substring(0, modelno.length-3) + "000";	
			}
			
		}
		
		else
		{				
			TmpModelno=1;	}
		
		return TmpModelno;
	}
	
	function DefaultinsertIntoMyFavorite(smodelno, smodelnm, icount, imgchk)
	{
		try
		{
			var sInsertHTML="";

			sInsertHTML += "<span align=center>\n"
			sInsertHTML += "<table border=0 cellpadding=0 cellspacing=0 width=66 height=52 bgcolor=#D4D4D4>\n" ;
			sInsertHTML += "<tr>\n" ;
			sInsertHTML += "<td colspan=3 height=1></td></tr>\n" ;
			sInsertHTML += "<tr><td width=1 valign=bottom></td>\n" ;
			sInsertHTML += "<td align=left valign=bottom bgcolor=ffffff>";
			sInsertHTML += "<div bgcolor=FFFFFF id='Goods_" + smodelno + "'  align=center vliagn=middle style=\"position:relative;left:0;top:5;z-index:6;cursor:hand;\" onclick=\"Main_OpenWindow('/view/Detailmulti.jsp?modelno=" + smodelno +"&sort_flag=&cate=','list"+smodelno+"','780','600','YES','YES',0,0)\" >";
			
			//sInsertHTML += "<div bgcolor=FFFFFF id='Goods_" + smodelno + "'  align=center vliagn=middle style=\"position:relative;left:0;top:-5;z-index:6;cursor:hand;\" onclick=\"Main_OpenWindow('/view/Detailmulti.jsp?modelno=" + smodelno +"&sort_flag=&cate=','list"+smodelno+"','780','600','YES','YES',0,0)\" >";
			sInsertHTML += "<img align=absmiddle ";
			if( imgchk=="1" || imgchk=="2" || imgchk=="6" || imgchk=="7" || imgchk=="8")
			{
				sInsertHTML += "src='<%=ConfigManager.PHOTO_ENURI_COM%>/data/images/service/small/" + imgFolder(smodelno) +"/"+smodelno+".gif' border=0 width=50 height=50 style='cursor:hand' alt=\""+smodelnm+"\">";
			}
			else if ( imgchk=="4" || imgchk=="5" )
			{
				sInsertHTML += "src='<%=ConfigManager.PHOTO_ENURI_COM%>/data/images/service/big/" + imgFolder(smodelno) +"/"+smodelno+".jpg' border=0 width=50 height=50 style='cursor:hand' alt=\""+smodelnm+"\">";
			}
			else if ( imgchk=="3" ||  imgchk=="9" )
			{
				sInsertHTML += "src='<%=ConfigManager.PHOTO_ENURI_COM%>/data/images/service/small/" + imgFolder(smodelno) +"/"+smodelno+".gif' border=0 width=50 height=50 style='cursor:hand' alt=\""+smodelnm+"\">";				
			}
			else {
					sInsertHTML += "src='<%=ConfigManager.PHOTO_ENURI_COM %>/data/images/service/small/" + imgFolder(smodelno) +"/"+smodelno+".gif' border=0 width=50 height=50 style='cursor:hand' alt=\""+smodelnm+"\"  onError=this.src='<%=ConfigManager.PHOTO_ENURI_COM%>/data/working.gif'>";
			}
		

			sInsertHTML += "</div><div align=right style='width=64;height:0;z-index:99;position:relative;top:0;left:0;cursor:hand'><img src='/images/myfavorite/bt_jjimcheck_01.gif' name='chImg' border='0' onclick=javascript:Click_check('" +icount+"');><input type=hidden name=chk_zzim value='" +smodelno+"'><input type=hidden name=chk_img value=0></div> ";
			
			sInsertHTML += "<td width=1></td></tr>\n" ;
		
			sInsertHTML += "</table>\n";
			sInsertHTML += "</span>\n";
		
	
			MyFavoriteLayer.insertAdjacentHTML("BeforeEnd", sInsertHTML );	
		}
		catch(e)
		{window.status ="일시적으로 장애가 발생하였습니다." ;}
	}

	// 에버몰 용 따로 분리함
	function DefaultinsertIntoMyFavorite_Ever(smodelno, smodelnm, icount, imgchk, everno, everstatus, everregflag)
	{
		try
		{
			var sInsertHTML="";

			sInsertHTML += "<span align=center>\n"
			sInsertHTML += "<table border=0 cellpadding=0 cellspacing=0 width=66 height=52 bgcolor=#D4D4D4>\n" ;
			sInsertHTML += "<tr>\n" ;
			sInsertHTML += "<td colspan=3 height=1></td></tr>\n" ;
			sInsertHTML += "<tr><td width=1 valign=bottom></td>\n" ;
			sInsertHTML += "<td align=left valign=bottom bgcolor=ffffff>";		
			
			//alert(everregflag);
			if ( everregflag == "1") {
		   	sInsertHTML += "<div align=left style='width=64;height:0;z-index:99;font-size:8pt;position:relative;top:1;left:1;cursor:hand' onclick=\"Main_OpenWindow('/edu/Edu_Detail_Frame.asp?iEverNo="+everno+"&iModelno="+smodelno+"','wDetail','897','714','YES','YES',0,0)\"><font color=red>등록대기</font></div> ";
			sInsertHTML += "<div bgcolor=FFFFFF id='Goods_" + smodelno + "'  align=center vliagn=middle style=\"position:relative;left:0;top:-5;z-index:6;cursor:hand;\" onclick=\"Main_OpenWindow('/view/Detailmulti.jsp?modelno=" + smodelno +"&sort_flag=&cate=','list"+smodelno+"','780','600','YES','YES',0,0)\" >";
			} else {
			sInsertHTML += "<div align=left style='width=64;height:0;z-index:99;font-size:8pt;position:relative;top:1;left:1;'></div> ";				
			sInsertHTML += "<div bgcolor=FFFFFF id='Goods_" + smodelno + "'  align=center vliagn=middle style=\"position:relative;left:0;top:-5;z-index:6;cursor:hand;\" onclick=\"Main_OpenWindow('/view/Detailmulti.jsp?modelno=" + smodelno +"&sort_flag=&cate=','list"+smodelno+"','780','600','YES','YES',0,0)\" >";	
			}
		
			//sInsertHTML += "<div bgcolor=FFFFFF id='Goods_" + smodelno + "'  align=center vliagn=middle style=\"position:relative;left:0;top:-5;z-index:6;cursor:hand;\" onclick=\"Main_OpenWindow('/view/Detailmulti.jsp?modelno=" + smodelno +"&sort_flag=&cate=','list"+smodelno+"','780','600','YES','YES',0,0)\" >";
			sInsertHTML += "<img align=absmiddle ";
			if( imgchk=="1" || imgchk=="2" || imgchk=="6" || imgchk=="7" || imgchk=="8")
			{
				sInsertHTML += "src='<%=ConfigManager.PHOTO_ENURI_COM%>/data/images/service/small/" + imgFolder(smodelno) +"/"+smodelno+".gif' border=0 width=50 height=50 style='cursor:hand' alt=\""+smodelnm+"\">";
			}
			else if ( imgchk=="4" || imgchk=="5" )
			{
				sInsertHTML += "src='<%=ConfigManager.PHOTO_ENURI_COM%>/data/images/service/big/" + imgFolder(smodelno) +"/"+smodelno+".jpg' border=0 width=50 height=50 style='cursor:hand' alt=\""+smodelnm+"\">";
			}
			else if ( imgchk=="3" ||  imgchk=="9" )
			{
				sInsertHTML += "src='<%=ConfigManager.PHOTO_ENURI_COM%>/data/images/service/small/" + imgFolder(smodelno) +"/"+smodelno+".gif' border=0 width=50 height=50 style='cursor:hand' alt=\""+smodelnm+"\">";				
			}
			else {
					sInsertHTML += "src='<%=ConfigManager.PHOTO_ENURI_COM %>/data/images/service/small/" + imgFolder(smodelno) +"/"+smodelno+".gif' border=0 width=50 height=50 style='cursor:hand' alt=\""+smodelnm+"\"  onError=this.src='<%=ConfigManager.PHOTO_ENURI_COM%>/data/working.gif'>";
			}
		
			sInsertHTML += "</div>"; //<div align=left style='width=64;height:20;z-index:99;position:relative;top:0;left:0;cursor:hand'><img src='/images/myfavorite/bt_jjimcheck_01.gif' name='chImg' border='0' width=20 height=20></div> ";		
			sInsertHTML += "<td width=1></td></tr>\n" ;
		
			sInsertHTML += "</table>\n";
			sInsertHTML += "</span>\n";
		
	
			MyFavoriteLayer.insertAdjacentHTML("BeforeEnd", sInsertHTML );	
		}
		catch(e)
		{window.status ="일시적으로 장애가 발생하였습니다." ;}
	}

	function MyFavoriteInitialize()
	{	
		<% if(!sUserID.equals("")) {%>
			<% if ( strAuth.equals("5") ) {   %>
				document.all("UpdateBtn").src="/images/evermall/edu/2edu_ani_bdjjim.gif";	
			<% }		%>
			MyFavoriteLayer.innerText="";
			var MaxLength = sMyFavoriteModelNo.length;
			if ( MaxLength > 50 )
			{	MaxLength=50;	}
			
			if (MaxLength >0)
			{	
				MyFavoriteLayer.innerHTML="" ;				
				
				if(sMyFavoriteModelNo.length > 6)
				{
					<% if ( strAuth.equals("5") ) {	%>	// claudy 2005.05.28  에버몰 판매자일때 버튼 바꾸기
					
					var sInsertHTML2="";
					sInsertHTML2 += "<table border=0 cellpadding=0 cellspacing=0 width=66 height=60  bgcolor=#D4D4D4>\n" ;
					sInsertHTML2 += "<tr>\n" ;
					sInsertHTML2 += "<td colspan=3 height=1></td></tr>\n" ;
					sInsertHTML2 += "<tr><td width=1 ></td>\n" ;
					sInsertHTML2 += "<td align=left valign=middle bgcolor=ffffff>";
					
					sInsertHTML2 += "<font color=808080> 위 버튼을<br>클릭하여<br>판매가격을<br>입력하세요.</font>";
					sInsertHTML2 += "<td width=1></td></tr>\n" ;
					sInsertHTML2 += "</table>\n"; 
					MyFavoriteLayer.insertAdjacentHTML("BeforeEnd",sInsertHTML2 );
					<% } else { %>
					var sInsertHTML ="";
					sInsertHTML += "<span id=sdfsddfff><table border=0 cellpadding=0 cellspacing=0 width=66  bgcolor=#D4D4D4>";
					sInsertHTML += "<tr><td height=1 bgcolor=#FFFFFF></td></tr>";
					sInsertHTML += "<tr><td align=center><a href=javascript:compChkValue();><img src=/images/button/bt_jjimcompare_sm.gif border=0></a><a href=javascript:CmdListDelProc();><img src=/images/button/bt_jjimcompare_del.gif border=0></a></td></tr></table></span>\n";
					MyFavoriteLayer.insertAdjacentHTML("BeforeEnd", sInsertHTML );
					<% } %>
				}
				
				<% if ( !strAuth.equals("5") ) {	%>
				for ( icount=0 ; icount < MaxLength; icount++)
				{	
					DefaultinsertIntoMyFavorite( sMyFavoriteModelNo[icount], sMyFavoriteModelNm[icount], icount, sMyFavoriteModelImgChk[icount] );
					
				}
				<% } else { %>
				for ( icount=0 ; icount < MaxLength; icount++)
				{	
					DefaultinsertIntoMyFavorite_Ever( sMyFavoriteModelNo[icount], sMyFavoriteModelNm[icount], icount, sMyFavoriteModelImgChk[icount], sMyFavoriteEverNo[icount], sMyFavoriteEverStatus[icount], sMyFavoriteEverRegFlag[icount]  );					
				}	
				<% } %>
				var sInsertHTML ="";
				sInsertHTML += "<span id=sdfsddf><table border=0 cellpadding=0 cellspacing=0 width=66  bgcolor=#D4D4D4>";
				sInsertHTML += "<tr><td height=1></td></tr></table></span>\n";
				MyFavoriteLayer.insertAdjacentHTML("BeforeEnd", sInsertHTML );
				
				//## shwoo 변환예정
				<% if ( !strAuth.equals("5") ) {	%>	// claudy 2005.05.28  에버몰 판매자일때 버튼 바꾸기	
				
				var sInsertHTML ="";
				sInsertHTML += "<span id=sdfsddfff><table border=0 cellpadding=0 cellspacing=0 width=66  bgcolor=#D4D4D4>";
				sInsertHTML += "<tr><td height=1 bgcolor=#FFFFFF></td></tr>";
				sInsertHTML += "<tr><td align=center><a href=javascript:compChkValue();><img src=/images/button/bt_jjimcompare_sm.gif border=0></a><a href=javascript:CmdListDelProc();><img src=/images/button/bt_jjimcompare_del.gif border=0></a></td></tr></table></span>\n";
				MyFavoriteLayer.insertAdjacentHTML("BeforeEnd", sInsertHTML );
				<% }	%>
			}
			else
			{
				var sInsertHTML2="";
				sInsertHTML2 += "<table border=0 cellpadding=0 cellspacing=0 width=66 height=60  bgcolor=#D4D4D4>\n" ;
				sInsertHTML2 += "<tr>\n" ;
				sInsertHTML2 += "<td colspan=3 height=1></td></tr>\n" ;
				sInsertHTML2 += "<tr><td width=1 ></td>\n" ;
				sInsertHTML2 += "<td align=center valign=middle bgcolor=ffffff>";
				
				sInsertHTML2 += "<font color=808080> 찜하신<br>상품이<br>없습니다.</font>";
				sInsertHTML2 += "<td width=1></td></tr>\n" ;
				sInsertHTML2 += "</table>\n"; 
				MyFavoriteLayer.insertAdjacentHTML("BeforeEnd",sInsertHTML2 );

				var sInsertHTML ="";
				sInsertHTML += "<span id=sdfsddf><table border=0 cellpadding=0 cellspacing=0 width=66  bgcolor=#D4D4D4>";
				sInsertHTML += "<tr><td height=1></td></tr></table></span>\n";
				MyFavoriteLayer.insertAdjacentHTML("BeforeEnd", sInsertHTML );

			}
		
		<% }else{ %>
			/*
			var sInsertHTML2="";
				sInsertHTML2 += "<table border=0 cellpadding=0 cellspacing=0 width=66  bgcolor=#D4D4D4>\n" ;
				sInsertHTML2 += "<tr>\n" ;
				sInsertHTML2 += "<td colspan=3 height=1></td></tr>\n" ;
				sInsertHTML2 += "<tr ><td width=1 ></td>\n" ;
				sInsertHTML2 += "<td align=center valign=bottom bgcolor=ffffff>";
				
				sInsertHTML2 += "<font color=808080> 로그인하면<br>찜 상품이<br>보입니다.</font>";
				sInsertHTML2 += "<td width=1></td></tr>\n" ;
				sInsertHTML2 += "</table>\n"; 
				MyFavoriteLayer.insertAdjacentHTML("BeforeEnd",sInsertHTML2 );
				
			var sInsertHTML ="";
				sInsertHTML += "<span id=sdfsddf><table border=0 cellpadding=0 cellspacing=0 width=66  bgcolor=#D4D4D4>";
				sInsertHTML += "<tr><td height=1></td></tr></table></span>\n";
				MyFavoriteLayer.insertAdjacentHTML("BeforeEnd", sInsertHTML );		
				*/

		<% }%>

		
		
	}


	function insertIntoMyFavorite(smodelno, smodelnm, minprice, imgchk)
	{
		try{
		var isExists=false;
		var NoFindIndex=-1;
		
			
			for(i=0; i < sMyFavoriteModelNo.length;i++)
			{
				if ( parseInt(sMyFavoriteModelNo[i])== parseInt(smodelno) )
				{
					isExists=true;
					NoFindIndex =i;
					break;
				}				
			} 
		
				if (isExists == false )
				{	
					
					var TmpsMyFavoriteModelNo = new Array();
					var TmpsMyFavoriteModelNm = new Array();
					var TmpsMyFavoriteModelImgChk = new Array();
					TmpsMyFavoriteModelNo[0] = smodelno;
					TmpsMyFavoriteModelNm[0] = smodelnm;
					TmpsMyFavoriteModelImgChk[0] = imgchk ;
					for(i=0; i< sMyFavoriteModelNo.length ;i++)
					{	TmpsMyFavoriteModelNo[TmpsMyFavoriteModelNo.length] = sMyFavoriteModelNo[i];
						TmpsMyFavoriteModelNm[TmpsMyFavoriteModelNm.length] = sMyFavoriteModelNm[i];
						TmpsMyFavoriteModelImgChk[TmpsMyFavoriteModelImgChk.length] = sMyFavoriteModelImgChk[i];
					}
					
					sMyFavoriteModelNo = TmpsMyFavoriteModelNo;
					sMyFavoriteModelNm = TmpsMyFavoriteModelNm;
					sMyFavoriteModelImgChk = TmpsMyFavoriteModelImgChk;
					MyFavoriteInitialize();
					
				}
				else
				{	
					var TmpsMyFavoriteModelNo = new Array();
					var TmpsMyFavoriteModelNm = new Array();
					var TmpsMyFavoriteModelImgChk = new Array();
					TmpsMyFavoriteModelNo[0] = smodelno;
					TmpsMyFavoriteModelNm[0] = smodelnm;
					TmpsMyFavoriteModelImgChk[0] = imgchk ;
					for(i=0; i< sMyFavoriteModelNo.length ;i++)
					{		
						if ( parseInt(sMyFavoriteModelNo[i]) != parseInt(smodelno) )
						{	TmpsMyFavoriteModelNo[TmpsMyFavoriteModelNo.length] = sMyFavoriteModelNo[i];
							TmpsMyFavoriteModelNm[TmpsMyFavoriteModelNm.length] = sMyFavoriteModelNm[i];
							TmpsMyFavoriteModelImgChk[TmpsMyFavoriteModelImgChk.length] = sMyFavoriteModelImgChk[i];
						}
					}
					sMyFavoriteModelNo = TmpsMyFavoriteModelNo;
					sMyFavoriteModelNm = TmpsMyFavoriteModelNm;
					sMyFavoriteModelImgChk = TmpsMyFavoriteModelImgChk;
					MyFavoriteInitialize();
				}
		
		}catch(e){window.status=e;}
	}

String.prototype.trim = function() {
      return this.replace(/(^\s*)|(\s*$)|($\s*)/g, "");
   }



function Click_check(Seqno)
{
	var i, j;
	var strSaveChk, strTmpSaveChk;
	var astrSaveChk;
	var strDelModelno;
	var maxCompareNo=5;

	strSaveChk = document.frmTempCheck.Mno.value;

	//저정된 Mno가 하나라도 있으면...
	if (sMyFavoriteModelNo.length > 1 )
	{	
		//방금클릭한이미지의 hidden값이 있으면
		if (document.all.chk_img[Seqno].value=="0")
		{
			if (strSaveChk == "") 
			{	strSaveChk = document.all.chk_zzim[Seqno].value;	}
			else
			{	strSaveChk = strSaveChk +","+ document.all.chk_zzim[Seqno].value;	}

			document.all.chk_img[Seqno].value="1";
			document.all.chImg[Seqno].src = "/images/myfavorite/bt_jjimcheck_02.gif";

			astrSaveChk = strSaveChk.split(",");
			j = astrSaveChk.length;
				
			if ( j > maxCompareNo)
			{
				// uchecked
				for( i=0; i < sMyFavoriteModelNo.length ; i++)
				{
					if(document.all.chk_zzim[i].value == astrSaveChk[0])
					{	
						document.all.chk_img[i].value="0";
						document.all.chImg[i].src = "/images/myfavorite/bt_jjimcheck_01.gif";
					}
				}

				// save
				strTmpSaveChk = "";
				for(i=1;i<=maxCompareNo;i++)
				{
					if(strTmpSaveChk.length==0)	
					{	strTmpSaveChk= astrSaveChk[i];	}
					else
					{	strTmpSaveChk = strTmpSaveChk + "," + astrSaveChk[i];	}
				}	
					
				strSaveChk = strTmpSaveChk;
			}
		}
		else
		{
			astrSaveChk = strSaveChk.split(",");
			strDelModelno = document.all.chk_zzim[Seqno].value;
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
				
			document.all.chk_img[Seqno].value="0";
			document.all.chImg[Seqno].src = "/images/myfavorite/bt_jjimcheck_01.gif";
	
	
			strSaveChk = strTmpSaveChk;
		}

		document.frmTempCheck.Mno.value = strSaveChk;
		

	}	
	else
	{
		if(document.all.chk_img.value=="1")
		{
			document.all.chk_img.value="0";
			document.all.chImg.src = "/images/myfavorite/bt_jjimcheck_01.gif";
			document.frmTempCheck.Mno.value = "";
		}else{
			document.all.chk_img.value="1";
			document.all.chImg.src = "/images/myfavorite/bt_jjimcheck_02.gif";
			document.frmTempCheck.Mno.value = document.all.chk_zzim.value;
		}

	}
	
	//alert(document.frmTempCheck.Mno.value);
}

function CheckComparison(Seqno)
{
	var i, j;
	var strSaveChk, strTmpSaveChk;
	var astrSaveChk;
	var strDelModelno;
	var maxCompareNo=5;

	strSaveChk = document.frmTempCheck.Mno.value;

	if (sMyFavoriteModelNo.length > 1 )
	{
		if (document.all.chk_zzim[Seqno].checked == true)
		{
			if (strSaveChk == "") 
			{	strSaveChk = document.all.chk_zzim[Seqno].value;	}
			else
			{	strSaveChk = strSaveChk +","+ document.all.chk_zzim[Seqno].value;	}
				
			astrSaveChk = strSaveChk.split(",");
			j = astrSaveChk.length;
				
			if ( j > maxCompareNo)
			{
				// uchecked
				for( i=0; i < sMyFavoriteModelNo.length ; i++)
				{
					if(document.all.chk_zzim[i].value == astrSaveChk[0])
					{	document.all.chk_zzim[i].checked = false;	}
				}

				// save
				strTmpSaveChk = "";
				for(i=1;i<=maxCompareNo;i++)
				{
					if(strTmpSaveChk.length==0)	
					{	strTmpSaveChk= astrSaveChk[i];	}
					else
					{	strTmpSaveChk = strTmpSaveChk + "," + astrSaveChk[i];	}
				}	
					
				strSaveChk = strTmpSaveChk;
			}
		}
		else
		{
			astrSaveChk = strSaveChk.split(",");
			strDelModelno = document.all.chk_zzim[Seqno].value;
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

		document.frmTempCheck.Mno.value = strSaveChk;
	}	
	else
	{
		document.frmTempCheck.Mno.value = document.all.chk_zzim[Seqno].value;
	}

	//alert(document.frmTempCheck.Mno.value);
		
}


function compChkValue(cmd)
{
	var szChkNo;
	var aszChkNo;
	var Obj = eval("document.frmTempCheck");
	if ( typeof(Obj)=="object" )
	{
		var Obj2 = eval("document.frmTempCheck.Mno");
		if (typeof(Obj2)=="object")
		{
			szChkNo = document.frmTempCheck.Mno.value;
					
			aszChkNo = szChkNo.split(",");
					
			if (aszChkNo.length <= 1){
				OpenWindowPosition('/view/Towcheck_Popup.jsp','towcheck','355','150','NO','NO','450','450')
			} 
			else 
			{
				OpenWindow('/view/Comparemulti.jsp?cmd='+ cmd +'&chkNo='+ szChkNo +'&cate=&chksetno=1','Compare','700','600','YES','YES');
					
					
			}
		}
	}
}

function insertZzimInfo()
{

}

function CmdGotoURL(sURL,sWinName,  isLogin, sRtnTarget, sWidth, sHeight, sScrollbars, sResizable, sToolbar)
{
	URL = sURL;
	try {
		//로그인 안됏을경우
		if (isLogin=="false")
		{
			OpenWindow(URL,sWinName,355,180,'no','no','no');
			//window.open(OpenFile,name,"width="+nWidth+",height="+nHeight+",toolbar="+ ToolbarYesNo +",directories="+ ToolbarYesNo +",status="+ ToolbarYesNo +",scrollbars="+ ScrollYesNo +",resizable="+ ResizeYesNo +",menubar="+ ToolbarYesNo +",left=300,top=300");
			//window.open("http://www,naver.com","sdf","width=600, height=500");
		}
		else
		{
			if(sRtnTarget=="_blank" || sRtnTarget=="_blank_useful")
			{
				OpenWindow(URL,sWinName,"true",sRtnTarget,sWidth,sHeight,sScrollbars,sResizable, sToolbar );
			}
			else if (sRtnTarget=="esdefault")
			{
				opener.document.FrmRedirectEnuri.target ="enuri_bodyframe";
				opener.document.FrmRedirectEnuri.action = "/Default_Es.jsp";
				opener.document.FrmRedirectEnuri.submit(); 
			}
			else if (sRtnTarget=="_top")
			{
				parent.top.location.href=sURL;
			}
			else
			{
				if(parent)
				{	parent.location.href=URL;	}
				else
				{	if(sWinName != "") 
						eval(sWinName+".location").href=URL;
				}
			}
		}
	}
	catch(e)
	{
		window.status =e;
	}
	
}

//-->
</script>


</span>
<form name="frmTempCheck">
	<input type="hidden" name="Mno" value="">
</form>
<form name="frmMainLogin" method="post" action="/login/Login_Islogin.jsp" target="ifrmForLogin">
<input type="hidden" name="rtnTarget" value="parent.parent">
<% if(!sUserID.equals("")){%>
<% 		if ( !strAuth.equals("5")) { %>
	<input type="hidden" name="rtnUrl" value="/view/Myfavoriteselectlist.jsp?f_login=true">
<% 		} else { %>				
	<input type="hidden" name="rtnUrl" value="/edu/edu_list.asp">
<%		} %>
<% 	} else { %>
	<input type="hidden" name="rtnUrl" value="/view/Myfavoriteselectlist.jsp?f_login=true">
<%	} %>

</form>
</body>
</html>
