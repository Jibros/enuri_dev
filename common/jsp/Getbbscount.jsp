<%@ page contentType="text/html; charset=UTF-8" %><%@ page import="java.util.HashMap"%><%@ page import="com.enuri.util.http.*"%><%@ page import="com.enuri.util.common.*"%><%@ page import="com.enuri.bean.main.Goods_BBS_Proc"%><%@ page import="com.enuri.bean.main.Category_Proc"%><%@ page import="com.enuri.bean.main.Goods_Proc"%><%@ page import="com.enuri.bean.main.Goods_Proc_New"%><%@ page import="com.enuri.bean.main.Goods_Data"%><%@ page import="com.enuri.util.image.ImageUtil"%><jsp:useBean id="Category_Proc" class="Category_Proc" scope="page" /><jsp:useBean id="Goods_Proc" class="Goods_Proc" scope="page" /><jsp:useBean id="Goods_Proc_New" class="Goods_Proc_New" scope="page" /><jsp:useBean id="Goods_Data" class="Goods_Data" scope="page" /><jsp:useBean id="Goods_BBS_Proc" class="Goods_BBS_Proc" scope="page" /><%
Goods_Proc goods_proc = new Goods_Proc();
int modelno = 0;
String modelnoStr = ChkNull.chkStr(request.getParameter("modelno"));
int modelno_one = ChkNull.chkInt(request.getParameter("modelno_one"));
int info_sum_point = ChkNull.chkInt(request.getParameter("info_sum_point"));
String group_yn = ChkNull.chkStr(request.getParameter("group_yn"));
String ca_code = ChkNull.chkStr(request.getParameter("ca_code"));

String rtn_str="";

if(modelnoStr.indexOf(",")>0) {
	modelnoStr = modelnoStr.substring(0, modelnoStr.indexOf(",")).trim();
}
modelno = ChkNull.chkInt(modelnoStr);

String strModelnos = goods_proc.getData_Group_Modelnos(modelno);
int rtn_cnt=0;
Goods_BBS_Proc goods_bbs_proc = new Goods_BBS_Proc();
if(!strModelnos.equals("")){
	//System.out.println("=="+strModelnos);
	rtn_cnt = goods_bbs_proc.Goods_List_Bbs_Count(strModelnos);
}
Goods_Data goods_data = null;
goods_data = goods_proc.getData_Info_One(modelno_one);

String strPopular="0";  
if(goods_data!=null){
	ca_code = goods_data.getCa_code();
	strPopular = goods_data.getPopular()+"";
	int intSale_cnt=0;
	if(group_yn.equals("Y")){
		intSale_cnt=goods_data.getSum_sale_cnt();
	}else{
		intSale_cnt=goods_data.getSale_cnt();
	}
	//System.out.println("=goods_data.getKb_num()="+goods_data.getKb_num());
	String strGoods_info = goods_data.getGoods_info();
	strGoods_info = ReplaceStr.replace(ReplaceStr.replace(strGoods_info,"\r\n","<br>"),"'","&quot;");
	rtn_str = strGoods_info+"[^]"+goods_data.getGoods_info_date()+"[^]"+goods_data.getInfo_point1()+"[^]"+goods_data.getInfo_point2()+"[^]"+goods_data.getInfo_point3()+"[^]"+goods_data.getInfo_sum_point()+"[^]"+goods_data.getKb_num()+"[^]"+intSale_cnt;
}
//System.out.println("=="+ca_code);
String strMcatenm="";
String strScatenm="";
int intGoods_Mcate_Cnt = 0;
int intFavor_rank_Mcate = 0;
int intGoods_Scate_Cnt = 0;
int intFavor_rank_Scate = 0;	

if(info_sum_point>0 && ca_code.length()>4){ //평점이 있는 경우만
	strMcatenm = Category_Proc.getData_Name(CutStr.cutStr(ca_code,4),2);
	strScatenm = Category_Proc.getData_Name(CutStr.cutStr(ca_code,6),3);
	
	HashMap hm = new HashMap();
	hm.put("popular",strPopular);
	//hm.put("popular","0");
	intGoods_Mcate_Cnt = Goods_Proc_New.getGoods_Total_cnt(ca_code.substring(0,4),hm);
	intFavor_rank_Mcate = Goods_Proc_New.getGoods_Favor_rank(ca_code.substring(0,4),hm ,modelno_one+"");
	String strCate = CutStr.cutStr(ca_code,4);
%>
	<%@ include file="/include/IncSponsorGoods.jsp"%>
	<%@ include file="/include/Inclistgoods_Notincate.jsp"%>
<%
	//System.out.println(intFavor_rank_Mcate+"=="+ChkNull.chkStr((String)(h_sponsor.get(CutStr.cutStr(ca_code,4)))).split(",").length);
	if ((String)h_sponsor.get(CutStr.cutStr(strCate,4)) != null){
		intFavor_rank_Mcate = intFavor_rank_Mcate - ChkNull.chkStr((String)(h_sponsor.get(CutStr.cutStr(ca_code,4)))).split(",").length;
	}

	intGoods_Scate_Cnt = Goods_Proc_New.getGoods_Total_cnt(ca_code.substring(0,6),hm);
	strCate = CutStr.cutStr(ca_code,6);
	
%>
	<%@ include file="/include/Inclistgoods_Notincate.jsp"%>
<%	
    //hm.put("popular",");
	hm = new HashMap();
	intFavor_rank_Scate = Goods_Proc_New.getGoods_Favor_rank(ca_code.substring(0,6),hm ,modelno_one+"");	
	if ((String)h_sponsor.get(CutStr.cutStr(strCate,6)) != null){
		intFavor_rank_Scate = intFavor_rank_Scate - ChkNull.chkStr((String)(h_sponsor.get(CutStr.cutStr(ca_code,6)))).split(",").length;
	}
    //System.out.println(intFavor_rank_Scate+"=="+CutStr.cutStr(ca_code,6)+"=="+ChkNull.chkStr((String)(h_sponsor.get(CutStr.cutStr(ca_code,6)))).split(",").length;
}
rtn_str = rtn_str+"[^]"+strMcatenm+"[^]"+strScatenm+"[^]"+intGoods_Mcate_Cnt+"[^]"+intFavor_rank_Mcate+"[^]"+intGoods_Scate_Cnt+"[^]"+intFavor_rank_Scate;

rtn_str = rtn_cnt+"[^]"+rtn_str;
out.print(rtn_str);
//System.out.println("=="+rtn_str);
%>