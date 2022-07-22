<%
	String strStartTxtPrice = strStartPrice;
	String strEndTxtPrice = strEndPrice;
	
	if ( !CutStr.cutStr(strCate,4).equals("1650") && (strSearchKeyword.trim().length() == 0 && !isAddSearchCate(strCate) && !ChkNull.chkStr(request.getParameter("brand_add_search"),"").equals("Y")) || ChkNull.chkStr(request.getParameter("prtmodelno")).trim().length() > 0){
		int intStartPrice = (int)(lngPricelist[0].longValue()/10000) * 10000; //시작가 (표시용)
		int intMinPriceRange = (int)lngPricelist[0].longValue();//최저가
		int intMaxPriceRange = (int)lngPricelist[lngPricelist.length-1].longValue();//최고가

		if (strStartTxtPrice.trim().length() == 0 ){
			strStartTxtPrice = intMinPriceRange+"";
		}
		if (strEndTxtPrice.trim().length() == 0 ){
			strEndTxtPrice = intMaxPriceRange+"";
		}
	}
	 
	if (!CutStr.cutStr(strCate,4).equals("1650") && strSearchKeyword.trim().length() == 0 && !CutStr.cutStr(strCate,2).equals("14") && !isAddSearchCate(strCate)){
		if (strStartTxtPrice.trim().length() == 0 ){
			strStartTxtPrice = lngPricelist[0]+""; 
		}
		if (strEndTxtPrice.trim().length() == 0 ){
			strEndTxtPrice = lngPricelist[lngPricelist.length-1]+""; 
		}	
	}else{
		if (strStartTxtPrice.trim().length() == 0 && intPriceRangeAndCnt != null ){
			strStartTxtPrice = intPriceRangeAndCnt[0][0]+""; 
		}
		if (strEndTxtPrice.trim().length() == 0 && intPriceRangeAndCnt != null ){
			strEndTxtPrice = intPriceRangeAndCnt[intPriceRangeAndCnt.length-1][0]+""; 
		}
	}
	
	
	if (strMPrice.trim().length() > 0 && strStartPrice.trim().length() == 0 && strEndPrice.trim().length() == 0){
		String strSearchPrice[] = strMPrice.split(",");
		strStartTxtPrice = strSearchPrice[0].split("~")[0];
		strEndTxtPrice = strSearchPrice[strSearchPrice.length-1].split("~")[1];
	}
	//if(intPriceRangeAndCnt == null ){
	if(strStartTxtPrice.equals("") && strEndTxtPrice.equals("") ){
		strStartTxtPrice = "0";
		strEndTxtPrice = "0";
	}
	
	out.println("{	\"priceList\":[ { \"minPirce\":\""+FmtStr.moneyFormat(strStartTxtPrice)+"\" ,  \"maxPirce\":\""+FmtStr.moneyFormat(strEndTxtPrice)+"\" } ] }  ");
%>