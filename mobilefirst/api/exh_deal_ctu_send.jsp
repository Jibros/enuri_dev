<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.enuri.exception.ExceptionManager"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.bean.mobile.Mobile_Deal_Proc"%>
<%@page import="org.json.*"%>
<%@page import="java.io.*"%>
<%@page import="com.enuri.util.common.CommonFtp"%>
<%@page import="com.oroinc.net.ftp.*"%>
<%@page import="com.enuri.bean.main.deal.Exhdeal_Proc"%>
<%
	String devYN = ChkNull.chkStr(request.getParameter("devYN"), "N");
	String exh_id = ChkNull.chkStr(request.getParameter("exh_id"), "2018090101");
	
	String fileName = "exh_deal_list_" + exh_id +".json";
	String fileFullName = "C:/www/jsp/mobilefirst/http/json/" + fileName;
	
	boolean vReturn = false;
	JSONArray jSONArray = new JSONArray(); 
	JSONObject jSONObject = new JSONObject();
	
	Exhdeal_Proc proc = new Exhdeal_Proc(devYN);
	
	jSONArray = proc.getJsonArray(exh_id);
	boolean mReturn = jsonFileWrite80(jSONArray , fileFullName);
	
	if(mReturn){
		ArrayList<String> ipList = getRelaseIpList(devYN);
		vReturn = ftpSendCrazy(ipList, fileName);
	}
%>
<%!
public ArrayList<String> getRelaseIpList (String type) {
	ArrayList<String> ipList = new ArrayList<String>();
	ipList.add("100.100.100.151");

	if(type.equals("N")) {
		ipList.add("100.100.100.170");
		ipList.add("100.100.110.171");
		ipList.add("100.100.100.172");
		ipList.add("100.100.110.173");
		ipList.add("100.100.100.174");
		ipList.add("100.100.110.175");
		ipList.add("100.100.100.176");
		ipList.add("100.100.110.177");
		ipList.add("100.100.100.178");
		ipList.add("100.100.110.179");
		ipList.add("100.100.110.191");
		ipList.add("100.100.100.192");
	}
	return ipList;
}

public boolean jsonFileWrite80(JSONArray arrayList , String fileName) throws JSONException{
 	
	boolean result = false;

	try {
		//파일생성
		File file = new File(fileName);
		file.createNewFile();

		BufferedWriter wt = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), "UTF-8"));
		
		wt.write(arrayList.toString());
		wt.close();
		
		result = true;
	} catch (IOException e) {
		System.out.println("********* MoblieDealProc jsonFileWrite **************:"+e);
	}
	return result; 

}
//운영에 생성된 파일들 전송 테스트
public boolean ftpSendCrazy(ArrayList<String> ipList,String fileName) throws ExceptionManager{
	
	boolean result = false; 

	int port = 21;
	String ftpId = "lena";
	String ftpPw = "#cloud2021";
	
	try {
		
		String putUrl = "C:/www/jsp/mobilefirst/http/json";

		//ftp 전송
		for(int i = 0; i<ipList.size() ;i++){
			CommonFtp commonFtp = new CommonFtp((String)ipList.get(i),port,ftpId,ftpPw);
			commonFtp.login();
			commonFtp.cd("/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/http/json");  
			
			boolean putResult = commonFtp.put(fileName,fileName,putUrl);
			
			long time = System.currentTimeMillis(); 
			SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
			String str = dayTime.format(new Date(time));
	        System.out.println(str+"    시즌 딜 품절: "+(String)ipList.get(i)+" 전송 "+putResult);
	        commonFtp.disconnect();
	        
        }
		result = true;
	} catch (Exception e) {
		System.out.println("Mobile_Deal_Proc ftp Error"+e);
		result = false;
	}
	return result ;
}
%>