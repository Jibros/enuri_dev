<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.depart.Save_Goods_Proc"%>
<%@ page import="com.enuri.bean.mobile.depart.Save_Goods_Data"%>
<%@ page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_PD_Data"%>
<%

//20171113 손진욱 t1 pd 모듈
	PDManager_Proc pdmanager = new PDManager_Proc();
	PDManager_PD_Data pdData = pdmanager.chkT1PD(request);
	String strPrice = ChkNull.chkStr(request.getParameter("price"),"");
	int intCount = 0;
	boolean strReturn = false;
	if(pdData != null && pdData.isData()){
		String sApp_type 			= pdData.getAppid();
		String sTime		 			= pdData.getTimes();
		String sUuid					= pdData.getUuid();
		String sEnuri_id				= pdData.getEnuri_id();
		
		String strModelNos = ChkNull.chkStr(request.getParameter("modelnos"),"");
		Save_Goods_Proc save_goods_proc = new Save_Goods_Proc();
		String astrModelNos[] = strModelNos.split(",");	
		for (int i=0;i<astrModelNos.length;i++){
			if (astrModelNos[i].length() > 0 ){
				Save_Goods_Data saveGoodsData = new Save_Goods_Data();
				String tempModelno = astrModelNos[i];
				int intTempModelno = 0;
				long lngTempPlno = 0;				
				if(tempModelno.indexOf("G:")>-1 || (tempModelno.indexOf("G:")<0 && tempModelno.indexOf("P:")<0)) {
					tempModelno = tempModelno.replace("G:", "");
					try {
						intTempModelno = Integer.parseInt(tempModelno);
					} catch(Exception e) {}
					saveGoodsData.setIntModelNo(intTempModelno);
				}
				if(tempModelno.indexOf("P:")>-1) {
					tempModelno = tempModelno.replace("P:", "");
					try {
						lngTempPlno = Long.parseLong(tempModelno);
					} catch(Exception e) {}
					saveGoodsData.setPl_no(lngTempPlno);
				}
				saveGoodsData.setStrId(sEnuri_id);
				
				String appId = "", appType = "";				
				if(sApp_type.length() == 5) {
					appType = sApp_type.substring(0, 1);
					appId = sApp_type.substring(1);
				}
				
				strReturn = save_goods_proc.insertMinpriceGoods(appId, appType, saveGoodsData, strPrice.trim());				
				int intReturn = save_goods_proc.insertSaveGoodsForMinprice(saveGoodsData,"MEMBER");
				if (intReturn >= 0){
					intCount = intCount + intReturn;
				}else{
					intCount = -1;	
					break;
				}				
			}
		}
	}
	out.println("{");
	out.println("	   \"result\": \""+ strReturn +"\", ");
	out.println("	   \"intCount\": \""+ intCount +"\" ");
	out.println("}");
%>
