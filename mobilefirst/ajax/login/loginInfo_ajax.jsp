<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.enuri.util.http.*"%>
<%@ page import="org.json.*"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="com.enuri.util.seed.Seed_Proc"%>
<%@ page import="com.enuri.util.common.ChkNull"%>
<%@page import="com.enuri.bean.member.Sns_Login"%>
<%

//안드로이드 앱에서 사용할려고 만들었습니다.
  	String os = ChkNull.chkStr(request.getParameter("os"),"");
  	if(os!=null && os.equals("and"))
  	{
		String id = ChkNull.chkStr(request.getParameter("id"),"");
	  	if(id.length()>2)
	  	{
		  	//String decoder = URLDecoder.decode("b%2F%2BtufF5riMp4cHOa34JUg%3D%3D",  "UTF-8");
			Seed_Proc seed_proc = new Seed_Proc();
			String result = seed_proc.DePass_Seed(id);
			out.print(result);
		}else
		{
			out.print("");
		}
	}
	else{
		CookieBean cb = null;
		cb = new CookieBean(request.getCookies());

		String loginCheck_strID = cb.GetCookie("MEM_INFO","USER_ID");
		String snsType = ChkNull.chkStr(cb.GetCookie("MEM_INFO","SNSTYPE"));
		if(!loginCheck_strID.equals("")){
			snsType = new Sns_Login().getSnsDcd(loginCheck_strID);
		}
		if( "K".equals(snsType) ||  "N".equals(snsType) ){//sns 계정일 경우 닉네임을 넣어준다
			loginCheck_strID = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_NICK")); //로그인 닉네임
		}

		JSONObject jSONObject = new JSONObject();
		jSONObject.put("id",loginCheck_strID);

		out.println(jSONObject);

	}


%>