<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %><%@ page import="com.enuri.bean.main.Category_Proc"%><%@ page import="com.enuri.bean.main.Category_Data"%><%@ page import="com.enuri.util.common.*"%><%
	request.setCharacterEncoding("UTF-8");

	String strCate = ChkNull.chkStr(request.getParameter("cate"));
	String strSdul = ChkNull.chkStr(request.getParameter("sdul"));
	Category_Proc category_proc = new Category_Proc();
	Category_Data[] category_date = null;
	String strWhere = " WHERE C_SEQNO > 0 ";
	String strOrderBy = " ORDER BY CA_CODE ";

	if (strCate.trim().length() == 0 ){
		strWhere = strWhere + " AND C_LEVEL = 1 AND ca_code NOT IN ( '22' ) ";
		if(strSdul.equals("Y")){ 
			category_date = category_proc.Category_sub_List(strWhere,strOrderBy);
		}else{
			category_date = category_proc.Category_Sub_Bind_List2(1,"",strOrderBy);
		}
	}else if (strCate.trim().length() == 2){
		strWhere = strWhere + " AND C_LEVEL = 2 AND ca_code NOT IN ('0320','1650','0309','0317','0499','1017','1021','2110','2111','2112','2118','2119','2123','2124','2125','1218','0796','0492','0493','0494','0495','0496','0497','0498','0791','0792','0793','0794','0795','0492','0493','0494','0495','0496','0497','0498','0411','0791','0792','0793','0794','0795','0496','0337','0338','0339','0340','0341',";
		strWhere = strWhere + " '1893','1686','1685','1649','0230','0291','0292','0419','0689','0694','0697','0698','0790','0417','0780','0781','0782','0783','0784','0785','0786','0798','0822','0823','0832','1209','0876','0877','0914','0915','0916','0994','0995','1014','1025','1026','1027','1028','1212','1217','1222','1223','1697','1804','2117','1806','1809','1810','1811','1815','1816','1890','1805','1210','1218','1240','1241','1285','1812','1813','1814','1817','1818','1819','2126','2127','2140')";
		strWhere = strWhere + " AND CA_CODE LIKE '"+strCate+"%'";
		if(strSdul.equals("Y")){ 
			category_date = category_proc.Category_sub_List(strWhere,strOrderBy);
		}else{
			category_date = category_proc.Category_Sub_Bind_List2(2,strCate,strOrderBy);
		}
	}else if (strCate.trim().length() == 4){
		strWhere = strWhere + " AND C_LEVEL = 3 AND CA_CODE LIKE '"+strCate+"%'";
		if(strSdul.equals("Y")){ 
			category_date = category_proc.Category_sub_List(strWhere,strOrderBy);
		}else{
			category_date = category_proc.Category_Sub_Bind_List2(3,strCate,strOrderBy);
		}
	}else if (strCate.trim().length() == 6){
		strWhere = strWhere + " AND C_LEVEL = 4 AND CA_CODE LIKE '"+strCate+"%'";
		if(strSdul.equals("Y")){ 
			category_date = category_proc.Category_sub_List(strWhere,strOrderBy);
		}else{
			category_date = category_proc.Category_Sub_Bind_List2(4,strCate,strOrderBy);	
		}
	}
	String strCates = "";
	for (int i=0;i<category_date.length;i++){
		String getCate_name = category_date[i].getC_name();
		getCate_name = ReplaceStr.replace(getCate_name,",","&#044;");

		strCates = strCates + category_date[i].getCa_code()+","+getCate_name+",";
	}
	if (strCates.trim().length() > 0 ){
		out.print(strCates.substring(0,strCates.length()-1));
	}
%>