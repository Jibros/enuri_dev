<%
	Detail_Notice_Proc detail_notice_proc = new Detail_Notice_Proc();
	Detail_Notice_Data detail_notice_data = null;
	
	//주의사항
	int leftMainWidth = 300;
	String strDn_popup = "";
	String strDn_simple = "";
	String strDn_print = "";
	String strDn_flag = "";
	String strDn_end_notice = "";
	String strDn_end_notice_print = "";
	String strDn_notice_no_1 = "";
	String strDn_notice_no_2 = "";
	String strDn_notice_no_1_print = "";
	String strDn_notice_no_2_print = "";
	String cur_date1 = "";
	String dDate = ConfigManager.RequestStr(request, "dDate", "");
	String strDetailMail = ConfigManager.RequestStr(request, "strDetailMail", "");
	
	String strDn_notice = ChkNull.chkStr(request.getParameter("dn_notice"));
	String strDn_position = ChkNull.chkStr(request.getParameter("dn_position"));
	String strDn_end_notice_bottom = ChkNull.chkStr(request.getParameter("dn_end_notice_bottom"));
	//주의사항  end
	

	detail_notice_data = detail_notice_proc.getDetail_Detailnotice(strCa_code, strFactory);

	/** 모델 카타로그에 <주의사항 관리자 입력내용으로 보이기 2009.02.16 toodoo ============================*/
	Detail_Notice_Data detail_catalognotice_data = null;
	String strCatalogNoticePK = ""; //모델별 주의사항 표시
	int intBeginIndex_CatalogNoticePK = 0;
	int intEndIndex_CatalogNoticePK = 0;
	String strCatalogNotice = "";
	String strCatalogDn_position = "";
	
	// 화장품 분류 일반 주의사항 이지만 예외로 제거 하기
	if(CutStr.cutStr(strCa_code,6).equals("080106") && strModelnm.indexOf("[기획세트]")>-1) {
		if(detail_notice_data.getDn_position().equals("0")) {
			detail_notice_data.setDn_position("");
		}
	}

	// 휴대폰 주의 사항 추가
	if(CutStr.cutStr(strCa_code,4).equals("0304") && strFunc_temp.indexOf("<주의사항")==-1) {
		if(strModelnm.indexOf("(번호이동)")>-1) strFunc_temp = "<주의사항45>\r\n" + strFunc_temp;
		if(strModelnm.indexOf("(신규)")>-1) strFunc_temp = "<주의사항46>\r\n" + strFunc_temp;
		if(strModelnm.indexOf("(보상)")>-1) strFunc_temp = "<주의사항47>\r\n" + strFunc_temp;
		if(strModelnm.indexOf("보상[2G→3G]")>-1) strFunc_temp = "<주의사항48>\r\n" + strFunc_temp;
		if(strModelnm.indexOf("보상[3G→3G]")>-1) strFunc_temp = "<주의사항49>\r\n" + strFunc_temp;
		if(strModelnm.indexOf("행복기변")>-1) strFunc_temp = "<주의사항50>\r\n" + strFunc_temp;
		if(strModelnm.indexOf("(지정요금제-번호이동)")>-1) strFunc_temp = "<주의사항51>\r\n" + strFunc_temp;
		if(strModelnm.indexOf("(지정요금제-신규)")>-1) strFunc_temp = "<주의사항52>\r\n" + strFunc_temp;
		if(strModelnm.indexOf("(지정요금제-보상)")>-1) strFunc_temp = "<주의사항53>\r\n" + strFunc_temp;
		if(strModelnm.indexOf("해외출시폰")>-1) strFunc_temp = "<주의사항56>\r\n" + strFunc_temp;
//	out.println("strFunc_temp="+strFunc_temp);
	}
	//자동차 차종선택
	if(CutStr.cutStr(strCa_code,2).equals("21") && strModelnm.indexOf("차종선택")>0 && strFunc_temp.indexOf("<주의사항210")==-1) {
		strFunc_temp = "<주의사항210>\r\n" + strFunc_temp;
	}
	// 주의 문구 예외
	if(strFunc_temp.indexOf("<주의사항")==-1) {
		if(strModelnm.indexOf("[옵션필수]")>-1) strFunc_temp = "<주의사항77>\r\n" + strFunc_temp;
		if(strModelnm.indexOf("[전시]")>-1) strFunc_temp = "<주의사항74>\r\n" + strFunc_temp;
		if(strModelnm.indexOf("[리퍼]")>-1) strFunc_temp = "<주의사항73>\r\n" + strFunc_temp;
	}

	// 중고 반품일 경우 주의사항 100추가
	if(strFunc_temp.indexOf("<주의사항")==-1) {
		if(strModelnm.indexOf("중고품")>-1) strFunc_temp = "<주의사항100>\r\n" + strFunc_temp;
	}

	// 에어컨 예약판매 주의사항 추가
	if(CutStr.cutStr(strCa_code,4).equals("0501") && strFunc_temp.indexOf("<주의사항")==-1) {
		if(strModelnm.indexOf("[예약판매]")>-1) strFunc_temp = "<주의사항11>\r\n" + strFunc_temp;
	}
	if(strFunc_temp.indexOf("<주의사항") > -1) {
		intBeginIndex_CatalogNoticePK = strFunc_temp.indexOf("<주의사항");
		intEndIndex_CatalogNoticePK = strFunc_temp.indexOf(">",strFunc_temp.indexOf("<주의사항"))+1;
	
		if (intBeginIndex_CatalogNoticePK>=0 && intEndIndex_CatalogNoticePK>intBeginIndex_CatalogNoticePK) {
			strCatalogNoticePK = strFunc_temp.substring(strFunc_temp.indexOf("<주의사항"),strFunc_temp.indexOf(">",strFunc_temp.indexOf("<주의사항"))+1);
			detail_catalognotice_data = detail_notice_proc.getDetail_Detailnotice(strCatalogNoticePK, "");

			strCatalogDn_position = detail_catalognotice_data.getDn_position();
			strCatalogNotice = detail_catalognotice_data.getDn_popup();
			strCatalogNotice = ReplaceStr.replace(strCatalogNotice,"<!--icon-->","<img src='"+IMG_ENURI_COM+"/images/detail/notice/attention_blt01.gif' style='vertical-align: middle;'>");
			strCatalogNotice = ReplaceStr.replace(strCatalogNotice,"&amp;","&");

			strFunc_temp = ReplaceStr.replace(strFunc_temp, strCatalogNoticePK+"\r\n", "");
		}
	}
	/** =======================================================================================*/
	
	strDn_end_notice += "<img src="+IMG_ENURI_COM+"/images/detail/notice/attention_blt01.gif style='vertical-align: middle;'> <font style=font-size:8pt>우측 쇼핑몰들의 상품설명도 클릭해 보세요.→</font><br>";
	strDn_end_notice += "<img src="+IMG_ENURI_COM+"/images/detail/notice/attention_blt01.gif style='vertical-align: middle;'> <font style=font-size:8pt;color:red>무단복제 엄금</font> <b>eNuri.com</b><br>";
	strDn_end_notice += "<img src="+IMG_ENURI_COM+"/images/detail/notice/attention_blt01.gif style='vertical-align: middle;'> <font style=font-size:8pt;>위 제조사명(판매사명,브랜드명) 및 로고는</font><br>";
	strDn_end_notice += "&nbsp;&nbsp;&nbsp;<font style=font-size:8pt;>위 제조사(판매사)의 상표나</font> ";
	if(strDetailMail.equals("YES")){
		strDn_end_notice += "<a href=\"http://www.enuri.com/escrow/myenuri/Esguidemain.jsp?pagecode=441\" target=\"_blank\"><span style=\"cursor:pointer;font-size:8pt\"><u>등록상표</u></span></a>";
	}else{
		strDn_end_notice += "<span style=\"cursor:pointer;font-size:8pt\" onclick=\"javascript:Sub_OpenWindow(&#39;/escrow/myenuri/Esguidemain.jsp?pagecode=441&#39;,&#39;Information&#39;,&#39;658&#39;,&#39;370&#39;,&#39;YES&#39;,&#39;YES&#39;,0,0);\"><u>등록상표</u></span>";		
	}
	strDn_end_notice += "입니다.</span>";

	strDn_end_notice_print += "<img src="+IMG_ENURI_COM+"/images/detail/notice/attention_blt01.gif style='vertical-align: middle;'> <font style=font-size:8pt>우측 쇼핑몰들의 상품설명도 클릭해<br>&nbsp;&nbsp;&nbsp;보세요.→</font><br>";
	strDn_end_notice_print += "<img src="+IMG_ENURI_COM+"/images/detail/notice/attention_blt01.gif style='vertical-align: middle;'> <font style=font-size:8pt;color:red>무단복제 엄금</font> <b>eNuri.com</b><br>";
	strDn_end_notice_print += "<img src="+IMG_ENURI_COM+"/images/detail/notice/attention_blt01.gif style='vertical-align: middle;'> <font style=font-size:8pt;>위 제조사명(판매사명,브랜드명) 및<br></font>";
	strDn_end_notice_print += "&nbsp;&nbsp;&nbsp;<font style=font-size:8pt;>로고는 위 제조사(판매사)의 상표나</font><br>&nbsp;&nbsp;&nbsp;";
	if(strDetailMail.equals("YES")){
		strDn_end_notice_print += "<a href=\"http://www.enuri.com/escrow/myenuri/Esguidemain.jsp?pagecode=441\" target=\"_blank\"><span style=\"cursor:pointer;font-size:8pt\"><u>등록상표</u></span></a>";
	}else{
		strDn_end_notice_print += "<span style=\"cursor:pointer;font-size:8pt\" onclick=\"javascript:Sub_OpenWindow(&#39;/escrow/myenuri/Esguidemain.jsp?pagecode=441&#39;,&#39;Information&#39;,&#39;658&#39;,&#39;370&#39;,&#39;YES&#39;,&#39;YES&#39;,0,0);\"><u>등록상표</u></span>";		
	}
	strDn_end_notice_print += "입니다.</span>";

	strDn_end_notice_bottom = "";

	strDn_notice_no_1 = "<img src="+IMG_ENURI_COM+"/images/detail/notice/attention_blt01.gif style='vertical-align: middle;'> 상품 상세설명은 우측 쇼핑몰에서 <img src="+IMG_ENURI_COM+"/images/detail/easy/order_btn.gif align=absmiddle>을<br>&nbsp;&nbsp;&nbsp;클릭하여 해당 쇼핑몰에서 확인하세요.<br>";
	strDn_notice_no_2 = "<img src="+IMG_ENURI_COM+"/images/detail/notice/attention_blt01.gif style='vertical-align: middle;'> 위 제조사명(판매사명,브랜드명) 및 로고는<br>";
	strDn_notice_no_2 += "&nbsp;&nbsp;&nbsp;위 제조사(판매사)의 상표나 ";
	if(strDetailMail.equals("YES")){
		strDn_notice_no_2 += "<a href=\"http://www.enuri.com/escrow/myenuri/Esguidemain.jsp?pagecode=441\" target=\"_blank\"><span style=\"cursor:pointer;\"><u>등록상표</u></span></a>";
	}else{
		strDn_notice_no_2 += "<span style=\"cursor:pointer;\" onclick=\"javascript:Sub_OpenWindow(&#39;/escrow/myenuri/Esguidemain.jsp?pagecode=441&#39;,&#39;Information&#39;,&#39;658&#39;,&#39;370&#39;,&#39;YES&#39;,&#39;YES&#39;,0,0);\"><u>등록상표</u></span>";
	}
	strDn_notice_no_2 += "입니다.</span>";

	strDn_notice_no_1_print = "<img src="+IMG_ENURI_COM+"/images/detail/notice/attention_blt01.gif style='vertical-align: middle;'> 상품 상세설명은 우측 쇼핑몰에서<br>&nbsp;&nbsp;&nbsp;<img src="+IMG_ENURI_COM+"/images/detail/easy/order_btn.gif align=absmiddle>을 클릭하여 해당 쇼핑몰에서<br>&nbsp;&nbsp;&nbsp;확인하세요.<br>";
	strDn_notice_no_2_print = "<img src="+IMG_ENURI_COM+"/images/detail/notice/attention_blt01.gif style='vertical-align: middle;'> 위 제조사명(판매사명,브랜드명) 및<br>";
	strDn_notice_no_2_print += "&nbsp;&nbsp;&nbsp;로고는 위 제조사(판매사)의 상표나<br>&nbsp;&nbsp;&nbsp;";
	if(strDetailMail.equals("YES")){
		strDn_notice_no_2_print += "<a href=\"http://www.enuri.com/escrow/myenuri/Esguidemain.jsp?pagecode=441\" target=\"_blank\"><span style=\"cursor:pointer;\"><u>등록상표</u></span></a>";
	}else{
		strDn_notice_no_2_print += "<span style=\"cursor:pointer;\" onclick=\"javascript:Sub_OpenWindow(&#39;/escrow/myenuri/Esguidemain.jsp?pagecode=441&#39;,&#39;Information&#39;,&#39;658&#39;,&#39;370&#39;,&#39;YES&#39;,&#39;YES&#39;,0,0);\"><u>등록상표</u></span>";		
	}
	strDn_notice_no_2_print += "입니다.</span>";

	if((!strCatalogNotice.equals("") && !strCatalogDn_position.equals("")) || (detail_notice_data != null && !detail_notice_data.getDn_position().equals(""))) {
		if(detail_notice_data != null && !detail_notice_data.getDn_position().equals("")){
			strDn_popup = ReplaceStr.replace(ReplaceStr.replace(ReplaceStr.replace(detail_notice_data.getDn_popup(),"<!--icon-->","<img src="+IMG_ENURI_COM+"/images/detail/notice/attention_blt01.gif style='vertical-align: middle;'>"),"&#34;","\""),"&amp;nbsp;","&nbsp;");
			strDn_print = ReplaceStr.replace(ReplaceStr.replace(ReplaceStr.replace(detail_notice_data.getDn_print(),"<!--icon-->","<img src="+IMG_ENURI_COM+"/images/detail/notice/attention_blt01.gif style='vertical-align: middle;'>"),"&#34;","\""),"&amp;nbsp;","&nbsp;");
			strDn_position = detail_notice_data.getDn_position();
			strDn_flag = detail_notice_data.getDn_flag();
		}else{ //분류별 주의사항이 없을땐 모델주의사항으로 세팅
			strDn_popup = strCatalogNotice;
			strDn_print = strDn_popup;
			strDn_position = strCatalogDn_position;
			strDn_flag = "0";
			
			strCatalogNotice = "";
			strCatalogDn_position = "";
		}
		strDn_popup = strDn_popup.replace("detail/more_btn","blank");
		//strDn_popup = strDn_popup.replace("<a href","<!--");
		//strDn_popup = strDn_popup.replace("a>","-->");
		//strDn_popup = strDn_popup.replace("<span","<!--span");
		//strDn_popup = strDn_popup.replace("span>","span-->");
		
		//strCatalogNotice = strCatalogNotice.replace("detail/more_btn","blank");
		//strCatalogNotice = strCatalogNotice.replace("<a href","<!--");
		//strCatalogNotice = strCatalogNotice.replace("a>","-->");
		//strCatalogNotice = strCatalogNotice.replace("<span","<!--span");
		//strCatalogNotice = strCatalogNotice.replace("span>","span-->");
		
		
		
		//strDn_popup = strDn_popup.replaceAll("<br>","");
		//strCatalogNotice = strCatalogNotice.replaceAll("<br>","");
		
		
		if(CutStr.LenH(strFunc_temp) > 20 && !strDn_popup.equals("") && (strDn_position.equals("1") || strDn_position.equals(""))) { //카달로그 있고 아래일때

			//if(!strCatalogNotice.equals("")){
			if(!strCatalogNotice.equals("") ){
				/**
				모델주의사항이 위일때 :
				위에는 모델주의사항
				아래는 분류주의사항 + 기본주의사항
				*/
				strDn_position = "0";
				strDn_notice = "<div class=\"caretxt\"><span class=\"title\">주의사항</span><br />";
				strDn_notice += "	<ul class=\"goods_add_center\">";
				strDn_notice += "		<li class=\"goods_add_sub\">";
				strDn_notice += strCatalogNotice;
				strDn_notice += "<br>" + strDn_popup ;
				strDn_notice += "		</li>";
				strDn_notice += "	</ul>";
				strDn_notice += "</div>";
				out.println(strDn_notice);
			}else{
				/**
				모델주의사항이 없을때 :
				주의사항은 모델주의사항일수도 있고 분류주의사항일 수도 있지만 어쨌든
				아래에 주의사항 + 기본주의사항
				*/
				strDn_notice = "<div class=\"caretxt\"><span class=\"title\">주의사항</span><br />";
				strDn_notice += "	<ul class=\"goods_add_center\">";
				strDn_notice += "		<li class=\"goods_add_sub\">";
				strDn_notice += strDn_popup ;
				strDn_notice += "		</li>";
				strDn_notice += "	</ul>";
				strDn_notice += "</div>";
				out.println(strDn_notice);
						
			}
		} else if(CutStr.LenH(strFunc_temp) > 20) { //카달로그 있고 위일때
			if(!strCatalogNotice.equals("")){
				/**
				모델주의사항이 위일때 :
				위에는 모델주의사항 + 분류주의사항
				아래는 기본주의사항
				*/
				strDn_notice = "<div class=\"caretxt\"><span class=\"title\">주의사항</span><br />";
				strDn_notice += "	<ul class=\"goods_add_center\">";
				strDn_notice += "		<li class=\"goods_add_sub\">";
				strDn_notice += strCatalogNotice ;
				strDn_notice += "<br>" + strDn_popup;
				strDn_notice += "		</li>";
				strDn_notice += "	</ul>";
				strDn_notice += "</div>";
				out.println(strDn_notice);
			}else{
				/**
				모델주의사항이 없을때 :
				주의사항은 모델주의사항일수도 있고 분류주의사항일 수도 있지만 어쨌든
				위에는 주의사항
				아래에 기본주의사항
				*/
				strDn_notice = "<div class=\"caretxt\"><span class=\"title\">주의사항</span><br />";
				strDn_notice += "	<ul class=\"goods_add_center\">";
				strDn_notice += "		<li class=\"goods_add_sub\">";
				strDn_notice += strDn_popup ;
				strDn_notice += "		</li>";
				strDn_notice += "	</ul>";
				strDn_notice += "</div>";
				out.println(strDn_notice);
			}
		} else if(CutStr.LenH(strFunc_temp) < 21) { //카달은 없지만 내용은 있을때 
			
			strDn_notice = "<div class=\"caretxt\"><span class=\"title\">주의사항</span><br />";
			strDn_notice += "	<ul class=\"goods_add_center\">";
			strDn_notice += "		<li class=\"goods_add_sub\">";
			if(!strCatalogNotice.equals("")){
				strDn_notice += strCatalogNotice + "<br>";
			}
			strDn_notice += strDn_popup;
			strDn_notice += "<br><img src=http://img.enuri.info/images/blank.gif height=8><br>" + strDn_notice_no_1 + "<img src=http://img.enuri.info/images/blank.gif height=8><br>"+ strDn_notice_no_2 ;
			strDn_notice += "		</li>";
			strDn_notice += "	</ul>";
			strDn_notice += "</div>";
			out.println(strDn_notice);

		}
	} else if(DateUtil.DateDiff("d", cur_date1, dDate) > 0) { //출시예정
		strDn_position = "1";
		strDn_popup = "<img src="+IMG_ENURI_COM+"/images/detail/notice/attention_blt01.gif style='vertical-align: middle;'> 이 상품은 출시예정이므로 상품의 외관,<br>";
   		strDn_popup += "&nbsp;&nbsp;&nbsp;사양 등은 상품 개선이나 제조사 사정으로<br>";
   		strDn_popup += "&nbsp;&nbsp;&nbsp;사전 예고없이 변경될 수 있습니다.";

   		strDn_print = "<img src="+IMG_ENURI_COM+"/images/detail/notice/attention_blt01.gif style='vertical-align: middle;'> 이 상품은 출시예정이므로 상품의 외관,<br>";
   		strDn_print += "&nbsp;&nbsp;&nbsp;사양 등은 상품 개선이나 제조사 사정<br>";
   		strDn_print += "&nbsp;&nbsp;&nbsp;으로 사전 예고없이 변경될 수 있습니다.";
		
		strDn_notice = "<div class=\"caretxt\"><span class=\"title\">주의사항</span><br />";
		strDn_notice += "	<ul class=\"goods_add_center\">";
		strDn_notice += "		<li class=\"goods_add_sub\">";
		strDn_notice += strDn_popup ;
		strDn_notice += "			<br><img src="+IMG_ENURI_COM+"/images/blank.gif height=8><br>";
		strDn_notice += "		</li>";
		strDn_notice += "	</ul>";
		strDn_notice += "</div>";
		out.println(strDn_notice);
	}
%><!--dp:<%=strDn_position%> -->