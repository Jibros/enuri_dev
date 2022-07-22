<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*,java.text.*,java.net.*"%>
<%@ page import="com.enuri.util.http.*"%>
<%@ page import="com.enuri.bean.mobile.depart.Save_Goods_Proc"%>
<%@ page import="com.enuri.bean.mobile.depart.Save_Goods_Data"%>
<%@ page import="com.enuri.util.common.*"%>
<%
	CookieBean cb = null;
	cb = new CookieBean( request.getCookies());
	String strMemberId = cb.GetCookie("MEM_INFO","USER_ID");
	String strTempId = cb.GetCookie("MYINFO","TMP_ID");	
	
	//안드로이드 쿠키 들어올때 길이 이상
	if(strMemberId.indexOf("?") > -1){
		strMemberId = strMemberId.replaceAll("?","");
	}
	
	//이상한 아이디 추출
	if(strMemberId.length() > 20){
		System.out.println("userid Error - insertSaveGoodsProc.jsp - 메세지보시면 woosh 알려주세요. >>>>"+strMemberId+"=====");
		System.out.println("userid Error - insertSaveGoodsProc.jsp - 쿠키쑈  >>>>"+cb.ShowCookie()+"=====");	
		//이부분이 추가됩니다.
        Cookie cookies[]= request.getCookies();

        StringBuilder sb = new StringBuilder();
        for(int i = 0; i < cookies.length; i++){
            String name = URLDecoder.decode(cookies[i].getName(), "UTF-8");
            String value = cookies[i].getValue();
            sb.append(name);
            sb.append("=");
            sb.append(value);
            sb.append("&");
        }
        System.out.println("userid Error - insertSaveGoodsProc.jsp - native cookies  >>>>"+sb.toString()+"=====");
/////여기까지

	}
	if(strTempId.length() > 20){
		System.out.println("userid Error - insertSaveGoodsProc.jsp - 메세지보시면 woosh 알려주세요. >>>>"+strTempId+"=====");	
	}
	
	String strModelNos = ChkNull.chkStr(request.getParameter("modelnos"),"");
	String strLoginType = ChkNull.chkStr(request.getParameter("logintype"),"");
	//System.out.println("strModelNos="+strModelNos);
	Save_Goods_Proc save_goods_proc = new Save_Goods_Proc();
	/*
	기존 로직 다 없어지고 로그인후 찜저장만 남음.
	*/
	if (strModelNos.trim().length() == 0 ){
		/*
		최근본 상품에서 저장상품으로 이동은 
		1. 최근본 상품에서 데이타 조회
		2. 최근본 상품이 기존 저장상품에 등록되어 있는지 확인
		3. 등록되어 있으면 등록일 수정
		4. 등록되어 있지 않으면 등록
		5. 가격목록의 MEMBER ID 업데이트
		6. 최저가 가격목록의 MEMBER ID 업데이트
		*/		
		if (strMemberId != null && strMemberId.trim().length() > 0 && strTempId.trim().length() > 0 && strMemberId.trim().length() < 21){
			if (strLoginType.trim().equals("today")){
				save_goods_proc.insertMemberSaveGoodsFromTodaySaveGoods(strTempId,strMemberId);	
			}else{
				save_goods_proc.insertMemberSaveGoodsFromTempSaveGoods(strTempId,strMemberId);	
			}
		}
	}else{
		String astrModelNos[] = strModelNos.split(",");
		int intCount = 0;
			for (int i=0;i<astrModelNos.length;i++){
				if (astrModelNos[i].length() > 0 ){
					Save_Goods_Data saveGoodsData = new Save_Goods_Data();
					String tempModelno = astrModelNos[i];
					int intTempModelno = 0;
					long lngTempPlno = 0;
					String strTempMkspModelno = "0";
					
					if(tempModelno.indexOf("G:")>-1 || (tempModelno.indexOf("G:")<0 && tempModelno.indexOf("P:")<0)) {
						tempModelno = tempModelno.replace("G:", "");

						try {
							intTempModelno = Integer.parseInt(tempModelno);
						} catch(Exception e) {}
						saveGoodsData.setIntModelNo(intTempModelno);
					}

					if(tempModelno.indexOf("P:")>-1) {
						tempModelno = tempModelno.replace("P:", "");

						try {
							lngTempPlno = Long.parseLong(tempModelno);
						} catch(Exception e) {}

						saveGoodsData.setPl_no(lngTempPlno);
					}
					
					saveGoodsData.setMksp_model_no("0");
					if(tempModelno.indexOf("M:")>-1) {
						tempModelno = tempModelno.replace("M:", "");

						try {
							strTempMkspModelno = tempModelno;
						} catch(Exception e) {}

						saveGoodsData.setMksp_model_no(strTempMkspModelno);
					}
					
					if (strMemberId != null && strMemberId.trim().length() > 0  && strMemberId.trim().length() < 21){
						saveGoodsData.setStrId(strMemberId);
						int intReturn = save_goods_proc.insertMobileSaveGoods(saveGoodsData,"MEMBER");
						if (intReturn >= 0){
							intCount = intCount + intReturn;
						}else{
							intCount = -1;	
							break;
						}
						if(tempModelno.indexOf("M:") < 0) {
							save_goods_proc.updateMemberIdSavePriceList(strMemberId,strTempId,intTempModelno,lngTempPlno);
							save_goods_proc.updateMemberIdResellSavePriceList(strMemberId,strTempId,intTempModelno);
						}
					}else{ 
						saveGoodsData.setStrId(strTempId);
						int intReturn = save_goods_proc.insertSaveGoods(saveGoodsData,"TEMP");					
						if (intReturn >= 0){
							intCount = intCount + intReturn;
						}else{
							intCount = -1;	
							break;
						}					
					}
				}
			}
		//}
		//System.out.println("intCount="+intCount);
		out.println("{");
		out.println("\"count\": \"" + intCount + "\"");
		out.println("}");
	}
%>