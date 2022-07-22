<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.main.Save_Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
{
<%
	String strID = cb.GetCookie("MEM_INFO","USER_ID");
	String modelnos = ChkNull.chkStr(request.getParameter("modelnos"), "");

	Save_Goods_Proc save_goods_proc = new Save_Goods_Proc();
	Goods_Data[] goods_data = null;

	String rtnValue = "";

	if(strID.length()>0 && modelnos.length()>0) {
	
	/*
		goods_data = save_goods_proc.getSaveGoodList(strID, "MEMBER");
		String zzimModelnoList = ",";

		if(goods_data!=null) {
			for(int i=0; i<goods_data.length; i++) {
				if(goods_data[i].getP_pl_no()>0) {
					zzimModelnoList += "P:"+goods_data[i].getModelno() + ",";
				} else {
					zzimModelnoList += "G:"+goods_data[i].getModelno() + ",";
				}
			}
		}
	*/
		String zzimModelnoList = ","+save_goods_proc.getSaveGoodNumList(strID);

		//out.println(strID+"==zzimModelnoList="+zzimModelnoList);

		String[] modelnosAry = modelnos.split(",");
		
		if(modelnosAry!=null) {
			for(int i=0; i<modelnosAry.length; i++) {
				String tempModelno = modelnosAry[i];
				if(tempModelno.indexOf("G:")<0 && tempModelno.indexOf("P:")<0) {
					tempModelno = "G:"+tempModelno;
				}

				if(zzimModelnoList.indexOf(","+tempModelno+",")>-1) {
					rtnValue += "1";
				} else {
					rtnValue += "0";
				}
				rtnValue += ",";
			}
		}
	}

	out.println("			\"rtnValue\":\""+rtnValue+"\" ");
%>
}
