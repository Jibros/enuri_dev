<%@ page contentType="text/html; charset=utf-8"%>

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
	String targetServer = "m";
	JSONObject makeJson = new JSONObject();
	try {
		String strGcate = ChkNull.chkStr(request.getParameter("gcate"), "0"); //  CPP카테고리
		//ios 3.3.9에서 gcate안쓰고 cate 쓰는 경우 있음
		if(strGcate.equals("0"))
				strGcate = ChkNull.chkStr(request.getParameter("cate"), "0"); //  CPP카테고리

		String tempStrGcate = strGcate.equals("9") ? "7" : strGcate;
		String pages[] = {

				"httparray",
				"0",
				"mainBanner",
				//"http://ad-api.enuri.info/enuri_M/m_main/M1/bundle?bundlenum=11",
				"http://localhost/mobilenew/gnb/category/mainBanner.json",
				

				"httpobject",
				"0",
				"getPlan",
				"http://localhost/mobilefirst/ajax/cppAjax2/getPlan_2018.jsp?gcate=" + tempStrGcate,
				//이건 데브를 봐야지만 됨 (노)

				"httpobject",
				"0",
				"getShoppingGuide",
				"http://localhost/mobilefirst/ajax/cppAjax2/getShoppingGuide_2018.jsp?gcate="
						+ tempStrGcate,
				/* "httpobject",
				"0",
				"getSocial",
				"http://localhost/mobilefirst/ajax/cppAjax2/getSocial_2018.jsp?gcate=1"
						+ strGcate, */

				"httpobject", "0", "cppHeadCate",
				"http://localhost/mobilefirst/api/cppHeadCate_2018.json",

				//	"httpobject", "0", "cppJSon", 		"http://"+targetServer+".enuri.com/mobilefirst/http/json/cppJson"+strGcate+".json", 
				"httpobject", "0", "banner_list",
				"http://localhost/mobilefirst/http/json/banner_list.json"

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
				makeJson.put("exception1 ", e.toString());
			}
		}
		
		if(strGcate.equals("1"))
			makeJson.put("mallree_mall_show", true);
		else 
			makeJson.put("mallree_mall_show", false);
		try{
			JSONObject obj = new JSONObject();
			obj.put("title","해외직구 가격비교");
			obj.put("link","http://"+targetServer+".enuri.com/global/m/Index.jsp?freetoken=global");
			makeJson.put("mallree_mall_header",obj);
			makeJson.put("mallree_mall_list",getJSONArrayfromHttp("http://localhost/global/ajax/getGlobalPopShop_ajax.jsp?view_pst_cd=C"));
			//makeJson.put("mallree_mall_bridge","http://"+targetServer+".enuri.com/global/m/portal.jsp");
			makeJson.put("mallree_mall_bridge","http://"+targetServer+".enuri.com/global/m/mvp.jsp?freetoken=global");
			makeJson.put("mallree_goods",getJSONArrayfromHttp("http://localhost/global/ajax/getDetailShoplist_ajax.json"));
															  
		}catch(Exception e){
			
		}
		
	

		{

			try{
				makeJson.put("KNOWSHOPPING_URL", "http://" + targetServer + ".enuri.com/knowcom/detail.jsp?");
				makeJson.put("CPPPLAN_URL", "http://" + targetServer + ".enuri.com/mobilefirst/planlist.jsp?");
				makeJson.put("CPPPLAN_IMAGE_URL", "http://img.enuri.info/images/mobilefirst/planlist/");
			}catch(Exception e)
			{
				
			}
			try {
				if (strGcate.equals("1")) {
					JSONArray arr1 = new JSONArray();
					arr1.add("cpp_header_1_2");
					arr1.add("cpp_header_1_1");
					arr1.add("cpp_header_1_3");
					makeJson.put("ICONS", arr1);
				} else if (strGcate.equals("2")) {
					JSONArray arr2 = new JSONArray();
					arr2.add("cpp_header_2_1");					
					makeJson.put("ICONS", arr2);
				} else if (strGcate.equals("3")) {
					JSONArray arr3 = new JSONArray();
					arr3.add("cpp_header_3_1");
					arr3.add("cpp_header_3_2");
					makeJson.put("ICONS", arr3);
				} else if (strGcate.equals("4")) {
					JSONArray arr4 = new JSONArray();
					arr4.add("cpp_header_4_1");
					arr4.add("cpp_header_4_2");//추가
					makeJson.put("ICONS", arr4);
				} else if (strGcate.equals("5")) {
					JSONArray arr5 = new JSONArray();
					arr5.add("cpp_header_5_1");
					arr5.add("cpp_header_5_2");
					makeJson.put("ICONS", arr5);
				} else if (strGcate.equals("6")) {
					JSONArray arr6 = new JSONArray();
					arr6.add("cpp_header_6_2");
					arr6.add("cpp_header_6_1");
					arr6.add("cpp_header_6_3");
					makeJson.put("ICONS", arr6);
				} else if (strGcate.equals("7")) {
					JSONArray arr7 = new JSONArray();
					arr7.add("cpp_header_7_1");
					arr7.add("cpp_header_7_3");
					arr7.add("cpp_header_7_22");
					makeJson.put("ICONS", arr7);
				} else if (strGcate.equals("8")) {
					JSONArray arr8 = new JSONArray();
					arr8.add("cpp_header_8_25");
					arr8.add("cpp_header_8_1");
					arr8.add("cpp_header_8_2");					
					makeJson.put("ICONS", arr8);
				} else if (strGcate.equals("9")) {
					JSONArray arr9 = new JSONArray();
					makeJson.put("ICONS", arr9);
				} else {
					makeJson.put("exception ", "icon index out of range exceptions =>" + strGcate);
				}
				makeJson.put("ICONS_URL", "http://img.enuri.info/images/mobilefirst/cpp/");

			} catch (Exception e) {
				makeJson.put("exception icon ", e.toString());
			}

			try {
				JSONObject obj;
				/* int cate = Integer.parseInt(strGcate);
				if (cate <= 4)
					obj = getJSONObjectfromHttp("http://" + targetServer
							+ ".enuri.com/mobilefirst/ajax/cppAjax/getNews.jsp?gcate=" + strGcate);
				else
					obj = getJSONObjectfromHttp("http://" + targetServer
							+ ".enuri.com/mobilefirst/ajax/listAjax/getNews2.jsp?gcate=" + strGcate); */
				obj = getJSONObjectfromHttp("http://localhost/mobilefirst/ajax/cppAjax2/getNews_2018.jsp?gcate=" + strGcate);
				if (obj != null)
					makeJson.put("getNews", obj);

			} catch (Exception e) {
				makeJson.put("getNewsexception", e.toString());
			}
			try {
				JSONObject obj;//노병원 과장 담당
				obj = getJSONObjectfromHttp("http://localhost/mobilefirst/http/json/cppJson_2018_" + strGcate + ".json");
				JSONArray arr = (JSONArray) obj.get("cppList");

				if (arr != null) {
					for (int i = 0; i < arr.size() && i < 50; i++) {
						int random = new Random().nextInt(arr.size());
						JSONObject cell = (JSONObject) arr.get(i);
						arr.set(i, arr.get(random));
						arr.set(random, cell);

					}

					JSONArray sendarr = new JSONArray();
					for (int i = 0; i < 50 && i < arr.size(); i++)
						sendarr.add(arr.get(i));

					JSONObject putobj = new JSONObject();
					putobj.put("cppList", sendarr);
					makeJson.put("cppJSon", putobj);
				}

			} catch (Exception e) {
				makeJson.put("exception2 ", e.toString());
			}
		}
		
		

	} catch (Exception e) {
		makeJson.put("exception 3", e.toString());
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
