<%

	int intHotFacCnt = 0;
	if (goods_factory_hot_data != null && goods_factory_hot_data.length > 0 ){
		intHotFacCnt = goods_factory_hot_data.length;
	} 
	
	int intFactoryAllCnt = 0;
	String strFactoryName = "";
	String strFactoryName2 = "";
	int iFactoryCnt = 0;

	if(goods_factory_data!=null){
		String strFactorySortName = "가나다 순";
				
		//HttpSession sessionFactorySort = request.getSession();
		//String strFactorySort = ChkNull.chkStr((String)sessionFactorySort.getAttribute("factory_sort"),"").trim();
		String strFactorySort=ChkNull.chkStr(request.getParameter("factory_sort"));
		
		/*if (CutStr.cutStr(strFactorySort,4).equals(CutStr.cutStr(strCate,4))){
			strFactorySort = strFactorySort.substring(strFactorySort.length()-1,strFactorySort.length());
		}else{
			strFactorySort = "";
		}*/ 
		//strFactorySort = "G";
		if (strFactorySort.equals("G") || strFactorySort.trim().length() == 0){
			strFactorySortName = "가나다 순";
			Arrays.sort(goods_factory_data,new com.enuri.bean.main.Factory_Name_Comparator());
		}else if(strFactorySort.equals("C")){
			strFactorySortName = "상품수 순";
			Arrays.sort(goods_factory_data,new com.enuri.bean.main.Factory_Mallcount_Comparator());
		}else if(strFactorySort.equals("P")){
			strFactorySortName = "인기도 순";
			Arrays.sort(goods_factory_data,new com.enuri.bean.main.Factory_Popular_Comparator());
		}
			
		if(goods_factory_data.length>0 || (goods_factory_data.length==0 && intHotFacCnt<3)){
			ArrayList arrayAllFactory = new ArrayList();
			ArrayList arrayFactory4 = new ArrayList();
			Goods_Data[] goods_All_factory_data= null;
					
			if (strFactorySort.equals("G") || strFactorySort.trim().length() == 0){
				/*if ( goods_factory_hot_data != null ){
					for(i=0; i< goods_factory_hot_data.length;i++){ 
						String strTmpFactory = "";
						if (goods_factory_hot_data[i].getFactory().trim().length() > 0){
							strTmpFactory = goods_factory_hot_data[i].getFactory().trim().substring(0,1);
							if(goods_factory_hot_data!=null){  									
								arrayAllFactory.add(goods_factory_hot_data[i]);
							}
						}
					}			 
				}	*/			
				for(i=0; i<goods_factory_data.length;i++){
					String strTmpFactory = "";
					if (goods_factory_data[i].getFactory().trim().length() > 0){
						strTmpFactory = goods_factory_data[i].getFactory().trim().substring(0,1);
						if (com.enuri.util.common.Validation.isHan(strTmpFactory)){//한글인경우
							if(goods_factory_hot_data!=null){  									
								for (int kk=0;kk<intHotFacCnt;kk++){
									if (goods_factory_hot_data[kk].getFactory().trim().equals(goods_factory_data[i].getFactory().trim())){
										goods_factory_data[i].setFactory_etc((kk+1)+"");
										goods_factory_hot_data[kk].setPopular(goods_factory_data[i].getPopular());
									}
								}
							}
							arrayAllFactory.add(goods_factory_data[i]);//한글 제조사 
						}
					}
				}
				for(i=0; i<goods_factory_data.length;i++){
					String strTmpFactory = "";
					if (goods_factory_data[i].getFactory().trim().length() > 0){
						strTmpFactory = goods_factory_data[i].getFactory().trim().substring(0,1);
						if (com.enuri.util.common.Validation.isAlphaNum(strTmpFactory)){	//영문인지 체크
							if(goods_factory_hot_data!=null){  								  									
								for (int kk=0;kk<intHotFacCnt;kk++){
									if (goods_factory_hot_data[kk].getFactory().trim().equals(goods_factory_data[i].getFactory().trim())){
										goods_factory_data[i].setFactory_etc((kk+1)+"");
										goods_factory_hot_data[kk].setPopular(goods_factory_data[i].getPopular());
									}
								}
							}
							arrayAllFactory.add(goods_factory_data[i]);//영문 제조사

						}
					}
				}
				for(i=0; i<goods_factory_data.length;i++){
					String strTmpFactory = "";
					if (goods_factory_data[i].getFactory().trim().length() > 0){
						if(!goods_factory_data[i].getFactory().equals("[불명]")){ 	 //불명 노출 안시킴
							strTmpFactory = goods_factory_data[i].getFactory().trim().substring(0,1);
							if (!com.enuri.util.common.Validation.isHan(strTmpFactory) && !com.enuri.util.common.Validation.isAlphaNum(strTmpFactory)){	//특수문자
								if(goods_factory_hot_data!=null){  								  									
									for (int kk=0;kk<intHotFacCnt;kk++){
										if (goods_factory_hot_data[kk].getFactory().trim().equals(goods_factory_data[i].getFactory().trim())){
											goods_factory_data[i].setFactory_etc((kk+1)+"");
											goods_factory_hot_data[kk].setPopular(goods_factory_data[i].getPopular());
										}
									}
								}
								arrayAllFactory.add(goods_factory_data[i]);//특수문자
							}
						}
					} 
				} 				
			}else{			
			//out.println("goods_factory_hot_data==="+goods_factory_hot_data.length);
			//out.println("goods_factory_data==="+goods_factory_data.length);

				if ( goods_factory_hot_data != null  && !strFactorySort.equals("C")){
					for(i=0; i< goods_factory_hot_data.length;i++){  
						String strTmpFactory = "";
						if (goods_factory_hot_data[i].getFactory().trim().length() > 0){
							strTmpFactory = goods_factory_hot_data[i].getFactory().trim().substring(0,1);
							if(goods_factory_hot_data!=null){  									
								arrayAllFactory.add(goods_factory_hot_data[i]);
							}
						}
					}			
				}	
				if(strFactorySort.equals("C")){
					int iSortPopular1 = 0;
					int iSortPopular2 = 0;
					
					ArrayList arrayFactory1 = new ArrayList();
					ArrayList arrayFactory2 = new ArrayList();
					ArrayList arrayFactory3 = new ArrayList();
					
					Goods_Data[] goods_All_factory_data1= null;
					Goods_Data[] goods_All_factory_data2= null;
					Goods_Data[] goods_All_factory_data3= null;
					
					for(i=0; i<goods_factory_data.length;i++){ 		
						if(!goods_factory_data[i].getFactory().equals("[불명]")){ 	 //불명 노출 안시킴		
							arrayAllFactory.add(goods_factory_data[0]);
						} 
					}
					goods_All_factory_data = (Goods_Data[])arrayAllFactory.toArray(new Goods_Data[0]);
 
					
					for(i=0; i<goods_factory_data.length;i++){ 
						if(!goods_factory_data[i].getFactory().equals("[불명]") ){ 	 //불명 노출 안시킴		
						iSortPopular1 = goods_factory_data[i].getPopular();
						//out.println(i+"   "+iSortPopular1+"<br>");
						String strTmpFactory = goods_factory_data[i].getFactory().trim().substring(0,1);
						//out.println(iSortPopular1 + " / "+iSortPopular2 );
							if( i > 0 && iSortPopular1 < iSortPopular2 ){
								if(arrayFactory1 != null){
									goods_All_factory_data1 = null;
									goods_All_factory_data1 = (Goods_Data[])arrayFactory1.toArray(new Goods_Data[0]);
									for( int f1 = 0 ; f1 < goods_All_factory_data1.length ; f1++ ){
										arrayFactory4.add(goods_All_factory_data1[f1]);
									} 
								}
								if(arrayFactory2 != null){
									
									goods_All_factory_data2 = null;
									goods_All_factory_data2 = (Goods_Data[])arrayFactory2.toArray(new Goods_Data[0]);
									for( int f2 = 0 ; f2 < goods_All_factory_data2.length ; f2++ ){
										arrayFactory4.add(goods_All_factory_data2[f2]);
									}
								}
								if(arrayFactory3 != null){
									goods_All_factory_data3 = null;
									goods_All_factory_data3 = (Goods_Data[])arrayFactory3.toArray(new Goods_Data[0]);
									for( int f3 = 0 ; f3 < goods_All_factory_data3.length ; f3++ ){
										arrayFactory4.add(goods_All_factory_data3[f3]);
									}
								}
	
								arrayFactory1 = null;
								arrayFactory2 = null;
								arrayFactory3 = null;
								
								arrayFactory1 = new ArrayList();
								arrayFactory2 = new ArrayList();
								arrayFactory3 = new ArrayList();
							}else{
	
							}
							
							if (goods_factory_data[i] != null && goods_factory_data[i].getFactory().trim().length() > 0 ){
								if (com.enuri.util.common.Validation.isHan(strTmpFactory)){	//한글인경우
									arrayFactory1.add(goods_factory_data[i]);						//한글 제조사
								}else if (com.enuri.util.common.Validation.isAlphaNum(strTmpFactory)){	//영문인지 체크
									arrayFactory2.add(goods_factory_data[i]);									//영문 제조사
								}else{
									if (!com.enuri.util.common.Validation.isHan(strTmpFactory) && !com.enuri.util.common.Validation.isAlphaNum(strTmpFactory)){	//특수문자
										arrayFactory3.add(goods_factory_data[i]);	
										//out.println(goods_factory_data[i].getFactory());
									}
								}
	
							}
							
						iSortPopular2 = iSortPopular1;
						}
					}
					
					if(arrayFactory1 != null){
						goods_All_factory_data1 = null;
						goods_All_factory_data1 = (Goods_Data[])arrayFactory1.toArray(new Goods_Data[0]);
						for( int f1 = 0 ; f1 < goods_All_factory_data1.length ; f1++ ){
							arrayFactory4.add(goods_All_factory_data1[f1]);
						} 
					}
					if(arrayFactory2 != null){
						
						goods_All_factory_data2 = null;
						goods_All_factory_data2 = (Goods_Data[])arrayFactory2.toArray(new Goods_Data[0]);
						for( int f2 = 0 ; f2 < goods_All_factory_data2.length ; f2++ ){
							arrayFactory4.add(goods_All_factory_data2[f2]);
						}
					}
					if(arrayFactory3 != null){
						goods_All_factory_data3 = null;
						goods_All_factory_data3 = (Goods_Data[])arrayFactory3.toArray(new Goods_Data[0]);
						for( int f3 = 0 ; f3 < goods_All_factory_data3.length ; f3++ ){
							arrayFactory4.add(goods_All_factory_data3[f3]);
						}
					}

				}else{
					for(i=0; i<goods_factory_data.length;i++){ 
						if (goods_factory_data[i].getFactory().trim().length() > 0 ){
							if(!goods_factory_data[i].getFactory().equals("[불명]")){ 	 //불명 노출 안시킴									
								for (int kk=0;kk<intHotFacCnt;kk++){ 
									if (goods_factory_hot_data[kk].getFactory().trim().equals(goods_factory_data[i].getFactory().trim())){
										goods_factory_data[i].setFactory_etc((kk+1)+"");
										goods_factory_hot_data[kk].setPopular(goods_factory_data[i].getPopular());
									}
									
								}
								if(goods_factory_data[i].getFactory_etc().trim().length() == 0){ 
									arrayAllFactory.add(goods_factory_data[i]);//한글 제조사 
								}
							}
						}
					}
				}
			}

			if(!strFactorySort.equals("C")){
				goods_All_factory_data = (Goods_Data[])arrayAllFactory.toArray(new Goods_Data[0]);
			}else{
				goods_All_factory_data = (Goods_Data[])arrayFactory4.toArray(new Goods_Data[0]);
			}
			
	 		if (goods_All_factory_data != null) {
	 			intFactoryAllCnt = goods_All_factory_data.length;
	 		}

			Goods_Data goods_factory_single = new Goods_Data(); //실제로 보여줄 factory 용
			
			int iPage = 0;
			if(intFactoryAllCnt % 10 > 0){
				iPage = (intFactoryAllCnt / 10 ) + 1 ;
			}else{
				iPage = intFactoryAllCnt / 10;
			}
			
			String strNext = "";	// 줄넘김 구분자
			String strPopular = "";	// 인기순위
			String strChecked = ""; // 선택된 제조사
 
			for ( i=0 ; i < intFactoryAllCnt ; i++){
				strChecked = "";
				if(i==0) out.println("{	\"factoryPage\":[ { \"pageCnt\":\""+intFactoryAllCnt/5+"\" } ]  ");
				if(i==0) out.println(", \"factoryNav\":[ { \"allCnt\":\""+intFactoryAllCnt+"\" , \"pageCnt\":\""+iPage+"\"  } ]  ");
				if(i==0) out.println(",	\"factoryList\": [");
				if (goods_All_factory_data[i].getFactory_etc().trim().length() > 0){
					strPopular = goods_All_factory_data[i].getFactory_etc();
				}else{
					strPopular = "";
				}
				for (int af=0;af<astrGetFactory.length;af++){ 
					if (astrGetFactory[af].trim().equals(goods_All_factory_data[i].getFactory().trim())){
						strChecked = "checked";
					}
				}	
				
				strFactoryName = goods_All_factory_data[i].getFactory();

				if(strFactoryName.indexOf("[") > 0){
					strFactoryName2 = strFactoryName.substring(strFactoryName.indexOf("["), strFactoryName.length());
					strFactoryName = strFactoryName.substring(0, strFactoryName.indexOf("["));
					if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android")  > 0){
						if(strFactoryName.length()>=8){
							strFactoryName = CutStr.cutStr(strFactoryName,8);
						}					
						if(strFactoryName2.length()>=7){ 
							strFactoryName2 = CutStr.cutStr(strFactoryName2,7);
						}	
					}else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > 0){
						if(strFactoryName.length()>=7){
							strFactoryName = CutStr.cutStr(strFactoryName,7);
						}
						if(strFactoryName2.length()>=5){
							strFactoryName2 = CutStr.cutStr(strFactoryName2,5);
						}
										
					}
				}else{
					if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android")  > 0){
						if(strFactoryName.length()>=13){
							strFactoryName = CutStr.cutStr(strFactoryName,13);
						}					
					}else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > 0){
						if(strFactoryName.length()>=10){
							strFactoryName = CutStr.cutStr(strFactoryName,10);
						}		 								
					}	 
				}		 	
					if(i % 10 == 9 ) 	strNext = "0";
					if(i == intFactoryAllCnt-1 )	strNext = "";
					if(i>0) out.print(",\r\n");
					if(!strFactorySort.equals("P")){
						strPopular = "";
					}
					out.print("		{  \"factoryGroup\":\""+((i/10)+1)+"\", \"factoryNo\":\""+(i+1)+"\", \"factoryId\":\""+goods_All_factory_data[i].getFactory()+"\", \"factoryHot\":\""+strPopular+"\", \"factoryChk\":\""+strChecked+"\", \"factoryName\":\""+strFactoryName+"\", \"factoryName2\":\""+strFactoryName2+"\", \"factoryCnt\":\""+FmtStr.moneyFormat(goods_All_factory_data[i].getPopular())+"\" , \"factoryNext\":\""+strNext+"\" }");
				if(i == intFactoryAllCnt-1 ) out.println("\r\n	] ");
				strNext = "";
				strFactoryName2 = "";
				
			}
			if(intFactoryAllCnt > 0 ){
				out.println(" }");
			}	
	}
}
%>