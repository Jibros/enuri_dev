<%@page import="com.enuri.bean.main.Goods_Data"%>
<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.main.deal.CrazyDeal_Proc"%>
<jsp:useBean id="Goods_Data" class="com.enuri.bean.main.Goods_Data" scope="page"  />
<jsp:useBean id="Goods_Proc" class="com.enuri.bean.main.Goods_Proc" scope="page"  />
<jsp:useBean id="ImageUtil_lsv" class="com.enuri.util.image.ImageUtil_lsv" scope="page"  />
<%
    String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	String userData  =  ChkNull.chkStr(request.getParameter("chkid"));
	String referer = ChkNull.chkStr(request.getHeader("referer"));
	
	String modelnos  = ChkNull.chkStr(request.getParameter("modelnos"));
	String strModelno[] = modelnoParser(modelnos);
    JSONObject jSONObject = new JSONObject();
	JSONArray jsonArray = new JSONArray();

    Goods_Data goods_data = new Goods_Data();
	try{
		if(modelnos.length() > 0 ){
			int intModelno[] = new int[strModelno.length];
			try{
				for(int i=0; i<strModelno.length;i++){
					JSONObject jSONData = new JSONObject();

					intModelno[i] = Integer.parseInt(strModelno[i]);
					goods_data =  Goods_Proc.Goods_Detailmulti_One(intModelno[i] , "Detailmulti");
					String strImageurl_middle= ChkNull.chkStr(ImageUtil_lsv.getVIPImageSrc(goods_data));
					
					jSONData.put("modelno", intModelno[i] );
					jSONData.put("modelnm", ChkNull.chkStr(goods_data.getModelnm()));	
					jSONData.put("imgUrl",strImageurl_middle);
					jSONData.put("minprice", goods_data.getMinprice());
					jSONData.put("minprice3", goods_data.getMinprice3());
					jSONData.put("bbs_point_avg", goods_data.getBbs_point_avg());		
					jsonArray.put(jSONData);
				}
			}catch(Exception ex){}
			
			jSONObject.put("goodsList", jsonArray);
		}else{
			jSONObject.put("result", false);
		}
	}catch(Exception e){
		jSONObject.put("result", false);
	}finally{
		out.println(jSONObject.toString());
	}
%>

<%!
public String[] modelnoParser(String modelnos){
    return modelnos.replaceAll(" ","").split(",");
}

%>