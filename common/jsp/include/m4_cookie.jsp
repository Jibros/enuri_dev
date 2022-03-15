<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*,java.text.*,java.net.*"%>
<%@ page import="com.enuri.util.http.*"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="org.apache.commons.lang3.StringUtils"%>

<%
	CookieBean cb = null;
	cb = new CookieBean( request.getCookies());
		
	String strModelNos = ChkNull.chkStr(request.getParameter("modelnos"),"");
	String strType = ChkNull.chkStr(request.getParameter("type"),""); //최근본상품(today)
	String strKeyword = ChkNull.chkStr(request.getParameter("keyword"),""); //검색어
	
	if(strType.equals("recentl_one") || strType.equals("m_recentl_one")){
		strKeyword = strModelNos;
	}
	int intMyCnt2 = 0; 
	
	if(strType.equals("today") || strType.equals("today_d")){
		String strToday = strModelNos;
		String strTodayCookie1 = cb.GetCookie("MOBILETODAY","MODELNOS");
		String strTodayCookie3 = "";
		
		if(strToday != null) {
			String astrToday[] = strToday.split(",");
			int intMyCnt = astrToday.length;
			if (intMyCnt >= 32 ){
				intMyCnt = 32;
			}    
			for (int i = 0 ; i < intMyCnt ; i++){
				if(strTodayCookie1.indexOf(astrToday[i]) > -1){
					strTodayCookie1 = strTodayCookie1.replaceAll(astrToday[i],"");			
				}
				if (astrToday[i].split(":")[0].equals("G") && ChkNull.chkNumber(astrToday[i].split(":")[1])){
					if (Integer.parseInt(astrToday[i].split(":")[1]) > 0 ){
						strTodayCookie1 = astrToday[i]+","+strTodayCookie1;
					}
				}else if (astrToday[i].split(":")[0].equals("P") && ChkNull.chkNumber(astrToday[i].split(":")[1])){
					if (Integer.parseInt(astrToday[i].split(":")[1]) > 0 ){
						strTodayCookie1 = astrToday[i]+","+strTodayCookie1;
					}
				}else{
					strTodayCookie1 = strTodayCookie1 + astrToday[i]+",";
				} 
			}
		}
		if (strTodayCookie1.length() > 0 ){ 
			if(strTodayCookie1.substring(strTodayCookie1.length()-1,strTodayCookie1.length()).equals(",")){
				strTodayCookie1 = CutStr.cutStr(strTodayCookie1,strTodayCookie1.length()-1);
			}else if(strTodayCookie1.substring(0,1).equals(",")){
				strTodayCookie1 = strTodayCookie1.substring(1,strTodayCookie1.length());
			} 
			strTodayCookie1 = strTodayCookie1.replaceAll(",,",",");		
		}
		strTodayCookie1 = strTodayCookie1.replaceAll(",,",",");	
		String strTodayCookie_n[] = strTodayCookie1.split(",");
 
		int intMyCnt = strTodayCookie_n.length;
		
		if (intMyCnt >= 32 ){ 
			intMyCnt = 32;
		}   
		
		for (int i = 0 ; i < intMyCnt ; i++){
			if(strTodayCookie3.equals("")){
				strTodayCookie3 = strTodayCookie_n[i];
			}else{
				strTodayCookie3 = strTodayCookie3+","+strTodayCookie_n[i];
			}
		} 
		//System.out.println("모바일 오늘본상품="+strTodayCookie3);
		intMyCnt2 = intMyCnt;
		cb.SetCookie("MOBILETODAY","MODELNOS",strTodayCookie3);
		cb.SetCookieExpire("MOBILETODAY",3600*24*30);
		cb.responseAddCookie(response);		 
		//out.println("strTodayCookie1="+strTodayCookie1); //같은데이터 이미있음 
	}else if(strType.equals("today_del") || strType.equals("today_del_d")){
		String strToday = strModelNos;   
		String strTodayCookie1 = cb.GetCookie("MOBILETODAY","MODELNOS");
		
		if(strToday != null) {
			String astrToday[] = strToday.split(",");
			int intMyCnt = astrToday.length;
			if (intMyCnt >= 32 ){
				intMyCnt = 32; 
			}  
			for (int i = 0 ; i < intMyCnt ; i++){
				if(strTodayCookie1.indexOf(astrToday[i]) > -1){
					strTodayCookie1 = strTodayCookie1.replaceAll(astrToday[i],"");		
					strTodayCookie1 = strTodayCookie1.replaceAll(",,",",");		
				} 
			} 
		}  
		if (strTodayCookie1.length() > 0 ){ 
			if(strTodayCookie1.substring(strTodayCookie1.length()-1,strTodayCookie1.length()).equals(",")){
				strTodayCookie1 = CutStr.cutStr(strTodayCookie1,strTodayCookie1.length()-1);
			}else if(strTodayCookie1.substring(0,1).equals(",")){
				strTodayCookie1 = strTodayCookie1.substring(1,strTodayCookie1.length());
			}	
		}
		if(strType.equals("today_del")){  
			out.println("TODAY_5");
		} 
		String strTodayCookie1_length[] = strTodayCookie1.split(",");
		intMyCnt2 = strTodayCookie1_length.length;
		
		cb.SetCookie("MOBILETODAY","MODELNOS",strTodayCookie1);
		cb.SetCookieExpire("MOBILETODAY",3600*24*30);
		cb.responseAddCookie(response);		 
	}else if(strType.equals("recentl")){ 		//최근검색어 삭제_전체
		cb.SetCookie("MOB_SEAR_HISTORY", "SEARCHKEYWORD", "");
		cb.SetCookieExpire("MOB_SEAR_HISTORY", 3600*24*30);
		cb.responseAddCookie(response);		
	}else if(strType.equals("reckeyword_N")){	//검색어저장 안함
		cb.SetCookie("MYSEARCHHISTORY2", "NOSAVE", "n");
		cb.SetCookieExpire("MYSEARCHHISTORY2", 3600*24*365);
		cb.responseAddCookie(response);
	}else if(strType.equals("reckeyword_Y")){	//검색어저장 안함-해제
		cb.SetCookie("MYSEARCHHISTORY2", "NOSAVE", "");
		cb.SetCookieExpire("MYSEARCHHISTORY2", 3600*24*30);
		cb.responseAddCookie(response);		
	}else if(strType.equals("recentl_one")){
	
		String stKeywordCookie = cb.GetCookie("MYSEARCHHISTORY2","SEARCHKEYWORD");
		//stKeywordCookie = stKeywordCookie.replace(strKeyword,"");
		//System.out.println("strKeyword:"+StringUtils.trim(strKeyword));
		/*		
		stKeywordCookie = StringUtils.replace(StringUtils.trim(stKeywordCookie),strKeyword,"");
		stKeywordCookie = StringUtils.replace(StringUtils.trim(stKeywordCookie),",,",",");		
		
		//stKeywordCookie:북,S:엘지 냉장고,S:뽀로로 음료수,S:S OIL 세븐 골드,S:뽀로로하우스,S:이사,S:48CX,C:나이키,S:NT550XDZ AD5AW
		//strKeyword:S:엘지 냉장고

		//System.out.println("=========="+StringUtils.trim(stKeywordCookie)+"==========");
		if(stKeywordCookie.equals(",")){
			stKeywordCookie = "";
		}
		
		if(stKeywordCookie.length() > 0){
			if(stKeywordCookie.substring(0,1).equals(",")){
				stKeywordCookie = stKeywordCookie.substring(1,stKeywordCookie.length());
			}
		}
		*/
		String[] keywords = StringUtils.split(stKeywordCookie, ",");
		ArrayList newKeywords = new ArrayList(); 
		for(String keyword : keywords){
			
			if(!strKeyword.equals(keyword)){
				newKeywords.add(keyword);
			}
		}
		stKeywordCookie = StringUtils.replace(newKeywords.toString(), "[", "");
		stKeywordCookie = StringUtils.replace(stKeywordCookie, "]", "");
		stKeywordCookie = StringUtils.replace(stKeywordCookie, ", S:", ",S:");
		stKeywordCookie = StringUtils.replace(stKeywordCookie, ", C:", ",C:");
		
		//System.out.println("=========="+StringUtils.trim(stKeywordCookie)+"==========");
		
		cb.SetCookie("MYSEARCHHISTORY2", "SEARCHKEYWORD", stKeywordCookie);
		cb.SetCookieExpire("MYSEARCHHISTORY2", 3600*24*30);
		cb.responseAddCookie(response);
		
	}else if( strType.equals("setKeyword") ){ //스마트택배용 쿠키 추가 노병원 2019/05/24 
		
		if (strKeyword.trim().length() > 0){
			String strSearchHistory = cb.GetCookie("MOB_SEAR_HISTORY","SEARCHKEYWORD");
			
			String strSearchS = "";
			String strInsertSearchS = "";
			String strSearch1 = "";
			String strSearch2 = "";
			
			strKeyword = ReplaceSpecialKeyWord(strKeyword);
			
			strSearchS = "S:"+strKeyword+"__"+getDate();
			strInsertSearchS = strSearchS;
			if(strSearchHistory != null & "".equals(strSearchHistory) == false) {
				String astrSearchHistory[] = strSearchHistory.split("\\,");
				int intSearchHistoryCnt = astrSearchHistory.length;
				if (intSearchHistoryCnt >= 15 ){
					intSearchHistoryCnt = 15;
				}
				for (int si=0;si<intSearchHistoryCnt;si++){
					strSearch1 = astrSearchHistory[si];
					strSearch2 = strSearchS;
					if(strSearch1.indexOf("__") > -1){
						strSearch1 = strSearch1.substring(0, strSearch1.indexOf("__"));
					}
					if(strSearch2.indexOf("__") > -1){
						strSearch2 = strSearch2.substring(0, strSearch2.indexOf("__"));
					}
					if (!strSearch1.equals(strSearch2)){
						strInsertSearchS = strInsertSearchS + ","+astrSearchHistory[si];
					}
				}
			}
			if (strInsertSearchS.trim().length() > 0){
				if (strInsertSearchS.substring(strInsertSearchS.length()-1,strInsertSearchS.length()).equals(",")){
					strInsertSearchS = CutStr.cutStr(strInsertSearchS,strInsertSearchS.length()-1);
				}
			}
			String strRecFlag = cb.GetCookie("MOB_REC_FLAG","RECFLAG");
			
			if(!strRecFlag.equals("N")){
				
				cb.SetCookie("MOB_SEAR_HISTORY", "SEARCHKEYWORD", strInsertSearchS);
				cb.SetCookieExpire("MOB_SEAR_HISTORY", 3600*24*30);
				cb.responseAddCookie(response);
			} 
		}	
		
	}
%>
<%!
private String ReplaceSpecialKeyWord(String strKeyword){
		
		strKeyword = ReplaceStr.replace(strKeyword, "-"," ");
		strKeyword = ReplaceStr.replace(strKeyword, ")"," ");
		strKeyword = ReplaceStr.replace(strKeyword, "("," ");		
	    strKeyword = ReplaceStr.replace(strKeyword, "^"," ");
	    strKeyword = ReplaceStr.replace(strKeyword, "&"," ");
	    strKeyword = ReplaceStr.replace(strKeyword, "~"," ");
	    strKeyword = ReplaceStr.replace(strKeyword, "@"," ");
	    strKeyword = ReplaceStr.replace(strKeyword, "$"," ");
	    strKeyword = ReplaceStr.replace(strKeyword, "%"," ");
	    strKeyword = ReplaceStr.replace(strKeyword, "*"," ");
	    strKeyword = ReplaceStr.replace(strKeyword, "+"," ");
	    strKeyword = ReplaceStr.replace(strKeyword, "="," ");
	    strKeyword = ReplaceStr.replace(strKeyword, "\\"," ");
	    strKeyword = ReplaceStr.replace(strKeyword, "{"," ");
	    strKeyword = ReplaceStr.replace(strKeyword, "}"," ");
	    strKeyword = ReplaceStr.replace(strKeyword, "["," ");
	    strKeyword = ReplaceStr.replace(strKeyword, "]"," ");
	    strKeyword = ReplaceStr.replace(strKeyword, ":"," ");
	    strKeyword = ReplaceStr.replace(strKeyword, ";"," ");
	    strKeyword = ReplaceStr.replace(strKeyword, "/"," ");
	    strKeyword = ReplaceStr.replace(strKeyword, "<"," ");
	    strKeyword = ReplaceStr.replace(strKeyword, ">"," ");
	    //strKeyword = ReplaceStr.replace(strKeyword, "."," ");
	    strKeyword = ReplaceStr.replace(strKeyword, ","," ");
	    strKeyword = ReplaceStr.replace(strKeyword, "?"," ");
	    strKeyword = ReplaceStr.replace(strKeyword, "'"," ");
	    strKeyword = ReplaceStr.replace(strKeyword, "_"," ");
	    strKeyword = ReplaceStr.replace(strKeyword, "`"," ");
    	strKeyword = ReplaceStr.replace(strKeyword, "|"," ");	    				
    	//strKeyword = ReplaceStr.replace(strKeyword, "."," ");
    	strKeyword = ReplaceStr.replace(strKeyword, ","," ");
    	
    	strKeyword = strKeyword.trim();
    	return strKeyword;
	}

public String getDate(){
   DecimalFormat df = new DecimalFormat("00");
   Calendar calendar = Calendar.getInstance();


   String year = Integer.toString(calendar.get(Calendar.YEAR)); //년도를 구한다
   String month = df.format(calendar.get(Calendar.MONTH) + 1); //달을 구한다
   String day = df.format(calendar.get(Calendar.DATE)); //날짜를 구한다
   String date = month+"월" + day+"일";

   return date;
}

%>
