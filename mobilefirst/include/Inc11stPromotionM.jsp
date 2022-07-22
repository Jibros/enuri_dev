<%@page import="java.io.*" %>
<%
StringBuilder sb11StPro = new StringBuilder();
String str11StPro = "";

if(com.enuri.util.date.DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.03.19. 10:00")>0 
		&& com.enuri.util.date.DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.04.30. 23:59")<=0){
	FileReader fr = null;
	char [] buff = new char[512];
	int len = -1;
	 
	try {
		fr = new FileReader("/was/lena/1.3/depot/lena-application/ROOT/lsv2016/etc/event_11st.json");
		//fr = new FileReader("C:/resin-pro-3.1.13/webapps/ROOT/lsv2016/etc/event_11st.json");
		
		while((len=fr.read(buff)) != -1){
			sb11StPro.append(new String(buff, 0, len));
		}
		str11StPro = sb11StPro.toString();
	} catch (IOException ex) {
		System.out.println("IOException : " + ex.getMessage());
	} finally {
		if (fr != null) try { fr.close();} catch (IOException ex){}
	}
}
%>