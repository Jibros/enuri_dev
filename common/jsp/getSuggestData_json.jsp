<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="org.json.*"%>
<%@ page import="java.util.*"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="com.enuri.bean.main.Main_SuggestGoods_Proc"%>
<%
	String strTodayGoods 	= "";
	String strTodayPrices 	= "";
	
	String[] arrStrTodayGoods;
	String[] arrStrTodayPrices;
	
	ArrayList<Integer> arrTodayGoodsModelno = new ArrayList<Integer>();
	ArrayList<Long> arrTodayGoodsPlno    = new ArrayList<Long>();
	
	int iTodayCnt = 0;
	
	strTodayGoods 	= cb.GetCookie("MYTODAYGOODS","MODELNOS");
	strTodayPrices 	= cb.GetCookie("MYTODAYGOODS","MINPRICE");

	Main_SuggestGoods_Proc main_suggestgoods_proc = new Main_SuggestGoods_Proc();
	
	JSONObject jsonObjTodayGoods = new JSONObject();
	JSONArray  jsonArrTodayGoods = new JSONArray();
	
    out.println("{");
    out.println("\"suggestList\":[");
    
	if(strTodayGoods != null && !strTodayGoods.equals("")) {
	   	arrStrTodayGoods  = strTodayGoods.split("\\,");	   
	   	arrStrTodayPrices = strTodayPrices.split("\\,");
	   	
	   	iTodayCnt = arrStrTodayGoods.length;
		iTodayCnt = iTodayCnt < arrStrTodayPrices.length ? arrStrTodayPrices.length : iTodayCnt;

		if(iTodayCnt>0){
			for(int i=0;i<(iTodayCnt > 50 ? 50 : iTodayCnt);i++){
			    JSONObject jsonTodayGoods = new JSONObject();
			    
			    jsonTodayGoods.put("goodsType"	 , arrStrTodayGoods[i].split(":")[0]);
			    jsonTodayGoods.put("goodsModelno", arrStrTodayGoods[i].split(":")[1]);
 			    jsonTodayGoods.put("goodsPrice"  , arrStrTodayPrices.length < arrStrTodayGoods.length ? "0" : arrStrTodayPrices[i].toString());
			    
			    if(arrStrTodayGoods[i].split(":")[0].equals("G")){
			        arrTodayGoodsModelno.add(Integer.parseInt(arrStrTodayGoods[i].split(":")[1].toString()));
			    }else{
			        arrTodayGoodsPlno.add(Long.parseLong(arrStrTodayGoods[i].split(":")[1].toString()));
			    }
			    
			    jsonArrTodayGoods.put(jsonTodayGoods);
			}

			jsonObjTodayGoods.put("TodayGoods",jsonArrTodayGoods);
			
			out.println(main_suggestgoods_proc.getGoodsFromRecent(arrTodayGoodsModelno.toString().replace("[","").replace("]",""),ChkNull.chkStr(cb.GetCookie("MEM_INFO","ADULT"))).toString());
		    out.println(",\r\n");
			out.println(main_suggestgoods_proc.getPriceListFromRecent(arrTodayGoodsPlno.toString().replace("[","").replace("]",""),ChkNull.chkStr(cb.GetCookie("MEM_INFO","ADULT"))).toString());
		    out.println(",\r\n");		    
			out.println(jsonObjTodayGoods.toString());
		} else {
		    out.println(main_suggestgoods_proc.getDefaultGoods(ChkNull.chkStr(cb.GetCookie("MEM_INFO","ADULT"))).toString());
		}		
	} else {
		out.println(main_suggestgoods_proc.getDefaultGoods2Num(ChkNull.chkStr(cb.GetCookie("MEM_INFO","ADULT")), 18).toString());	    
	}
	
	out.println("]}");
%>	    
