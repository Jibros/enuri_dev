<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>
<%@ page import="com.enuri.bean.lsv2016.TermDic_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.TermDic_Data"%>
<%@ page import="com.enuri.bean.knowbox.Know_termdic_title_Data"%>
<%@ page import="com.enuri.bean.knowbox.Know_termdic_title_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Know_box_Data"%>
<%@ page import="com.enuri.bean.knowbox.Know_box_Proc"%>
<jsp:useBean id="Know_box_Data" scope="page" class="com.enuri.bean.knowbox.Know_box_Data"/>
<jsp:useBean id="Know_box_Proc" scope="page" class="com.enuri.bean.knowbox.Know_box_Proc"/>
<jsp:useBean id="Know_termdic_title_Data" class="com.enuri.bean.knowbox.Know_termdic_title_Data" scope="page" />
<jsp:useBean id="Know_termdic_title_Proc" class="com.enuri.bean.knowbox.Know_termdic_title_Proc" scope="page" />
<%@ page import="java.util.*,java.text.*,java.net.*"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.log.Log_main_Proc"%>
<%@ page import="com.enuri.bean.log.Log_main_Data"%>
<%@ page import="com.enuri.include.*"%>
<%@ page import="com.enuri.util.etc.*"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.util.image.*"%>
<%@ page import="com.enuri.util.http.*"%>
<%@ page import="com.enuri.util.date.*"%>
<%@ page import="com.enuri.util.common.JsonResponse"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="org.json.JSONObject"%>
<%
//deviceType=1 : PC
//deviceType=2 : 모바일
String deviceType = ConfigManager.RequestStr(request, "deviceType", "1");

String strPageType = ConfigManager.RequestStr(request, "page", "VIP");

// procType=1 : 상품창에서 보여줄 용어사전 리스트를 구해옴
// procType=2 : 지식통 번호를 이용해 용어사전 상세를 읽어옴
// procType=3 : 상품창에서 검색하는 용어사전 리스트
// procType=4 : attribute_id, attribute_element_id 를 이용해서 스펙 번호 읽어오기(LP이동을 위해)
String procType = ConfigManager.RequestStr(request, "procType", "0");


TermDic_Proc termdic_proc = new TermDic_Proc();
JsonResponse ret = null;
JSONObject rtnJSONObject = new JSONObject();


String outJson = "";


//procType=1 : 상품창에서 보여줄 용어사전 리스트를 구해옴
if(procType.equals("1")) {
	String cate = ConfigManager.RequestStr(request, "cate", "");
	int modelno = ChkNull.chkInt(request.getParameter("modelno"), 0);
	int kbno= ChkNull.chkInt(request.getParameter("kbnos"), 0);
	String orderBy = ConfigManager.RequestStr(request, "orderBy", "");

	Goods_Proc goods_proc = new Goods_Proc();
	Goods_Data goods_data = goods_proc.getData_AvailableOne(modelno);
	JSONArray jSONArray = new JSONArray();
	if(goods_data!=null && goods_data.getCa_code().length()>=4) {
		cate = goods_data.getCa_code().substring(0, 4);
	}

	if(cate.length()>0 && modelno>0) {
		TermDic_Data[] termdic_data = termdic_proc.getModelTermDicList(modelno, cate, "",strPageType);
		String kb_nos = "";
		int dicnum = 0;
		String kttdName = "";
		boolean kbnoDic = false; //KNOW_TERMDIC_TITLE 테이블 내용 유무판별
		int dicsortno = 0;
		Know_termdic_title_Data[] kttdAry = null;
		if(kbno>0){
			kb_nos +=kbno;
		}
		if(termdic_data!=null && termdic_data.length>0) {
			for(int j=0; j<termdic_data.length; j++) {
				if(kb_nos.length()>0) kb_nos += ":";
				kb_nos += termdic_data[j].getRef_kb_no();
			}
			if(kb_nos.length()>0) {
				kttdAry = Know_termdic_title_Proc.getData_TermdicTitleKbnos(kb_nos);
			}
			int inum = 0;
		    for(int i=0; i<termdic_data.length;) {
				//out.println(i);
				String name = termdic_data[i].getName();
				int attribute_id = termdic_data[i].getAttribute_id();
				int attribute_element_id = termdic_data[i].getAttribute_element_id();
				int ref_kb_no = termdic_data[i].getRef_kb_no();
				int sortno = termdic_data[i].getSortno();
				
				boolean kbnocheck = false; //KNOW_TERMDIC_TITLE 테이블 내용 유무판별
				//System.out.println(ref_kb_no);
				for(int ti=0; ti<kttdAry.length; ti++) {
					
					if(kttdAry[ti].getRef_kbno()==ref_kb_no){
						kbnocheck = true;
						if(!strPageType.equals("VIP")) name = kttdAry[ti].getKtt_title();
						inum++;
					}
				}
				String strRefKbNo = "";
				for(int k=i;k<termdic_data.length;k++){
					if(attribute_id==termdic_data[k].getAttribute_id() && attribute_element_id==termdic_data[k].getAttribute_element_id()){
						if(strRefKbNo.equals("")){
							strRefKbNo = termdic_data[k].getRef_kb_no()+"";
						}else{
							strRefKbNo += "," + termdic_data[k].getRef_kb_no();
						}
						i++;
						kbnocheck = true;
					}else{
						//i++;
						break;
					}
				}
				if(kbnocheck){
					JSONObject tmpObject = new JSONObject();
					tmpObject.put("name",name);
					tmpObject.put("attribute_id",attribute_id);
					tmpObject.put("attribute_element_id",attribute_element_id);
					tmpObject.put("ref_kb_no",strRefKbNo);
					tmpObject.put("sortno",sortno);
					jSONArray.put(tmpObject);
				}
				dicsortno = sortno;
			}
			for(int ti=0; ti<kttdAry.length; ti++) {
				if(kttdAry[ti].getRef_kbno()==kbno){
					kbnoDic = true;
					kttdName = kttdAry[ti].getKtt_title();
					dicnum=ti;
				}
			}
			if(kbnoDic){
				JSONObject tmpObject = new JSONObject();
				tmpObject.put("name",kttdName);
				tmpObject.put("attribute_id",0);
				tmpObject.put("attribute_element_id",0);
				tmpObject.put("ref_kb_no",kbno);
				tmpObject.put("sortno",++dicsortno);
				jSONArray.put(tmpObject);
			}
			ret = new JsonResponse(true).setData(jSONArray).setTotal(jSONArray.length());
		} else {
 			ret = new JsonResponse(false).setData(jSONArray).setTotal(jSONArray.length());
		}
	}else {
			ret = new JsonResponse(false).setData(jSONArray).setTotal(jSONArray.length());
	}
	out.println(ret.toString());
}

//procType=2 : 지식통 번호를 이용해 용어사전 상세를 읽어옴
if(procType.equals("2")) {
	
	String cate = ConfigManager.RequestStr(request, "cate", "");
	String strModelno = ChkNull.chkStr(request.getParameter("modelno"),"0");
	String strKbnos = ConfigManager.RequestStr(request, "kbnos", "");
	int attribute_id = ChkNull.chkInt(request.getParameter("attribute_id"), 0);
	int attribute_element_id = ChkNull.chkInt(request.getParameter("attribute_element_id"), 0);
	int intModelNo = Integer.parseInt(strModelno);
	
	String[] strKbnosAry = null;
	int[] kbnos = null;
	TermDic_Data termdic_data[] = null;
	if(cate.length() > 4 ){
		cate = cate.substring(0,4);
	}
	/*if(attribute_id > 0 && attribute_element_id > 0){
		termdic_data = termdic_proc.getModelTermDicData(intModelNo, cate, attribute_id,attribute_element_id, "");
		for(int i=0;i<termdic_data.length;i++){
			if(!strKbnos.equals("")) strKbnos += ",";
			strKbnos+=termdic_data[i].getRef_kb_no();
		}
	}*/

	if(strKbnos.length()>0) {
		strKbnosAry = strKbnos.split(",");

		if(strKbnosAry!=null && strKbnosAry.length>0) {
			kbnos = new int[strKbnosAry.length];

			for(int i=0; i<strKbnosAry.length; i++) {
				try {
					kbnos[i] = Integer.parseInt(strKbnosAry[i]);
				} catch(Exception e) {}
			}
		}
	}

	String strSpec = "";
	String reStrSpec = "";
	Goods_Data goods_data = null;
	Goods_Proc goods_proc = null;
	JSONArray jSONArray = new JSONArray();
	


	if(kbnos!=null && kbnos.length>0) { 
		String strBeginerTip = "";
		String strHeaderOverDesc = "";
		String strIconMovie = ""; //상세보기링크 초보사전글에 동영상이 있는지 여부
		String strIsVote = "N";


		if(kbnos!=null && kbnos.length>0) {
			for(int i=0; i<kbnos.length; i++) {
				String vmode = ChkNull.chkStr(request.getParameter("vmode"), "read");
				String vtype = ChkNull.chkStr(request.getParameter("vtype"),"GOOD");
			    String strRemoteHost = ConfigManager.szConnectIp(request);

				String strUserid = cb.GetCookie("MEM_INFO","USER_ID");
				//사내에서 호출은 로그 안남김
				if(strRemoteHost.indexOf("58.234.199") < 0) {
					if (vmode.equals("read")){
						Know_termdic_title_Proc.insert_ReadLog(kbnos[i], strUserid, strRemoteHost, vtype);
					}else if (vmode.equals("link")){
						Know_termdic_title_Proc.insert_LinkLog(kbnos[i], strUserid, strRemoteHost, vtype);
					}
					Know_box_Proc.updateReadCnt(kbnos[i], strUserid);
				}

				Know_termdic_title_Data kdata = termdic_proc.getData_TermdicTitle(kbnos[i]);
				if(kdata != null){
					int kb_no = kdata.getRef_kbno();
					String strHeaerTitle = kdata.getKtt_title();
					String strHeaderImage = kdata.getKtt_titleimg();
					String strHeaerDesc = kdata.getKtt_content();
					String strKb_movfile = kdata.getKb_movfile();
					String strKbContent = kdata.getKb_content();
					String strLinkYn = kdata.getKtt_linkyn();
					int intKtt_readcnt = kdata.getKtt_readcnt();
					int intImageHeight = kdata.getKtt_titleimg_height();
					int intImageWidth = kdata.getKtt_titleimg_width();
					String strIsSearch = kdata.getKtt_searchflag();
					String strBigImage = kdata.getKtt_titlebigimg();
					int intImport = kdata.getKtt_importance();
					String strSpecsynonym = kdata.getKtt_funcsynonym();
					strSpecsynonym = HtmlStr.removeHtml(strSpecsynonym);

					if(intModelNo>0) {
						if(kb_no==236538) {
							goods_proc = new Goods_Proc();
							goods_data = goods_proc.Goods_Detailmulti_One(intModelNo, "Detailmulti");
							strSpec = goods_data.getSpec();
							reStrSpec = strSpec.substring(0,strSpec.lastIndexOf("㎡"));
							if(reStrSpec.lastIndexOf(" ")>0) {
								reStrSpec = reStrSpec.substring(reStrSpec.lastIndexOf(" "),reStrSpec.length()).trim();
							}
						} else if(kb_no==146923) { //제습 면적 계산일때만 사용
							goods_proc = new Goods_Proc();
							goods_data = goods_proc.Goods_Detailmulti_One(intModelNo, "Detailmulti");
							strSpec = goods_data.getSpec();
							reStrSpec = strSpec.substring(strSpec.indexOf("제습면적:")+5,strSpec.lastIndexOf("㎡"));
							if(reStrSpec.indexOf(".")>0) {
								reStrSpec = reStrSpec.substring(0,reStrSpec.lastIndexOf("."));
							}
						} else if(kb_no==144048) { //사용 면적 계산일때만 사용
							goods_proc = new Goods_Proc();
							goods_data = goods_proc.Goods_Detailmulti_One(intModelNo, "Detailmulti");
							strSpec = goods_data.getSpec();
							reStrSpec = strSpec.substring(strSpec.indexOf("사용면적:")+5,strSpec.lastIndexOf("㎡"));
							if(reStrSpec.indexOf(".")>0) {
								reStrSpec = reStrSpec.substring(0,reStrSpec.lastIndexOf("."));
							}
						} else if(kb_no==147348) { //난방 면적 계산일때만 사용
							goods_proc = new Goods_Proc();
							goods_data = goods_proc.Goods_Detailmulti_One(intModelNo, "Detailmulti");
							strSpec = goods_data.getSpec();
							reStrSpec = strSpec.substring(strSpec.indexOf("난방면적:")+5,strSpec.lastIndexOf("㎡"));
							if(reStrSpec.indexOf(".")>0) {
								reStrSpec = reStrSpec.substring(0,reStrSpec.lastIndexOf("."));
							}
						} else if(kb_no==219397) { //사용 면적 계산일때만 사용
							goods_proc = new Goods_Proc();
							goods_data = goods_proc.Goods_Detailmulti_One(intModelNo, "Detailmulti");
							strSpec = goods_data.getSpec();
							reStrSpec = strSpec.substring(strSpec.indexOf("사용면적:")+5,strSpec.lastIndexOf("㎡"));
							if(reStrSpec.indexOf(".")>0) {
								reStrSpec = reStrSpec.substring(0,reStrSpec.lastIndexOf("."));
							}
						}
					}

					strSpecsynonym = strSpecsynonym.replace("\""," ");
					strSpecsynonym = strSpecsynonym.replace("'"," ");
					strSpecsynonym = strSpecsynonym.replace("^"," ");
					strSpecsynonym = strSpecsynonym.replace("&"," ");
					strSpecsynonym = strSpecsynonym.replace("~"," ");
					strSpecsynonym = strSpecsynonym.replace("!"," ");
					strSpecsynonym = strSpecsynonym.replace("@"," ");
					strSpecsynonym = strSpecsynonym.replace("$"," ");
					strSpecsynonym = strSpecsynonym.replace("%"," ");
					strSpecsynonym = strSpecsynonym.replace("*"," ");
					strSpecsynonym = strSpecsynonym.replace("+"," ");
					strSpecsynonym = strSpecsynonym.replace("="," ");
					strSpecsynonym = strSpecsynonym.replace("\\"," ");
					strSpecsynonym = strSpecsynonym.replace("{"," ");
					strSpecsynonym = strSpecsynonym.replace("}"," ");
					strSpecsynonym = strSpecsynonym.replace("["," ");
					strSpecsynonym = strSpecsynonym.replace("]"," ");
					strSpecsynonym = strSpecsynonym.replace(":"," ");
					strSpecsynonym = strSpecsynonym.replace(";"," ");
					strSpecsynonym = strSpecsynonym.replace("/"," ");
					strSpecsynonym = strSpecsynonym.replace("<"," ");
					strSpecsynonym = strSpecsynonym.replace(">"," ");
					//strSpecsynonym = strSpecsynonym.replace("."," ");
					strSpecsynonym = strSpecsynonym.replace(","," ");
					strSpecsynonym = strSpecsynonym.replace("?"," ");
					strSpecsynonym = strSpecsynonym.replace("("," ");
					strSpecsynonym = strSpecsynonym.replace(")"," ");
					strSpecsynonym = strSpecsynonym.replace("_"," ");
					strSpecsynonym = strSpecsynonym.replace("-"," ");
					strSpecsynonym = strSpecsynonym.replace("`"," ");
					strSpecsynonym = strSpecsynonym.replace("|"," ");

					if(!strKb_movfile.equals("") || ((strKbContent.toLowerCase().indexOf("<embed")>=0 || strKbContent.toLowerCase().indexOf("<object")>=0) && strKbContent.toLowerCase().indexOf("wmv")>=0)) {
						strIconMovie = "Y";
					}

					strHeaerTitle = strHeaerTitle.replaceAll("\"","'");
					strSpecsynonym = strSpecsynonym.replaceAll("\"","'");

					strHeaerDesc = ReplaceStr.replace(strHeaerDesc,"bigimg=&quot;", "style='cursor:pointer' onclick=&quot;top.showBeginnerDicBigImage('");

					strHeaerDesc = strHeaerDesc.replaceAll("\"","'");
					strHeaerDesc = strHeaerDesc.replaceAll("\r\n","<br>");
					strHeaerDesc = strHeaerDesc.replaceAll("\r","");
					strHeaerDesc = strHeaerDesc.replaceAll("\n","");
					strHeaerDesc = strHeaerDesc.replaceAll("\"","'");
					strHeaerDesc = strHeaerDesc.replaceAll("(?i)<BR>&nbsp;","<BR>");
					strHeaerDesc = strHeaerDesc.replaceAll("(?i)HY헤드라인M","wooriSoyoung");
					strHeaerDesc = strHeaerDesc.replaceAll("(?i)wooriSoyoung","돋움");
					strHeaerDesc = strHeaerDesc.replaceAll("(?i)FONT-SIZE: 16pt","FONT-SIZE: 8pt;font-weight:bold");
					strHeaerDesc = strHeaerDesc.replaceAll("(?i)FONT-SIZE: 10pt","FONT-SIZE: 8pt;");
					strHeaerDesc = strHeaerDesc.replaceAll("(?i)LINE-HEIGHT: 250","LINE-HEIGHT: 170;");
					strHeaerDesc = strHeaerDesc.replaceAll("(?i)LINE-HEIGHT: 150","LINE-HEIGHT: 110;");
					strHeaerDesc = strHeaerDesc.replaceAll("(?i)&quot;","\"");
					strHeaerDesc = strHeaerDesc.replaceAll("&nbsp;","");

					strHeaderOverDesc = strHeaerDesc;

					if(strHeaderOverDesc.trim().indexOf("<synonym")>=0) {
						int intLoopCheck = 0;
						while(true) {
							if(strHeaderOverDesc.trim().indexOf("<synonym")>=0) {
								try {
									int intF1 = strHeaderOverDesc.trim().indexOf("<synonym");
									String str1 = strHeaderOverDesc.substring(0,intF1);
									int intF2 = strHeaderOverDesc.indexOf(">",intF1+8);
									String strKbNo = strHeaderOverDesc.substring(intF1+8,intF2).trim();
									int intF3 = strHeaderOverDesc.indexOf("</synonym>",intF2);
									String strFuncsynonym = strHeaderOverDesc.substring(intF2+1,intF3);
									String str2 = strHeaderOverDesc.substring(intF3+10,strHeaderOverDesc.length());

									strHeaderOverDesc = str1 + "<span style='cursor:pointer;text-decoration:underline;'  onmouseover=\"this.style.color='#c70b09'\"  onmouseout=\"this.style.color='#000000'\"  onClick=\"showBeginnerDic2("+strKbNo+");\">"+strFuncsynonym+"</span>" + str2;

								} catch(Exception wex) {
									strHeaderOverDesc = strHeaerDesc;
									break;
								}
							} else {
								break;
							}

							if(intLoopCheck>20) {
								break;
							}

							intLoopCheck++;
						}
					}
					String strHeaderOverDescBottom = "";
					int intBreak = strHeaderOverDesc.trim().indexOf("<break>");
					if(intBreak>0) {
						strHeaderOverDescBottom = strHeaderOverDesc.substring(intBreak+7,strHeaderOverDesc.trim().length());
						strHeaderOverDesc = strHeaderOverDesc.substring(0,intBreak);
					}

					String strBottomClass = "bgBeginnerTop04";
					String strSearchDisplay = "display:none;";
					if(strIsSearch.equals("1")) {
						strBottomClass = "bgBeginnerTop05";
						strSearchDisplay = "";
					}
					String strVoteDisplay = "";
					if(strIsVote.equals("N")) {
						strVoteDisplay = "style=\"display:none;\"";
					}
					String strGuideDetailTextDisplay = "";
					String strGuideDetailImage = "";
					if(strIconMovie.trim().length()==0) {
						strGuideDetailImage = ConfigManager.IMG_ENURI_COM + "/2012/list/guide/btn_more_big2.gif";
						if(!strLinkYn.equals("N")) {
							strGuideDetailTextDisplay = "";
						} else {
							strGuideDetailTextDisplay = "display:none;";
						}
					} else {
						strGuideDetailImage = ConfigManager.IMG_ENURI_COM + "/images/view/mini/movie_detail_view.gif";
						if(!strLinkYn.equals("N")) {
							strGuideDetailTextDisplay = "";
						} else {
							strGuideDetailTextDisplay = "display:none;";
						}
					}
					boolean bBottomRow = true;
					if(strSearchDisplay.trim().length()>0 && intImport<=0 && strGuideDetailTextDisplay.trim().length()>0) {
						bBottomRow = false;
					}
			
					

					//지식통 댓글 데이터
					Know_box_Data odata = Know_box_Proc.getData_Kbno(kb_no);
					int iTotalCnt = 0;
					if(odata!=null) {
						iTotalCnt = odata.getKb_child_num();
					}
					

					JSONObject tmpObject = new JSONObject();
					tmpObject.put("kb_no",kb_no);
					tmpObject.put("strHeaerTitle",strHeaerTitle);
					tmpObject.put("strHeaderImage",strHeaderImage);
					tmpObject.put("strHeaerDesc",strHeaerDesc);
					tmpObject.put("strKb_movfile",strKb_movfile);
					tmpObject.put("strKbContent",strKbContent);
					tmpObject.put("strLinkYn",strLinkYn);
					tmpObject.put("intKtt_readcnt",intKtt_readcnt);
					tmpObject.put("intImageHeight",intImageHeight);
					tmpObject.put("intImageWidth",intImageWidth);
					tmpObject.put("strIsSearch",strIsSearch);
					tmpObject.put("strBigImage",strBigImage);
					tmpObject.put("intImport",intImport);
					tmpObject.put("strSpecsynonym",strSpecsynonym);
					jSONArray.put(tmpObject);
				}
			}
			rtnJSONObject.put("kbnoList",jSONArray);

			int specno = 0;
			if(attribute_id > 0 || attribute_element_id > 0){
				specno = termdic_proc.getSpecFromAttributeIdModelno(cate, intModelNo, attribute_id, attribute_element_id);
			}
			rtnJSONObject.put("specno",specno);
			ret = new JsonResponse(true).setData(rtnJSONObject).setTotal(jSONArray.length());
		} else {
			ret = new JsonResponse(false).setData(rtnJSONObject);
		}
	}else{
		ret = new JsonResponse(false).setData(rtnJSONObject);
	}
	out.println(ret.toString());
}

//procType=3 : 상품창에서 검색하는 용어사전 리스트
if(procType.equals("3")) {
	String cate = ConfigManager.RequestStr(request, "cate", "");
	int modelno = ChkNull.chkInt(request.getParameter("modelno"), 0);
	String keyword = ConfigManager.RequestStr(request, "keyword", "");
	if(cate.length()>=4) {
		cate = cate.substring(0, 4);
	}
	TermDic_Data[] termdic_model_data = termdic_proc.getModelTermDicList(modelno, cate, "");
	int attribute_id = 0;
	int attribute_element_id = 0;

	TermDic_Data[] termdic_data = termdic_proc.getSearchTermDicList(cate, keyword, "");
	JSONArray jSONArray = new JSONArray();
	if(termdic_data!=null && termdic_data.length>0) {
	    for(int i=0; i<termdic_data.length; i++) {
			String name = termdic_data[i].getName();
			int ref_kb_no = termdic_data[i].getRef_kb_no();
			
			if(termdic_model_data!=null && termdic_model_data.length>0) {
				for(int j=0; j<termdic_model_data.length; j++) {
					if(ref_kb_no == termdic_model_data[j].getRef_kb_no()){
						attribute_id = termdic_model_data[j].getAttribute_id();
						attribute_element_id = termdic_model_data[j].getAttribute_element_id();
					}
				}
			}
			JSONObject tmpObject = new JSONObject();
			tmpObject.put("name",name);
			tmpObject.put("ref_kb_no",ref_kb_no);
			tmpObject.put("attribute_id",attribute_id);
			tmpObject.put("attribute_element_id",attribute_element_id);
			jSONArray.put(tmpObject);
		}
		ret = new JsonResponse(true).setData(jSONArray).setTotal(jSONArray.length());
	} else {
		ret = new JsonResponse(false).setData(jSONArray);
	}
	out.println(ret.toString());
}


if(procType.equals("5")) {
	int intKbno = ChkNull.chkInt(request.getParameter("intKbno"), 0);
	String strUserid = cb.GetCookie("MEM_INFO","USER_ID");
	
	Know_box_Proc.updateReadCnt(intKbno, strUserid);
}



//out.println(outJson);
%>

