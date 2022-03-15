<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="com.enuri.bean.mobile.depart.Save_Goods_Proc"%>
<%@ page import="com.enuri.bean.mobile.depart.Save_Goods_Data"%>
<%@ page import="com.enuri.util.common.JsonResponse"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>

<%

	if(!CvtStr.isNumeric(request.getParameter("modelno"))){
		return ;
	}

	JSONObject rtnJSONObject = new JSONObject();
	JsonResponse ret = null;
	String serverName = request.getServerName();
	
	//정상 통과
	String strModelno = ChkNull.chkStr(request.getParameter("modelno"), "");
	int intMinPrice = ChkNull.chkInt(request.getParameter("minprice"));


	if (strModelno != null && strModelno.length() > 0) {
		Save_Goods_Proc proc = new Save_Goods_Proc();
		try {
			JSONArray tmpWeekArray = proc.getWeekMinpriceItemList(strModelno);
			int month3Minprice = proc.getMonthMinprice(strModelno,3);
			int month1Minprice = proc.getMonthMinprice(strModelno,1);
			int weekMinprice = 0;
			JSONArray weekArray = new JSONArray();
			int beforeDayPrice = 0;
			int daydiff_price = 0;
			String daydiff_priceText = "";
			int percent = 0;
			//if(month3Minprice==0) month3Minprice = intMinPrice;
			//if(month1Minprice==0) month1Minprice = intMinPrice;
			
			if(tmpWeekArray.length() > 0){
				int limitCnt = (tmpWeekArray.length()>7) ? 7 : tmpWeekArray.length()-1;
				beforeDayPrice = tmpWeekArray.getJSONObject(tmpWeekArray.length()-1).getInt("minprice");
				for(int i=limitCnt;i>0;i--){
					int tmpPrice = tmpWeekArray.getJSONObject(i).getInt("minprice"); 
					if(i==limitCnt){
						weekMinprice = tmpPrice;
					}else{
						if(weekMinprice > tmpPrice){
							weekMinprice = tmpPrice;
						}
					}
					//weekArray.put(tmpWeekArray.getJSONObject(i));
				}
				daydiff_price = intMinPrice - beforeDayPrice;
				if(daydiff_price<0){
					daydiff_priceText = "어제보다 "+FmtStr.commaToMoney(Math.abs(daydiff_price))+"원 저렴합니다.";
				}
				//rtnJSONObject.put("week_data",weekArray);
			}
				rtnJSONObject.put("week_minprice",weekMinprice);
			//rtnJSONObject.put("daydiff_priceText",daydiff_priceText);
			//result.put("month3_minprice",(intMinPrice < month3Minprice ? String.valueOf(intMinPrice) : String.valueOf(month3Minprice)));
			//result.put("month1_minprice",(intMinPrice < month1Minprice ? String.valueOf(intMinPrice) : String.valueOf(month1Minprice)));

			rtnJSONObject.put("month3_minprice",month3Minprice);
			rtnJSONObject.put("month1_minprice",month1Minprice);
			ret = new JsonResponse(true).setData(rtnJSONObject);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}else{
		ret = new JsonResponse(false).setData(rtnJSONObject);
	}
	out.println(ret.toString());
%>

