<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.main.Save_Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.JSONArray"%>
<%
	String strID = cb.GetCookie("MEM_INFO","USER_ID");

	Save_Goods_Proc save_goods_proc = new Save_Goods_Proc();
    
    JSONArray jsonArray = new JSONArray();
    
	if(strID.length()>0 ) {
        //String goodsNum = StringUtils.defaultString(StringUtils.replace(save_goods_proc.getSaveGoodNumList(strID),":","_"));
        
        //Goods_Data[] goods_data = save_goods_proc.getSaveGoodList(strID, 1);
        
        Goods_Data[] goods_data = save_goods_proc.getSaveGoodListPage(strID, 1 ,1,100);
        
        for(int i = 0 ; i < goods_data.length; i++ ){
            
            long plno =   goods_data[i].getP_pl_no();
            int modelno =   goods_data[i].getModelno();
            
            if ( plno > 0 ){
                jsonArray.put("P_"+plno);
            }
            
            if ( modelno > 0 ){
                jsonArray.put("G_"+modelno);
            }
        
            /*
            if ( plno > 0 ){
                jsonArray.put("P_"+plno);
            }else{
                jsonArray.put("G_"+modelno);
            }
            */
            
            //jsonArray.put();
        }
	}
    out.println(jsonArray.toString());
%>
