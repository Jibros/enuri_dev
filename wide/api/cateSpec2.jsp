<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="org.json.JSONException"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Search_Lsv_Proc"%>
<%@ page import="com.enuri.bean.main.Spec_Group_Data"%>
<%@ page import="com.enuri.bean.main.Spec_Group_Proc2"%>
<%
	//deviceType=P : PC
	//deviceType=M : 모바일
	String deviceType = ChkNull.chkStr(request.getParameter("deviceType"), "P");
	String strCate = ChkNull.chkStr(request.getParameter("cate"), "");
	String strGCate = ChkNull.chkStr(request.getParameter("gCate"), "");
	String serverName = request.getServerName();
	String strDevFlag = ChkNull.chkStr(request.getParameter("devFlag"), "N"); // Y이면 테스트
	boolean devFlag = false;
	if(strDevFlag.equals("Y")){
		devFlag = true;
	}
		
	String strCate4 = "";
	String strCate6 = "";
	String strCate8 = "";
	String[] strCateAry = strCate.split(",");
	
	if(strCateAry!=null && strCateAry.length>0) {
		for(int i=0; i<strCateAry.length; i++) {
			if(strCateAry[i].length()==4) {
				if(strCate4.length()>0) strCate4 += ",";
				strCate4 += strCateAry[i];
			}
			if(strCateAry[i].length()==6) {
				if(strCate6.length()>0) strCate6 += ",";
				strCate6 += strCateAry[i];
			}
			if(strCateAry[i].length()==8) {
				if(strCate8.length()>0) strCate8 += ",";
				strCate8 += strCateAry[i];
			}
		}
	}
	
	String outJson = "";
	Map<String, Object> tmpMapArray = new JsonMap<String, Object>();
	Map<String, String> tmpMapString = new JsonMap<String, String>();
	
	if(strCate4.length()>0 || strCate6.length()>0 || strCate8.length()>0 ) {
		
		boolean customSpec = true;
		Spec_Group_Proc2 spec_group_proc = new Spec_Group_Proc2();
		Spec_Group_Data[] spec_group_data = spec_group_proc.getCateSpecGroupMenu(strCate,devFlag);
		
		if(spec_group_data.length==0){
			
			// 미분류 일때 진입 카테고리 정보만 가져온다. 
			if(strGCate.length()==8) {
				strCate8 = strGCate;
			}
			
			spec_group_data =  spec_group_proc.getNewSpecGroupMenu(strCate4, strCate6, strCate8, deviceType, devFlag);	
			
			customSpec = false;
		}
		if(spec_group_data!=null && spec_group_data.length>0) {
			boolean bAllDel = true;
			for(int i=0; i<spec_group_data.length; i++) {
				String StrSpecGroupDelFlag = spec_group_data[i].getStrSpecGroupDelFlag();
				if(!StrSpecGroupDelFlag.equals("9")){
					bAllDel = false;
				}
			}
			if (bAllDel){
				return;
			}
			
			List<JSONObject> tmpListJson = new ArrayList<JSONObject>();
			JSONObject tmpJson = new JSONObject();
			List<JSONObject> tmpMenuArray = new ArrayList<JSONObject>();
			JSONObject tmpMenuJson = new JSONObject();
			
			String strPreGroupName = "";
			int itemCnt = 0;
			int intOldGpNo = 0;
			String strImgViewYN = "N";
			for(int i=0; i<spec_group_data.length; i++) {
				boolean IsItemTitle = false;
				int intSpecNo = spec_group_data[i].getIntSpecNo();
				String strSpecNo = spec_group_data[i].getStrSpecNo();
				int intGpno = spec_group_data[i].getIntGpno();
				int intGpsno = spec_group_data[i].getIntGpsno();
				String strSpecType  = spec_group_data[i].getStrSpecType();
				String strGpNoAoflag = spec_group_data[i].getStrSpecCateAoflag();
				String StrSpecGroupDelFlag = spec_group_data[i].getStrSpecGroupDelFlag();
				String strGpsNoAoflag = spec_group_data[i].getStrSpecCateDetailAoflag();
				String strSpecCateTitle = spec_group_data[i].getStrSpecCateTitle();
				String strGroupName = spec_group_data[i].getStrGroupName();
				String strSpecGroupTitle = spec_group_data[i].getStrSpecGroupTitle();
				int intKbNo = spec_group_data[i].getIntKbNo(); // 용어사전 번호
				int intCateKbNo = spec_group_data[i].getIntCateKbNo(); // 제목 용어사전 번호
				String strIconType = spec_group_data[i].getStrIconType();
				String strGIconType = spec_group_data[i].getStrGIconType();
				String strImageIconYN = spec_group_data[i].getStrImageIconYN();
				
				// strSpecGroupTitle=blank 는 무시
				// StrSpecGroupDelFlag=9 는 하위 분류
				// json은 각 그룹별로 출력하되 하위 분류의 제목만 구분을 함
				if(strSpecGroupTitle.equals("blank")) continue;

				if(StrSpecGroupDelFlag.equals("9")) IsItemTitle = true;
				
				// 새로운 분류 시작
				if(itemCnt>0) {
					tmpJson.put("specMenuList", tmpMenuArray);
					if(i>0 && (!strPreGroupName.equals(strSpecCateTitle) || IsItemTitle)) {
						tmpMenuArray = new ArrayList<JSONObject>();
						tmpJson.put("strImgViewYN", strImgViewYN);
						strImgViewYN = "N";
						// 다른 리스트 시작
						tmpListJson.add(tmpJson);
						tmpJson = new JSONObject();
					}
				}
				

				if(!strPreGroupName.equals(strSpecCateTitle) || IsItemTitle) {
					String showSpecCateTitle = toJS2(strSpecCateTitle);
					String strSubTitle = "";
					
					if(IsItemTitle) {
						strSubTitle = toJS2(strSpecGroupTitle);
					}

					tmpJson.put("strSpecCateTitle", showSpecCateTitle);
					tmpJson.put("strSubTitle", strSubTitle);
					tmpJson.put("strCateKbNo", String.valueOf(intCateKbNo) );
					tmpJson.put("strGpno", String.valueOf(intGpno) );
					tmpJson.put("strGIconType", strGIconType);
					
					itemCnt = 0;
				}

				strPreGroupName = strSpecCateTitle;

				if(IsItemTitle) {
					continue;
				} else {
					tmpMenuJson = new JSONObject();
					if(IsItemTitle) {
						tmpMenuJson.put("strIsItemTitleYN", "Y");
					} else {
						tmpMenuJson.put("strIsItemTitleYN", "N");
					}
					
					String strTmpSpecNo = (customSpec) ? strSpecNo : String.valueOf(intSpecNo);

					tmpMenuJson.put("strSpecNo", strTmpSpecNo);
					tmpMenuJson.put("strGpsno", String.valueOf(intGpsno));
					tmpMenuJson.put("strSpecno", String.valueOf(intGpsno));
					tmpMenuJson.put("strKbNo", String.valueOf(intKbNo));
					tmpMenuJson.put("strGpNoAoflag", strGpNoAoflag);
					tmpMenuJson.put("StrSpecGroupDelFlag", StrSpecGroupDelFlag);
					tmpMenuJson.put("strGpsNoAoflag", strGpsNoAoflag);
					tmpMenuJson.put("strGroupName", strGroupName);
					tmpMenuJson.put("strSpecGroupTitle", strSpecGroupTitle);
					tmpMenuJson.put("strIconType", strIconType);
					tmpMenuJson.put("strSpecType",String.valueOf(strSpecType));

					if(strImageIconYN.equals("Y")) {
						tmpMenuJson.put("strIconImage_on","http://img.enuri.info/images/finder/icon/icon_"+strTmpSpecNo+"_on.png");
						tmpMenuJson.put("strIconImage_off","http://img.enuri.info/images/finder/icon/icon_"+strTmpSpecNo+"_off.png");
						strImgViewYN = "Y";
					} else {
						tmpMenuJson.put("strIconImage_on","");
						tmpMenuJson.put("strIconImage_off","");
					}
					
					if(strTmpSpecNo.equals("9469") || strTmpSpecNo.equals("9471") || strTmpSpecNo.equals("9470") || strTmpSpecNo.equals("9472") 
							|| strTmpSpecNo.equals("9474") || strTmpSpecNo.equals("9475") || strTmpSpecNo.equals("9473")
							|| strTmpSpecNo.equals("19169") || strTmpSpecNo.equals("9479") || strTmpSpecNo.equals("9478") 
							|| strTmpSpecNo.equals("9476") || strTmpSpecNo.equals("9477") || strTmpSpecNo.equals("9480") ) {
						
						switch(strTmpSpecNo) {
						case "9469" : tmpMenuJson.put("rgb", "000000"); break;
						case "9470" : tmpMenuJson.put("rgb", "FFFFFF"); break;
						case "9471" : tmpMenuJson.put("rgb", "90572C"); break;
						case "9472" : tmpMenuJson.put("rgb", "3074FD"); break;
						case "9473" : tmpMenuJson.put("rgb", "E8E095"); break;
						case "9474" : tmpMenuJson.put("rgb", "888888"); break;
						case "9475" : tmpMenuJson.put("rgb", "EC1615"); break;
						case "9476" : tmpMenuJson.put("rgb", "F4AA25"); break;
						case "9477" : tmpMenuJson.put("rgb", "FFD500"); break;
						case "9478" : tmpMenuJson.put("rgb", "37B400"); break;
						case "9479" : tmpMenuJson.put("rgb", "FFC3DC"); break;
						case "9480" : tmpMenuJson.put("rgb", "8316C1"); break;
						case "19169" : tmpMenuJson.put("rgb", "1C2B86"); break;
						}
					}
					
					tmpMenuArray.add(tmpMenuJson);
				}
				itemCnt++;
			}
		
			tmpJson.put("specMenuList", tmpMenuArray);
			tmpJson.put("strImgViewYN", strImgViewYN);
			tmpListJson.add(tmpJson);
			
			List<JSONObject> tmpListJsonCustom = new ArrayList<JSONObject>();
			JSONObject tmpJsonColor = new JSONObject();
			
			// 색상 코드 있을 경우 제외하고 따로 분리
			for( int i=0; i<tmpListJson.size(); i++ ) {
				JSONObject tmpParseRGB = (JSONObject) tmpListJson.get(i);
				String checkRGBKey = tmpParseRGB.get("strGpno")!=null ? (String) tmpParseRGB.get("strGpno") : "";
				if(checkRGBKey.equals("1049")) {
					tmpJsonColor = tmpParseRGB;
				} else {
					tmpListJsonCustom.add(tmpParseRGB);
				}
			}
			
			// 색상
			tmpMapArray.put("specCateColor", tmpJsonColor);
			
			tmpMapArray.put("specCateList", tmpListJsonCustom);
		}
	}
	if(tmpMapString.toString().indexOf("}")>-1 && tmpMapString.size()>0) {
		out.print(tmpMapString.toString().replace("}",","));
		out.print(tmpMapArray.toString().trim().substring(2));
	} else {
		out.print(tmpMapArray.toString().trim());
	}
%>