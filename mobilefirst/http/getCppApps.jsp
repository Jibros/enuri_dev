<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%>
<%@page import="java.net.*"%>
<jsp:useBean id="ChkNull" class="com.enuri.util.common.ChkNull"
	scope="page" />
<%
String targetServer = "dev";
	JSONObject makeJson = new JSONObject();
	try {
		String strGcate = ChkNull.chkStr(request.getParameter("gcate"), "1"); //  CPP카테고리

		String pages[] = {

		"httparray", "0", "mainBanner", 
		//"http://ad-api.enuri.info/enuri_M/m_main/M1/bundle?bundlenum=11",
		"http://localhost/mobilenew/gnb/category/mainBanner.json",
		//"http://adsvc.enuri.mcrony.com/enuri_M/m_main/M1/bundle?bundlenum=11",
	
		"httpobject", "0","getPlan", "http://localhost/mobilefirst/ajax/cppAjax/getPlan.jsp?gcate=" + strGcate,
				//이건 데브를 봐야지만 됨 (노)

				"httpobject", "0", "getShoppingGuide", "http://localhost/mobilefirst/ajax/cppAjax/getShoppingGuide.jsp?gcate=" + strGcate, 
				"httpobject", "0", "getSocial","http://localhost/mobilefirst/ajax/cppAjax/getSocial.jsp?gcate=" + strGcate,
				
				"httpobject", "0", "cppHeadCate","http://localhost/mobilefirst/api/cppHeadCate.json",
				

				//	"httpobject", "0", "cppJSon", 		"http://localhost/mobilefirst/http/json/cppJson"+strGcate+".json", 
				"httpobject", "0", "banner_list", "http://localhost/mobilefirst/http/json/banner_list.json"

		};
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		String dates = formatter.format(new Date());

		makeJson.put("time", dates);

		for (int i = 0; i < pages.length; i += 4) {
			try {
				if (pages[i].equals("httpobject")) {
					JSONObject obj;
					obj = getJSONObjectfromHttp(pages[i + 3]);
					if (obj != null)
						makeJson.put(pages[i + 2], obj);
				} else if (pages[i].equals("httparray")) {
					JSONArray obj;
					obj = getJSONArrayfromHttp(pages[i + 3]);
					if (obj != null)
						makeJson.put(pages[i + 2], obj);
				}
			} catch (Exception e) {
				makeJson.put("exception ", e.toString());
			}
		}
		{
			
			
			try{		
				JSONObject obj;
				int cate =Integer.parseInt(strGcate); 
				if(cate <= 4)
					obj = getJSONObjectfromHttp("http://localhost/mobilefirst/ajax/cppAjax/getNews.jsp?gcate=" + strGcate);
				else
					obj = getJSONObjectfromHttp("http://localhost/mobilefirst/ajax/listAjax/getNews2.jsp?gcate=" + strGcate);
				if(obj != null)
					makeJson.put("getNews", obj);
				
			}catch(Exception e)
			{
				makeJson.put("getNewsexception", e.toString());
			}
			try {
				JSONObject obj;
				obj = getJSONObjectfromHttp("http://localhost/mobilefirst/http/json/cppJson" + strGcate + ".json");
				JSONArray arr = (JSONArray) obj.get("cppList");

				if (arr != null) {
					for (int i = 0; i < arr.size() && i < 50; i++) {
						int random = new Random().nextInt(arr.size());
						JSONObject cell = (JSONObject) arr.get(i);
						arr.set(i, arr.get(random));
						arr.set(random, cell);

					}
					
					JSONArray sendarr = new JSONArray();
					for(int i = 0 ; i < 50 && i<arr.size() ; i ++)
						sendarr.add(arr.get(i));
					
					JSONObject putobj = new JSONObject();
					putobj.put("cppList", sendarr);
					makeJson.put("cppJSon", putobj);
				}

			} catch (Exception e) {
				makeJson.put("exception ", e.toString());
			}
		}

	} catch (Exception e) {
		makeJson.put("exception ", e.toString());
	}

	if (makeJson != null)
		out.println(makeJson.toString());
%>

<%!public JSONObject getJSONObjectfromHttp(String strurl) {
		try {
			String recv;
			StringBuffer recvbuff = new StringBuffer();
			URL jsonpage = new URL(strurl);
			URLConnection urlcon = jsonpage.openConnection();
			BufferedReader buffread = new BufferedReader(new InputStreamReader(urlcon.getInputStream(), "utf-8"));
			while ((recv = buffread.readLine()) != null)
				recvbuff.append(recv);
			buffread.close();

			JSONParser parser = new JSONParser();
			Object obj = parser.parse(recvbuff.toString());
			return (JSONObject) obj;
		} catch (Exception e) {

		}
		return null;
	}

	public JSONArray getJSONArrayfromHttp(String strurl) {
		try {
			String recv;
			StringBuffer recvbuff = new StringBuffer();
			URL jsonpage = new URL(strurl);
			URLConnection urlcon = jsonpage.openConnection();
			BufferedReader buffread = new BufferedReader(new InputStreamReader(urlcon.getInputStream(), "utf-8"));
			while ((recv = buffread.readLine()) != null)
				recvbuff.append(recv);
			buffread.close();

			JSONParser parser = new JSONParser();
			Object obj = parser.parse(recvbuff.toString());
			return (JSONArray) obj;
		} catch (Exception e) {

		}
		return null;
	}%>
