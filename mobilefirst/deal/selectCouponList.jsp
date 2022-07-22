<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.bean.mobile.CDealLpSearch"%>
<%@page import="com.enuri.bean.mobile.SocialGoods_Proc"%>
<%@page import="javax.servlet.http.Cookie"%>
<%@ page contentType="application/json; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="org.json.*"%>
<%@ page import="java.io.InputStream"%>
<%@page import="javax.servlet.ServletInputStream,javax.servlet.http.HttpServletRequest"%>
<%@page import="java.io.BufferedReader,java.io.InputStreamReader"%>
<%!
	public String getUserAddr(HttpServletRequest request){
	   	String ip = request.getHeader("log.user_ip");
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-Forwarded-For");
		}
		if(ip != null && ip.indexOf(",")>-1) {
			ip = ip.split(",")[0];
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
	
	public String getUserAgent(HttpServletRequest request){
		return request.getHeader("log.user_agent") != null ? request.getHeader("log.user_agent") : request.getHeader("User-Agent");
	}
%>
<%
	JSONObject param = getPostParameter(request.getInputStream());
	JSONObject resJSON = new JSONObject();

	String id = param.optString("mbId", "");
	String cate1 = param.optString("cate1", "");
	String cate2 = param.optString("cate2", "");
	String cate3 = param.optString("cate3", "");
	String buyOpt = param.optString("buyOpt", "");
	String align = param.optString("prodAlign", "pop");
	String malls = param.optString("malls", "");
	int pagingSize = param.optInt("pagingSize", 50);
	int pagingRowNum = param.optInt("pagingRnum", 0);

	CDealLpSearch search = new CDealLpSearch();
	search.setStrUserIp(getUserAddr(request)); //사용자 주소
	search.setStrUserAgent(getUserAgent(request)); // 사용자 Agent
	
	if (!StringUtils.isEmpty(cate1))
		search.setStrCpCate1(cate1);

	if (!StringUtils.isEmpty(cate2))
		search.setStrCpCate2(cate2);

	if (!StringUtils.isEmpty(cate3))
		search.setStrCpCate3(cate3);

	if (!StringUtils.isEmpty(buyOpt))
		search.setStrBuyOpt(buyOpt);

	if (!StringUtils.isEmpty(malls))
		search.setStrMalls(malls);
	
	search.setStrProdAlign(align);

	search.setIntPageSize(pagingSize);
	search.setIntPageFrom(pagingRowNum);

	int intErrorCode = search.run();
	JSONObject result = new JSONObject();
	result.put("buyOpt", buyOpt);
	result.put("list", appendZzimInfo(search, id));
	result.put("result", intErrorCode == 0);
	result.put("totalSize", search.getIntTotal());

	out.println(result.toString(4));
%>

<%!public boolean isEqualsJSON(JSONObject param, String key, String compareTo) {
		boolean result = false;
		try {
			result = param.has(key) && param.getString(key).equals(compareTo);
		} catch (Exception e) {
			result = false;
		}
		return result;
	}

	public boolean isEmptyJSON(JSONObject param, String key) {

		boolean result = false;
		try {
			result = !param.has(key) || param.getString(key).length() == 0;
		} catch (Exception e) {
			result = false;
		}
		return result;
	}

	public JSONObject getPostParameter(InputStream inputStream) {

		StringBuilder stringBuilder = new StringBuilder();
		JSONObject param = new JSONObject();
		if (inputStream != null) {
			try {
				BufferedReader bufferedReader = new BufferedReader(
						new InputStreamReader(inputStream));
				char[] charBuffer = new char[128];
				int bytesRead = -1;
				while ((bytesRead = bufferedReader.read(charBuffer)) > 0) {
					stringBuilder.append(charBuffer, 0, bytesRead);
				}
				bufferedReader.close();
				inputStream.close();

				param = new JSONObject(stringBuilder.toString());
			} catch (Exception e) {

			}
		}

		return param;
	}
	
	public JSONObject appendZzimInfo(CDealLpSearch search, String enuriId) {
		
		JSONObject list = new JSONObject();
		String cpId = "";
		String cpCompany = "";
		String cpUrl = "";

		try {
			if (search == null || search.getJsonResult() == null) {
				list.put("DS_COUPON", new JSONArray());
			} else if (StringUtils.isEmpty(enuriId)) {
				JSONArray array = search.getJsonResult();
				for(int i=0;i<array.length();i++){
					JSONObject obj = array.getJSONObject(i);
					cpId = obj.getString("cpId");
					cpCompany = obj.getString("cpCompany");
					try{
						cpUrl = URLEncoder.encode(toUrlCode(obj.getString("cpUrl")),"UTF-8");	
					}catch(Exception e){
						
					}
						
					cpUrl = "http://www.enuri.com/deal/move.html?freetoken=outlink&cpId="+cpId+"&cpCompany="+cpCompany+"&cpUrl="+cpUrl;
					obj.put("cpUrl",cpUrl);
				}
				list.put("DS_COUPON", array);
			} else {
				JSONArray array = search.getJsonResult();
				Map<String, String> zzimIdMap = new SocialGoods_Proc().selectZzimListCpId(enuriId);
				for (int i=0; i<array.length(); i++) {
					JSONObject obj = array.getJSONObject(i);
					
					if (zzimIdMap.containsKey(obj.optString("cpId")))
						obj.put("regdate", "zzim");
				}
				
				list.put("DS_COUPON", array);
			}
		} catch (JSONException e) {
			
		}
	
		return list;
	}
%>