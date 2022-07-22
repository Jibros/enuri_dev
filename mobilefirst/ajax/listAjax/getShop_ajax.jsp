<%
	int intShopAllCnt = 0;
	
	if(goods_shop_data!=null){
		if(goods_shop_data.length>0 || (goods_shop_data.length==0)){
			ArrayList arrayAllShop = new ArrayList();
			Goods_Data[] goods_All_Shop_data = goods_shop_data;
			
	 		if (goods_All_Shop_data != null) {
	 			Arrays.sort(goods_All_Shop_data,new com.enuri.bean.main.Factory_Mallcount_Comparator());
	 			intShopAllCnt = goods_All_Shop_data.length;
	 		}
	 		int intAllGoods = 0;
			for (int k3=0; k3 < goods_All_Shop_data.length ;k3++){
				intAllGoods = intAllGoods + goods_All_Shop_data[k3].getPopular();
			}	

			Goods_Data goods_Shop_single = new Goods_Data();
		
			int iPage = 0;
			String strNext = "";	// 줄넘김 구분자
			String strChecked = ""; // 선택된 제조사
			String strShopName = "";

			int iPage2 = 0;
			if(intShopAllCnt % 10 > 0){
				iPage2 = (intShopAllCnt / 10 ) + 1 ;
			}else{
				iPage2 = intShopAllCnt / 10;
			}
			
			j = -1;
			for (i=1 ;i < intShopAllCnt+1 ;i++){
				goods_Shop_single = goods_All_Shop_data[i-1];  
				if (goods_Shop_single.getFactory().trim().length() > 0){
					j = j+1; 							
					strChecked = "";
					strShopName = goods_Shop_single.getFactory().trim();
					if(j==0) out.println("{	\"factoryPage\":[ { \"pageCnt\":\""+intShopAllCnt/5+"\" } ]  ");
					if(j==0) out.println(", \"factoryNav\":[ { \"allCnt\":\""+intShopAllCnt+"\" , \"pageCnt\":\""+iPage2+"\"  } ]  ");
					if(j==0) out.println(",	\"factoryList\": [");
	 
					for (int af=0;af<astrGetShop.length;af++){
						if (astrGetShop[af].trim().equals(goods_Shop_single.getFactory_etc().trim())){
							strChecked = "checked ";
						}
					}	
						if(j % 10 == 9 ) 	strNext = "0";
						if(j>0) out.print(",\r\n");
						//out.print("	{                                       \"factoryNo\":\""+i+"\", \"factoryId\":\""+goods_Shop_single.getFactory_etc()+"\", \"factoryHot\":\"\", \"factoryChk\":\""+strChecked+"\", \"factoryName\":\""+strShopName+"\", \"factoryCnt\":\""+goods_Shop_single.getPopular()+"\" , \"factoryNext\":\""+strNext+"\" }");
						out.print("		{  \"factoryGroup\":\""+((j/10)+1)+"\", \"factoryNo\":\""+j+"\", \"factoryId\":\""+goods_Shop_single.getFactory_etc()+"\", \"factoryHot\":\"\", \"factoryChk\":\""+strChecked+"\", \"factoryName\":\""+strShopName+"\", \"factoryCnt\":\""+goods_Shop_single.getPopular()+"\" , \"factoryNext\":\""+strNext+"\" }");
					if(i == intShopAllCnt ) out.println("\r\n	] ");
					strNext = "";
				}
			}
			if(intShopAllCnt > 0 ){
				out.println(" }"); 
			}	
			
		}
	}

%>  	
