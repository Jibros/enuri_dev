<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.io.*"%>
<%@ page import="com.enuri.util.common.JsonResponse"%>
<%@ page import="com.enuri.bean.lsv2016.ReviewInfoList_Data"%>
<%@ page import="com.enuri.bean.lsv2016.ReviewInfoList_Proc"%>
<%
if(!CvtStr.isNumeric(request.getParameter("modelno"))){
    return ;
}
	int intModelno = ChkNull.chkInt(request.getParameter("modelno"));
	String strCategory = ChkNull.chkStr(request.getParameter("cate"));
	String strModelName = ChkNull.chkStr(request.getParameter("modelnm"));
	String strKeyword = ChkNull.chkStr(request.getParameter("keyword"));
	String strContentFlag = "";
	String strVideoFlag = "";
	String strBlogFlag = "";
	String strModelnmFlag = "";
	String strNewKeyword = "";
	JsonResponse ret = null;
	JSONObject rtnJSONObject = new JSONObject();
	JSONObject tmpJSONObjectBlog = new JSONObject();
	JSONObject tmpJSONObjectVideo = new JSONObject();
	ReviewInfoList_Proc reviewInfoList_Proc = new ReviewInfoList_Proc();
	ReviewInfoList_Data reviewInfoListModelnm_Data = null;
	ReviewInfoList_Data reviewInfoList_Data = null;
	String strRemoteHost = ConfigManager.szConnectIp(request);
	reviewInfoList_Data = reviewInfoList_Proc.get_model_portal_flag(intModelno);
	strKeyword = strKeyword.replaceAll("%(?![0-9a-fA-F]{2})", "%25");
	strKeyword = URLDecoder.decode(strKeyword, "UTF-8");

	if (reviewInfoList_Data != null) {
		if (!"".equals(reviewInfoList_Data.getKeyword())) strNewKeyword = reviewInfoList_Data.getKeyword();
		strContentFlag = reviewInfoList_Data.getContents_flag();
		strVideoFlag = reviewInfoList_Data.getVideo_flag();
		strBlogFlag = reviewInfoList_Data.getBlog_flag();
	}

	if(reviewInfoList_Data == null || (reviewInfoList_Data != null && "".equals(reviewInfoList_Data.getKeyword()))){
		if(strCategory.length()>0){
			reviewInfoListModelnm_Data = reviewInfoList_Proc.get_category_portal_flag(strCategory);

			if(reviewInfoListModelnm_Data!=null) strModelnmFlag = reviewInfoListModelnm_Data.getModelnm_flag();

			if(strModelnmFlag.equals("1")){
				strNewKeyword = strKeyword;
			}else{
				strNewKeyword = strModelName;
			}

			if(!(CutStr.cutStr(strCategory, 2).equals("93"))) {
				if(strNewKeyword.indexOf("[") > -1) strNewKeyword = strNewKeyword.substring(0, strNewKeyword.indexOf("["));
			}

			if(strNewKeyword.indexOf("(") > -1) strNewKeyword = strNewKeyword.substring(0, strNewKeyword.indexOf("("));
		}
	}

	if(!strContentFlag.equals("1")) {
		reviewInfoList_Data = reviewInfoList_Proc.get_category_portal_flag(strCategory);

		if(reviewInfoList_Data != null) {
			strContentFlag = reviewInfoList_Data.getContents_flag();
			strVideoFlag = reviewInfoList_Data.getVideo_flag();
			strBlogFlag = reviewInfoList_Data.getBlog_flag();
		}
	}

	if(!strContentFlag.equals("1")) {
		ret = new JsonResponse(false).setData(rtnJSONObject);
	    out.println(ret.toString());
	} else {
		if(strBlogFlag.equals("1")) tmpJSONObjectBlog = getGoodsBbsZum("blog",20,strNewKeyword,strRemoteHost);
		if(strVideoFlag.equals("1")) tmpJSONObjectVideo = getGoodsBbsZum("video",10,strNewKeyword,strRemoteHost);

		rtnJSONObject.put("blog",tmpJSONObjectBlog);
		rtnJSONObject.put("video",tmpJSONObjectVideo);
		rtnJSONObject.put("keyword",URLEncoder.encode(strNewKeyword, "UTF-8"));

		ret = new JsonResponse(true).setData(rtnJSONObject);
		out.println(ret.toString());
	}
%>

<%!
	public JSONObject getGoodsBbsZum(String sCn, int rowCnt, String keyWord,String ip) {
		JSONObject jsonObj = new JSONObject();
		StringBuffer strUrl = new StringBuffer();

		try{
			//URL obj = new URL("http://search.engine.zum.com/search/enuri/?cn=" + sCn + "&start=0&rows=" + rowCnt + "&q=" + java.net.URLEncoder.encode(strKeyword, "UTF-8")); //+ strKeyword.replaceAll(" ", "+")); // 호출할 url
			/**[ZUM] API변경에 따른 대응 (#43757)
			**
			**     q  검색어
			** start  결과 시작 인덱스
			**  rows  결과 수
			**  rank  값 범위 = date(최신순), 기본 값 = special(정확도) , blog
			**  rank  값 범위 = date(최신순), 기본 값 = relevance(정확도) , video
			**
			**/

			if(sCn.equals("blog")){
				strUrl.append("http://external.searchapi.zum.com/search.zum/enuri/blog");
			}else{
				strUrl.append("http://external.searchapi.zum.com/search.zum/enuri/video");
			}
			strUrl.append("?q=" + java.net.URLEncoder.encode(keyWord, "UTF-8"));
			strUrl.append("&rows=" + rowCnt);

			URL obj = new URL(strUrl.toString());

			HttpURLConnection con = (HttpURLConnection)obj.openConnection();

			con.setConnectTimeout(10000);
			con.setReadTimeout(10000);
			con.setDoOutput(true);
			con.setUseCaches(false);
			con.setRequestMethod("GET");

			String inputLine = "";
			BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			StringBuffer res = new StringBuffer();

			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			
			jsonObj = new JSONObject(res.toString());
		}catch (FileNotFoundException e) {
			System.out.println("FileNotFoundException : " +e.getMessage());
		}catch (IOException e) {
			System.out.println("IOException  : " + e.getMessage() + " || remoteIP : "+ ip + " || connection URL : "+strUrl);
		}catch (Exception  e) {
			System.out.println("Exception   : " );
		}
		return jsonObj;
	}
%>