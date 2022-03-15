<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.net.*,java.io.*"%>
<%@ include file="/include/Base_Inc_New_2010.jsp"%>
<%@ page import="com.enuri.bean.main.GNB_List_Data"%>
<%@ page import="com.enuri.bean.main.GNB_List_2021_Proc"%>
<%
	String login_id    = cb.GetCookie("MEM_INFO","USER_ID");
	String login_auth  = cb.GetCookie("MEM_INFO","USER_GROUP");

	String server      = request.getServerName().trim();
	String stype       = ChkNull.chkStr(request.getParameter("stype"));
/*
	if(login_id.equals("") || (!login_auth.equals("1") && !login_auth.equals("2"))){
		out.println("<script>alert('에누리 사원 아이디로 로그인하세요.');</script>");
		return;
	}
*/
	//if((!server.equals("100.100.100.151") && !server.equals("dev.enuri.com")) || ( !server.equals("27.122.133.189") && !server.equals("dev.enuri.com"))){
//		out.println("<script>alert('151에서만 실행하십시오!');</script>");
		//return;
	//}

	String serverIp = "100.100.100.151";

	if(stype.equals("banner")){
		URL topMenuUrl = new URL("http://"+serverIp+"/wide/main/ajax/Ajax_Gnb_Src_2021_main_nw.jsp?stype=banner");
		URLConnection yc = topMenuUrl.openConnection();
		BufferedReader in = new BufferedReader(new InputStreamReader(yc.getInputStream(),"UTF-8"));

		String inputLine;
		String strTotCont = "";

		while ((inputLine = in.readLine()) != null){
		    strTotCont += inputLine+"\r\n";
		}

		in.close();

		//String strTopMenuFileName = "/was/lena/1.3/depot/lena-application/ROOT/common/js/eb/nGnbBanner_data_2018.json";
		String strTopMenuFileName = "/was/lena/1.3/depot/lena-application/ROOT/wide/main/ajax/mainCateBanner_data_2021.json";

		OutputStream topMenuStream = new FileOutputStream(strTopMenuFileName, false);

		topMenuStream.write(strTotCont.getBytes("UTF-8"));
		topMenuStream.flush();
		topMenuStream.close();

		uploadFile("mainCateBanner_data_2021.json","/was/lena/1.3/depot/lena-application/ROOT/wide/main/ajax/");

		out.println("<script>alert('정상반영되었습니다.');</script>");
	}else{
		GNB_List_2021_Proc     GNB_List_Proc       = new GNB_List_2021_Proc();

	    GNB_List_Data[] gnb_list_0     = GNB_List_Proc.getGNB_List(1, 0); //대대분류 목록

	    URL topMenuUrl;
	    URLConnection yc;
	    BufferedReader in;
	    OutputStream topMenuStream;

        String inputLine = "";
        String strTotCont = "";
        String strTopMenuFileName = "";
        int[] g_seq = {1,2,3,4,5,6,7,8,9,10,11};

	    for(int i=0; i<gnb_list_0.length; i++){
			topMenuUrl = new URL("http://"+serverIp+"/wide/main/ajax/Ajax_Gnb_Src_202202_main.jsp?g_seq=" + g_seq[i]);
			yc = topMenuUrl.openConnection();
			in = new BufferedReader(new InputStreamReader(yc.getInputStream(),"UTF-8"));

			inputLine = "";
			strTotCont = "";

			while ((inputLine = in.readLine()) != null){
			    strTotCont += inputLine+"\r\n";
			}

			in.close();

			strTopMenuFileName = "/was/lena/1.3/depot/lena-application/ROOT/wide/main/ajax/main_CateList_2022_" + i + ".html";
			topMenuStream = new FileOutputStream(strTopMenuFileName, false);

			topMenuStream.write(strTotCont.getBytes("UTF-8"));
			topMenuStream.flush();
			topMenuStream.close();

			uploadFile("main_CateList_2022_" + i + ".html","/was/lena/1.3/depot/lena-application/ROOT/wide/main/ajax/");
	    }

        topMenuUrl = new URL("http://"+serverIp+"/wide/main/ajax/Ajax_Gnb_Src_202202_main.jsp?stype=allCate");

        yc = topMenuUrl.openConnection();
        in = new BufferedReader(new InputStreamReader(yc.getInputStream(),"UTF-8"));

        strTotCont = "";

        while ((inputLine = in.readLine()) != null){
            strTotCont += inputLine+"\r\n";
        }

        in.close();

        strTopMenuFileName = "/was/lena/1.3/depot/lena-application/ROOT/wide/main/ajax/AllCateList_2022.html";
        topMenuStream = new FileOutputStream(strTopMenuFileName, false);

        topMenuStream.write(strTotCont.getBytes("UTF-8"));
        topMenuStream.flush();
        topMenuStream.close();

        uploadFile("AllCateList_2022.html","/was/lena/1.3/depot/lena-application/ROOT/wide/main/ajax/");


        //========================================================================================================
        topMenuUrl = new URL("http://"+serverIp+"/common/jsp/Ajax_Gnb_AllMenu_2021.jsp");

        yc = topMenuUrl.openConnection();
        in = new BufferedReader(new InputStreamReader(yc.getInputStream(),"UTF-8"));

        strTotCont = "";

        while ((inputLine = in.readLine()) != null){
            strTotCont += inputLine+"\r\n";
        }

        in.close();

        strTopMenuFileName = "/was/lena/1.3/depot/lena-application/ROOT/wide/main/ajax/TopAllCate_2022.html";
        topMenuStream = new FileOutputStream(strTopMenuFileName, false);

        topMenuStream.write(strTotCont.getBytes("UTF-8"));
        topMenuStream.flush();
        topMenuStream.close();

        uploadFile("TopAllCate_2022.html","/was/lena/1.3/depot/lena-application/ROOT/wide/main/ajax/");
        
        
        //out.println("<script>alert('정상반영되었습니다.');window.open('http://dev.enuri.com/jca/nGNB2/gnbViewAllServer.html');</script>");
        out.println("<script>alert('정상반영되었습니다.')</script>");
	}
%>
<%!
static boolean uploadFile(String strFileName, String uploadDir){
     ArrayList<String> ipList = new ArrayList<String>();

    //ipList.add("100.100.100.151");
  	//ipList.add("100.100.110.151");
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

    //오리진 서버로 미사용 주석 처리 함.
   // ipList.add("100.100.100.61");
   // ipList.add("100.100.100.62");

    int port = 21;
    String ftpId = "lena";
    String ftpPw = "#cloud2021";

    //ftp 전송
    for(int i = 0; i<ipList.size() ;i++){
        try{
	        CommonFtp commonFtp = new CommonFtp((String)ipList.get(i),port,ftpId,ftpPw);
	        commonFtp.login();

	        if(!uploadDir.equals(""))
	            commonFtp.cd(uploadDir);

	        commonFtp.put(strFileName,strFileName,uploadDir);
	        System.out.println("gnb:"+(String)ipList.get(i)+"   "+strFileName+" 전송 완료");

	        commonFtp.disconnect();
        } catch(Exception e){
            System.out.println((String)ipList.get(i)+" 전송 실패");
        }finally{

        }
    }

    return true;
}

static boolean uploadFile(String strFileName){
    return uploadFile(strFileName,"");
}
%>