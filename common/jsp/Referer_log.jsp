<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URL"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%!	
	public boolean chkRefererFrom(String referer, String page){
		try{
			URL url = new URL(referer);
			String pagename = url.getPath();
			if (pagename.toLowerCase().contains (page.toLowerCase())){
				return true;
			}else{
				return false;
			}
		}catch(Exception ex){
			return false;	
		}
	}

	public String getParamFromStr(String referer, String key, int valmaxlength){		
		try{
			URL url = new URL(referer);
			String query = url.getQuery();			
			for (String queryparam:query.split("&")){
				if (queryparam.contains("=") == false){
					continue;
				}
				
				String[] kvqueryparam = queryparam.split("=");
				if (kvqueryparam.length != 2){
					continue;
				}
				String querykey = kvqueryparam[0];
				String queryval = kvqueryparam[1];
				
				if (key.toLowerCase().equals(querykey.toLowerCase())){
					
					String ret = queryval;
					if (queryval.length() > valmaxlength){
						ret = ret.substring(0,valmaxlength);
					}
					
					return ret;
				}				
			}
			
			return "";
			
		}catch(Exception ex){
			return "";	
		}
	}
%>