<%
	String strChkClass = "";
	String strBrandNameMargin = "";
	String strBrandClickFunction = "";
 
	String strBrandName = "";
	String strBrandName2 = "";
	
	if (ChkNull.chkStr(request.getParameter("keyword"),"").trim().length() == 0 && ChkNull.chkStr(request.getParameter("in_keyword"),"").trim().length() == 0){
		strChkClass = "chkbox";
		strBrandClickFunction = "clickBrandSearch";
	}else{
		strChkClass = "h_chkbox";
		strBrandNameMargin = "margin-left:5px";
		strBrandClickFunction = "clickBrandDirectSearch";
	}
	int intHotBrandCnt = 0;
	if (goods_brand_hot_data != null && goods_brand_hot_data.length > 0 ){
		intHotBrandCnt = goods_brand_hot_data.length;
	}
	
	int intBrandAllCnt = 0;
	int intSelectedBrandCnt = 0;
	if(goods_brand_data!=null){
		String strBrandSortName = "가나다 순";
				
		HttpSession sessionBrandSort = request.getSession();
		//String strBrandSort = ChkNull.chkStr((String)sessionBrandSort.getAttribute("brand_sort"),"").trim();
		String strBrandSort=ChkNull.chkStr(request.getParameter("brand_sort"));
		if (ChkNull.chkStr(request.getParameter("keyword"),"").trim().length() > 0 ){
		//	strBrandSort = "";
		}
		//if (CutStr.cutStr(strBrandSort,4).equals(CutStr.cutStr(strCate,4))){
		//	strBrandSort = strBrandSort.substring(strBrandSort.length()-1,strBrandSort.length());
		//}else{
		//	strBrandSort = "";
		//} 
	 
		
		if (strBrandSort.equals("G") || strBrandSort.trim().length() == 0){
			strBrandSortName = "가나다 순";
			Arrays.sort(goods_brand_data,new com.enuri.bean.main.Brand_Name_Comparator());
		}else if(strBrandSort.equals("C")){ 
			strBrandSortName = "상품수 순";  
			Arrays.sort(goods_brand_data,new com.enuri.bean.main.Factory_Mallcount_Comparator());
		}else if(strBrandSort.equals("P")){ 
			strBrandSortName = "인기도 순"; 
			Arrays.sort(goods_brand_data,new com.enuri.bean.main.Factory_Popular_Comparator());
		}  
		
		if(goods_brand_data.length>0 || (goods_brand_data.length==0 && intHotBrandCnt<3)){
 
			ArrayList arrayAllBrand = new ArrayList();
			ArrayList arrayBrand4 = new ArrayList(); 
			Goods_Data[] goods_All_brand_data= null; 
			
			if (strBrandSort.equals("G") || strBrandSort.trim().length() == 0){
				for(i=0; i<goods_brand_data.length;i++){
					String strTmpBrand = "";
					if (goods_brand_data[i].getBrand().trim().length() > 0){
						strTmpBrand = goods_brand_data[i].getBrand().trim().substring(0,1);
						if (com.enuri.util.common.Validation.isHan(strTmpBrand)){//한글인경우

							if(goods_brand_hot_data!=null){  									
								for (int kk=0;kk<intHotBrandCnt;kk++){
									if (goods_brand_hot_data[kk].getBrand().trim().equals(goods_brand_data[i].getBrand().trim())){
										goods_brand_data[i].setBrand_etc((kk+1)+"");
										goods_brand_hot_data[kk].setPopular(goods_brand_data[i].getPopular());
									}
								}
							}
							arrayAllBrand.add(goods_brand_data[i]);//한글 제조사 
						}
					}
				}
				for(i=0; i<goods_brand_data.length;i++){
					String strTmpBrand = "";
					if (goods_brand_data[i].getBrand().trim().length() > 0){
						strTmpBrand = goods_brand_data[i].getBrand().trim().substring(0,1);
						if (com.enuri.util.common.Validation.isAlphaNum(strTmpBrand)){	//영문인지 체크
							if(goods_brand_hot_data!=null){  								  									
								for (int kk=0;kk<intHotBrandCnt;kk++){
									if (goods_brand_hot_data[kk].getBrand().trim().equals(goods_brand_data[i].getBrand().trim())){
										goods_brand_data[i].setBrand_etc((kk+1)+"");
										goods_brand_hot_data[kk].setPopular(goods_brand_data[i].getPopular());
									}
								}
							}
							arrayAllBrand.add(goods_brand_data[i]);//영문 제조사

						}
					}
				}
				for(i=0; i<goods_brand_data.length;i++){
					String strTmpBrand = "";
					if (goods_brand_data[i].getBrand().trim().length() > 0){
						strTmpBrand = goods_brand_data[i].getBrand().trim().substring(0,1);
						if (!com.enuri.util.common.Validation.isHan(strTmpBrand) && !com.enuri.util.common.Validation.isAlphaNum(strTmpBrand)){	//특수문자
							if(goods_brand_hot_data!=null){  								  									
								for (int kk=0;kk<intHotBrandCnt;kk++){
									if (goods_brand_hot_data[kk].getBrand().trim().equals(goods_brand_data[i].getBrand().trim())){
										goods_brand_data[i].setBrand_etc((kk+1)+"");
										goods_brand_hot_data[kk].setPopular(goods_brand_data[i].getPopular());
									}
								}
							}
							arrayAllBrand.add(goods_brand_data[i]);//특수문자
						}
					}
				} 				
			}else{			
				/*for(i=0; i<goods_brand_data.length;i++){
					String strTmpBrand = "";
					if (goods_brand_data[i].getBrand().trim().length() > 0){
						strTmpBrand = goods_brand_data[i].getBrand().trim().substring(0,1);
						if(goods_brand_hot_data!=null){  									
							for (int kk=0;kk<intHotBrandCnt;kk++){
								if (goods_brand_hot_data[kk].getBrand().trim().equals(goods_brand_data[i].getBrand().trim())){
									goods_brand_data[i].setBrand_etc((kk+1)+"");
									goods_brand_hot_data[kk].setPopular(goods_brand_data[i].getPopular());
								}
							}
							arrayAllBrand.add(goods_brand_data[i]);//한글 제조사 
						}
					}
				}*/
				if ( goods_brand_hot_data != null  && !strBrandSort.equals("C")){
					for(i=0; i< goods_brand_hot_data.length;i++){  
						String strTmpBrand = "";
						if (goods_brand_hot_data[i].getBrand().trim().length() > 0){
							strTmpBrand = goods_brand_hot_data[i].getBrand().trim().substring(0,1);
							if(goods_brand_hot_data!=null){  									
								arrayAllBrand.add(goods_brand_hot_data[i]);
							} 
						}
					}			
				}	
				
				if(strBrandSort.equals("C")){
					int iSortPopular1 = 0;
					int iSortPopular2 = 0;
					
					ArrayList arrayBrand1 = new ArrayList();
					ArrayList arrayBrand2 = new ArrayList();
					ArrayList arrayBrand3 = new ArrayList();
					
					Goods_Data[] goods_All_brand_data1= null;
					Goods_Data[] goods_All_brand_data2= null;
					Goods_Data[] goods_All_brand_data3= null;
					
					for(i=0; i<goods_brand_data.length;i++){ 		
						if(!goods_brand_data[i].getBrand().equals("[불명]")){ 	 //불명 노출 안시킴		
							arrayAllBrand.add(goods_brand_data[0]);
						} 
					}
					goods_All_brand_data = (Goods_Data[])arrayAllBrand.toArray(new Goods_Data[0]);
 					
					for(i=0; i<goods_brand_data.length;i++){ 
						if(!goods_brand_data[i].getBrand().equals("[불명]") ){ 	 //불명 노출 안시킴		
						iSortPopular1 = goods_brand_data[i].getPopular();
						//out.println(i+"   "+iSortPopular1+"<br>");
						String strTmpBrand = "";
						if(strTmpBrand.trim().length() > 0){
							strTmpBrand = goods_brand_data[i].getBrand().trim().substring(0,1);
						}
							//out.println(iSortPopular1 + " / "+iSortPopular2 );
							if( i > 0 && iSortPopular1 < iSortPopular2 ){
								if(arrayBrand1 != null){
									goods_All_brand_data1 = null;
									goods_All_brand_data1 = (Goods_Data[])arrayBrand1.toArray(new Goods_Data[0]);
									for( int f1 = 0 ; f1 < goods_All_brand_data1.length ; f1++ ){
										arrayBrand4.add(goods_All_brand_data1[f1]);
									} 
								}
								if(arrayBrand2 != null){
									
									goods_All_brand_data2 = null;
									goods_All_brand_data2 = (Goods_Data[])arrayBrand2.toArray(new Goods_Data[0]);
									for( int f2 = 0 ; f2 < goods_All_brand_data2.length ; f2++ ){
										arrayBrand4.add(goods_All_brand_data2[f2]);
									}
								}
								if(arrayBrand3 != null){
									goods_All_brand_data3 = null;
									goods_All_brand_data3 = (Goods_Data[])arrayBrand3.toArray(new Goods_Data[0]);
									for( int f3 = 0 ; f3 < goods_All_brand_data3.length ; f3++ ){
										arrayBrand4.add(goods_All_brand_data3[f3]);
									}
								}
	
								arrayBrand1 = null;
								arrayBrand2 = null;
								arrayBrand3 = null;
								
								arrayBrand1 = new ArrayList();
								arrayBrand2 = new ArrayList();
								arrayBrand3 = new ArrayList();
							}else{
	
							}
							
							if (goods_brand_data[i] != null && goods_brand_data[i].getBrand().trim().length() > 0 ){
								if (com.enuri.util.common.Validation.isHan(strTmpBrand)){	//한글인경우
									arrayBrand1.add(goods_brand_data[i]);						//한글 제조사
								}else if (com.enuri.util.common.Validation.isAlphaNum(strTmpBrand)){	//영문인지 체크
									arrayBrand2.add(goods_brand_data[i]);									//영문 제조사
								}else{
									if (!com.enuri.util.common.Validation.isHan(strTmpBrand) && !com.enuri.util.common.Validation.isAlphaNum(strTmpBrand)){	//특수문자
										arrayBrand3.add(goods_brand_data[i]);	
										//out.println(goods_brand_data[i].getBrand());
									}
								}
	
							}
							
						iSortPopular2 = iSortPopular1;
						}
					}
					
					if(arrayBrand1 != null){
						goods_All_brand_data1 = null;
						goods_All_brand_data1 = (Goods_Data[])arrayBrand1.toArray(new Goods_Data[0]);
						for( int f1 = 0 ; f1 < goods_All_brand_data1.length ; f1++ ){
							arrayBrand4.add(goods_All_brand_data1[f1]);
						} 
					}
					if(arrayBrand2 != null){
						
						goods_All_brand_data2 = null;
						goods_All_brand_data2 = (Goods_Data[])arrayBrand2.toArray(new Goods_Data[0]);
						for( int f2 = 0 ; f2 < goods_All_brand_data2.length ; f2++ ){
							arrayBrand4.add(goods_All_brand_data2[f2]);
						}
					}
					if(arrayBrand3 != null){
						goods_All_brand_data3 = null;
						goods_All_brand_data3 = (Goods_Data[])arrayBrand3.toArray(new Goods_Data[0]);
						for( int f3 = 0 ; f3 < goods_All_brand_data3.length ; f3++ ){
							arrayBrand4.add(goods_All_brand_data3[f3]);
						}
					}

				}else{
					for(i=0; i<goods_brand_data.length;i++){ 
						if (goods_brand_data[i].getBrand().trim().length() > 0 ){
							if(!goods_brand_data[i].getBrand().equals("[불명]")){ 	 //불명 노출 안시킴									
								if(!strBrandSort.equals("C")){
									for (int kk=0;kk<intHotBrandCnt;kk++){ 
										if (goods_brand_hot_data[kk].getBrand().trim().equals(goods_brand_data[i].getBrand().trim())){
											goods_brand_data[i].setBrand_etc((kk+1)+"");
											goods_brand_hot_data[kk].setPopular(goods_brand_data[i].getPopular());
										}
									}
								}
								if(goods_brand_data[i].getBrand_etc().trim().length() == 0){ 
									arrayAllBrand.add(goods_brand_data[i]);//한글 제조사 
								}
							}
						}
					}
				}
				
			}
						
	 		if(!strBrandSort.equals("C")){
				goods_All_brand_data = (Goods_Data[])arrayAllBrand.toArray(new Goods_Data[0]);
			}else{
				goods_All_brand_data = (Goods_Data[])arrayBrand4.toArray(new Goods_Data[0]);
			}
			
	 		if (goods_All_brand_data != null) {
	 			intBrandAllCnt = goods_All_brand_data.length;
	 		}
	 		int iPage = 0;
	 		
			if(intBrandAllCnt % 10 > 0){
				iPage = (intBrandAllCnt / 10 ) + 1 ;
			}else{
				iPage = intBrandAllCnt / 10;
			}
			
			String strNext = "";	// 줄넘김 구분자
			String strPopular = "";	// 인기순위
			String strChecked = ""; // 선택된 제조사
	 
			for ( i=0 ; i < intBrandAllCnt ; i++){
				strChecked = "";
				if(i==0) out.println("{	\"brandPage\":[ { \"pageCnt\":\""+intBrandAllCnt/5+"\" } ]  ");
				if(i==0) out.println(", \"brandNav\":[ { \"allCnt\":\""+intBrandAllCnt+"\" , \"pageCnt\":\""+iPage+"\"  } ]  ");
				if(i==0) out.println(",	\"brandList\": [");
				if (goods_All_brand_data[i].getBrand_etc().trim().length() > 0){
					strPopular = goods_All_brand_data[i].getBrand_etc();
				}else{
					strPopular = "";
				} 
				for (int af=0;af<astrGetBrand.length;af++){ 
					if (astrGetBrand[af].trim().equals(goods_All_brand_data[i].getBrand().trim())){
						strChecked = "checked";
					}
				}	
				
				strBrandName = goods_All_brand_data[i].getBrand();

				if(strBrandName.indexOf("[") > 0){
					strBrandName2 = strBrandName.substring(strBrandName.indexOf("["), strBrandName.length());
					strBrandName = strBrandName.substring(0, strBrandName.indexOf("["));
					if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android")  > 0){
						if(strBrandName.length()>=8){
							strBrandName = CutStr.cutStr(strBrandName,8);
						}					
						if(strBrandName2.length()>=7){ 
							strBrandName2 = CutStr.cutStr(strBrandName2,7);
						}	
					}else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > 0){
						if(strBrandName.length()>=7){
							strBrandName = CutStr.cutStr(strBrandName,7);
						}
						if(strBrandName2.length()>=5){
							strBrandName2 = CutStr.cutStr(strBrandName2,5);
						}
										
					}
				}else{
					if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android")  > 0){
						if(strBrandName.length()>=13){
							strBrandName = CutStr.cutStr(strBrandName,13);
						}					
					}else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") > 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") > 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") > 0){
						if(strBrandName.length()>=10){
							strBrandName = CutStr.cutStr(strBrandName,10);
						}		 								
					}	 
				}		 	
					if(i % 10 == 9 ) 	strNext = "0";
					if(i == intBrandAllCnt-1 )	strNext = "";
					if(i>0) out.print(",\r\n");
					if(!strBrandSort.equals("P")){
						strPopular = "";
					}
					out.print("		{  \"brandGroup\":\""+((i/10)+1)+"\", \"brandNo\":\""+(i+1)+"\", \"brandId\":\""+toJS2(goods_All_brand_data[i].getBrand())+"\", \"brandHot\":\""+strPopular+"\", \"brandChk\":\""+strChecked+"\", \"brandName\":\""+toJS2(strBrandName)+"\", \"brandName2\":\""+toJS2(strBrandName2)+"\", \"brandCnt\":\""+FmtStr.moneyFormat(goods_All_brand_data[i].getPopular())+"\" , \"brandNext\":\""+strNext+"\" }");
				if(i == intBrandAllCnt-1 ) out.println("\r\n	] ");
				strNext = "";
				strBrandName2 = "";
				
			}
			if(intBrandAllCnt > 0 ){
				out.println(" }");
			}	
		}
	}
%>
<%!
public static String toJS2(String str){
	return str.replace("\\", "\\\\")
				.replace("\"", "\\\"")
				.replace("&" , "&amp;")
				.replace("\'", "&apos;")
				.replace("\b", "\\b")
				.replace("\f", "\\f")
				.replace("\n", "\\n")
				.replace("\r", "\\r")
				.replace("\t", "\\t");
}
%>