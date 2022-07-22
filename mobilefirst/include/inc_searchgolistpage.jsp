<%@ page import="com.enuri.bean.main.Search_Category_Proc"%>
<%@ page import="com.enuri.bean.main.Search_Category_Data"%>
<%@ page import="java.util.*,java.io.*,java.net.*"%>
<%@ page import="org.apache.commons.httpclient.HttpClient"%>
<%@ page import="org.apache.commons.httpclient.HttpStatus"%>
<%@ page import="org.apache.commons.httpclient.methods.GetMethod"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%>
<%
	String strRedirectCaCode = "";
	String strReturnRedirectPage = "";
	
	/* 특정 단어와 복합된 키워드일때에도 분류검색이 되도록 처리 (toodoo 2008.06.16) 
	 * 주의 : 복합단어를 앞쪽에 위치시켜주세요
	 * 		 그중 특정단어일때 정렬기준도 설정(기본 인기순정렬됩니다)
	 *		 /fashion/include/Inc_Fashion_SearchReturnCate.jsp 도 같이 수정해야함
	 **/
	%>
	<%@include file="/lsv2016/include/IncMatchingKeyword.jsp"%>
	<%
	strRedirectCaCode = getKeywordMatchingCategory(ReplaceStr.replace(strKeyword,"무료배송",""), strMatchingCateAdd, strMatchingCateExcept);
	if (CutStr.cutStr(strRedirectCaCode,4).equals("1472") || CutStr.cutStr(strRedirectCaCode,4).equals("1471") || CutStr.cutStr(strRedirectCaCode,4).equals("1473")){
		strRedirectCaCode = "";
	}
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
	
	
	String listLocation = "";
	String k_ca_code = "";
	String k_keyword_search = "";
	String k_key_type = "";

	//System.out.println("strRedirectCaCode=="+strRedirectCaCode);
	
	if (strRedirectCaCode.trim().length() > 0 ){
		
		StringBuffer getCategoryJson = new StringBuffer();
		String g_seqno = "";
		
		try {
		    
		    JSONParser parser = new JSONParser();
			//Object obj = parser.parse(new FileReader("webapps/ROOT/mobilenew/gnb/category/category_center.json"));
			Object obj = parser.parse(new FileReader("/was/lena/1.3/depot/lena-application/ROOT/mobilenew/gnb/category/category_center.json"));
			
			JSONObject jsonObject = (JSONObject) obj;
			JSONArray array = (JSONArray) jsonObject.get("23category");
			
			for(int i=0; i<array.size(); i++){
		        JSONObject data = (JSONObject)array.get(i);
		        String G_SEQNO = (String)data.get("G_SEQNO");
		        String G_CATE = (String)data.get("G_CATE");
		        
		        if(strRedirectCaCode.equals(G_CATE)){
		        	g_seqno = G_SEQNO;
		        }
				
	    	}
		    
		} catch (Exception e) {
		    System.out.println("mobilefrist include cateJson==>>>"+e);
		}
 		
 		/*
		String line = null;
		int httpTryCnt = 0;
		String g_seqno = "";
		try {
			URL u = new URL(categoryJson);
			
			HttpURLConnection huc = (HttpURLConnection) u.openConnection();
			huc.setRequestMethod("GET");
			huc.setConnectTimeout(1000);
			huc.connect();

			InputStream is = huc.getInputStream();
			BufferedReader in = new BufferedReader(new InputStreamReader(is));
			
			while(true) {
				line = in.readLine();
				
				if(line==null) break;

				int findNum = line.indexOf("\""+strRedirectCaCode+"\"");
				if(findNum>-1 && findNum>26) {
					String findSeqnoStr = line.substring(findNum-26, findNum);
					
					String finder1 = "\":\"";
					String finder2 = "\",\"";
					if(findSeqnoStr.indexOf(finder1)>-1 && findSeqnoStr.indexOf(finder2)>-1) {
						String find1 = findSeqnoStr.split(finder1)[1];
						String find2 = find1.split(finder2)[0];

						g_seqno = find2;
					}
				}

				httpTryCnt++;
				if(httpTryCnt==1000) break;
			} 
		} catch(Exception e) {
			System.out.println("Exception : "+e);
		} finally {
		}
		*/
		listLocation = "http://"+request.getServerName()+"/m/list.jsp?from=search&cate="+strRedirectCaCode+"&gseq="+g_seqno+"&skeyword="+URLEncoder.encode(strKeyword, "UTF-8");;
		response.sendRedirect(listLocation);
		return; 
	}

	Search_Category_Proc search_category_proc = new Search_Category_Proc();
	Search_Category_Data keyword_search_data = new Search_Category_Data();
	keyword_search_data = search_category_proc.getKeywordSearch(strKeyword);		
	
	if(keyword_search_data != null){	 
		k_ca_code = keyword_search_data.getCa_code();
		k_keyword_search = keyword_search_data.getKey_search(); 
		k_key_type = keyword_search_data.getKey_type();
		
		if(k_key_type.equals("L")){ 
			listLocation = "http://"+request.getServerName()+"/m/list.jsp?from=search&cate="+k_ca_code+"&in_keyword="+URLEncoder.encode(strKeyword, "UTF-8");
			response.sendRedirect(listLocation);
		}else if(k_key_type.equals("S") && k_ca_code.length() > 2){ 
			listLocation = "http://"+request.getServerName()+"/m/search.jsp?from=searchOrg&cate="+k_ca_code+"&keyword="+URLEncoder.encode(strKeyword, "UTF-8");
			response.sendRedirect(listLocation);		   
		}
	}    
	 
%> 
<%!
	private String getKeywordMatchingCategory(String strKeyword, String strMatchingCateAdd, String strMatchingCateExcept) throws Exception{
		strKeyword = ReplaceSpecialKeyWord(strKeyword);

    	String[] arrMatchingCateAdd = strMatchingCateAdd.split(",");
    	for (int i=0; i<arrMatchingCateAdd.length; i++){
    		if(arrMatchingCateAdd[i].length() > 0){
	    		if (strKeyword.indexOf(arrMatchingCateAdd[i])>=0){
	    			if (
	    				!(strKeyword.indexOf("상품권") >= 0 && arrMatchingCateAdd[i].equals("상품")) &&
	    				!(strKeyword.toUpperCase().indexOf("추천PC") >= 0 && arrMatchingCateAdd[i].equals("추천")) &&
	    				!(strKeyword.indexOf("추천컴퓨터") >= 0 && arrMatchingCateAdd[i].equals("추천")) &&
	    				!(strKeyword.indexOf("성인기저귀") >= 0 && arrMatchingCateAdd[i].equals("인기")) &&
	    				!(strKeyword.indexOf("반제품") >= 0 && arrMatchingCateAdd[i].equals("제품")) &&
	    				!(strKeyword.indexOf("완제품") >= 0 && arrMatchingCateAdd[i].equals("제품")) &&
						!(strKeyword.indexOf("인기브랜드") >= 0 && arrMatchingCateAdd[i].equals("인기")) &&
						!(strKeyword.indexOf("인기 브랜드") >= 0 && arrMatchingCateAdd[i].equals("인기")) &&
						!(strKeyword.indexOf("인기제조사") >= 0 && arrMatchingCateAdd[i].equals("인기")) &&
						!(strKeyword.indexOf("인기 제조사") >= 0 && arrMatchingCateAdd[i].equals("인기")) &&
						!(strKeyword.indexOf("성인기저기") >= 0 && arrMatchingCateAdd[i].equals("인기")) &&
						!(strKeyword.indexOf("인기향기") >= 0 && arrMatchingCateAdd[i].equals("인기")) &&
						!(strKeyword.indexOf("저가형") >= 0 && arrMatchingCateAdd[i].equals("저가")) &&
						!(strKeyword.indexOf("메신저가방") >= 0 && arrMatchingCateAdd[i].equals("저가")) &&
						!(strKeyword.indexOf("수저가방") >= 0 && arrMatchingCateAdd[i].equals("저가")) &&
						!(strKeyword.indexOf("침구매트") >= 0 && arrMatchingCateAdd[i].equals("구매")) &&
						!(strKeyword.indexOf("커피판매기") >= 0 && arrMatchingCateAdd[i].equals("판매")) &&
						!(strKeyword.indexOf("아이디어상품") >= 0 && arrMatchingCateAdd[i].equals("상품")) &&
						!(strKeyword.indexOf("초특가") >= 0 && arrMatchingCateAdd[i].equals("특가")) &&
						!(strKeyword.indexOf("전기장판매트") >= 0 && arrMatchingCateAdd[i].equals("판매")) &&
	    				!(strKeyword.indexOf("커피자동판매기") >= 0 && arrMatchingCateAdd[i].equals("판매")) 
	    			){
		    			strKeyword = ReplaceStr.replace(strKeyword,arrMatchingCateAdd[i],"");
	    				strKeyword = strKeyword.trim();
	    				break;
	    			}
	    		}
    		}
    	}
    	if (!strKeyword.equals(" ")){ //같은 단어가 띄어쓰기로 반복된 경우 하나만 남도록 처리
			for(;;){
				if(strKeyword.indexOf("  ")>=0){
					strKeyword = ReplaceStr.replace(strKeyword, "  "," ");
			   	}else{
			   		break;
			   	}
			}
	    	String[] arrKeyword = strKeyword.split(" ");
	    	for (int i=0; i<arrKeyword.length; i++){
	    		if (i==0){
	    			strKeyword = arrKeyword[i];
	    		}else{
	    			if (!strKeyword.equals(arrKeyword[i])){
	    				strKeyword += " " + arrKeyword[i];
	    			}
	    		}
	    	}
    	}
		String strReturnCategory = "";
		
		if(strKeyword.equals("신차")){
			strKeyword = "";
		}
		 
		Search_Category_Proc search_category_proc = new Search_Category_Proc();
		Search_Category_Data[]  search_category_data = search_category_proc.getDataList(strKeyword);
		if (search_category_data != null)
		{
			if (search_category_data.length > 0 ){
				strReturnCategory = search_category_data[0].getCa_code();
				if(strReturnCategory.equals("2111")){
					strReturnCategory = "";
				}
			} 
		} 
		return strReturnCategory;
	}


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
%>