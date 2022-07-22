<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ include file="/include/IncSearch.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.enuri.bean.main.RecKeyword_Data"%>
<%@ page import="com.enuri.bean.main.RecKeyword_Proc"%>
<%@ page import="com.enuri.bean.main.Search_Category_Proc"%>
<%@ page import="com.enuri.bean.main.Search_Category_Data"%>
<%@ page import="org.apache.commons.lang3.*"%>

<jsp:useBean id="RecKeyword_Data" class="com.enuri.bean.main.RecKeyword_Data" scope="page" />
<jsp:useBean id="RecKeyword_Proc" class="com.enuri.bean.main.RecKeyword_Proc" scope="page" />
<%
	response.setHeader("Pragma","No-cache");
	response.setDateHeader("Expires",-1);
	response.setHeader("Cache-Control","no-cache");
	String strReturn = "";
	String strType = "";

	String strCate = request.getParameter("_c") == null ? "" : request.getParameter("_c").trim();
	String strQuery = request.getParameter("_q") == null ? "" : request.getParameter("_q").trim();
	String strSearchType = request.getParameter("_t") == null ? "" : request.getParameter("_t").trim();
	
	try{
		
		//검색어 예외처리
		//2019-02-13.
		//2019-04-23. 예외처리 삭제 요청
		//#35971 조개젓 관련 키워드 결과 없음 처리 2019.09.18. shwoo
		//#36492 삼성 셀리턴 외 2019.10.23 jinwook
		//#36741 베이비드림 키워드 결과 없음 처리 2019.11.07. shwoo
		//#40697 [PC/모바일] 특정 키워드 검색창 자동완성 비노출 처리 2020.06.25 jinwook
		String strExword = ",조개젓,조개젓갈,whrowjt,삼성셀리턴,삼성전자셀리턴,삼성LED마스크,삼성전자LED마스크,베이비드림,오나홀,텐가,";	//앞뒤 콤마 추가 기입바람
		
		if(strExword.indexOf(","+ strQuery.toLowerCase()  + ",") > -1){
			strQuery = "";
		}
		
		/*
		// 상위의 조건에 포함되더라로 걸려있더라도, 정확히 일치하는 경우 다시 strQuery를 다시 세팅한다.
		#36771 LP/SRP 검색결과없음 처리 보완 2019.11.18 jinwook
		*/
		if(request.getParameter("_q") != null && request.getParameter("_q").trim().length()>0 ) {
			String strMatchWord = ",베이비 드림,";	//앞뒤 콤마 추가 기입바람
			String strQueryOrigin = request.getParameter("_q").trim();
			if(strMatchWord.indexOf(","+ strQueryOrigin.toLowerCase()  + ",") > -1){
				strQuery = strQueryOrigin;
			}
		}
		//System.out.println("strQuery===="+strQuery);
		ArrayList arrHistoryTitle = new ArrayList();
		ArrayList arrHistoryFrom = new ArrayList();
		
		ArrayList arrAutoType = new ArrayList();
		ArrayList arrAutoWord = new ArrayList();
		ArrayList arrAutoCate = new ArrayList();
		
		ArrayList arrPopKeyword = new ArrayList();		
		ArrayList arrPopCate = new ArrayList();
		
		ArrayList arrRecKeyword = new ArrayList();
		
		ArrayList arrLinkAgeWord = new ArrayList();
		
		if (strCate.trim().length() == 0 && strQuery.trim().length() == 0 ){
			if(strSearchType.equals("recentl")){		//최근
				strType = "m2";
			}else{										//전체
				strType = "m2";
			}
		}
		if (strCate.trim().length() > 0 && strQuery.trim().length() == 0 ){
			strType = "c";
		}
		
		if (strQuery.trim().length() > 0){
			strType = "a";
		}
		if(strSearchType.equals("linkage")){   	//연관
			strType = "r";	
		}

		//검색 히스토리
		if (strType.equals("m") || strType.equals("m2")){
			String strSearchHistory = cb.GetCookie("MOB_SEAR_HISTORY","SEARCHKEYWORD");
			
			if(strSearchHistory != null & "".equals(strSearchHistory) == false) {
				String astrSearchHistory[] = strSearchHistory.split("\\,");
				int intSearchHistoryCnt = astrSearchHistory.length;
						
				for (int si=0;si<intSearchHistoryCnt;si++){
					String strHistory = "";
					String strHistoryDate = ""; 
					String strHistoryFrom = "";
					if (astrSearchHistory[si].trim().length() > 2 ){
						strHistory = astrSearchHistory[si].substring(2,astrSearchHistory[si].length());
						strHistoryFrom = "";
					}
					
					String strDisHistory = strHistory;

					if (CutStr.cutStr(astrSearchHistory[si],2).equals("C:")){
						//strDisHistory = strDisHistory + "[해당메뉴로]";
												
						strHistoryFrom = "search";
					}
					
					arrHistoryTitle.add(strDisHistory);
					arrHistoryFrom.add(strHistoryFrom);
				}		
			}

		}
		//추천검색어
		if (strType.equals("c")){
			RecKeyword_Data[] reckeyword_data = null;
			reckeyword_data = RecKeyword_Proc.RecKeyword_List(strCate);  
			int reckeyword_length = reckeyword_data.length;
			for(int i=0;i<reckeyword_length;i++){
				String strReckeyWord = reckeyword_data[i].getCa_title();
				strReckeyWord = strReckeyWord.replaceAll("(?i)<EBR>","<br>");
				strReckeyWord = strReckeyWord.replaceAll("(?i)<ebr>","<br>");			
				strReckeyWord =  ReplaceStr.replace(strReckeyWord,"\"","&quot;");
				arrRecKeyword.add(strReckeyWord);
			}
		}
		
		//인기 검색어
		
		
		//연관검색어
		if (strType.equals("r")){
			Search_Category_Proc search_category_proc = new Search_Category_Proc();
			String strLinkageWords[] = search_category_proc.getLinkageWordList(strQuery);
			String strLinkageKeyword = "";
			
			if (strLinkageWords != null && strLinkageWords.length > 0 ){
				int intCnt = 0;
				for (int sci=0;sci<strLinkageWords.length;sci++){
					if (!strQuery.equals(strLinkageWords[sci])){
						if (intCnt > 0 ){
							strLinkageKeyword += ",";
						}			
						strLinkageKeyword += strLinkageWords[sci];
						intCnt++;
					}
				}
			}
			try{
				
					CSearch csearch = new CSearch();
					csearch.setIntPortSet(intEtcPortSet);//port
					csearch.setStrCollectionName(strAutoMakerCollectionName);//컬렉션명
					csearch.setStrHostSet(etcHostSet);//검색엔진 주소
					csearch.setStrUserIp(request.getRemoteAddr());
					csearch.setStrKeyword(strQuery);
					csearch.setNPageSize(30);
					String strAutoMakerTemp = csearch.CSearchRunSmartMaker();//실제 검색
					String astrAutoMakerTemp[] = strAutoMakerTemp.split("\\^");
					
					String strAutoMakerTemp2 = "";
					int intAutoMakeWCnt = 0;
					for (int i=0;i<astrAutoMakerTemp.length;i++){
						if (CutStr.cutStr(astrAutoMakerTemp[i],2).equals("W:")){
							boolean bWCheck = false;
							for (int j=0;j<i;j++){
								if (CutStr.cutStr(astrAutoMakerTemp[j],2).equals("W:")){
									if (astrAutoMakerTemp[i].equals(astrAutoMakerTemp[j])){
										bWCheck = true;
									}
								}
							}
							boolean bAdultKeyword = false;
							String strAdultKeyword = "성인용품,자위,콘돔,딜도";
							String[] strArrayAdultKeyword = strAdultKeyword.split(",");
							for (int ai=0;ai<strArrayAdultKeyword.length;ai++){
								if (astrAutoMakerTemp[i].indexOf(strArrayAdultKeyword[ai]) >= 0){
									bAdultKeyword = true;
									break;
								}
							}				
							if (!bWCheck && !bAdultKeyword && astrAutoMakerTemp[i].trim().length() <= 10 && intAutoMakeWCnt < 10 && !strQuery.toUpperCase().equals(ReplaceStr.replace(astrAutoMakerTemp[i].toUpperCase(),"W:",""))){
								if (strLinkageKeyword.trim().length() > 0){
									strLinkageKeyword += ",";
								}
								//strLinkageKeyword += ReplaceStr.replace(astrAutoMakerTemp[i],"W:","");
								arrLinkAgeWord.add(ReplaceStr.replace(astrAutoMakerTemp[i],"W:",""));
								intAutoMakeWCnt++; 
							}
						}
					}		
				}catch(Exception e){
				
				}finally {
				}		
							
			String  strLinkageWords2[] = search_category_proc.getLinkageWordListByEnuriKeyword(strQuery);
			if (strLinkageWords2 != null && strLinkageWords2.length > 0 ){
				int intCnt2 = 0;
				for (int sci2=0;sci2<strLinkageWords2.length;sci2++){
					if (!strQuery.equals(strLinkageWords2[sci2]) && strLinkageWords2[sci2].trim().length() <= 8 ){
						arrLinkAgeWord.add(strLinkageWords2[sci2]);
						intCnt2++;
					}
				}
			}
		}
		//System.out.println("-------------------------------------------------------");
		
		//자동완성
		if (strType.equals("a")){		
			
			String strRecFlag = cb.GetCookie("MOB_REC_FLAG","RECFLAG");

			CSearch csearch = new CSearch();
			
			csearch.setIntPortSet(intEtcPortSet);//port
			csearch.setStrCollectionName(strAutoMakerCollectionName);//컬렉션명
			csearch.setStrHostSet(etcHostSet);//검색엔진 주소
			csearch.setStrUserIp(request.getRemoteAddr());
			csearch.setStrKeyword(strQuery);
			
			String strSearchHistory2 =  cb.GetCookie("MOB_SEAR_HISTORY","SEARCHKEYWORD");
			//System.out.println("strSearchHistory2="+strSearchHistory2);
			String astrSearchHistory2[] = strSearchHistory2.split(",");
			String strSearchHistory2Text = "";
			String strTmp = "";
			
			String strAutoMakerTemp = csearch.CSearchRunSmartMaker();//실제 검색
			//System.out.println(strAutoMakerTemp);
			String strQueryOut = csearch.getStrQuery();
			//System.out.println("strQueryOut="+strQueryOut);
			String strAutoText = "|";
			 
			if(!strRecFlag.equals("N")){
				for(int i2=0 ;i2< astrSearchHistory2.length ; i2++){
					strSearchHistory2Text = astrSearchHistory2[i2];
					//System.out.println("strSearchHistory2Text="+strSearchHistory2Text);
					if (strSearchHistory2Text.indexOf(":") > -1){
						String strAutoQ = ":"+ strQuery;
						String strAutoQ_Upper = ":"+ strQuery.toUpperCase();
						String strAutoQ_Lower = ":"+ strQuery.toLowerCase();
						if(strSearchHistory2Text.indexOf(strAutoQ) > -1 || strSearchHistory2Text.indexOf(strAutoQ_Upper) > -1 || strSearchHistory2Text.indexOf(strAutoQ_Lower) > -1){
							strAutoMakerTemp = strAutoMakerTemp.replace(strSearchHistory2Text,"");
							 
							if (CutStr.cutStr(strSearchHistory2Text,2).equals("C:")){
								//strSearchHistory2Text = strSearchHistory2Text + "[해당메뉴로]";	
							}
							strSearchHistory2Text = strSearchHistory2Text.replace("C:","").replace("S:","").replace("W:","");
							arrHistoryTitle.add(strSearchHistory2Text.replace("C:","").replace("S:","").replace("W:",""));
							arrHistoryFrom.add("");		
							if(strTmp.equals("")){
								strTmp = strSearchHistory2Text.substring(0,strSearchHistory2Text.indexOf("__")) ;
							}else{
								strTmp = strTmp + "," + strSearchHistory2Text.substring(0,strSearchHistory2Text.indexOf("__")) ;
							}
							strAutoText = strAutoText + strSearchHistory2Text.substring(0,strSearchHistory2Text.indexOf("__")) + "|";
						} 
					} 
				} 
			}
			/*
			String astrAutoMakerTemp[] = strAutoMakerTemp.split("\\^");
									
			for (int i=0;i<astrAutoMakerTemp.length;i++){
				
				if(strAutoText.indexOf("|"+astrAutoMakerTemp[i].replace("W:","").replace("C:","")+"|") < 0){
					if (CutStr.cutStr(astrAutoMakerTemp[i],2).equals("W:")){
						boolean bWCheck = false;
						for (int j=0;j<i;j++){
							if (CutStr.cutStr(astrAutoMakerTemp[j],2).equals("W:")){
								if (astrAutoMakerTemp[i].equals(astrAutoMakerTemp[j])){
									bWCheck = true;
								} 
							}
						}
						boolean bAdultKeyword = false;
						String strAdultKeyword = "성인용품,자위,콘돔,딜도";
						String[] strArrayAdultKeyword = strAdultKeyword.split(",");
						for (int ai=0;ai<strArrayAdultKeyword.length;ai++){
							if (astrAutoMakerTemp[i].indexOf(strArrayAdultKeyword[ai]) >= 0){
								bAdultKeyword = true;
								break;
							}
						}				
						if (!bWCheck && !bAdultKeyword){
							arrAutoType.add("W"); 
							//System.out.println(ReplaceStr.replace(astrAutoMakerTemp[i],"W:",""));
							arrAutoWord.add(ReplaceStr.replace(astrAutoMakerTemp[i],"W:",""));
							arrAutoCate.add("");
						}
					}else if(CutStr.cutStr(astrAutoMakerTemp[i],2).equals("C:")){

						boolean bCCheck = false;
						for (int j=0;j<i;j++){
							if (CutStr.cutStr(astrAutoMakerTemp[j],2).equals("C:")){
								if (astrAutoMakerTemp[i].split("\\|").length > 1 &&  astrAutoMakerTemp[j].split("\\|").length > 1){
									if (astrAutoMakerTemp[i].split("\\|")[1].equals(astrAutoMakerTemp[j].split("\\|")[1])){
										bCCheck = true;
									}
								}
							}
						}
						
						String strAfterCheckCacode = astrAutoMakerTemp[i].split("\\|")[0];
						for (int j=i+1;j<astrAutoMakerTemp.length;j++){
							if (CutStr.cutStr(astrAutoMakerTemp[j],2).equals("C:")){
								if (j>=(astrAutoMakerTemp.length)){
									if (astrAutoMakerTemp[i].split("\\|").length > 1 &&  astrAutoMakerTemp[j].split("\\|").length > 1){
										if (astrAutoMakerTemp[i].split("\\|")[1].equals(astrAutoMakerTemp[j].split("\\|")[1])){
											strAfterCheckCacode = CutStr.cutStr(astrAutoMakerTemp[j].split("\\|")[0],6);
										}
									}
								}
							}
						}	
						
						if (!bCCheck){
		 					arrAutoType.add("C"); 
							arrAutoWord.add(astrAutoMakerTemp[i].split("\\|")[1].replace(">","> "));
							arrAutoCate.add(strAfterCheckCacode);
						}
						 
					}
				}
			}
			*/
			
			String astrAutoMakerTemp[] = strAutoMakerTemp.split("\\^");
			String strAutoMakerTemp2 = "";
			if (astrAutoMakerTemp != null && astrAutoMakerTemp.length > 0){
				for (int i=0;i<astrAutoMakerTemp.length;i++){
					if (CutStr.cutStr(astrAutoMakerTemp[i],2).equals("W:")){
						boolean bWCheck = false;
						for (int j=0;j<i;j++){
							if (CutStr.cutStr(astrAutoMakerTemp[j],2).equals("W:")){
								if (astrAutoMakerTemp[i].equals(astrAutoMakerTemp[j])){
									bWCheck = true;
								}
							}
						}
						boolean bAdultKeyword = false;
						String strAdultKeyword = "성인용품,자위,콘돔,딜도";
						String[] strArrayAdultKeyword = strAdultKeyword.split(",");
						for (int ai=0;ai<strArrayAdultKeyword.length;ai++){
							if (astrAutoMakerTemp[i].indexOf(strArrayAdultKeyword[ai]) >= 0){
								bAdultKeyword = true;
								break;
							}
						}				
						if (!bWCheck && !bAdultKeyword){
							//strAutoMakerTemp2 = strAutoMakerTemp2 + astrAutoMakerTemp[i] + "^";
							
							arrAutoType.add("W"); 
							//System.out.println(ReplaceStr.replace(astrAutoMakerTemp[i],"W:",""));
							arrAutoWord.add(ReplaceStr.replace(astrAutoMakerTemp[i],"W:",""));
							arrAutoCate.add("");
							
						}
					}else if(CutStr.cutStr(astrAutoMakerTemp[i],2).equals("C:")){
						boolean bCCheck = false;
						for (int j=0;j<i;j++){
							if (CutStr.cutStr(astrAutoMakerTemp[j],2).equals("C:")){
								if (astrAutoMakerTemp[i].split("\\|").length > 1 &&  astrAutoMakerTemp[j].split("\\|").length > 1){
									if (astrAutoMakerTemp[i].split("\\|")[1].equals(astrAutoMakerTemp[j].split("\\|")[1])){
										bCCheck = true;
									}
								}
							}
						}
						String strAfterCheckCacode = astrAutoMakerTemp[i].split("\\|")[0];
						for (int j=i+1;j<astrAutoMakerTemp.length;j++){
							if (CutStr.cutStr(astrAutoMakerTemp[j],2).equals("C:")){
								if (j>=(astrAutoMakerTemp.length)){
									if (astrAutoMakerTemp[i].split("\\|").length > 1 &&  astrAutoMakerTemp[j].split("\\|").length > 1){
										if (astrAutoMakerTemp[i].split("\\|")[1].equals(astrAutoMakerTemp[j].split("\\|")[1])){
											strAfterCheckCacode = CutStr.cutStr(astrAutoMakerTemp[j].split("\\|")[0],6);
										}
									}
								}
							}
						}				
						if (!bCCheck){
							if (astrAutoMakerTemp[i].split("\\|").length > 1 ){
								strAutoMakerTemp2 = strAutoMakerTemp2 + strAfterCheckCacode+"|"+astrAutoMakerTemp[i].split("\\|")[1] + "^";
								
								arrAutoType.add("C"); 
								arrAutoWord.add(astrAutoMakerTemp[i].split("\\|")[1].replace(">","> "));
								arrAutoCate.add(StringUtils.replace( strAfterCheckCacode, "C:", "") );
							} 
						}
					}
				}
		
				/*
				if (strAutoMakerTemp2 != null){
					String astrAutoMaker[] = strAutoMakerTemp2.split("\\^");
					String strAutoMaker = "";
					int intCnt = 0;
					for (int i=0;i<astrAutoMaker.length;i++){
						if (astrAutoMaker[i].trim().length() > 3 ){
							strAutoMaker = strAutoMaker + astrAutoMaker[i] + "^";
							intCnt++;
						}
						if (intCnt == 15 ){
							break;
						}	
					}
					if (strAutoMaker.trim().length() > 0 ){
						strAutoMaker = CutStr.cutStr(strAutoMaker,strAutoMaker.length()-1);
						out.println(strAutoMaker);
					}
				}
				*/
			}
			
			
			
		}
		//인기키워드
		
		if (strType.equals("m") || strType.equals("m3")){
			arrPopKeyword.add("포맷불필요 블랙박스");
			arrPopCate.add("21172018");
			arrPopKeyword.add("14년형 UHD TV");
			arrPopCate.add("02012407");
			arrPopKeyword.add("또봇 ZERO");
			arrPopCate.add("");
			arrPopKeyword.add("엑스페리아Z2 태블릿");
			arrPopCate.add("");
			arrPopKeyword.add("2룸텐트");
			arrPopCate.add("09310301"); 
			arrPopKeyword.add("목걸이형 블루투스");
			arrPopCate.add("03180202"); 
			arrPopKeyword.add("1인용 소파");
			arrPopCate.add("12011401"); 
			arrPopKeyword.add("코오롱 로건 자켓");
			arrPopCate.add(""); 
		}      

		if (strType.equals("m")){
			int intMaxCount = 30;
			int intMaxCount2 = 15;
			strReturn += "{";
			strReturn += getHistoryWords(intMaxCount2,arrHistoryTitle,arrHistoryFrom);
			strReturn += getPopularWords(intMaxCount-arrHistoryTitle.size(),arrPopKeyword,arrPopCate);
			
			if (strReturn.trim().length() > 1 ){
				strReturn = CutStr.cutStr(strReturn,strReturn.length()-1);
			}
			strReturn += "}";
		} 
		
		if (strType.equals("m2")){
			int intMaxCount = 15;
			strReturn += "{"; 
			strReturn += getHistoryWords(intMaxCount,arrHistoryTitle,arrHistoryFrom);
				
			if (strReturn.trim().length() > 1 ){
				strReturn = CutStr.cutStr(strReturn,strReturn.length()-1);
			}
			strReturn += "}";

		} 
		
		if (strType.equals("m3")){
			int intMaxCount = 15;
			strReturn += "{";
			//strReturn += getHistoryWords(intMaxCount,arrHistoryTitle,arrHistoryFrom);
			strReturn += getPopularWords(intMaxCount-arrHistoryTitle.size(),arrPopKeyword,arrPopCate);
			
			if (strReturn.trim().length() > 1 ){
				strReturn = CutStr.cutStr(strReturn,strReturn.length()-1);
			}
			strReturn += "}";
		} 
		
		
		if (strType.equals("c")){
			int intMaxCount = 30;
			strReturn += "{";
			strReturn += getRecKeyWords(arrRecKeyword);
			strReturn += getHistoryWords(intMaxCount-arrRecKeyword.size(),arrHistoryTitle,arrHistoryFrom);
			if (strReturn.trim().length() > 1 ){
				strReturn = CutStr.cutStr(strReturn,strReturn.length()-1);
			}
			strReturn += "}";		
		}
		
		if (strType.equals("a")){
			
			int intMaxCount = 15;
			int intMaxCount2 = 5;
			strReturn += "{"; 
			strReturn += getHistoryWords(intMaxCount2,arrHistoryTitle,arrHistoryFrom);
			strReturn += getAutoWords(intMaxCount-arrHistoryTitle.size(),arrAutoType,arrAutoWord,arrAutoCate,strQuery);
			if (strReturn.trim().length() > 1 ){
				strReturn = CutStr.cutStr(strReturn,strReturn.length()-1);
			}			
			strReturn += "}";
		}
		if (strType.equals("r")){
			int intMaxCount = 15;
			strReturn += "{";
			strReturn += getLinkAgeWords(intMaxCount, arrLinkAgeWord);
			if (strReturn.trim().length() > 1 ){
				strReturn = CutStr.cutStr(strReturn,strReturn.length()-1);
			}
			strReturn += "}";	
		}
		
	}catch(Exception e){ 
	}finally { 
	}  
	out.print(strReturn);
%>
<%!
	public String getPopularWords(int intMaxSize,ArrayList arrPopKeyword,ArrayList arrPopCate){
		String strReturn = "";
		if (arrPopKeyword.size() > 0 ){ 
			strReturn += "\"popular\":[";			
			for (int i=0;i<intMaxSize;i++){
				if (i == arrPopKeyword.size()){
					break;
				}			
				if (i > 0){
					strReturn += ",";
				}							
				strReturn += "{\"keyword\":\""+((String)arrPopKeyword.get(i))+"\",\"cate\":\""+((String)arrPopCate.get(i))+"\"}";
			}
			strReturn += "],";
		}	
		return strReturn;
	}
	public String getRecKeyWords(ArrayList arrRecKeyword){
		String strReturn = "";
		if (arrRecKeyword.size() > 0 ){ 
			int intCnt = 0;
			strReturn += "\"reckeyword\":[";			
			for (int i=0;i<arrRecKeyword.size();i++){
				if (((String)arrRecKeyword.get(i)).indexOf(".gif") < 0){
					if (intCnt > 0){
						strReturn += ",";
					}							
					strReturn += "{\"keyword\":\""+((String)arrRecKeyword.get(i))+"\"}";
					if (intCnt == 29 ){
						break;
					}
					intCnt++;
				}
			}
			strReturn += "],";
		}	
		return strReturn;
	}	
	public String getHistoryWords(int intMaxSize,ArrayList arrHistoryTitle,ArrayList arrHistoryFrom){
		String strReturn = "";
		if (arrHistoryTitle.size() > 0 ){
			strReturn += "\"history\":[";			
			for (int i=0;i<intMaxSize;i++){
				if (i == arrHistoryTitle.size()){
					break;
				}
				if (i > 0){
					strReturn += ",";
				}							
				strReturn += "{\"keyword\":\""+((String)arrHistoryTitle.get(i))+"\",\"from\":\""+((String)arrHistoryFrom.get(i))+"\"}";
			}
			strReturn += "],";
		}
		//System.out.println("strReturn==="+strReturn);
		return strReturn;
	}	
	public String getAutoWords(int intMaxSize ,ArrayList arrAutoType, ArrayList arrAutoWord,ArrayList arrAutoCate,String strQuery)  {
		String strReturn = "";
		if (arrAutoType.size() > 0 ){
			/*
			strReturn += "\"auto\":[";			
			if(arrAutoType.size() < intMaxSize){
				intMaxSize = arrAutoType.size();
			}
			for (int i=0;i<intMaxSize;i++){				
				
				if (i > 0){
					strReturn += ",";
				}
				String word = (String)arrAutoWord.get(i);
				strReturn += "{\"keyword\":\""+(String)arrAutoWord.get(i)+"\",\"type\":\""+((String)arrAutoType.get(i))+"\",\"cate\":\""+((String)arrAutoCate.get(i))+"\"}";	
				
			} 
			strReturn += "],";
			*/
			try{
				JSONArray jsonArr = new JSONArray ();
				for (int i=0;i<arrAutoType.size();i++){
					
					String word = (String)arrAutoWord.get(i);
					String type = (String)arrAutoType.get(i);
					String cate = (String)arrAutoCate.get(i);
					
					//if(!word.equals(strQuery)){ //앱 기준으로 자동완성 노출되도록 수정
						
						JSONObject json = new JSONObject();
						json.put("keyword", word);
						json.put("type", type);
						json.put("cate", cate);
						jsonArr.put(json);
						
						//System.out.println(i+":"+"word:"+word);
					//}
				}
				strReturn += "\"auto\":";
				strReturn += jsonArr.toString();
				strReturn += ",";
				
				
			}catch(Exception ex){
				System.out.println(ex);	
			}
			
		}
		return strReturn;
	}	
	public String getLinkAgeWords(int intMaxSize, ArrayList arrLinkAgeWord){
		String strReturn = "";
		if (arrLinkAgeWord.size() > 0 ){ 
			int intCnt = 0;
			strReturn += "\"linkage\":[";			
			for (int i=0;i<intMaxSize;i++){
				if (i == arrLinkAgeWord.size()){
					break;
				}		
				if(i > 0){
					strReturn += ",";
				}
				strReturn += "{\"keyword\":\""+((String)arrLinkAgeWord.get(i))+"\"}";
			}
			strReturn += "],";
		}	
		return strReturn;
	}
%>