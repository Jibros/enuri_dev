<%
	String strFactoryCate = "";
	String strFactoryCateFlag = "";
	
	//out.println("11111===="+factorybrand_data[0].getStrFactory_view_flag());

	Mobile_Category_Proc mobile_category_proc = new Mobile_Category_Proc();
	Mobile_Category_Data[] mobile_mcategory_data = mobile_category_proc.Mobile_Category(strCate4, "2");
	String strCateName = "";
	
	//요약설명 2줄 예외처리
	boolean bProdtxt = false;
	
	if(strCate != null){ 
		if( strCate4.equals("0201") || strCate4.equals("0203") || strCate4.equals("0208") || strCate4.equals("0211") || strCate4.equals("0215") || strCate4.equals("0220") || strCate4.equals("0224") || strCate4.equals("0232") || 
			strCate4.equals("0233") || strCate4.equals("0234") || strCate4.equals("0235") || strCate4.equals("0236") || strCate4.equals("0237") || strCate4.equals("0238") || strCate4.equals("0239") || strCate4.equals("0240") || 
			strCate4.equals("0241") || strCate4.equals("0304") || strCate4.equals("0305") || strCate4.equals("0318") || strCate4.equals("0357") || strCate4.equals("0359") || strCate4.equals("0360") || strCate4.equals("0362") || 
			strCate4.equals("0363") || strCate4.equals("0364") || strCate4.equals("0401") || strCate4.equals("0402") || strCate4.equals("0404") || strCate4.equals("0405") || strCate4.equals("0408") || strCate4.equals("0414") || 
			strCate4.equals("0418") || strCate4.equals("0420") || strCate4.equals("0422") || strCate4.equals("0423") || strCate4.equals("0502") || strCate4.equals("0503") || strCate4.equals("0507") || strCate4.equals("0508") || 
			strCate4.equals("0510") || strCate4.equals("0511") || strCate4.equals("0513") || strCate4.equals("0514") || strCate4.equals("0515") || strCate4.equals("0521") || strCate4.equals("0526") || strCate4.equals("0527") || 
			strCate4.equals("0601") || strCate4.equals("0602") || strCate4.equals("0603") || strCate4.equals("0605") || strCate4.equals("0606") || strCate4.equals("0607") || strCate4.equals("0608") || strCate4.equals("0609") || 
			strCate4.equals("0610") || strCate4.equals("0611") || strCate4.equals("0621") || strCate4.equals("0701") || strCate4.equals("0702") || strCate4.equals("0703") || strCate4.equals("0704") || strCate4.equals("0705") || 
			strCate4.equals("0707") || strCate4.equals("0708") || strCate4.equals("0709") || strCate4.equals("0710") || strCate4.equals("0711") || strCate4.equals("0712") || strCate4.equals("0713") || strCate4.equals("0715") || 
			strCate4.equals("0904") || strCate4.equals("0905") || strCate4.equals("0908") || strCate4.equals("0918") || strCate4.equals("1001") || strCate4.equals("1003") || strCate4.equals("1004") || strCate4.equals("1009") || 
			strCate4.equals("1010") || strCate4.equals("1012") || strCate4.equals("1015") || strCate4.equals("1020") || strCate4.equals("1201") || strCate4.equals("1202") || strCate4.equals("1204") || strCate4.equals("1219") || 
			strCate4.equals("1244") || strCate4.equals("1245") || strCate4.equals("1501") || strCate4.equals("1502") || strCate4.equals("1511") || strCate4.equals("1602") || strCate4.equals("2144") || strCate4.equals("1625") || strCate4.equals("1632") || 
			strCate4.equals("1636") || strCate4.equals("1642") || strCate4.equals("1643") || strCate4.equals("1807") || strCate4.equals("2115") || strCate4.equals("2211") || strCate4.equals("2241") || strCate4.equals("2401") || 
			strCate4.equals("2402") || strCate4.equals("2403") || strCate4.equals("2404") || strCate4.equals("2405") || strCate4.equals("2406") || strCate4.equals("2407") || strCate4.equals("0242") || strCate4.equals("0358") || 
			strCate4.equals("0622") || strCate4.equals("0424") || strCate4.equals("1629") || strCate4.equals("1644") 
		){ 
			bProdtxt = true;
		}
	}	 
	
	
	if(strCate.length() > 2 && mobile_mcategory_data != null && mobile_mcategory_data.length > 0){
		strCateName = mobile_mcategory_data[0].getC_name();
	}
  
	String ad_command = Ca_Ad_Keyword.Ca_Ad_Google_Call(strCate4);
  
	if(ad_command.equals("")){
		if(strCate != null && !strCate.equals("") && strCate.length() >= 4 &&  strCate.substring(0,2).equals("08") && !strCate.substring(0,4).equals("0811")) {
			ad_command = strCateName;  
		} else {
			if(strCateName.indexOf("<") > -1){
				if(strCateName.length() > strCateName.indexOf("<")) {
					ad_command = strCateName.substring(strCateName.indexOf("<")+1,strCateName.length()).trim();  //스폰서 링크 검색어(중분류명)
				} else {
					ad_command = strCateName;
				}
			}else if(strKeyword.length() > 0){
					ad_command = strKeyword;
			} 
		} 
	}
	ad_command = ad_command.replaceAll("\"","&#34;");
  
  	  
	//하단 페이징 부분
	int iEndPage = cPage*20;
	if(cPage == 1 && nPageCntCnt > 20){
		iEndPage = nPageCntCnt;
	}
		
	String pageGubun = "";
	
	if(iEndPage > intTotRsCnt){
		iEndPage = intTotRsCnt;
	}
	
	//String pagingBar = ((cPage-1)*20+1)+" ~ "+ iEndPage  ;	//페이징 텍스트부분
	String pagingBar = iEndPage + ""  ;	//페이징 텍스트부분 
 
	//테스트용
	//strPlNos = "415755126,1457343696,1267234789";
	if(request.getRequestURI().indexOf("getList_ajax.jsp") > 0 || request.getRequestURI().indexOf("getListNew_ajax.jsp") > 0){
		out.println(" { ");
	}
	out.println("   \"ad_command\": \""+ad_command+"\" , ");
	out.println("	\"goodsCnt\": [ { \"cnt\":\""+FmtStr.moneyFormat(intTotRsCnt)+"\" } ] , ");
	out.println("	\"goodsPageBar\": [ { \"pageBar\":\""+pagingBar+"\" ,  \"cnt\":\""+FmtStr.moneyFormat(intTotRsCnt)+"\" }] , ");
	out.println(" 	\"goodsList\": [ ");
				
	String strSearckKeywordSynonym = "";
	
	String strZzimmodelnos = "";
	
	if (goods_data != null && goods_data.length > 0 ){ 
		boolean listFirstPrintFlag = false;
		//마음열기
		//가격비교상품 goods_data
		for (i=0;i<goods_data.length;i++){
			int intModelNo = goods_data[i].getModelno();
			
			if(strZzimmodelnos.length() == 0 ){
				strZzimmodelnos = "G:"+intModelNo+"";
			}else{
				strZzimmodelnos = strZzimmodelnos + ",G:"+intModelNo +"";
			}	
				
			if(goods_data[i].getP_imgurl2().equals("SHOP")){
				//intModelNo = goods_data[i].getP_pl_no();
			}
			String strCa_code = goods_data[i].getCa_code();
			String strCa_code2 = "";
			if(strCa_code.length() >= 2){
				strCa_code2 = strCa_code.substring(0,2);
			} 
 			if(request.getRequestURI().indexOf("getSearch_ajax.jsp") > 0){
 				if(strCa_code.length() >= 4){
 					strCate4 = CutStr.cutStr(strCa_code,4);
					if( strCate4.equals("0201") || strCate4.equals("0203") || strCate4.equals("0208") || strCate4.equals("0211") || strCate4.equals("0215") || strCate4.equals("0220") || strCate4.equals("0224") || strCate4.equals("0232") || 
						strCate4.equals("0233") || strCate4.equals("0234") || strCate4.equals("0235") || strCate4.equals("0236") || strCate4.equals("0237") || strCate4.equals("0238") || strCate4.equals("0239") || strCate4.equals("0240") || 
						strCate4.equals("0241") || strCate4.equals("0304") || strCate4.equals("0305") || strCate4.equals("0318") || strCate4.equals("0357") || strCate4.equals("0359") || strCate4.equals("0360") || strCate4.equals("0362") || 
						strCate4.equals("0363") || strCate4.equals("0364") || strCate4.equals("0401") || strCate4.equals("0402") || strCate4.equals("0404") || strCate4.equals("0405") || strCate4.equals("0408") || strCate4.equals("0414") || 
						strCate4.equals("0418") || strCate4.equals("0420") || strCate4.equals("0422") || strCate4.equals("0423") || strCate4.equals("0502") || strCate4.equals("0503") || strCate4.equals("0507") || strCate4.equals("0508") || 
						strCate4.equals("0510") || strCate4.equals("0511") || strCate4.equals("0513") || strCate4.equals("0514") || strCate4.equals("0515") || strCate4.equals("0521") || strCate4.equals("0526") || strCate4.equals("0527") || 
						strCate4.equals("0601") || strCate4.equals("0602") || strCate4.equals("0603") || strCate4.equals("0605") || strCate4.equals("0606") || strCate4.equals("0607") || strCate4.equals("0608") || strCate4.equals("0609") || 
						strCate4.equals("0610") || strCate4.equals("0611") || strCate4.equals("0621") || strCate4.equals("0701") || strCate4.equals("0702") || strCate4.equals("0703") || strCate4.equals("0704") || strCate4.equals("0705") || 
						strCate4.equals("0707") || strCate4.equals("0708") || strCate4.equals("0709") || strCate4.equals("0710") || strCate4.equals("0711") || strCate4.equals("0712") || strCate4.equals("0713") || strCate4.equals("0715") || 
						strCate4.equals("0904") || strCate4.equals("0905") || strCate4.equals("0908") || strCate4.equals("0918") || strCate4.equals("1001") || strCate4.equals("1003") || strCate4.equals("1004") || strCate4.equals("1009") || 
						strCate4.equals("1010") || strCate4.equals("1012") || strCate4.equals("1015") || strCate4.equals("1020") || strCate4.equals("1201") || strCate4.equals("1202") || strCate4.equals("1204") || strCate4.equals("1219") || 
						strCate4.equals("1244") || strCate4.equals("1245") || strCate4.equals("1501") || strCate4.equals("1502") || strCate4.equals("1511") || strCate4.equals("1602") || strCate4.equals("2144") || strCate4.equals("1625") || strCate4.equals("1632") || 
						strCate4.equals("1636") || strCate4.equals("1642") || strCate4.equals("1643") || strCate4.equals("1807") || strCate4.equals("2115") || strCate4.equals("2211") || strCate4.equals("2241") || strCate4.equals("2401") || 
						strCate4.equals("2402") || strCate4.equals("2403") || strCate4.equals("2404") || strCate4.equals("2405") || strCate4.equals("2406") || strCate4.equals("2407") || strCate4.equals("0242") || strCate4.equals("0358") || 
						strCate4.equals("0622") || strCate4.equals("0424") || strCate4.equals("1629") || strCate4.equals("1644") 
					){
						bProdtxt = true;
					}else{
						bProdtxt = false; 
					}
 				}
 			}	
			if (strPCate.trim().length() == 0 ){ 
				strPCate = strCa_code;
			}	 		
			String strImgChkRolling = goods_data[i].getImgchk_rolling();
			long lngP_pl_no = goods_data[i].getP_pl_no();
			String strPImageUrl = goods_data[i].getP_imgurl();
			String strPImageUrlFlag = goods_data[i].getP_imgurlflag();
			String strImgChk = goods_data[i].getImgchk();
			String strImageUrl = ImageUtil.getImageSrc(strCate,intModelNo,strImgChk,lngP_pl_no,strPImageUrl,strPImageUrlFlag);
			String strImageUrl_er = "";
			String strSpec = goods_data[i].getSpec_group(); 
			String strModelName = ChkNull.chkStr(goods_data[i].getModelnm()," "); 
			
			String strFactory = goods_data[i].getFactory();
			String strBrand = goods_data[i].getBrand();
			int intSaleCnt = goods_data[i].getSale_cnt();
			int intSaleCnt_Sum = goods_data[i].getSum_sale_cnt();
			int intBbsCnt = goods_data[i].getBbs_num();
			
			String strModelnmText[] = getModel_FBN(strCa_code, strModelName, strFactory, strBrand);
			String strNm_factory = toJS2(strModelnmText[1]);
			String strNm_brand   = toJS2(strModelnmText[2]); 
			String strNm_model  = toJS2(strModelnmText[0]);
			 
			if(!strCate2.equals("93")){ 
				if(strNm_model.lastIndexOf("[")>0){ 
					strNm_model = strNm_model.substring(0,strNm_model.lastIndexOf("["));
				} 
			} 
			String strNm_New = strNm_factory + " "+ strNm_brand+ " "+ strNm_model; 
			strNm_New = strNm_New.replace("  "," ");
			//if(request.getRequestURI().indexOf("getSearch_ajax.jsp") > 0){
			//	strNm_New = strCate4+","+ strNm_New;
			//}
			
			String strMinPrice = goods_data[i].getMinprice()+"";
			if(DateUtil.RtnDateComment(CutStr.cutStr(goods_data[i].getC_date(),10),"2010_list","").equals("예정")){ 
				strMinPrice = "출시예정";
			}else if(goods_data[i].getMinprice3()==0 && ( strCate4.equals("0304") || strCate4.equals("0305") || strCate4.equals("0353"))){
				strMinPrice = "별도확인"; 
			}else{ 
				strMinPrice = FmtStr.moneyFormat(strMinPrice);
			} 
			String strMinPrice3 = goods_data[i].getMinprice3()+"";
			if(DateUtil.RtnDateComment(CutStr.cutStr(goods_data[i].getC_date(),10),"2010_list","").equals("예정")){ 
				strMinPrice3 = "출시예정";
			}else if(goods_data[i].getMinprice3()==0 && ( strCate4.equals("0304") || strCate4.equals("0305") || strCate4.equals("0353"))){
				strMinPrice3 = "별도확인"; 
			}else{ 
				strMinPrice3 = FmtStr.moneyFormat(strMinPrice3);
			}  
			
			if(!strCate4.equals("0304") && strMinPrice3.equals("0")){
				strMinPrice3 = "미정";
			}
			String strMallCnt = goods_data[i].getMallcnt()+"";
			String strMallCnt3 = goods_data[i].getMallcnt3()+"";
			String strCopyPhrase = goods_data[i].getKeyword2();
			String strCdate = goods_data[i].getC_date();
			String strCondiName = goods_data[i].getCondiname();
			String strMall_YN = "";
			String strOption_YN = "Y";
			String strSponsor = "";
			String strSoldOut_Y = "";
			String strSoldOut_N = "";
			String strHotIcon = "";
			String strViewCdate = "";
			String dateText = "";
			String strNew = "";
			String strNew2 = "";
			String strInfoAd_YN = "";
			
			//제조사, 브랜드명
			if( (i==0 && request.getRequestURI().indexOf("getList_ajax.jsp") > 0 ) || request.getRequestURI().indexOf("getSearch_ajax.jsp") > 0){
				if(request.getRequestURI().indexOf("getList_ajax.jsp") > 0){
					strCate = strCate;
				}else if(request.getRequestURI().indexOf("getSearch_ajax.jsp") > 0){
					strCate = strCa_code;
				}

				if(!strCate.equals("")){
					if(strCate.length() > 2 ){
						strFactoryCate = strCate.substring(0,2);
					}
				}

				if(strFactoryCate.length() > 0){
					FactoryBrand_Data factorybrand_data[] = FactoryBrand_Proc.FactoryBrand_flag(strFactoryCate); 
					strFactoryCateFlag = factorybrand_data[0].getStrFactory_view_flag();
				}
			}
				
			if(strFactoryCateFlag.equals("1")){
				strFactory = strFactory;
			}else if(strFactoryCateFlag.equals("2")){
				strFactory = strBrand;
			}else if(strFactoryCateFlag.equals("3")){
				if(strBrand.length() > 0){ 
					if(strFactory.equals(strBrand) || strFactory.indexOf(strBrand) > -1 ){
						strFactory = strFactory;
					}else{
						strFactory = strFactory +" "+ strBrand;
					}
				}
			}else if(strFactoryCateFlag.equals("4")){
				strFactory = ""; 
			}	
			
			
			//out.println("strBrand====="+strBrand);					
			//모델명
			if(strCate2.equals("14")){
				if(strModelName.indexOf("_") > -1){
				//	strModelName = strModelName.substring(0,strModelName.lastIndexOf("_"));
				}
			}  
			if((strCa_code2.equals("14_1") || strCa_code2.equals("93")) && request.getRequestURI().indexOf("getSearch_ajax.jsp") > -1){
				
			}else{
				if(!strCate2.equals("14_1") && !strCate2.equals("93")){
					if(strModelName.lastIndexOf("[")>0){ 
						strModelName = strModelName.substring(0,strModelName.lastIndexOf("["));
					}
				}	 
			}
			
			strModelName = Searchfunction.IsIn(strModelName,strSearckKeywordSynonym);	
			
			//제조사 
			strFactory = Searchfunction.IsIn(strFactory,strSearckKeywordSynonym);
    		if(!strFactory.equals("")){
    			strFactory = strFactory.replace("["," ").replace("]","");
    			strFactory = strFactory.replace("㈜","(주)");
    		}
			
			if(strFactory.length() > 0 && !strCate4.equals("0304") ){
				String astrFactory[] = strFactory.split(" ");
				for (int i_factory = 0; i_factory < astrFactory.length; i_factory++){
					if(strModelName.indexOf(astrFactory[i_factory]) >= 0 ){
						strFactory = strFactory.replace(astrFactory[i_factory], "");
					} 
				}
			}
			
			if(strFactory.trim().length() > 0){
			//	strFactory = "["+strFactory.trim()+"]";
    		}

 			if (strFactory.trim().equals("불명") || strFactory.trim().equals("없음")){
				strFactory = "";
			}   		
    							
			//카피문구(상품설명부분)
			//if (strCopyPhrase.trim().length() > 0 && !strCate4.equals("0703") && !strCate4.equals("0714") && !strCate4.equals("0925") && !CutStr.cutStr(strCate4,2).equals("14") && !CutStr.cutStr(strCate4,2).equals("15")){
				strCopyPhrase = ReplaceStr.replace(strCopyPhrase,"★","");
				strCopyPhrase = ReplaceStr.replace(strCopyPhrase,"▶","");
				strCopyPhrase = ReplaceStr.replace(strCopyPhrase,"\"","&quot;");
			//} 
			
			if(strCopyPhrase.length() > 47){
				//strCopyPhrase = strCopyPhrase.substring(0, 46);
			}
			if(strCate4.equals("0703") || strCate4.equals("0925") || strCate6.equals("070120") || strCate6.equals("070121") || strCate6.equals("070122") || strCate6.equals("070123")){
				strCopyPhrase = "";
			}
			//상품 상세 요약
			String[] astrSpecException = {"05160101","05160102","05160103","05160106","05160201","05160202","05160203","05160206","05160209",
	        "05160301","05160302","05160303","05160313","05160314","05160501","05160502","05160601","05160602","05160607","05160701","05160702",
	        "05160703","05161101","05161102","05161103","05161106","05161107","05161108","05161109","05161110","05161301","05161302","05161303","05161304"};
	        
	        
			boolean bSpecException = false;
			for (int si=0;si<astrSpecException.length;si++){
				if (strCate.equals(astrSpecException[si])){
					bSpecException = true;
				}
			}
	        if (bSpecException || strSpec.trim().length() == 0){
	        	strSpec = goods_data[i].getSpec();
	        }
	        if(strCate2.equals("15") && strSpec.trim().length() == 0){
	        	strSpec = strModelName;
	        }      
	         
			String strTempModelName = strModelName;
			String strBeginnerDicSpec = strSpec;
			String strBeginnerDicCate = strCate;
		
			boolean bSpecSynonymCheck = false; 
			if (goods_data[i].getFactory().equals(strFactory) && strTempModelName.equals(strModelName)){
				bSpecSynonymCheck = true;
			}
			//strBeginnerDicSpec = Searchfunction.IsInSpec(strBeginnerDicSpec,strSearckKeywordSynonym,bSpecSynonymCheck);	
			strBeginnerDicSpec = Searchfunction.IsIn(strBeginnerDicSpec,strSearckKeywordSynonym);
			
			if(strCate2.equals("14")){
				if(strBeginnerDicSpec.indexOf("> [") > -1){
					strBeginnerDicSpec = strBeginnerDicSpec.substring(strBeginnerDicSpec.indexOf("> [")+2, strBeginnerDicSpec.length());
				}
			}   
			strBeginnerDicSpec = ReplaceStr.replace(strBeginnerDicSpec, "</", "****");
			strBeginnerDicSpec = ReplaceStr.replace(strBeginnerDicSpec, "/", " / ");
			strBeginnerDicSpec = ReplaceStr.replace(strBeginnerDicSpec, "****", "</");
			strBeginnerDicSpec = ReplaceStr.replace(strBeginnerDicSpec, "   /   ", " / ");
			strBeginnerDicSpec = ReplaceStr.replace(strBeginnerDicSpec, "  /  ", " / ");
			strBeginnerDicSpec = ReplaceStr.replace(strBeginnerDicSpec, "<b>", ""); 
			strBeginnerDicSpec = ReplaceStr.replace(strBeginnerDicSpec, " </b>", "");
						
			//날짜
			strCdate = CutStr.cutStr(strCdate,10); 
			//strCdate = toDateText(strCdate,"");

			strViewCdate = DateUtil.RtnDateComment(strCdate,"2010_list",""); 
			
			if(!CutStr.cutStr(strCate4,2).equals("15")){
				if (strViewCdate.equals("예정")){
					dateText = "출시예정";
				}else{
					// 2012.03.07.imzig. 현재년도 이전 출시 상품은 출시월 정보 없이 출시년도만 표시
					int cdateYear = 0;
					int cdateMon = 0;
					 
					if(strCdate.length() > 0){
						cdateYear = Integer.parseInt(strCdate.substring(0,4));
						cdateMon =  Integer.parseInt(strCdate.substring(5,7));
					}
					int nowYear = Integer.parseInt(new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()));
					int nowMon = ChkNull.chkInt(DateStr.getYMD(DateStr.nowStr(),"M"));
					 
					if( strCdate.length() > 0 ){
						if( cdateYear < nowYear) {
							if(cdateYear == nowYear-1 && cdateMon > nowMon && nowMon < 3){
								if(strCdate.substring(5,6).equals("0")){
									dateText = "등록일 '"+strCdate.substring(2,4)+"년 "+strCdate.substring(6,7)+"월";
								}else{
									dateText = "등록일 '"+strCdate.substring(2,4)+"년 "+strCdate.substring(5,7)+"월";
								}	
							}else{
								dateText = "등록일 '"+strCdate.substring(2,4)+"년";
							}
						} else {			
							if(strCdate.substring(5,6).equals("0")){
								dateText = "등록일 '"+strCdate.substring(2,4)+"년 "+strCdate.substring(6,7)+"월";
							}else{
								dateText = "등록일 '"+strCdate.substring(2,4)+"년 "+strCdate.substring(5,7)+"월";
							}
						}
					}
				}
			} 				
					
			//그룹, 인기모델
			int intTempPopular = 0 ;
			int intPopularModelNo = 0;
			int intResizeModelNo = 0;
			
			Goods_Data[] now_goods_group_data = null;
	
			if (goods_data[i].getIsgroup() == 1 ){
		
				ArrayList arrayListGoods_group = new ArrayList();
				ArrayList arrayListGoods_group_c1 = new ArrayList();
				ArrayList arrayListGoods_group_c2 = new ArrayList();
				
		  		boolean bArrCondiEqual = false;
		  		if(strCondi.trim().length() > 0){
			  		for(int ii=0;ii<arrCondi.length;ii++){
			  			for (int jj=1;jj<arrCondi.length;jj++){
			  				if (arrCondi[ii].trim().indexOf(arrCondi[jj].trim()) >= 0 ){
			  					bArrCondiEqual = true;
			  				}
			  			}
					}
				}
				if (goods_all_group_data != null){
					for (int ai=0;ai<goods_all_group_data.length;ai++){
						if (intModelNo == goods_all_group_data[ai].getModelno_group()){
							boolean bEquals = false;
				  			if(strCondi.trim().length() > 0){
								for(int ii=0;ii<arrCondi.length;ii++){			
									if (bArrCondiEqual){
										if (goods_all_group_data[ai].getCondiname().trim().equals(ReplaceStr.replace(arrCondi[ii],"&#44;",",").trim())){
											bEquals = true;
											arrayListGoods_group_c1.add(goods_all_group_data[ai]);
										}											
									}else{
										if (goods_all_group_data[ai].getCondiname().trim().indexOf(ReplaceStr.replace(arrCondi[ii],"&#44;",",").trim()) == 0 ){
											bEquals = true;
											arrayListGoods_group_c1.add(goods_all_group_data[ai]);
										}
									}
								}
								if (!bEquals){
									arrayListGoods_group_c2.add(goods_all_group_data[ai]);
								}
							}else{
								arrayListGoods_group_c1.add(goods_all_group_data[ai]);
							}
						}		
					}
				}
				
				arrayListGoods_group.addAll(arrayListGoods_group_c1);
				arrayListGoods_group.addAll(arrayListGoods_group_c2);
				if (arrayListGoods_group.size() > 0 ){
					now_goods_group_data = (Goods_Data[])arrayListGoods_group.toArray(new Goods_Data[0]);
				}else{
					now_goods_group_data = new Goods_Data[1];
					now_goods_group_data[0] = goods_data[i];
				}
			}else{
				now_goods_group_data = new Goods_Data[1];
				now_goods_group_data[0] = goods_data[i];
			}
			
			Integer intGoodsGroupPopular[][] = new Integer[3][2];
			int intNowGoodsGroupDataLength = now_goods_group_data.length;

			int groupMallcnt = 0;
			int groupMallcnt2 = 0;
			String strRental = "";
			
			for (j=0;j<intNowGoodsGroupDataLength;j++){
				groupMallcnt = groupMallcnt + now_goods_group_data[j].getMallcnt();
				groupMallcnt2 = groupMallcnt2 + now_goods_group_data[j].getMallcnt3();
				//System.out.println("111="+i + " ,  "+j+"=====>"+now_goods_group_data[j].getCondiname());
				if(now_goods_group_data[j].getCondiname().equals("렌탈(월)") || now_goods_group_data[j].getCondiname().equals("렌탈")){
					strRental = "Y";
				}  
				
				if (!(now_goods_group_data[j].getCondiname().indexOf("리퍼") >= 0 || now_goods_group_data[j].getCondiname().indexOf("전시") >= 0|| 
					now_goods_group_data[j].getCondiname().indexOf("옵션필수") >= 0)){
					/*					 
					if (intGoodsGroupPopular[0][1] == null){
						intGoodsGroupPopular[0][0] = now_goods_group_data[j].getModelno();
						intGoodsGroupPopular[0][1] = now_goods_group_data[j].getPopular();
					}else if (intGoodsGroupPopular[1][1] == null){
						if (intGoodsGroupPopular[0][1] < now_goods_group_data[j].getPopular()){
							intGoodsGroupPopular[1][0] = intGoodsGroupPopular[0][0];
			  				intGoodsGroupPopular[1][1] = intGoodsGroupPopular[0][1];	
							intGoodsGroupPopular[0][0] = now_goods_group_data[j].getModelno();
							intGoodsGroupPopular[0][1] = now_goods_group_data[j].getPopular();  												
						}else{
							intGoodsGroupPopular[1][0] = now_goods_group_data[j].getModelno();
							intGoodsGroupPopular[1][1] = now_goods_group_data[j].getPopular();	  										
						}
					}else if (intGoodsGroupPopular[2][1] == null){
						if (intGoodsGroupPopular[0][1] < now_goods_group_data[j].getPopular()){
							intGoodsGroupPopular[2][0] = intGoodsGroupPopular[1][0];
			  				intGoodsGroupPopular[2][1] = intGoodsGroupPopular[1][1];
							intGoodsGroupPopular[1][0] = intGoodsGroupPopular[0][0];
			  				intGoodsGroupPopular[1][1] = intGoodsGroupPopular[0][1];
							intGoodsGroupPopular[0][0] = now_goods_group_data[j].getModelno();
							intGoodsGroupPopular[0][1] = now_goods_group_data[j].getPopular();
						}else if(intGoodsGroupPopular[1][1] < now_goods_group_data[j].getPopular()){
							intGoodsGroupPopular[2][0] = intGoodsGroupPopular[1][0];
			  				intGoodsGroupPopular[2][1] = intGoodsGroupPopular[1][1];	  
							intGoodsGroupPopular[1][0] = now_goods_group_data[j].getModelno();
							intGoodsGroupPopular[1][1] = now_goods_group_data[j].getPopular();  												
						}else{
				  			intGoodsGroupPopular[2][0] = now_goods_group_data[j].getModelno();
				  			intGoodsGroupPopular[2][1] = now_goods_group_data[j].getPopular();	  										
						}	  				
				  	}else if (intGoodsGroupPopular[0][1] < now_goods_group_data[j].getPopular()){
				  		if (intGoodsGroupPopular[1][1] != null){
							intGoodsGroupPopular[2][0] = intGoodsGroupPopular[1][0];
				  			intGoodsGroupPopular[2][1] = intGoodsGroupPopular[1][1];
				  		}
				  		intGoodsGroupPopular[1][0] = intGoodsGroupPopular[0][0];
						intGoodsGroupPopular[1][1] = intGoodsGroupPopular[0][1];  					
				  		intGoodsGroupPopular[0][0] = now_goods_group_data[j].getModelno();
						intGoodsGroupPopular[0][1] = now_goods_group_data[j].getPopular();  			
				  	}else if (intGoodsGroupPopular[1][1] != null && intGoodsGroupPopular[1][1] < now_goods_group_data[j].getPopular()){
						intGoodsGroupPopular[2][0] = intGoodsGroupPopular[1][0];
						intGoodsGroupPopular[2][1] = intGoodsGroupPopular[1][1];  					
						intGoodsGroupPopular[1][0] = now_goods_group_data[j].getModelno();
						intGoodsGroupPopular[1][1] = now_goods_group_data[j].getPopular();  					
					}else if(intGoodsGroupPopular[2][1] != null && intGoodsGroupPopular[2][1] < now_goods_group_data[j].getPopular()){
						intGoodsGroupPopular[2][0] = now_goods_group_data[j].getModelno();
						intGoodsGroupPopular[2][1] = now_goods_group_data[j].getPopular();  					
					}*/
		  		}
		  	}

		  	if(groupMallcnt > 0){
		  		strMallCnt = groupMallcnt + "";
		  		strMallCnt = FmtStr.moneyFormat(strMallCnt);
		  	}
		  	if(groupMallcnt2 > 0){
		  		strMallCnt3 = groupMallcnt2 + "";
		  		strMallCnt3 = FmtStr.moneyFormat(strMallCnt3);
		  	}
		  	if(dateText.equals("출시예정") ){	//출시예정 예외처리
		  		strMallCnt = "0";
		  		strNew = "";	//출시예정 
		  		strNew2 = "1";	//출시예정일때 가격비교 탭 비활성화
		  	}else if(strMinPrice.equals("별도확인") || strMinPrice3.equals("미정")){	
		  		strNew = "";	//별도확인
		  		strNew2 = "";
		  	}else{ 
		  		strNew = "1"; 
		  		strNew2 = "";
		  	}	

		  	int int15j = 0;
		  	int intPopj = 0;
		  	int intRepj = 0;
		  	boolean b15j = true; 
		  	
		  	int iGroupCnt = 0;
		  	
		  	for (j=0;j<intNowGoodsGroupDataLength;j++){
				if (now_goods_group_data[j].getPopular() >= intTempPopular   ){
					intPopularModelNo = now_goods_group_data[j].getModelno();
					intTempPopular = now_goods_group_data[j].getPopular();
					intPopj = j;
				}
				if (now_goods_group_data[j].getRsiflag2().equals("1")){
					intResizeModelNo = now_goods_group_data[j].getModelno();
				}
				if (now_goods_group_data[j].getP_pl_no()  > 0 && now_goods_group_data[j].getP_imgurlflag().equals("1") && b15j){
					int15j = j;
					b15j = false;
				}
				if (now_goods_group_data[j].getModelno() == intModelNo){
					intRepj = j;
				} 
				if(now_goods_group_data[j].getMinprice3() > 0){
					iGroupCnt = iGroupCnt + 1;
				} 
			}		 
			if (strKey.indexOf("minprice") >= 0 && intNowGoodsGroupDataLength > 0){
				intPopularModelNo = now_goods_group_data[0].getModelno();
			}
			if (strKeyword.trim().length() > 0 && intNowGoodsGroupDataLength > 0){
				intPopularModelNo = now_goods_group_data[0].getModelno();
			}		
			
			//작은이미지
			if ((strImgChk.trim().equals("1") && strCate4.equals("0905")) || strCate4.equals("0923")){	//인기상품
				strImageUrl =  ""+ImageUtil.getImageSrc(strCate4,now_goods_group_data[intPopj].getModelno(),now_goods_group_data[intPopj].getImgchk(),now_goods_group_data[intPopj].getP_pl_no(),now_goods_group_data[intPopj].getP_imgurl(),now_goods_group_data[intPopj].getP_imgurlflag());
			}else if(strImgChk.trim().equals("4") && strCate4.equals("0905")){							//마지막상품
				strImageUrl =  ImageUtil.getImageSrc(strCate4,now_goods_group_data[now_goods_group_data.length-1].getModelno(),strImgChk,lngP_pl_no,strPImageUrl,strPImageUrlFlag);
			}else if(CutStr.cutStr(strCate4,2).equals("15")){											//식품
				if (now_goods_group_data.length > 0 ){ 
					strImageUrl =  ImageUtil.getImageSrc("15",now_goods_group_data[int15j].getModelno(),now_goods_group_data[int15j].getImgchk(),now_goods_group_data[int15j].getP_pl_no(),now_goods_group_data[int15j].getP_imgurl(),now_goods_group_data[int15j].getP_imgurlflag());
				}
			}else if(strImgChk.trim().equals("8")){														//인기상품
				if ( now_goods_group_data.length > 0 ){ 
					strImageUrl =  ImageUtil.getImageSrc(strCate4,now_goods_group_data[int15j].getModelno(),now_goods_group_data[int15j].getImgchk(),now_goods_group_data[int15j].getP_pl_no(),now_goods_group_data[int15j].getP_imgurl(),now_goods_group_data[int15j].getP_imgurlflag());
				}else{	
					strImageUrl =  ImageUtil.getImageSrc(strCate4,intPopularModelNo,strImgChk,lngP_pl_no,strPImageUrl,strPImageUrlFlag);
				}
			}else{ 
				if (now_goods_group_data.length > 0 ){													//대표모델의 이미지정보로 작은이미지를 찾아온다
					strImageUrl =  ImageUtil.getImageSrc(strCate4,now_goods_group_data[intRepj].getModelno(),now_goods_group_data[intRepj].getImgchk(),now_goods_group_data[intRepj].getP_pl_no(),now_goods_group_data[int15j].getP_imgurl(),now_goods_group_data[int15j].getP_imgurlflag());
				}else{
					strImageUrl =  ImageUtil.getImageSrc(strCate4,intModelNo,strImgChk,lngP_pl_no,strPImageUrl,strPImageUrlFlag);
				}
			} 	
			/*유사상품*/
			if (goods_data[i].getConstrain().equals("5")){
				strImageUrl = goods_data[i].getP_imgurl2();
				if (strFactory.equals("추가")){
					strFactory = "";
				}		 
			}	
			strFactory = CutStr.cutStr(strFactory, 9); 
			
			// 성인인증 정보를 쿠키에서 읽어옴
			String chkAdult = cb.GetCookie("MEM_INFO", "ADULT");
			
			String strAdultImageUrl = getEnuriGoodsAdultImage(strCate4,"",strImageUrl,100);
			boolean bAdult = false;
			
			if (!chkAdult.equals("1") && !strAdultImageUrl.equals(strImageUrl)){
				strImageUrl = ConfigManager.IMG_ENURI_COM + "/images/mobilenew/images/img_19.jpg";
				bAdult = true;
			}
			if(isAdultCate(strCate4) && !chkAdult.equals("1")){
				strImageUrl = ConfigManager.IMG_ENURI_COM +"/images/mobilenew/images/img_19.jpg";
				bAdult = true;
			}
			//스폰서 엠블럼
			if (getIsSponserGoods(strCate, intModelNo)){
				strSponsor = "Y";
			}			 
			//단종,품절 엠블럼
			if (groupMallcnt == 0 && goods_data[i].getMinprice() == 0 && request.getRequestURI().indexOf("getListNew_ajax.jsp") < -1){
				strSoldOut_Y = "Y";
				strSoldOut_N = "";
				if(strMinPrice3.equals("미정")){ 
					strMinPrice3 = "";
				} 
				strNew2 = "1";	//출시예정일때 가격비교 탭 비활성화
			}else{
				strSoldOut_Y = "";
				strSoldOut_N = "Y";
			}
			
			//마음열기
			if(arrInfoAdModelNo!=null){
			    for(String strInfoAdModelNo:arrInfoAdModelNo){
			        if (cPage == 1 && strCate!=null && (strCate.length()==4 || strCate.length()==6) && goods_data[i].getModelno() == Integer.parseInt(strInfoAdModelNo)){
			        	strInfoAd_YN = "Y";
			        	 strInfoadModels += strInfoAdModelNo+",";
			        }
			    }
			}
			 
			//인기 1~3위 엠블럼
			if((cPage == 1 && ( strKey.equals("popular") || strKey.equals("popular DESC") )) ){
				if(  ( (strKeyword.trim().length() > 0 || strGetFactory.trim().length() > 0 || strMPrice.trim().length() > 0 || isAddSearchCate(strCate)) && ((strKey.equals("popular") || strKey.equals("popular DESC")) && cPage == 1)) ){
					if(i>=0 && i<intHot && i < 3){ 
						strHotIcon = (i+1)+"";
					}     
				}else{  
					if(intHot > 0){  
						if (goods_factory_hot_model_data != null){
							intHotNo = incMeta.RtnHotNo(intModelNo, goods_factory_hot_model_data); 
							if(intHotNo > -1 && intHotNo < 3){
								strHotIcon = (intHotNo+1)+""; 
								if (getIsSponserGoods(intModelNo)){
									strHotIcon = "";
								}							
							}
						}
					}
				}
			}	
			
			if( now_goods_group_data.length == 1 && strCondiName.equals("") ){
				strMall_YN = "Y";
				strOption_YN = "";
			}
			strImageUrl_er = strImageUrl;
			//strImageUrl = strImageUrl.replace("small","middle").replace(".gif",".jpg");
			if(strSponsor.equals("Y")){
			//	strImageUrl_er = ReplaceStr.replace(strImageUrl_er,intModelNo+"",intModelNo+"_o");
			}  
			//if(strImageUrl.indexOf("small") < 0 && strImageUrl.indexOf("middle") < 0  ){
			//	strImageUrl_er = ConfigManager.PHOTO_ENURI_COM+"/data/working.gif";
			//	strImageUrl_er = strImageUrl.replace("small","middle").replace(".gif",".jpg");
			//}
			String strImageUrl_middle = strImageUrl;
 
			String smallImgUrlFinder = "/data/images/service/small/";
			int smallFinderIdx = strImageUrl.indexOf(smallImgUrlFinder);
			// 500이미지로 변경
			if(smallFinderIdx>-1) {
				strImageUrl_middle = strImageUrl.substring(0, smallFinderIdx);
				strImageUrl_middle += "/data/images/service/middle/";
				strImageUrl_middle += strImageUrl.substring(smallFinderIdx + smallImgUrlFinder.length());

				int lastDotIdx = strImageUrl_middle.lastIndexOf(".");
				strImageUrl_middle = strImageUrl_middle.substring(0, lastDotIdx) + ".jpg";
			}  
			strMallCnt3 = strMallCnt3.replace("업체","").trim();
			if(strMallCnt3.equals("0")){
				strMallCnt3 = "";
			} 
			if(iGroupCnt == 0){
		  	//	strNew2 = "1";	
		  	}

			if(strModelName.length()>0) {
				if(listFirstPrintFlag) out.print("\r\n");	 			
		 			out.println("			{");
					out.println("			\"type\":\"list\", ");
					out.println("			\"modelno\":\""+intModelNo+"\", "); 
					out.println("			\"popularmodelno\":\""+intPopularModelNo+"\", ");
					out.println("			\"ca_code\":\""+toJS2(strCa_code)+"\", ");
					out.println("			\"p_pl_no\":\""+lngP_pl_no+"\", ");
					out.println("			\"goodscode\":\"\", ");
					out.println("			\"modelnm\":\""+strNm_New+"\", ");
					out.println("			\"mall_YN\":\""+toJS2(strMall_YN)+"\", ");  
		 			out.println("			\"option_YN\":\""+toJS2(strOption_YN)+"\", "); 
		 			//out.println("			\"factory\":\""+toJS2(strFactory)+"\", ");
		 			out.println("			\"minprice\":\""+toJS2(strMinPrice)+"\", ");
		 			out.println("			\"minprice3\":\""+toJS2(strMinPrice3)+"\", ");
		 			//if(iGroupCnt > 0){ 
		 				out.println("			\"group_cnt\":\""+(iGroupCnt)+"\", ");
		 			//}
		 			out.println("			\"copyphrase\":\""+toJS2(strCopyPhrase)+"\", ");
					out.println("			\"spec\":\""+toJS2(strBeginnerDicSpec)+"\", ");
					if(!bProdtxt  && strBeginnerDicSpec.length() < 29){
						out.println("			\"spec_length\":\"Y\", ");    
					}    
					if(bProdtxt){
						out.println("			\"prodtxt\":\"Y\", ");
						if(strBeginnerDicSpec.length() < 65){ 
							out.println("			\"spec_length\":\"Y\", ");     
						}
					}
					out.println("			\"imgurl\":\""+toJS2(strImageUrl_middle)+"\", "); 
					out.println("			\"imgurl_er\":\""+toJS2(strImageUrl_er)+"\", "); 
					out.println("			\"sponsor\":\""+toJS2(strSponsor)+"\", ");
					out.println("			\"info_ad\":\""+toJS2(strInfoAd_YN)+"\", ");
					out.println("			\"soldout_y\":\""+toJS2(strSoldOut_Y)+"\", ");
					out.println("			\"soldout_n\":\""+toJS2(strSoldOut_N)+"\", ");
					out.println("			\"hot\":\""+toJS2(strHotIcon)+"\", "); 
					out.println("			\"date\":\""+toJS2(dateText)+"\", ");
					out.println("			\"new\":\""+toJS2(strNew)+"\", ");
					out.println("			\"new2\":\""+toJS2(strNew2)+"\", ");
					out.println("			\"shopcode\":\"\", "); 
					out.println("			\"shopname\":\"\", ");  
					if(intBbsCnt > 0){  
						out.println("        \"bbs_num\":\""+FmtStr.moneyFormat(intBbsCnt)+"\", "); 
					}
					if(strRental.length() > 0 ){
						out.println("			\"rental\":\""+strRental+"\", ");
					}
					out.println("			\"zzimId\":\"btn_zzim_G"+intModelNo+"\", ");
					if(strMallCnt3.length() > 0 ){
						out.println("			\"mallcnt\":\"업체 : "+strMallCnt3+"\" , ");
					}else{ 
						out.println("			\"mallcnt\":\"업체 : 0\" , ");
					}
					if(strKey.equals("sale_cnt DESC")){
						if(intSaleCnt_Sum > 9){  
							out.println("			\"salecnt\":\""+FmtStr.moneyFormat(intSaleCnt_Sum)+"\" ,  ");
						}
						out.println("			\"mallcnt3\":\""+strMallCnt3+"\"   ");
					}else{ 
						if(intSaleCnt_Sum > 9){  
							out.println("			\"salecnt\":\""+FmtStr.moneyFormat(intSaleCnt_Sum)+"\" ,  ");
						} 
						out.println("			\"mallcnt3\":\""+strMallCnt3+"\" ");
					} 
					out.println("			}"); 
   
					listFirstPrintFlag = true;
				}
	 	out.println("\r\n	   ");	
	 	if( i < goods_data.length-1 ) out.println(" , ");	
	 	}
	 }
	
	//추가검색 상품 strPlNos 
	if (strPlNos.trim().length() > 0 ){
		String astrPlNos[] = strPlNos.split("\\,");
		if(goods_data != null)  out.println("\r\n  , ");	
		 
		for (int ipl=0;ipl<astrPlNos.length;ipl++){
			if (ChkNull.chkNumber(astrPlNos[ipl]) && ipl < astrPlNos.length){
				long lngPlNo = Long.parseLong(astrPlNos[ipl]);
	 
				if(strZzimmodelnos.length() == 0 ){
					strZzimmodelnos = "P:"+lngPlNo+"";
				}else{
					strZzimmodelnos = strZzimmodelnos + ",P:"+lngPlNo+"";
				}	
			
		    	Pricelist_Data pricelist_data_info = Mobile_Pricelist_Proc.getPricelistData(lngPlNo);
		    	String strGoodsName = "";
		    	String strPCa_Code = ""; 
		    	String strUrl = "";
		    	String strMoblieUrl = "";
		    	String strImgUrl = "";
		    	String strImgUrlFlag = "";
		    	String strDeliveryInfo = "";
		    	String strCateNm_93 = "";
		    	String strUdate ="";
		    	String strShopName = "";
		    	String dateText = "";
		    	long lngPrice = 0;
		    	long lngMobliePrice = 0;
		    	int intShopCode = 0;
		    	String mobile_url = "";
		    	String strGoodsCode = "";
		    	long lngMobileText = 0;
		    	String strGoodsFactory = "";
				String strImageUrl_er = "";
				String strSrvFlag = ""; 
				
		    	if(pricelist_data_info!=null){
			    	strSrvFlag = pricelist_data_info.getSrvflag();
		    		strGoodsName = pricelist_data_info.getGoodsnm();
		    		strPCa_Code = pricelist_data_info.getCa_code(); 
					if (strPCate.trim().length() == 0 ){ 
						strPCate = strPCa_Code;
					}	
			
		    		strGoodsFactory = pricelist_data_info.getGoodsfactory();
		    		if(!strGoodsFactory.equals("")){
		    			//strGoodsFactory = "["+strGoodsFactory+"]";
		    		}
					if (strGoodsFactory.trim().equals("불명") || strGoodsFactory.trim().equals("없음")){
						strGoodsFactory = "";
					}
			
		    		strUrl = pricelist_data_info.getUrl();
		    		strImgUrl = pricelist_data_info.getImgurl();
				    boolean bAdult2 = false;
				    // 성인인증 정보를 쿠키에서 읽어옴
					String chkAdult = cb.GetCookie("MEM_INFO", "ADULT");
				    
				    if (!chkAdult.equals("1") &&( bAdultKeyword || adultKeywordCheck(strGoodsName) || strSrvFlag.equals("S") )){
				    	bAdult2 = true;
				    	//strImgUrl = ConfigManager.IMG_ENURI_COM+"/2012/list/19_2.gif";
				    	strImgUrl = ConfigManager.IMG_ENURI_COM + "/images/mobilenew/images/img_19.jpg";
				    }
                    
                    if( strPCa_Code.length() >= 4){
					    if(!chkAdult.equals("1") && isAdultCate(strPCa_Code)){
					    	bAdult2 = true;
					    	//strImgUrl = ConfigManager.IMG_ENURI_COM+"/2012/list/19_2.gif";
					    	strImgUrl = ConfigManager.IMG_ENURI_COM + "/images/mobilenew/images/img_19.jpg";
					    }
                    }
                    
		    		strImgUrlFlag = pricelist_data_info.getImgurlflag();
		    		strImageUrl_er = ConfigManager.PHOTO_ENURI_COM+"/data/working.gif";
		    		lngPrice = pricelist_data_info.getPrice();
		    		lngMobliePrice = pricelist_data_info.getInstance_price();
		    		intShopCode = pricelist_data_info.getShop_code();
		    		strShopName = pricelist_data_info.getShop_name();
		    		strGoodsCode = pricelist_data_info.getGoodscode();
			    	strUdate = pricelist_data_info.getU_date();
			    	
			    	//날짜, 출시일
			    	strUdate = CutStr.cutStr(strUdate,10);				
					int cdateYear = 0;
					int cdateMon = 0; 
					
					if(strUdate.length() > 0){
						cdateYear = Integer.parseInt(strUdate.substring(0,4));
						cdateMon =  Integer.parseInt(strUdate.substring(5,7));
					} 
					
					int nowYear = Integer.parseInt(new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()));
			    	int nowMon = ChkNull.chkInt(DateStr.getYMD(DateStr.nowStr(),"M"));
					
					if( cdateYear < nowYear) {
						if(cdateYear == nowYear-1 && cdateMon > nowMon && nowMon < 3){
							if(strUdate.substring(5,6).equals("0")){
								dateText = "등록일 '"+strUdate.substring(2,4)+"년 "+strUdate.substring(6,7)+"월";
							}else{
								dateText = "등록일 '"+strUdate.substring(2,4)+"년 "+strUdate.substring(5,7)+"월";
							}	
						}else{
							dateText = "등록일 '"+strUdate.substring(2,4)+"년";
						}
					} else {			
						if(strUdate.substring(5,6).equals("0")){
							dateText = "등록일 '"+strUdate.substring(2,4)+"년 "+strUdate.substring(6,7)+"월";
						}else{
							dateText = "등록일 '"+strUdate.substring(2,4)+"년 "+strUdate.substring(5,7)+"월";
						}
					}
					
					//가격
					if(lngPrice < lngMobliePrice || lngMobliePrice == 0){
						lngMobileText = lngPrice;
					}else{
						lngMobileText = lngMobliePrice;
					}
					strGoodsFactory = CutStr.cutStr(strGoodsFactory, 9); 
					strGoodsFactory = strGoodsFactory.replace("㈜","(주)");
					
		 			out.println("			{");
		 			out.println("			\"type\":\"\", ");
					out.println("			\"modelno\":\""+lngPlNo+"\", ");
					out.println("			\"popularmodelno\":\"\", ");
					out.println("			\"ca_code\":\""+strPCa_Code+"\", ");
					out.println("			\"p_pl_no\":\""+lngPlNo+"\", ");
					out.println("			\"goodscode\":\""+strGoodsCode+"\", ");
					out.println("			\"modelnm\":\""+toJS2(strGoodsName)+"\", ");
					out.println("			\"mall_YN\":\"\", "); 
		 			out.println("			\"option_YN\":\"\", ");
		 			//out.println("			\"factory\":\""+strGoodsFactory+"\", ");
		 			out.println("			\"minprice\":\""+FmtStr.moneyFormat(lngMobileText+"")+"\", ");
		 			out.println("			\"minprice3\":\""+FmtStr.moneyFormat(lngMobileText+"")+"\", ");
		 			out.println("			\"copyphrase\":\"\", ");
					out.println("			\"imgurl\":\""+strImgUrl+"\", ");
					out.println("			\"imgurl_er\":\""+strImageUrl_er+"\", ");
					out.println("			\"mobileurl\":\""+toUrlCode(strUrl)+"\", ");
					out.println("			\"soldout_n\":\"y\", ");
					out.println("			\"date\":\""+dateText+"\", "); 
					out.println("			\"shopcode\":\""+intShopCode+"\", "); 
					out.println("			\"new\":\"1\" , ");
					out.println("			\"shopname\":\""+strShopName+"\", "); 
					out.println("			\"zzimId\":\"btn_zzim_P"+lngPlNo+"\", ");
					out.println("			\"mallcnt\":\""+strShopName+"\", ");
					out.println("			\"mallcnt3\":\""+strShopName+"\", ");
					out.println("			\"salecnt\":\"\" ");
					out.println("			}");
				}
				out.println("\r\n	   ");	 
				if( ipl < astrPlNos.length-1 && pricelist_data_info!=null) out.println(" , ");
			}
		}  
	}
	 out.println(" 	] ,   ");	 
	 out.println("	\"infoModels\": [ { \"Model\":\""+strInfoadModels+"\"  }] , ");
	 out.println("	\"zzimModel\": [ { \"Model\":\""+strZzimmodelnos+"\"  }] , ");
	 out.println("	\"pcate\": [ { \"pcate\":\""+strPCate+"\"  }]  ");
	 out.println("  }  ");	
%>