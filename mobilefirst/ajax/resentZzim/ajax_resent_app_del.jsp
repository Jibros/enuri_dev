<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="javax.servlet.http.Cookie"%>
<%@page import="org.apache.commons.lang3.*"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
	String modelId = ChkNull.chkStr(request.getParameter("modelId"),"");
	
	//String resentList = cb.getCookie_One("resentList");
	
	String UCode = "UTF-8";
	
	Cookie cookies[] = request.getCookies(); 
	
	ArrayList resentList = new ArrayList(); 
	
	boolean result = false;
	
	if(cookies != null){
		
	    for(int i = 0; i < cookies.length; i++){
	    
	    String name = URLDecoder.decode(cookies[i].getName(), UCode);
	    String value = cookies[i].getValue();
	    
		    if(name.equals("resentList")){
				
				value = StringEscapeUtils.unescapeJava(value);
				
				value = URLDecoder.decode(value, "UTF-8"); 
				
	    		String values[] = StringUtils.split(value,",");
	    		
	    		//out.println(values[0]);
	    		ArrayList<String>  al;
	    		al = new ArrayList<String> (Arrays.asList(values)); 
	    		//al.toArray(values);
	    		
	    		//al.remove(modelId);
	    		
	    		for(int j = 0 ; j < al.size() ; j++ ){
	    			
	    			String temp = StringUtils.replace((String)al.get(j),":","").trim();
	    			
	    			if(temp.equals(modelId)){
	    				al.remove(j);
	    				resentList.addAll(al);
	    				result = true;
	    				break;
	    			}
	    		}
	    		
	    		//System.out.println("value : "+values[0]);		    
		    }
	    }
	    
	}
	
	if(result){
	
		StringBuilder data = new StringBuilder();
			
		for(int i = 0 ; i < resentList.size() ; i ++){
			data.append((String)resentList.get(i));
			data.append(",");
		}
		
		String resentListData = data.toString();
		out.println(resentListData);
		
		StringBuffer url = new StringBuffer();
		url.append(request.getServerName());
		String domain = url.toString();
		
		Cookie cookie = new Cookie("resentList",  URLEncoder.encode(resentListData, UCode));
		cookie.setDomain(domain);
		cookie.setPath("/");
		cookie.setMaxAge(21600);
		response.addCookie(cookie);
		
		out.println("result:Y");
	}else{
		out.println("result:N");
	}
%>
