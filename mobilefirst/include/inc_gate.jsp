<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.log.Log_info_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<jsp:useBean id="Gatepage_buylog_Proc" class="com.enuri.bean.log.Gatepage_buylog_Proc"  />
<%
//유입경로해당자테스트

int intModelno = ChkNull.chkInt(request.getParameter("modelno"),0);

String strGTmpid = cb.GetCookie("GATEP","TMP_ID");
String strGkind = cb.GetCookie("GATEP","GKIND");
String strGno = cb.GetCookie("GATEP","GNO");

boolean blGatepage = false;

if(!strGTmpid.equals("") && !strGno.equals("")){
	try{
		int intOutput = Gatepage_buylog_Proc.getInsert_Buylog(strGkind, ChkNull.chkInt(strGno), strGTmpid, intModelno);
	}catch(Exception pe){}
}

String strCTmpId = cb.GetCookie("GATEC","TMP_ID");
String strCModelNoGroup = cb.GetCookie("GATEC","MODELNO");
String strCCate = cb.GetCookie("GATEC","CATE");

if(!strCTmpId.equals("") && !strCModelNoGroup.equals("")){
    try{
        Gatepage_buylog_Proc.insertCreteoMoveLog(Integer.parseInt(strCModelNoGroup), strCCate,strCTmpId,ConfigManager.szConnectIp(request),"out","Y");
    }catch(Exception pe){
    }
}

//와이더 플래닛
String strW_CTmpId = cb.GetCookie("GATEW","TMP_ID");
String strW_Modelno = cb.GetCookie("GATEW","MODELNO");
String strW_cate = cb.GetCookie("GATEW","CATE");

if(!strW_CTmpId.equals("") && !strW_Modelno.equals("")){
	try{
		Gatepage_buylog_Proc.insertWiderMoveLog(Integer.parseInt(strW_Modelno), strW_cate,strW_CTmpId,ConfigManager.szConnectIp(request),"out","Y");         
	}catch(Exception pe){      
    }    
}

//piclick 추가 2020-06-10 shwoo
String strCTmpId_r = cb.GetCookie("GATER","TMP_ID");
String strCModelNoGroup_r = cb.GetCookie("GATER","MODELNO");
String strCCate_r = cb.GetCookie("GATER","CATE");

if(!strCTmpId_r.equals("") && !strCModelNoGroup_r.equals("")){
    try{
        Gatepage_buylog_Proc.insertPiclickMoveLog(Integer.parseInt(strCModelNoGroup_r), strCCate_r,strCTmpId_r,ConfigManager.szConnectIp(request),"out","Y");
    }catch(Exception pe){
    }
}

//pass 추가 2020-07-20 shwoo
String strCTmpId_s = cb.GetCookie("GATES","TMP_ID");
String strCModelNoGroup_s = cb.GetCookie("GATES","MODELNO");
String strCCate_s= cb.GetCookie("GATES","CATE");

if(!strCTmpId_s.equals("") && !strCModelNoGroup_s.equals("")){
  try{
      Gatepage_buylog_Proc.insertPassMoveLog(Integer.parseInt(strCModelNoGroup_s), strCCate_s,strCTmpId_s,ConfigManager.szConnectIp(request),"out","Y");
  }catch(Exception pe){
  }
}
// #50233 리타게팅 신규매체(모비온) 진행: JCA 블랙박스, 로거 파라미터 개발 (2022.01.11 scboys)

String strCTmpId_m = cb.GetCookie("GATEM","TMP_ID");
String strCModelNoGroup_m = cb.GetCookie("GATEM","MODELNO");
String strCCate_m= cb.GetCookie("GATEM","CATE");

if(!strCTmpId_s.equals("") && !strCModelNoGroup_s.equals("")){
  try{
      Gatepage_buylog_Proc.insertMobiMoveLog(Integer.parseInt(strCModelNoGroup_m), strCCate_m,strCTmpId_m,ConfigManager.szConnectIp(request),"out","Y");
  }catch(Exception pe){
  }
}
%>