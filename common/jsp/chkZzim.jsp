<%@page import="com.enuri.bean.main.brandplacement.DBDataTable"%>
<%@page import="com.enuri.bean.main.brandplacement.DBWrap"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="com.enuri.bean.main.Goods_Data"%>
<%@page import="com.enuri.bean.main.Save_Goods_Proc"%>
<%@page import="com.enuri.util.http.CookieBean"%>
<%
try{
	String outprint = "";
	CookieBean cb = null;		
	cb = new CookieBean(request.getCookies());
    Save_Goods_Proc save_goods_proc = new Save_Goods_Proc();		    
    if(cb.GetCookie("MEM_INFO","USER_ID").equals("") == false ){		    	
        String strUserId2 = cb.GetCookie("MEM_INFO","USER_ID");
        
     	
     	String modelno = ChkNull.chkStr(request.getParameter("modelno"), "");
     	String pl_no = ChkNull.chkStr(request.getParameter("pl_no"), "");
     	
     // 모델 있음.
        if (modelno.equals("") == false){
        	Goods_Data[] goods_save_data = save_goods_proc.getSaveGoodList(strUserId2,"MEMBER");//저장상품 (로그인)
        	if(goods_save_data!=null){			
                for(int j=0;j<goods_save_data.length;j++){            	
                    if(modelno.equals(String.valueOf(goods_save_data[j].getModelno()).trim())){                	
                    	outprint = "true";
                    }
                }
            }       	
        	
        	if (outprint.equals("")){
        		outprint = "false";
        	}
        }        
        // 모델 없음
        if (pl_no.equals("") == false){
        	String nomodelquery = "select pl_no from TBL_MEMBER_SAVE_GOODS where MEMBER_ID = ? and modelno=0 and pl_no = ? ";
            DBDataTable dt = new DBWrap("main2004").setQuery(nomodelquery).addParameter(strUserId2).addParameter(pl_no).selectAllTry();
            
        	if (dt != null){
        		for (int i=0;i<dt.count();i++){
        			if (pl_no.equals(dt.parse(i, "PL_NO", ""))){
        				outprint = "true";
        			}
        		}				
        	}
        	if (outprint.equals("")){
        		outprint = "false";
        	}
        }
        
        out.print(outprint);
    }
}catch(Exception ex){
	out.print("false");
}
%>
