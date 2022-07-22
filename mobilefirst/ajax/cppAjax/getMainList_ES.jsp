<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true" %>
<%@page import="javax.servlet.http.Cookie"%>
<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>
<%@ include file="/wide/include/IncSearch.jsp"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@page import="com.enuri.bean.mobile.Cpp_Proc"%>
<%@page import="com.enuri.bean.mobile.Cpp_Data"%>
<jsp:useBean id="Searchfunction" class="com.enuri.bean.search.SearchFunction"  />
<% 
	String strGcate = ChkNull.chkStr(request.getParameter("gcate"), "1"); //  CPP카테고리
	
	JSONArray dataArr = new JSONArray();
	
	Cpp_Proc cpp_proc = new Cpp_Proc();
	
	// 1. GNB 기준 gcate 의 하위 모든 카테고리를 Map<카테고리 코드, 카테고리명> 단위로 가져온다.
	Map<String, String> gCatesMap = cpp_proc.getGnbCateMap(strGcate);
	
	// 한번에 모든 데이터를 가져올 경우
	// String gCateEs = gCatesMap.entrySet().stream().map(entrySet -> entrySet.getKey()).collect(Collectors.joining(","));
	
	// ES에서 콜백받은 모델번호들을 저장
	
	Iterator<String> iteCateKey = gCatesMap.keySet().iterator();
	
	/* 검색엔진 관련 변수 세팅 */
	Set<String> modelSet = new HashSet<String>();
	String strFrom = "list";
	String strIsTest = "N";
	int intTab = 1;
	String strDevice = "pc";
	String strPrtModelNo = "";
	String strKeyword = "";
	String strInKeyword = "";
	String strIsRental = "N";
	String strParamFactory = "";
	String strParamBrand = "";
	String strParamShopCode = "";
	String strSpec = "";
	long lngSPrice = 0;
	long lngEPrice = 0;
	String strIsReSearch = "Y";
	int intSort = 1;
	String strSort = "popular DESC";
	int pageNum = 1;
	int pageGap = 6;
	
	// 2. 검색엔진을 통해 데이터를 추출한다.
	while(iteCateKey.hasNext()) {
		String strCate = iteCateKey.next();
		String strCate4 = strCate;
		
		/** ES Search */
%><%@ include file="/wide/include/IncEsSearch.jsp"%><%
		/** // ES Search */
		
		String[] strModels = strMpnos.replaceAll("G","").split(",");
		for (int i = 0; i< strModels.length; i++){  
			modelSet.add(strModels[i]);
		}
	}
	
	// 3. 오라클을 활용하여 세부데이터를 추가한다.
	try {
		dataArr = cpp_proc.CppList_Model(modelSet, gCatesMap);
	//	Collections.shuffle(dataArr);
	} catch(Exception e) { }
	
	JSONObject retObj = new JSONObject();
	retObj.put("cppList", dataArr);
	out.print(retObj);
%>