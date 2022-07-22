<%@page import="java.io.IOException"%>
<%@page import="java.net.MalformedURLException"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.UUID"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.io.UnsupportedEncodingException"%>
<%@page import="org.json.JSONException"%>
<%@page import="org.json.JSONObject"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%!
public JSONObject urlConversion(JSONObject jsonobj) throws Exception{
		
		//String url , String shopCode, String  plno , String from
		String uuid = StringUtils.substring(UUID.randomUUID().toString().replace("-", ""),0 , 8);  //캐시방지
		String url = "";
		String shopCode = "";
		String pl_no = "";
		
		StringBuffer gateUrl = new StringBuffer (); 
		gateUrl.append("http://m.enuri.com/mobilefirst/move.jsp?");
		
		if(jsonobj.isNull("shopcode")) shopCode = "";
		else shopCode = jsonobj.getString("shopcode");
		
		gateUrl.append("&vcode="+shopCode);
		
		if(jsonobj.isNull("pl_no")) pl_no = "";
		else pl_no = jsonobj.getString("pl_no");
		gateUrl.append("&plno="+pl_no);
		
		if(jsonobj.isNull("url")){
			url = "";
		}else{
			url = URLEncoder.encode(jsonobj.getString("url"), "UTF-8");
		}
		gateUrl.append("&url="+url);
		
		gateUrl.append("&ch="+uuid);
		jsonobj.put("url", gateUrl.toString());	
		
		return jsonobj;
		
}

public JSONObject urlConversion(JSONObject jsonobj,int shopCode) throws Exception{
	
	//String url , String shopCode, String  plno , String from
	String uuid = StringUtils.substring(UUID.randomUUID().toString().replace("-", ""),0 , 8);  //캐시방지
	String url = "";
	
	String pl_no = "";
	
	StringBuffer gateUrl = new StringBuffer (); 
	gateUrl.append("http://m.enuri.com/mobilefirst/move.jsp?");
	gateUrl.append("&vcode="+shopCode);
	
	if(jsonobj.isNull("pl_no")) pl_no = "";
	else pl_no = jsonobj.getString("pl_no");
	gateUrl.append("&plno="+pl_no);
	
	if(jsonobj.isNull("url")){
		url = "";
	}else{
		url = URLEncoder.encode(jsonobj.getString("url"), "UTF-8");
	}
	gateUrl.append("&url="+url);
	
	gateUrl.append("&ch="+uuid);
	jsonobj.put("url", gateUrl.toString());	
	
	return jsonobj;
	
}

protected void pushMsgGo(String msg){
	//http://jca.enuri.com:8080/jqgrid/push/ajax/push_proc_ems_ajax.jsp?title=strtitle&page=index.jsp&msg=%EC%99%84%EC%84%B1%EB%90%9C%EA%B2%BD%EC%9A%B0&lab=strlab&team=msolution&type=exception
	//title: "strtitle",
	//message: "[strlab>msolution/index.jsp] 완성된경우",
	//노트3 endpoint
	StringBuilder sbUrl = new StringBuilder();
	
	try {
	sbUrl.append("http://jca.enuri.com:8080/jqgrid/push/ajax/push_proc_ems_ajax.jsp");
	sbUrl.append("?title=enuriBatchError");
	sbUrl.append("&msg="+URLEncoder.encode(msg,"UTF-8"));
	sbUrl.append("&lab=m&uLab&team=mplatform&type=exception");
	//String arn = "arn:aws:sns:ap-northeast-1:351636241112:endpoint/GCM/enuri.monitoring/164829f3-a242-3bc6-b11d-c7e31f708d47";
	//sbUrl.append("&arn="+arn);
	} catch (UnsupportedEncodingException e1) {
		e1.printStackTrace();
	}
	
	BufferedReader br;
	try {
		br = new BufferedReader(new InputStreamReader((new URL(sbUrl.toString())).openConnection().getInputStream(),"UTF-8"));
		
		StringBuilder sbJson = new StringBuilder();
		String strLine = "";
		    
		while ((strLine = br.readLine()) != null){			   	sbJson.append(strLine);			}
		br.close();
		
	} catch (UnsupportedEncodingException e) {
		e.printStackTrace();
	} catch (MalformedURLException e) {
		e.printStackTrace();
	} catch (IOException e) {
		e.printStackTrace();
	}
}

%>