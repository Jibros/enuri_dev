<%!
	public boolean isGroupTool(String strCate){
		boolean bReturn = false;
		if (CutStr.cutStr(strCate,6).equals("040207") && !CutStr.cutStr(strCate,8).equals("04020706") && !CutStr.cutStr(strCate,8).equals("04020710") && !CutStr.cutStr(strCate,8).equals("04020714")){
			bReturn = false;
		}else{
			bReturn = true;
		}
		return bReturn;
	}
	public boolean isCompareToYesterday(String strCate){
		boolean bReturn = false;
		/*
		if (CutStr.cutStr(strCate,4).equals("0713") || CutStr.cutStr(strCate,4).equals("0702")){
			bReturn = true;
		}else{
			bReturn = false; 
		}
		*/
		return bReturn;
	}	
	public String getCondiName(String strCate){
		String strGroupGubunName = "";
		if (CutStr.cutStr(strCate,4).trim().equals("0355") || 
			CutStr.cutStr(strCate,4).trim().equals("0353") ||  
			CutStr.cutStr(strCate,4).trim().equals("0356") || 	
			CutStr.cutStr(strCate,6).trim().equals("021010") ||
			(CutStr.cutStr(strCate,4).trim().equals("0354") && !CutStr.cutStr(strCate,6).trim().equals("035407")) ||
			CutStr.cutStr(strCate,4).trim().equals("0401") || 
			CutStr.cutStr(strCate,6).trim().equals("040601") || 
			CutStr.cutStr(strCate,6).trim().equals("040606")  || 
			CutStr.cutStr(strCate,4).trim().equals("2113") || 
			CutStr.cutStr(strCate,8).trim().equals("97020801") || 
			CutStr.cutStr(strCate,8).trim().equals("97020803") || 
			CutStr.cutStr(strCate,6).trim().equals("971504") ||
			CutStr.cutStr(strCate,6).trim().equals("970209") ||
			CutStr.cutStr(strCate,4).trim().equals("2116") || 
			CutStr.cutStr(strCate,6).trim().equals("219607")		
			){ 
			strGroupGubunName = "패키지 선택";
		}else if (CutStr.cutStr(strCate,4).trim().equals("0212") || 
			CutStr.cutStr(strCate,4).trim().equals("0218") || 
			CutStr.cutStr(strCate,4).trim().equals("0301") || 
			CutStr.cutStr(strCate,4).trim().equals("0810") || 
			CutStr.cutStr(strCate,6).trim().equals("021001") ||
			CutStr.cutStr(strCate,6).trim().equals("021012") ||
			CutStr.cutStr(strCate,6).trim().equals("021013") ||
			CutStr.cutStr(strCate,6).trim().equals("021016") ||
			CutStr.cutStr(strCate,6).trim().equals("021201") || 
			CutStr.cutStr(strCate,6).trim().equals("021206") || 
			CutStr.cutStr(strCate,6).trim().equals("021208") || 
			CutStr.cutStr(strCate,6).trim().equals("021209") || 
			CutStr.cutStr(strCate,6).trim().equals("021211") ||
			CutStr.cutStr(strCate,6).trim().equals("021513") ||
			CutStr.cutStr(strCate,6).trim().equals("040607") ||
			CutStr.cutStr(strCate,6).trim().equals("070202") || 
			CutStr.cutStr(strCate,6).trim().equals("070203") || 
			CutStr.cutStr(strCate,6).trim().equals("070204") || 
			CutStr.cutStr(strCate,6).trim().equals("070209") || 
			CutStr.cutStr(strCate,6).trim().equals("070210") || 
			CutStr.cutStr(strCate,6).trim().equals("070211") ||			
			CutStr.cutStr(strCate,6).trim().equals("070213") ||
			CutStr.cutStr(strCate,6).trim().equals("070513") ||
			CutStr.cutStr(strCate,6).trim().equals("971502") ||
			CutStr.cutStr(strCate,4).trim().equals("0712") || 
			CutStr.cutStr(strCate,4).trim().equals("0713") ||
			CutStr.cutStr(strCate,4).trim().equals("0703") ||
			CutStr.cutStr(strCate,6).trim().equals("040402") ||
			CutStr.cutStr(strCate,6).trim().equals("041009") ||
			CutStr.cutStr(strCate,6).trim().equals("041102") ||
			CutStr.cutStr(strCate,6).trim().equals("041103") ||
			CutStr.cutStr(strCate,6).trim().equals("041104") ||
			CutStr.cutStr(strCate,6).trim().equals("041011") ||
			CutStr.cutStr(strCate,6).trim().equals("081001") ||
			CutStr.cutStr(strCate,6).trim().equals("161001") || 
			CutStr.cutStr(strCate,6).trim().equals("070513") || 
			CutStr.cutStr(strCate,6).trim().equals("971602") || 
			CutStr.cutStr(strCate,8).trim().equals("15020201") ||
			CutStr.cutStr(strCate,8).trim().equals("15020211") || 
			CutStr.cutStr(strCate,8).trim().equals("15051001") ||
			CutStr.cutStr(strCate,8).trim().equals("15050104") ||
			CutStr.cutStr(strCate,8).trim().equals("15050105") ||
			CutStr.cutStr(strCate,6).trim().equals("150602") ||
			CutStr.cutStr(strCate,6).trim().equals("150704") ||
			CutStr.cutStr(strCate,6).trim().equals("150705") ||
			CutStr.cutStr(strCate,6).trim().equals("150706") ||
			CutStr.cutStr(strCate,6).trim().equals("150707") ||
			CutStr.cutStr(strCate,4).trim().equals("0306") ||  
			CutStr.cutStr(strCate,8).trim().equals("97020802")){
			strGroupGubunName = "용량 선택";
		}else if (CutStr.cutStr(strCate,6).trim().equals("970201") || 
			CutStr.cutStr(strCate,4).trim().equals("0304") || 
			CutStr.cutStr(strCate,4).trim().equals("0406") || 
			CutStr.cutStr(strCate,4).trim().equals("1615") || 
			CutStr.cutStr(strCate,6).trim().equals("092708") ||
			CutStr.cutStr(strCate,6).trim().equals("971601") ||
			CutStr.cutStr(strCate,6).trim().equals("061004") ||  
			CutStr.cutStr(strCate,6).trim().equals("061001") ||
			CutStr.cutStr(strCate,6).trim().equals("061003") ||
			CutStr.cutStr(strCate,6).trim().equals("061005") ||
			CutStr.cutStr(strCate,6).trim().equals("061014") ||
			CutStr.cutStr(strCate,8).trim().equals("06100303") ||
			CutStr.cutStr(strCate,8).trim().equals("06100304") ||
			CutStr.cutStr(strCate,8).trim().equals("06100302") ||
			CutStr.cutStr(strCate,6).trim().equals("090107")){

			strGroupGubunName = "구매조건 선택";      
		}else if( CutStr.cutStr(strCate,4).trim().equals("0201") || CutStr.cutStr(strCate,6).trim().equals("020803") || 
					CutStr.cutStr(strCate,4).trim().equals("0513") || CutStr.cutStr(strCate,6).trim().equals("020109")){
			strGroupGubunName = "설치형태 선택";
		}else if( CutStr.cutStr(strCate,4).trim().equals("0714") || CutStr.cutStr(strCate,4).trim().equals("2101") || CutStr.cutStr(strCate,6).trim().equals("070907") || 
				CutStr.cutStr(strCate,6).trim().equals("061011") || CutStr.cutStr(strCate,6).trim().equals("100303") || CutStr.cutStr(strCate,4).trim().equals("0905") ||
				CutStr.cutStr(strCate,6).trim().equals("210117") || CutStr.cutStr(strCate,6).trim().equals("210118") || CutStr.cutStr(strCate,4).trim().equals("2117") ||
				CutStr.cutStr(strCate,8).trim().equals("97160703") || CutStr.cutStr(strCate,4).trim().equals("0707") || CutStr.cutStr(strCate,8).trim().equals("03180603") ||
				CutStr.cutStr(strCate,8).trim().equals("07021602") || CutStr.cutStr(strCate,4).trim().equals("0414") || CutStr.cutStr(strCate,4).trim().equals("0305") ||
				CutStr.cutStr(strCate,8).trim().equals("16021103") || CutStr.cutStr(strCate,8).trim().equals("21441103") || CutStr.cutStr(strCate,8).trim().equals("02230123") || CutStr.cutStr(strCate,6).trim().equals("061011") ||
				CutStr.cutStr(strCate,8).trim().equals("06100302") || CutStr.cutStr(strCate,8).trim().equals("06100305") || CutStr.cutStr(strCate,8).trim().equals("06100201") ||
				CutStr.cutStr(strCate,8).trim().equals("06100204") || CutStr.cutStr(strCate,8).trim().equals("06100205") || CutStr.cutStr(strCate,8).trim().equals("21441103")
		){
			strGroupGubunName = "구성 선택";
		}else if(CutStr.cutStr(strCate,6).trim().equals("020812") || CutStr.cutStr(strCate,8).trim().equals("02140613") || CutStr.cutStr(strCate,8).trim().equals("02140614") || 
				CutStr.cutStr(strCate,8).equals("04081111") || CutStr.cutStr(strCate,8).equals("04080916") || CutStr.cutStr(strCate,8).equals("02141303") || CutStr.cutStr(strCate,8).equals("21010901") ||
				CutStr.cutStr(strCate,8).equals("07021603") || CutStr.cutStr(strCate,6).equals("040711") || CutStr.cutStr(strCate,6).equals("041402") || CutStr.cutStr(strCate,6).equals("022405")
		){
			strGroupGubunName = "길이 선택";			
		}else if(CutStr.cutStr(strCate,8).trim().equals("03110801") || CutStr.cutStr(strCate,6).trim().equals("031112")){
			strGroupGubunName = "매수 선택";			
		}else if(CutStr.cutStr(strCate,8).trim().equals("12260503")){
			strGroupGubunName = "시공면적 선택";			
		}else if(CutStr.cutStr(strCate,4).trim().equals("0816") ||  
			CutStr.cutStr(strCate,4).equals("0817") || 
			CutStr.cutStr(strCate,4).equals("1020") || 			
			CutStr.cutStr(strCate,6).equals("081205") || 
			CutStr.cutStr(strCate,6).equals("081408") || 
			CutStr.cutStr(strCate,4).trim().equals("1005") || 
			CutStr.cutStr(strCate,4).trim().equals("1614") ||  
			CutStr.cutStr(strCate,4).trim().equals("1625") || 
			CutStr.cutStr(strCate,6).equals("101203") || 
			CutStr.cutStr(strCate,6).equals("160211") ||
			CutStr.cutStr(strCate,6).equals("214411") ||
			CutStr.cutStr(strCate,8).equals("05151004") ||
			CutStr.cutStr(strCate,4).trim().equals("1620") || 
			CutStr.cutStr(strCate,6).trim().equals("162904") || 
			CutStr.cutStr(strCate,6).trim().equals("051911") || 
			CutStr.cutStr(strCate,6).trim().equals("052305") || 
			CutStr.cutStr(strCate,6).trim().equals("100301") || 
			CutStr.cutStr(strCate,4).trim().equals("1501") ||
			CutStr.cutStr(strCate,8).trim().equals("15020501") ||
			CutStr.cutStr(strCate,8).trim().equals("15020502") || 			
			CutStr.cutStr(strCate,8).trim().equals("15020503") ||
			CutStr.cutStr(strCate,8).trim().equals("15020510") ||
			CutStr.cutStr(strCate,8).trim().equals("15020512") ||
			CutStr.cutStr(strCate,4).trim().equals("1503") ||
			CutStr.cutStr(strCate,4).trim().equals("1504") ||
			CutStr.cutStr(strCate,8).trim().equals("15050101") ||
			CutStr.cutStr(strCate,8).trim().equals("15050102") ||
			CutStr.cutStr(strCate,6).trim().equals("150503") ||
			CutStr.cutStr(strCate,6).trim().equals("150508") ||	
			CutStr.cutStr(strCate,6).trim().equals("150708") ||					
			CutStr.cutStr(strCate,4).trim().equals("1508") ||
			CutStr.cutStr(strCate,4).trim().equals("1510") ||
			CutStr.cutStr(strCate,8).equals("05230801") ||
			CutStr.cutStr(strCate,8).equals("05100905") ||
			CutStr.cutStr(strCate,4).trim().equals("1007")){
			strGroupGubunName = "수량 선택";      
		}else if(CutStr.cutStr(strCate,8).equals("09081601") ||
				CutStr.cutStr(strCate,8).equals("09081602") ||
				CutStr.cutStr(strCate,8).equals("09081603") ||
				CutStr.cutStr(strCate,8).equals("09081604")){
			strGroupGubunName = "스펙 선택";
		}else if(CutStr.cutStr(strCate,4).equals("2115") || CutStr.cutStr(strCate,6).equals("210615") || CutStr.cutStr(strCate,6).equals("210302") || 
				CutStr.cutStr(strCate,6).equals("211505") || CutStr.cutStr(strCate,6).equals("210804") || CutStr.cutStr(strCate,6).equals("219701") || 
				CutStr.cutStr(strCate,6).equals("219706") || CutStr.cutStr(strCate,8).equals("21090702") || CutStr.cutStr(strCate,8).equals("21090704") ||
				CutStr.cutStr(strCate,6).equals("219602") || CutStr.cutStr(strCate,6).equals("219605")
		){
			strGroupGubunName = "규격 선택";
		}else if(CutStr.cutStr(strCate,6).equals("021407") || CutStr.cutStr(strCate,6).equals("035407") || CutStr.cutStr(strCate,6).equals("022208")){
			strGroupGubunName = "구경 선택";
		}else if(CutStr.cutStr(strCate,6).equals("021401") || CutStr.cutStr(strCate,6).equals("035406") || CutStr.cutStr(strCate,4).equals("0222")){
			strGroupGubunName = "마운트 선택";
		}else if(CutStr.cutStr(strCate,4).equals("0501")){
			strGroupGubunName = "설치조건 선택";
		}else if(CutStr.cutStr(strCate,6).equals("121503")){
			strGroupGubunName = "사이즈 선택";
		}else if (CutStr.cutStr(strCate,6).trim().equals("021010") || CutStr.cutStr(strCate,6).trim().equals("035605") || 
			CutStr.cutStr(strCate,6).trim().equals("035607")){
			strGroupGubunName = "수량 선택";
		}
		return  strGroupGubunName;
	}
	public boolean isSum_PointCate(String strCate){
		return  false;
	}
	private String[] getGroupGubun(String strCate){
		String strReturns[] = new String[3];
		strReturns[0] = "";
		strReturns[1] = "";
		strReturns[2] = "";		
	
		return strReturns;
	}			
	//개당환산가 계산시 배송포함 일경우
	public boolean isDeliveryCate(String strCate){
		boolean bReturn = true;
		if (CutStr.cutStr(strCate,6).trim().equals("210813") || CutStr.cutStr(strCate,4).trim().equals("1803")){
			bReturn = false;
		}
		return bReturn;
	} 
	private String getCondiNames(String strInputCondiName,String strKeyword,String[] arrCondi,boolean bSaleCnt){
		com.enuri.bean.search.SearchFunction Searchfunction = new com.enuri.bean.search.SearchFunction();
	    String strCondiname = "";
		/*if(strInputCondiName.indexOf("정품") > -1 && strInputCondiName.indexOf("비정품") < 0){
			strCondiname=strInputCondiName;
			strCondiname=Searchfunction.IsIn(strCondiname, strKeyword);
			boolean bEqCondiName = false;
			if (arrCondi != null && arrCondi.length > 0 ){
				for (int ai=0;ai<arrCondi.length;ai++){
					if(strInputCondiName.trim().indexOf(arrCondi[ai].trim()) == 0 )	{
						strCondiname = ReplaceStr.replace(strCondiname,arrCondi[ai].trim(),"<span style='font-weight:bold'>"+arrCondi[ai].trim()+"</span>");
						bEqCondiName = true;
					}					
				}
			}
			if (!bEqCondiName){
				strCondiname = ReplaceStr.replace(strCondiname,"정품","<span style='font-weight:bold'>정품</span>");
			}			
		}else{*/
			strCondiname=strInputCondiName;
			strCondiname = Searchfunction.IsIn(strCondiname,strKeyword);
			if(strCondiname.indexOf("(") >= 0){
				if (arrCondi != null && arrCondi.length > 0 ){
					for (int ai=0;ai<arrCondi.length;ai++){
						if(strInputCondiName.trim().indexOf(arrCondi[ai].trim()) == 0 )	{
							strCondiname = ReplaceStr.replace(strCondiname,arrCondi[ai].trim(),"<span style='font-weight:bold'>"+arrCondi[ai].trim()+"</span>");
						}					
					}
				}
				//strCondiname = ReplaceStr.replace(strCondiname,"(","<span style='font-size:8pt'>(");
				//strCondiname = ReplaceStr.replace(strCondiname,")",")</span>");
			}else{
				if (arrCondi != null && arrCondi.length > 0 ){
					for (int ai=0;ai<arrCondi.length;ai++){
						if(strInputCondiName.trim().indexOf(arrCondi[ai].trim()) == 0 )	{
							strCondiname = ReplaceStr.replace(strCondiname,arrCondi[ai].trim(),"<span style='font-weight:bold'>"+arrCondi[ai].trim()+"</span>");
						}					
					}			
				}
			}
		//}
		return  strCondiname;

	}
	private String getCondiNames(String strInputCondiNameOrg,String[] arrCondi){
		com.enuri.bean.search.SearchFunction Searchfunction = new com.enuri.bean.search.SearchFunction();
	    String strCondiname = "";
	    String strCondiNameOrg = "";
	    String strInputCondiName = "";
	    if (strInputCondiNameOrg.indexOf("<") < 0 ){
	    	strInputCondiName = strInputCondiNameOrg;
	    }else{
	    	strCondiNameOrg = HtmlStr.removeHtml(strInputCondiNameOrg);
	    	strInputCondiName = HtmlStr.removeHtml(strInputCondiNameOrg);
	    }
		/*if(strInputCondiName.indexOf("정품") > -1 && strInputCondiName.indexOf("비정품") < 0){
			strCondiname=strInputCondiName;
			if(strCondiname.indexOf("(") >= 0){
				strCondiname = ReplaceStr.replace(strCondiname,"(","<span style='font-size:8pt'>(") + "</span>";
			}
			boolean bEqCondiName = false;
			if (arrCondi != null && arrCondi.length > 0 ){
				for (int ai=0;ai<arrCondi.length;ai++){
					if(strInputCondiName.trim().indexOf(arrCondi[ai].trim()) == 0 )	{
						strCondiname = ReplaceStr.replace(strCondiname,arrCondi[ai].trim(),"<span style='font-weight:bold'>"+arrCondi[ai].trim()+"</span>");
						bEqCondiName = true;
					}					
				}
			}
			if (!bEqCondiName){
				strCondiname = ReplaceStr.replace(strCondiname,"정품","<span style='font-weight:bold'>정품</span>");
			}			
		}else{*/
			strCondiname=strInputCondiName;
			if(strCondiname.indexOf("(") >= 0){
				if (arrCondi != null && arrCondi.length > 0 ){
					for (int ai=0;ai<arrCondi.length;ai++){
						if(strInputCondiName.trim().indexOf(arrCondi[ai].trim()) == 0 )	{
							strCondiname = ReplaceStr.replace(strCondiname,arrCondi[ai].trim(),"<span style='font-weight:bold'>"+arrCondi[ai].trim()+"</span>");
						}					
					}
				}
				strCondiname = ReplaceStr.replace(strCondiname,"(","<span style='font-size:11px'>(");
				strCondiname = ReplaceStr.replace(strCondiname,")",")</span>");
			}else{
				if (arrCondi != null && arrCondi.length > 0 ){
					for (int ai=0;ai<arrCondi.length;ai++){
						
						if(strInputCondiName.trim().indexOf(arrCondi[ai].trim()) == 0 )	{
							strCondiname = ReplaceStr.replace(strCondiname,arrCondi[ai].trim(),"<span style='font-weight:bold'>"+arrCondi[ai].trim()+"</span>");
						}					
					}			
				}
			}
		//}
	    if (strInputCondiNameOrg.indexOf("<") >= 0 ){
	    	strCondiname = ReplaceStr.replace(strInputCondiNameOrg,strCondiNameOrg,strCondiname);
	    }		
		return  strCondiname;

	}	
	private int getSpecCount(String strSpec){
		
		String strSpecUnit[] = strSpec.split("/");
		String strLastSpecUnit = "";
		String strReturn = "";
		if (strSpecUnit != null && strSpecUnit.length > 0 ){
			strLastSpecUnit = strSpecUnit[strSpecUnit.length-1];
		}
		strLastSpecUnit = lastSpecReplace(strLastSpecUnit);
		if (strLastSpecUnit != null && strLastSpecUnit.trim().length() > 0 ){
			for (int i=0;i<strLastSpecUnit.length();i++){
				String strCharOne = strLastSpecUnit.substring(i,i+1);
				if (ChkNull.chkNumber(strCharOne)){
					strReturn = strReturn + strCharOne;
				}
			}
			if (!ChkNull.chkNumber(strLastSpecUnit.substring(0,1))){
				strReturn = "";
			}
		}
		if (strReturn.trim().length() > 0 ){
			return Integer.parseInt(strReturn);
		}else{
			return 1;
		}
	}
	private int getSpecCount(String strSpec,String strDiv){
		String strSpecUnit[] = strSpec.split("/");
		String strLastSpecUnit = "";			
		String strReturn = "";
		if (strSpecUnit != null && strSpecUnit.length > 0 ){
			if (strSpecUnit[strSpecUnit.length-1].indexOf(strDiv) >= 0 ){
				String strTempSpecUnit[] = strSpecUnit[strSpecUnit.length-1].trim().split(strDiv);
				String strLastSpecUnit1 = "";
				String strLastSpecUnit2 = "";
				if (strTempSpecUnit != null && strTempSpecUnit.length > 1 ){
					strLastSpecUnit1 = strTempSpecUnit[0].trim();
					strLastSpecUnit2 = strTempSpecUnit[1].trim();
					
					String strReturn1 = "";
					String strReturn2 = "";
					for (int i=0;i<strLastSpecUnit1.length();i++){
						String strCharOne = strLastSpecUnit1.substring(i,i+1);
						if (ChkNull.chkNumber(strCharOne)){
							strReturn1 = strReturn1 + strCharOne;
						}
					}
					for (int i=0;i<strLastSpecUnit2.length();i++){
						String strCharOne = strLastSpecUnit2.substring(i,i+1);
						if (ChkNull.chkNumber(strCharOne)){
							strReturn2 = strReturn2 + strCharOne;
						}
					}
					strReturn = (Integer.parseInt(strReturn1)*Integer.parseInt(strReturn2))+"";
				}
			}else{
				strLastSpecUnit = strSpecUnit[strSpecUnit.length-1].trim();
				if (strLastSpecUnit != null && strLastSpecUnit.trim().length() > 0 ){
					for (int i=0;i<strLastSpecUnit.length();i++){
						String strCharOne = strLastSpecUnit.substring(i,i+1);
						if (ChkNull.chkNumber(strCharOne)){
							strReturn = strReturn + strCharOne;
						}
					}
				}
			}
		}					
		if (strReturn.trim().length() > 0 ){
			return Integer.parseInt(strReturn);
		}else{
			return 1;
		}
	}
	private int getSpecCount(String strSpec,int intSpecIdx,boolean bNumberChk){
		String strSpecUnit[] = strSpec.split("/");
		String strLastSpecUnit = "";
		String strReturn = "";
		if (strSpecUnit != null && strSpecUnit.length > intSpecIdx ){
			strLastSpecUnit = strSpecUnit[intSpecIdx];
		}
		strLastSpecUnit = lastSpecReplace(strLastSpecUnit);
		if (strLastSpecUnit != null && strLastSpecUnit.trim().length() > 0 ){
			for (int i=0;i<strLastSpecUnit.length();i++){
				String strCharOne = strLastSpecUnit.substring(i,i+1);
				if (ChkNull.chkNumber(strCharOne)){
					strReturn = strReturn + strCharOne;
				}
			}
			if (bNumberChk){
				if (!ChkNull.chkNumber(strLastSpecUnit.substring(0,1))){
					strReturn = "";
				}
			}
		}
		if (strReturn.trim().length() > 0 && ChkNull.chkNumber(strReturn)){
			return Integer.parseInt(strReturn);
		}else{
			return 1;
		}
	}	
	//개당 환산가 단위 리턴
	//여기서 리턴 되는 단위가 없는 경우는 개당 환산가를 계산 하지 않는다.
	private String getIndividualChangeUnit(String strCate,String strCondiName,String strSpec){
		String strReturn = "";
		//단순 개당 환산가의 단위일 경우
		if (CutStr.cutStr(strCate,6).equals("035605") || CutStr.cutStr(strCate,6).equals("162912") || CutStr.cutStr(strCate,6).equals("122609") || CutStr.cutStr(strCate,8).equals("09111004") ||
			CutStr.cutStr(strCate,8).equals("02101001") || CutStr.cutStr(strCate,8).equals("02101004") || CutStr.cutStr(strCate,6).equals("102503") || CutStr.cutStr(strCate,8).trim().equals("16250909") ||
			CutStr.cutStr(strCate,6).trim().equals("101210") || CutStr.cutStr(strCate,8).equals("02101007") || CutStr.cutStr(strCate,8).equals("16021101") || CutStr.cutStr(strCate,8).equals("21441101") || CutStr.cutStr(strCate,8).trim().equals("16250911") ||
			CutStr.cutStr(strCate,8).equals("16021104") || CutStr.cutStr(strCate,8).equals("21441104") || CutStr.cutStr(strCate,8).trim().equals("10120608") || CutStr.cutStr(strCate,8).equals("16210214") || CutStr.cutStr(strCate,8).equals("08012302") ||
			CutStr.cutStr(strCate,8).equals("07141106") || CutStr.cutStr(strCate,8).equals("07141107") || CutStr.cutStr(strCate,8).trim().equals("10120801") || CutStr.cutStr(strCate,6).trim().equals("093005") ||
			CutStr.cutStr(strCate,6).equals("035607") || CutStr.cutStr(strCate,6).equals("021010") || CutStr.cutStr(strCate,8).trim().equals("16110801") || CutStr.cutStr(strCate,8).trim().equals("16110407") ||
			CutStr.cutStr(strCate,8).equals("02100307") || CutStr.cutStr(strCate,8).equals("02100310") || CutStr.cutStr(strCate,8).equals("16250707") || CutStr.cutStr(strCate,8).equals("02100310") ||  
			CutStr.cutStr(strCate,6).equals("052305") || CutStr.cutStr(strCate,8).equals("05230801") || CutStr.cutStr(strCate,6).trim().equals("081410") || CutStr.cutStr(strCate,8).trim().equals("21080613") ||
			CutStr.cutStr(strCate,8).equals("07010702") || CutStr.cutStr(strCate,8).equals("07010602") || CutStr.cutStr(strCate,6).trim().equals("160309") || CutStr.cutStr(strCate,8).trim().equals("21080209") ||
			(CutStr.cutStr(strCate,4).equals("0714") &&  !CutStr.cutStr(strCate,6).equals("071405")) || CutStr.cutStr(strCate,8).trim().equals("21080202") || CutStr.cutStr(strCate,8).trim().equals("21080208") ||
			CutStr.cutStr(strCate,4).equals("0817") ||  CutStr.cutStr(strCate,4).equals("0817") || CutStr.cutStr(strCate,4).equals("0817") || CutStr.cutStr(strCate,8).equals("16290513") || 
			(CutStr.cutStr(strCate,6).equals("101203") && !CutStr.cutStr(strCate,8).equals("10120303") && !CutStr.cutStr(strCate,8).equals("10120304") && !CutStr.cutStr(strCate,8).equals("10120305") 
			&& !CutStr.cutStr(strCate,8).equals("10120306") && !CutStr.cutStr(strCate,8).equals("10120308") && !CutStr.cutStr(strCate,8).equals("10120309") && !CutStr.cutStr(strCate,8).equals("10120310")
			&& !CutStr.cutStr(strCate,8).equals("10120315") && !CutStr.cutStr(strCate,8).equals("10120307") && !CutStr.cutStr(strCate,8).equals("10120316")) || CutStr.cutStr(strCate,8).equals("16111310") || CutStr.cutStr(strCate,8).equals("16111311") ||
			CutStr.cutStr(strCate,8).equals("10070409") || CutStr.cutStr(strCate,6).equals("100705") || CutStr.cutStr(strCate,6).equals("100710") || CutStr.cutStr(strCate,6).equals("100711") ||
			(CutStr.cutStr(strCate,6).equals("100301")  && !CutStr.cutStr(strCate,8).equals("10030102") && !CutStr.cutStr(strCate,8).equals("10030103") && !CutStr.cutStr(strCate,8).equals("10030104")  ) || 
			CutStr.cutStr(strCate,8).equals("16021101") || CutStr.cutStr(strCate,8).equals("21441101") || CutStr.cutStr(strCate,8).trim().equals("10011010") || CutStr.cutStr(strCate,8).equals("16021104") || CutStr.cutStr(strCate,8).equals("21441104") || CutStr.cutStr(strCate,8).equals("16210503") ||
			CutStr.cutStr(strCate,6).equals("162904") || CutStr.cutStr(strCate,4).equals("0712") || CutStr.cutStr(strCate,8).equals("16110802") || CutStr.cutStr(strCate,8).equals("10230507") ||
			CutStr.cutStr(strCate,6).equals("034201") || CutStr.cutStr(strCate,6).equals("034203") || CutStr.cutStr(strCate,6).equals("034204") || CutStr.cutStr(strCate,6).equals("034205") || 
			CutStr.cutStr(strCate,8).equals("16250601") || CutStr.cutStr(strCate,8).equals("16250602") || CutStr.cutStr(strCate,6).equals("122507") || CutStr.cutStr(strCate,8).equals("10120105") ||
			CutStr.cutStr(strCate,8).equals("16250603") || CutStr.cutStr(strCate,8).equals("16250605") || CutStr.cutStr(strCate,8).equals("16250606") || CutStr.cutStr(strCate,8).equals("16250607") ||
			CutStr.cutStr(strCate,8).equals("16250609") || CutStr.cutStr(strCate,8).equals("16250701") ||CutStr.cutStr(strCate,8).equals("16250904") || CutStr.cutStr(strCate,8).equals("16250901") || 
			CutStr.cutStr(strCate,8).equals("16250905") || CutStr.cutStr(strCate,8).equals("16250906") || CutStr.cutStr(strCate,8).equals("16250907") || 
			CutStr.cutStr(strCate,8).equals("16250908") || CutStr.cutStr(strCate,8).equals("16140302") || CutStr.cutStr(strCate,8).equals("16140303") || CutStr.cutStr(strCate,8).equals("16140501") || 
			CutStr.cutStr(strCate,8).equals("16140502") || CutStr.cutStr(strCate,6).equals("150110") || CutStr.cutStr(strCate,4).equals("0605") || CutStr.cutStr(strCate,8).equals("16350909")  || CutStr.cutStr(strCate,8).equals("21450909") || CutStr.cutStr(strCate,8).equals("21450909") ||
			(CutStr.cutStr(strCate,6).equals("163505") && !CutStr.cutStr(strCate,8).equals("16350501") && !CutStr.cutStr(strCate,8).equals("16350513") && !CutStr.cutStr(strCate,8).equals("16350516") && !CutStr.cutStr(strCate,8).equals("16350519")) ||
			(CutStr.cutStr(strCate,6).equals("214505") && !CutStr.cutStr(strCate,8).equals("21450501") && !CutStr.cutStr(strCate,8).equals("21450513") && !CutStr.cutStr(strCate,8).equals("21450516") && !CutStr.cutStr(strCate,8).equals("21450519")) || 
			CutStr.cutStr(strCate,8).equals("16141101") || CutStr.cutStr(strCate,8).equals("16141103") || CutStr.cutStr(strCate,8).equals("16141102") ||
			CutStr.cutStr(strCate,8).equals("10070401") || CutStr.cutStr(strCate,8).equals("10070407") || CutStr.cutStr(strCate,8).equals("10070405") ||CutStr.cutStr(strCate,8).equals("10070406") ||
			CutStr.cutStr(strCate,6).equals("031112") || CutStr.cutStr(strCate,8).equals("15040407") || CutStr.cutStr(strCate,6).equals("070202") || CutStr.cutStr(strCate,6).equals("070203") ||
			CutStr.cutStr(strCate,6).equals("071303") || CutStr.cutStr(strCate,6).equals("071304") || CutStr.cutStr(strCate,6).equals("071307") || CutStr.cutStr(strCate,6).equals("071308") ||	
			CutStr.cutStr(strCate,6).equals("070213") || CutStr.cutStr(strCate,6).equals("070209") || CutStr.cutStr(strCate,6).equals("162005") || CutStr.cutStr(strCate,6).equals("070220") ||
			CutStr.cutStr(strCate,8).equals("15090411") || CutStr.cutStr(strCate,8).equals("06111311") || CutStr.cutStr(strCate,6).equals("031319") ||
			CutStr.cutStr(strCate,8).equals("05140813") || CutStr.cutStr(strCate,8).equals("06060616") || CutStr.cutStr(strCate,6).equals("164001") || CutStr.cutStr(strCate,6).equals("081401") ||    
			(CutStr.cutStr(strCate,4).equals("0810") && !CutStr.cutStr(strCate,6).equals("081010") && !CutStr.cutStr(strCate,6).equals("081004") && !CutStr.cutStr(strCate,6).equals("081013")) ||
			(CutStr.cutStr(strCate,6).equals("150406") && !CutStr.cutStr(strCate,8).equals("15040603")) || CutStr.cutStr(strCate,8).equals("07020528") || CutStr.cutStr(strCate,8).equals("09201112") ||
			CutStr.cutStr(strCate,8).equals("09201111") || CutStr.cutStr(strCate,6).equals("100303") ||	CutStr.cutStr(strCate,8).equals("10110803") || CutStr.cutStr(strCate,6).equals("101109") ||
			CutStr.cutStr(strCate,6).equals("101110") || CutStr.cutStr(strCate,6).equals("090802") || CutStr.cutStr(strCate,8).equals("09201108") || CutStr.cutStr(strCate,6).equals("161405") ||
			CutStr.cutStr(strCate,6).equals("101112") || CutStr.cutStr(strCate,8).equals("16050806") || CutStr.cutStr(strCate,8).equals("16050802") || CutStr.cutStr(strCate,8).trim().equals("16050809") ||
			CutStr.cutStr(strCate,8).equals("16050803") || CutStr.cutStr(strCate,8).equals("16050811") || CutStr.cutStr(strCate,8).equals("16360102") || CutStr.cutStr(strCate,6).equals("163604") ||
			CutStr.cutStr(strCate,8).equals("16360701") || CutStr.cutStr(strCate,8).equals("16360702") || CutStr.cutStr(strCate,8).equals("16360703") || CutStr.cutStr(strCate,8).equals("05102201") ||
			CutStr.cutStr(strCate,8).equals("10070306") || CutStr.cutStr(strCate,8).equals("05102202") || CutStr.cutStr(strCate,8).equals("05102203") ||
			CutStr.cutStr(strCate,8).equals("05150102") || CutStr.cutStr(strCate,8).equals("05151302") || CutStr.cutStr(strCate,4).equals("0703") || CutStr.cutStr(strCate,8).equals("05150103") ||
			CutStr.cutStr(strCate,8).equals("05150404") || CutStr.cutStr(strCate,8).equals("05150704") || CutStr.cutStr(strCate,6).equals("081408") || CutStr.cutStr(strCate,6).equals("080905") ||
			CutStr.cutStr(strCate,6).equals("092011") || CutStr.cutStr(strCate,6).equals("081404") || (CutStr.cutStr(strCate,4).equals("0807") && !CutStr.cutStr(strCate,8).equals("08070303")) ||
			(CutStr.cutStr(strCate,4).equals("1654") && !CutStr.cutStr(strCate,8).equals("16540303")) ||
			CutStr.cutStr(strCate,6).equals("081406") || CutStr.cutStr(strCate,6).equals("081402") || CutStr.cutStr(strCate,6).equals("081405") || CutStr.cutStr(strCate,8).equals("16290707") ||
			CutStr.cutStr(strCate,6).equals("080218")	|| CutStr.cutStr(strCate,6).equals("080214") || CutStr.cutStr(strCate,8).equals("16290512") || CutStr.cutStr(strCate,8).equals("16290703") ||  
			CutStr.cutStr(strCate,6).equals("080220")	|| CutStr.cutStr(strCate,8).equals("16110709") || CutStr.cutStr(strCate,8).equals("16110710") || CutStr.cutStr(strCate,8).equals("16110711") ||
			CutStr.cutStr(strCate,8).equals("16110705") || CutStr.cutStr(strCate,6).equals("080906") || CutStr.cutStr(strCate,6).equals("080908") || CutStr.cutStr(strCate,6).equals("080910") ||
			CutStr.cutStr(strCate,8).equals("05030302") || CutStr.cutStr(strCate,8).equals("05030305") ||  CutStr.cutStr(strCate,8).equals("05030306") || CutStr.cutStr(strCate,8).equals("05190701") ||
			CutStr.cutStr(strCate,8).equals("05130108") || CutStr.cutStr(strCate,8).equals("06061709") || CutStr.cutStr(strCate,8).equals("06062202") || CutStr.cutStr(strCate,6).equals("080909") ||
			CutStr.cutStr(strCate,8).equals("05260602") || CutStr.cutStr(strCate,8).equals("05260603") || CutStr.cutStr(strCate,6).equals("052604") || CutStr.cutStr(strCate,8).equals("05151303") ||
			CutStr.cutStr(strCate,8).equals("05060503") || CutStr.cutStr(strCate,8).equals("05060504") || CutStr.cutStr(strCate,8).equals("05060604") || CutStr.cutStr(strCate,8).equals("05060603") ||
			CutStr.cutStr(strCate,8).equals("05030303")	|| 	CutStr.cutStr(strCate,8).equals("05080204") || CutStr.cutStr(strCate,6).equals("100105") || CutStr.cutStr(strCate,8).equals("05140306") ||
			CutStr.cutStr(strCate,6).equals("100108") || CutStr.cutStr(strCate,6).equals("101207") || CutStr.cutStr(strCate,8).equals("10130504")  || CutStr.cutStr(strCate,8).equals("05111302") || 
			CutStr.cutStr(strCate,8).equals("05110906") || CutStr.cutStr(strCate,8).equals("05110102") || CutStr.cutStr(strCate,8).equals("09110304") || CutStr.cutStr(strCate,6).equals("091104") ||
			CutStr.cutStr(strCate,8).equals("09110504") || CutStr.cutStr(strCate,8).equals("09110514") || CutStr.cutStr(strCate,8).equals("09110603") || CutStr.cutStr(strCate,8).equals("15011107") || 
			CutStr.cutStr(strCate,8).equals("12071002") || CutStr.cutStr(strCate,8).equals("12071003") || CutStr.cutStr(strCate,8).equals("12071004") ||  
			CutStr.cutStr(strCate,6).equals("062006") || CutStr.cutStr(strCate,6).equals("051409") || CutStr.cutStr(strCate,8).equals("05211002") || CutStr.cutStr(strCate,8).equals("05260302") || 
			CutStr.cutStr(strCate,8).equals("16350903") || CutStr.cutStr(strCate,8).equals("16350904") || CutStr.cutStr(strCate,8).equals("16350905") || 
			CutStr.cutStr(strCate,8).equals("21450903") || CutStr.cutStr(strCate,8).equals("21450904") || CutStr.cutStr(strCate,8).equals("21450905") || CutStr.cutStr(strCate,6).equals("101207") ||
			CutStr.cutStr(strCate,6).equals("080903") || CutStr.cutStr(strCate,8).equals("05110105") || CutStr.cutStr(strCate,8).equals("05101910") || CutStr.cutStr(strCate,8).equals("05101915") ||
			CutStr.cutStr(strCate,8).equals("05101303") || CutStr.cutStr(strCate,8).equals("16140406") || CutStr.cutStr(strCate,8).equals("16350901") || CutStr.cutStr(strCate,8).equals("21450901") || CutStr.cutStr(strCate,6).equals("162901") ||
			CutStr.cutStr(strCate,6).equals("160302") || CutStr.cutStr(strCate,6).equals("160303") || CutStr.cutStr(strCate,6).equals("160304") || CutStr.cutStr(strCate,6).equals("160305") || 
			CutStr.cutStr(strCate,6).equals("160306") || CutStr.cutStr(strCate,6).equals("160311") || CutStr.cutStr(strCate,8).equals("06100207") || CutStr.cutStr(strCate,6).equals("081302") || 	 
			CutStr.cutStr(strCate,6).equals("162910") || CutStr.cutStr(strCate,6).equals("162903") || CutStr.cutStr(strCate,6).equals("162907") || 
			CutStr.cutStr(strCate,6).equals("162909") || CutStr.cutStr(strCate,8).equals("16290608") || CutStr.cutStr(strCate,8).equals("16290501")	|| CutStr.cutStr(strCate,8).equals("12071008") ||
			CutStr.cutStr(strCate,4).equals("0804") || CutStr.cutStr(strCate,8).equals("09110304") || CutStr.cutStr(strCate,6).equals("120710") || CutStr.cutStr(strCate,8).equals("16051504") ||
			CutStr.cutStr(strCate,8).equals("09110603") || CutStr.cutStr(strCate,8).equals("16140304") || CutStr.cutStr(strCate,8).equals("16140306") ||
			CutStr.cutStr(strCate,8).equals("16140305") || CutStr.cutStr(strCate,8).equals("05151709") || CutStr.cutStr(strCate,6).equals("160505") ||
			CutStr.cutStr(strCate,8).equals("03551001") || CutStr.cutStr(strCate,8).equals("09201007") || CutStr.cutStr(strCate,8).equals("16031201") || CutStr.cutStr(strCate,8).equals("16031202") || 
			CutStr.cutStr(strCate,8).equals("16030904") || CutStr.cutStr(strCate,8).equals("08140604") || CutStr.cutStr(strCate,8).equals("16290702") || CutStr.cutStr(strCate,8).equals("16290503") || 
			CutStr.cutStr(strCate,8).equals("16031203") || (CutStr.cutStr(strCate,6).equals("081309") && !CutStr.cutStr(strCate,8).equals("08130901") && !CutStr.cutStr(strCate,8).equals("08130902")) || 
			CutStr.cutStr(strCate,8).equals("08140604") || CutStr.cutStr(strCate,6).equals("162105") ||
			CutStr.cutStr(strCate,8).equals("05030302") || CutStr.cutStr(strCate,8).equals("05030306") || CutStr.cutStr(strCate,8).equals("05030305") || CutStr.cutStr(strCate,8).equals("05030114") ||
			CutStr.cutStr(strCate,8).equals("05030711") || CutStr.cutStr(strCate,6).equals("035608") ||
			CutStr.cutStr(strCate,6).equals("032103") || (CutStr.cutStr(strCate,4).equals("0805") && !CutStr.cutStr(strCate,6).equals("080504")) || 
			(CutStr.cutStr(strCate,4).trim().equals("0511")   && !CutStr.cutStr(strCate,8).equals("05110907") && !CutStr.cutStr(strCate,8).equals("05110908") && !CutStr.cutStr(strCate,8).equals("05110909")
			  && !CutStr.cutStr(strCate,8).equals("05110921") && !CutStr.cutStr(strCate,8).equals("05110922") && !CutStr.cutStr(strCate,8).equals("05111101") && !CutStr.cutStr(strCate,8).equals("05111103")
			  && !CutStr.cutStr(strCate,8).equals("05110302") && !CutStr.cutStr(strCate,8).equals("05111102") && !CutStr.cutStr(strCate,8).equals("05111201") && !CutStr.cutStr(strCate,8).equals("05111202")
			  && !CutStr.cutStr(strCate,8).equals("05110302") && !CutStr.cutStr(strCate,8).equals("05110303") && !CutStr.cutStr(strCate,8).equals("05110402") && !CutStr.cutStr(strCate,8).equals("05110401")
			  && !CutStr.cutStr(strCate,8).equals("05110101") && !CutStr.cutStr(strCate,8).equals("05110103") && !CutStr.cutStr(strCate,6).equals("051106") && !CutStr.cutStr(strCate,8).equals("05110502")
			  && !CutStr.cutStr(strCate,8).equals("05110108") && !CutStr.cutStr(strCate,8).equals("05110107") && !CutStr.cutStr(strCate,8).equals("05110109") && !CutStr.cutStr(strCate,8).equals("05110104")
  			  && !CutStr.cutStr(strCate,8).equals("05110504") && !CutStr.cutStr(strCate,8).equals("05110503") && !CutStr.cutStr(strCate,6).equals("051107") && !CutStr.cutStr(strCate,8).equals("05110114")) || 
  			 CutStr.cutStr(strCate,8).equals("12070503") || CutStr.cutStr(strCate,6).equals("161201") || CutStr.cutStr(strCate,6).equals("161203") || CutStr.cutStr(strCate,8).equals("16290502")	|| 
  			 (CutStr.cutStr(strCate,6).equals("080612") && !CutStr.cutStr(strCate,8).equals("08061201") && !CutStr.cutStr(strCate,8).equals("08061202") && !CutStr.cutStr(strCate,8).equals("08061203") && !CutStr.cutStr(strCate,8).equals("08061204") &&
  			 !CutStr.cutStr(strCate,8).equals("08061207")) || CutStr.cutStr(strCate,8).equals("16351303") || CutStr.cutStr(strCate,8).equals("21451303") || CutStr.cutStr(strCate,8).equals("21451303") || CutStr.cutStr(strCate,8).equals("16351301") || CutStr.cutStr(strCate,8).equals("21451301") ||
  			 (CutStr.cutStr(strCate,6).equals("161204") && !CutStr.cutStr(strCate,8).equals("16120404") && !CutStr.cutStr(strCate,8).equals("16120405")) ||  
  			 (CutStr.cutStr(strCate,6).equals("161207") && !CutStr.cutStr(strCate,8).equals("16120708")) ||  CutStr.cutStr(strCate,8).equals("08060615") || CutStr.cutStr(strCate,6).equals("080609") || 
  			 (CutStr.cutStr(strCate,4).equals("1513") && !CutStr.cutStr(strCate,8).equals("15130305") && !CutStr.cutStr(strCate,8).equals("15130505") && !CutStr.cutStr(strCate,6).equals("151301") && 
  			 !CutStr.cutStr(strCate,6).equals("151302") && !CutStr.cutStr(strCate,6).equals("151303")  && !CutStr.cutStr(strCate,6).equals("151304") && !CutStr.cutStr(strCate,6).equals("151305") && 
  			 !CutStr.cutStr(strCate,6).equals("151306")) || CutStr.cutStr(strCate,8).equals("06062001") || CutStr.cutStr(strCate,8).equals("06062002") || CutStr.cutStr(strCate,8).equals("15081104") || 
  			 (CutStr.cutStr(strCate,6).equals("161213") && !CutStr.cutStr(strCate,8).equals("16121314"))  || CutStr.cutStr(strCate,6).equals("080809") || CutStr.cutStr(strCate,4).equals("0826") ||
			CutStr.cutStr(strCate,8).equals("16030702") || CutStr.cutStr(strCate,8).equals("16030703") || CutStr.cutStr(strCate,8).equals("16030707") || CutStr.cutStr(strCate,8).equals("16030708") || 
			CutStr.cutStr(strCate,8).equals("16030710") || CutStr.cutStr(strCate,8).equals("05190702") || CutStr.cutStr(strCate,8).equals("05101912") || CutStr.cutStr(strCate,8).equals("05151806") ||   			 
			CutStr.cutStr(strCate,8).equals("16361102") || CutStr.cutStr(strCate,8).equals("16361104") || CutStr.cutStr(strCate,8).equals("16361106")  || CutStr.cutStr(strCate,8).equals("05260302") ||
			CutStr.cutStr(strCate,6).equals("070120") || CutStr.cutStr(strCate,6).equals("070121") || (CutStr.cutStr(strCate,6).equals("070122") && !CutStr.cutStr(strCate,8).equals("07012220"))|| 
			CutStr.cutStr(strCate,6).equals("102508") || CutStr.cutStr(strCate,6).equals("102502") || CutStr.cutStr(strCate,6).equals("102504") || CutStr.cutStr(strCate,6).equals("102505") || 
			CutStr.cutStr(strCate,6).equals("052604") || CutStr.cutStr(strCate,8).equals("15081101") || CutStr.cutStr(strCate,8).equals("15081102") || CutStr.cutStr(strCate,8).equals("15081103") || 
			CutStr.cutStr(strCate,8).equals("15081105") || CutStr.cutStr(strCate,8).equals("15081106") || CutStr.cutStr(strCate,8).equals("15081107") ||  CutStr.cutStr(strCate,8).equals("16051505") ||
			CutStr.cutStr(strCate,8).equals("03241201") || CutStr.cutStr(strCate,8).equals("03241203") || CutStr.cutStr(strCate,8).equals("03241205") || CutStr.cutStr(strCate,8).equals("03241202") ||
			CutStr.cutStr(strCate,8).equals("09200120") || CutStr.cutStr(strCate,8).equals("09200502") || CutStr.cutStr(strCate,8).equals("09200410") || CutStr.cutStr(strCate,8).equals("09200411") ||
			CutStr.cutStr(strCate,6).equals("161215") || CutStr.cutStr(strCate,8).equals("09200212") || CutStr.cutStr(strCate,8).equals("16360711") || CutStr.cutStr(strCate,8).equals("16321103") ||
			CutStr.cutStr(strCate,8).equals("10111708") || CutStr.cutStr(strCate,8).equals("16110702") || CutStr.cutStr(strCate,8).equals("16110703") || CutStr.cutStr(strCate,8).equals("16050106") ||
			CutStr.cutStr(strCate,6).equals("180304") || CutStr.cutStr(strCate,6).equals("180305") || CutStr.cutStr(strCate,6).equals("180306") || CutStr.cutStr(strCate,8).equals("16360111") ||
			CutStr.cutStr(strCate,8).equals("16360112") || CutStr.cutStr(strCate,8).equals("16360113") || CutStr.cutStr(strCate,8).equals("16360704") || CutStr.cutStr(strCate,8).equals("06061706") || 
			( CutStr.cutStr(strCate,6).equals("150910") && !CutStr.cutStr(strCate,8).equals("15091004") ) ||  CutStr.cutStr(strCate,6).equals("070119") || 
			CutStr.cutStr(strCate,8).equals("16111302") || CutStr.cutStr(strCate,8).equals("16111303") || CutStr.cutStr(strCate,8).equals("16111304") || CutStr.cutStr(strCate,8).equals("16111305") || 
			CutStr.cutStr(strCate,8).equals("16111306") || CutStr.cutStr(strCate,8).equals("06061705") ||  CutStr.cutStr(strCate,8).equals("16360709") || CutStr.cutStr(strCate,8).equals("16050803") ||
			CutStr.cutStr(strCate,8).equals("16050816") || CutStr.cutStr(strCate,8).equals("16120815") || CutStr.cutStr(strCate,6).equals("163511") || CutStr.cutStr(strCate,6).equals("214511") || CutStr.cutStr(strCate,6).equals("093006") ||
			CutStr.cutStr(strCate,6).equals("100505") ||  (CutStr.cutStr(strCate,6).equals("162902") && !CutStr.cutStr(strCate,8).equals("16290201") ) || 
			CutStr.cutStr(strCate,8).equals("10050209")  || CutStr.cutStr(strCate,6).equals("162101") || CutStr.cutStr(strCate,6).equals("162102") || CutStr.cutStr(strCate,6).equals("122514") ||
			CutStr.cutStr(strCate,8).equals("16110901") || CutStr.cutStr(strCate,8).equals("16110902") || CutStr.cutStr(strCate,8).equals("16110903") || CutStr.cutStr(strCate,8).equals("16111307") ||
			CutStr.cutStr(strCate,6).equals("034212") || CutStr.cutStr(strCate,8).equals("05152107") || CutStr.cutStr(strCate,8).equals("05152109") || CutStr.cutStr(strCate,8).equals("05150314") ||
			(CutStr.cutStr(strCate,6).equals("051503") && !CutStr.cutStr(strCate,8).equals("05150313") && !CutStr.cutStr(strCate,8).equals("05150301") && !CutStr.cutStr(strCate,8).equals("05150311")) ||
			CutStr.cutStr(strCate,8).equals("05152103") || CutStr.cutStr(strCate,6).equals("162116") || CutStr.cutStr(strCate,8).equals("16470704") || CutStr.cutStr(strCate,8).equals("16470708") ||
			(CutStr.cutStr(strCate,6).equals("162504") && !CutStr.cutStr(strCate,8).equals("16250401") && !CutStr.cutStr(strCate,8).equals("16250402") && !CutStr.cutStr(strCate,8).equals("16250404") && 
			!CutStr.cutStr(strCate,8).equals("16250403")) || CutStr.cutStr(strCate,8).equals("16421012") || CutStr.cutStr(strCate,6).equals("080225") || CutStr.cutStr(strCate,6).equals("101114") ||
			CutStr.cutStr(strCate,6).equals("101118") || CutStr.cutStr(strCate,8).equals("16290201") || CutStr.cutStr(strCate,8).equals("15010122") || CutStr.cutStr(strCate,8).equals("10230305") ||
			(CutStr.cutStr(strCate,6).equals("162509") && !CutStr.cutStr(strCate,8).equals("16250902") && !CutStr.cutStr(strCate,8).equals("16250903")) ||
			CutStr.cutStr(strCate,8).equals("12261002") || CutStr.cutStr(strCate,8).equals("12261003") || CutStr.cutStr(strCate,8).equals("15081404") || CutStr.cutStr(strCate,8).equals("08060108") ||
			CutStr.cutStr(strCate,8).equals("08060111") || CutStr.cutStr(strCate,8).equals("08060110") || CutStr.cutStr(strCate,8).equals("08060112") ||
			CutStr.cutStr(strCate,6).equals("151101") || CutStr.cutStr(strCate,8).equals("16370605") || CutStr.cutStr(strCate,8).equals("16290510") || CutStr.cutStr(strCate,8).equals("09201112") ||
			CutStr.cutStr(strCate,8).equals("09201111") || CutStr.cutStr(strCate,8).equals("16030711") || CutStr.cutStr(strCate,8).equals("10200404") || CutStr.cutStr(strCate,8).equals("16351312")  || CutStr.cutStr(strCate,8).equals("21451312")  ||
			CutStr.cutStr(strCate,8).equals("16351601") || CutStr.cutStr(strCate,8).equals("16351602") || CutStr.cutStr(strCate,8).equals("16351603") || CutStr.cutStr(strCate,8).equals("16351604") ||
			CutStr.cutStr(strCate,8).equals("21451601") || CutStr.cutStr(strCate,8).equals("21451602") || CutStr.cutStr(strCate,8).equals("21451603") || CutStr.cutStr(strCate,8).equals("21451604") ||
			CutStr.cutStr(strCate,6).equals("080230") || CutStr.cutStr(strCate,6).equals("122611") || CutStr.cutStr(strCate,8).equals("04020208") || CutStr.cutStr(strCate,8).equals("05102307") ||
			CutStr.cutStr(strCate,8).equals("05102310") || CutStr.cutStr(strCate,8).equals("05101114") || CutStr.cutStr(strCate,8).equals("05102308") || CutStr.cutStr(strCate,8).equals("05102305") ||
			CutStr.cutStr(strCate,6).equals("060617") || CutStr.cutStr(strCate,8).equals("16050805")
		){ 
			if (strCondiName != null && strCondiName.trim().length() > 0 ){
				for (int i=0;i<strCondiName.length();i++){
					String strCharOne = strCondiName.substring(i,i+1);
					if (!ChkNull.chkNumber(strCharOne)){
						strReturn = strReturn + strCharOne; 
					}
				} 
			}
			if (CutStr.cutStr(strCate,8).equals("16470704") || CutStr.cutStr(strCate,8).equals("16470708")){
				if (strReturn.indexOf("회") >= 0){
					strReturn = "회";
				}else{
					strReturn = "";
				}
			}
			if ( CutStr.cutStr(strCate,4).equals("0703") && strReturn.equals("M")){
				strReturn = "G";
			}
			if ( ( CutStr.cutStr(strCate,4).equals("0712") || CutStr.cutStr(strCate,6).equals("034201") || CutStr.cutStr(strCate,6).equals("034203") || CutStr.cutStr(strCate,6).equals("034204") || 
				CutStr.cutStr(strCate,6).equals("034205") || CutStr.cutStr(strCate,6).equals("031319") || CutStr.cutStr(strCate,6).equals("034212")) && strReturn.indexOf("M") >= 0){
				strReturn = "";
			}
			if ( (CutStr.cutStr(strCate,6).equals("034201") || CutStr.cutStr(strCate,6).equals("034203") || CutStr.cutStr(strCate,6).equals("034204") || CutStr.cutStr(strCate,6).equals("034212") || 
				CutStr.cutStr(strCate,6).equals("034205") || CutStr.cutStr(strCate,6).equals("031319")) && strReturn.indexOf("G") >= 0){
				strReturn = "G";
			}			
			if (CutStr.cutStr(strCate,4).equals("0703")){
				if (strReturn.indexOf("G") >= 0){
					strReturn = "G";
				}			
			}
			if (CutStr.cutStr(strCate,4).equals("0714") || CutStr.cutStr(strCate,6).equals("070120") || CutStr.cutStr(strCate,6).equals("070121") || CutStr.cutStr(strCate,6).equals("070122") || CutStr.cutStr(strCate,6).equals("070119")
			){
				strReturn = "장";
			}
			if (CutStr.cutStr(strCate,6).equals("035607")){
				strReturn = "팩";
			}
			if (CutStr.cutStr(strCate,4).equals("0810") && !CutStr.cutStr(strCate,6).equals("081004") && !CutStr.cutStr(strCate,6).equals("081013")){
				strReturn = "";
				String strCondiCount = "";
				strCondiName = ReplaceStr.replace(strCondiName,"테스터/","");
				strCondiName = ReplaceStr.replace(strCondiName,"신형,","");
				strCondiName = ReplaceStr.replace(strCondiName,"구형,/","");
				for (int i=0;i<strCondiName.length();i++){
					String strCharOne = strCondiName.substring(i,i+1);
					if (ChkNull.chkNumber(strCharOne)){
						strCondiCount = strCondiCount + strCharOne;
					}else if(strCharOne.equals(".")){
						strCondiCount = "";
						break;
					}
				}	
				if (ChkNull.chkNumber(strCondiCount)){
					double intCondiCount = Double.parseDouble(strCondiCount);
					if (intCondiCount > 9 ){
						strReturn = "ml";
					}						
				}
				if (strCondiName.trim().indexOf("미니어처") >= 0){
					strReturn = "";
				}
			}
			if ((CutStr.cutStr(strCate,4).equals("0807") && !CutStr.cutStr(strCate,6).equals("080709")) || (CutStr.cutStr(strCate,4).equals("1654") && !CutStr.cutStr(strCate,6).equals("165409"))){
				if (strCondiName.indexOf("ml") >= 0 ){
					strReturn = "ml";
				}else if(strCondiName.indexOf("g") >= 0 ){
					strReturn = "g";
				}else{
					strReturn = "";
				}
			}
			if (CutStr.cutStr(strCate,6).equals("122609") || CutStr.cutStr(strCate,6).equals("102503") || CutStr.cutStr(strCate,8).equals("16351303") || CutStr.cutStr(strCate,8).equals("16351301") || CutStr.cutStr(strCate,8).equals("21451303") || CutStr.cutStr(strCate,8).equals("21451301")){
				if (strCondiName.indexOf("ml") >= 0 || strCondiName.indexOf("L") >= 0 ){
					strReturn = "ml";
				}else{
					strReturn = "";
				} 
			}			
			if (CutStr.cutStr(strCate,8).equals("06100207")  ||  CutStr.cutStr(strCate,8).equals("16140305")
			){
				strReturn = "개"; 
			}
			if (CutStr.cutStr(strCate,8).equals("16140304") || CutStr.cutStr(strCate,8).equals("16140306")){
				strReturn = "롤";
			}
			if (CutStr.cutStr(strCate,6).equals("150910")){
				if (strReturn.indexOf("세트") >= 0){
					strReturn = "세트";
				}			
			}
			if (CutStr.cutStr(strCate,4).equals("0511") ){ 
				if (strReturn.indexOf("구매대행") >= 0 || strReturn.indexOf("해외쇼핑") >= 0 || strReturn.indexOf("면도망") >= 0 || strReturn.indexOf("본품") >= 0 || strReturn.indexOf("중고품") >= 0  || strReturn.indexOf("일반") >= 0 
					|| strReturn.indexOf("면도날") >= 0 || strReturn.indexOf("쉐이빙") >= 0 || strReturn.indexOf("컨디셔너") >= 0 || strReturn.indexOf("카트리지") >= 0 || strReturn.indexOf("선물세트") >= 0){
					strReturn = "";
				}
	
			}	
			if (CutStr.cutStr(strCate,6).equals("051110") ){ 
				if (strReturn.indexOf("+날") >= 0){
					strReturn = "";
				}
	
			}			
			if (CutStr.cutStr(strCate,6).equals("080903") || CutStr.cutStr(strCate,6).equals("080609") || CutStr.cutStr(strCate,8).equals("16050805")){
				if (strReturn.indexOf("세트") >= 0){
					strReturn = "세트";
				}else{
					strReturn = "";
				}			
			}	
			if (CutStr.cutStr(strCate,4).equals("0813") || CutStr.cutStr(strCate,4).equals("0814")){
				if (strReturn.indexOf("구매대행") >= 0 || strReturn.indexOf("해외쇼핑") >= 0){
					strReturn = "";
				}
			}				
			if ( CutStr.cutStr(strCate,6).equals("081401") || CutStr.cutStr(strCate,6).equals("163505") || CutStr.cutStr(strCate,8).equals("16350909") || CutStr.cutStr(strCate,6).equals("163511") || CutStr.cutStr(strCate,6).equals("214505") || CutStr.cutStr(strCate,8).equals("21450909") || CutStr.cutStr(strCate,6).equals("214511")){
				if (strCondiName.length() > 0 && strReturn.trim().length() > 0){
					strReturn = "개";
				}
			}	
			if (CutStr.cutStr(strCate,6).equals("101108") || CutStr.cutStr(strCate,6).equals("101109") || CutStr.cutStr(strCate,6).trim().equals("101111") || CutStr.cutStr(strCate,6).equals("101117") ||
				CutStr.cutStr(strCate,6).equals("101110") || CutStr.cutStr(strCate,6).equals("101112") || CutStr.cutStr(strCate,6).equals("102502") ||  CutStr.cutStr(strCate,6).equals("101114") ||
				CutStr.cutStr(strCate,6).equals("101118")
			){
				if (strReturn.indexOf("권") < 0){
					strReturn = "";
				}else{
					strReturn = "권";
				}
			}																												
			if (CutStr.cutStr(strCate,6).equals("070202") || CutStr.cutStr(strCate,6).equals("070203") || CutStr.cutStr(strCate,6).equals("070220") || 	CutStr.cutStr(strCate,6).equals("070213") || 
				CutStr.cutStr(strCate,6).equals("070209") || CutStr.cutStr(strCate,8).equals("07020528") ||
				CutStr.cutStr(strCate,6).equals("071303") || CutStr.cutStr(strCate,6).equals("071304") || CutStr.cutStr(strCate,6).equals("071307") || CutStr.cutStr(strCate,6).equals("071308") 
			){
				if (strReturn.equals("G+TB")){
					strReturn = "";
				}else{
					strReturn = "G";
				}	
			}					
			if (CutStr.cutStr(strCate,8).equals("16360102") || CutStr.cutStr(strCate,6).equals("081401") || CutStr.cutStr(strCate,6).equals("092011")  || CutStr.cutStr(strCate,8).equals("16031201") || 
				CutStr.cutStr(strCate,8).equals("16031202") || CutStr.cutStr(strCate,8).equals("16031203") || CutStr.cutStr(strCate,8).equals("16030702") || CutStr.cutStr(strCate,8).equals("16030703") || 
				CutStr.cutStr(strCate,8).equals("16030707") || CutStr.cutStr(strCate,8).equals("16030708") || CutStr.cutStr(strCate,8).equals("16030710") || CutStr.cutStr(strCate,8).equals("16030904") ||
				CutStr.cutStr(strCate,8).equals("05190702") || CutStr.cutStr(strCate,8).equals("05101912") || CutStr.cutStr(strCate,8).equals("05151806") || CutStr.cutStr(strCate,8).equals("06111311") ||
				CutStr.cutStr(strCate,8).equals("21080202") || CutStr.cutStr(strCate,8).equals("21080208") || CutStr.cutStr(strCate,8).equals("21080209") || CutStr.cutStr(strCate,8).equals("21080613") ||
				CutStr.cutStr(strCate,8).equals("09110504") || CutStr.cutStr(strCate,8).equals("05152107") || CutStr.cutStr(strCate,8).equals("05152109") ||   
				CutStr.cutStr(strCate,8).equals("09200120") || CutStr.cutStr(strCate,8).equals("09200502") || CutStr.cutStr(strCate,8).equals("09200410") || CutStr.cutStr(strCate,8).equals("09200411") ||
				CutStr.cutStr(strCate,8).equals("09200212") || CutStr.cutStr(strCate,6).equals("091104") || CutStr.cutStr(strCate,8).equals("16110702") || CutStr.cutStr(strCate,8).equals("09110514") ||
				CutStr.cutStr(strCate,8).equals("16110703") || CutStr.cutStr(strCate,8).equals("16360111") || CutStr.cutStr(strCate,8).equals("16360112") || CutStr.cutStr(strCate,8).equals("16360113") ||
				CutStr.cutStr(strCate,8).equals("12070503") || CutStr.cutStr(strCate,6).equals("100301") || CutStr.cutStr(strCate,6).equals("162116") || CutStr.cutStr(strCate,8).equals("16351602") || CutStr.cutStr(strCate,8).equals("21451602") ||
				CutStr.cutStr(strCate,8).equals("05151302") || CutStr.cutStr(strCate,8).equals("05150404") || CutStr.cutStr(strCate,6).equals("150110") ||
				CutStr.cutStr(strCate,8).equals("16250909") || CutStr.cutStr(strCate,8).equals("16250911") || CutStr.cutStr(strCate,8).equals("06061705") || 
				CutStr.cutStr(strCate,8).equals("06061706") || CutStr.cutStr(strCate,8).equals("16210503") || CutStr.cutStr(strCate,6).equals("122507") || CutStr.cutStr(strCate,8).equals("05102307") ||
				CutStr.cutStr(strCate,8).equals("05102310") || CutStr.cutStr(strCate,8).equals("05101114") || CutStr.cutStr(strCate,6).equals("060617") || CutStr.cutStr(strCate,6).equals("162105")
			){
				if (strReturn.indexOf("개") < 0){
					strReturn = "";
				}
			}
			
			if (CutStr.cutStr(strCate,6).equals("100505") || CutStr.cutStr(strCate,8).equals("10050209")){
				if (strReturn.indexOf("개") >= 0 ){
					strReturn = "개";
				}else if (strReturn.indexOf("팩") >= 0 ){
					strReturn = "팩";
				}else if (strReturn.indexOf("세트") >= 0 ){
					strReturn = "세트";
				}else if (strReturn.indexOf("봉") >= 0 ){
					strReturn = "봉";
				}else if (strReturn.indexOf("캔") >= 0 ){
					strReturn = "캔";
				}else if (strReturn.indexOf("정기배송") >= 0 ){
					strReturn = "";
				}
			}
			if (CutStr.cutStr(strCate,8).equals("16110709") || CutStr.cutStr(strCate,8).equals("16110710") || CutStr.cutStr(strCate,8).equals("16110711")){
				if (strReturn.indexOf("개") >= 0){
					strReturn = "10개";
				}			
			}
			if (CutStr.cutStr(strCate,6).equals("081302") || (CutStr.cutStr(strCate,6).equals("081309") && !CutStr.cutStr(strCate,8).equals("08130901") && !CutStr.cutStr(strCate,8).equals("08130902")) || 
				CutStr.cutStr(strCate,6).equals("052604") || CutStr.cutStr(strCate,8).equals("05260302") || CutStr.cutStr(strCate,6).equals("080709") || CutStr.cutStr(strCate,6).equals("165409") || CutStr.cutStr(strCate,8).equals("06060616") || 
				CutStr.cutStr(strCate,8).equals("08140604")
			){
				
				if (strReturn.indexOf("+") >= 0 || strReturn.indexOf("구매대행") >= 0 || strReturn.indexOf("해외쇼핑") >= 0){
					strReturn = "";
				}else{
					if (strReturn.indexOf("매") >= 0){
						strReturn = "매";
					}else if (strReturn.indexOf("개") >= 0){
						strReturn = "개";
					}
				}
			}			
			if (CutStr.cutStr(strCate,6).equals("080218") || CutStr.cutStr(strCate,6).equals("080220")  || CutStr.cutStr(strCate,6).equals("180304") || CutStr.cutStr(strCate,6).equals("180305") || 
				CutStr.cutStr(strCate,6).equals("180301") || CutStr.cutStr(strCate,6).equals("180302") || CutStr.cutStr(strCate,6).equals("032103") || CutStr.cutStr(strCate,6).equals("180306") ||
				CutStr.cutStr(strCate,6).equals("180312") || CutStr.cutStr(strCate,6).equals("080214") || CutStr.cutStr(strCate,8).equals("05152103") || CutStr.cutStr(strCate,6).equals("080225") ||
				CutStr.cutStr(strCate,6).equals("080230") || CutStr.cutStr(strCate,6).equals("180313") || CutStr.cutStr(strCate,6).equals("180303") || CutStr.cutStr(strCate,8).equals("04020208")
			){
				if (strReturn.indexOf("매") < 0){
					strReturn = "";
				}
			}			
			if ( CutStr.cutStr(strCate,6).equals("035608") ){
				if (!strReturn.equals("팩")){
					strReturn = "";
				}
			}
			if (CutStr.cutStr(strCate,8).equals("05140306")){
				if (!strReturn.equals("개")){
					strReturn = "";
				}
			}	

			if (CutStr.cutStr(strCate,6).equals("062006")  
			){
				if (strReturn.indexOf("세트") < 0){
					strReturn = "";
				}else{
					if (strReturn.equals("기획세트")){
						strReturn = "";
					}else{
						strReturn = "세트";
					}
				}
			}			
			if (CutStr.cutStr(strCate,6).equals("080906") || CutStr.cutStr(strCate,6).equals("080908") || CutStr.cutStr(strCate,6).equals("080910") || CutStr.cutStr(strCate,6).trim().equals("160309") ||
				CutStr.cutStr(strCate,8).equals("05150314")
			){
				if (strReturn.indexOf("개") < 0 && strReturn.indexOf("매") < 0){
					strReturn = "";
				}
			}	
			if (CutStr.cutStr(strCate,6).equals("160302") || CutStr.cutStr(strCate,6).equals("160303") || CutStr.cutStr(strCate,6).equals("160304") ||
				CutStr.cutStr(strCate,6).equals("160305") || CutStr.cutStr(strCate,6).equals("160306") || CutStr.cutStr(strCate,6).equals("160311") 
			){
				if (strReturn.indexOf(",") >= 0 ){
					strReturn = strReturn.substring(strReturn.indexOf(",")+1,strReturn.length());
				}
				if (!strReturn.equals("개") && !strReturn.equals("매")){
					strReturn = "";
				}				
			}			
			if (CutStr.cutStr(strCate,6).equals("162901") || CutStr.cutStr(strCate,6).equals("162910") || CutStr.cutStr(strCate,6).equals("162907") || CutStr.cutStr(strCate,6).equals("162903") || 
				(CutStr.cutStr(strCate,6).equals("162902") && !CutStr.cutStr(strCate,8).equals("16290201")) || CutStr.cutStr(strCate,8).equals("16290608")){
				if (strReturn.indexOf("개") < 0 && strReturn.indexOf("팩") < 0  && strReturn.indexOf("세트") < 0){
					strReturn = "";
				}			
			}
			if (CutStr.cutStr(strCate,8).equals("16050806") || CutStr.cutStr(strCate,8).equals("16050802") || CutStr.cutStr(strCate,8).trim().equals("16050809")){
				
				if (strReturn.indexOf("개") >= 0 ){
					strReturn = "개";
				}else if (strReturn.indexOf("팩") >= 0 ){
					strReturn = "팩";
				}else if (strReturn.indexOf("세트") >= 0 ){
					strReturn = "세트";
				}else{
					strReturn = "";
				}
			}
			if (CutStr.cutStr(strCate,8).equals("16290502") || CutStr.cutStr(strCate,4).equals("0804") || CutStr.cutStr(strCate,4).equals("0805")
			){
				strReturn = "";
				if (strCondiName != null && strCondiName.trim().length() > 0 ){
					if (strCondiName.substring(strCondiName.length()-1,strCondiName.length()).equals("개")){
						strReturn = "개";
					}
				}
			}
			if (CutStr.cutStr(strCate,6).equals("100303")){
				if (strReturn.indexOf("개") >= 0){
					strReturn = "개";
				}else if(strReturn.indexOf("팩") >= 0){
					strReturn = "팩";
				}else{
					strReturn = "";
				} 
			} 
			if (CutStr.cutStr(strCate,8).equals("05151709")){
				if (strReturn.indexOf("개") < 0 && strReturn.indexOf("박스") < 0){
					strReturn = "";
				}			
			}
			if (CutStr.cutStr(strCate,6).equals("051503") && !CutStr.cutStr(strCate,8).equals("05150314") && !CutStr.cutStr(strCate,8).equals("05150301")){
				if (strReturn.indexOf("패드") < 0){
					strReturn = "";
				}			
			}
			if (CutStr.cutStr(strCate,8).equals("03551001")){
				if (strReturn.equals("개")){
					strReturn = "개";
				}
				if (strReturn.indexOf("장") >= 0){
					strReturn = "장";
				}									
			}			
			if (CutStr.cutStr(strCate,6).equals("160505") || CutStr.cutStr(strCate,8).equals("16110407") || CutStr.cutStr(strCate,8).equals("10120105")){
				if (strReturn.indexOf("장") >= 0){
					strReturn = "장";
				}else{
					strReturn = "";
				}								
			}
			if (CutStr.cutStr(strCate,8).equals("16360102") || CutStr.cutStr(strCate,8).equals("16360111") || CutStr.cutStr(strCate,8).equals("16360112") || CutStr.cutStr(strCate,8).equals("16360113") || CutStr.cutStr(strCate,8).equals("16290201") ){
				strReturn = "ml";
			}
			if (CutStr.cutStr(strCate,6).equals("161203") || CutStr.cutStr(strCate,6).equals("161204") || CutStr.cutStr(strCate,6).equals("161207") || CutStr.cutStr(strCate,6).equals("161213") || 
				CutStr.cutStr(strCate,8).equals("16120815")){
				if (strReturn.indexOf("P") >= 0){
					strReturn = "개";
				}
			}
			if (CutStr.cutStr(strCate,6).equals("161215")
			){
				if (strReturn.indexOf("P") >= 0){
					strReturn = "개";
				}else{
					strReturn = "";
				}
			}						
			if (CutStr.cutStr(strCate,4).equals("0809")){
				if (strReturn.indexOf("구매대행") >= 0 || strReturn.indexOf("리필") >= 0 || strReturn.indexOf("해외쇼핑") >= 0){
					strReturn = "";
				}
			}
			if (CutStr.cutStr(strCate,6).equals("100105") || CutStr.cutStr(strCate,6).equals("100108") || CutStr.cutStr(strCate,8).equals("16370605") || CutStr.cutStr(strCate,8).equals("16351601") || CutStr.cutStr(strCate,8).equals("16351604") || CutStr.cutStr(strCate,8).equals("21451601") || CutStr.cutStr(strCate,8).equals("21451604")){
				if (strReturn.indexOf("개") < 0 && strReturn.indexOf("장") < 0 && strReturn.indexOf("매") < 0 && strReturn.indexOf("켤레") < 0){
					strReturn = "";
				}
			}
			if (CutStr.cutStr(strCate,4).equals("0809")){
				if (strReturn.indexOf("개") < 0 && strReturn.indexOf("세트") < 0 && strReturn.indexOf("매") < 0 ){
					strReturn = "";
				}
			}
			if (CutStr.cutStr(strCate,8).equals("16050106")){
				if (strReturn.indexOf("개") < 0 && strReturn.indexOf("롤") < 0 ){
					strReturn = "";
				}
			}			
			if (CutStr.cutStr(strCate,8).equals("16110801") || CutStr.cutStr(strCate,8).trim().equals("10011010")){
				if (strReturn.indexOf("개") < 0 && strReturn.indexOf("켤레") < 0){
					strReturn = "";
				}
			}	
			if (CutStr.cutStr(strCate,6).equals("162912")){
				if (!strReturn.equals("개") && !strReturn.equals("팩") && !strReturn.equals("세트")  ){
					strReturn = "";
				}			
			}
			if (CutStr.cutStr(strCate,8).equals("16361106") || CutStr.cutStr(strCate,8).equals("16361102") || CutStr.cutStr(strCate,8).equals("16361104") || 
			(CutStr.cutStr(strCate,6).equals("080612") && !CutStr.cutStr(strCate,8).equals("08061201") && !CutStr.cutStr(strCate,8).equals("08061202") && !CutStr.cutStr(strCate,8).equals("08061203") && !CutStr.cutStr(strCate,8).equals("08061204") &&
			!CutStr.cutStr(strCate,8).equals("08061207")) ){
				if (!strReturn.equals("개") && !strReturn.equals("팩") && !strReturn.equals("매")  ){
					strReturn = "";
				}			
			}			
			if (CutStr.cutStr(strCate,6).equals("102504")  || CutStr.cutStr(strCate,6).equals("102505") || CutStr.cutStr(strCate,6).equals("102508")){
				if (strReturn.indexOf("장") < 0 && strReturn.indexOf("박스") < 0  && strReturn.indexOf("팩") < 0  && strReturn.indexOf("개") < 0 ){
					strReturn = "";
				}else{
					if (strReturn.indexOf("장") > 0){
						strReturn = "장";
					}
					if (strReturn.indexOf("박스") > 0){
						strReturn = "박스";
					}
					if (strReturn.indexOf("팩") > 0){
						strReturn = "팩";
					}					
					if (strReturn.indexOf("개") > 0 ){
						strReturn = "개";
					}								
					if (CutStr.cutStr(strCate,8).equals("10250402") && strReturn.equals("개")){
						strReturn = "";
					}		
				}		
			}			
			if (CutStr.cutStr(strCate,6).trim().equals("101201") ||  CutStr.cutStr(strCate,6).trim().equals("101210") || CutStr.cutStr(strCate,6).equals("093006")){
				if (strCondiName.trim().length() > 0 ){
					if (strCondiName.substring(strCondiName.length()-1,strCondiName.length()).equals("장")){
						strReturn = "장";
					}					
				}
				if (CutStr.cutStr(strCate,6).equals("093006")){
					if (!strReturn.equals("장")){
						strReturn = "";
					}
				}
			}
			if (CutStr.cutStr(strCate,6).equals("161203") || CutStr.cutStr(strCate,6).equals("161204") || CutStr.cutStr(strCate,6).equals("161207") || CutStr.cutStr(strCate,6).equals("161213")){
				if (strReturn.indexOf("구매대행") >= 0 || strReturn.indexOf("일반") >= 0 || strReturn.indexOf("해외쇼핑") >= 0){
					strReturn = "";
				}			
			}
			if (CutStr.cutStr(strCate,6).equals("161201")){
				if (strReturn.indexOf("인조") >= 0){
					strReturn = "인조";
				}			
			}
			if (CutStr.cutStr(strCate,8).equals("16321103") || CutStr.cutStr(strCate,6).equals("081405") || CutStr.cutStr(strCate,6).equals("081406") || CutStr.cutStr(strCate,6).equals("081408") ||   
				CutStr.cutStr(strCate,8).equals("08090802") || CutStr.cutStr(strCate,8).equals("08090801") || CutStr.cutStr(strCate,8).equals("16360704")  || CutStr.cutStr(strCate,6).equals("162509") ||
				CutStr.cutStr(strCate,6).equals("080909") || CutStr.cutStr(strCate,6).equals("080910") || CutStr.cutStr(strCate,6).equals("080905") || CutStr.cutStr(strCate,8).equals("08060108") ||
				CutStr.cutStr(strCate,8).equals("08060111") || CutStr.cutStr(strCate,8).equals("08060110") || CutStr.cutStr(strCate,8).equals("08060112") || CutStr.cutStr(strCate,8).equals("09201112") || 
				CutStr.cutStr(strCate,8).equals("09201111")
			){
				if (strReturn.indexOf("개") >= 0){
					strReturn = "개";
				}
			}
			if ( CutStr.cutStr(strCate,6).equals("081402") || CutStr.cutStr(strCate,6).equals("081404") || CutStr.cutStr(strCate,6).equals("081410")){
				if (strReturn.indexOf("개") >= 0){
					strReturn = "개";
				}else{
					strReturn = "";
				}
			}
			if(CutStr.cutStr(strCate,8).equals("16051504")){
				if (strCondiName.indexOf("개") >= 0){
					String strSpecUnit[] = strSpec.split("/");
					String strLastSpecUnit = "";			
					if (strSpecUnit != null && strSpecUnit.length > 1 ){
						strLastSpecUnit = strSpecUnit[1].trim();
						strLastSpecUnit = lastSpecReplace(strLastSpecUnit);
						if (strLastSpecUnit != null && strLastSpecUnit.trim().length() > 0 ){
							for (int i=0;i<strLastSpecUnit.length();i++){
								String strCharOne = strLastSpecUnit.substring(i,i+1);
								if (!ChkNull.chkNumber(strCharOne)){
									strReturn = strReturn + strCharOne;
								}
							}
						}
					}	
				}else if(strCondiName.indexOf("ml") >= 0){
					strReturn = strCondiName;
				}
				if(strReturn.indexOf("ml") >= 0){
					strReturn = "ml";
				}
			}			
			if (CutStr.cutStr(strCate,8).equals("16141101") || CutStr.cutStr(strCate,8).equals("16141103") || CutStr.cutStr(strCate,8).equals("16141102")){
				if (strReturn.indexOf("롤") >= 0){
					strReturn = "롤";
				}
				if (strReturn.indexOf("개") >= 0){
					strReturn = "개";
				}			
			}
			if (CutStr.cutStr(strCate,4).equals("0605")){
				if (!strReturn.equals("매")){
					strReturn = "";
				}						
			}			
			if (CutStr.cutStr(strCate,8).equals("16110802")){
				if (strReturn.trim().length() > 0){
					strReturn = "개";
				}else{
					strReturn = "";
				}
			} 
			if (CutStr.cutStr(strCate,8).equals("05102201") || CutStr.cutStr(strCate,8).equals("05102202") || CutStr.cutStr(strCate,8).equals("05102203")){
				if (strReturn.indexOf("개") >= 0 ){
					strReturn = "개";
				}else if (strReturn.indexOf("g") >= 0){
					strReturn = "g";
				}else{
					strReturn = "";
				}			
			}			
			if (CutStr.cutStr(strCate,8).equals("16360702") || CutStr.cutStr(strCate,8).equals("16360703") || CutStr.cutStr(strCate,8).equals("16360711") || CutStr.cutStr(strCate,8).equals("16111310") ||
				CutStr.cutStr(strCate,8).equals("16110901")	|| CutStr.cutStr(strCate,8).equals("16110902") || CutStr.cutStr(strCate,8).equals("16110903") || CutStr.cutStr(strCate,8).equals("16111307") 
			){
				if (strReturn.indexOf("매") >= 0 ){
					strReturn = "매";
				}else if (strReturn.indexOf("팩") >= 0){
					strReturn = "팩";
				}else{
					strReturn = "";
				}		
			}
			if (CutStr.cutStr(strCate,8).equals("16290512")){
				if (strReturn.indexOf("매") >= 0 && strReturn.indexOf("팩") >= 0){
					strReturn = "매";
				}else{
					strReturn = "";
				}		
			}
			if (CutStr.cutStr(strCate,8).equals("16290707")  ||  CutStr.cutStr(strCate,8).equals("16360709") || CutStr.cutStr(strCate,8).equals("16050803") || CutStr.cutStr(strCate,8).equals("16050816")){
				if (strReturn.indexOf("매") >= 0 && strReturn.indexOf("팩") >= 0){
					strReturn = "매";
				}else if(strReturn.indexOf("개") >= 0){
					strReturn = "개";
				}else{
					strReturn = "";
				}		
			}
			if (CutStr.cutStr(strCate,8).equals("16290702") || CutStr.cutStr(strCate,8).equals("16290703")){
				if (strReturn.indexOf("매") >= 0 && strReturn.indexOf("팩") >= 0){
					strReturn = "매";
				}else if(strReturn.indexOf("개") >= 0){
					strReturn = "개";
				}else{
					strReturn = "";
				}		
			}			
			if (CutStr.cutStr(strCate,8).equals("16290503")){
				if (strReturn.indexOf("개") >= 0 && strReturn.indexOf("팩") >= 0){
					strReturn = "개";
				}else{
					strReturn = "";
				}		
			}
			if (CutStr.cutStr(strCate,6).equals("162909")){
				if (strReturn.indexOf("개") >= 0 && strReturn.indexOf("팩") >= 0){
					strReturn = "개";
				}else if(strReturn.indexOf("개") >= 0){
					strReturn = "개";
				}else{
					strReturn = "";
				}		
			}
			if (CutStr.cutStr(strCate,8).equals("16111311")){
				if (strReturn.indexOf("팩") >= 0){
					strReturn = "팩";
				}else if(strReturn.indexOf("개") >= 0){
					strReturn = "개";
				}else{
					strReturn = "";
				}		
			}			
			if (CutStr.cutStr(strCate,8).equals("16421012")){
				if (strReturn.indexOf("L") >= 0){
					strReturn = "L";
				}else if(strReturn.indexOf("P") >= 0){
					strReturn = "개";
				}else{
					strReturn = "";
				}		
			}
			if (CutStr.cutStr(strCate,8).equals("12261002") || CutStr.cutStr(strCate,8).equals("12261003") || CutStr.cutStr(strCate,8).equals("16351312") || CutStr.cutStr(strCate,8).equals("21451312") || CutStr.cutStr(strCate,6).equals("122611")){
				if (strReturn.indexOf("m") >= 0){
					strReturn = "m";
				}else{
					strReturn = "";
				}
			}
			if (CutStr.cutStr(strCate,8).equals("05102308") || CutStr.cutStr(strCate,8).equals("05102305")){
				if (!strReturn.equals("박스") && !strReturn.equals("봉지") && !strReturn.equals("개")  ){
					strReturn = "";
				}
			}			
		}else if(bSpecCheck(strCate) || bGetIndividualChangeUnitBySpec(strCate)){//요약설명에 있는 항목으로 계산해야 하는 경우
			if (CutStr.cutStr(strCate,6).equals("161401") || CutStr.cutStr(strCate,8).equals("16140804") ||CutStr.cutStr(strCate,8).equals("16140806") || 
				CutStr.cutStr(strCate,8).equals("16140808")  || CutStr.cutStr(strCate,8).equals("16140904") || CutStr.cutStr(strCate,8).equals("16140906") ||
				CutStr.cutStr(strCate,8).equals("16140908") || CutStr.cutStr(strCate,8).equals("16140903") 
			){
				if (strSpec.split("/") != null && strSpec.split("/").length > 0 ){
					String strMiter = strSpec.split("/")[1];
					if (strMiter.length() == 3){
						if (strMiter.substring(2,3).equals("m")){
							if (ChkNull.chkNumber(CutStr.cutStr(strMiter,2))){
								strReturn = "10m";									
							}
						}
					}
				}			
			}else if (CutStr.cutStr(strCate,8).equals("10031201")  || CutStr.cutStr(strCate,8).equals("10031108") || CutStr.cutStr(strCate,8).equals("10031102") || CutStr.cutStr(strCate,8).equals("10031202") || 
					CutStr.cutStr(strCate,6).equals("100316") || CutStr.cutStr(strCate,6).equals("100317") 
			){
				if (strSpec.split("/") != null && strSpec.split("/").length > 0 ){
					String strCnt = strSpec.split("/")[strSpec.split("/").length-1];
					if (strCnt.indexOf("매") >= 0){
						strReturn = "매";
					}
					if (strCnt.indexOf("개") >= 0){
						strReturn = "개";
					}					
				}		
				if (CutStr.cutStr(strCate,6).equals("100317") && strReturn.trim().length() == 0){
					if (strCondiName != null && strCondiName.trim().length() > 0 ){
						if (strCondiName.substring(strCondiName.length()-1,strCondiName.length()).equals("개")){
							strReturn = "개";
						}
					}
				}
			}else if ( 
					CutStr.cutStr(strCate,8).equals("16140301") || CutStr.cutStr(strCate,8).equals("16140304") ||
					CutStr.cutStr(strCate,8).equals("16140305") || CutStr.cutStr(strCate,8).equals("16140306") ||
					CutStr.cutStr(strCate,8).equals("16140309")					
				){
				if (strSpec.split("/") != null && strSpec.split("/").length > 0 ){
					String strCnt = strSpec.split("/")[1];
					if (strCnt.indexOf("매") >= 0){
						strReturn = "10매";
					}
				}	
			}else if(CutStr.cutStr(strCate,8).equals("16110901") || CutStr.cutStr(strCate,8).equals("16110902") || CutStr.cutStr(strCate,8).equals("16110903") ||
				CutStr.cutStr(strCate,8).equals("16111307")
			){
				if (strSpec.split("/") != null && strSpec.split("/").length > 1 ){
					String strCnt = strSpec.split("/")[1];
					if (strCnt.substring(strCnt.length()-1,strCnt.length()).equals("매")){
						strReturn = "매";
					}
				}				
			}else if (CutStr.cutStr(strCate,8).equals("10230405")){
				if (strSpec.split("/") != null && strSpec.split("/").length > 0 ){
					String strCnt = strSpec.split("/")[strSpec.split("/").length-1];
					if (strCnt.substring(strCnt.length()-1,strCnt.length()).equals("개")){
						strReturn = "개";
					}else{
						strReturn = "";
					}
				}		
			}else if (CutStr.cutStr(strCate,6).equals("120302")){
				if (strSpec.split("/") != null && strSpec.split("/").length > 1 ){
					String strCm = strSpec.split("/")[1];
					if (strCm.indexOf("(") > 0 ){
						strCm = CutStr.cutStr(strCm,strCm.indexOf("("));
						String strCm1 = "";
						for (int i=0;i<strCm.length();i++){
							String strCharOne = strCm.substring(i,i+1);
							if (ChkNull.chkNumber(strCharOne)){
								strCm1 = strCm1 + strCharOne;
							}
						}
						if (ChkNull.chkNumber(strCm1)){
							strReturn = "10cm";									
						}				
					}else{
						String strCm1 = "";
						for (int i=0;i<strCm.length();i++){
							String strCharOne = strCm.substring(i,i+1);
							if (ChkNull.chkNumber(strCharOne)){
								strCm1 = strCm1 + strCharOne;
							}
						}
						if (ChkNull.chkNumber(strCm1)){
							strReturn = "10cm";
						}				
					}
				}	
			}else if (CutStr.cutStr(strCate,8).equals("12020504")){
				if (strCondiName.trim().indexOf("cm") >= 0){
					strReturn = "10cm";
				}
			}else if(CutStr.cutStr(strCate,8).equals("16421702")){
				if (strSpec.split("/") != null && strSpec.split("/").length > 1 ){
					String strCm = strSpec.split("/")[strSpec.split("/").length-1];
					if (strCm.indexOf("g") > 0 ){
						strReturn = "kg";									
					}else if(strCm.indexOf("ml") > 0 ){
						strReturn = "L";				
					}
				}				
			}else if(CutStr.cutStr(strCate,8).equals("16421402") || CutStr.cutStr(strCate,8).equals("16421403") || CutStr.cutStr(strCate,8).equals("16421408")){
				if (strSpec.split("/") != null && strSpec.split("/").length > 1 ){
					String strCnt = strSpec.split("/")[strSpec.split("/").length-1];
					if (strCnt.substring(strCnt.length()-1,strCnt.length()).equals("매")){
						strReturn = "매";
					}
				}				
			}else if(CutStr.cutStr(strCate,8).equals("16421317") ){
				if (strSpec.split("/") != null && strSpec.split("/").length > 1 ){
					String strCnt = strSpec.split("/")[strSpec.split("/").length-1];
					if (strCnt.substring(strCnt.length()-1,strCnt.length()).equals("개")){
						strReturn = "개";
					}
				}				
			}else if(CutStr.cutStr(strCate,6).equals("080601") || CutStr.cutStr(strCate,6).equals("080602") || CutStr.cutStr(strCate,6).equals("080611") || CutStr.cutStr(strCate,4).equals("0812") ||
				 CutStr.cutStr(strCate,6).equals("080603") || CutStr.cutStr(strCate,6).equals("080613") || CutStr.cutStr(strCate,6).equals("080605") || CutStr.cutStr(strCate,6).equals("080608") ||
				 (CutStr.cutStr(strCate,6).equals("080606") && !CutStr.cutStr(strCate,8).equals("08060615")) || CutStr.cutStr(strCate,8).equals("08061203") || CutStr.cutStr(strCate,6).equals("080615") ||
				 CutStr.cutStr(strCate,6).equals("100501") || CutStr.cutStr(strCate,8).equals("10050201") || CutStr.cutStr(strCate,8).equals("10050204") || CutStr.cutStr(strCate,6).equals("100508") ||
				 CutStr.cutStr(strCate,6).equals("100511") || CutStr.cutStr(strCate,6).equals("100512") || CutStr.cutStr(strCate,6).equals("100513") || CutStr.cutStr(strCate,6).equals("100514") ||
				 CutStr.cutStr(strCate,6).equals("100515") || CutStr.cutStr(strCate,6).equals("100516") || CutStr.cutStr(strCate,8).equals("16420901") ||
				 CutStr.cutStr(strCate,8).equals("10050206") || CutStr.cutStr(strCate,8).equals("10050208") || CutStr.cutStr(strCate,8).equals("10050208") || CutStr.cutStr(strCate,8).equals("10050203") ||
				 CutStr.cutStr(strCate,8).equals("10050203") || CutStr.cutStr(strCate,6).equals("081407") || CutStr.cutStr(strCate,6).equals("080617") || CutStr.cutStr(strCate,6).equals("080618") ||
				 CutStr.cutStr(strCate,8).equals("10050210") || CutStr.cutStr(strCate,8).equals("10050211") || CutStr.cutStr(strCate,8).equals("10050212") || CutStr.cutStr(strCate,8).equals("10050213") ||
				 CutStr.cutStr(strCate,8).equals("10050215") || CutStr.cutStr(strCate,8).equals("10050216") || CutStr.cutStr(strCate,6).equals("080104") || CutStr.cutStr(strCate,6).equals("080112") ||
				 CutStr.cutStr(strCate,6).equals("080107") || CutStr.cutStr(strCate,6).equals("080102") || CutStr.cutStr(strCate,6).equals("080103") || CutStr.cutStr(strCate,6).equals("080120") ||
				 CutStr.cutStr(strCate,6).equals("080121") || CutStr.cutStr(strCate,6).equals("080122") || CutStr.cutStr(strCate,6).equals("080123") || CutStr.cutStr(strCate,6).equals("080111") ||
				 CutStr.cutStr(strCate,6).equals("080104") || CutStr.cutStr(strCate,6).equals("080112") || CutStr.cutStr(strCate,6).equals("080107") || CutStr.cutStr(strCate,6).equals("080102") || 
				 CutStr.cutStr(strCate,6).equals("080103") || CutStr.cutStr(strCate,6).equals("080120") || CutStr.cutStr(strCate,6).equals("080121") || CutStr.cutStr(strCate,6).equals("080122") || 
				 CutStr.cutStr(strCate,6).equals("080123") || CutStr.cutStr(strCate,6).equals("080111") || CutStr.cutStr(strCate,8).equals("08061201") || CutStr.cutStr(strCate,8).equals("08061202") ||
				 CutStr.cutStr(strCate,8).equals("08061204") || CutStr.cutStr(strCate,8).equals("08061207") || CutStr.cutStr(strCate,8).equals("15080201") || CutStr.cutStr(strCate,8).equals("15080203") ||
				 CutStr.cutStr(strCate,8).equals("15080204") || CutStr.cutStr(strCate,8).equals("15080205") || CutStr.cutStr(strCate,8).equals("15080205") || CutStr.cutStr(strCate,8).equals("15080228") ||
				 CutStr.cutStr(strCate,8).equals("15080222") || CutStr.cutStr(strCate,8).equals("15080223") || CutStr.cutStr(strCate,8).equals("15080229") || CutStr.cutStr(strCate,8).equals("15080226") ||
				 CutStr.cutStr(strCate,8).equals("08130901") || CutStr.cutStr(strCate,8).equals("21150506") || (CutStr.cutStr(strCate,6).equals("150801") && !CutStr.cutStr(strCate,8).equals("15080113")) ||
				 CutStr.cutStr(strCate,8).equals("08130902") || CutStr.cutStr(strCate,6).equals("150809") || CutStr.cutStr(strCate,8).equals("15091303") ||
				 CutStr.cutStr(strCate,8).equals("15080230") || CutStr.cutStr(strCate,8).equals("15080231") ||
				 ( CutStr.cutStr(strCate,6).equals("150808") && !CutStr.cutStr(strCate,8).equals("15080806") && !CutStr.cutStr(strCate,8).equals("15080807") && !CutStr.cutStr(strCate,8).equals("15080812")) ||
				  CutStr.cutStr(strCate,6).equals("150813")   
			){
				String strSpecUnit[] = strSpec.split("/");
				String strLastSpecUnit = "";			
				if (strSpecUnit != null && strSpecUnit.length > 0 ){
					if (strSpecUnit[strSpecUnit.length-1].indexOf("x") >= 0 ){
						String strTempSpecUnit[] = strSpecUnit[strSpecUnit.length-1].split("x");
						if (strTempSpecUnit != null && strTempSpecUnit.length > 0 ){
							strLastSpecUnit = strTempSpecUnit[0].trim();
						}
					}else{
						strLastSpecUnit = strSpecUnit[strSpecUnit.length-1].trim();
					}
					strLastSpecUnit = lastSpecReplace(strLastSpecUnit);
					if (strLastSpecUnit != null && strLastSpecUnit.trim().length() > 0 ){
						for (int i=0;i<strLastSpecUnit.length();i++){
							String strCharOne = strLastSpecUnit.substring(i,i+1);
							if (!ChkNull.chkNumber(strCharOne)){
								strReturn = strReturn + strCharOne;
							}
						}
					}
				}
				if (CutStr.cutStr(strCate,6).equals("080613") || CutStr.cutStr(strCate,6).equals("080601")){
					if (strReturn.equals("총ml")){
						strReturn = "ml";
					}
				}
								
				if (!strReturn.equals("g") && !strReturn.equals("ml") && !strReturn.equals("매") && !strReturn.equals("봉") && !strReturn.equals("티백") && !strReturn.equals("세트") && !strReturn.equals("정") ){
					strReturn = "";
				}
				if (CutStr.cutStr(strCate,6).equals("080104") || CutStr.cutStr(strCate,6).equals("080112") ||
				 CutStr.cutStr(strCate,6).equals("080107") || CutStr.cutStr(strCate,6).equals("080102") || CutStr.cutStr(strCate,6).equals("080103") || CutStr.cutStr(strCate,6).equals("080120") ||
				 CutStr.cutStr(strCate,6).equals("080121") || CutStr.cutStr(strCate,6).equals("080122") || CutStr.cutStr(strCate,6).equals("080123") || CutStr.cutStr(strCate,6).equals("080111") ||
				 CutStr.cutStr(strCate,6).equals("080104") || CutStr.cutStr(strCate,6).equals("080112") || CutStr.cutStr(strCate,6).equals("080107") || CutStr.cutStr(strCate,6).equals("080102") || 
				 CutStr.cutStr(strCate,6).equals("080103") || CutStr.cutStr(strCate,6).equals("080120") || CutStr.cutStr(strCate,6).equals("080121") || CutStr.cutStr(strCate,6).equals("080122") || 
				 CutStr.cutStr(strCate,6).equals("080123") || CutStr.cutStr(strCate,6).equals("080111")){
				 	if (!(strCondiName.trim().indexOf("ml") >= 0 || strCondiName.trim().indexOf("g") >= 0 )){
				 		strReturn = "";
				 	} 
				 }

			}else if(CutStr.cutStr(strCate,8).equals("16110905") || CutStr.cutStr(strCate,8).equals("16110907") || CutStr.cutStr(strCate,8).equals("18010607") || CutStr.cutStr(strCate,8).equals("16321303")){
				if (strCondiName.trim().length() > 0 ){
					String strSpecUnit[] = strSpec.split("/");
					String strLastSpecUnit = "";			
					if (strSpecUnit != null && strSpecUnit.length > 0 ){
						if (strSpecUnit[strSpecUnit.length-1].indexOf("x") >= 0 ){
							String strTempSpecUnit[] = strSpecUnit[strSpecUnit.length-1].split("x");
							if (strTempSpecUnit != null && strTempSpecUnit.length > 0 ){
								strLastSpecUnit = strTempSpecUnit[1].trim();
							}
						}else{
							strLastSpecUnit = strSpecUnit[strSpecUnit.length-1].trim();
						}
						strLastSpecUnit = lastSpecReplace(strLastSpecUnit);
						if (strLastSpecUnit != null && strLastSpecUnit.trim().length() > 0 ){
							for (int i=0;i<strLastSpecUnit.length();i++){
								String strCharOne = strLastSpecUnit.substring(i,i+1);
								if (!ChkNull.chkNumber(strCharOne)){
									strReturn = strReturn + strCharOne;
								}
							}
						}
					}
					if (CutStr.cutStr(strCate,8).equals("16321303") && strReturn.indexOf("길이") < 0){
						strReturn = "";
					}
					if (strReturn.indexOf("m") >= 0){
						strReturn = "m";
					}				
				}
			}else if(CutStr.cutStr(strCate,8).equals("16421313") || CutStr.cutStr(strCate,8).equals("16421314") || CutStr.cutStr(strCate,8).equals("16421316") || CutStr.cutStr(strCate,8).equals("16421315") ||
				CutStr.cutStr(strCate,8).equals("16421318") ||  CutStr.cutStr(strCate,8).equals("16421323") ||  CutStr.cutStr(strCate,8).equals("16421612") ||  CutStr.cutStr(strCate,8).equals("16421613") ||
				CutStr.cutStr(strCate,8).equals("16421614") ||  CutStr.cutStr(strCate,8).equals("16421615") 
			){
				String strSpecUnit[] = strSpec.split("/");
				if (strSpecUnit != null && strSpecUnit.length > 2 ){
					String strLastSpecUnit = "";
					strLastSpecUnit = strSpecUnit[strSpecUnit.length-2];
					strLastSpecUnit = lastSpecReplace(strLastSpecUnit);
					String strNumber = "";
					if (strLastSpecUnit != null && strLastSpecUnit.trim().length() > 0 ){
						for (int i=0;i<strLastSpecUnit.length();i++){
							String strCharOne = strLastSpecUnit.substring(i,i+1);
							if (!ChkNull.chkNumber(strCharOne)){
								strReturn = strReturn + strCharOne;
							}else{
								strNumber = strNumber + strCharOne;
							}	
						}
					}	
					if (!strReturn.equals("g") && !strReturn.equals("ml")){
						strReturn = "";
					}
				}
				if (strReturn.trim().length() == 0){
					if (strCondiName.indexOf("P") > 0 ){
						strReturn = "개";
					}
				}
			}else{
				String strSpecUnit[] = strSpec.split("/");
				String strLastSpecUnit = "";
				if (strSpecUnit != null && strSpecUnit.length > 0 ){
					if ((
						CutStr.cutStr(strCate,4).equals("1625") || CutStr.cutStr(strCate,8).equals("21081301") || CutStr.cutStr(strCate,8).equals("21081302") || CutStr.cutStr(strCate,8).equals("21081303") || 
						CutStr.cutStr(strCate,8).equals("21081304") || CutStr.cutStr(strCate,8).equals("21081305") || CutStr.cutStr(strCate,8).equals("21081310") || CutStr.cutStr(strCate,8).equals("21081311") || 
						CutStr.cutStr(strCate,8).equals("21081312") || CutStr.cutStr(strCate,8).equals("16110901") ||
						CutStr.cutStr(strCate,8).equals("16110902") || CutStr.cutStr(strCate,8).equals("16110903") || CutStr.cutStr(strCate,8).equals("16360707") || CutStr.cutStr(strCate,8).equals("16360708") || 
						CutStr.cutStr(strCate,8).equals("21081315") || CutStr.cutStr(strCate,8).equals("21081316") || CutStr.cutStr(strCate,8).equals("21081317") || CutStr.cutStr(strCate,8).equals("21081318") || 
						CutStr.cutStr(strCate,8).equals("21081319") || CutStr.cutStr(strCate,8).equals("21081320") || CutStr.cutStr(strCate,8).equals("16111307") || CutStr.cutStr(strCate,8).equals("10030102") || 
						CutStr.cutStr(strCate,8).equals("10030103") || CutStr.cutStr(strCate,8).equals("10030104") || CutStr.cutStr(strCate,8).equals("10120303") || CutStr.cutStr(strCate,8).equals("10120304") || 
						CutStr.cutStr(strCate,8).equals("10120305") || CutStr.cutStr(strCate,8).equals("10120306") || CutStr.cutStr(strCate,8).equals("10120308") || CutStr.cutStr(strCate,8).equals("10120309") ||
						CutStr.cutStr(strCate,8).equals("10120315") || CutStr.cutStr(strCate,8).equals("10120307") || CutStr.cutStr(strCate,6).equals("210812") || CutStr.cutStr(strCate,8).equals("21080201") || 
						CutStr.cutStr(strCate,8).equals("21080203") || CutStr.cutStr(strCate,8).equals("21080206") || CutStr.cutStr(strCate,8).equals("21080207") || CutStr.cutStr(strCate,8).equals("21080211") || 
						CutStr.cutStr(strCate,8).equals("21080213") || CutStr.cutStr(strCate,8).equals("16321005") || CutStr.cutStr(strCate,8).equals("10120316") || CutStr.cutStr(strCate,8).equals("16051501") || 
						CutStr.cutStr(strCate,8).equals("16051502") || CutStr.cutStr(strCate,8).equals("16051503") || CutStr.cutStr(strCate,8).equals("09011910")
						)
						&& strSpecUnit.length > 1){
						strLastSpecUnit = strSpecUnit[1];
					}else{
						strLastSpecUnit = strSpecUnit[strSpecUnit.length-1];
					}
				}
				strLastSpecUnit = lastSpecReplace(strLastSpecUnit);
				if (strLastSpecUnit != null && strLastSpecUnit.trim().length() > 0 ){
					for (int i=0;i<strLastSpecUnit.length();i++){
						String strCharOne = strLastSpecUnit.substring(i,i+1);
						if (!ChkNull.chkNumber(strCharOne)){
							strReturn = strReturn + strCharOne;
						}
					}
				}			
				if(CutStr.cutStr(strCate,8).equals("16251103")){
					if (strCondiName.trim().indexOf("세트") >= 0){
						strReturn = "";
					}			
				}				
				if (CutStr.cutStr(strCate,8).equals("16051501") || CutStr.cutStr(strCate,8).equals("16051502") || CutStr.cutStr(strCate,6).equals("162507") || CutStr.cutStr(strCate,6).equals("162509") || 
					CutStr.cutStr(strCate,8).equals("16051503")){
					if (!strReturn.equals("g") && !strReturn.equals("ml")){
						strReturn = "";
					}
				}
				if (CutStr.cutStr(strCate,8).equals("16360707")){
					if (!strReturn.equals("ml") && !strReturn.equals("g")){
						strReturn = "";
						if (strCondiName != null && strCondiName.trim().length() > 0 ){
							for (int i=0;i<strCondiName.length();i++){
								String strCharOne = strCondiName.substring(i,i+1);
								if (!ChkNull.chkNumber(strCharOne)){
									strReturn = strReturn + strCharOne; 
								}
							} 
						}
					}				
				}
				if ((CutStr.cutStr(strCate,6).equals("164213") && !CutStr.cutStr(strCate,8).equals("16421320")) || 
					CutStr.cutStr(strCate,6).equals("032403") || (CutStr.cutStr(strCate,6).equals("164216") && !CutStr.cutStr(strCate,8).equals("16421617"))){
					//System.out.println("strReturn="+strReturn);
					if (!strReturn.equals("g") && !strReturn.equals("ml") && !strReturn.equals("개")){
						strReturn = "";
					}				
				}				
				/*
				if (CutStr.cutStr(strCate,6).equals("162011")  || CutStr.cutStr(strCate,6).equals("162012") || CutStr.cutStr(strCate,6).equals("162014")){
					if (!strReturn.equals("개")){
						strReturn = "";
					}						
				}
				*/
				if (CutStr.cutStr(strCate,4).equals("1620") || CutStr.cutStr(strCate,6).equals("161402")){
					if (strReturn.indexOf("개") >= 0){
						strReturn = "개";
					}						
				}				
				if (CutStr.cutStr(strCate,8).equals("10030104") || CutStr.cutStr(strCate,8).equals("10120308") || CutStr.cutStr(strCate,8).equals("10120309") || CutStr.cutStr(strCate,6).equals("162505") ||
					CutStr.cutStr(strCate,8).equals("16250111") || CutStr.cutStr(strCate,8).equals("16250209") || CutStr.cutStr(strCate,8).equals("16250303") || CutStr.cutStr(strCate,8).equals("16250704") ||
					CutStr.cutStr(strCate,8).equals("16250103") || CutStr.cutStr(strCate,8).equals("16250203") || CutStr.cutStr(strCate,8).equals("16250305") || CutStr.cutStr(strCate,8).equals("16250703") ||
					CutStr.cutStr(strCate,6).equals("162512") || CutStr.cutStr(strCate,6).equals("164002") || CutStr.cutStr(strCate,8).equals("16250404") || CutStr.cutStr(strCate,8).equals("16321005") ||
					CutStr.cutStr(strCate,8).equals("16250717") || CutStr.cutStr(strCate,8).equals("08050413") || CutStr.cutStr(strCate,8).equals("08050414") || CutStr.cutStr(strCate,8).equals("08050415") ||
					CutStr.cutStr(strCate,8).equals("08050416") || CutStr.cutStr(strCate,8).equals("08050417") || CutStr.cutStr(strCate,8).equals("09011910") 
				){
					if (strReturn.indexOf("ml") >= 0 ){
						strReturn = "ml";
					}else if(strReturn.indexOf("g") >= 0 ){
						strReturn = "g";
					}
					if (CutStr.cutStr(strCate,8).equals("16250717")){
						if (strLastSpecUnit != null && strLastSpecUnit.trim().length() > 0 ){
							String strTempN = "";
							for (int i=0;i<strLastSpecUnit.length();i++){
								String strCharOne = strLastSpecUnit.substring(i,i+1);
								if (ChkNull.chkNumber(strCharOne)){
									strTempN = strTempN + strCharOne;
								}
							}
							if (ChkNull.chkNumber(strTempN)){
								int intTempN = Integer.parseInt(strTempN);
								if (intTempN < 100){
									strReturn = "";
								}
							}
						}							
					}
					if (CutStr.cutStr(strCate,8).equals("09011910") && !(strReturn.equals("g") || strReturn.equals("ml"))){
						strReturn = "";
					}
				}
				if(CutStr.cutStr(strCate,8).equals("15040305") || CutStr.cutStr(strCate,8).equals("15040306")){
					if (strReturn.indexOf("개") >= 0){
						strReturn = "";
					}
				}
				if( CutStr.cutStr(strCate,6).equals("210812") || CutStr.cutStr(strCate,8).equals("21080201") || CutStr.cutStr(strCate,8).equals("21080203") || CutStr.cutStr(strCate,8).equals("21080206") || 
					CutStr.cutStr(strCate,8).equals("21080207") || CutStr.cutStr(strCate,8).equals("21080211") || CutStr.cutStr(strCate,8).equals("21080213") || CutStr.cutStr(strCate,8).equals("16421009")){
					if (strReturn.indexOf("ml") >= 0 ){
						strReturn = "ml";
					}else if(strReturn.indexOf("g") >= 0 ){
						strReturn = "g";
					}else{
						strReturn = "";
					}
				}					
				if (CutStr.cutStr(strCate,8).equals("10120316") ){
					if (strCondiName.indexOf("+") >= 0){
						strReturn = "";
					}
				}
				if (CutStr.cutStr(strCate,4).equals("1020") ){
					if (strCondiName.indexOf(",") >= 0){
						strReturn = "";
					}
				}				
				if (CutStr.cutStr(strCate,2).equals("15")){
					int intGcnt = 100;
					if (CutStr.cutStr(strCate,8).equals("15020201") || (CutStr.cutStr(strCate,6).equals("150203") && !CutStr.cutStr(strCate,8).equals("15020308")) ||  
						CutStr.cutStr(strCate,8).equals("15090101") || CutStr.cutStr(strCate,8).equals("15090102") || CutStr.cutStr(strCate,8).equals("15090103") || 
						CutStr.cutStr(strCate,8).equals("15090104") || CutStr.cutStr(strCate,8).equals("15020216") || CutStr.cutStr(strCate,8).equals("15090212") ||
						CutStr.cutStr(strCate,8).equals("15050916") || CutStr.cutStr(strCate,8).equals("15090119") ||
						CutStr.cutStr(strCate,8).equals("15090122") || CutStr.cutStr(strCate,8).equals("15090113") || CutStr.cutStr(strCate,6).equals("150202") || 
						CutStr.cutStr(strCate,6).equals("159801") || CutStr.cutStr(strCate,8).equals("15090102") || CutStr.cutStr(strCate,8).equals("15090101") || CutStr.cutStr(strCate,8).equals("15090103") ||
						CutStr.cutStr(strCate,8).equals("15090104") || CutStr.cutStr(strCate,8).equals("15020226") || CutStr.cutStr(strCate,8).equals("15020227") ||  
						CutStr.cutStr(strCate,6).equals("150208") || CutStr.cutStr(strCate,6).equals("150209") || CutStr.cutStr(strCate,8).equals("15090126") 
					){
						intGcnt = 1000;
					}
					if (CutStr.cutStr(strCate,8).equals("15070510") || CutStr.cutStr(strCate,8).equals("15070605") ||
						CutStr.cutStr(strCate,8).equals("15020217") || CutStr.cutStr(strCate,8).equals("15010609") ||
						CutStr.cutStr(strCate,8).equals("15110307") || CutStr.cutStr(strCate,8).equals("15020509") || CutStr.cutStr(strCate,8).equals("15020511") ||
						CutStr.cutStr(strCate,8).equals("15980504") || CutStr.cutStr(strCate,8).equals("15980506") ||
						CutStr.cutStr(strCate,8).equals("16360707") || CutStr.cutStr(strCate,8).equals("16360708") || CutStr.cutStr(strCate,8).equals("15130303") || CutStr.cutStr(strCate,8).equals("15070416") ||
						CutStr.cutStr(strCate,8).equals("15070405") || CutStr.cutStr(strCate,8).equals("15070505") || CutStr.cutStr(strCate,8).equals("15110306") || CutStr.cutStr(strCate,8).equals("15110305") ||
						CutStr.cutStr(strCate,8).equals("15100803") || CutStr.cutStr(strCate,8).equals("15100804") || CutStr.cutStr(strCate,8).equals("15100805") || CutStr.cutStr(strCate,8).equals("15100806") ||
						CutStr.cutStr(strCate,8).equals("15100323") || CutStr.cutStr(strCate,8).equals("15100328") || CutStr.cutStr(strCate,8).equals("15070508") || CutStr.cutStr(strCate,8).equals("15010508") ||
						CutStr.cutStr(strCate,6).equals("150101") || CutStr.cutStr(strCate,6).equals("150102") || (CutStr.cutStr(strCate,6).equals("150103") && !CutStr.cutStr(strCate,8).equals("15010319") && !CutStr.cutStr(strCate,8).equals("15010320")) ||
						CutStr.cutStr(strCate,6).equals("150104") || CutStr.cutStr(strCate,6).equals("150105") || CutStr.cutStr(strCate,6).equals("150107") || CutStr.cutStr(strCate,6).equals("150108") ||
						(CutStr.cutStr(strCate,6).equals("150111") && !CutStr.cutStr(strCate,6).equals("15011104")) || CutStr.cutStr(strCate,6).equals("150112")  || 
						  CutStr.cutStr(strCate,8).equals("15080508") ||
						(CutStr.cutStr(strCate,6).equals("150501") && !CutStr.cutStr(strCate,8).equals("15050120") && !CutStr.cutStr(strCate,8).equals("15050106") && !CutStr.cutStr(strCate,8).equals("15050127") && 
						!CutStr.cutStr(strCate,8).equals("15050132") && !CutStr.cutStr(strCate,8).equals("15050128") && !CutStr.cutStr(strCate,8).equals("15050129") && !CutStr.cutStr(strCate,8).equals("15050130") && 
						!CutStr.cutStr(strCate,8).equals("15050131")) ||
						(CutStr.cutStr(strCate,6).equals("150504") && !CutStr.cutStr(strCate,8).equals("15050408") && !CutStr.cutStr(strCate,8).equals("15050420")) || (CutStr.cutStr(strCate,6).equals("150502") && !CutStr.cutStr(strCate,8).equals("15050208")) ||
						(CutStr.cutStr(strCate,6).equals("150507") && !CutStr.cutStr(strCate,8).equals("15050704") && !CutStr.cutStr(strCate,8).equals("15050722")) ||
						CutStr.cutStr(strCate,8).equals("15020501") || CutStr.cutStr(strCate,8).equals("15020502") || CutStr.cutStr(strCate,8).equals("15020503") || CutStr.cutStr(strCate,8).equals("15020506") ||
						CutStr.cutStr(strCate,8).equals("15020507") || CutStr.cutStr(strCate,8).equals("15020510") || CutStr.cutStr(strCate,8).equals("15020512") || CutStr.cutStr(strCate,8).equals("15020520") ||
						CutStr.cutStr(strCate,8).equals("15020521") || CutStr.cutStr(strCate,8).equals("15020522") || CutStr.cutStr(strCate,8).equals("15100411") || CutStr.cutStr(strCate,8).equals("15070504") ||
						CutStr.cutStr(strCate,8).equals("16051501") || CutStr.cutStr(strCate,8).equals("16051502") || CutStr.cutStr(strCate,8).equals("16051503") || CutStr.cutStr(strCate,8).equals("15070511") ||
						CutStr.cutStr(strCate,8).equals("15090106") || CutStr.cutStr(strCate,8).equals("15040422") || CutStr.cutStr(strCate,8).equals("15110503") || CutStr.cutStr(strCate,8).equals("15110505") ||
						CutStr.cutStr(strCate,8).equals("15110511") || CutStr.cutStr(strCate,8).equals("15110512")  
					){
						intGcnt = 10;
					}
					if (CutStr.cutStr(strCate,8).equals("15060210")){
						if (!strReturn.equals("g")){
							strReturn = "";
						}
					}					 
					if (strReturn.equals("g")){
						String strTempSpecCnt = "";
						for (int i=0;i<strLastSpecUnit.length();i++){
							String strCharOne = strLastSpecUnit.substring(i,i+1);
							if (ChkNull.chkNumber(strCharOne)){
								strTempSpecCnt = strTempSpecCnt + strCharOne;
							}
						}
						if (ChkNull.chkNumber(strTempSpecCnt)){
							if (Integer.parseInt(strTempSpecCnt) < intGcnt ){
								strReturn = "";
							}
						}				
					}
				}
			}							
		}
		if (CutStr.cutStr(strCate,2).equals("15") && strCondiName.trim().length() == 0){
			strReturn = "";
		}
		if (CutStr.cutStr(strCate,2).equals("08")){
			if (strCondiName.indexOf("구매대행") >= 0 || strCondiName.indexOf("해외쇼핑") >= 0){
				strReturn = "";
			}
		}			
		return strReturn.trim();
	}	
	private String lastSpecReplace(String strLastSpecUnit){
		strLastSpecUnit = ReplaceStr.replace(strLastSpecUnit,",","");
		strLastSpecUnit = ReplaceStr.replace(strLastSpecUnit,".","");
		strLastSpecUnit = ReplaceStr.replace(strLastSpecUnit,"(리필)","");
		strLastSpecUnit = ReplaceStr.replace(strLastSpecUnit,"(캡리필)","");
		return strLastSpecUnit;
	}
	//개당 환산가를 개별요약설명으로 계산해야 하는 분류
	private boolean bGetIndividualChangeUnitBySpec(String strCate){
		boolean bReturn = false;
		if(	CutStr.cutStr(strCate,6).equals("035607") || 
			(CutStr.cutStr(strCate,4).equals("1501") && !CutStr.cutStr(strCate,8).equals("15010110") && !CutStr.cutStr(strCate,8).equals("15010207") && !CutStr.cutStr(strCate,8).equals("15010513") && 
			!CutStr.cutStr(strCate,8).equals("15010718") && !CutStr.cutStr(strCate,8).equals("15010805") && !CutStr.cutStr(strCate,8).equals("15011208")) ||  
			CutStr.cutStr(strCate,8).equals("15010508") || (CutStr.cutStr(strCate,6).equals("151004") && !CutStr.cutStr(strCate,8).equals("15100406") && !CutStr.cutStr(strCate,8).equals("15100411")) ||    
			CutStr.cutStr(strCate,8).equals("15020201") || CutStr.cutStr(strCate,8).equals("15090406") || CutStr.cutStr(strCate,8).equals("16110901") || CutStr.cutStr(strCate,8).equals("16110903") ||
			CutStr.cutStr(strCate,8).equals("15090422") || CutStr.cutStr(strCate,8).equals("15090423") || CutStr.cutStr(strCate,8).equals("16110902") ||
			CutStr.cutStr(strCate,8).equals("15090424") || CutStr.cutStr(strCate,8).equals("15090410") || CutStr.cutStr(strCate,6).equals("159801") ||
			CutStr.cutStr(strCate,8).equals("15090417") || CutStr.cutStr(strCate,8).equals("15090401") || 
			(CutStr.cutStr(strCate,6).equals("164213") && !CutStr.cutStr(strCate,8).equals("16421320")) || 
			CutStr.cutStr(strCate,8).equals("15090219") ||   
			CutStr.cutStr(strCate,8).equals("15050101") || CutStr.cutStr(strCate,8).equals("15050102") || CutStr.cutStr(strCate,6).equals("032403") || CutStr.cutStr(strCate,8).equals("15040309") || 
			CutStr.cutStr(strCate,8).equals("15030103") || CutStr.cutStr(strCate,8).equals("15030108") || (CutStr.cutStr(strCate,6).equals("164216") && !CutStr.cutStr(strCate,8).equals("16421617")) ||
			(CutStr.cutStr(strCate,6).equals("150302") && !CutStr.cutStr(strCate,8).equals("15030214")) || CutStr.cutStr(strCate,6).equals("151301") || CutStr.cutStr(strCate,8).equals("15040310") ||
			CutStr.cutStr(strCate,8).equals("15090415") || CutStr.cutStr(strCate,8).equals("16421402") || CutStr.cutStr(strCate,8).equals("16421403") || CutStr.cutStr(strCate,8).equals("15060405") ||
			CutStr.cutStr(strCate,8).equals("16421702") || CutStr.cutStr(strCate,6).equals("150309") || CutStr.cutStr(strCate,6).equals("150204") ||
			CutStr.cutStr(strCate,8).equals("15090203") || CutStr.cutStr(strCate,8).equals("15090204") ||
			CutStr.cutStr(strCate,8).equals("15050128") || CutStr.cutStr(strCate,8).equals("15050129") || CutStr.cutStr(strCate,8).equals("15050130") || CutStr.cutStr(strCate,8).equals("15050131") ||  
			CutStr.cutStr(strCate,8).equals("15090404") || CutStr.cutStr(strCate,8).equals("15090405") || CutStr.cutStr(strCate,8).equals("15070508") ||
			CutStr.cutStr(strCate,8).equals("15030401") || CutStr.cutStr(strCate,8).equals("15030402") || CutStr.cutStr(strCate,8).equals("15030403") || CutStr.cutStr(strCate,8).equals("15090202") ||
			CutStr.cutStr(strCate,8).equals("15100301") || CutStr.cutStr(strCate,8).equals("15100302") || CutStr.cutStr(strCate,8).equals("15100305") || CutStr.cutStr(strCate,8).equals("15100310") ||
			CutStr.cutStr(strCate,8).equals("15100313") || CutStr.cutStr(strCate,8).equals("15100309") || CutStr.cutStr(strCate,8).equals("15100311") || CutStr.cutStr(strCate,8).equals("15100316") ||
			CutStr.cutStr(strCate,8).equals("15100304") || CutStr.cutStr(strCate,8).equals("15100306") || CutStr.cutStr(strCate,8).equals("15030601") || CutStr.cutStr(strCate,8).equals("15090201") || 
			CutStr.cutStr(strCate,8).equals("15030602") || CutStr.cutStr(strCate,8).equals("15030604") || CutStr.cutStr(strCate,8).equals("15030606") || CutStr.cutStr(strCate,8).equals("15051001") || 
			CutStr.cutStr(strCate,8).equals("15030631") || CutStr.cutStr(strCate,8).equals("15030632") || CutStr.cutStr(strCate,8).equals("15030634") ||   
			CutStr.cutStr(strCate,6).equals("150707") ||  CutStr.cutStr(strCate,6).equals("150708") || CutStr.cutStr(strCate,8).equals("15050104") || CutStr.cutStr(strCate,8).equals("15050105") ||
			CutStr.cutStr(strCate,6).equals("150303") || (CutStr.cutStr(strCate,6).equals("150203") && !CutStr.cutStr(strCate,8).equals("15020308") ) ||  
			CutStr.cutStr(strCate,8).equals("15090101") || CutStr.cutStr(strCate,8).equals("15090103") || CutStr.cutStr(strCate,8).equals("15090104") ||  
			CutStr.cutStr(strCate,6).equals("150602") ||
			CutStr.cutStr(strCate,8).equals("15070115") || CutStr.cutStr(strCate,8).equals("15060407") || CutStr.cutStr(strCate,8).equals("15070409") || CutStr.cutStr(strCate,8).equals("15070609") ||
			CutStr.cutStr(strCate,8).equals("15070610") || CutStr.cutStr(strCate,8).equals("15070611") || CutStr.cutStr(strCate,8).equals("15070612") || CutStr.cutStr(strCate,8).equals("15070613") ||
			CutStr.cutStr(strCate,6).equals("150704") || CutStr.cutStr(strCate,6).equals("150705") || CutStr.cutStr(strCate,8).equals("16111307") ||
			(CutStr.cutStr(strCate,6).equals("150202") && !CutStr.cutStr(strCate,8).equals("15020501") && !CutStr.cutStr(strCate,8).equals("15020208") && !CutStr.cutStr(strCate,8).equals("15020505") &&
			!CutStr.cutStr(strCate,8).equals("15020520") && !CutStr.cutStr(strCate,8).equals("15020521") && !CutStr.cutStr(strCate,8).equals("15020522")) ||
			CutStr.cutStr(strCate,6).equals("150706") || CutStr.cutStr(strCate,6).equals("150707") ||  CutStr.cutStr(strCate,6).equals("151302") || CutStr.cutStr(strCate,6).equals("151303") ||
			CutStr.cutStr(strCate,6).equals("151304") || (CutStr.cutStr(strCate,6).equals("151305") && !CutStr.cutStr(strCate,8).equals("15130505")) || CutStr.cutStr(strCate,6).equals("151306") ||
			(CutStr.cutStr(strCate,6).equals("150802") && !CutStr.cutStr(strCate,8).equals("15080206") && !CutStr.cutStr(strCate,8).equals("15080218") && !CutStr.cutStr(strCate,8).equals("15080218") && 
			!CutStr.cutStr(strCate,8).equals("15080227")) || (CutStr.cutStr(strCate,6).equals("150407") && !CutStr.cutStr(strCate,8).equals("15040705")) ||
			CutStr.cutStr(strCate,8).equals("15080508") || ( CutStr.cutStr(strCate,6).equals("150310") && !CutStr.cutStr(strCate,8).equals("15031006")) || 
			(CutStr.cutStr(strCate,6).equals("151101") && !CutStr.cutStr(strCate,8).equals("15110106") ) || (CutStr.cutStr(strCate,6).equals("150503") && !CutStr.cutStr(strCate,8).equals("15050316") && 
			!CutStr.cutStr(strCate,8).equals("15050320")) || CutStr.cutStr(strCate,6).equals("150601") || CutStr.cutStr(strCate,6).equals("150311") || CutStr.cutStr(strCate,8).equals("16421408") ||
			(CutStr.cutStr(strCate,6).equals("150508") && !CutStr.cutStr(strCate,8).equals("15050807")) || CutStr.cutStr(strCate,8).equals("15090102") ||
			(CutStr.cutStr(strCate,6).equals("150205") && !CutStr.cutStr(strCate,8).equals("15020505") && !CutStr.cutStr(strCate,8).equals("15020513")) || CutStr.cutStr(strCate,8).equals("15090105") ||
			CutStr.cutStr(strCate,6).equals("151103")  || CutStr.cutStr(strCate,6).equals("151007") || CutStr.cutStr(strCate,6).equals("151008") ||
			CutStr.cutStr(strCate,6).equals("150111") || CutStr.cutStr(strCate,6).equals("150112") || CutStr.cutStr(strCate,8).equals("15090126") ||
			( CutStr.cutStr(strCate,6).equals("151003") && !CutStr.cutStr(strCate,8).equals("15100323") && !CutStr.cutStr(strCate,8).equals("15100328") && !CutStr.cutStr(strCate,8).equals("15100326") && 
			!CutStr.cutStr(strCate,8).equals("15100329")) || CutStr.cutStr(strCate,8).equals("15030628") || CutStr.cutStr(strCate,8).equals("15030626") ||  
			CutStr.cutStr(strCate,8).equals("15080509") || CutStr.cutStr(strCate,8).equals("15090409") || CutStr.cutStr(strCate,8).equals("15090219") || 
			CutStr.cutStr(strCate,8).equals("15060401") || CutStr.cutStr(strCate,8).equals("15060403") || CutStr.cutStr(strCate,8).equals("15060408") || CutStr.cutStr(strCate,8).equals("15060406") ||
			CutStr.cutStr(strCate,8).equals("15020216") || CutStr.cutStr(strCate,8).equals("16110905") || CutStr.cutStr(strCate,8).equals("16110907") || CutStr.cutStr(strCate,8).equals("18010607") ||  
			(CutStr.cutStr(strCate,6).equals("150404") && !CutStr.cutStr(strCate,8).equals("15040414") && !CutStr.cutStr(strCate,8).equals("15040406")) || (CutStr.cutStr(strCate,6).equals("150606") && 
			!CutStr.cutStr(strCate,8).equals("15060605")) || CutStr.cutStr(strCate,8).equals("15040603") || CutStr.cutStr(strCate,8).equals("15040606") || 
			CutStr.cutStr(strCate,8).equals("15090412") || CutStr.cutStr(strCate,8).equals("16321303") || 
			CutStr.cutStr(strCate,6).equals("150403")   || CutStr.cutStr(strCate,8).equals("15091301") || CutStr.cutStr(strCate,8).equals("15080808") || 
			CutStr.cutStr(strCate,8).equals("15080207") || CutStr.cutStr(strCate,8).equals("15050110") || CutStr.cutStr(strCate,8).equals("15050111") || 
			CutStr.cutStr(strCate,8).equals("15050113") || CutStr.cutStr(strCate,8).equals("15010601") || CutStr.cutStr(strCate,8).equals("15010602") || CutStr.cutStr(strCate,8).equals("15010608") ||
			CutStr.cutStr(strCate,8).equals("15050316") || CutStr.cutStr(strCate,8).equals("15050320") || CutStr.cutStr(strCate,8).equals("15050807") || CutStr.cutStr(strCate,8).equals("12020504") ||
			CutStr.cutStr(strCate,8).equals("15080207") || CutStr.cutStr(strCate,8).equals("15050106") || CutStr.cutStr(strCate,8).equals("15090206") || CutStr.cutStr(strCate,8).equals("15090207") ||
			CutStr.cutStr(strCate,8).equals("15090209") || CutStr.cutStr(strCate,8).equals("15090210") || CutStr.cutStr(strCate,8).equals("15090211") || CutStr.cutStr(strCate,8).equals("15090212") ||
			CutStr.cutStr(strCate,8).equals("15090301") || CutStr.cutStr(strCate,8).equals("15090303") || CutStr.cutStr(strCate,8).equals("15090306") || CutStr.cutStr(strCate,8).equals("15090403") ||
			CutStr.cutStr(strCate,8).equals("15090416") || CutStr.cutStr(strCate,8).equals("15090418") || CutStr.cutStr(strCate,6).equals("120302")   || CutStr.cutStr(strCate,6).equals("150708") ||
			CutStr.cutStr(strCate,8).equals("15080509") || CutStr.cutStr(strCate,8).equals("15081001") || CutStr.cutStr(strCate,8).equals("15081002") ||
			CutStr.cutStr(strCate,8).equals("15090501") || CutStr.cutStr(strCate,6).equals("150208") || CutStr.cutStr(strCate,6).equals("150209") || 
			CutStr.cutStr(strCate,8).equals("15090502") || CutStr.cutStr(strCate,8).equals("15090503") || CutStr.cutStr(strCate,8).equals("15090504") || CutStr.cutStr(strCate,8).equals("15090505") || 
			CutStr.cutStr(strCate,8).equals("15090112")	|| CutStr.cutStr(strCate,8).equals("15090426") || CutStr.cutStr(strCate,8).equals("15090427")	|| CutStr.cutStr(strCate,8).equals("15100308") ||
			CutStr.cutStr(strCate,6).equals("150207") || CutStr.cutStr(strCate,8).equals("15100307") || CutStr.cutStr(strCate,8).equals("15050121") || CutStr.cutStr(strCate,8).equals("15050132") ||
			CutStr.cutStr(strCate,8).equals("15050122") || CutStr.cutStr(strCate,8).equals("15050123") || CutStr.cutStr(strCate,8).equals("15050124") || CutStr.cutStr(strCate,8).equals("15050125") || 
			CutStr.cutStr(strCate,8).equals("15050126")	|| CutStr.cutStr(strCate,8).equals("15050120") || CutStr.cutStr(strCate,6).equals("164002") || CutStr.cutStr(strCate,8).equals("15050127") ||
			CutStr.cutStr(strCate,8).equals("15030603") || CutStr.cutStr(strCate,8).equals("15030608") || CutStr.cutStr(strCate,8).equals("15030609") || CutStr.cutStr(strCate,8).equals("15030610") ||
			CutStr.cutStr(strCate,8).equals("15030611")	|| CutStr.cutStr(strCate,8).equals("15030612") || CutStr.cutStr(strCate,8).equals("15030613") || CutStr.cutStr(strCate,8).equals("15030614") || 
			CutStr.cutStr(strCate,8).equals("15030615") || CutStr.cutStr(strCate,8).equals("15030616") || CutStr.cutStr(strCate,8).equals("15030618") || CutStr.cutStr(strCate,8).equals("15030619") || 
			CutStr.cutStr(strCate,8).equals("15030621") || CutStr.cutStr(strCate,8).equals("15030623") || CutStr.cutStr(strCate,8).equals("15030627") || CutStr.cutStr(strCate,8).equals("15030622") ||
			CutStr.cutStr(strCate,8).equals("16360102") || (CutStr.cutStr(strCate,6).equals("150307") && !CutStr.cutStr(strCate,8).equals("15030715"))  || CutStr.cutStr(strCate,8).equals("15050916") || 
			CutStr.cutStr(strCate,6).equals("180301")   || CutStr.cutStr(strCate,6).equals("180302")   || CutStr.cutStr(strCate,6).equals("032103")   || CutStr.cutStr(strCate,8).equals("15090511") ||
			CutStr.cutStr(strCate,8).equals("15090122") || CutStr.cutStr(strCate,8).equals("15090113") || CutStr.cutStr(strCate,8).equals("15090123") || CutStr.cutStr(strCate,8).equals("15090112") ||
			CutStr.cutStr(strCate,8).equals("15090119") || CutStr.cutStr(strCate,8).equals("15090121") || CutStr.cutStr(strCate,8).equals("15090701") || CutStr.cutStr(strCate,8).equals("15090702") ||
			CutStr.cutStr(strCate,8).equals("15090703") || CutStr.cutStr(strCate,8).equals("15090704") || CutStr.cutStr(strCate,8).equals("15090705") || CutStr.cutStr(strCate,8).equals("15090706") ||
			CutStr.cutStr(strCate,8).equals("15090707") || CutStr.cutStr(strCate,8).equals("15090708") || CutStr.cutStr(strCate,8).equals("15030111") || CutStr.cutStr(strCate,8).equals("15030112") ||  
			CutStr.cutStr(strCate,8).equals("16421317") || CutStr.cutStr(strCate,8).equals("16421613") || CutStr.cutStr(strCate,6).equals("180303") ||
			CutStr.cutStr(strCate,8).equals("16421614") || CutStr.cutStr(strCate,8).equals("15071002") || CutStr.cutStr(strCate,8).equals("15130305") ||
			CutStr.cutStr(strCate,8).equals("15051004") || CutStr.cutStr(strCate,6).equals("159802") || CutStr.cutStr(strCate,6).equals("159803") || CutStr.cutStr(strCate,6).equals("159804") ||
			CutStr.cutStr(strCate,8).equals("15980501") || CutStr.cutStr(strCate,8).equals("15980502") || CutStr.cutStr(strCate,8).equals("15980503") || CutStr.cutStr(strCate,8).equals("15980505") ||
			CutStr.cutStr(strCate,8).equals("15980507") || CutStr.cutStr(strCate,8).equals("15980508") || CutStr.cutStr(strCate,8).equals("15980510") || CutStr.cutStr(strCate,8).equals("15980504") || 
			CutStr.cutStr(strCate,8).equals("15980506") || CutStr.cutStr(strCate,6).equals("180304") || CutStr.cutStr(strCate,6).equals("180305") || CutStr.cutStr(strCate,6).equals("180306") ||
			CutStr.cutStr(strCate,8).equals("16360111") || CutStr.cutStr(strCate,8).equals("16360112") || CutStr.cutStr(strCate,8).equals("16360113") || CutStr.cutStr(strCate,8).equals("16360708") ||
			CutStr.cutStr(strCate,6).equals("180312") || CutStr.cutStr(strCate,8).equals("15090102") || CutStr.cutStr(strCate,8).equals("15090101") || CutStr.cutStr(strCate,8).equals("15090103") ||
			CutStr.cutStr(strCate,8).equals("15090104") || CutStr.cutStr(strCate,6).equals("150909") || CutStr.cutStr(strCate,8).equals("15090125") ||
			(CutStr.cutStr(strCate,6).equals("150308") &&  !CutStr.cutStr(strCate,8).equals("15030805")) || CutStr.cutStr(strCate,8).equals("15060210") || 
			CutStr.cutStr(strCate,8).equals("10030102") || CutStr.cutStr(strCate,8).equals("10030103") || CutStr.cutStr(strCate,8).equals("10030104") || CutStr.cutStr(strCate,8).equals("15100322") || 
			CutStr.cutStr(strCate,8).equals("10120303") || CutStr.cutStr(strCate,8).equals("10120304") || CutStr.cutStr(strCate,8).equals("10120305") || CutStr.cutStr(strCate,8).equals("15100106") ||
			CutStr.cutStr(strCate,8).equals("10120306") || CutStr.cutStr(strCate,8).equals("10120308") || CutStr.cutStr(strCate,8).equals("10120309") || CutStr.cutStr(strCate,8).equals("10120315") ||
			(CutStr.cutStr(strCate,6).equals("080601")  && !CutStr.cutStr(strCate,8).equals("08060108") && !CutStr.cutStr(strCate,8).equals("08060111") && !CutStr.cutStr(strCate,8).equals("08060110") && 
			!CutStr.cutStr(strCate,8).equals("08060112"))|| CutStr.cutStr(strCate,6).equals("080617") || CutStr.cutStr(strCate,6).equals("080618") || CutStr.cutStr(strCate,6).equals("180313") ||
			CutStr.cutStr(strCate,6).equals("080602") || CutStr.cutStr(strCate,6).equals("080611") || CutStr.cutStr(strCate,6).equals("081407") || CutStr.cutStr(strCate,8).equals("08130901") ||
			CutStr.cutStr(strCate,6).equals("080603") || CutStr.cutStr(strCate,6).equals("080613") || CutStr.cutStr(strCate,6).equals("080605") ||  CutStr.cutStr(strCate,8).equals("08061203") ||
			(CutStr.cutStr(strCate,6).equals("080606") && !CutStr.cutStr(strCate,8).equals("08060615")) || CutStr.cutStr(strCate,6).equals("080608") || CutStr.cutStr(strCate,6).equals("080615") || 
			CutStr.cutStr(strCate,6).equals("151102") ||  CutStr.cutStr(strCate,6).equals("151103") || CutStr.cutStr(strCate,6).equals("162505") || CutStr.cutStr(strCate,8).equals("08130902") ||
			CutStr.cutStr(strCate,8).equals("15100803") || CutStr.cutStr(strCate,8).equals("15100804") || CutStr.cutStr(strCate,8).equals("15100805") || CutStr.cutStr(strCate,8).equals("15100806") || 
			CutStr.cutStr(strCate,8).equals("15100323") || CutStr.cutStr(strCate,8).equals("15100328") || CutStr.cutStr(strCate,8).equals("15100326") || CutStr.cutStr(strCate,8).equals("15100329") || 
			CutStr.cutStr(strCate,8).equals("15100407") || CutStr.cutStr(strCate,8).equals("15100321") || (CutStr.cutStr(strCate,6).equals("150501") && !CutStr.cutStr(strCate,8).equals("15050112")) ||
			(CutStr.cutStr(strCate,6).equals("150504") && !CutStr.cutStr(strCate,8).equals("15050408") && !CutStr.cutStr(strCate,8).equals("15050420")) || (CutStr.cutStr(strCate,6).equals("150502") && !CutStr.cutStr(strCate,8).equals("15050208")) ||
			(CutStr.cutStr(strCate,4).equals("0812") && !CutStr.cutStr(strCate,6).equals("081203") && !CutStr.cutStr(strCate,8).equals("08120603") && !CutStr.cutStr(strCate,8).equals("08120408")) ||
			CutStr.cutStr(strCate,8).equals("16250111") || CutStr.cutStr(strCate,8).equals("16250209") || CutStr.cutStr(strCate,8).equals("16250303") || CutStr.cutStr(strCate,8).equals("16250704") ||
			CutStr.cutStr(strCate,8).equals("16250109") || CutStr.cutStr(strCate,8).equals("16250308") || (CutStr.cutStr(strCate,6).equals("150507") && !CutStr.cutStr(strCate,8).equals("15050704")) ||
			CutStr.cutStr(strCate,6).equals("150401") || CutStr.cutStr(strCate,6).equals("150402") ||  CutStr.cutStr(strCate,8).equals("15040409") ||
			CutStr.cutStr(strCate,8).equals("15130213") || CutStr.cutStr(strCate,8).equals("15130214") || CutStr.cutStr(strCate,8).equals("15130215") || CutStr.cutStr(strCate,8).equals("15130509") ||
			CutStr.cutStr(strCate,8).equals("15040415") || CutStr.cutStr(strCate,8).equals("15040416") || CutStr.cutStr(strCate,8).equals("15040417") || CutStr.cutStr(strCate,8).equals("15040418") ||
			CutStr.cutStr(strCate,8).equals("10120307") || CutStr.cutStr(strCate,6).equals("100501") || CutStr.cutStr(strCate,8).equals("10050201") || CutStr.cutStr(strCate,8).equals("10050204") || 
			CutStr.cutStr(strCate,6).equals("100508") || CutStr.cutStr(strCate,6).equals("100511") || CutStr.cutStr(strCate,6).equals("100512") || CutStr.cutStr(strCate,6).equals("100513") || 
			CutStr.cutStr(strCate,6).equals("100514") || CutStr.cutStr(strCate,6).equals("100515") || CutStr.cutStr(strCate,6).equals("100516") || CutStr.cutStr(strCate,8).equals("16420901") ||
			(CutStr.cutStr(strCate,6).equals("151012") && ! CutStr.cutStr(strCate,8).equals("15101206")) || CutStr.cutStr(strCate,6).equals("151104") || CutStr.cutStr(strCate,6).equals("151011") ||
			CutStr.cutStr(strCate,8).equals("15100703") || CutStr.cutStr(strCate,8).equals("15100704") || CutStr.cutStr(strCate,8).equals("15100705") || CutStr.cutStr(strCate,8).equals("16421002") ||
			CutStr.cutStr(strCate,6).equals("210812") || CutStr.cutStr(strCate,8).equals("21080201") || CutStr.cutStr(strCate,8).equals("21080203") || CutStr.cutStr(strCate,8).equals("21080206") || 
			CutStr.cutStr(strCate,8).equals("21080207") || CutStr.cutStr(strCate,8).equals("21080211") || CutStr.cutStr(strCate,8).equals("21080213") || CutStr.cutStr(strCate,8).equals("16250404") ||
			CutStr.cutStr(strCate,8).equals("16421003") || CutStr.cutStr(strCate,8).equals("16421008") || CutStr.cutStr(strCate,8).equals("16421010") ||
			CutStr.cutStr(strCate,8).equals("16421005") || CutStr.cutStr(strCate,8).equals("16421006") || CutStr.cutStr(strCate,8).equals("16421009") || CutStr.cutStr(strCate,8).equals("16421011") ||
			CutStr.cutStr(strCate,8).equals("16421013") || CutStr.cutStr(strCate,8).equals("16321005") || CutStr.cutStr(strCate,8).equals("15020226") || CutStr.cutStr(strCate,8).equals("15020227") ||
			CutStr.cutStr(strCate,8).equals("10050206") || CutStr.cutStr(strCate,8).equals("10050208") || CutStr.cutStr(strCate,8).equals("16290201") || CutStr.cutStr(strCate,8).equals("10050203") ||
			(CutStr.cutStr(strCate,4).equals("1620") && !CutStr.cutStr(strCate,6).equals("162005") && !CutStr.cutStr(strCate,6).equals("162006") && !CutStr.cutStr(strCate,8).equals("16200902") && !CutStr.cutStr(strCate,8).equals("16200707")) ||
			CutStr.cutStr(strCate,8).equals("15040410") || CutStr.cutStr(strCate,8).equals("15060301") || CutStr.cutStr(strCate,8).equals("16250717") ||
			CutStr.cutStr(strCate,8).equals("15060305") || CutStr.cutStr(strCate,8).equals("15060306") || CutStr.cutStr(strCate,8).equals("15060307") || CutStr.cutStr(strCate,8).equals("15100411") ||
			CutStr.cutStr(strCate,8).equals("08050413") || CutStr.cutStr(strCate,8).equals("08050413") || CutStr.cutStr(strCate,8).equals("08050414") || CutStr.cutStr(strCate,8).equals("08050415") ||
			CutStr.cutStr(strCate,8).equals("08050416") || CutStr.cutStr(strCate,8).equals("08050417") || CutStr.cutStr(strCate,8).equals("10031605") || CutStr.cutStr(strCate,8).equals("10050210") || 
			CutStr.cutStr(strCate,8).equals("10050211") || CutStr.cutStr(strCate,8).equals("10050212") || CutStr.cutStr(strCate,8).equals("10050213") || CutStr.cutStr(strCate,8).equals("10050215") || 
			CutStr.cutStr(strCate,8).equals("10050216") || CutStr.cutStr(strCate,6).equals("080104") || CutStr.cutStr(strCate,6).equals("080112") ||  CutStr.cutStr(strCate,6).equals("080107") || 
			CutStr.cutStr(strCate,6).equals("080102") || CutStr.cutStr(strCate,6).equals("080103") || CutStr.cutStr(strCate,6).equals("080120") ||  CutStr.cutStr(strCate,6).equals("080121") || 
			CutStr.cutStr(strCate,6).equals("080122") || CutStr.cutStr(strCate,6).equals("080123") || CutStr.cutStr(strCate,6).equals("080111") || CutStr.cutStr(strCate,8).equals("08061201") ||
			CutStr.cutStr(strCate,8).equals("08061202") || CutStr.cutStr(strCate,8).equals("08061204") || CutStr.cutStr(strCate,8).equals("08061207") || CutStr.cutStr(strCate,8).equals("15080201") || 
			CutStr.cutStr(strCate,8).equals("15080203") || CutStr.cutStr(strCate,8).equals("15080204") || CutStr.cutStr(strCate,8).equals("15080205") || CutStr.cutStr(strCate,8).equals("15080205") ||
			CutStr.cutStr(strCate,8).equals("15080228") || CutStr.cutStr(strCate,8).equals("15080222") || CutStr.cutStr(strCate,8).equals("15080223") || CutStr.cutStr(strCate,8).equals("15080229") || 
			CutStr.cutStr(strCate,8).equals("15080226")	|| CutStr.cutStr(strCate,8).equals("21150506") || (CutStr.cutStr(strCate,6).equals("150801") && !CutStr.cutStr(strCate,8).equals("15080113")) ||
			CutStr.cutStr(strCate,6).equals("161402")  || CutStr.cutStr(strCate,6).equals("150809") || CutStr.cutStr(strCate,8).equals("15091303") ||
			CutStr.cutStr(strCate,8).equals("15080230") || CutStr.cutStr(strCate,8).equals("15080231") ||
			( CutStr.cutStr(strCate,6).equals("150808") && !CutStr.cutStr(strCate,8).equals("15080806") && !CutStr.cutStr(strCate,8).equals("15080807") && !CutStr.cutStr(strCate,8).equals("15080812")) ||
			CutStr.cutStr(strCate,6).equals("150813") || CutStr.cutStr(strCate,8).equals("15090106")  || CutStr.cutStr(strCate,8).equals("16421313") || CutStr.cutStr(strCate,8).equals("16421314") ||
			CutStr.cutStr(strCate,8).equals("16421316") || CutStr.cutStr(strCate,8).equals("16421315") || CutStr.cutStr(strCate,8).equals("16421318") ||  CutStr.cutStr(strCate,8).equals("16421323") ||
			CutStr.cutStr(strCate,8).equals("16421612") ||  CutStr.cutStr(strCate,8).equals("16421613") || CutStr.cutStr(strCate,8).equals("16421614") ||  CutStr.cutStr(strCate,8).equals("16421615") ||
			CutStr.cutStr(strCate,8).equals("09011910") || CutStr.cutStr(strCate,8).equals("15110504") || CutStr.cutStr(strCate,8).equals("15110506") || CutStr.cutStr(strCate,8).equals("15110508") ||
			CutStr.cutStr(strCate,8).equals("15040422") || CutStr.cutStr(strCate,8).equals("15110503") || CutStr.cutStr(strCate,8).equals("15110505") || CutStr.cutStr(strCate,8).equals("15110511") || 
			CutStr.cutStr(strCate,8).equals("15110512") || CutStr.cutStr(strCate,8).equals("15110107") || CutStr.cutStr(strCate,8).equals("04020208")
		){
			bReturn = true;
		}	
		return bReturn;		
	}
	//개당 환산가를 요약설명으로 계산 해야 하는 분류
	private boolean bSpecCheck(String strCate){
		boolean bReturn = false;
		if(	CutStr.cutStr(strCate,6).equals("100701") || CutStr.cutStr(strCate,6).equals("100702") ||  CutStr.cutStr(strCate,8).equals("16251103") || CutStr.cutStr(strCate,8).equals("16250102") ||
			(CutStr.cutStr(strCate,6).equals("100703") && !CutStr.cutStr(strCate,8).equals("10070307")) || CutStr.cutStr(strCate,8).equals("16250301") ||
			CutStr.cutStr(strCate,6).equals("100707") || CutStr.cutStr(strCate,8).trim().equals("16200902") ||
			CutStr.cutStr(strCate,6).equals("100708") || CutStr.cutStr(strCate,6).equals("161401") || CutStr.cutStr(strCate,8).equals("16250902") || CutStr.cutStr(strCate,8).equals("16250903") ||
			(CutStr.cutStr(strCate,6).equals("162502") && !CutStr.cutStr(strCate,8).equals("16250209")) || CutStr.cutStr(strCate,6).equals("031112") ||
			CutStr.cutStr(strCate,8).equals("16140301") || CutStr.cutStr(strCate,6).equals("100721") || 
			CutStr.cutStr(strCate,8).equals("16140304") || CutStr.cutStr(strCate,8).equals("16140305") || CutStr.cutStr(strCate,8).equals("16200601") ||
			CutStr.cutStr(strCate,8).equals("16250307") || CutStr.cutStr(strCate,6).equals("162006") || CutStr.cutStr(strCate,8).equals("16250101") || 
			CutStr.cutStr(strCate,8).equals("16250103") || CutStr.cutStr(strCate,8).equals("16250104") || CutStr.cutStr(strCate,8).equals("16250105") || CutStr.cutStr(strCate,8).equals("16250106") ||
			CutStr.cutStr(strCate,8).equals("16250108") || CutStr.cutStr(strCate,8).equals("16250304") || CutStr.cutStr(strCate,8).equals("16250305") ||
			CutStr.cutStr(strCate,8).equals("16250302") || CutStr.cutStr(strCate,8).equals("16250306") || CutStr.cutStr(strCate,8).equals("16250107") || CutStr.cutStr(strCate,6).equals("100712") ||
			CutStr.cutStr(strCate,6).equals("100713") || CutStr.cutStr(strCate,6).equals("100714") || CutStr.cutStr(strCate,6).equals("100715") || CutStr.cutStr(strCate,6).equals("100717") ||
			CutStr.cutStr(strCate,8).equals("10070411") || CutStr.cutStr(strCate,8).equals("10070412") || CutStr.cutStr(strCate,8).equals("10070413") || CutStr.cutStr(strCate,8).equals("05100905") ||
			CutStr.cutStr(strCate,6).equals("035607") || CutStr.cutStr(strCate,8).equals("16140306") || CutStr.cutStr(strCate,6).equals("162512") || 
			CutStr.cutStr(strCate,6).equals("100718") || CutStr.cutStr(strCate,8).equals("16250110")  || CutStr.cutStr(strCate,8).equals("16250309") ||
			CutStr.cutStr(strCate,8).equals("10230405") || CutStr.cutStr(strCate,8).equals("16140809") || CutStr.cutStr(strCate,8).equals("16140309") || CutStr.cutStr(strCate,8).equals("10230806") ||
			CutStr.cutStr(strCate,8).equals("16140804") || CutStr.cutStr(strCate,8).equals("16140805") || CutStr.cutStr(strCate,8).equals("16140806") || CutStr.cutStr(strCate,8).equals("16140807") ||
			CutStr.cutStr(strCate,8).equals("16140808") || CutStr.cutStr(strCate,8).equals("16140904") || CutStr.cutStr(strCate,8).equals("16140906") || CutStr.cutStr(strCate,8).equals("16140908") || 
			CutStr.cutStr(strCate,8).equals("16140903") || CutStr.cutStr(strCate,8).equals("16140905") || CutStr.cutStr(strCate,8).equals("16140907") || CutStr.cutStr(strCate,8).equals("16140905") || 
			CutStr.cutStr(strCate,8).equals("16140907") || CutStr.cutStr(strCate,8).equals("21081301") || CutStr.cutStr(strCate,8).equals("21081302") || CutStr.cutStr(strCate,8).equals("21081303") || 
			CutStr.cutStr(strCate,8).equals("21081304") || CutStr.cutStr(strCate,8).equals("21081305") || CutStr.cutStr(strCate,8).equals("21081310") || CutStr.cutStr(strCate,8).equals("21081311") || 
			CutStr.cutStr(strCate,8).equals("21081312") || CutStr.cutStr(strCate,8).equals("16250702") || CutStr.cutStr(strCate,6).equals("100317") ||
			CutStr.cutStr(strCate,8).equals("16250703") || (CutStr.cutStr(strCate,6).equals("100316") && !CutStr.cutStr(strCate,8).equals("10031605") && !CutStr.cutStr(strCate,8).equals("10031606")) ||  
			(CutStr.cutStr(strCate,4).equals("1020") && !CutStr.cutStr(strCate,6).equals("102012") && !CutStr.cutStr(strCate,8).equals("10200705") && !CutStr.cutStr(strCate,8).equals("10201400")
			&& !CutStr.cutStr(strCate,8).equals("10200404")
			) || 
			CutStr.cutStr(strCate,8).equals("10031201")  || CutStr.cutStr(strCate,8).equals("10031108") || CutStr.cutStr(strCate,8).equals("10031102") || CutStr.cutStr(strCate,8).equals("10031202") ||
			CutStr.cutStr(strCate,8).equals("16360707") || CutStr.cutStr(strCate,8).equals("16360708") || CutStr.cutStr(strCate,8).equals("21081315") || CutStr.cutStr(strCate,8).equals("21081316") || 
			CutStr.cutStr(strCate,8).equals("21081317") || CutStr.cutStr(strCate,8).equals("21081318") || CutStr.cutStr(strCate,8).equals("21081319") || CutStr.cutStr(strCate,8).equals("21081320") ||
			CutStr.cutStr(strCate,8).equals("16250401") || CutStr.cutStr(strCate,8).equals("16250402") || CutStr.cutStr(strCate,8).equals("16250403") || CutStr.cutStr(strCate,8).equals("10120316") ||
			CutStr.cutStr(strCate,8).equals("16250711") || CutStr.cutStr(strCate,8).equals("16250712") || CutStr.cutStr(strCate,8).equals("16051501") || CutStr.cutStr(strCate,8).equals("16051502") || 
			CutStr.cutStr(strCate,8).equals("16051503")
		){
			bReturn = true;
		}	
		return bReturn;
	}
	//개당 환산개 계산식
	private long getIndividualChangeUnitPrice(long lngMinprice,String strSpec,String strIndividualChangeUnit,String strCondiName,String strCate){
		long lngReturn = 0;
		String strCondiCount = "";
		for (int i=0;i<strCondiName.length();i++){
			String strCharOne = strCondiName.substring(i,i+1);
			if (ChkNull.chkNumber(strCharOne)){
				strCondiCount = strCondiCount + strCharOne;
			}
		}		
		int intSpecCount = 1; 
		if (bSpecCheck(strCate) || bGetIndividualChangeUnitBySpec(strCate)){
			//1625분류는 요약설명에 2번째
			if (CutStr.cutStr(strCate,4).equals("1625") ||  CutStr.cutStr(strCate,8).equals("16110901") || CutStr.cutStr(strCate,8).equals("16110903") ||
				CutStr.cutStr(strCate,8).equals("21081301") || CutStr.cutStr(strCate,8).equals("21081302") || CutStr.cutStr(strCate,8).equals("21081303") || CutStr.cutStr(strCate,8).equals("21081304") || 
				CutStr.cutStr(strCate,8).equals("21081305") || CutStr.cutStr(strCate,8).equals("21081310") || CutStr.cutStr(strCate,8).equals("21081311") || CutStr.cutStr(strCate,8).equals("21081312") || 
				CutStr.cutStr(strCate,8).equals("16110902") ||  
				CutStr.cutStr(strCate,8).equals("16360708") || CutStr.cutStr(strCate,8).equals("16051501") || CutStr.cutStr(strCate,8).equals("16051502") || CutStr.cutStr(strCate,8).equals("16051503") ||
				CutStr.cutStr(strCate,8).equals("16360707") || CutStr.cutStr(strCate,8).equals("21081315") || CutStr.cutStr(strCate,8).equals("21081316") || CutStr.cutStr(strCate,8).equals("21081317") || 
				CutStr.cutStr(strCate,8).equals("21081318") || CutStr.cutStr(strCate,8).equals("21081319") || CutStr.cutStr(strCate,8).equals("21081320") || CutStr.cutStr(strCate,8).equals("10030102") || 
				CutStr.cutStr(strCate,8).equals("10030103") || CutStr.cutStr(strCate,8).equals("10030104") || CutStr.cutStr(strCate,8).equals("10120303") || CutStr.cutStr(strCate,8).equals("10120304") || 
				CutStr.cutStr(strCate,8).equals("10120305") || CutStr.cutStr(strCate,8).equals("10120306") || CutStr.cutStr(strCate,8).equals("10120308") || CutStr.cutStr(strCate,8).equals("10120309") ||
				CutStr.cutStr(strCate,8).equals("16111307")	|| CutStr.cutStr(strCate,8).equals("10120315") || CutStr.cutStr(strCate,8).equals("10120307") || CutStr.cutStr(strCate,6).equals("210812") || 
				CutStr.cutStr(strCate,8).equals("21080201") || CutStr.cutStr(strCate,8).equals("21080203") || CutStr.cutStr(strCate,8).equals("21080206") || CutStr.cutStr(strCate,8).equals("21080207") || 
				CutStr.cutStr(strCate,8).equals("21080211")	|| CutStr.cutStr(strCate,8).equals("16321005") || CutStr.cutStr(strCate,8).equals("10120316") || CutStr.cutStr(strCate,8).equals("09011910") ||
				CutStr.cutStr(strCate,8).equals("21080213")   
				){
				if (!CutStr.cutStr(strCate,8).equals("10030104") && !CutStr.cutStr(strCate,8).equals("10120308") && !CutStr.cutStr(strCate,8).equals("10120309") && !CutStr.cutStr(strCate,6).equals("162505") &&
					!CutStr.cutStr(strCate,8).equals("16250111") && !CutStr.cutStr(strCate,8).equals("16250209") && !CutStr.cutStr(strCate,8).equals("16250303") && !CutStr.cutStr(strCate,8).equals("16250704") &&
					!CutStr.cutStr(strCate,8).equals("16250404") && !CutStr.cutStr(strCate,8).equals("16321005") && !CutStr.cutStr(strCate,8).equals("16250717") && !CutStr.cutStr(strCate,8).equals("09011910")
				){
					intSpecCount = getSpecCount(strSpec,1,true);
				}else{
					intSpecCount = getSpecCount(strSpec,1,false);//총용량
				}
			}else if(CutStr.cutStr(strCate,6).equals("080601") || CutStr.cutStr(strCate,6).equals("080602") || CutStr.cutStr(strCate,6).equals("080611") || CutStr.cutStr(strCate,6).equals("080608") || 
				 CutStr.cutStr(strCate,6).equals("080603") || CutStr.cutStr(strCate,6).equals("080613") || CutStr.cutStr(strCate,6).equals("080605") || CutStr.cutStr(strCate,8).equals("08061203") ||
				 (CutStr.cutStr(strCate,4).equals("0812") && !CutStr.cutStr(strCate,6).equals("081203") && !CutStr.cutStr(strCate,8).equals("08120603") && !CutStr.cutStr(strCate,8).equals("08120408")) ||
				 (CutStr.cutStr(strCate,6).equals("080606") && !CutStr.cutStr(strCate,8).equals("08060615")) || CutStr.cutStr(strCate,6).equals("080615") ||
				 CutStr.cutStr(strCate,6).equals("100501") || CutStr.cutStr(strCate,8).equals("10050201") || CutStr.cutStr(strCate,8).equals("10050204") || CutStr.cutStr(strCate,6).equals("100508") ||
				 CutStr.cutStr(strCate,6).equals("100511") || CutStr.cutStr(strCate,6).equals("100512") || CutStr.cutStr(strCate,6).equals("100513") || CutStr.cutStr(strCate,6).equals("100514") ||
				 CutStr.cutStr(strCate,6).equals("100515") || CutStr.cutStr(strCate,6).equals("100516") || CutStr.cutStr(strCate,8).equals("16420901") || 
				 CutStr.cutStr(strCate,8).equals("10050206") || CutStr.cutStr(strCate,8).equals("10050208") || CutStr.cutStr(strCate,4).equals("1620") || CutStr.cutStr(strCate,8).equals("10050203") ||
				 CutStr.cutStr(strCate,6).equals("081407") || CutStr.cutStr(strCate,6).equals("080617") || CutStr.cutStr(strCate,6).equals("080618") || 
				 CutStr.cutStr(strCate,8).equals("10050210") || CutStr.cutStr(strCate,8).equals("10050211") || CutStr.cutStr(strCate,8).equals("10050212") || CutStr.cutStr(strCate,8).equals("10050213") ||
				 CutStr.cutStr(strCate,8).equals("10050215") || CutStr.cutStr(strCate,8).equals("10050216") || CutStr.cutStr(strCate,6).equals("080104") || CutStr.cutStr(strCate,6).equals("080112") ||
				 CutStr.cutStr(strCate,6).equals("080107") || CutStr.cutStr(strCate,6).equals("080102") || CutStr.cutStr(strCate,6).equals("080103") || CutStr.cutStr(strCate,6).equals("080120") ||
				 CutStr.cutStr(strCate,6).equals("080121") || CutStr.cutStr(strCate,6).equals("080122") || CutStr.cutStr(strCate,6).equals("080123") || CutStr.cutStr(strCate,6).equals("080111") ||
				 CutStr.cutStr(strCate,8).equals("08061201") || CutStr.cutStr(strCate,8).equals("08061202") || CutStr.cutStr(strCate,8).equals("08061204") || CutStr.cutStr(strCate,8).equals("08061207") ||
				 CutStr.cutStr(strCate,8).equals("15080201") || CutStr.cutStr(strCate,8).equals("15080203") || CutStr.cutStr(strCate,8).equals("15080204") || CutStr.cutStr(strCate,8).equals("15080205") || 
				 CutStr.cutStr(strCate,8).equals("15080205") || CutStr.cutStr(strCate,8).equals("15080228") || CutStr.cutStr(strCate,8).equals("15080222") || CutStr.cutStr(strCate,8).equals("15080223") || 
				 CutStr.cutStr(strCate,8).equals("15080229") || CutStr.cutStr(strCate,8).equals("15080226") || CutStr.cutStr(strCate,8).equals("08130901") || CutStr.cutStr(strCate,8).equals("21150506") ||
				 (CutStr.cutStr(strCate,6).equals("150801") && !CutStr.cutStr(strCate,8).equals("15080113")) || CutStr.cutStr(strCate,6).equals("161402") || CutStr.cutStr(strCate,8).equals("08130902") ||
				  CutStr.cutStr(strCate,6).equals("150809") || CutStr.cutStr(strCate,8).equals("15091303") || CutStr.cutStr(strCate,8).equals("15080230") || CutStr.cutStr(strCate,8).equals("15080231") ||
				 ( CutStr.cutStr(strCate,6).equals("150808") && !CutStr.cutStr(strCate,8).equals("15080806") && !CutStr.cutStr(strCate,8).equals("15080807") && !CutStr.cutStr(strCate,8).equals("15080812")) ||
				  CutStr.cutStr(strCate,6).equals("150813")  || CutStr.cutStr(strCate,8).equals("15091301") || CutStr.cutStr(strCate,8).equals("15080808")
			 )
			{
				intSpecCount = getSpecCount(strSpec,"x");
			}else if(CutStr.cutStr(strCate,8).equals("16360102") || CutStr.cutStr(strCate,8).equals("16360111") || CutStr.cutStr(strCate,8).equals("16360112") || CutStr.cutStr(strCate,8).equals("16360113") || 
					CutStr.cutStr(strCate,8).equals("16290201") || CutStr.cutStr(strCate,8).equals("16421313") || CutStr.cutStr(strCate,8).equals("16421314") ||
					CutStr.cutStr(strCate,8).equals("16421316") || CutStr.cutStr(strCate,8).equals("16421315") || CutStr.cutStr(strCate,8).equals("16421318") ||  CutStr.cutStr(strCate,8).equals("16421323") ||
					CutStr.cutStr(strCate,8).equals("16421612") ||  CutStr.cutStr(strCate,8).equals("16421613") || CutStr.cutStr(strCate,8).equals("16421614") ||  CutStr.cutStr(strCate,8).equals("16421615") 
			){
				String strSpecUnit[] = strSpec.split("/");
				if (strSpecUnit != null && strSpecUnit.length > 2 ){
					if(CutStr.cutStr(strCate,8).equals("16290201") || CutStr.cutStr(strCate,8).equals("16421313") || CutStr.cutStr(strCate,8).equals("16421314") || CutStr.cutStr(strCate,8).equals("16421316") || 
					CutStr.cutStr(strCate,8).equals("16421315") || CutStr.cutStr(strCate,8).equals("16421318") ||  CutStr.cutStr(strCate,8).equals("16421323") || CutStr.cutStr(strCate,8).equals("16421612") ||  
					CutStr.cutStr(strCate,8).equals("16421613") ||CutStr.cutStr(strCate,8).equals("16421614") ||  CutStr.cutStr(strCate,8).equals("16421615")){
						intSpecCount = getSpecCount(strSpec,strSpecUnit.length-2,false);
					}else{
						intSpecCount = getSpecCount(strSpec,strSpecUnit.length-2,true);
					}
				}
			}else{
				intSpecCount = getSpecCount(strSpec);
			}
		}
		
		if ((CutStr.cutStr(strCate,4).equals("1625") || CutStr.cutStr(strCate,8).equals("15100210") || CutStr.cutStr(strCate,8).equals("15051001") || CutStr.cutStr(strCate,6).equals("159801")
			|| CutStr.cutStr(strCate,6).equals("150602") || CutStr.cutStr(strCate,8).equals("15010508")	|| CutStr.cutStr(strCate,8).equals("15070115") || CutStr.cutStr(strCate,8).equals("15060407") 
			|| CutStr.cutStr(strCate,8).equals("15070409") || CutStr.cutStr(strCate,8).equals("15070609") || CutStr.cutStr(strCate,8).equals("15070610") || CutStr.cutStr(strCate,8).equals("15070611") 
			|| CutStr.cutStr(strCate,8).equals("15070612") || CutStr.cutStr(strCate,8).equals("15070613") || 
			(CutStr.cutStr(strCate,6).equals("150205") && !CutStr.cutStr(strCate,8).equals("15020505") && !CutStr.cutStr(strCate,8).equals("15020513")) 
			|| CutStr.cutStr(strCate,6).equals("150704") || CutStr.cutStr(strCate,6).equals("150705") || CutStr.cutStr(strCate,8).equals("15090219")
			|| (CutStr.cutStr(strCate,6).equals("150202") && !CutStr.cutStr(strCate,8).equals("15020208"))|| CutStr.cutStr(strCate,6).equals("150706") || (CutStr.cutStr(strCate,6).equals("164213") && 
			!CutStr.cutStr(strCate,8).equals("16421320"))   || CutStr.cutStr(strCate,8).equals("15090105")
			|| CutStr.cutStr(strCate,6).equals("150707") || (CutStr.cutStr(strCate,6).equals("150203") && !CutStr.cutStr(strCate,8).equals("15020308") ) 
			|| (CutStr.cutStr(strCate,6).equals("164216") && !CutStr.cutStr(strCate,8).equals("16421617")) || CutStr.cutStr(strCate,6).equals("150601")
			|| CutStr.cutStr(strCate,8).equals("15090126") || CutStr.cutStr(strCate,8).equals("15090101") || CutStr.cutStr(strCate,8).equals("15090102") 
			|| CutStr.cutStr(strCate,6).equals("032403") || CutStr.cutStr(strCate,8).equals("15090103") || CutStr.cutStr(strCate,8).equals("15090104") || CutStr.cutStr(strCate,8).equals("16421702") 
			|| CutStr.cutStr(strCate,8).equals("15130305") || CutStr.cutStr(strCate,8).equals("15030103") 
			|| CutStr.cutStr(strCate,8).equals("15030108") || CutStr.cutStr(strCate,6).equals("151302") || CutStr.cutStr(strCate,6).equals("151303") || CutStr.cutStr(strCate,6).equals("151304")  
			|| (CutStr.cutStr(strCate,6).equals("151305") && !CutStr.cutStr(strCate,8).equals("15130505")) || CutStr.cutStr(strCate,6).equals("151306") 
			|| (CutStr.cutStr(strCate,6).equals("150302") && !CutStr.cutStr(strCate,8).equals("15030214")) || CutStr.cutStr(strCate,8).equals("15090415") || CutStr.cutStr(strCate,6).equals("151301")
			|| CutStr.cutStr(strCate,8).equals("15050128") || CutStr.cutStr(strCate,8).equals("15050129") || CutStr.cutStr(strCate,8).equals("15050130") || CutStr.cutStr(strCate,8).equals("15050131") 
			|| CutStr.cutStr(strCate,8).equals("15030401") || CutStr.cutStr(strCate,8).equals("15030402") || CutStr.cutStr(strCate,8).equals("15030403") || CutStr.cutStr(strCate,8).equals("15090202")
			|| CutStr.cutStr(strCate,8).equals("15030601") || CutStr.cutStr(strCate,8).equals("15090201") || CutStr.cutStr(strCate,8).equals("15030602") || CutStr.cutStr(strCate,8).equals("15030604") 
			|| CutStr.cutStr(strCate,8).equals("15030631") || CutStr.cutStr(strCate,8).equals("15030632") || CutStr.cutStr(strCate,8).equals("15030634")
			|| CutStr.cutStr(strCate,8).equals("15030606") || CutStr.cutStr(strCate,8).equals("15070508") || CutStr.cutStr(strCate,8).equals("15090203") || CutStr.cutStr(strCate,8).equals("15090204") 
			|| CutStr.cutStr(strCate,8).equals("15090404") || CutStr.cutStr(strCate,8).equals("15090405") || CutStr.cutStr(strCate,8).equals("15060401") 
			|| CutStr.cutStr(strCate,8).equals("15060403") || CutStr.cutStr(strCate,8).equals("15060408") || CutStr.cutStr(strCate,8).equals("15030304") || CutStr.cutStr(strCate,8).equals("15050104") 
			|| CutStr.cutStr(strCate,8).equals("15060406") 
			|| CutStr.cutStr(strCate,8).equals("15100301") || CutStr.cutStr(strCate,8).equals("15100302") || CutStr.cutStr(strCate,8).equals("15100305") || CutStr.cutStr(strCate,8).equals("15100310")
			|| CutStr.cutStr(strCate,8).equals("15100313") || CutStr.cutStr(strCate,8).equals("15100309") || CutStr.cutStr(strCate,8).equals("15100311") || CutStr.cutStr(strCate,8).equals("15100316")			  
			|| CutStr.cutStr(strCate,8).equals("15100305") || CutStr.cutStr(strCate,8).equals("15100310") || CutStr.cutStr(strCate,8).equals("15100313") || CutStr.cutStr(strCate,8).equals("15100309")
			|| CutStr.cutStr(strCate,8).equals("15100311") || CutStr.cutStr(strCate,8).equals("15100316") || CutStr.cutStr(strCate,8).equals("15100304") || CutStr.cutStr(strCate,8).equals("15100306")
			|| CutStr.cutStr(strCate,8).equals("15090409") || CutStr.cutStr(strCate,8).equals("15010601") || CutStr.cutStr(strCate,8).equals("15010602") || CutStr.cutStr(strCate,8).equals("15010608") 
			|| (CutStr.cutStr(strCate,4).equals("1501") && !CutStr.cutStr(strCate,8).equals("15010110") && !CutStr.cutStr(strCate,8).equals("15010207") && !CutStr.cutStr(strCate,8).equals("15010513") 
			&& !CutStr.cutStr(strCate,8).equals("15010805")) || CutStr.cutStr(strCate,8).equals("15040309") || CutStr.cutStr(strCate,8).equals("15040310") || CutStr.cutStr(strCate,8).equals("15060405") 
			|| (CutStr.cutStr(strCate,6).equals("151004") && !CutStr.cutStr(strCate,8).equals("15100406") && !CutStr.cutStr(strCate,8).equals("15100411"))
			|| CutStr.cutStr(strCate,8).equals("15040401") || CutStr.cutStr(strCate,8).equals("15040402") || CutStr.cutStr(strCate,6).equals("150208") || CutStr.cutStr(strCate,6).equals("150209") 
			|| CutStr.cutStr(strCate,8).equals("15040403") || CutStr.cutStr(strCate,8).equals("15040404") || CutStr.cutStr(strCate,6).equals("150606") || CutStr.cutStr(strCate,8).equals("15040421")
			|| CutStr.cutStr(strCate,8).equals("15050105") || CutStr.cutStr(strCate,8).equals("15020216") || (CutStr.cutStr(strCate,6).equals("150407") && !CutStr.cutStr(strCate,8).equals("15040705"))
			|| CutStr.cutStr(strCate,8).equals("15040603") || CutStr.cutStr(strCate,8).equals("15080508") || CutStr.cutStr(strCate,8).equals("15080509")
			|| CutStr.cutStr(strCate,8).equals("15080207") || CutStr.cutStr(strCate,8).equals("15020217") || CutStr.cutStr(strCate,8).equals("15070510") || CutStr.cutStr(strCate,8).equals("15070504")
			|| CutStr.cutStr(strCate,8).equals("15070507") || CutStr.cutStr(strCate,8).equals("15050106") || CutStr.cutStr(strCate,8).equals("15090212") || CutStr.cutStr(strCate,8).equals("15050101")
			|| CutStr.cutStr(strCate,6).equals("150708")   || CutStr.cutStr(strCate,8).equals("15040302") || CutStr.cutStr(strCate,8).equals("15010609") || CutStr.cutStr(strCate,8).equals("15040419") 
			|| CutStr.cutStr(strCate,8).equals("15040405") || CutStr.cutStr(strCate,8).equals("15040408") || CutStr.cutStr(strCate,8).equals("15070511") 
			|| CutStr.cutStr(strCate,8).equals("15080509") || CutStr.cutStr(strCate,8).equals("15081001") || CutStr.cutStr(strCate,8).equals("15081002")  
			|| CutStr.cutStr(strCate,8).equals("15090501") || CutStr.cutStr(strCate,8).equals("15090502") || CutStr.cutStr(strCate,6).equals("150204")
			|| CutStr.cutStr(strCate,8).equals("15090503") || CutStr.cutStr(strCate,8).equals("15090504") || CutStr.cutStr(strCate,8).equals("15090505") || CutStr.cutStr(strCate,8).equals("15090112")				
			|| CutStr.cutStr(strCate,8).equals("15090412") || CutStr.cutStr(strCate,8).equals("15100308") || CutStr.cutStr(strCate,6).equals("150207") || CutStr.cutStr(strCate,8).equals("15100307")
			|| CutStr.cutStr(strCate,8).equals("15050121") || CutStr.cutStr(strCate,8).equals("15050122") || CutStr.cutStr(strCate,8).equals("15050123") || CutStr.cutStr(strCate,8).equals("15050124")
			|| CutStr.cutStr(strCate,8).equals("15050125") || CutStr.cutStr(strCate,8).equals("15050126") 
			|| CutStr.cutStr(strCate,8).equals("15030303") || CutStr.cutStr(strCate,8).equals("15030306") || CutStr.cutStr(strCate,8).equals("15030605") || CutStr.cutStr(strCate,8).equals("15030603")
			|| CutStr.cutStr(strCate,8).equals("15030608") || CutStr.cutStr(strCate,8).equals("15030609") || CutStr.cutStr(strCate,8).equals("15030610") || CutStr.cutStr(strCate,8).equals("15030611")
			|| CutStr.cutStr(strCate,8).equals("15030612") || CutStr.cutStr(strCate,8).equals("15030613") || CutStr.cutStr(strCate,8).equals("15030614") || CutStr.cutStr(strCate,8).equals("15030615")
			|| CutStr.cutStr(strCate,8).equals("15030616") || CutStr.cutStr(strCate,8).equals("15030618") || CutStr.cutStr(strCate,8).equals("15030619") || CutStr.cutStr(strCate,8).equals("15030621")
			|| CutStr.cutStr(strCate,8).equals("15030623") || CutStr.cutStr(strCate,8).equals("15030627") || CutStr.cutStr(strCate,8).equals("15030622") || CutStr.cutStr(strCate,8).equals("15030301") 
			|| CutStr.cutStr(strCate,8).equals("15100203") || (CutStr.cutStr(strCate,6).equals("150307") && !CutStr.cutStr(strCate,8).equals("15030715")) || CutStr.cutStr(strCate,8).equals("15030310") 
			|| CutStr.cutStr(strCate,8).equals("15050916") || CutStr.cutStr(strCate,8).equals("15080508") 
			|| CutStr.cutStr(strCate,8).equals("21081301") || CutStr.cutStr(strCate,8).equals("21081302") || CutStr.cutStr(strCate,8).equals("21081303") 
			|| CutStr.cutStr(strCate,8).equals("21081304") || CutStr.cutStr(strCate,8).equals("21081305") || CutStr.cutStr(strCate,8).equals("21081310") || CutStr.cutStr(strCate,8).equals("21081311") 
			|| CutStr.cutStr(strCate,8).equals("21081312") || CutStr.cutStr(strCate,8).equals("15030302") || CutStr.cutStr(strCate,8).equals("15100107") || CutStr.cutStr(strCate,8).equals("15090511") 
			|| CutStr.cutStr(strCate,8).equals("15090122") || CutStr.cutStr(strCate,8).equals("15090113") || CutStr.cutStr(strCate,8).equals("15090123") || CutStr.cutStr(strCate,8).equals("15090112")
			|| CutStr.cutStr(strCate,8).equals("15090119") || CutStr.cutStr(strCate,8).equals("15090121") || CutStr.cutStr(strCate,8).equals("15090701") || CutStr.cutStr(strCate,8).equals("15090702")
			|| CutStr.cutStr(strCate,8).equals("15090703") || CutStr.cutStr(strCate,8).equals("15090704") || CutStr.cutStr(strCate,8).equals("15090705") || CutStr.cutStr(strCate,8).equals("15090706")
			|| CutStr.cutStr(strCate,8).equals("15090707") || CutStr.cutStr(strCate,8).equals("15090708") 
			|| CutStr.cutStr(strCate,8).equals("15030111") || CutStr.cutStr(strCate,8).equals("15030112") || CutStr.cutStr(strCate,8).equals("15071002") || CutStr.cutStr(strCate,6).equals("151103") 
			|| CutStr.cutStr(strCate,6).equals("151003") || CutStr.cutStr(strCate,6).equals("151007") || CutStr.cutStr(strCate,6).equals("151008")  
			|| CutStr.cutStr(strCate,6).equals("150111") || CutStr.cutStr(strCate,6).equals("150112") 
			|| CutStr.cutStr(strCate,6).equals("159802") || CutStr.cutStr(strCate,6).equals("159803") || CutStr.cutStr(strCate,6).equals("159804") || CutStr.cutStr(strCate,8).equals("15980501") 
			|| CutStr.cutStr(strCate,8).equals("15980502") || CutStr.cutStr(strCate,8).equals("15980503") || CutStr.cutStr(strCate,8).equals("15980505") || CutStr.cutStr(strCate,8).equals("15980507") 
			|| CutStr.cutStr(strCate,8).equals("15980508") || CutStr.cutStr(strCate,8).equals("15980510") || CutStr.cutStr(strCate,6).equals("159802") || CutStr.cutStr(strCate,6).equals("159803") 
			|| CutStr.cutStr(strCate,6).equals("159804") || CutStr.cutStr(strCate,8).equals("15980501") || CutStr.cutStr(strCate,8).equals("15980502") || CutStr.cutStr(strCate,8).equals("15980503") 
			|| CutStr.cutStr(strCate,8).equals("15980505") || CutStr.cutStr(strCate,8).equals("15980507") || CutStr.cutStr(strCate,8).equals("15980508") || CutStr.cutStr(strCate,8).equals("15980510")	
			|| CutStr.cutStr(strCate,8).equals("15980504") || CutStr.cutStr(strCate,8).equals("15980506") || CutStr.cutStr(strCate,8).equals("16360707") || CutStr.cutStr(strCate,8).equals("16360708")
			|| CutStr.cutStr(strCate,6).equals("150905") || CutStr.cutStr(strCate,6).equals("150907") || CutStr.cutStr(strCate,6).equals("150902")  
			|| (CutStr.cutStr(strCate,6).equals("150308") &&  !CutStr.cutStr(strCate,8).equals("15030805")) 
			|| CutStr.cutStr(strCate,8).equals("15090123") || CutStr.cutStr(strCate,8).equals("15090112") || CutStr.cutStr(strCate,8).equals("15090125") 
			|| CutStr.cutStr(strCate,8).equals("21081315") || CutStr.cutStr(strCate,8).equals("21081316") || CutStr.cutStr(strCate,8).equals("21081317") || CutStr.cutStr(strCate,8).equals("21081318") 
			|| CutStr.cutStr(strCate,8).equals("21081319") || CutStr.cutStr(strCate,8).equals("21081320") || CutStr.cutStr(strCate,8).equals("15100106") || CutStr.cutStr(strCate,6).equals("080615") 
			|| CutStr.cutStr(strCate,8).equals("10030102") || CutStr.cutStr(strCate,8).equals("10030103") || CutStr.cutStr(strCate,8).equals("10030104") || CutStr.cutStr(strCate,8).equals("10120307")  
			|| CutStr.cutStr(strCate,8).equals("10120303") || CutStr.cutStr(strCate,8).equals("10120304") || CutStr.cutStr(strCate,8).equals("10120305") || CutStr.cutStr(strCate,8).equals("10120315") 
			|| CutStr.cutStr(strCate,8).equals("10120306") || CutStr.cutStr(strCate,8).equals("10120308") || CutStr.cutStr(strCate,8).equals("10120309") || CutStr.cutStr(strCate,8).equals("08061203") 
			|| CutStr.cutStr(strCate,6).equals("080601") || CutStr.cutStr(strCate,6).equals("080602") || CutStr.cutStr(strCate,6).equals("080611") || CutStr.cutStr(strCate,6).equals("080603") 
			|| CutStr.cutStr(strCate,6).equals("080613") || CutStr.cutStr(strCate,6).equals("080605") || (CutStr.cutStr(strCate,6).equals("080606") && !CutStr.cutStr(strCate,8).equals("08060615"))
			|| CutStr.cutStr(strCate,6).equals("151102") ||  CutStr.cutStr(strCate,6).equals("151103") || CutStr.cutStr(strCate,6).equals("080608") || CutStr.cutStr(strCate,6).equals("080617") 
			|| CutStr.cutStr(strCate,6).equals("080618") || CutStr.cutStr(strCate,8).equals("15100803") || CutStr.cutStr(strCate,8).equals("15100804") || CutStr.cutStr(strCate,8).equals("15100805") 
			|| CutStr.cutStr(strCate,8).equals("15100806") || CutStr.cutStr(strCate,8).equals("15100323") || CutStr.cutStr(strCate,8).equals("15100328") || CutStr.cutStr(strCate,8).equals("21150506")
			|| CutStr.cutStr(strCate,8).equals("15100326") || CutStr.cutStr(strCate,8).equals("15100329") || CutStr.cutStr(strCate,8).equals("15100407") 
			|| CutStr.cutStr(strCate,8).equals("15100321") || CutStr.cutStr(strCate,8).equals("15100322") || CutStr.cutStr(strCate,8).equals("15060210")
			|| CutStr.cutStr(strCate,6).equals("150101") || CutStr.cutStr(strCate,6).equals("150102") || CutStr.cutStr(strCate,6).equals("150104") ||  CutStr.cutStr(strCate,6).equals("150103") 
			|| CutStr.cutStr(strCate,6).equals("150105") || CutStr.cutStr(strCate,6).equals("150107") || CutStr.cutStr(strCate,6).equals("150108") ||  CutStr.cutStr(strCate,6).equals("150111") 
			|| CutStr.cutStr(strCate,6).equals("150112") || (CutStr.cutStr(strCate,6).equals("150501") && !CutStr.cutStr(strCate,8).equals("15050112")) 
			|| (CutStr.cutStr(strCate,6).equals("150504") && !CutStr.cutStr(strCate,8).equals("15050408") && !CutStr.cutStr(strCate,8).equals("15050420")) || (CutStr.cutStr(strCate,6).equals("150502") && !CutStr.cutStr(strCate,8).equals("15050208"))
			|| (CutStr.cutStr(strCate,4).equals("0812") && !CutStr.cutStr(strCate,6).equals("081203") && !CutStr.cutStr(strCate,8).equals("08120603") && !CutStr.cutStr(strCate,8).equals("08120408"))  
			|| (CutStr.cutStr(strCate,6).equals("150507") && !CutStr.cutStr(strCate,8).equals("15050704")) || CutStr.cutStr(strCate,8).equals("15030628") || CutStr.cutStr(strCate,8).equals("15030626")				
			|| CutStr.cutStr(strCate,6).equals("150309") || ( CutStr.cutStr(strCate,6).equals("150310") && !CutStr.cutStr(strCate,8).equals("15031006")) || CutStr.cutStr(strCate,6).equals("150311")  
			|| CutStr.cutStr(strCate,8).equals("16250111") || CutStr.cutStr(strCate,8).equals("16250209") || CutStr.cutStr(strCate,8).equals("16250303") || CutStr.cutStr(strCate,8).equals("16250704")
			|| CutStr.cutStr(strCate,6).equals("150401") || CutStr.cutStr(strCate,6).equals("150402") ||  CutStr.cutStr(strCate,8).equals("15040409") || CutStr.cutStr(strCate,8).equals("16250717")
			|| CutStr.cutStr(strCate,8).equals("15130213") || CutStr.cutStr(strCate,8).equals("15130214") || CutStr.cutStr(strCate,8).equals("15130215") || CutStr.cutStr(strCate,8).equals("15130509") 
			|| CutStr.cutStr(strCate,8).equals("15040415") || CutStr.cutStr(strCate,8).equals("15040416") || CutStr.cutStr(strCate,8).equals("15040417") || CutStr.cutStr(strCate,8).equals("15040418")
			|| CutStr.cutStr(strCate,6).equals("100501") || CutStr.cutStr(strCate,8).equals("10050201") || CutStr.cutStr(strCate,8).equals("10050204") || CutStr.cutStr(strCate,6).equals("100508") 
			|| CutStr.cutStr(strCate,6).equals("100511") || CutStr.cutStr(strCate,6).equals("100512") || CutStr.cutStr(strCate,6).equals("100513") || CutStr.cutStr(strCate,6).equals("100514")
			|| CutStr.cutStr(strCate,6).equals("100515") || CutStr.cutStr(strCate,6).equals("100516") || (CutStr.cutStr(strCate,6).equals("151012") && ! CutStr.cutStr(strCate,8).equals("15101206")) 
			|| CutStr.cutStr(strCate,6).equals("151104") || CutStr.cutStr(strCate,6).equals("151011") || CutStr.cutStr(strCate,8).equals("15100703") || CutStr.cutStr(strCate,8).equals("15100704") 
			|| CutStr.cutStr(strCate,8).equals("15100705") || CutStr.cutStr(strCate,8).equals("16420901") || CutStr.cutStr(strCate,8).equals("16421002") || CutStr.cutStr(strCate,6).equals("210812") 
			|| CutStr.cutStr(strCate,8).equals("21080201") || CutStr.cutStr(strCate,8).equals("21080203") || CutStr.cutStr(strCate,8).equals("21080206") || CutStr.cutStr(strCate,8).equals("21080207") 
			|| CutStr.cutStr(strCate,8).equals("21080211") || CutStr.cutStr(strCate,8).equals("16250404") || CutStr.cutStr(strCate,8).equals("16421003") || CutStr.cutStr(strCate,8).equals("16421008") 
			|| CutStr.cutStr(strCate,8).equals("16421010") || CutStr.cutStr(strCate,8).equals("16421005") || CutStr.cutStr(strCate,8).equals("16421006") || CutStr.cutStr(strCate,8).equals("16421009") 
			|| CutStr.cutStr(strCate,8).equals("16421011") || CutStr.cutStr(strCate,8).equals("16421013") || CutStr.cutStr(strCate,8).equals("16321005") || CutStr.cutStr(strCate,8).equals("10120316")
			|| CutStr.cutStr(strCate,8).equals("15020226") || CutStr.cutStr(strCate,8).equals("15020227") || CutStr.cutStr(strCate,8).equals("10050206") || CutStr.cutStr(strCate,8).equals("10050203") 
			|| CutStr.cutStr(strCate,8).equals("10050208") || CutStr.cutStr(strCate,8).equals("16290201") || CutStr.cutStr(strCate,8).equals("15040410") || CutStr.cutStr(strCate,8).equals("15060301")
			|| CutStr.cutStr(strCate,8).equals("15060305") || CutStr.cutStr(strCate,8).equals("15060306") || CutStr.cutStr(strCate,8).equals("15060307") || CutStr.cutStr(strCate,8).equals("15100411")
			|| CutStr.cutStr(strCate,8).equals("16051501") || CutStr.cutStr(strCate,8).equals("16051502") || CutStr.cutStr(strCate,8).equals("16051503") || CutStr.cutStr(strCate,6).equals("081407") 
			|| CutStr.cutStr(strCate,8).equals("10050210") || CutStr.cutStr(strCate,8).equals("10050211") || CutStr.cutStr(strCate,8).equals("10050212") || CutStr.cutStr(strCate,8).equals("10050213") 
			|| CutStr.cutStr(strCate,8).equals("10050215") || CutStr.cutStr(strCate,8).equals("10050216") || CutStr.cutStr(strCate,6).equals("080104") || CutStr.cutStr(strCate,6).equals("080112") 
			|| CutStr.cutStr(strCate,6).equals("080107") || CutStr.cutStr(strCate,6).equals("080102") || CutStr.cutStr(strCate,6).equals("080103") || CutStr.cutStr(strCate,6).equals("080120") 
			|| CutStr.cutStr(strCate,6).equals("080121") || CutStr.cutStr(strCate,6).equals("080122") || CutStr.cutStr(strCate,6).equals("080123") || CutStr.cutStr(strCate,6).equals("080111") 
			|| CutStr.cutStr(strCate,8).equals("08061201") || CutStr.cutStr(strCate,8).equals("08061202") || CutStr.cutStr(strCate,8).equals("08061204") || CutStr.cutStr(strCate,8).equals("08061207") 
			|| CutStr.cutStr(strCate,8).equals("15080201") || CutStr.cutStr(strCate,8).equals("15080203") || CutStr.cutStr(strCate,8).equals("15080204") || CutStr.cutStr(strCate,8).equals("15080205") 
			|| CutStr.cutStr(strCate,8).equals("15080205") || CutStr.cutStr(strCate,8).equals("15080228") || CutStr.cutStr(strCate,8).equals("15080222") || CutStr.cutStr(strCate,8).equals("15080223") 
			|| CutStr.cutStr(strCate,8).equals("15080229") || CutStr.cutStr(strCate,8).equals("15080226") || CutStr.cutStr(strCate,8).equals("08130901") || CutStr.cutStr(strCate,8).equals("08130902")
			|| (CutStr.cutStr(strCate,6).equals("150801") && !CutStr.cutStr(strCate,8).equals("15080113")) || CutStr.cutStr(strCate,8).equals("15080230") || CutStr.cutStr(strCate,8).equals("15080231")   
			|| CutStr.cutStr(strCate,6).equals("150809") || ( CutStr.cutStr(strCate,6).equals("150808") && !CutStr.cutStr(strCate,8).equals("15080806") && !CutStr.cutStr(strCate,8).equals("15080807") && !CutStr.cutStr(strCate,8).equals("15080812")) 
			|| CutStr.cutStr(strCate,6).equals("150813") || CutStr.cutStr(strCate,8).equals("15090106") || CutStr.cutStr(strCate,8).equals("16421313") || CutStr.cutStr(strCate,8).equals("16421314") 
			|| CutStr.cutStr(strCate,8).equals("16421316") || CutStr.cutStr(strCate,8).equals("16421315") || CutStr.cutStr(strCate,8).equals("16421318") ||  CutStr.cutStr(strCate,8).equals("16421323")
			|| CutStr.cutStr(strCate,8).equals("16421612") || CutStr.cutStr(strCate,8).equals("16421613") || CutStr.cutStr(strCate,8).equals("16421614") ||  CutStr.cutStr(strCate,8).equals("16421615")
			|| CutStr.cutStr(strCate,8).equals("15091301") || CutStr.cutStr(strCate,8).equals("15091303") || CutStr.cutStr(strCate,8).equals("09011910") || CutStr.cutStr(strCate,8).equals("15080808")
			|| CutStr.cutStr(strCate,8).equals("15110504") || CutStr.cutStr(strCate,8).equals("15110506") || CutStr.cutStr(strCate,8).equals("15110508") || CutStr.cutStr(strCate,8).equals("15040422") 
			|| CutStr.cutStr(strCate,8).equals("15110503") || CutStr.cutStr(strCate,8).equals("15110505") || CutStr.cutStr(strCate,8).equals("15110511") || CutStr.cutStr(strCate,8).equals("15110512")
			|| CutStr.cutStr(strCate,8).equals("15110107") || CutStr.cutStr(strCate,8).equals("21080213")
			)&& (strIndividualChangeUnit.toLowerCase().equals("ml") || strIndividualChangeUnit.toLowerCase().equals("g") || strIndividualChangeUnit.toLowerCase().equals("l") || 
				strIndividualChangeUnit.toLowerCase().equals("kg") || strIndividualChangeUnit.toLowerCase().equals("cm"))){
			if (strIndividualChangeUnit.toLowerCase().equals("l") || strIndividualChangeUnit.toLowerCase().equals("kg")){
				intSpecCount = intSpecCount * 1000;
			}
			if (intSpecCount > 0 ){
				if (CutStr.cutStr(strCate,8).equals("15100210") || 
					(CutStr.cutStr(strCate,6).equals("164213") && !CutStr.cutStr(strCate,8).equals("16421320") && !CutStr.cutStr(strCate,8).equals("16421313") && !CutStr.cutStr(strCate,8).equals("16421314") &&
					!CutStr.cutStr(strCate,8).equals("16421316") && !CutStr.cutStr(strCate,8).equals("16421315") && !CutStr.cutStr(strCate,8).equals("16421318") && !CutStr.cutStr(strCate,8).equals("16421323") ) || 
					CutStr.cutStr(strCate,6).equals("159801") || CutStr.cutStr(strCate,8).equals("15010508") || CutStr.cutStr(strCate,6).equals("150601") ||
					CutStr.cutStr(strCate,8).equals("15070508") || CutStr.cutStr(strCate,6).equals("032403") || 
					CutStr.cutStr(strCate,6).equals("150602") || CutStr.cutStr(strCate,6).equals("151102") ||
					(CutStr.cutStr(strCate,6).equals("150205") && !CutStr.cutStr(strCate,8).equals("15020505") && !CutStr.cutStr(strCate,8).equals("15020513")) ||
					CutStr.cutStr(strCate,6).equals("150704") || (CutStr.cutStr(strCate,6).equals("164216") && !CutStr.cutStr(strCate,8).equals("16421617") && !CutStr.cutStr(strCate,8).equals("16421612") &&  
					!CutStr.cutStr(strCate,8).equals("16421613") && !CutStr.cutStr(strCate,8).equals("16421614") &&  !CutStr.cutStr(strCate,8).equals("16421615")) ||
					(CutStr.cutStr(strCate,6).equals("150202") && !CutStr.cutStr(strCate,8).equals("15020208")) || CutStr.cutStr(strCate,6).equals("150706") || CutStr.cutStr(strCate,8).equals("16421702") || 
					CutStr.cutStr(strCate,8).equals("15090219") || CutStr.cutStr(strCate,8).equals("15090105") || 
					CutStr.cutStr(strCate,6).equals("150707") || (CutStr.cutStr(strCate,6).equals("150203") && !CutStr.cutStr(strCate,8).equals("15020308") ) || 
					CutStr.cutStr(strCate,8).equals("15130305") || CutStr.cutStr(strCate,8).equals("15090126") ||
					CutStr.cutStr(strCate,8).equals("15090101") || CutStr.cutStr(strCate,8).equals("15090102") || CutStr.cutStr(strCate,8).equals("15090103") || CutStr.cutStr(strCate,8).equals("15090104") ||
					CutStr.cutStr(strCate,8).equals("15090415") ||
					CutStr.cutStr(strCate,8).equals("15030103") || CutStr.cutStr(strCate,8).equals("15030108") || CutStr.cutStr(strCate,6).equals("151302") || CutStr.cutStr(strCate,6).equals("151303") ||
					CutStr.cutStr(strCate,6).equals("151304") || (CutStr.cutStr(strCate,6).equals("151305") && !CutStr.cutStr(strCate,8).equals("15130505")) || CutStr.cutStr(strCate,6).equals("151306") || 
					(CutStr.cutStr(strCate,6).equals("150302") && !CutStr.cutStr(strCate,8).equals("15030214")) || CutStr.cutStr(strCate,8).equals("15040309") || CutStr.cutStr(strCate,8).equals("15040310") || 
					CutStr.cutStr(strCate,8).equals("15030304") || CutStr.cutStr(strCate,6).equals("151301") || CutStr.cutStr(strCate,8).equals("15060405") ||
					CutStr.cutStr(strCate,8).equals("15090203") || CutStr.cutStr(strCate,8).equals("15090204") || CutStr.cutStr(strCate,8).equals("15090404") || CutStr.cutStr(strCate,8).equals("15090405") ||
					CutStr.cutStr(strCate,8).equals("15030401") || CutStr.cutStr(strCate,8).equals("15030402") || CutStr.cutStr(strCate,8).equals("15030403") || CutStr.cutStr(strCate,8).equals("15090202") ||
					CutStr.cutStr(strCate,8).equals("15030601") || CutStr.cutStr(strCate,8).equals("15090201") || CutStr.cutStr(strCate,8).equals("15030602") || CutStr.cutStr(strCate,8).equals("15030604") || 
					CutStr.cutStr(strCate,8).equals("15030631") ||  CutStr.cutStr(strCate,8).equals("15030632") ||  CutStr.cutStr(strCate,8).equals("15030634") ||
					CutStr.cutStr(strCate,8).equals("15030606") || CutStr.cutStr(strCate,6).equals("150705") || CutStr.cutStr(strCate,8).equals("15060401") || CutStr.cutStr(strCate,8).equals("15060403") || 
					CutStr.cutStr(strCate,8).equals("15060406") || 
					CutStr.cutStr(strCate,8).equals("15050128") || CutStr.cutStr(strCate,8).equals("15050129") || CutStr.cutStr(strCate,8).equals("15050130") || CutStr.cutStr(strCate,8).equals("15050131") ||
					CutStr.cutStr(strCate,8).equals("15060408") || CutStr.cutStr(strCate,8).equals("15051001") || CutStr.cutStr(strCate,8).equals("15050104") || CutStr.cutStr(strCate,8).equals("15050105") ||
					CutStr.cutStr(strCate,8).equals("15100301") || CutStr.cutStr(strCate,8).equals("15100302") || CutStr.cutStr(strCate,8).equals("15100305") || CutStr.cutStr(strCate,8).equals("15100310") ||
					CutStr.cutStr(strCate,8).equals("15100313") || CutStr.cutStr(strCate,8).equals("15100309") || CutStr.cutStr(strCate,8).equals("15100311") || CutStr.cutStr(strCate,8).equals("15100316") ||
					CutStr.cutStr(strCate,8).equals("15100304") || CutStr.cutStr(strCate,8).equals("15100306") || CutStr.cutStr(strCate,8).equals("15020216") ||
					CutStr.cutStr(strCate,8).equals("15090409") || CutStr.cutStr(strCate,8).equals("15010601") || CutStr.cutStr(strCate,8).equals("15010602") || CutStr.cutStr(strCate,8).equals("15010608") ||
					CutStr.cutStr(strCate,8).equals("15040401") || CutStr.cutStr(strCate,8).equals("15040402") || CutStr.cutStr(strCate,8).equals("15040403") || CutStr.cutStr(strCate,8).equals("15040404") ||
					CutStr.cutStr(strCate,6).equals("150606") || (CutStr.cutStr(strCate,6).equals("150407") && !CutStr.cutStr(strCate,8).equals("15040705")) || CutStr.cutStr(strCate,8).equals("15040421") ||
					CutStr.cutStr(strCate,8).equals("15080508") || CutStr.cutStr(strCate,8).equals("15080509") || 
					CutStr.cutStr(strCate,8).equals("15040603") || CutStr.cutStr(strCate,8).equals("15080207") || CutStr.cutStr(strCate,8).equals("15040419") ||  
					CutStr.cutStr(strCate,8).equals("15020217") || CutStr.cutStr(strCate,8).equals("15070510") || CutStr.cutStr(strCate,8).equals("15080207")	|| CutStr.cutStr(strCate,8).equals("15070507") || 
					CutStr.cutStr(strCate,8).equals("15050106")	|| CutStr.cutStr(strCate,8).equals("15090212")	|| CutStr.cutStr(strCate,8).equals("15070504") || 
					(CutStr.cutStr(strCate,4).equals("1501") && !CutStr.cutStr(strCate,8).equals("15010110") && !CutStr.cutStr(strCate,8).equals("15010207") && !CutStr.cutStr(strCate,8).equals("15010513") && 
					!CutStr.cutStr(strCate,8).equals("15010805")) ||   
					(CutStr.cutStr(strCate,6).equals("151004") && !CutStr.cutStr(strCate,8).equals("15100406") && !CutStr.cutStr(strCate,8).equals("15100411")) || CutStr.cutStr(strCate,8).equals("15020509") || CutStr.cutStr(strCate,8).equals("15020511") ||
					CutStr.cutStr(strCate,8).equals("15050101") || CutStr.cutStr(strCate,6).equals("150708") ||	CutStr.cutStr(strCate,8).equals("15040302") ||  
					CutStr.cutStr(strCate,8).equals("15040405") || CutStr.cutStr(strCate,8).equals("15040408") || CutStr.cutStr(strCate,8).equals("15070511") ||
					CutStr.cutStr(strCate,8).equals("15080509") || CutStr.cutStr(strCate,8).equals("15081001") || CutStr.cutStr(strCate,6).equals("150204") ||
					CutStr.cutStr(strCate,8).equals("15081002") || CutStr.cutStr(strCate,6).equals("150208") || CutStr.cutStr(strCate,6).equals("150209") || 
					CutStr.cutStr(strCate,8).equals("15090501") || CutStr.cutStr(strCate,8).equals("15090502") || CutStr.cutStr(strCate,8).equals("15090503") || CutStr.cutStr(strCate,8).equals("15090504") || 
					CutStr.cutStr(strCate,8).equals("15090505") || CutStr.cutStr(strCate,8).equals("15090112") || CutStr.cutStr(strCate,8).equals("15090412") || CutStr.cutStr(strCate,8).equals("15070809") ||
					CutStr.cutStr(strCate,8).equals("15070810") || CutStr.cutStr(strCate,8).equals("15070811") || CutStr.cutStr(strCate,8).equals("15070812") || CutStr.cutStr(strCate,8).equals("15070813") ||
					CutStr.cutStr(strCate,8).equals("15100308")	|| CutStr.cutStr(strCate,6).equals("150207")   || CutStr.cutStr(strCate,8).equals("15100307")	|| CutStr.cutStr(strCate,8).equals("15050121") || 
					CutStr.cutStr(strCate,8).equals("15050122") || CutStr.cutStr(strCate,8).equals("15050123") || CutStr.cutStr(strCate,8).equals("15050124") || CutStr.cutStr(strCate,8).equals("15050125") || 
					CutStr.cutStr(strCate,8).equals("15050126")	|| CutStr.cutStr(strCate,8).equals("15030303") || 
					CutStr.cutStr(strCate,8).equals("15030306")	|| CutStr.cutStr(strCate,8).equals("15030603") || CutStr.cutStr(strCate,8).equals("15030608") || CutStr.cutStr(strCate,8).equals("15030609") || 
					CutStr.cutStr(strCate,8).equals("15030610") || CutStr.cutStr(strCate,8).equals("15030611") || CutStr.cutStr(strCate,8).equals("15030612") || CutStr.cutStr(strCate,8).equals("15030613") || 
					CutStr.cutStr(strCate,8).equals("15030614") || CutStr.cutStr(strCate,8).equals("15030615") || CutStr.cutStr(strCate,8).equals("15030616") || CutStr.cutStr(strCate,8).equals("15030618") || 
					CutStr.cutStr(strCate,8).equals("15030619") || CutStr.cutStr(strCate,8).equals("15030621") || CutStr.cutStr(strCate,8).equals("15030623") || CutStr.cutStr(strCate,8).equals("15030627") ||
					CutStr.cutStr(strCate,8).equals("15030622") || CutStr.cutStr(strCate,8).equals("15030301") || CutStr.cutStr(strCate,8).equals("15100203") || 
					(CutStr.cutStr(strCate,6).equals("150307") && !CutStr.cutStr(strCate,8).equals("15030715")) || CutStr.cutStr(strCate,8).equals("15030628") || CutStr.cutStr(strCate,8).equals("15030626") ||  
					CutStr.cutStr(strCate,8).equals("15030310") || CutStr.cutStr(strCate,8).equals("15050916") || CutStr.cutStr(strCate,8).equals("15030302") ||
					CutStr.cutStr(strCate,8).equals("15100107") || CutStr.cutStr(strCate,8).equals("15090511") || CutStr.cutStr(strCate,8).equals("15090122") || CutStr.cutStr(strCate,8).equals("15090113") ||
					CutStr.cutStr(strCate,8).equals("15090123") || CutStr.cutStr(strCate,8).equals("15090112") || CutStr.cutStr(strCate,8).equals("15090119") || CutStr.cutStr(strCate,8).equals("15090121") ||
					CutStr.cutStr(strCate,8).equals("15090701") || CutStr.cutStr(strCate,8).equals("15090702") || CutStr.cutStr(strCate,8).equals("15090703") || CutStr.cutStr(strCate,8).equals("15090704") ||
					CutStr.cutStr(strCate,8).equals("15090705") || CutStr.cutStr(strCate,8).equals("15090706") || CutStr.cutStr(strCate,8).equals("15090707") || CutStr.cutStr(strCate,8).equals("15090708") ||
					CutStr.cutStr(strCate,8).equals("15030111") || CutStr.cutStr(strCate,8).equals("15030112") || CutStr.cutStr(strCate,8).equals("15071002") || CutStr.cutStr(strCate,6).equals("151103") || 
					CutStr.cutStr(strCate,6).equals("151003") || CutStr.cutStr(strCate,6).equals("151007") || CutStr.cutStr(strCate,6).equals("151008") || CutStr.cutStr(strCate,8).equals("15100322") ||
					CutStr.cutStr(strCate,6).equals("150111") || CutStr.cutStr(strCate,6).equals("150112") || CutStr.cutStr(strCate,8).equals("15100106") ||
					CutStr.cutStr(strCate,6).equals("159802") || CutStr.cutStr(strCate,6).equals("159803") || CutStr.cutStr(strCate,6).equals("159804") || CutStr.cutStr(strCate,8).equals("15980501") || 
					CutStr.cutStr(strCate,8).equals("15980502") || CutStr.cutStr(strCate,8).equals("15980503") || CutStr.cutStr(strCate,8).equals("15980505") || CutStr.cutStr(strCate,8).equals("15980507") || 
					CutStr.cutStr(strCate,8).equals("15980508") || CutStr.cutStr(strCate,8).equals("15980510") || CutStr.cutStr(strCate,6).equals("159802") || CutStr.cutStr(strCate,6).equals("159803") || 
					CutStr.cutStr(strCate,6).equals("159804") || CutStr.cutStr(strCate,8).equals("15980501") || CutStr.cutStr(strCate,8).equals("15980502") || CutStr.cutStr(strCate,8).equals("15980503") || 
					CutStr.cutStr(strCate,8).equals("15980505") || CutStr.cutStr(strCate,8).equals("15980507") || CutStr.cutStr(strCate,8).equals("15980508") || CutStr.cutStr(strCate,8).equals("15980510") ||
					CutStr.cutStr(strCate,8).equals("15980504") || CutStr.cutStr(strCate,8).equals("15980506") || CutStr.cutStr(strCate,6).equals("150905") || 
					CutStr.cutStr(strCate,6).equals("150907") || CutStr.cutStr(strCate,6).equals("150902") || CutStr.cutStr(strCate,8).equals("15090123") || CutStr.cutStr(strCate,8).equals("15090112") || 
					CutStr.cutStr(strCate,8).equals("15090125") || (CutStr.cutStr(strCate,6).equals("150308") &&  !CutStr.cutStr(strCate,8).equals("15030805")) ||
					CutStr.cutStr(strCate,8).equals("10030104") || CutStr.cutStr(strCate,8).equals("10120308") || CutStr.cutStr(strCate,8).equals("10120309") || CutStr.cutStr(strCate,6).equals("080608") ||
					CutStr.cutStr(strCate,6).equals("080601") || CutStr.cutStr(strCate,6).equals("080611") || CutStr.cutStr(strCate,6).equals("080603") || CutStr.cutStr(strCate,6).equals("080602") || 
					CutStr.cutStr(strCate,6).equals("080613") || CutStr.cutStr(strCate,6).equals("080605") || (CutStr.cutStr(strCate,6).equals("080606") && !CutStr.cutStr(strCate,8).equals("08060615")) ||
 					CutStr.cutStr(strCate,6).equals("150101") || CutStr.cutStr(strCate,6).equals("150102") || CutStr.cutStr(strCate,6).equals("150104") || CutStr.cutStr(strCate,6).equals("150103") || 
 					CutStr.cutStr(strCate,6).equals("150105") || CutStr.cutStr(strCate,6).equals("150107") || CutStr.cutStr(strCate,6).equals("150108") || CutStr.cutStr(strCate,6).equals("150111") || 
 					CutStr.cutStr(strCate,6).equals("150112") || CutStr.cutStr(strCate,8).equals("15011104") || CutStr.cutStr(strCate,6).equals("080615") ||
					(CutStr.cutStr(strCate,6).equals("150501") && !CutStr.cutStr(strCate,8).equals("15050112")) || (CutStr.cutStr(strCate,6).equals("150504") && !CutStr.cutStr(strCate,8).equals("15050408") && !CutStr.cutStr(strCate,8).equals("15050420")) || 
					(CutStr.cutStr(strCate,6).equals("150502") && !CutStr.cutStr(strCate,8).equals("15050208")) || (CutStr.cutStr(strCate,6).equals("150507") && !CutStr.cutStr(strCate,8).equals("15050704")) ||
					CutStr.cutStr(strCate,8).equals("15070115") || CutStr.cutStr(strCate,8).equals("15060407") || CutStr.cutStr(strCate,8).equals("15070409") || CutStr.cutStr(strCate,8).equals("15070609") ||
					CutStr.cutStr(strCate,8).equals("15070610") || CutStr.cutStr(strCate,8).equals("15070611") || CutStr.cutStr(strCate,8).equals("15070612") || CutStr.cutStr(strCate,8).equals("15070613") ||
					(CutStr.cutStr(strCate,4).equals("0812") && !CutStr.cutStr(strCate,6).equals("081203") && !CutStr.cutStr(strCate,8).equals("08120603") && !CutStr.cutStr(strCate,8).equals("08120408"))	||
					CutStr.cutStr(strCate,8).equals("16250111") || CutStr.cutStr(strCate,8).equals("16250209") || CutStr.cutStr(strCate,8).equals("16250303") || CutStr.cutStr(strCate,8).equals("16250704") ||
					CutStr.cutStr(strCate,6).equals("150309") || ( CutStr.cutStr(strCate,6).equals("150310") && !CutStr.cutStr(strCate,8).equals("15031006")) || CutStr.cutStr(strCate,6).equals("150311") ||
					CutStr.cutStr(strCate,6).equals("150401") || CutStr.cutStr(strCate,6).equals("150402") ||  CutStr.cutStr(strCate,8).equals("15040409") || CutStr.cutStr(strCate,8).equals("08061203") || 
					CutStr.cutStr(strCate,8).equals("15130213") || CutStr.cutStr(strCate,8).equals("15130214") || CutStr.cutStr(strCate,8).equals("15130215") || CutStr.cutStr(strCate,8).equals("15130509") ||
					CutStr.cutStr(strCate,8).equals("15040415") || CutStr.cutStr(strCate,8).equals("15040416") || CutStr.cutStr(strCate,8).equals("15040417") || CutStr.cutStr(strCate,8).equals("15040418") ||
					CutStr.cutStr(strCate,6).equals("100501") || CutStr.cutStr(strCate,8).equals("10050201") || CutStr.cutStr(strCate,8).equals("10050204") || CutStr.cutStr(strCate,6).equals("100508") ||
					CutStr.cutStr(strCate,6).equals("100511") || CutStr.cutStr(strCate,6).equals("100512") || CutStr.cutStr(strCate,6).equals("100513") || CutStr.cutStr(strCate,6).equals("100514") ||
					CutStr.cutStr(strCate,6).equals("100515") || CutStr.cutStr(strCate,6).equals("100516") || (CutStr.cutStr(strCate,6).equals("151012") && ! CutStr.cutStr(strCate,8).equals("15101206")) || 
					CutStr.cutStr(strCate,6).equals("151104") || CutStr.cutStr(strCate,6).equals("151011") || CutStr.cutStr(strCate,8).equals("15100703") || CutStr.cutStr(strCate,8).equals("15100704") || 
					CutStr.cutStr(strCate,8).equals("15100705") || CutStr.cutStr(strCate,8).equals("16420901") || CutStr.cutStr(strCate,8).equals("16421002") || CutStr.cutStr(strCate,6).equals("210812") || 
					CutStr.cutStr(strCate,8).equals("21080201") || CutStr.cutStr(strCate,8).equals("21080203") || CutStr.cutStr(strCate,8).equals("21080206") || CutStr.cutStr(strCate,8).equals("21080207") || 
					CutStr.cutStr(strCate,8).equals("21080211") || CutStr.cutStr(strCate,8).equals("21080213") || CutStr.cutStr(strCate,8).equals("16250404") || CutStr.cutStr(strCate,8).equals("21150506") ||
					CutStr.cutStr(strCate,8).equals("16421003") || CutStr.cutStr(strCate,8).equals("15020226") || CutStr.cutStr(strCate,8).equals("15020227") ||
					CutStr.cutStr(strCate,8).equals("16421008") || CutStr.cutStr(strCate,8).equals("16421010") || CutStr.cutStr(strCate,8).equals("16421005") || CutStr.cutStr(strCate,8).equals("16421006") || 
					CutStr.cutStr(strCate,8).equals("16421009") || CutStr.cutStr(strCate,8).equals("16421011") || CutStr.cutStr(strCate,8).equals("16421013") || 
					CutStr.cutStr(strCate,8).equals("10050208") || CutStr.cutStr(strCate,8).equals("15020501") || CutStr.cutStr(strCate,8).equals("15020502") || CutStr.cutStr(strCate,8).equals("15020503") || 
					CutStr.cutStr(strCate,8).equals("15020506") || CutStr.cutStr(strCate,8).equals("15020507") || CutStr.cutStr(strCate,8).equals("15020510") || CutStr.cutStr(strCate,8).equals("15020512") ||
					CutStr.cutStr(strCate,8).equals("15040410") || CutStr.cutStr(strCate,8).equals("15020520") || CutStr.cutStr(strCate,8).equals("15020521") || CutStr.cutStr(strCate,8).equals("15020522") ||
					CutStr.cutStr(strCate,8).equals("15060301") || CutStr.cutStr(strCate,8).equals("15060305") || CutStr.cutStr(strCate,8).equals("15060306") || CutStr.cutStr(strCate,8).equals("15060307") ||
					CutStr.cutStr(strCate,6).equals("081407") || CutStr.cutStr(strCate,6).equals("080617") || CutStr.cutStr(strCate,6).equals("080618") || CutStr.cutStr(strCate,6).equals("080104") || 
					CutStr.cutStr(strCate,6).equals("080112") || CutStr.cutStr(strCate,6).equals("080107") || CutStr.cutStr(strCate,6).equals("080102") || CutStr.cutStr(strCate,6).equals("080103") || 
					CutStr.cutStr(strCate,6).equals("080120") || CutStr.cutStr(strCate,6).equals("080121") || CutStr.cutStr(strCate,6).equals("080122") || CutStr.cutStr(strCate,6).equals("080123") || 
					CutStr.cutStr(strCate,6).equals("080111") || CutStr.cutStr(strCate,8).equals("08061201") || CutStr.cutStr(strCate,8).equals("08061202") || CutStr.cutStr(strCate,8).equals("08061203") ||
					CutStr.cutStr(strCate,8).equals("08061204") || CutStr.cutStr(strCate,8).equals("08061207") || CutStr.cutStr(strCate,8).equals("08130901") || CutStr.cutStr(strCate,8).equals("08130902") ||
					(CutStr.cutStr(strCate,6).equals("150801") && !CutStr.cutStr(strCate,8).equals("15080113")) || CutStr.cutStr(strCate,8).equals("15100411") ||
					CutStr.cutStr(strCate,6).equals("150809") || ( CutStr.cutStr(strCate,6).equals("150808") && !CutStr.cutStr(strCate,8).equals("15080806") && !CutStr.cutStr(strCate,8).equals("15080807") && !CutStr.cutStr(strCate,8).equals("15080812")) ||
				  	CutStr.cutStr(strCate,6).equals("150813") || CutStr.cutStr(strCate,8).equals("15090106")  || CutStr.cutStr(strCate,8).equals("15091301") || CutStr.cutStr(strCate,8).equals("15091303") ||
				  	CutStr.cutStr(strCate,8).equals("15080808") || CutStr.cutStr(strCate,8).equals("10050210") || CutStr.cutStr(strCate,8).equals("10050211") || CutStr.cutStr(strCate,8).equals("10050212") ||
				  	CutStr.cutStr(strCate,8).equals("10050213") || CutStr.cutStr(strCate,8).equals("10050215") || CutStr.cutStr(strCate,8).equals("10050216") ||
				  	CutStr.cutStr(strCate,8).equals("15110504") || CutStr.cutStr(strCate,8).equals("15110506") || CutStr.cutStr(strCate,8).equals("15110508") || CutStr.cutStr(strCate,8).equals("15110107") ||
				  	CutStr.cutStr(strCate,8).equals("15040422") || CutStr.cutStr(strCate,8).equals("15110503") || CutStr.cutStr(strCate,8).equals("15110505") ||
				  	(CutStr.cutStr(strCate,6).equals("150802") && !CutStr.cutStr(strCate,8).equals("15080206"))  || CutStr.cutStr(strCate,8).equals("10050206") || CutStr.cutStr(strCate,8).equals("10050203")
				){
					strCondiCount = "1";
				}
				int intGcnt = 100;
				if (CutStr.cutStr(strCate,8).equals("15020201") || (CutStr.cutStr(strCate,6).equals("150203") && !CutStr.cutStr(strCate,8).equals("15020308") ) || 
					CutStr.cutStr(strCate,8).equals("15090126") ||  
					CutStr.cutStr(strCate,8).equals("15090101") || CutStr.cutStr(strCate,8).equals("15090102") || CutStr.cutStr(strCate,8).equals("15090103") || 
					CutStr.cutStr(strCate,8).equals("15090104") || CutStr.cutStr(strCate,8).equals("15020216") || CutStr.cutStr(strCate,8).equals("15090212") ||
					CutStr.cutStr(strCate,8).equals("15050916") || CutStr.cutStr(strCate,8).equals("15090119") ||
					CutStr.cutStr(strCate,8).equals("15090122") || CutStr.cutStr(strCate,8).equals("15090113") || CutStr.cutStr(strCate,6).equals("150202") || 
					CutStr.cutStr(strCate,6).equals("159801") || CutStr.cutStr(strCate,8).equals("15090102") || CutStr.cutStr(strCate,8).equals("15090101") || CutStr.cutStr(strCate,8).equals("15090103") ||
					CutStr.cutStr(strCate,8).equals("15090104") ||  
					CutStr.cutStr(strCate,6).equals("150208") || CutStr.cutStr(strCate,6).equals("150209") || CutStr.cutStr(strCate,8).equals("15020226") || CutStr.cutStr(strCate,8).equals("15020227")
					
				){
					intGcnt = 1000;
				}
				if (CutStr.cutStr(strCate,8).equals("15070510") || CutStr.cutStr(strCate,8).equals("15070605") || CutStr.cutStr(strCate,8).equals("08061203") || CutStr.cutStr(strCate,8).equals("08061201") ||
					CutStr.cutStr(strCate,8).equals("15020217") || CutStr.cutStr(strCate,8).equals("15070510") || CutStr.cutStr(strCate,8).equals("15010609") || CutStr.cutStr(strCate,8).equals("08061202") ||
					CutStr.cutStr(strCate,8).equals("15980504") || CutStr.cutStr(strCate,8).equals("15980506") || CutStr.cutStr(strCate,8).equals("08061204") || CutStr.cutStr(strCate,8).equals("08061207") ||
					CutStr.cutStr(strCate,8).equals("16360707") || CutStr.cutStr(strCate,8).equals("16360708") || CutStr.cutStr(strCate,8).equals("15130303") || CutStr.cutStr(strCate,8).equals("15070416") ||
					CutStr.cutStr(strCate,8).equals("15070405") || CutStr.cutStr(strCate,8).equals("15070505") || CutStr.cutStr(strCate,6).equals("080605") || CutStr.cutStr(strCate,6).equals("080606") ||
					CutStr.cutStr(strCate,6).equals("080603") || CutStr.cutStr(strCate,6).equals("080602") || CutStr.cutStr(strCate,6).equals("080611") || CutStr.cutStr(strCate,6).equals("080613") || 
					CutStr.cutStr(strCate,8).equals("15110306") || CutStr.cutStr(strCate,8).equals("15110305") || CutStr.cutStr(strCate,8).equals("15110307") || CutStr.cutStr(strCate,6).equals("080601") ||
					CutStr.cutStr(strCate,8).equals("15100803") || CutStr.cutStr(strCate,8).equals("15100804") || CutStr.cutStr(strCate,8).equals("15100805") || CutStr.cutStr(strCate,6).equals("080608") ||
					CutStr.cutStr(strCate,8).equals("15100806") || CutStr.cutStr(strCate,8).equals("15100323") || CutStr.cutStr(strCate,8).equals("15100328") || CutStr.cutStr(strCate,8).equals("15070508") ||
					CutStr.cutStr(strCate,8).equals("15010508") ||  CutStr.cutStr(strCate,6).equals("150101") || CutStr.cutStr(strCate,6).equals("150102") || CutStr.cutStr(strCate,8).equals("10120315") ||
					(CutStr.cutStr(strCate,6).equals("150103") && !CutStr.cutStr(strCate,8).equals("15010319") && !CutStr.cutStr(strCate,8).equals("15010320")) || CutStr.cutStr(strCate,8).equals("15070504") ||
					CutStr.cutStr(strCate,6).equals("150104") || CutStr.cutStr(strCate,6).equals("150105") || CutStr.cutStr(strCate,6).equals("150107") || CutStr.cutStr(strCate,6).equals("150108") ||
					(CutStr.cutStr(strCate,6).equals("150111") && !CutStr.cutStr(strCate,6).equals("15011104")) || CutStr.cutStr(strCate,6).equals("150112") || 
					CutStr.cutStr(strCate,8).equals("15080508") || CutStr.cutStr(strCate,6).equals("080615") ||
					(CutStr.cutStr(strCate,6).equals("150501") && !CutStr.cutStr(strCate,8).equals("15050120") && !CutStr.cutStr(strCate,8).equals("15050106") && !CutStr.cutStr(strCate,8).equals("15050127") 
					&& !CutStr.cutStr(strCate,8).equals("15050128") && !CutStr.cutStr(strCate,8).equals("15050129") && !CutStr.cutStr(strCate,8).equals("15050130") && !CutStr.cutStr(strCate,8).equals("15050131")
					&& !CutStr.cutStr(strCate,8).equals("15050132")) || 
					(CutStr.cutStr(strCate,4).equals("0812") && !CutStr.cutStr(strCate,6).equals("081203") && !CutStr.cutStr(strCate,8).equals("08120603") && !CutStr.cutStr(strCate,8).equals("08120408")) || 
					CutStr.cutStr(strCate,6).equals("150504") || CutStr.cutStr(strCate,6).equals("150502")  || (CutStr.cutStr(strCate,6).equals("150507") && !CutStr.cutStr(strCate,8).equals("15050722")) ||
					CutStr.cutStr(strCate,6).equals("100501") || CutStr.cutStr(strCate,8).equals("10050201") || CutStr.cutStr(strCate,8).equals("10050204") || CutStr.cutStr(strCate,6).equals("100508") ||
					CutStr.cutStr(strCate,6).equals("100511") || CutStr.cutStr(strCate,6).equals("100512") || CutStr.cutStr(strCate,6).equals("100513") || CutStr.cutStr(strCate,6).equals("100514") ||
					CutStr.cutStr(strCate,8).equals("16420901") || CutStr.cutStr(strCate,8).equals("16250403") || CutStr.cutStr(strCate,8).equals("16421003") || CutStr.cutStr(strCate,8).equals("16421008") ||
					CutStr.cutStr(strCate,8).equals("16421010") || CutStr.cutStr(strCate,8).equals("15100329") || CutStr.cutStr(strCate,8).equals("15100321") || CutStr.cutStr(strCate,8).equals("15100322") || 
					CutStr.cutStr(strCate,8).equals("15100326") || CutStr.cutStr(strCate,8).equals("15100327") || CutStr.cutStr(strCate,8).equals("15100401") || CutStr.cutStr(strCate,8).equals("15100407") ||
					CutStr.cutStr(strCate,8).equals("10050206") || CutStr.cutStr(strCate,8).equals("10050208") || CutStr.cutStr(strCate,8).equals("15020501") || CutStr.cutStr(strCate,8).equals("10050203") || 
					CutStr.cutStr(strCate,8).equals("15020502") || CutStr.cutStr(strCate,8).equals("15020503") || CutStr.cutStr(strCate,8).equals("15020506") || CutStr.cutStr(strCate,8).equals("15020507") || 
					CutStr.cutStr(strCate,8).equals("15020510") || CutStr.cutStr(strCate,8).equals("15020512") || CutStr.cutStr(strCate,8).equals("15020511") || CutStr.cutStr(strCate,8).equals("15020520") ||
					CutStr.cutStr(strCate,8).equals("15020521") || CutStr.cutStr(strCate,8).equals("15020522") || CutStr.cutStr(strCate,8).equals("15100411") || CutStr.cutStr(strCate,8).equals("15070510") ||
					CutStr.cutStr(strCate,8).equals("16051501") || CutStr.cutStr(strCate,8).equals("16051502") || CutStr.cutStr(strCate,8).equals("16051503") || CutStr.cutStr(strCate,6).equals("081407") ||
					CutStr.cutStr(strCate,8).equals("15070511") || CutStr.cutStr(strCate,6).equals("080617") || CutStr.cutStr(strCate,6).equals("080618") || CutStr.cutStr(strCate,8).equals("10050210") || 
					CutStr.cutStr(strCate,8).equals("10050211") || CutStr.cutStr(strCate,8).equals("10050212") || CutStr.cutStr(strCate,8).equals("10050213") || CutStr.cutStr(strCate,8).equals("10050215") || 
					CutStr.cutStr(strCate,8).equals("10050216") || CutStr.cutStr(strCate,6).equals("080104") || CutStr.cutStr(strCate,6).equals("080112") || CutStr.cutStr(strCate,6).equals("080107") || 
					CutStr.cutStr(strCate,6).equals("080102") || CutStr.cutStr(strCate,6).equals("080103") || CutStr.cutStr(strCate,6).equals("080120") || CutStr.cutStr(strCate,6).equals("080121") || 
					CutStr.cutStr(strCate,6).equals("080122") || CutStr.cutStr(strCate,6).equals("080123") || CutStr.cutStr(strCate,6).equals("080111") || CutStr.cutStr(strCate,8).equals("15080201") || 
					CutStr.cutStr(strCate,8).equals("15080203") || CutStr.cutStr(strCate,8).equals("15080204") || CutStr.cutStr(strCate,8).equals("15080205") || CutStr.cutStr(strCate,8).equals("15080205") ||
					CutStr.cutStr(strCate,8).equals("15080228") || CutStr.cutStr(strCate,8).equals("15080222") || CutStr.cutStr(strCate,8).equals("15080223") || CutStr.cutStr(strCate,8).equals("15080229") || 
					CutStr.cutStr(strCate,8).equals("15080226") || CutStr.cutStr(strCate,8).equals("08130901") || CutStr.cutStr(strCate,8).equals("15080230") || CutStr.cutStr(strCate,8).equals("15080231") ||
					(CutStr.cutStr(strCate,6).equals("150801") && !CutStr.cutStr(strCate,8).equals("15080113")) || CutStr.cutStr(strCate,8).equals("08130902") ||   
					CutStr.cutStr(strCate,6).equals("150809") || CutStr.cutStr(strCate,8).equals("15091303") ||
				 	( CutStr.cutStr(strCate,6).equals("150808") && !CutStr.cutStr(strCate,8).equals("15080806") && !CutStr.cutStr(strCate,8).equals("15080807") && !CutStr.cutStr(strCate,8).equals("15080812")
				 	&& !CutStr.cutStr(strCate,8).equals("15080808") && !CutStr.cutStr(strCate,8).equals("15080801")) ||
				  	CutStr.cutStr(strCate,6).equals("150813")  || CutStr.cutStr(strCate,8).equals("15100412") || CutStr.cutStr(strCate,8).equals("15090106") || CutStr.cutStr(strCate,8).equals("16421313") || 
				  	CutStr.cutStr(strCate,8).equals("16421314") || CutStr.cutStr(strCate,8).equals("16421316") || CutStr.cutStr(strCate,8).equals("16421315") || CutStr.cutStr(strCate,8).equals("16421318") ||
				  	CutStr.cutStr(strCate,8).equals("16421323") || CutStr.cutStr(strCate,8).equals("16421612") || CutStr.cutStr(strCate,8).equals("16421615") || CutStr.cutStr(strCate,8).equals("15040422") || 
				  	CutStr.cutStr(strCate,8).equals("15110503") || CutStr.cutStr(strCate,8).equals("15110505") || CutStr.cutStr(strCate,8).equals("15110511") || CutStr.cutStr(strCate,8).equals("15110512") ||
				  	CutStr.cutStr(strCate,8).equals("15020509")
				){
					intGcnt = 10;
				}
				if (CutStr.cutStr(strCate,8).equals("16421702")){
					intGcnt = 1000000;
				}
				if (CutStr.cutStr(strCate,6).equals("162505") || CutStr.cutStr(strCate,8).equals("16321005") || CutStr.cutStr(strCate,8).equals("09011910")){
					strCondiCount = getSpecCount(strSpec)+"";
				}
				if (CutStr.cutStr(strCate,8).equals("16421613") || CutStr.cutStr(strCate,8).equals("16421614")){
					intGcnt = 1;
				}
				if (ChkNull.chkNumber(strCondiCount)){
					//배송비 때문에 오류 나서 환산가 단위보다 작으면 계산 안함.
					if (intSpecCount<intGcnt){
						lngReturn = 0;
					}else{
						lngReturn = (long)(((double)lngMinprice/Double.parseDouble(strCondiCount))/(double)intSpecCount*intGcnt);
					}
				}
			}
		}else if(CutStr.cutStr(strCate,8).equals("05100905") && strIndividualChangeUnit.toLowerCase().equals("ml")){
			if (strCondiCount.trim().length() > 0 && intSpecCount > 0){
				lngReturn = (long)(((double)lngMinprice/Double.parseDouble(strCondiCount))/(double)intSpecCount*10);
			}
		}else if((CutStr.cutStr(strCate,4).equals("0712") || CutStr.cutStr(strCate,6).equals("034201") || CutStr.cutStr(strCate,6).equals("034203") || CutStr.cutStr(strCate,6).equals("034204") || 
			CutStr.cutStr(strCate,6).equals("034205") || CutStr.cutStr(strCate,6).equals("031319") || CutStr.cutStr(strCate,6).equals("034212")) 
			&& (strCondiName.trim().length() > 0 && strCondiName.substring(strCondiName.length()-1,strCondiName.length()).toLowerCase().equals("m")) ){
				lngReturn = 0;
		}else if(CutStr.cutStr(strCate,4).equals("0703") && strCondiName.indexOf("(") >= 0){
			String strTempCondiName = CutStr.cutStr(strCondiName,strCondiName.indexOf("("));
			if (strTempCondiName.trim().length() > 0 && strTempCondiName.substring(strTempCondiName.length()-1,strTempCondiName.length()).toLowerCase().equals("m")){
				lngReturn = 0;
			}else{
				strCondiCount = "";
				for (int i=0;i<strTempCondiName.length();i++){
					String strCharTempOne = strTempCondiName.substring(i,i+1);
					if (ChkNull.chkNumber(strCharTempOne)){
						strCondiCount = strCondiCount + strCharTempOne;
					}
				}
				if (ChkNull.chkNumber(strCondiCount)){
					int intCondiCount = Integer.parseInt(strCondiCount);
					if (intSpecCount > 0 && intCondiCount > 0 ){
						lngReturn = (long)((lngMinprice/intCondiCount)/intSpecCount);
					}
				}
			}
		}else if((CutStr.cutStr(strCate,4).equals("0703")) && (strCondiName.trim().length() > 0 && strCondiName.substring(strCondiName.length()-1,strCondiName.length()).toLowerCase().equals("m")) && strCondiCount.trim().length() > 0){
			lngReturn = 0;
		}else if(CutStr.cutStr(strCate,4).equals("0714") || CutStr.cutStr(strCate,6).equals("081302") || (CutStr.cutStr(strCate,6).equals("081309") && !CutStr.cutStr(strCate,8).equals("08130901") && !CutStr.cutStr(strCate,8).equals("08130902")) || 
				CutStr.cutStr(strCate,6).equals("070119") || CutStr.cutStr(strCate,6).equals("070120") || CutStr.cutStr(strCate,6).equals("070121") || CutStr.cutStr(strCate,6).equals("070122") || 
				CutStr.cutStr(strCate,8).equals("08140604") || CutStr.cutStr(strCate,8).equals("09201112") || CutStr.cutStr(strCate,8).equals("09201111")
			){
			if (strCondiName.indexOf("x") == -1 ){
				if (CutStr.cutStr(strCate,6).equals("081302") || CutStr.cutStr(strCate,6).equals("081309") ||  CutStr.cutStr(strCate,8).equals("08140604") ){
					if (ChkNull.chkNumber(strCondiCount) && intSpecCount > 0){
						lngReturn = (long)((lngMinprice/Integer.parseInt(strCondiCount))/intSpecCount);
					}
				}else{
					if (ChkNull.chkNumber(strCondiCount) && intSpecCount > 0){
						lngReturn = (long)((lngMinprice/Integer.parseInt(strCondiCount))/intSpecCount);
					}
				}
			}else{
				String strCondiName1 = strCondiName.substring(0,strCondiName.indexOf("x"));
				String strCondiName2 = strCondiName.substring(strCondiName.indexOf("x"),strCondiName.length());
				String strCondiCount1 = "";
				String strCondiCount2 = "";
				for (int i=0;i<strCondiName1.length();i++){
					String strCharOne1 = strCondiName1.substring(i,i+1);
					if (ChkNull.chkNumber(strCharOne1)){
						strCondiCount1 = strCondiCount1 + strCharOne1;
					}
				}
				for (int i=0;i<strCondiName2.length();i++){
					String strCharOne2 = strCondiName2.substring(i,i+1);
					if (ChkNull.chkNumber(strCharOne2)){
						strCondiCount2 = strCondiCount2 + strCharOne2;
					}
				}						
				if (ChkNull.chkNumber(strCondiCount1) && ChkNull.chkNumber(strCondiCount2) && intSpecCount > 0){
					lngReturn = (long)((lngMinprice/(Integer.parseInt(strCondiCount1)*Integer.parseInt(strCondiCount2)))/intSpecCount);
				}	
			}
		}else if((CutStr.cutStr(strCate,4).equals("0807") && !CutStr.cutStr(strCate,6).equals("080709")) || (CutStr.cutStr(strCate,4).equals("1654") && !CutStr.cutStr(strCate,6).equals("165409"))){
			int int08070403Unit = 100;
			if (strCate.equals("08070403") || CutStr.cutStr(strCate,6).equals("080704") || CutStr.cutStr(strCate,6).equals("080703") || strCate.equals("08071903") ||
				strCate.equals("08071901") || strCate.equals("08071902") || strCate.equals("08071904") || CutStr.cutStr(strCate,6).equals("080721") ||
				strCate.equals("16540403") || CutStr.cutStr(strCate,6).equals("165404") || CutStr.cutStr(strCate,6).equals("165403") || strCate.equals("16541903") ||
				strCate.equals("16541901") || strCate.equals("16541902") || strCate.equals("16541904") || CutStr.cutStr(strCate,6).equals("165421") 
			){
				int08070403Unit = 10;
			}		
			if (strCondiName.indexOf("x") == -1 ){
				if (ChkNull.chkNumber(strCondiCount) && intSpecCount > 0){
					lngReturn = (long)((lngMinprice*int08070403Unit/Integer.parseInt(strCondiCount))/intSpecCount);
				}
			}else{
				String strCondiName1 = strCondiName.substring(0,strCondiName.indexOf("x"));
				String strCondiName2 = strCondiName.substring(strCondiName.indexOf("x"),strCondiName.length());
				String strCondiCount1 = "";
				String strCondiCount2 = "";
				for (int i=0;i<strCondiName1.length();i++){
					String strCharOne1 = strCondiName1.substring(i,i+1);
					if (ChkNull.chkNumber(strCharOne1)){
						strCondiCount1 = strCondiCount1 + strCharOne1;
					}
				}
				for (int i=0;i<strCondiName2.length();i++){
					String strCharOne2 = strCondiName2.substring(i,i+1);
					if (ChkNull.chkNumber(strCharOne2)){
						strCondiCount2 = strCondiCount2 + strCharOne2;
					}
				}						
				if (ChkNull.chkNumber(strCondiCount1) && ChkNull.chkNumber(strCondiCount2) && intSpecCount > 0){
					lngReturn = (long)((lngMinprice*int08070403Unit/(Integer.parseInt(strCondiCount1)*Integer.parseInt(strCondiCount2)))/intSpecCount);
				}	
			}
		}else if(CutStr.cutStr(strCate,8).equals("16140305") || CutStr.cutStr(strCate,8).equals("16140304") || 
				CutStr.cutStr(strCate,8).equals("16140306") || CutStr.cutStr(strCate,8).equals("16140805") || CutStr.cutStr(strCate,8).equals("16140807") ||  
				CutStr.cutStr(strCate,8).equals("16140809") || CutStr.cutStr(strCate,8).equals("16140905") || CutStr.cutStr(strCate,8).equals("16140907") || 
				CutStr.cutStr(strCate,8).equals("16140905") || CutStr.cutStr(strCate,8).equals("16140907") || CutStr.cutStr(strCate,8).equals("06060616") 
		){
			String strCondiName1 = "";
			String strCondiCount1 = "";
			if (strCondiName.indexOf("(") > 0 ){
				strCondiName1 = strCondiName.substring(strCondiName.indexOf("("),strCondiName.length());
				for (int i=0;i<strCondiName1.length();i++){
					String strCharOne1 = strCondiName1.substring(i,i+1);
					if (ChkNull.chkNumber(strCharOne1)){
						strCondiCount1 = strCondiCount1 + strCharOne1;
					}
				}
			}		
			if (ChkNull.chkNumber(strCondiCount1)){	
				lngReturn = (long)((lngMinprice/Integer.parseInt(strCondiCount1)));
			}
		}else if(CutStr.cutStr(strCate,4).equals("100505") && (strCondiName.indexOf("+") > 0 || strCondiName.indexOf(",") > 0)){
			String strCondiName1 = "";
			String strCondiCount1 = "";
			String strDiv = "";
			
			if (strCondiName.indexOf("+") > 0 ){
				strCondiName1 = strCondiName.substring(0,strCondiName.indexOf("+"));
				for (int i=0;i<strCondiName1.length();i++){
					String strCharOne1 = strCondiName1.substring(i,i+1);
					if (ChkNull.chkNumber(strCharOne1)){
						strCondiCount1 = strCondiCount1 + strCharOne1;
					}
				}
			}else if(strCondiName.indexOf(",") > 0 ){
				strCondiName1 = strCondiName.substring(strCondiName.indexOf(","),strCondiName.length());
				for (int i=0;i<strCondiName1.length();i++){
					String strCharOne1 = strCondiName1.substring(i,i+1);
					if (ChkNull.chkNumber(strCharOne1)){
						strCondiCount1 = strCondiCount1 + strCharOne1;
					}
				}
			}
			if (ChkNull.chkNumber(strCondiCount1)){	
				lngReturn = (long)((lngMinprice/Integer.parseInt(strCondiCount1)));
			}
		}else if(CutStr.cutStr(strCate,8).equals("16360702") || CutStr.cutStr(strCate,8).equals("16360703") || CutStr.cutStr(strCate,8).equals("16360711") || CutStr.cutStr(strCate,8).equals("16360704") ||
				 CutStr.cutStr(strCate,8).equals("16290512") || CutStr.cutStr(strCate,8).equals("16290503") || CutStr.cutStr(strCate,8).equals("16290703") || CutStr.cutStr(strCate,8).equals("16290707") ||
				 CutStr.cutStr(strCate,8).equals("16290702") || CutStr.cutStr(strCate,6).equals("162909")   ||  CutStr.cutStr(strCate,8).equals("16360709") || CutStr.cutStr(strCate,8).equals("16050803") ||
				 CutStr.cutStr(strCate,8).equals("16050816") || CutStr.cutStr(strCate,8).equals("16110407") || CutStr.cutStr(strCate,6).equals("162509") || CutStr.cutStr(strCate,8).equals("16111310") ||
				 CutStr.cutStr(strCate,8).equals("16110901") || CutStr.cutStr(strCate,8).equals("16110902") || CutStr.cutStr(strCate,8).equals("16110903") || CutStr.cutStr(strCate,8).equals("16111307") 
		){
			String strCondiName1 = "";
			String strCondiCount1 = "";
			if (strCondiName.indexOf("(") > 0 ){
				strCondiName1 = strCondiName.substring(strCondiName.indexOf("("),strCondiName.length());
				for (int i=0;i<strCondiName1.length();i++){
					String strCharOne1 = strCondiName1.substring(i,i+1);
					if (ChkNull.chkNumber(strCharOne1)){
						strCondiCount1 = strCondiCount1 + strCharOne1;
					}
				}
				strCondiCount = strCondiCount1;
			}		
			if (ChkNull.chkNumber(strCondiCount)){	
				lngReturn = (long)((lngMinprice/Integer.parseInt(strCondiCount)));
			}
		}else if(CutStr.cutStr(strCate,8).equals("05102203") || CutStr.cutStr(strCate,8).equals("05102201")){
			if (ChkNull.chkNumber(strCondiCount)){
				int intCondiCount = Integer.parseInt(strCondiCount);
				if (strCondiName.indexOf(".") >= 0 ){
					if ((strCondiName.length() - strCondiName.indexOf(".")) == 3 ){
						intCondiCount = intCondiCount/10;
					}else if ((strCondiName.length() - strCondiName.indexOf(".")) == 4 ){
						intCondiCount = intCondiCount/100;
					}else if ((strCondiName.length() - strCondiName.indexOf(".")) == 5 ){
						intCondiCount = intCondiCount/1000;
					}
				}
				lngReturn = (long)((lngMinprice/intCondiCount)/intSpecCount);
			}		
		}else if(CutStr.cutStr(strCate,6).equals("070202") || CutStr.cutStr(strCate,6).equals("070203") || CutStr.cutStr(strCate,6).equals("070220") || CutStr.cutStr(strCate,6).equals("070213") || 
			CutStr.cutStr(strCate,6).equals("070209") || CutStr.cutStr(strCate,8).equals("07020528") ||
			CutStr.cutStr(strCate,6).equals("071303") || CutStr.cutStr(strCate,6).equals("071304") || CutStr.cutStr(strCate,6).equals("071307") || CutStr.cutStr(strCate,6).equals("071308") ){
			if (strCondiName.indexOf("T") >= 0 ){
				if (ChkNull.chkNumber(strCondiCount)){
					int intCondiCount = Integer.parseInt(strCondiCount)*1000;
					if (strCondiName.indexOf(".") >= 0 ){
						if ((strCondiName.length() - strCondiName.indexOf(".")) == 3 ){
							intCondiCount = intCondiCount/10;
						}else if ((strCondiName.length() - strCondiName.indexOf(".")) == 4 ){
							intCondiCount = intCondiCount/100;
						}else if ((strCondiName.length() - strCondiName.indexOf(".")) == 5 ){
							intCondiCount = intCondiCount/1000;
						}
					}
					if (intSpecCount > 0 ){
						lngReturn = (long)((lngMinprice/intCondiCount)/intSpecCount);
					}			
				}
			}else if (strCondiName.equals("케이스") || strCondiName.equals("단품")){
				lngReturn = 0;
			}else{
				if (strCondiName.indexOf("G") > 0 ){
					strCondiCount = "";
					strCondiName = CutStr.cutStr(strCondiName,strCondiName.indexOf("G"));
					for (int i=0;i<strCondiName.length();i++){
						String strCharOne = strCondiName.substring(i,i+1);
						if (ChkNull.chkNumber(strCharOne)){
							strCondiCount = strCondiCount + strCharOne;
						}else if(strCharOne.equals(".")){
							strCondiCount = "";
							break;
						}
					}						
				}
				if (ChkNull.chkNumber(strCondiCount)){
					int intCondiCount = Integer.parseInt(strCondiCount);
					if (strCondiName.indexOf(".") >= 0 ){
						if ((strCondiName.length() - strCondiName.indexOf(".")) == 3 ){
							intCondiCount = intCondiCount/10;
						}else if ((strCondiName.length() - strCondiName.indexOf(".")) == 4 ){
							intCondiCount = intCondiCount/100;
						}else if ((strCondiName.length() - strCondiName.indexOf(".")) == 5 ){
							intCondiCount = intCondiCount/1000;
						}
					}					
					if (CutStr.cutStr(strCate,6).equals("031112")){
						intCondiCount = intCondiCount/100;
					}
					if (intSpecCount > 0 ){
						lngReturn = (long)((lngMinprice/intCondiCount)/intSpecCount);
					}			
				}
			}
		}else if(CutStr.cutStr(strCate,8).equals("16250109") || CutStr.cutStr(strCate,8).equals("16250308")){
			if (ChkNull.chkNumber(strCondiCount)){
				int intCondiCount = Integer.parseInt(strCondiCount);
				if (intSpecCount > 0 && intCondiCount > 0){
					lngReturn = (long)((lngMinprice/intCondiCount)/intSpecCount);
				}
			}
		}else if(CutStr.cutStr(strCate,8).equals("16140301") || CutStr.cutStr(strCate,8).equals("16140304") ||
			CutStr.cutStr(strCate,8).equals("16140305") || CutStr.cutStr(strCate,8).equals("16140306") ||
			CutStr.cutStr(strCate,8).equals("16140309") 
		){
			if ( CutStr.cutStr(strCate,8).equals("16140304") || CutStr.cutStr(strCate,8).equals("16140306") ||  CutStr.cutStr(strCate,8).equals("16140305")){
				strCondiCount = "";
				for (int i=1;i<strCondiName.length();i++){
					String strCharOne = strCondiName.substring(i,i+1);
					if (ChkNull.chkNumber(strCharOne)){
						strCondiCount = strCondiCount + strCharOne;
					}
				}
				intSpecCount = 1;
			}			
			if (CutStr.cutStr(strCate,8).equals("16140309")){
				intSpecCount = 1;
			}
			if (ChkNull.chkNumber(strCondiCount)){
				int intCondiCount = Integer.parseInt(strCondiCount);
				if (intSpecCount > 0 && intCondiCount > 0){
					if (strSpec.split("/") != null && strSpec.split("/").length > 0 ){
						String strCnt = strSpec.split("/")[1];
						if (strCnt.substring(strCnt.length()-1,strCnt.length()).equals("매")){
							if (ChkNull.chkNumber(CutStr.cutStr(strCnt,strCnt.length()-1))){
								if (Integer.parseInt(CutStr.cutStr(strCnt,strCnt.length()-1)) > 0){
									lngReturn = (long)((lngMinprice/intCondiCount)/intSpecCount*10/Integer.parseInt(CutStr.cutStr(strCnt,strCnt.length()-1))) ;
								}	
							}
						}else{
							lngReturn = (long)((lngMinprice/intCondiCount)/intSpecCount);
						}
					}else{
						lngReturn = (long)((lngMinprice/intCondiCount)/intSpecCount);
					}
				}
			}
		}else if(CutStr.cutStr(strCate,8).equals("10031201") || CutStr.cutStr(strCate,8).equals("16110901") || CutStr.cutStr(strCate,8).equals("16110902") 
			 || CutStr.cutStr(strCate,8).equals("10031108") || CutStr.cutStr(strCate,8).equals("10031102") || CutStr.cutStr(strCate,8).equals("10031202") || CutStr.cutStr(strCate,8).equals("16110903")
			 || CutStr.cutStr(strCate,8).equals("16111307") || ((CutStr.cutStr(strCate,6).equals("164002") && (strIndividualChangeUnit.toLowerCase().equals("ml") || strIndividualChangeUnit.toLowerCase().equals("g"))))
		 ) 
		{
			if (ChkNull.chkNumber(strCondiCount)){
				int intCondiCount = Integer.parseInt(strCondiCount);
				if (intSpecCount > 0 && intCondiCount > 0){
					lngReturn = (long)((lngMinprice/intCondiCount)/intSpecCount);
				}
			}
		}else if(CutStr.cutStr(strCate,6).equals("100316") || CutStr.cutStr(strCate,6).equals("160305") || CutStr.cutStr(strCate,6).equals("100317")){
			strCondiCount = "";
			if (strCondiName.indexOf(",") > 0 ){
				strCondiName = strCondiName.substring(strCondiName.indexOf(","),strCondiName.length());
			}
			for (int i=0;i<strCondiName.length();i++){
				String strCharOne = strCondiName.substring(i,i+1);
				if (ChkNull.chkNumber(strCharOne)){
					strCondiCount = strCondiCount + strCharOne;
				}
			}	
			if (CutStr.cutStr(strCate,8).equals("10031605")){
				strCondiCount = "1";
			}
			if (ChkNull.chkNumber(strCondiCount)){
				int intCondiCount = Integer.parseInt(strCondiCount);
				if (intSpecCount > 0 && intCondiCount > 0){
					lngReturn = (long)((lngMinprice/intCondiCount)/intSpecCount);
				}
			}		
		}else if(CutStr.cutStr(strCate,8).equals("16140804") || CutStr.cutStr(strCate,8).equals("16140806") || CutStr.cutStr(strCate,8).equals("16140808") || CutStr.cutStr(strCate,6).equals("161401") ||
				 CutStr.cutStr(strCate,8).equals("16140904") || CutStr.cutStr(strCate,8).equals("16140906") || CutStr.cutStr(strCate,8).equals("16140908") || CutStr.cutStr(strCate,8).equals("16140903") 
		){
			if (CutStr.cutStr(strCate,6).equals("161401") || CutStr.cutStr(strCate,8).equals("16140804") ||CutStr.cutStr(strCate,8).equals("16140806") || CutStr.cutStr(strCate,8).equals("16140808") ||
				CutStr.cutStr(strCate,8).equals("16140904") || CutStr.cutStr(strCate,8).equals("16140906") || CutStr.cutStr(strCate,8).equals("16140908") || CutStr.cutStr(strCate,8).equals("16140903") 
			){
				strCondiCount = "";
				if(strCondiName.indexOf("(")>-1){
					//for (int i=1;i<strCondiName.length();i++){
					//infolim 2012.05.31
					for (int i=strCondiName.indexOf("(");i<strCondiName.length();i++){
						String strCharOne = strCondiName.substring(i,i+1);
						if (ChkNull.chkNumber(strCharOne)){
							strCondiCount = strCondiCount + strCharOne;
						}
					}
				}
				intSpecCount = 1;
			}
			if (ChkNull.chkNumber(strCondiCount)){
				int intCondiCount = Integer.parseInt(strCondiCount);
				if (intSpecCount > 0 && intCondiCount > 0){
					String[] astrSpecs = strSpec.split("/");  
					if (astrSpecs != null && astrSpecs.length > 0 ){		
						String strLastUnit = astrSpecs[astrSpecs.length-1].substring(astrSpecs[astrSpecs.length-1].length()-1,astrSpecs[astrSpecs.length-1].length());
						if (strLastUnit.equals("롤")){						
							String strMiter = astrSpecs[1];
							if (strMiter.length() == 3){
								if (strMiter.substring(2,3).equals("m")){
									if (ChkNull.chkNumber(CutStr.cutStr(strMiter,2))){
										if (Integer.parseInt(CutStr.cutStr(strMiter,2)) > 0){
											lngReturn = (long)((lngMinprice/intCondiCount)/intSpecCount*10/Integer.parseInt(CutStr.cutStr(strMiter,2))) ;											
										}	
									}
								}else{
									lngReturn = (long)((lngMinprice/intCondiCount)/intSpecCount);
								}
							}else{
								lngReturn = (long)((lngMinprice/intCondiCount)/intSpecCount);
							}
						}else{
							lngReturn = (long)((lngMinprice/intCondiCount)/intSpecCount);
						}
					}else{
						lngReturn = (long)((lngMinprice/intCondiCount)/intSpecCount);
					}
				}
			}
		}else if(CutStr.cutStr(strCate,6).equals("120302")){
			if (strSpec.split("/") != null && strSpec.split("/").length > 0 ){
				String strCm = strSpec.split("/")[1];
				if (strCm.indexOf("(") > 0 ){
					strCm = CutStr.cutStr(strCm,strCm.indexOf("("));
					String strCm1 = "";
					for (int i=0;i<strCm.length();i++){
						String strCharOne = strCm.substring(i,i+1);
						if (ChkNull.chkNumber(strCharOne)){
							strCm1 = strCm1 + strCharOne;
						}
					}
					if (ChkNull.chkNumber(strCm1)){
						lngReturn = (long)((lngMinprice/1)*10/Integer.parseInt(strCm1)) ;
					}				
				}else{
					String strCm1 = "";
					for (int i=0;i<strCm.length();i++){
						String strCharOne = strCm.substring(i,i+1);
						if (ChkNull.chkNumber(strCharOne)){
							strCm1 = strCm1 + strCharOne;
						}
					}
					if (ChkNull.chkNumber(strCm1)){
						lngReturn = (long)((lngMinprice/1)*10/Integer.parseInt(strCm1)) ;
					}
				}
			}	
		}else if(CutStr.cutStr(strCate,8).equals("12020504") || CutStr.cutStr(strCate,8).equals("16110709") || CutStr.cutStr(strCate,8).equals("16110710") || CutStr.cutStr(strCate,8).equals("16110711")){
			if (ChkNull.chkNumber(strCondiCount)){
		 		lngReturn = (long)(((double)lngMinprice/Double.parseDouble(strCondiCount))*10);
		 	}
		}else if(CutStr.cutStr(strCate,8).equals("16360102") || CutStr.cutStr(strCate,8).equals("16360111") || CutStr.cutStr(strCate,8).equals("16360112") || CutStr.cutStr(strCate,8).equals("16360113") || CutStr.cutStr(strCate,8).equals("16360708")){
			if (strCondiName != null && strCondiName.trim().length() > 0 ){
				int intGcnt = 10;
				if (strCondiName.substring(strCondiName.length()-1,strCondiName.length()).equals("개")){
					if (ChkNull.chkNumber(strCondiCount)){
						lngReturn = (long)(((double)lngMinprice/Double.parseDouble(strCondiCount))/(double)intSpecCount*intGcnt);
					}				
				}else if(strCondiName.substring(strCondiName.length()-2,strCondiName.length()).equals("ml")){
					lngReturn = (long)(((double)lngMinprice/Double.parseDouble(strCondiCount))*intGcnt);
				}
			}
		}else if(CutStr.cutStr(strCate,6).equals("180301") || CutStr.cutStr(strCate,6).equals("180302") ||CutStr.cutStr(strCate,6).equals("180313") || CutStr.cutStr(strCate,6).equals("180312") || CutStr.cutStr(strCate,6).equals("180303")){
			if (intSpecCount > 0){
				int intGcnt = 10;
				lngReturn = (long)(((double)lngMinprice)/(double)intSpecCount*intGcnt);
			}
		}else if(CutStr.cutStr(strCate,6).equals("032103") || CutStr.cutStr(strCate,6).equals("180304") || CutStr.cutStr(strCate,6).equals("180305") || CutStr.cutStr(strCate,6).equals("180306") || CutStr.cutStr(strCate,8).equals("04020208")){
			if (ChkNull.chkNumber(strCondiCount)){
		 		lngReturn = (long)(((double)lngMinprice/Double.parseDouble(strCondiCount))*10);
		 	}
		}else if(CutStr.cutStr(strCate,6).equals("052604") || CutStr.cutStr(strCate,8).equals("05260302")){
			int intConiCnt = 0;
			String strCm1 = "";
			if (strCondiName.trim().length() > 0 && strCondiName.indexOf("(") >= 0){
				String strTemp1 = strCondiName.substring(strCondiName.indexOf("("),strCondiName.length());
				for (int j=0;j<strTemp1.length();j++){
					String strCharOne = strTemp1.substring(j,j+1);
					if (ChkNull.chkNumber(strCharOne)){
						strCm1 = strCm1 + strCharOne;
					}
				}
			}
			if (ChkNull.chkNumber(strCm1)){
				intConiCnt = intConiCnt + Integer.parseInt(strCm1);
				lngReturn = (long)((double)lngMinprice/intConiCnt);
			}
		}else if(CutStr.cutStr(strCate,8).equals("16321103")){
			if (strCondiName.indexOf("(") >= 0 ){
				strCondiCount = "";
				strCondiName = strCondiName.substring(strCondiName.indexOf("(")+1,strCondiName.length());
				for (int i=0;i<strCondiName.length();i++){
					String strCharOne = strCondiName.substring(i,i+1);
					if (ChkNull.chkNumber(strCharOne)){
						strCondiCount = strCondiCount + strCharOne;
					}
				}					
			}
			if (ChkNull.chkNumber(strCondiCount)){
				int intCondiCount = Integer.parseInt(strCondiCount);
				if (intCondiCount > 0 ){
					lngReturn = (long)((lngMinprice/intCondiCount));
				}
			}
		}else if (CutStr.cutStr(strCate,8).equals("16141101") || CutStr.cutStr(strCate,8).equals("16141103") || CutStr.cutStr(strCate,8).equals("16141102")){
			if (strCondiName.indexOf("(") >= 0 ){
				strCondiCount = "";
				strCondiName = strCondiName.substring(strCondiName.indexOf("(")+1,strCondiName.length());
				for (int i=0;i<strCondiName.length();i++){
					String strCharOne = strCondiName.substring(i,i+1);
					if (ChkNull.chkNumber(strCharOne)){
						strCondiCount = strCondiCount + strCharOne;
					}
				}					
			}
			if (ChkNull.chkNumber(strCondiCount)){
				int intCondiCount = Integer.parseInt(strCondiCount);
				if (intCondiCount > 0 ){
					lngReturn = (long)((lngMinprice/intCondiCount));
				}
			}			
		}else if( CutStr.cutStr(strCate,8).equals("16421315") || CutStr.cutStr(strCate,8).equals("16421318") || CutStr.cutStr(strCate,8).equals("16421323")){
			if (ChkNull.chkNumber(strCondiCount)){
				int intCondiCount = Integer.parseInt(strCondiCount);
				if (intSpecCount > 0 && intCondiCount > 0 ){
					lngReturn = (long)((lngMinprice/intCondiCount));
				}
			}		
		}else if(CutStr.cutStr(strCate,8).equals("16110905") || CutStr.cutStr(strCate,8).equals("16110907") || CutStr.cutStr(strCate,8).equals("18010607") || CutStr.cutStr(strCate,8).equals("16321303")){
			String strSpecUnit[] = strSpec.split("/");
			String strLastSpecUnit = "";			
			if (strSpecUnit != null && strSpecUnit.length > 0 ){
				if (strSpecUnit[strSpecUnit.length-1].indexOf("x") >= 0 ){
					String strTempSpecUnit[] = strSpecUnit[strSpecUnit.length-1].split("x");
					if (strTempSpecUnit != null && strTempSpecUnit.length > 0 ){
						strLastSpecUnit = strTempSpecUnit[1].trim();
					}
				}else{
					strLastSpecUnit = strSpecUnit[strSpecUnit.length-1].trim();
				}
				int intDot = 1;
				if (strLastSpecUnit.indexOf(".") >= 0 ){
					intDot = 10;
				}
				strLastSpecUnit = lastSpecReplace(strLastSpecUnit);
				String strSpecCount = "";
				if (strLastSpecUnit != null && strLastSpecUnit.trim().length() > 0 ){
					for (int i=0;i<strLastSpecUnit.length();i++){
						String strCharOne = strLastSpecUnit.substring(i,i+1);
						if (ChkNull.chkNumber(strCharOne)){
							strSpecCount = strSpecCount + strCharOne;
						}
					}
				}
				int intSpecCount16110905 = 0;
				int intCondiCount = 0;
				if (ChkNull.chkNumber(strSpecCount)){
					intSpecCount16110905 = Integer.parseInt(strSpecCount);
				}				
				if (ChkNull.chkNumber(strCondiCount)){
					intCondiCount = Integer.parseInt(strCondiCount);
				}			
				
				if (intSpecCount16110905 > 0 && intCondiCount > 0 ){
					if (intDot == 10 ){
						lngReturn = (long)(((double)lngMinprice/intCondiCount)*10/(double)(intSpecCount16110905));
					}else{
						lngReturn = (long)(((double)lngMinprice/intCondiCount)/(double)(intSpecCount16110905));
					}
					
				}							
			}
		}else if(bGetIndividualChangeUnitBySpec(strCate)){
			if (intSpecCount > 0 ){
				lngReturn = (long)(lngMinprice/intSpecCount);
			}
		}else if(CutStr.cutStr(strCate,6).equals("100303") ){
			if (strCondiName.indexOf(",") > 0 ){
				String strCondi1 = strCondiName.substring(strCondiName.indexOf(","),strCondiName.length());
				strCondiCount = "";
				for (int i=0;i<strCondi1.length();i++){
					String strCharOne = strCondi1.substring(i,i+1);
					if (ChkNull.chkNumber(strCharOne)){
						strCondiCount = strCondiCount + strCharOne;
					}
				}				
				if (ChkNull.chkNumber(strCondiCount)){
					int intCondiCount = Integer.parseInt(strCondiCount);
					if (intCondiCount > 0 ){
						lngReturn = (long)((lngMinprice/intCondiCount));
					}
				}	
			}else{
				if (ChkNull.chkNumber(strCondiCount)){
					int intCondiCount = Integer.parseInt(strCondiCount);
					if (intCondiCount > 0 ){
						lngReturn = (long)((lngMinprice/intCondiCount));
					}
				}	
			}
		}else if(CutStr.cutStr(strCate,6).equals("102502") || (CutStr.cutStr(strCate,6).equals("102504") && ! CutStr.cutStr(strCate,8).equals("10250402"))  || CutStr.cutStr(strCate,6).equals("102505") || CutStr.cutStr(strCate,8).equals("102508") ){
			if (strCondiName.indexOf(",") > 0 ){
				String strCondi1 = strCondiName.substring(strCondiName.indexOf(","),strCondiName.length());
				strCondiCount = "";
				for (int i=0;i<strCondi1.length();i++){
					String strCharOne = strCondi1.substring(i,i+1);
					if (ChkNull.chkNumber(strCharOne)){
						strCondiCount = strCondiCount + strCharOne;
					}
				}				
				if (ChkNull.chkNumber(strCondiCount)){
					int intCondiCount = Integer.parseInt(strCondiCount);
					if (intCondiCount > 0 ){
						lngReturn = (long)((lngMinprice/intCondiCount));
					}
				}	
			}else{
				if (ChkNull.chkNumber(strCondiCount)){
					int intCondiCount = Integer.parseInt(strCondiCount);
					if (intSpecCount > 0 && intCondiCount > 0 ){
						lngReturn = (long)((lngMinprice/intCondiCount)/intSpecCount);
					}
				}			
			}		
		}else if((CutStr.cutStr(strCate,4).equals("0810") && !CutStr.cutStr(strCate,6).equals("081004")) && strIndividualChangeUnit.toLowerCase().equals("ml")){
			strCondiName = ReplaceStr.replace(strCondiName,"테스터/","");
			strCondiName = ReplaceStr.replace(strCondiName,"신형,","");
			strCondiName = ReplaceStr.replace(strCondiName,"구형,","");
			if (ChkNull.chkNumber(CutStr.cutStr(strCondiName,1))){
				strCondiCount = "";
				for (int i=0;i<strCondiName.length();i++){
					String strCharOne = strCondiName.substring(i,i+1);
					if (ChkNull.chkNumber(strCharOne)){
						strCondiCount = strCondiCount + strCharOne;
					}else if(strCharOne.equals(".")){
						strCondiCount = "";
						break;
					}
				}	
				if (ChkNull.chkNumber(strCondiCount)){
					double intCondiCount = Double.parseDouble(strCondiCount);
					if (intCondiCount > 9 ){
						//lngReturn = (long)(((double)lngMinprice/Double.parseDouble(strCondiCount))/(double)intSpecCount*intGcnt);
						lngReturn = (long)(((double)lngMinprice)/(double)(intCondiCount/10));
					}				
				}
			}
			if (strCondiName.trim().indexOf("미니어처") >= 0){
				lngReturn = 0;
			}						
		}else if((CutStr.cutStr(strCate,6).equals("122609") || CutStr.cutStr(strCate,6).equals("102503") || CutStr.cutStr(strCate,8).equals("16351303") || CutStr.cutStr(strCate,8).equals("16351301") || CutStr.cutStr(strCate,8).equals("21451303") || CutStr.cutStr(strCate,8).equals("21451301")) && strIndividualChangeUnit.toLowerCase().equals("ml")){
			if (ChkNull.chkNumber(CutStr.cutStr(strCondiName,1))){
				int intGcnt = 1;
				if (strCondiName.substring(strCondiName.length()-1,strCondiName.length()).equals("L")) {
					intGcnt = 1000;
				}
				strCondiCount = "";
				for (int i=0;i<strCondiName.length();i++){
					String strCharOne = strCondiName.substring(i,i+1);
					if (ChkNull.chkNumber(strCharOne) || strCharOne.equals(".") ){
						strCondiCount = strCondiCount + strCharOne;
					}
				}	
				double intCondiCount = Double.parseDouble(strCondiCount);
				lngReturn = (long)(((double)lngMinprice)/(double)(intCondiCount*intGcnt/100));
			}
		}else if(CutStr.cutStr(strCate,6).equals("101108") || CutStr.cutStr(strCate,6).equals("101109") || CutStr.cutStr(strCate,6).trim().equals("101111") || CutStr.cutStr(strCate,6).equals("101110") || 
				CutStr.cutStr(strCate,6).equals("101112") || CutStr.cutStr(strCate,6).equals("101117")  || CutStr.cutStr(strCate,6).equals("101114") || CutStr.cutStr(strCate,6).equals("101118") ){
			if (strCondiName.indexOf(",") > 0 ){
				strCondiName = strCondiName.substring(strCondiName.indexOf(","),strCondiName.length());
			}	
			strCondiCount = "";
			for (int i=0;i<strCondiName.length();i++){
				String strCharOne = strCondiName.substring(i,i+1);
				if (ChkNull.chkNumber(strCharOne)){
					strCondiCount = strCondiCount + strCharOne;
				}
			}		
			if (ChkNull.chkNumber(strCondiCount)){
				int intCondiCount = Integer.parseInt(strCondiCount);
				if (intSpecCount > 0 && intCondiCount > 0 ){
					lngReturn = (long)((lngMinprice/intCondiCount)/intSpecCount);
				}
			}					
		}else if(CutStr.cutStr(strCate,6).equals("080214") || CutStr.cutStr(strCate,8).equals("05152103") || CutStr.cutStr(strCate,8).equals("16421012")){
			if (strCondiName.indexOf("(") > 0 ){
				strCondiName = strCondiName.substring(0,strCondiName.indexOf("("));
			}	
			strCondiCount = "";
			for (int i=0;i<strCondiName.length();i++){
				String strCharOne = strCondiName.substring(i,i+1);
				if (ChkNull.chkNumber(strCharOne)){
					strCondiCount = strCondiCount + strCharOne;
				}
			}		
			if (ChkNull.chkNumber(strCondiCount)){
				int intCondiCount = Integer.parseInt(strCondiCount);
				if (intSpecCount > 0 && intCondiCount > 0 ){
					lngReturn = (long)((lngMinprice/intCondiCount)/intSpecCount);
				}
			}	
		}else if((CutStr.cutStr(strCate,4).equals("0805") && !CutStr.cutStr(strCate,6).equals("080504"))){
			strCondiCount = "";
			if (strCondiName != null && strCondiName.trim().length() > 0 ){
				if (strCondiName.substring(strCondiName.length()-1,strCondiName.length()).equals("개")){
					if (strCondiName.indexOf("x") >= 0 ){
						String strCondiName2 = strCondiName.substring(strCondiName.indexOf("x"),strCondiName.length());
						for (int i=0;i<strCondiName2.length();i++){
							String strCharOne = strCondiName2.substring(i,i+1);
							if (ChkNull.chkNumber(strCharOne)){
								strCondiCount = strCondiCount + strCharOne;
							}
						}							
					}else{
						for (int i=0;i<strCondiName.length();i++){
							String strCharOne = strCondiName.substring(i,i+1);
							if (ChkNull.chkNumber(strCharOne)){
								strCondiCount = strCondiCount + strCharOne;
							}
						}
						if (strCondiCount.trim().length() == 0){
							if (strCondiName.indexOf("리필") >= 0){
								strCondiCount = "1";
							}
						}  							
					}
				}
				if (ChkNull.chkNumber(strCondiCount)){
					int intCondiCount = Integer.parseInt(strCondiCount);
					if (intSpecCount > 0 && intCondiCount > 0 ){
						lngReturn = (long)((lngMinprice/intCondiCount)/intSpecCount);
					}
				}					
			}
		}else if(CutStr.cutStr(strCate,8).equals("16290502")){
			strCondiCount = "";
			if (strCondiName != null && strCondiName.trim().length() > 0 ){
				if (strCondiName.substring(strCondiName.length()-1,strCondiName.length()).equals("개")){
					if (strCondiName.indexOf("x") >= 0 ){
						String strCondiName2 = strCondiName.substring(strCondiName.indexOf("x"),strCondiName.length());
						for (int i=0;i<strCondiName2.length();i++){
							String strCharOne = strCondiName2.substring(i,i+1);
							if (ChkNull.chkNumber(strCharOne)){
								strCondiCount = strCondiCount + strCharOne;
							}
						}							
					}else{
						for (int i=0;i<strCondiName.length();i++){
							String strCharOne = strCondiName.substring(i,i+1);
							if (ChkNull.chkNumber(strCharOne)){
								strCondiCount = strCondiCount + strCharOne;
							}
						}						
					}
				}
				if (ChkNull.chkNumber(strCondiCount)){
					int intCondiCount = Integer.parseInt(strCondiCount);
					if (intSpecCount > 0 && intCondiCount > 0 ){
						lngReturn = (long)((lngMinprice/intCondiCount)/intSpecCount);
					}
				}					
			}
		}else if(CutStr.cutStr(strCate,6).trim().equals("101209") || CutStr.cutStr(strCate,6).trim().equals("101210") || CutStr.cutStr(strCate,6).equals("093006")){
			if (strCondiName != null && strCondiName.trim().length() > 0 ){
				strCondiCount = "";
				//if (strCondiName.substring(strCondiName.length()-1,strCondiName.length()).equals("개") || strCondiName.substring(strCondiName.length()-1,strCondiName.length()).equals("장")){
				if (strCondiName.substring(strCondiName.length()-1,strCondiName.length()).equals("장")){
					if (strCondiName.indexOf(",") >= 0 ){
						String strCondiName2 = strCondiName.substring(strCondiName.indexOf(",")+1,strCondiName.length()).trim();
						for (int i=0;i<strCondiName2.length();i++){
							String strCharOne = strCondiName2.substring(i,i+1);
							if (ChkNull.chkNumber(strCharOne)){
								strCondiCount = strCondiCount + strCharOne;
							}
						}							
					}
				}
				if (ChkNull.chkNumber(strCondiCount)){
					int intCondiCount = Integer.parseInt(strCondiCount);
					if (intCondiCount > 0 ){
						lngReturn = (long)((lngMinprice/intCondiCount));
					}
				}					
			}
		}else if(CutStr.cutStr(strCate,8).equals("16051504")){
			int intCondiCount = 1;
			int intSpecCount16051504 = 1;
			if (strCondiName.indexOf("개") >= 0){
				String strSpecUnit[] = strSpec.split("/");
				String strLastSpecUnit = "";			
				if (strSpecUnit != null && strSpecUnit.length > 1 ){
					strLastSpecUnit = strSpecUnit[1].trim();
					strLastSpecUnit = lastSpecReplace(strLastSpecUnit);
					if (strLastSpecUnit.indexOf("(") >= 0 ){
						strLastSpecUnit = CutStr.cutStr(strLastSpecUnit,strLastSpecUnit.indexOf("("));
					}
					String strSpecCount = "";
					if (strLastSpecUnit != null && strLastSpecUnit.trim().length() > 0 ){
						for (int i=0;i<strLastSpecUnit.length();i++){
							String strCharOne = strLastSpecUnit.substring(i,i+1);
							if (ChkNull.chkNumber(strCharOne)){
								strSpecCount = strSpecCount + strCharOne;
							}
						}
					}
					if (ChkNull.chkNumber(strSpecCount)){
						intSpecCount16051504 = Integer.parseInt(strSpecCount);
					}
				}	
			}
			if (ChkNull.chkNumber(strCondiCount)){
				intCondiCount = Integer.parseInt(strCondiCount);
			}			
			if (intSpecCount16051504 > 0 && intCondiCount > 0 ){
				lngReturn = (long)(((double)lngMinprice/intCondiCount)/(double)intSpecCount16051504*10);
			}			
		}else if(CutStr.cutStr(strCate,8).equals("16110802")){
			if (strCondiName.indexOf("(") > 0 && strCondiName.indexOf(")") > 0){
				strCondiName = strCondiName.substring(strCondiName.indexOf("("),strCondiName.indexOf(")"));
			}	
			strCondiCount = "";
			for (int i=0;i<strCondiName.length();i++){
				String strCharOne = strCondiName.substring(i,i+1);
				if (ChkNull.chkNumber(strCharOne)){
					strCondiCount = strCondiCount + strCharOne;
				}
			}		
			if (ChkNull.chkNumber(strCondiCount)){
				int intCondiCount = Integer.parseInt(strCondiCount);
				if (intSpecCount > 0 && intCondiCount > 0 ){
					lngReturn = (long)((lngMinprice/intCondiCount)/intSpecCount);
				}
			}	
		}else if(CutStr.cutStr(strCate,8).equals("12261002") || CutStr.cutStr(strCate,8).equals("12261003") || CutStr.cutStr(strCate,8).equals("16351312") || CutStr.cutStr(strCate,8).equals("21451312") || CutStr.cutStr(strCate,6).equals("122611")){
			if (strCondiName.indexOf(")") > 0){
				strCondiName = strCondiName.substring(strCondiName.indexOf(")"),strCondiName.length());
			}
			strCondiCount = "";
			for (int i=0;i<strCondiName.length();i++){
				String strCharOne = strCondiName.substring(i,i+1);
				if (ChkNull.chkNumber(strCharOne)){
					strCondiCount = strCondiCount + strCharOne;
				}
			}							
			if (ChkNull.chkNumber(strCondiCount)){
				int intCondiCount = Integer.parseInt(strCondiCount);
				int intDot = 1;
				if (strCondiName.indexOf(".") >= 0 ){
					if ((strCondiName.length() - strCondiName.indexOf(".")) == 3 ){
						intDot = 10;
					}else if ((strCondiName.length() - strCondiName.indexOf(".")) == 4 ){
						intDot = 100;
					}else if ((strCondiName.length() - strCondiName.indexOf(".")) == 5 ){
						intDot = 1000;
					}
				}					
				lngReturn = (long)(((double)lngMinprice/intCondiCount*intDot)/(double)intSpecCount);
				
							
			}	
		}else{
			if (ChkNull.chkNumber(strCondiCount)){
				int intCondiCount = Integer.parseInt(strCondiCount);
				if (CutStr.cutStr(strCate,6).equals("031112")){
					intCondiCount = intCondiCount/100;
				}
				if (intSpecCount > 0 && intCondiCount > 0 ){
					lngReturn = (long)((lngMinprice/intCondiCount)/intSpecCount);
				}
			}
		}
		if (strCondiName.equals("리퍼") || strCondiName.equals("전시") || strCondiName.equals("옵션필수") || strCondiName.indexOf("정기배송") >= 0 ){
			lngReturn = 0;
		}
		if (CutStr.cutStr(strCate,2).equals("08")){
			if (strCondiName.indexOf("구매대행") >= 0 || strCondiName.indexOf("해외쇼핑") >= 0){
				lngReturn = 0;
			}
		}	
		return lngReturn;
	}
	private String getIndividualChangeUnit(String strIndividualChangeUnit,String strCa_code ){
		if (CutStr.cutStr(strCa_code,4).equals("1625") || CutStr.cutStr(strCa_code,4).equals("1501") || CutStr.cutStr(strCa_code,6).equals("151301") ||  
			(CutStr.cutStr(strCa_code,6).equals("151004") && !CutStr.cutStr(strCa_code,8).equals("15100406") ) ||  CutStr.cutStr(strCa_code,8).equals("15050916") ||  
			CutStr.cutStr(strCa_code,8).equals("15100210") || CutStr.cutStr(strCa_code,8).equals("15051001") || 
			CutStr.cutStr(strCa_code,6).equals("150202") || CutStr.cutStr(strCa_code,8).equals("15090219") || 
			CutStr.cutStr(strCa_code,6).equals("150602")  || CutStr.cutStr(strCa_code,8).equals("15010508") ||  
			(CutStr.cutStr(strCa_code,6).equals("150205") && !CutStr.cutStr(strCa_code,8).equals("15020505")) || CutStr.cutStr(strCa_code,8).equals("15090101") || CutStr.cutStr(strCa_code,8).equals("15090105") || 
			CutStr.cutStr(strCa_code,6).equals("150704") || CutStr.cutStr(strCa_code,6).equals("150705") || CutStr.cutStr(strCa_code,6).equals("164213") || 
			CutStr.cutStr(strCa_code,6).equals("150706") || CutStr.cutStr(strCa_code,6).equals("150707") || CutStr.cutStr(strCa_code,6).equals("164216") || CutStr.cutStr(strCa_code,6).equals("159801") ||
			(CutStr.cutStr(strCa_code,6).equals("150203") && !CutStr.cutStr(strCa_code,8).equals("15020308") ) || CutStr.cutStr(strCa_code,8).equals("15090126") ||  
			CutStr.cutStr(strCa_code,6).trim().equals("032403") || CutStr.cutStr(strCa_code,8).equals("15090102") || CutStr.cutStr(strCa_code,8).equals("15090103") || CutStr.cutStr(strCa_code,8).equals("15090104") || 
			CutStr.cutStr(strCa_code,8).equals("15050104") || CutStr.cutStr(strCa_code,8).equals("15050105") || 
			CutStr.cutStr(strCa_code,8).equals("15030304") || CutStr.cutStr(strCa_code,8).equals("15030401") || CutStr.cutStr(strCa_code,8).equals("15030402") || CutStr.cutStr(strCa_code,8).equals("15030403") || 
			CutStr.cutStr(strCa_code,6).equals("150601") ||
			CutStr.cutStr(strCa_code,8).equals("15050128") || CutStr.cutStr(strCa_code,8).equals("15050129") || CutStr.cutStr(strCa_code,8).equals("15050130") || CutStr.cutStr(strCa_code,8).equals("15050131") ||
			CutStr.cutStr(strCa_code,8).equals("15090202") || CutStr.cutStr(strCa_code,8).equals("15030601") || CutStr.cutStr(strCa_code,8).equals("15090201") || CutStr.cutStr(strCa_code,8).equals("15030602") || 
			CutStr.cutStr(strCa_code,8).equals("15030631") || CutStr.cutStr(strCa_code,8).equals("15030632") || CutStr.cutStr(strCa_code,8).equals("15030634") ||
			CutStr.cutStr(strCa_code,8).equals("15030604") || CutStr.cutStr(strCa_code,8).equals("15030606") || CutStr.cutStr(strCa_code,8).equals("15090203") || CutStr.cutStr(strCa_code,8).equals("15090204") || 
			CutStr.cutStr(strCa_code,8).equals("15090404") || CutStr.cutStr(strCa_code,8).equals("15090405") || CutStr.cutStr(strCa_code,8).equals("15030103") || CutStr.cutStr(strCa_code,8).equals("15030108") || 
			(CutStr.cutStr(strCa_code,6).equals("150302") && !CutStr.cutStr(strCa_code,8).equals("15030214") ) || CutStr.cutStr(strCa_code,6).equals("151302") || CutStr.cutStr(strCa_code,6).equals("151303") || 
			CutStr.cutStr(strCa_code,6).equals("151304") || CutStr.cutStr(strCa_code,6).equals("151305") || CutStr.cutStr(strCa_code,6).equals("151306") || CutStr.cutStr(strCa_code,8).equals("15060406") ||
			CutStr.cutStr(strCa_code,8).equals("15060401") || CutStr.cutStr(strCa_code,8).equals("15060403") || CutStr.cutStr(strCa_code,8).equals("15060408") || 
			CutStr.cutStr(strCa_code,8).equals("15100301") || CutStr.cutStr(strCa_code,8).equals("15100302") || CutStr.cutStr(strCa_code,8).equals("15100305") || CutStr.cutStr(strCa_code,8).equals("15100310") ||
			CutStr.cutStr(strCa_code,8).equals("15100313") || CutStr.cutStr(strCa_code,8).equals("15100309") ||	CutStr.cutStr(strCa_code,8).equals("15100311") || CutStr.cutStr(strCa_code,8).equals("15100316") || 		  			  
			CutStr.cutStr(strCa_code,8).equals("15100304") || CutStr.cutStr(strCa_code,8).equals("15100306") ||	CutStr.cutStr(strCa_code,8).equals("15090415") || CutStr.cutStr(strCa_code,8).equals("15020216") ||
			CutStr.cutStr(strCa_code,8).equals("15090409") || CutStr.cutStr(strCa_code,8).equals("15010601") || CutStr.cutStr(strCa_code,8).equals("15010602") || CutStr.cutStr(strCa_code,8).equals("15010608") ||
			CutStr.cutStr(strCa_code,8).equals("15040401") || CutStr.cutStr(strCa_code,8).equals("15040402") ||	CutStr.cutStr(strCa_code,8).equals("15040403") || CutStr.cutStr(strCa_code,8).equals("15040404") ||
			CutStr.cutStr(strCa_code,6).equals("150606") || (CutStr.cutStr(strCa_code,6).equals("150407") && !CutStr.cutStr(strCa_code,8).equals("15040705")) || CutStr.cutStr(strCa_code,8).equals("15040421") ||
			CutStr.cutStr(strCa_code,8).equals("15080508") || CutStr.cutStr(strCa_code,8).equals("15080509") ||	CutStr.cutStr(strCa_code,8).equals("15040603") || 
			CutStr.cutStr(strCa_code,8).equals("15080207") || CutStr.cutStr(strCa_code,6).equals("150208") || CutStr.cutStr(strCa_code,6).equals("150209")  || CutStr.cutStr(strCa_code,8).equals("15040419") ||
			CutStr.cutStr(strCa_code,8).equals("15020217") || CutStr.cutStr(strCa_code,8).equals("15070510") || CutStr.cutStr(strCa_code,8).equals("15020509") || CutStr.cutStr(strCa_code,8).equals("15020511") ||
			CutStr.cutStr(strCa_code,8).equals("15080207") || CutStr.cutStr(strCa_code,8).equals("15050106") ||	CutStr.cutStr(strCa_code,8).equals("15090212") || CutStr.cutStr(strCa_code,8).equals("15050101") ||
			CutStr.cutStr(strCa_code,6).equals("150708")   || CutStr.cutStr(strCa_code,8).equals("15040302") ||	
			CutStr.cutStr(strCa_code,8).equals("15040405") || CutStr.cutStr(strCa_code,8).equals("15040408") ||  
			CutStr.cutStr(strCa_code,8).equals("15080509") || CutStr.cutStr(strCa_code,8).equals("15081001") ||	CutStr.cutStr(strCa_code,8).equals("15081002") || 																					 
			CutStr.cutStr(strCa_code,8).equals("15090501") || CutStr.cutStr(strCa_code,8).equals("15090502") ||
			CutStr.cutStr(strCa_code,8).equals("15090503") || CutStr.cutStr(strCa_code,8).equals("15090504") || CutStr.cutStr(strCa_code,8).equals("15090505") || CutStr.cutStr(strCa_code,8).equals("15090112") ||
			CutStr.cutStr(strCa_code,8).equals("15090412") || CutStr.cutStr(strCa_code,8).equals("15070809") ||	CutStr.cutStr(strCa_code,8).equals("15070810") || CutStr.cutStr(strCa_code,8).equals("15070811") || 
			CutStr.cutStr(strCa_code,8).equals("15070812") || CutStr.cutStr(strCa_code,8).equals("15070813") ||	CutStr.cutStr(strCa_code,8).equals("15050121") || CutStr.cutStr(strCa_code,8).equals("15050122") ||
			CutStr.cutStr(strCa_code,8).equals("15050123") || CutStr.cutStr(strCa_code,8).equals("15050124") ||	CutStr.cutStr(strCa_code,8).equals("15050125") || CutStr.cutStr(strCa_code,8).equals("15050126") ||
			CutStr.cutStr(strCa_code,8).equals("15100308") || CutStr.cutStr(strCa_code,6).equals("150207")   || CutStr.cutStr(strCa_code,6).equals("150204") ||		
			CutStr.cutStr(strCa_code,8).equals("15030303") || CutStr.cutStr(strCa_code,8).equals("15030306") ||	CutStr.cutStr(strCa_code,8).equals("15030603") || CutStr.cutStr(strCa_code,8).equals("15030608") || 
			CutStr.cutStr(strCa_code,8).equals("15030609") || CutStr.cutStr(strCa_code,8).equals("15030610") ||	CutStr.cutStr(strCa_code,8).equals("15030611") || CutStr.cutStr(strCa_code,8).equals("15030612") || 
			CutStr.cutStr(strCa_code,8).equals("15030613") || CutStr.cutStr(strCa_code,8).equals("15030614") ||	CutStr.cutStr(strCa_code,8).equals("15030615") || CutStr.cutStr(strCa_code,8).equals("15030616") || 
			CutStr.cutStr(strCa_code,8).equals("15030618") || CutStr.cutStr(strCa_code,8).equals("15030619") ||	CutStr.cutStr(strCa_code,8).equals("15030621") || CutStr.cutStr(strCa_code,8).equals("15030623") || 
			CutStr.cutStr(strCa_code,8).equals("15030627") || CutStr.cutStr(strCa_code,8).equals("15030622") ||	CutStr.cutStr(strCa_code,8).equals("16360102") || CutStr.cutStr(strCa_code,8).equals("15030301") ||
			CutStr.cutStr(strCa_code,8).equals("15100203") || (CutStr.cutStr(strCa_code,6).equals("150307") && !CutStr.cutStr(strCa_code,8).equals("15030715"))	 ||	CutStr.cutStr(strCa_code,8).equals("15030310") || 
			CutStr.cutStr(strCa_code,8).equals("21081301") ||	CutStr.cutStr(strCa_code,8).equals("21081302") || CutStr.cutStr(strCa_code,8).equals("21081303") || 
			CutStr.cutStr(strCa_code,8).equals("21081304") || CutStr.cutStr(strCa_code,8).equals("21081305") ||	CutStr.cutStr(strCa_code,8).equals("21081310") || CutStr.cutStr(strCa_code,8).equals("21081311") || 
			CutStr.cutStr(strCa_code,8).equals("21081312") || CutStr.cutStr(strCa_code,8).equals("15030302") ||	CutStr.cutStr(strCa_code,8).equals("15100107") || CutStr.cutStr(strCa_code,8).equals("15090511") ||
			CutStr.cutStr(strCa_code,8).equals("15090122") || CutStr.cutStr(strCa_code,8).equals("15090113") ||	CutStr.cutStr(strCa_code,8).equals("15090123") || CutStr.cutStr(strCa_code,8).equals("15090112") ||
			CutStr.cutStr(strCa_code,8).equals("15090119") || CutStr.cutStr(strCa_code,8).equals("15090121") ||	CutStr.cutStr(strCa_code,8).equals("15090701") || CutStr.cutStr(strCa_code,8).equals("15090702") ||
			CutStr.cutStr(strCa_code,8).equals("15090703") || CutStr.cutStr(strCa_code,8).equals("15090704") ||	CutStr.cutStr(strCa_code,8).equals("15090705") || CutStr.cutStr(strCa_code,8).equals("15090706") ||
			CutStr.cutStr(strCa_code,8).equals("15090707") || CutStr.cutStr(strCa_code,8).equals("15090708") ||	
			CutStr.cutStr(strCa_code,8).equals("15030111") || CutStr.cutStr(strCa_code,8).equals("15030112") ||	CutStr.cutStr(strCa_code,6).equals("122609") || CutStr.cutStr(strCa_code,6).equals("102503") ||
			CutStr.cutStr(strCa_code,6).equals("151103") || CutStr.cutStr(strCa_code,6).equals("151003") || CutStr.cutStr(strCa_code,6).equals("151007") || CutStr.cutStr(strCa_code,6).equals("151008") ||
			CutStr.cutStr(strCa_code,6).equals("150111") || CutStr.cutStr(strCa_code,6).equals("150112") ||  CutStr.cutStr(strCa_code,8).equals("10030102") || CutStr.cutStr(strCa_code,8).equals("10030103") ||
			CutStr.cutStr(strCa_code,6).equals("159802") || CutStr.cutStr(strCa_code,6).equals("159803") || CutStr.cutStr(strCa_code,6).equals("159804") || 
			CutStr.cutStr(strCa_code,8).equals("15980501") || CutStr.cutStr(strCa_code,8).equals("15980502") || CutStr.cutStr(strCa_code,8).equals("15980503") || CutStr.cutStr(strCa_code,8).equals("15980505") ||
			CutStr.cutStr(strCa_code,8).equals("15980507") || CutStr.cutStr(strCa_code,8).equals("15980508") || CutStr.cutStr(strCa_code,8).equals("15980510") || CutStr.cutStr(strCa_code,8).equals("15980504") || 
			CutStr.cutStr(strCa_code,8).equals("15980506") || CutStr.cutStr(strCa_code,8).equals("16360111") || CutStr.cutStr(strCa_code,8).equals("16360112") || CutStr.cutStr(strCa_code,8).equals("16360113") ||
			CutStr.cutStr(strCa_code,8).equals("16360707") || CutStr.cutStr(strCa_code,8).equals("16360708") || CutStr.cutStr(strCa_code,8).equals("15090102") || CutStr.cutStr(strCa_code,8).equals("15090101") || 
			CutStr.cutStr(strCa_code,8).equals("15090103") || CutStr.cutStr(strCa_code,8).equals("15090104") ||  
			CutStr.cutStr(strCa_code,6).equals("150905") || CutStr.cutStr(strCa_code,6).equals("150909") || CutStr.cutStr(strCa_code,6).equals("150907") || CutStr.cutStr(strCa_code,6).equals("150902") ||
			CutStr.cutStr(strCa_code,8).equals("15090123") || CutStr.cutStr(strCa_code,8).equals("15090112") || CutStr.cutStr(strCa_code,8).equals("15090125") ||
			(CutStr.cutStr(strCa_code,6).equals("150308") && !CutStr.cutStr(strCa_code,8).equals("15030805")) || CutStr.cutStr(strCa_code,8).equals("21081315") || CutStr.cutStr(strCa_code,8).equals("21081316") || CutStr.cutStr(strCa_code,8).equals("21081317") ||
			CutStr.cutStr(strCa_code,8).equals("21081318") || CutStr.cutStr(strCa_code,8).equals("21081319") || CutStr.cutStr(strCa_code,8).equals("21081320") || 
			CutStr.cutStr(strCa_code,8).equals("10030102") || CutStr.cutStr(strCa_code,8).equals("10030103") || CutStr.cutStr(strCa_code,8).equals("10030104") || CutStr.cutStr(strCa_code,6).equals("100301") ||
			CutStr.cutStr(strCa_code,8).equals("10120303") || CutStr.cutStr(strCa_code,8).equals("10120304") || CutStr.cutStr(strCa_code,8).equals("10120305") || CutStr.cutStr(strCa_code,8).equals("10120315") ||
			CutStr.cutStr(strCa_code,8).equals("10120306") || CutStr.cutStr(strCa_code,8).equals("10120308") || CutStr.cutStr(strCa_code,8).equals("10120309") || CutStr.cutStr(strCa_code,4).equals("0806") || 
			CutStr.cutStr(strCa_code,8).equals("16051504")	|| CutStr.cutStr(strCa_code,6).equals("151102") ||  CutStr.cutStr(strCa_code,8).equals("15030628") || CutStr.cutStr(strCa_code,8).equals("15030626") ||  
			CutStr.cutStr(strCa_code,6).equals("151103")  || CutStr.cutStr(strCa_code,8).equals("15100322") || CutStr.cutStr(strCa_code,8).equals("10120307") || CutStr.cutStr(strCa_code,8).equals("21150506") ||
			CutStr.cutStr(strCa_code,8).equals("15100803") || CutStr.cutStr(strCa_code,8).equals("15100804") || CutStr.cutStr(strCa_code,8).equals("15100805") || CutStr.cutStr(strCa_code,8).equals("15100106") || 
			CutStr.cutStr(strCa_code,8).equals("15100806") || CutStr.cutStr(strCa_code,8).equals("15100323") || CutStr.cutStr(strCa_code,8).equals("15100328") ||
			CutStr.cutStr(strCa_code,8).equals("15100326") || CutStr.cutStr(strCa_code,8).equals("15100329") || CutStr.cutStr(strCa_code,8).equals("15100407") ||
			CutStr.cutStr(strCa_code,8).equals("15100321") || CutStr.cutStr(strCa_code,8).equals("15100322") || CutStr.cutStr(strCa_code,8).equals("15060210") ||
			CutStr.cutStr(strCa_code,6).equals("150101") || CutStr.cutStr(strCa_code,6).equals("150102") || CutStr.cutStr(strCa_code,6).equals("150103") || CutStr.cutStr(strCa_code,6).equals("150104") || 
			CutStr.cutStr(strCa_code,6).equals("150105") || CutStr.cutStr(strCa_code,6).equals("150107") || CutStr.cutStr(strCa_code,6).equals("150108") ||
			CutStr.cutStr(strCa_code,6).equals("150111") || CutStr.cutStr(strCa_code,6).equals("150112") || 
			CutStr.cutStr(strCa_code,8).equals("15080508") || CutStr.cutStr(strCa_code,8).equals("15040309") || CutStr.cutStr(strCa_code,8).equals("15040310") || CutStr.cutStr(strCa_code,8).equals("15060405") ||
			(CutStr.cutStr(strCa_code,6).equals("150501") && !CutStr.cutStr(strCa_code,8).equals("15050112")) || (CutStr.cutStr(strCa_code,6).equals("150504") && !CutStr.cutStr(strCa_code,8).equals("15050408") && !CutStr.cutStr(strCa_code,8).equals("15050420")) || 
			(CutStr.cutStr(strCa_code,6).equals("150502") && !CutStr.cutStr(strCa_code,8).equals("15050208")) || (CutStr.cutStr(strCa_code,6).equals("150507") && !CutStr.cutStr(strCa_code,8).equals("15050704")) ||
			CutStr.cutStr(strCa_code,8).equals("15070115") || CutStr.cutStr(strCa_code,8).equals("15060407") || CutStr.cutStr(strCa_code,8).equals("15070409") || CutStr.cutStr(strCa_code,8).equals("15070609") ||
			CutStr.cutStr(strCa_code,8).equals("15070610") || CutStr.cutStr(strCa_code,8).equals("15070611") || CutStr.cutStr(strCa_code,8).equals("15070612") || CutStr.cutStr(strCa_code,8).equals("15070613") ||
			(CutStr.cutStr(strCa_code,4).equals("0812") && !CutStr.cutStr(strCa_code,6).equals("081203") && !CutStr.cutStr(strCa_code,8).equals("08120603") && !CutStr.cutStr(strCa_code,8).equals("08120408")) ||
			CutStr.cutStr(strCa_code,6).equals("150309") || ( CutStr.cutStr(strCa_code,6).equals("150310") && !CutStr.cutStr(strCa_code,8).equals("15031006")) || CutStr.cutStr(strCa_code,6).equals("150311")	||
			CutStr.cutStr(strCa_code,6).equals("150401") || CutStr.cutStr(strCa_code,6).equals("150402") ||  CutStr.cutStr(strCa_code,8).equals("15040409") || 
			CutStr.cutStr(strCa_code,8).equals("15130213") || CutStr.cutStr(strCa_code,8).equals("15130214") || CutStr.cutStr(strCa_code,8).equals("15130215") || CutStr.cutStr(strCa_code,8).equals("15130509") ||
			CutStr.cutStr(strCa_code,8).equals("15040415") || CutStr.cutStr(strCa_code,8).equals("15040416") || CutStr.cutStr(strCa_code,8).equals("15040417") || CutStr.cutStr(strCa_code,8).equals("15040418") ||
			CutStr.cutStr(strCa_code,6).equals("100501") || CutStr.cutStr(strCa_code,8).equals("10050201") || CutStr.cutStr(strCa_code,8).equals("10050204") || CutStr.cutStr(strCa_code,6).equals("100508") ||
			CutStr.cutStr(strCa_code,6).equals("100511") || CutStr.cutStr(strCa_code,6).equals("100512") || CutStr.cutStr(strCa_code,6).equals("100513") || CutStr.cutStr(strCa_code,6).equals("100514") ||
			CutStr.cutStr(strCa_code,6).equals("100515") || CutStr.cutStr(strCa_code,6).equals("100516") || (CutStr.cutStr(strCa_code,6).equals("151012") && ! CutStr.cutStr(strCa_code,8).equals("15101206")) || 
			CutStr.cutStr(strCa_code,6).equals("151104") || CutStr.cutStr(strCa_code,6).equals("151011") || CutStr.cutStr(strCa_code,8).equals("15100703") || CutStr.cutStr(strCa_code,8).equals("15100704") || 
			CutStr.cutStr(strCa_code,8).equals("15100705") || CutStr.cutStr(strCa_code,8).equals("16420901") || CutStr.cutStr(strCa_code,8).equals("16421002") ||
			CutStr.cutStr(strCa_code,6).equals("210812") || CutStr.cutStr(strCa_code,8).equals("21080201") || CutStr.cutStr(strCa_code,8).equals("21080203") || CutStr.cutStr(strCa_code,8).equals("21080206") || 
			CutStr.cutStr(strCa_code,8).equals("21080207") || CutStr.cutStr(strCa_code,8).equals("21080211") || CutStr.cutStr(strCa_code,8).equals("21080213") ||
			CutStr.cutStr(strCa_code,8).equals("16250401") || CutStr.cutStr(strCa_code,8).equals("16250402") || CutStr.cutStr(strCa_code,8).equals("16250403") || CutStr.cutStr(strCa_code,8).equals("16421003") ||
			CutStr.cutStr(strCa_code,8).equals("16421008") || CutStr.cutStr(strCa_code,8).equals("16421010") || CutStr.cutStr(strCa_code,8).equals("16421005") || CutStr.cutStr(strCa_code,8).equals("16421006") || 
			CutStr.cutStr(strCa_code,8).equals("16421009") || CutStr.cutStr(strCa_code,8).equals("16421011") || CutStr.cutStr(strCa_code,8).equals("16421013") || CutStr.cutStr(strCa_code,8).equals("16321005") ||
			CutStr.cutStr(strCa_code,8).equals("10120316") || CutStr.cutStr(strCa_code,8).equals("15020226") || CutStr.cutStr(strCa_code,8).equals("15020227") || 
			CutStr.cutStr(strCa_code,8).equals("10050206") || CutStr.cutStr(strCa_code,8).equals("10050208") || CutStr.cutStr(strCa_code,8).equals("16290201") || CutStr.cutStr(strCa_code,8).equals("15020501") || 
			CutStr.cutStr(strCa_code,8).equals("15020502") || CutStr.cutStr(strCa_code,8).equals("15020503") || CutStr.cutStr(strCa_code,8).equals("15020506") || CutStr.cutStr(strCa_code,8).equals("15020507") || 
			CutStr.cutStr(strCa_code,8).equals("15020510") || CutStr.cutStr(strCa_code,8).equals("15020512") || CutStr.cutStr(strCa_code,8).equals("15040410") || CutStr.cutStr(strCa_code,8).equals("10050203") ||
			CutStr.cutStr(strCa_code,8).equals("15020520") || CutStr.cutStr(strCa_code,8).equals("15020521") || CutStr.cutStr(strCa_code,8).equals("15020522") || CutStr.cutStr(strCa_code,8).equals("15060301") ||
			CutStr.cutStr(strCa_code,8).equals("15060305") || CutStr.cutStr(strCa_code,8).equals("15060306") || CutStr.cutStr(strCa_code,8).equals("15060307") || CutStr.cutStr(strCa_code,8).equals("15100411") ||
			CutStr.cutStr(strCa_code,8).equals("16051501") || CutStr.cutStr(strCa_code,8).equals("16051502") || CutStr.cutStr(strCa_code,8).equals("16051503") || CutStr.cutStr(strCa_code,8).equals("10050210") || 
			CutStr.cutStr(strCa_code,8).equals("10050211") || CutStr.cutStr(strCa_code,8).equals("10050212") || CutStr.cutStr(strCa_code,8).equals("10050213") || CutStr.cutStr(strCa_code,8).equals("10050215") || 
			CutStr.cutStr(strCa_code,8).equals("10050216") || CutStr.cutStr(strCa_code,6).equals("080104") || CutStr.cutStr(strCa_code,6).equals("080112") || CutStr.cutStr(strCa_code,6).equals("080107") || 
			CutStr.cutStr(strCa_code,6).equals("080102") || CutStr.cutStr(strCa_code,6).equals("080103") || CutStr.cutStr(strCa_code,6).equals("080120") || CutStr.cutStr(strCa_code,6).equals("080121") || 
			CutStr.cutStr(strCa_code,6).equals("080122") || CutStr.cutStr(strCa_code,6).equals("080123") || CutStr.cutStr(strCa_code,6).equals("080111") || CutStr.cutStr(strCa_code,8).equals("15080201") || 
			CutStr.cutStr(strCa_code,8).equals("15080203") ||  CutStr.cutStr(strCa_code,8).equals("15080204") || CutStr.cutStr(strCa_code,8).equals("15080205") || CutStr.cutStr(strCa_code,8).equals("15080205") ||
			CutStr.cutStr(strCa_code,8).equals("15080228") || CutStr.cutStr(strCa_code,8).equals("15080222") || CutStr.cutStr(strCa_code,8).equals("15080223") || CutStr.cutStr(strCa_code,8).equals("15080229") || 
			CutStr.cutStr(strCa_code,8).equals("15080226") || CutStr.cutStr(strCa_code,8).equals("16351303") || CutStr.cutStr(strCa_code,8).equals("16351301") || CutStr.cutStr(strCa_code,8).equals("21451303") || CutStr.cutStr(strCa_code,8).equals("21451301") ||
			(CutStr.cutStr(strCa_code,6).equals("150801") && !CutStr.cutStr(strCa_code,8).equals("15080113")) || CutStr.cutStr(strCa_code,8).equals("15080230") || CutStr.cutStr(strCa_code,8).equals("15080231") ||
			CutStr.cutStr(strCa_code,6).equals("150809") || ( CutStr.cutStr(strCa_code,6).equals("150808") && !CutStr.cutStr(strCa_code,8).equals("15080806") && !CutStr.cutStr(strCa_code,8).equals("15080807") && !CutStr.cutStr(strCa_code,8).equals("15080812")) ||
			CutStr.cutStr(strCa_code,6).equals("150813") || CutStr.cutStr(strCa_code,8).equals("15090106") 	|| CutStr.cutStr(strCa_code,8).equals("16421313") || CutStr.cutStr(strCa_code,8).equals("16421314") ||
			CutStr.cutStr(strCa_code,8).equals("16421316") || CutStr.cutStr(strCa_code,8).equals("16421315") || CutStr.cutStr(strCa_code,8).equals("16421318") || CutStr.cutStr(strCa_code,8).equals("16421323") ||
			CutStr.cutStr(strCa_code,8).equals("16421612") || CutStr.cutStr(strCa_code,8).equals("16421613") || CutStr.cutStr(strCa_code,8).equals("16421614") || CutStr.cutStr(strCa_code,8).equals("16421615")	||
			CutStr.cutStr(strCa_code,8).equals("15091301") || CutStr.cutStr(strCa_code,8).equals("15091303") || CutStr.cutStr(strCa_code,8).equals("09011910") || CutStr.cutStr(strCa_code,8).equals("15080808") ||
			CutStr.cutStr(strCa_code,8).equals("15080801") || CutStr.cutStr(strCa_code,8).equals("15110504") || CutStr.cutStr(strCa_code,8).equals("15110506") || CutStr.cutStr(strCa_code,8).equals("15110508") ||
			CutStr.cutStr(strCa_code,8).equals("15040422") || CutStr.cutStr(strCa_code,8).equals("15110503") || CutStr.cutStr(strCa_code,8).equals("15110505") || CutStr.cutStr(strCa_code,8).equals("15110511") || 
			CutStr.cutStr(strCa_code,8).equals("15110512") || CutStr.cutStr(strCa_code,8).equals("15110107")			
		){
			if (strIndividualChangeUnit.toLowerCase().equals("ml") || strIndividualChangeUnit.toLowerCase().equals("l")){ 
				if (CutStr.cutStr(strCa_code,8).equals("16360102") || 
					CutStr.cutStr(strCa_code,8).equals("16360111") || CutStr.cutStr(strCa_code,8).equals("16360112") || CutStr.cutStr(strCa_code,8).equals("16360113") ||  CutStr.cutStr(strCa_code,8).equals("16360707") || 
					CutStr.cutStr(strCa_code,8).equals("16360708") || CutStr.cutStr(strCa_code,8).equals("15130303") || CutStr.cutStr(strCa_code,8).equals("15070405") || CutStr.cutStr(strCa_code,4).equals("0806") || 
					CutStr.cutStr(strCa_code,8).equals("16051504") || CutStr.cutStr(strCa_code,8).equals("15110306") || CutStr.cutStr(strCa_code,8).equals("15110305") || CutStr.cutStr(strCa_code,8).equals("15110307") ||
					CutStr.cutStr(strCa_code,8).equals("15100803") || CutStr.cutStr(strCa_code,8).equals("15100804") || CutStr.cutStr(strCa_code,8).equals("15100805") || CutStr.cutStr(strCa_code,8).equals("15100806") || 
					CutStr.cutStr(strCa_code,8).equals("15100323") || CutStr.cutStr(strCa_code,8).equals("15100328") || CutStr.cutStr(strCa_code,8).equals("15070508") || CutStr.cutStr(strCa_code,8).equals("15010609") ||
					CutStr.cutStr(strCa_code,8).equals("15010508") || 	CutStr.cutStr(strCa_code,6).equals("150101") || CutStr.cutStr(strCa_code,6).equals("150102") || CutStr.cutStr(strCa_code,8).equals("10120315") ||
					(CutStr.cutStr(strCa_code,6).equals("150103") && !CutStr.cutStr(strCa_code,8).equals("15010319") && !CutStr.cutStr(strCa_code,8).equals("15010320")) || 
					CutStr.cutStr(strCa_code,6).equals("150104") || CutStr.cutStr(strCa_code,6).equals("150105") || CutStr.cutStr(strCa_code,6).equals("150107") || CutStr.cutStr(strCa_code,6).equals("150108") ||
					(CutStr.cutStr(strCa_code,6).equals("150111") && !CutStr.cutStr(strCa_code,8).equals("15011104")) || CutStr.cutStr(strCa_code,6).equals("150112") || 
					CutStr.cutStr(strCa_code,8).equals("15080508") || CutStr.cutStr(strCa_code,8).equals("15020509") ||
					(CutStr.cutStr(strCa_code,6).equals("150501") && !CutStr.cutStr(strCa_code,8).equals("15050120") && !CutStr.cutStr(strCa_code,8).equals("15050106") && !CutStr.cutStr(strCa_code,8).equals("15050127") 
					&& !CutStr.cutStr(strCa_code,8).equals("15050128") && !CutStr.cutStr(strCa_code,8).equals("15050129") && !CutStr.cutStr(strCa_code,8).equals("15050130") && !CutStr.cutStr(strCa_code,8).equals("15050131")
					&& !CutStr.cutStr(strCa_code,8).equals("15050132")) || CutStr.cutStr(strCa_code,8).equals("15020511") || 
					(CutStr.cutStr(strCa_code,4).equals("0812") && !CutStr.cutStr(strCa_code,6).equals("081203") && !CutStr.cutStr(strCa_code,8).equals("08120603") && !CutStr.cutStr(strCa_code,8).equals("08120408")) ||
					CutStr.cutStr(strCa_code,6).equals("150504") || CutStr.cutStr(strCa_code,6).equals("150502") || (CutStr.cutStr(strCa_code,6).equals("150507") && !CutStr.cutStr(strCa_code,8).equals("15050722")) ||
					CutStr.cutStr(strCa_code,6).equals("100501") || CutStr.cutStr(strCa_code,8).equals("10050201") || CutStr.cutStr(strCa_code,8).equals("10050204") || CutStr.cutStr(strCa_code,6).equals("100508") ||
					CutStr.cutStr(strCa_code,6).equals("100511") || CutStr.cutStr(strCa_code,6).equals("100512") || CutStr.cutStr(strCa_code,6).equals("100513") || CutStr.cutStr(strCa_code,6).equals("100514") ||
					CutStr.cutStr(strCa_code,8).equals("16420901") || CutStr.cutStr(strCa_code,8).equals("16250403") || CutStr.cutStr(strCa_code,8).equals("16421003") || CutStr.cutStr(strCa_code,8).equals("16421008") ||
					CutStr.cutStr(strCa_code,8).equals("16421010") || CutStr.cutStr(strCa_code,8).equals("15100329") || CutStr.cutStr(strCa_code,8).equals("15100321") || CutStr.cutStr(strCa_code,8).equals("15100322") || 
					CutStr.cutStr(strCa_code,8).equals("15100326") || CutStr.cutStr(strCa_code,8).equals("15100327") || CutStr.cutStr(strCa_code,8).equals("15100401") || CutStr.cutStr(strCa_code,8).equals("15100407") ||
					CutStr.cutStr(strCa_code,8).equals("10050206") || CutStr.cutStr(strCa_code,8).equals("10050208") || CutStr.cutStr(strCa_code,8).equals("15020501") || CutStr.cutStr(strCa_code,8).equals("15100412") || 
					CutStr.cutStr(strCa_code,8).equals("15020502") || CutStr.cutStr(strCa_code,8).equals("15020503") || CutStr.cutStr(strCa_code,8).equals("15020506") || CutStr.cutStr(strCa_code,8).equals("15020507") || 
					CutStr.cutStr(strCa_code,8).equals("15020510") || CutStr.cutStr(strCa_code,8).equals("15020512") || CutStr.cutStr(strCa_code,8).equals("10050203") || CutStr.cutStr(strCa_code,8).equals("15020520") || 
					CutStr.cutStr(strCa_code,8).equals("15020521") || CutStr.cutStr(strCa_code,8).equals("15020522") || CutStr.cutStr(strCa_code,8).equals("15100411") || CutStr.cutStr(strCa_code,8).equals("15070504") ||
					CutStr.cutStr(strCa_code,8).equals("16051501") || CutStr.cutStr(strCa_code,8).equals("16051502") || CutStr.cutStr(strCa_code,8).equals("16051503") || CutStr.cutStr(strCa_code,8).equals("15070511") ||
					CutStr.cutStr(strCa_code,8).equals("10050210") || CutStr.cutStr(strCa_code,8).equals("10050211") || CutStr.cutStr(strCa_code,8).equals("10050212") || CutStr.cutStr(strCa_code,8).equals("10050213") || 
					CutStr.cutStr(strCa_code,8).equals("10050215") || CutStr.cutStr(strCa_code,8).equals("10050216") || CutStr.cutStr(strCa_code,6).equals("080104") || CutStr.cutStr(strCa_code,6).equals("080112") || 
					CutStr.cutStr(strCa_code,6).equals("080107") || CutStr.cutStr(strCa_code,6).equals("080102") || CutStr.cutStr(strCa_code,6).equals("080103") || CutStr.cutStr(strCa_code,6).equals("080120") || 
					CutStr.cutStr(strCa_code,6).equals("080121") || CutStr.cutStr(strCa_code,6).equals("080122") || CutStr.cutStr(strCa_code,6).equals("080123") || CutStr.cutStr(strCa_code,6).equals("080111") ||
					CutStr.cutStr(strCa_code,8).equals("15080201") || CutStr.cutStr(strCa_code,8).equals("15080203") ||  CutStr.cutStr(strCa_code,8).equals("15080204") || CutStr.cutStr(strCa_code,8).equals("15080205") || 
					CutStr.cutStr(strCa_code,8).equals("15080205") || CutStr.cutStr(strCa_code,8).equals("15080228") || CutStr.cutStr(strCa_code,8).equals("15080222") || CutStr.cutStr(strCa_code,8).equals("15080223") || 
					CutStr.cutStr(strCa_code,8).equals("15080229") || CutStr.cutStr(strCa_code,8).equals("15080226") || (CutStr.cutStr(strCa_code,6).equals("150801") && !CutStr.cutStr(strCa_code,8).equals("15080113")) ||
					CutStr.cutStr(strCa_code,6).equals("150809") || CutStr.cutStr(strCa_code,8).equals("15080230") || CutStr.cutStr(strCa_code,8).equals("15080231") ||
					( CutStr.cutStr(strCa_code,6).equals("150808") && !CutStr.cutStr(strCa_code,8).equals("15080806") && !CutStr.cutStr(strCa_code,8).equals("15080807") && !CutStr.cutStr(strCa_code,8).equals("15080812")
					&& !CutStr.cutStr(strCa_code,8).equals("15080808") && !CutStr.cutStr(strCa_code,8).equals("15080801")) ||
					CutStr.cutStr(strCa_code,6).equals("150813") || CutStr.cutStr(strCa_code,8).equals("15090106")	|| CutStr.cutStr(strCa_code,8).equals("16421313") || CutStr.cutStr(strCa_code,8).equals("16421314") ||
					CutStr.cutStr(strCa_code,8).equals("16421316") || CutStr.cutStr(strCa_code,8).equals("16421315") || CutStr.cutStr(strCa_code,8).equals("16421318") ||  CutStr.cutStr(strCa_code,8).equals("16421323") ||
					CutStr.cutStr(strCa_code,8).equals("16421612") || CutStr.cutStr(strCa_code,8).equals("16421613") || CutStr.cutStr(strCa_code,8).equals("16421615") || CutStr.cutStr(strCa_code,8).equals("15091303") ||
					CutStr.cutStr(strCa_code,8).equals("15040422") || CutStr.cutStr(strCa_code,8).equals("15110503") || CutStr.cutStr(strCa_code,8).equals("15110505") || CutStr.cutStr(strCa_code,8).equals("15110511") || 
					CutStr.cutStr(strCa_code,8).equals("15110512")
				){
					strIndividualChangeUnit = "10ml" + "당가격"; 
				}else{
					strIndividualChangeUnit = "100ml" + "당가격";
				}
			}else if(strIndividualChangeUnit.toLowerCase().equals("kg") || strIndividualChangeUnit.toLowerCase().equals("g")){
				if (CutStr.cutStr(strCa_code,8).equals("15020201") || (CutStr.cutStr(strCa_code,6).equals("150203") && !CutStr.cutStr(strCa_code,8).equals("15020308") ) || 
					CutStr.cutStr(strCa_code,8).equals("15090126") ||  CutStr.cutStr(strCa_code,8).equals("15020226") || CutStr.cutStr(strCa_code,8).equals("15020227") || 
					CutStr.cutStr(strCa_code,8).equals("15090102") || CutStr.cutStr(strCa_code,8).equals("15090103") || CutStr.cutStr(strCa_code,8).equals("15090104") || 
					CutStr.cutStr(strCa_code,8).equals("15020216") || CutStr.cutStr(strCa_code,8).equals("15090212") ||
					CutStr.cutStr(strCa_code,8).equals("15050916") || CutStr.cutStr(strCa_code,8).equals("15090119") ||
					CutStr.cutStr(strCa_code,8).equals("15090122") || CutStr.cutStr(strCa_code,8).equals("15090113") || CutStr.cutStr(strCa_code,6).equals("150202") || 
					CutStr.cutStr(strCa_code,6).equals("159801") || CutStr.cutStr(strCa_code,8).equals("15090102") || CutStr.cutStr(strCa_code,8).equals("15090101") || 
					CutStr.cutStr(strCa_code,8).equals("15090103") || CutStr.cutStr(strCa_code,8).equals("15090104") ||
					CutStr.cutStr(strCa_code,8).equals("15090101") || CutStr.cutStr(strCa_code,6).equals("150208") || CutStr.cutStr(strCa_code,6).equals("150209")
				){
					strIndividualChangeUnit = "1kg" + "당가격";
				}else if(CutStr.cutStr(strCa_code,8).equals("16421613") || CutStr.cutStr(strCa_code,8).equals("16421614")){
					strIndividualChangeUnit = "g" + "당가격";
				}else if(CutStr.cutStr(strCa_code,8).equals("15070510") || CutStr.cutStr(strCa_code,8).equals("15070605") || CutStr.cutStr(strCa_code,8).equals("15070508") || CutStr.cutStr(strCa_code,8).equals("15020509") ||
						 CutStr.cutStr(strCa_code,4).equals("0806") || CutStr.cutStr(strCa_code,8).equals("15010508") ||   
						 CutStr.cutStr(strCa_code,8).equals("15020217") || CutStr.cutStr(strCa_code,8).equals("15070510") || CutStr.cutStr(strCa_code,8).equals("15080508") ||
						 CutStr.cutStr(strCa_code,8).equals("15980504") || CutStr.cutStr(strCa_code,8).equals("15020511") ||
						 CutStr.cutStr(strCa_code,8).equals("15980506") || CutStr.cutStr(strCa_code,8).equals("16360707") || CutStr.cutStr(strCa_code,8).equals("16360708") || CutStr.cutStr(strCa_code,8).equals("15070504") ||
						 CutStr.cutStr(strCa_code,8).equals("15130303") || CutStr.cutStr(strCa_code,8).equals("15070416") || CutStr.cutStr(strCa_code,8).equals("15070505") || CutStr.cutStr(strCa_code,8).equals("15070511") ||
						 CutStr.cutStr(strCa_code,8).equals("15110306") || CutStr.cutStr(strCa_code,8).equals("15110305") || CutStr.cutStr(strCa_code,8).equals("15110307") ||
						 CutStr.cutStr(strCa_code,8).equals("15100803") || CutStr.cutStr(strCa_code,8).equals("15100804") || CutStr.cutStr(strCa_code,8).equals("15100805") ||
						 CutStr.cutStr(strCa_code,8).equals("15100806") || CutStr.cutStr(strCa_code,8).equals("15100323") || CutStr.cutStr(strCa_code,8).equals("15100328") ||
						 CutStr.cutStr(strCa_code,6).equals("150101") || CutStr.cutStr(strCa_code,6).equals("150102") || CutStr.cutStr(strCa_code,6).equals("150104") ||  
						 (CutStr.cutStr(strCa_code,6).equals("150103") && !CutStr.cutStr(strCa_code,8).equals("15010319") && !CutStr.cutStr(strCa_code,8).equals("15010320")) || 
						 CutStr.cutStr(strCa_code,6).equals("150105") || CutStr.cutStr(strCa_code,6).equals("150107") || CutStr.cutStr(strCa_code,6).equals("150108") || CutStr.cutStr(strCa_code,8).equals("15010609") ||
						 (CutStr.cutStr(strCa_code,6).equals("150111") && !CutStr.cutStr(strCa_code,8).equals("15011104")) || CutStr.cutStr(strCa_code,6).equals("150112") ||
						(CutStr.cutStr(strCa_code,6).equals("150501") && !CutStr.cutStr(strCa_code,8).equals("15050120") && !CutStr.cutStr(strCa_code,8).equals("15050106") && !CutStr.cutStr(strCa_code,8).equals("15050127") 
						&& !CutStr.cutStr(strCa_code,8).equals("15050128") && !CutStr.cutStr(strCa_code,8).equals("15050129") && !CutStr.cutStr(strCa_code,8).equals("15050130") && !CutStr.cutStr(strCa_code,8).equals("15050131")
						&& !CutStr.cutStr(strCa_code,8).equals("15050132")) || (CutStr.cutStr(strCa_code,4).equals("0812") && !CutStr.cutStr(strCa_code,6).equals("081203") && !CutStr.cutStr(strCa_code,8).equals("08120603") && !CutStr.cutStr(strCa_code,8).equals("08120408")) ||
						CutStr.cutStr(strCa_code,6).equals("150504") || CutStr.cutStr(strCa_code,6).equals("150502") || (CutStr.cutStr(strCa_code,6).equals("150507") && !CutStr.cutStr(strCa_code,8).equals("15050722")) ||
						CutStr.cutStr(strCa_code,6).equals("100501") || CutStr.cutStr(strCa_code,8).equals("10050201") || CutStr.cutStr(strCa_code,8).equals("10050204") || CutStr.cutStr(strCa_code,6).equals("100508") ||
						CutStr.cutStr(strCa_code,6).equals("100511") || CutStr.cutStr(strCa_code,6).equals("100512") || CutStr.cutStr(strCa_code,6).equals("100513") || CutStr.cutStr(strCa_code,6).equals("100514") ||
						CutStr.cutStr(strCa_code,8).equals("16420901") || CutStr.cutStr(strCa_code,8).equals("16250403") || CutStr.cutStr(strCa_code,8).equals("16421003") || CutStr.cutStr(strCa_code,8).equals("16421008") ||
						CutStr.cutStr(strCa_code,8).equals("16421010") || CutStr.cutStr(strCa_code,8).equals("15100329") || CutStr.cutStr(strCa_code,8).equals("15100321") || CutStr.cutStr(strCa_code,8).equals("15100322") || 
						CutStr.cutStr(strCa_code,8).equals("15100326") || CutStr.cutStr(strCa_code,8).equals("15100327") || CutStr.cutStr(strCa_code,8).equals("15100401") || CutStr.cutStr(strCa_code,8).equals("15100407") ||
						CutStr.cutStr(strCa_code,8).equals("10050206") || CutStr.cutStr(strCa_code,8).equals("10050208") || CutStr.cutStr(strCa_code,8).equals("15020501") || CutStr.cutStr(strCa_code,8).equals("15100412") || 
						CutStr.cutStr(strCa_code,8).equals("15020502") || CutStr.cutStr(strCa_code,8).equals("15020503") || CutStr.cutStr(strCa_code,8).equals("15020506") || CutStr.cutStr(strCa_code,8).equals("15020507") || 
						CutStr.cutStr(strCa_code,8).equals("15020510") || CutStr.cutStr(strCa_code,8).equals("15020512") || CutStr.cutStr(strCa_code,8).equals("10050203") || CutStr.cutStr(strCa_code,8).equals("15020520") || 
						CutStr.cutStr(strCa_code,8).equals("15020521") || CutStr.cutStr(strCa_code,8).equals("15020522") || CutStr.cutStr(strCa_code,8).equals("15100411") || CutStr.cutStr(strCa_code,8).equals("16051501") || 
						CutStr.cutStr(strCa_code,8).equals("16051502") || CutStr.cutStr(strCa_code,8).equals("16051503") || CutStr.cutStr(strCa_code,8).equals("10050210") || CutStr.cutStr(strCa_code,8).equals("10050211") ||
					 	CutStr.cutStr(strCa_code,8).equals("10050212") || CutStr.cutStr(strCa_code,8).equals("10050213") || CutStr.cutStr(strCa_code,8).equals("10050215") || CutStr.cutStr(strCa_code,8).equals("10050216") ||
						CutStr.cutStr(strCa_code,6).equals("080104") || CutStr.cutStr(strCa_code,6).equals("080112") || CutStr.cutStr(strCa_code,6).equals("080107") || CutStr.cutStr(strCa_code,6).equals("080102") || 
						CutStr.cutStr(strCa_code,6).equals("080103") || CutStr.cutStr(strCa_code,6).equals("080120") || CutStr.cutStr(strCa_code,6).equals("080121") || CutStr.cutStr(strCa_code,6).equals("080122") || 
						CutStr.cutStr(strCa_code,6).equals("080123") || CutStr.cutStr(strCa_code,6).equals("080111") || CutStr.cutStr(strCa_code,8).equals("15080201") || CutStr.cutStr(strCa_code,8).equals("15080203") ||  
						CutStr.cutStr(strCa_code,8).equals("15080204") || CutStr.cutStr(strCa_code,8).equals("15080205") || CutStr.cutStr(strCa_code,8).equals("15080205") || CutStr.cutStr(strCa_code,8).equals("15080228") || 
						CutStr.cutStr(strCa_code,8).equals("15080222") || CutStr.cutStr(strCa_code,8).equals("15080223") || CutStr.cutStr(strCa_code,8).equals("15080229") || CutStr.cutStr(strCa_code,8).equals("15080226") ||
						(CutStr.cutStr(strCa_code,6).equals("150801") && !CutStr.cutStr(strCa_code,8).equals("15080113")) || 
						CutStr.cutStr(strCa_code,6).equals("150809") || ( CutStr.cutStr(strCa_code,6).equals("150808") && !CutStr.cutStr(strCa_code,8).equals("15080806") && !CutStr.cutStr(strCa_code,8).equals("15080807") && !CutStr.cutStr(strCa_code,8).equals("15080812")
						&& !CutStr.cutStr(strCa_code,8).equals("15080808") && !CutStr.cutStr(strCa_code,8).equals("15080801")) || CutStr.cutStr(strCa_code,8).equals("15080230") || CutStr.cutStr(strCa_code,8).equals("15080231") ||
						CutStr.cutStr(strCa_code,6).equals("150813") || CutStr.cutStr(strCa_code,8).equals("15090106")	|| CutStr.cutStr(strCa_code,8).equals("16421313") || CutStr.cutStr(strCa_code,8).equals("16421314") ||
						CutStr.cutStr(strCa_code,8).equals("16421316") || CutStr.cutStr(strCa_code,8).equals("16421315") || CutStr.cutStr(strCa_code,8).equals("16421318") || CutStr.cutStr(strCa_code,8).equals("16421323") ||
						CutStr.cutStr(strCa_code,8).equals("16421612") || CutStr.cutStr(strCa_code,8).equals("16421613") || CutStr.cutStr(strCa_code,8).equals("16421614") || CutStr.cutStr(strCa_code,8).equals("16421615") ||
						CutStr.cutStr(strCa_code,8).equals("15091303") || CutStr.cutStr(strCa_code,8).equals("15040422") || CutStr.cutStr(strCa_code,8).equals("15110503") || CutStr.cutStr(strCa_code,8).equals("15110505") || 
						CutStr.cutStr(strCa_code,8).equals("15110511") || CutStr.cutStr(strCa_code,8).equals("15110512")					 
				){
					strIndividualChangeUnit = "10g" + "당가격";
				}else if(strIndividualChangeUnit.toLowerCase().equals("cm")){
					strIndividualChangeUnit = "100cm" + "당가격";
				}else{
					strIndividualChangeUnit = "100g" + "당가격";
				}
			}else{
				strIndividualChangeUnit = strIndividualChangeUnit + "당가격";
			}
		}else if(CutStr.cutStr(strCa_code,8).equals("05100905") || (CutStr.cutStr(strCa_code,4).equals("0810") && !CutStr.cutStr(strCa_code,6).equals("081004")) ){
			if (strIndividualChangeUnit.toLowerCase().equals("ml")){
				strIndividualChangeUnit = "10ml" + "당가격";
			}else if(strIndividualChangeUnit.toLowerCase().equals("g")){
				strIndividualChangeUnit = "10g" + "당가격";
			}
		}else if(CutStr.cutStr(strCa_code,6).equals("031112")){
			strIndividualChangeUnit = "100매" + "당가격";
		}else if(CutStr.cutStr(strCa_code,4).equals("1011")){
			strIndividualChangeUnit = "권당가격";
		}else if ((CutStr.cutStr(strCa_code,4).equals("0807") && !CutStr.cutStr(strCa_code,6).equals("080709")) || (CutStr.cutStr(strCa_code,4).equals("1654") && !CutStr.cutStr(strCa_code,6).equals("165409"))){
			if (CutStr.cutStr(strCa_code,8).equals("08070403") || CutStr.cutStr(strCa_code,8).equals("08070403") || CutStr.cutStr(strCa_code,6).equals("080704") || CutStr.cutStr(strCa_code,6).equals("080703") || CutStr.cutStr(strCa_code,8).equals("08071903")  || 
				CutStr.cutStr(strCa_code,8).equals("16540403") || CutStr.cutStr(strCa_code,8).equals("16540403") || CutStr.cutStr(strCa_code,6).equals("165404") || CutStr.cutStr(strCa_code,6).equals("165403") || CutStr.cutStr(strCa_code,8).equals("16541903")){
				strIndividualChangeUnit = "10ml" + "당가격";
			}else if(CutStr.cutStr(strCa_code,8).equals("08071901") || CutStr.cutStr(strCa_code,8).equals("08071902") || CutStr.cutStr(strCa_code,8).equals("08071904") ||
					CutStr.cutStr(strCa_code,8).equals("16541901") || CutStr.cutStr(strCa_code,8).equals("16541902") || CutStr.cutStr(strCa_code,8).equals("16541904")){
				strIndividualChangeUnit = "10g" + "당가격";
			}else if(CutStr.cutStr(strCa_code,6).equals("080721") || CutStr.cutStr(strCa_code,6).equals("165421")){
				if (strIndividualChangeUnit.toLowerCase().equals("g")){
					strIndividualChangeUnit = "10g" + "당가격";
				}else if(strIndividualChangeUnit.toLowerCase().equals("ml")){
					strIndividualChangeUnit = "10ml" + "당가격";
				}
			}else{
				strIndividualChangeUnit = "100ml" + "당가격";
			}
		}else if(CutStr.cutStr(strCa_code,6).equals("180301") || CutStr.cutStr(strCa_code,6).equals("180302") || CutStr.cutStr(strCa_code,6).equals("032103") || CutStr.cutStr(strCa_code,6).equals("180304") || 
			CutStr.cutStr(strCa_code,6).equals("180305") || CutStr.cutStr(strCa_code,6).equals("180306") || CutStr.cutStr(strCa_code,6).equals("180312") || CutStr.cutStr(strCa_code,6).equals("180313") || CutStr.cutStr(strCa_code,6).equals("180303") || 
			CutStr.cutStr(strCa_code,8).equals("04020208")
		){
			strIndividualChangeUnit = "10매당가격";
		}else if(CutStr.cutStr(strCa_code,4).equals("1020") && !CutStr.cutStr(strCa_code,6).equals("102012") && !CutStr.cutStr(strCa_code,6).equals("102005") && !CutStr.cutStr(strCa_code,8).equals("10200705") && !CutStr.cutStr(strCa_code,8).equals("10201400")
		&& !CutStr.cutStr(strCa_code,8).equals("10201400") && !CutStr.cutStr(strCa_code,8).equals("10200404")){
			strIndividualChangeUnit = "매당가격";
		}else{ 
			strIndividualChangeUnit = strIndividualChangeUnit + "당가격";
		}
		return strIndividualChangeUnit;
	}
	public boolean isDivCondinameCate(String strCate){
		boolean bReturn = false;
		if (CutStr.cutStr(strCate,4).equals("0304") || CutStr.cutStr(strCate,4).equals("0305") || CutStr.cutStr(strCate,4).equals("0790") || CutStr.cutStr(strCate,4).equals("2115") ||
			CutStr.cutStr(strCate,4).equals("0801") || CutStr.cutStr(strCate,4).equals("0802") || CutStr.cutStr(strCate,4).equals("0803") || CutStr.cutStr(strCate,4).equals("0804") ||
			CutStr.cutStr(strCate,4).equals("0805") || CutStr.cutStr(strCate,4).equals("0806") || CutStr.cutStr(strCate,4).equals("0807") || CutStr.cutStr(strCate,4).equals("0808") || 
			CutStr.cutStr(strCate,4).equals("0809") || CutStr.cutStr(strCate,4).equals("0810") || CutStr.cutStr(strCate,4).equals("0812") || CutStr.cutStr(strCate,4).equals("0813") || 
			CutStr.cutStr(strCate,4).equals("0814") || CutStr.cutStr(strCate,4).equals("0304") || CutStr.cutStr(strCate,4).equals("0908") || CutStr.cutStr(strCate,4).equals("0928") || 
			CutStr.cutStr(strCate,4).equals("0904") || CutStr.cutStr(strCate,4).equals("0929") || CutStr.cutStr(strCate,4).equals("1003") || CutStr.cutStr(strCate,4).equals("2122") || 
			CutStr.cutStr(strCate,4).equals("2117") || CutStr.cutStr(strCate,4).equals("2113") || CutStr.cutStr(strCate,4).equals("1202") || CutStr.cutStr(strCate,4).equals("1612") ||
			CutStr.cutStr(strCate,4).equals("1623") || CutStr.cutStr(strCate,4).equals("1626") || CutStr.cutStr(strCate,4).equals("1226") ||  
			CutStr.cutStr(strCate,4).equals("2116") || CutStr.cutStr(strCate,4).equals("1801") || CutStr.cutStr(strCate,4).equals("1802") || CutStr.cutStr(strCate,4).equals("1643") || 
			CutStr.cutStr(strCate,4).equals("1647") || CutStr.cutStr(strCate,4).equals("0713") || CutStr.cutStr(strCate,4).equals("1005") || CutStr.cutStr(strCate,4).equals("1011") ||
			CutStr.cutStr(strCate,4).equals("1654")
		){
			bReturn = true;
		}
		return bReturn;
	}
	public String replaceSpecialCharacter(String srrCate,String strTerms){
		String strReturn = strTerms;
		/*
		if (CutStr.cutStr(srrCate,4).equals("0501") || CutStr.cutStr(srrCate,4).equals("9003")){
			strReturn = ReplaceStr.replace(strReturn,"`</span>","</span>");
			strReturn = ReplaceStr.replace(strReturn,"!</span>","</span>");
			strReturn = ReplaceStr.replace(strReturn,"*</span>","</span>");
			strReturn = ReplaceStr.replace(strReturn,"#</span>","</span>");
		}else if(CutStr.cutStr(srrCate,4).equals("0305")){
			strReturn = ReplaceStr.replace(strReturn,">`",">");
			strReturn = ReplaceStr.replace(strReturn,">!",">");
			strReturn = ReplaceStr.replace(strReturn,">*",">");
			strReturn = ReplaceStr.replace(strReturn,">#",">");
			strReturn = ReplaceStr.replace(strReturn,">.",">");
			if (strReturn.trim().length() > 0 ){
				if (strReturn.substring(0,1).equals("`") || strReturn.substring(0,1).equals("!") || strReturn.substring(0,1).equals("*") || strReturn.substring(0,1).equals("#") || strReturn.substring(0,1).equals(".")){
					strReturn = strReturn.substring(1,strReturn.length());
				} 
			}			
		}
		*/	
		if(CutStr.cutStr(srrCate,4).equals("0501") || CutStr.cutStr(srrCate,4).equals("9003") ||CutStr.cutStr(srrCate,4).equals("0305") ||CutStr.cutStr(srrCate,4).equals("9418") ||CutStr.cutStr(srrCate,4).equals("0304") ||
			CutStr.cutStr(srrCate,4).equals("0222") || CutStr.cutStr(srrCate,4).equals("0354") || CutStr.cutStr(srrCate,4).equals("0353") || CutStr.cutStr(srrCate,4).equals("0352") || CutStr.cutStr(srrCate,4).equals("0358") ||
			CutStr.cutStr(srrCate,4).equals("0212") || CutStr.cutStr(srrCate,4).equals("0208") || CutStr.cutStr(srrCate,4).equals("0353") || CutStr.cutStr(srrCate,4).equals("0702") || CutStr.cutStr(srrCate,4).equals("0411") ||
			CutStr.cutStr(srrCate,4).equals("0404")
			){
			strReturn = ReplaceStr.replace(strReturn,">`",">");
			strReturn = ReplaceStr.replace(strReturn,">!",">");
			strReturn = ReplaceStr.replace(strReturn,">*",">");
			strReturn = ReplaceStr.replace(strReturn,">#",">");
			strReturn = ReplaceStr.replace(strReturn,">.",">");
			if (CutStr.cutStr(srrCate,4).equals("0702") || CutStr.cutStr(srrCate,4).equals("0411")){
				strReturn = ReplaceStr.replace(strReturn,"#","");
			}
			if (strReturn.trim().length() > 0 ){
				if (strReturn.substring(0,1).equals("`") || strReturn.substring(0,1).equals("!") || strReturn.substring(0,1).equals("*") || strReturn.substring(0,1).equals("#") || strReturn.substring(0,1).equals(".")){
					strReturn = strReturn.substring(1,strReturn.length());
				} 
			}
		}		
		return strReturn;
	}
	public String replaceModelNmSpecialChar(String strCate, String strModelNm){
		String strReturn = strModelNm;
		strReturn = strReturn.replaceAll("'","`");
		strReturn = strReturn.replaceAll("`]","]");
		strReturn = strReturn.replaceAll("!]","]");
		strReturn = strReturn.replaceAll("#]","]");
		if(CutStr.cutStr(strCate,4).equals("0305")){
			strReturn = ReplaceStr.replace(strReturn,"[,","[");
			strReturn = ReplaceStr.replace(strReturn,"[.","[");
		}
		try{
			if(strReturn.indexOf("*]")>-1) {
				strReturn = strReturn.substring(0, strReturn.indexOf("*]")) + strReturn.substring(strReturn.indexOf("*]")+1);
			}
			if(strReturn.indexOf("[일반]")>-1) {
				strReturn = CutStr.cutStr(strReturn, strReturn.indexOf("[일반]")) + strReturn.substring(strReturn.indexOf("[일반]")+4);
			}
		}catch(Exception e){}
		return strReturn;
	}
	public int getStringLength(String str){
		final int intS = 3;
		final int intM = 6;
		final int intL = 12;
		final int intH = 14;
		int intReturn = 0;
		
		if (str != null && str.trim().length() > 0 ){
			for (int i=0;i<=str.length()-1;i++){
				String strOne = str.substring(i,i+1);
				if (strOne.substring(0,1).compareTo("a") >=0 && strOne.substring(0,1).compareTo("z") <=0 ){
					intReturn += intM;
				}else if( strOne.substring(0,1).compareTo("A") >=0 && strOne.substring(0,1).compareTo("Z") <=0 ){
					intReturn += intL;
				}else if ((strOne.substring(0,1).compareTo("1") >=0 && strOne.substring(0,1).compareTo("9") <=0 )){
					intReturn += intL;
				}else if(",.;':\"`!^|()".indexOf(strOne) >= 0){
					intReturn += intS;
				}else if("*[]{}+-=/<>?\\~@#$%&_".indexOf(strOne) >= 0){
					intReturn += intM;
				}else if(" ".equals(strOne)){
					intReturn += intM;
				}else{
					intReturn += intH;
				}
			}
		}
		return intReturn;
						
	}	


	public String strGetMoveCategory(String strCate){
		return strCate;
		/*
		String strReturnCate = strCate;
		java.util.ArrayList<String[]> arrStrOrgCate = new java.util.ArrayList<String[]>();
		arrStrOrgCate.add("14511101,14511111,14511121,14511201,14511211,14511221,14511301,14511311,14511321".split(","));
		arrStrOrgCate.add("14511102,14511112,14511122,14511202,14511212,14511222,14511302,14511312,14511322".split(","));
		arrStrOrgCate.add("14511103,14511113,14511123,14511203,14511213,14511223,14511303,14511313,14511323".split(","));		
		arrStrOrgCate.add("14511104,14511114,14511204,14511214,14511304,14511314".split(","));				
		arrStrOrgCate.add("14511130,14511131,14511230,14511231,14511335,14511336".split(","));						
		arrStrOrgCate.add("14511205,14511215,14511315".split(","));					
		
		String strMoveCate[] = {"145114","145115","145116","145117","145118","145119"};
		
		for (int i=0;i<arrStrOrgCate.size();i++){
			for (int j=0;j<arrStrOrgCate.get(i).length;j++){
				if (arrStrOrgCate.get(i)[j].equals(strCate)){
					strReturnCate = strMoveCate[i];
					break; 
				}
			}
		}
		
		return strReturnCate;
		*/
		
	}
%>