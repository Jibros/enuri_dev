<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>
<%@ page import="com.enuri.bean.wide.Lp_Header_Proc"%>
<%@ page import="org.json.simple.*"%>
<%
	/** Parameter Sets */
	// 카테고리
	String strCate = ConfigManager.RequestStr(request, "category", "");
	int intSeqNo = ChkNull.chkInt(request.getParameter("seqno"), 0);
	String strSeqFlag = ChkNull.chkStr(request.getParameter("seqflag"), ""); //depth1Sel, detph2Sel, ""
 	
	/** // Parameter Sets */
	
	/** Parameter Validation Check */
	boolean blParam = true;
	JsonResponse ret = null;
	if(strCate.length()==0 && intSeqNo == 0 ) {
		blParam = false;
	}
	if(!blParam) {
		ret = new JsonResponse(false).setCode(10).setParam(request);
		out.print(ret);
		return;
	}
	/** // Parameter Validation Check */
	
	JSONObject depth1Obj = new JSONObject();
	JSONObject depth2Obj = new JSONObject();
	JSONObject depth3Obj = new JSONObject();
	JSONObject depth4Obj = new JSONObject();
	String depth3CateNm = new String();
	String depth4CateNm = new String();
	String depth5CateNm = new String();
	JSONObject totalObj = new JSONObject();
	
	Lp_Header_Proc lp_header_proc = new Lp_Header_Proc();
	
	boolean blGNBCheck = false;
	int intGNBLevel = 0;
	int intParent  = 0;
	
	if(strCate.length() > 0){ //카테이동시
		blGNBCheck = lp_header_proc.gnbCateChk(strCate);
		if(blGNBCheck){
			intGNBLevel = lp_header_proc.getGNBLevel(strCate, true);
			intSeqNo = lp_header_proc.getGNBSeq(strCate, true);
		}else{
			intGNBLevel = lp_header_proc.getGNBLevel("/list.jsp?cate="+strCate, false);
			intSeqNo = lp_header_proc.getGNBSeq("/list.jsp?cate="+strCate, false);
		}
		if(intSeqNo > 0){ //GNB 카테
			if(intGNBLevel == 2){
				depth3Obj = lp_header_proc.getGNBCateList(intSeqNo, "depth2Sel");
				depth2Obj =  lp_header_proc.getGNBCateList(intSeqNo, strSeqFlag);
				intParent = lp_header_proc.getGNBParent(intSeqNo);
				depth1Obj = lp_header_proc.getGNBCateList(intParent, strSeqFlag);
			}else if(intGNBLevel == 3){
				depth3Obj = lp_header_proc.getGNBCateList(intSeqNo, strSeqFlag);
				intParent = lp_header_proc.getGNBParent(intSeqNo);
				depth2Obj = lp_header_proc.getGNBCateList(intParent, strSeqFlag);
				intParent = lp_header_proc.getGNBParent(intParent);
				depth1Obj = lp_header_proc.getGNBCateList(intParent, strSeqFlag);
			}else if(intGNBLevel == 4){
				depth4CateNm = lp_header_proc.getGNBDepth4CateNm(strCate, true);
				intParent = lp_header_proc.getGNBParent(intSeqNo);
				depth3Obj = lp_header_proc.getGNBCateList( intParent, strSeqFlag);
				intParent = lp_header_proc.getGNBParent(intParent);
				depth2Obj = lp_header_proc.getGNBCateList(intParent, strSeqFlag);
				intParent = lp_header_proc.getGNBParent(intParent);
				depth1Obj = lp_header_proc.getGNBCateList(intParent, strSeqFlag);
			}
			totalObj.put("depth1", depth1Obj);
			totalObj.put("depth2", depth2Obj);
			totalObj.put("depth3", depth3Obj);
			totalObj.put("depth4CateNm", depth4CateNm);
		}else{ //원카테
			String strTempCate = "";
			if(strCate.length() > 4){
				strTempCate = strCate.substring(0,4);
				blGNBCheck = lp_header_proc.gnbCateChk(strTempCate);
				if(blGNBCheck){
					intGNBLevel = lp_header_proc.getGNBLevel(strTempCate, true);
					intSeqNo = lp_header_proc.getGNBSeq(strTempCate, true);
				}else{
					intGNBLevel = lp_header_proc.getGNBLevel("/list.jsp?cate="+strTempCate, false);
					intSeqNo = lp_header_proc.getGNBSeq("/list.jsp?cate="+strTempCate, false);
				}
			}
			if(intSeqNo > 0){ //4자리로 잘랐을 때 GNB카테가 있을 경우
				if(intGNBLevel == 2){
					if(strCate.length() >= 8) depth4CateNm = lp_header_proc.getOrgCateNm(strCate.substring(0,8));
					if(strCate.length() >= 6) depth3CateNm = lp_header_proc.getOrgCateNm(strCate.substring(0,6));
					depth2Obj =  lp_header_proc.getGNBCateList(intSeqNo, strSeqFlag);
					intParent = lp_header_proc.getGNBParent(intSeqNo);
					depth1Obj = lp_header_proc.getGNBCateList(intParent, strSeqFlag);
					totalObj.put("depth1", depth1Obj);
					totalObj.put("depth2", depth2Obj);
					totalObj.put("depth3CateNm", depth3CateNm);
					totalObj.put("depth4CateNm", depth4CateNm);
				}else if(intGNBLevel == 3){
					String strTempCateLength6 = "";
					int intTempCateLength6SeqNo = 0;
					if(strCate.length() > 6){
						strTempCateLength6 = strCate.substring(0,6);
						blGNBCheck = lp_header_proc.gnbCateChk(strTempCateLength6);
						if(blGNBCheck){ //6자리가 GNB카테일 때
							intTempCateLength6SeqNo = lp_header_proc.getGNBSeq(strTempCateLength6, true);
							depth5CateNm = lp_header_proc.getOrgCateNm(strCate);
							depth4Obj = lp_header_proc.getGNBCateList(intTempCateLength6SeqNo, strSeqFlag);
						}else{
							depth5CateNm = lp_header_proc.getOrgCateNm(strCate);
							depth4Obj = lp_header_proc.getOrgCateList(strCate);
						}
					}else if(strCate.length() == 6){
						depth4Obj = lp_header_proc.getOrgCateList(strCate);
					}
					depth3Obj = lp_header_proc.getGNBCateList(intSeqNo, strSeqFlag);
					intParent = lp_header_proc.getGNBParent(intSeqNo);
					depth2Obj = lp_header_proc.getGNBCateList(intParent, strSeqFlag);
					intParent = lp_header_proc.getGNBParent(intParent);
					depth1Obj = lp_header_proc.getGNBCateList(intParent, strSeqFlag);
					totalObj.put("depth1", depth1Obj);
					totalObj.put("depth2", depth2Obj);
					totalObj.put("depth3", depth3Obj);
					totalObj.put("depth4", depth4Obj);
					totalObj.put("depth5CateNm", depth5CateNm);
				} else if (intGNBLevel == 4){
					totalObj = lp_header_proc.getNavCateList(strCate); //원카테
				}
			}else{
				totalObj = lp_header_proc.getNavCateList(strCate); //원카테
			}
		}
	}else{ //단순 nav 이동
		if(strSeqFlag.equals("depth2Sel")){
			depth3Obj = lp_header_proc.getGNBCateList(intSeqNo, strSeqFlag);
			depth2Obj = lp_header_proc.getGNBCateList( intSeqNo, "");
			intParent = lp_header_proc.getGNBParent(intSeqNo);
			depth1Obj = lp_header_proc.getGNBCateList(intParent, "");
		}else if(strSeqFlag.equals("depth1Sel")){
			depth2Obj = lp_header_proc.getGNBCateList(intSeqNo, strSeqFlag);
			depth1Obj = lp_header_proc.getGNBCateList(intSeqNo, "");
		}
		totalObj.put("depth1", depth1Obj);
		totalObj.put("depth2", depth2Obj);
		totalObj.put("depth3", depth3Obj);
		//totalObj.put("depth4CateNm", depth4CateNm);
	}
	ret = new JsonResponse(true).setData(totalObj);
	out.print ( ret );
%>