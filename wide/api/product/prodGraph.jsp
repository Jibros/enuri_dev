<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="com.enuri.bean.main.Goods_Detail_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Detail_Proc"%>
<%@ page import="com.enuri.util.common.JsonResponse"%>
<%@ page import="org.json.*" %>
<%@ include file="/view/zum/ajax/ajaxFunctions.jsp"%>

<%
	if(!CvtStr.isNumeric(request.getParameter("modelno"))){
		return ;
	}
	int modelNo = ChkNull.chkInt(request.getParameter("modelno"), 0);
	int nowMinprice = ChkNull.chkInt(request.getParameter("minprice"), 0);
	// showType=1 : 1개월, showType=3 : 3개월, showType=6 : 6개월
	int showType = ChkNull.chkInt(request.getParameter("showType"), 0);
	int dataGap = 1;
	int showMaxCnt = 6;
	int showGraphCnt = 0;
	
	int mTotalCnt = 0;
	Goods_Detail_Proc goods_detail_proc = new Goods_Detail_Proc();
	Goods_Detail_Data[] goods_detail_tot_data = goods_detail_proc.Goods_Price_List_Showtype(modelNo, 6);
	if(goods_detail_tot_data!=null){
		mTotalCnt = goods_detail_tot_data.length;
	}

	Goods_Detail_Data[] goods_detail_data = goods_detail_proc.Goods_Price_List_Showtype(modelNo, showType);
	JsonResponse ret = null;
	if(goods_detail_data!=null) {
		long maxPrice = 0;
		long minPrice = 0;
		long showMaxPrice = 0;
		long showMinPrice = 0;
		int itemCnt = 0;
		int totalCnt = 0;
		int maxIdx = -1;
		int minIdx = -1;

		// 총 데이터의 개수를 구함
		for(int i=0; i<goods_detail_data.length; i++) {
			totalCnt++;
		}
		if(showType==0) {
			if(mTotalCnt<12) showType = 1;
			else showType = 3;
		}

		if(showType==1) showMaxCnt = 4;
		else if(showType==3) showMaxCnt = totalCnt;
		else if(showType==6) showMaxCnt = totalCnt/2;
		if(totalCnt>=6){
			//if(showType==3) dataGap = totalCnt/6; // 2주 단위로 보여줌
			if(showType==6) dataGap = totalCnt/12; // 2주 단위로 보여줌
		}else dataGap = 1;
		
		
		// 최대값, 최저값을 먼저 구함
		for(int i=0; i<goods_detail_data.length; i=i+dataGap) {
			long wg_minprice = goods_detail_data[i].getWg_minprice();

			if(i==0) {
				maxPrice = wg_minprice;
				minPrice = wg_minprice;
			} else {
				if(maxPrice<=wg_minprice) {
					maxPrice = wg_minprice;
				}
				if(minPrice>=wg_minprice) {
					minPrice = wg_minprice;
				}
			}

			itemCnt++;

			if(itemCnt==showMaxCnt) break;
		}
		
		for(int i=0; i<goods_detail_data.length; i=i+dataGap) {
			long wg_minprice = goods_detail_data[i].getWg_minprice();
			if(maxPrice==wg_minprice) {
				maxIdx = i;
				break;
			}
		}
		for(int i=0; i<goods_detail_data.length; i=i+dataGap) {
			long wg_minprice = goods_detail_data[i].getWg_minprice();
			if(minPrice==wg_minprice) {
				minIdx = i;
				break;
			}
		}

		showMaxPrice = maxPrice;
		showMinPrice = minPrice;

		// minPrice가 -1이면 현재가가 최저가임
		if(goods_detail_data.length>0) {
			if(nowMinprice<=minPrice) minPrice = -1;
			if(nowMinprice>=maxPrice) maxPrice = -1;
		}

		// 최저가와 최고가가 같으면 모든 가격이 같은 것임
		if(maxPrice==minPrice) {
			minPrice = 0;
			maxPrice = 0;
		}
		
		ArrayList<JSONObject> arraylist = new ArrayList<JSONObject>();
		JSONObject jSONObject = new JSONObject();
		JSONObject rtnJSONObject = new JSONObject();
		Calendar cal = Calendar.getInstance();
		itemCnt = 0;
		// 최대값, 최저값을 먼저 구함
		for(int i=0; i<goods_detail_data.length; i=i+dataGap) {
			String wg_date_id = goods_detail_data[i].getWg_date_id();
			long wg_minprice = goods_detail_data[i].getWg_minprice();
			String wg_minpriceStr = setComma((int)wg_minprice);

			int intDay = 0;
			int sunDayCnt=0;
			String dateYM = "";
			int week = 0;
			dateYM = wg_date_id.substring(0, 6);
			try {
				week = Integer.parseInt(wg_date_id.substring(6));
			} catch(Exception e) {}

			int intYear=Integer.parseInt(dateYM.substring(0,4));
			int intMonth=Integer.parseInt(dateYM.substring(4,6));
			for (int j = 1; j <= 31; j++) {
				cal.set(Calendar.YEAR, intYear);
				cal.set(Calendar.MONTH, intMonth - 1);
				cal.set(Calendar.DAY_OF_MONTH, j);
				intDay = cal.get(Calendar.DAY_OF_WEEK); //현재 요일을 구한다.( 0:일요일, 1:월요일, 2:화요일, 3:수요일, 4:목요일, 5:금요일, 6:토요일 )
				if (intDay == 1) sunDayCnt++;

				if (week == sunDayCnt) {
					intDay = j;
					break;
				}
			}

			String startDay =  intMonth + "." + intDay;

			jSONObject = new JSONObject();
			jSONObject.put("date",dateYM+"-"+week);
			jSONObject.put("date_text",startDay);
			jSONObject.put("price",wg_minprice);
			if(minPrice>0 && minPrice==wg_minprice && i==minIdx) {
				jSONObject.put("labelLoc","m");
			} else if(maxPrice>0 && maxPrice==wg_minprice && i==maxIdx) {
				jSONObject.put("labelLoc","h");
			} else {
				jSONObject.put("labelLoc","");
			}

			arraylist.add(0,jSONObject);
			itemCnt++; 

			if(itemCnt==showMaxCnt) break;
		}

		jSONObject = new JSONObject();
		cal = Calendar.getInstance();
		jSONObject.put("date","(현재)");
		jSONObject.put("date_text","(현재)");
		jSONObject.put("price",nowMinprice);
		jSONObject.put("labelLoc","ne");
		arraylist.add(jSONObject);
		
		if(nowMinprice<=showMinPrice) showMinPrice = nowMinprice;
		if(nowMinprice>=showMaxPrice) showMaxPrice = nowMinprice;

		if(showMinPrice<=0) showMinPrice = nowMinprice;
		if(showMaxPrice<=0) showMaxPrice = nowMinprice;

		rtnJSONObject.put("graphDataCnt",totalCnt);
		rtnJSONObject.put("graphShowType",showType);
		rtnJSONObject.put("graphDataList",arraylist);
		rtnJSONObject.put("showGraphCnt",arraylist.size());
		rtnJSONObject.put("showMaxPrice",showMaxPrice);
		rtnJSONObject.put("showMinPrice",showMinPrice);

		ret = new JsonResponse(true).setData(rtnJSONObject).setTotal(totalCnt);
        out.println(ret.toString());
	}
%>