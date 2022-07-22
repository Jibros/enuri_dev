<%
	String strTrendTabFileNm = "/wide/main/ajax/wtrendList_title1.jsp";
	String strTrendConFileNm = "/wide/main/ajax/wTrendHtml_new1.jsp";
	int intTrendInitNum = 1;
	int intTrendTotalPage = 1; //전체 페이지 
	
	try{
 		org.json.simple.JSONObject trendTotalObj =  new org.json.simple.JSONObject();
		trendTotalObj = readTrendJson();
		
		int intTrendAdPer = 5; // 광고 비율
		int intTrendPer = 5; //일반 비율
		org.json.simple.JSONArray trendAdPageNumArr = new org.json.simple.JSONArray();//광고 페이지 번호들
		
		if(trendTotalObj.size() > 0) {
			intTrendTotalPage = Integer.parseInt(trendTotalObj.get("total_page").toString()); 
			intTrendAdPer = Integer.parseInt(trendTotalObj.get("adRatio").toString()); 
			trendAdPageNumArr = (org.json.simple.JSONArray)trendTotalObj.get("adPage"); 
			
			intTrendAdPer = (int)(intTrendAdPer *0.1); 
			intTrendPer = 10 - intTrendAdPer;

			String strAdYN = "Y";
			int intAdYNRanIdx = 0; 
			int intTrendRandIdx = 0; 
			
			org.json.simple.JSONArray adYNArr = new org.json.simple.JSONArray();
			for(int i =1; i <= 10; i++) { //광고 Y,N을 비율만큼 넣어주기
				if (i >= 1 && i <= intTrendAdPer) adYNArr.add("Y");
				else	adYNArr.add("N");
			}
			intAdYNRanIdx =  (int) (Math.random() * 10); 
			strAdYN = adYNArr.get(intAdYNRanIdx).toString();
			
			int intAdPageLength = trendAdPageNumArr.size();
			if (strAdYN.equals("Y")) { // 광고판이 나와야 될 때
				intTrendInitNum = 1; //광고 노출일경우는 1번판을 디폴트로 함.
			} else { //일반판
				org.json.simple.JSONArray idxArr = new org.json.simple.JSONArray(); //일반판 번호들
				for (int i = 1; i <= intTrendTotalPage; i++) {
					boolean blAdChk = false;
					for (int j = 0; j < intAdPageLength; j ++) {
						int intAdNum =  Integer.parseInt(trendAdPageNumArr.get(j).toString());
						if (i == intAdNum) {
							blAdChk = true;
							break;
						}
					}
					if (!blAdChk) idxArr.add(i);
				}
				intTrendRandIdx = (int) (Math.random() * idxArr.size()); 
				intTrendInitNum = Integer.parseInt(idxArr.get(intTrendRandIdx).toString());
			}
			strTrendTabFileNm = "/wide/main/ajax/wtrendList_title"+intTrendInitNum+".jsp";
			strTrendConFileNm = "/wide/main/ajax/wTrendHtml_new"+intTrendInitNum+".jsp";
		}
 	}catch(Exception e){}  
%>
<div class="trendpickup">
	<div class="trendpickup__inner">
		<div class="trendtabs">
			<h1 class="trendtabs__tit">트렌드픽업</h1>
			<!-- 220217 : SR#51471 : PC 트렌드픽업 수정 건 -->
			<div class="trendtabs__pagination">
				<span class="page_current"><%=intTrendInitNum %></span><span class="page_slash">/</span><span class="page_total"><%=intTrendTotalPage %></span>
			</div>
			<!-- 트렌드픽업 탭 이동 화살표 -->
			<div class="arrows arrows--wihte">
				<button type="button" class="arr arr-prev" id="shopmenu__btn_prev">이전</button>
				<button type="button" class="arr arr-next" id="shopmenu__btn_next">다음</button>
			</div>
			<div class="trendtabs__mask">
				<jsp:include page="<%=strTrendTabFileNm %>"/>
			</div>
		</div>
		<div class="trendpickup__container">
			<jsp:include page="<%=strTrendConFileNm %>"/>
		</div>
	</div>
</div>
<script>var vTrendPageNum =<%=intTrendInitNum %>; var vTrendTotalPage = <%=intTrendTotalPage%>; </script>
<%!
public org.json.simple.JSONObject readTrendJson() throws Exception{
	String strFileNm = "/was/lena/1.3/depot/lena-application/ROOT/wide/main/ajax/adPage.json";
	org.json.simple.JSONObject jobject = new org.json.simple.JSONObject();
	try{
		org.json.simple.parser.JSONParser parser = new org.json.simple.parser.JSONParser();
		java.io.Reader reader = new java.io.FileReader(strFileNm);
		jobject = (org.json.simple.JSONObject)parser.parse(reader);
	}catch(Exception ex) {}
	return jobject;
}
%>