	//###  20040615 sky 에스크로 로그인 체크후 에스크로 팝업. ###//
	function CmdGotoURL(urltype, cmd, sCode, sName, mNo, mName, mFactory, mPrice, multiFlag, iPlNo, sPlGoodsNm, sUrl, ismin)
	{
		alert('ttt');
		 //if(urltype==1 || urltype==10 || urltype==11 ){
		var location = "yes";
		if(urltype==1 ||urltype==0 || urltype==11){
			if(urltype!=0){
				location = "no";
				}
			var w = window.screen.width-70;
			var h = window.screen.height-220;
			var k = window.open ("","Direct"+iPlNo+"","width="+w+" height="+h+" toolbar=yes,location="+location+",directories=yes,status=yes,scrollbars=yes,resizable=yes,menubar=yes");
				k.moveTo(20,20);		
			
			var strURL = "/escrow/EsFrmOrderMain.jsp";
			strURL += "?cmd=" + cmd;
			strURL += "^frmshopcode=" + sCode;
			strURL += "^frmshopnm=" + sName;
			strURL += "^frmmodelno=" + mNo;
			strURL += "^frmmodelnm=" + mName;
			strURL += "^frmfactory=" + mFactory;
			strURL += "^frmmprice=" + mPrice;
			strURL += "^frmmultiflag=" + multiFlag;
			strURL += "^frmpl_no=" + iPlNo;
			strURL += "^frmpl_goodsnm=" + sPlGoodsNm;
			strURL += "^frmurl=" + js_replace(sUrl,"^","<$>"); 		
			
			fmRedirectProc.cmd.value = cmd;
			fmRedirectProc.vcode.value=sCode;
			fmRedirectProc.modelno.value= mNo;
			fmRedirectProc.price.value=mPrice;
			fmRedirectProc.multiflag.value=multiFlag;
			fmRedirectProc.pl_no.value=iPlNo;
			fmRedirectProc.factory.value=mFactory;
			fmRedirectProc.modelnm.value=mName;
			fmRedirectProc.url.value=js_replace(sUrl,"^","<$>");
			//fmRedirectProc.gubun.value="escrow";
			fmRedirectProc.escrow_url.value=strURL;
			fmRedirectProc.cate.value="<%=strCate%>";
			fmRedirectProc.urltype.value=urltype;
			fmRedirectProc.target = "Direct"+iPlNo;
			fmRedirectProc.action = "/move/Redirect.jsp";
			fmRedirectProc.submit();
			return;
		}else if(urltype==10){	
			var k = window.open ("","ESWINDS"+iPlNo+"","width=1010 height=700 scrollbars=yes ");
			fmEscrowProc.cmd.value=cmd;
			fmEscrowProc.frmshopcode.value=sCode;
			fmEscrowProc.frmshopnm.value=sName;
			fmEscrowProc.frmmodelno.value=mNo;
			fmEscrowProc.frmmodelnm.value=mName;
			fmEscrowProc.frmfactory.value=mFactory;
			fmEscrowProc.frmmprice.value=mPrice;
			fmEscrowProc.frmmultiflag.value=multiFlag;
			fmEscrowProc.frmpl_no.value=iPlNo;
			fmEscrowProc.frmpl_goodsnm.value=sPlGoodsNm;
			fmEscrowProc.frmurl.value= js_replace(sUrl,"^","<$>");;
			fmEscrowProc.target = "ESWINDS"+iPlNo;
			fmEscrowProc.action = "/escrow/EsFrmOrderMain.jsp";
			fmEscrowProc.submit();
			return;
			
		}
		
		
	}

