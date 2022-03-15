<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*,java.text.*,java.net.*"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.util.http.*"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_BBS_List_Data"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_BBS_2019"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.bean.main.Vip_Comment_Filtering_Proc"%>
<%@ page import="com.enuri.bean.main.Vip_Comment_Filtering_Data"%>
<%@ page import="com.enuri.bean.knowbox.Know_box_Proc"%>
<%@ page import="com.enuri.bean.member.Sns_Login"%>
<%@ page import="com.enuri.util.common.JsonResponse"%>
<jsp:useBean  id="Know_box_Proc" class="com.enuri.bean.knowbox.Know_box_Proc"  />
<jsp:useBean id="Goods_Proc" class="com.enuri.bean.main.Goods_Proc" scope="page" />
<jsp:useBean id="Goods_BBS_2019" class="com.enuri.bean.lsv2016.Goods_BBS_2019" scope="page" />
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc" scope="page" />
<jsp:useBean id="Vip_Comment_Filtering_Proc" class="com.enuri.bean.main.Vip_Comment_Filtering_Proc" scope="page" />
<jsp:useBean id="Vip_Comment_Filtering_Data" class="com.enuri.bean.main.Vip_Comment_Filtering_Data" scope="page" />
<jsp:useBean id="Sns_Login" class="com.enuri.bean.member.Sns_Login" scope="page" />
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>

<%!
public static String toJS2(String str) {
	return str.replace("\\", "\\\\")
				.replace("\"", "\\\"")
				.replace("&" , "&amp;")
				.replace("\'", "&#39")
				.replace("\b", "\\b")
				.replace("\f", "\\f")
				.replace("\n", "\\n")
				.replace("\r", "\\r")
				.replace("\t", "\\t");
}
public static String toJS3(String str) {
	return str.replace("\\", "\\\\")
				.replace("\"", "\\\"")
				.replace("\b", "\\b")
				.replace("\f", "\\f")
				.replace("\n", "\\n")
				.replace("\r", "\\r")
				.replace("\t", "\\t");
}
%>

<%
	CookieBean cb = null;
	cb = new CookieBean( request.getCookies());

	//불법 크롤링 차단
	String strBrowser = request.getHeader("User-Agent");
	String strReferer = ChkNull.chkStr(request.getHeader("referer"));

	if(!CvtStr.isNumeric(request.getParameter("modelno"))){
		return ;
	}
	if((strReferer == null || strReferer.equals("")) && !(request.getRemoteAddr().equals("127.0.0.1") ||  request.getRemoteAddr().indexOf("100.100.100.") > -1||  request.getRemoteAddr().indexOf("58.234.") > -1)){
		out.print("{}");
		return ;
	}
	Goods_BBS_2019 gbs = new Goods_BBS_2019();
	String pType 			= ChkNull.chkStr(request.getParameter("pType"),"GL");
	String strWord_code	= ChkNull.chkStr(request.getParameter("word_code"));		//주제 필터링추가
	String strCategory	= ChkNull.chkStr(request.getParameter("cate"));		//주제 필터링추가
	int iModelno 			= ChkNull.chkInt(request.getParameter("modelno"));

	int iGroupModelno 		= gbs.getGroupModelno(iModelno);

	String sUserId 		= cb.GetCookie("MEM_INFO"	, "USER_ID"		);
	String sUserNick 	= cb.GetCookie("MEM_INFO"	, "USER_NICK"	);
	String sLoginNick 	= cb.GetCookie("MEM_INFO"	, "LOGIN_NICK"	);
	String sUserGroup	= cb.GetCookie("MEM_INFO"	, "USER_GROUP"	);
	String sCookieNick 	= cb.GetCookie("KNOWBOX"	, "KB_NICKNAME"	);
	String sCookieEmail = cb.GetCookie("KNOWBOX"	, "TO_EMAIL"	);
	String sSnsType = cb.GetCookie("MEM_INFO","SNSTYPE");

	//String ip = request.getRemoteAddr();
	String ip = ConfigManager.szConnectIp(request);
	String usernmSet 	= "";
	JSONObject rtnJSONObject = new JSONObject();
  	JsonResponse ret = null;

	if(sUserNick.length()>0) usernmSet = sUserNick;
	else usernmSet = sUserId;

	if ( pType.equals("GB") ) {
		//상품평 차트 조회 ( 에누리 PC, [PC/M] VIP 사용, 상품 비교창)
		JSONObject chartJSONObject = new JSONObject();
		JSONArray chartJSONArray = new JSONArray();
		if(iModelno > 0) {
			Goods_Data goods_data 	= Goods_Proc.Goods_Detailmulti_One(iModelno, "Detailmulti");

			if(goods_data != null) {

				String smodelnos 		= Goods_Proc.getData_Group_Modelnos(iModelno);
				String svod_kbnos 		= Goods_Proc.getKbs_Goods_Vod(smodelnos);
				String strCate 			= goods_data.getCa_code();
				float bbs_point_avg 	= goods_data.getBbs_point_avg();
				int iBbs_point_num 		= goods_data.getBbs_num();
				int iBbs_point_cnt		= 0;

				int iBbs_num = gbs.Goods_BBS_Cnt(iModelno, iGroupModelno);

				DecimalFormat df = new DecimalFormat("#.#");
				//bbs_point_avg = Float.parseFloat(df.format(bbs_point_avg));

				chartJSONObject.put("smodelnos",smodelnos);
				chartJSONObject.put("svod_kbnos",svod_kbnos);
				chartJSONObject.put("strCate",strCate);
				chartJSONObject.put("bbs_point_avg",df.format(bbs_point_avg));
				chartJSONObject.put("iBbs_point_num",iBbs_point_num); // 사용자 총 평점
				chartJSONObject.put("iBbs_num",iBbs_num);			  // 등록 총 평점 합계
				chartJSONObject.put("sUserId",sUserId);				  // 등록평 Count

				if (iBbs_num > 0) {
					Goods_BBS_List_Data[] goods_BBS_List_Data = null;
					goods_BBS_List_Data = gbs.Goods_BBS_Star_Most_New(iModelno,iGroupModelno);
					if (goods_BBS_List_Data != null && goods_BBS_List_Data.length > 0) {
						for(int i=0; i<goods_BBS_List_Data.length; i++) {
							JSONObject tmpObject = new JSONObject();
							tmpObject.put("point",goods_BBS_List_Data[i].getPoint());
							tmpObject.put("pointCnt",goods_BBS_List_Data[i].getPointCnt());
							chartJSONArray.put(tmpObject);
							iBbs_point_cnt += goods_BBS_List_Data[i].getPointCnt();
						}
					}
				}
				chartJSONObject.put("pointList",chartJSONArray);
				chartJSONObject.put("iBbs_point_cnt",iBbs_point_cnt);
				ret = new JsonResponse(true).setData(chartJSONObject);
			}else{
				ret = new JsonResponse(false).setData(chartJSONObject);
			}
		}else{
			ret = new JsonResponse(false).setData(chartJSONObject);
		}
       	out.println(ret.toString());
	} else if ( pType.equals("GT") ) {
		//상품평 상단 3개 랜덤 조회 ( 에누리 PC, [PC] VIP 사용)
		Goods_BBS_List_Data[] goods_BBS_List_Data_t = null;
		/* 상단 댓글 3개 조회 - 랜덤 */
		goods_BBS_List_Data_t = gbs.Goods_BBS_Commend_List_2021(iModelno,iGroupModelno);
		JSONObject topJSONObject = new JSONObject();
		JSONArray topJSONArray = new JSONArray();

		if (goods_BBS_List_Data_t != null) {
			int next_idx = 0;
			int prev_idx = 0;
			for(int i = 0; i < goods_BBS_List_Data_t.length; i++) {


				int modelno = goods_BBS_List_Data_t[i].getModelno();
				int no = goods_BBS_List_Data_t[i].getNo();
				String shopcode = goods_BBS_List_Data_t[i].getShop_code();
				String username = goods_BBS_List_Data_t[i].getUsernm();
				String userid = goods_BBS_List_Data_t[i].getUserid();
				String title = goods_BBS_List_Data_t[i].getTitle();
				String contents = goods_BBS_List_Data_t[i].getContents();
				String regdate = goods_BBS_List_Data_t[i].getRegdate();
				String shopname = goods_BBS_List_Data_t[i].getShop_name();
				int point = goods_BBS_List_Data_t[i].getPoint();
				String imgsrv_flg = goods_BBS_List_Data_t[i].getImgsrv_flg();
				String imgurl_org =goods_BBS_List_Data_t[i].getImgurl_org();
				String bbsid =goods_BBS_List_Data_t[i].getBbsid();
				boolean is_sns = gbs.isSnsUser(userid);
				String usernameView = "";
				String titleView ="";
				String contentsView = "";
				if(shopcode.equals("0")){
					username = goods_BBS_List_Data_t[i].getUsernm();
				}else {
					username = goods_BBS_List_Data_t[i].getUsernm().replaceAll("(?<=.{2}).", "*");
				}

				if(goods_BBS_List_Data_t[i].getUserid().length() > 2){
					userid = goods_BBS_List_Data_t[i].getUserid().substring(0, 2)+"****";
				}else {
					userid = goods_BBS_List_Data_t[i].getUserid()+"****";
				}
				//에누리 회원 + SNS 회원이면 닉네임
				//나머지는 ID
				if(shopcode.equals("0") && is_sns){
					usernameView = username;
				}else {
					usernameView = userid;
				}
				if(title.trim().equals("") || title.trim().equals("null")){
					if(!contents.trim().equals("") && !contents.trim().equals("null")){
						titleView = contents.replaceAll("(<([^>]+)>)", "");
						contentsView = contents;
						
						if(titleView.length() > 30){
							titleView = titleView.substring(0,30);
						}
					}else{
						titleView = "평점만 제공되는 상품평입니다.";
						contentsView = "평점만 제공되는 상품평입니다.";
					}
				}else{
					titleView = title;
					contentsView = contents;
				}

				JSONObject tmpObject = new JSONObject();
				JSONArray addlist =  gbs.getPhoto_ImageList(shopcode, bbsid);
				tmpObject.put("imglist", addlist);
				tmpObject.put("modelno", modelno);
				tmpObject.put("no",no);
				tmpObject.put("username",usernameView);
				tmpObject.put("regdate",regdate);
				tmpObject.put("imgsrv_flg",imgsrv_flg);
				tmpObject.put("imgurl_org",imgurl_org.replaceAll("\\\\", "/"));
				tmpObject.put("shopcode",shopcode);
				tmpObject.put("shopname",shopname);
				tmpObject.put("title",titleView);
				tmpObject.put("contents",contentsView);
				tmpObject.put("point",point);
				tmpObject.put("next_idx",next_idx);
				tmpObject.put("prev_idx",prev_idx);
				tmpObject.put("list_idx",i+1);
				topJSONArray.put(tmpObject);
			}
			ret = new JsonResponse(true).setData(topJSONArray).setTotal(topJSONArray.length());
		}else{
			ret = new JsonResponse(false).setData(topJSONArray).setTotal(0);
		}
		out.println(ret.toString());
	} else if ( pType.equals("GO") ) {
		//상단 평점 호출  - 상단 상품평 클릭 (에누리PC 사용)
		String strShopCode = ChkNull.chkStr(request.getParameter("shop_code"), "");
		int iNo = ChkNull.chkInt(request.getParameter("no"));
		Goods_BBS_List_Data goods_BBS_List_Data = new Goods_BBS_List_Data();
		/* 상단 댓글 2개 조회 - 랜덤 */
		goods_BBS_List_Data = gbs.Goods_BBS_Commend_One(iModelno,iGroupModelno, iNo, strShopCode);
		String  contents = "";
		String  title = "";
		out.println("{");
		if (goods_BBS_List_Data != null) {
				contents = goods_BBS_List_Data.getContents();
				title = goods_BBS_List_Data.getTitle();
				out.println("	\"modelno\":\""+goods_BBS_List_Data.getModelno()+"\", ");
				out.println("	\"no\":\""+goods_BBS_List_Data.getNo()+"\", ");
				if(!goods_BBS_List_Data.getShop_code().equals("0")){
					out.println("	\"usernm\":\""+goods_BBS_List_Data.getUsernm().replaceAll("(?<=.{2}).", "*")+"\", ");
					if (goods_BBS_List_Data.getUserid().length() > 2) {
						out.println("	\"userid\":\""+goods_BBS_List_Data.getUserid().substring(0, 2)+"****"+"\", ");
					} else {
						out.println("	\"userid\":\""+goods_BBS_List_Data.getUserid()+"****"+"\", ");
					}
				}else{
					out.println("	\"usernm\":\""+goods_BBS_List_Data.getUsernm()+"\", ");
					if (goods_BBS_List_Data.getUserid().length() > 2) {
						out.println("	\"userid\":\""+goods_BBS_List_Data.getUserid().substring(0, 2)+"****"+"\", ");
					} else {
						out.println("	\"userid\":\""+goods_BBS_List_Data.getUserid()+"****"+"\", ");
					}
				}
				if( (title.trim().equals("") && !contents.trim().equals("")) || (title.trim().equals("null") && !contents.trim().equals("null"))){			//제목만 없을경우 내용을 제목으로 대체
					out.println("	\"title\":\""+toJS2(contents)+"\", ");
					out.println("	\"contents\":\""+toJS3(contents)+"\", ");
				}else if( (title.trim().equals("") && contents.trim().equals("")) || (title.trim().equals("null") && contents.trim().equals("null")) ){		//제목,컨텐츠 둘다없을경우 예외처리
					out.println("	\"title\":\"평점만 제공되는 상품평입니다.\", ");
					out.println("	\"contents\":\"평점만 제공되는 상품평입니다.\", ");
				}else{
					out.println("	\"title\":\""+toJS2(title)+"\", ");
					out.println("	\"contents\":\""+toJS3(contents)+"\", ");
				}
				out.println("	\"contentsByte\":\""+goods_BBS_List_Data.getContents().getBytes().length+"\", ");
				out.println("	\"regdate\":\""+goods_BBS_List_Data.getRegdate()+"\", ");
				out.println("	\"shop_code\":\""+goods_BBS_List_Data.getShop_code()+"\", ");
				out.println("	\"shop_name\":\""+toJS2(goods_BBS_List_Data.getShop_name())+"\", ");
				out.println("	\"delflag\":\""+goods_BBS_List_Data.getDelflag()+"\", ");
				out.println("	\"event_idx\":\""+goods_BBS_List_Data.getEvent_idx()+"\", ");
				out.println("	\"recommend\":\""+goods_BBS_List_Data.getRecommend()+"\", ");
				out.println("	\"point\":\""+goods_BBS_List_Data.getPoint()+"\", ");
				out.println("	\"imgsrv_flg\":\""+goods_BBS_List_Data.getImgsrv_flg()+"\", ");
				out.println("	\"imgurl_org\":\""+goods_BBS_List_Data.getImgurl_org().replaceAll("\\\\", "/")+"\" ");
		}
		out.println("}");
	} else if ( pType.equals("GL") ) {
		//상품평 리스트 조회 (에누리 PC, [PC/M] VIP  )
		int iPoint = ChkNull.chkInt(request.getParameter("point"), 0);
		String nnos = ChkNull.chkStr(request.getParameter("nnos"), "");
		String shopcodes = ChkNull.chkStr(request.getParameter("shopcodes"), "");
		String isPhoto = ChkNull.chkStr(request.getParameter("isphoto"), "");

		int iPage = ChkNull.chkInt(request.getParameter("page"), 1);
		int iPageSize = ChkNull.chkInt(request.getParameter("pagesize"), 5); //페이지당 게시물수
		int iPageCount = 0;

		//by Zero 처리 2018-09-17
		if(iPageSize < 1){
			iPageSize = 5;
		}

		if(iPageSize > 50){
			iPageSize = 50;
		}

		//주제필터링 추가 2017-07-24 shwoo
		Vip_Comment_Filtering_Data[] vip_comment_filtering_data = null;
		int intGoodsDataCnt = 0;
		String strNo = "";
		String strBbsModelno = "";
		if(strWord_code != null && !strWord_code.equals("")){
			strCategory = strCategory.substring(0,4);
			vip_comment_filtering_data = Vip_Comment_Filtering_Proc.Vip_Comment_Filtering_List(iModelno, strCategory, strWord_code);

			if (vip_comment_filtering_data != null){
			    intGoodsDataCnt = vip_comment_filtering_data.length;
			}

			for(int i=0; i<intGoodsDataCnt; i++) {

				if(!String.valueOf(vip_comment_filtering_data[i].getModelno()).equals("")){
					if(i > 0) 	strBbsModelno += ",";
					strBbsModelno += vip_comment_filtering_data[i].getModelno();
				}


				if(!vip_comment_filtering_data[i].getNo().equals("")){
					if(i > 0) 	strNo += ",";
					strNo += vip_comment_filtering_data[i].getNo();
				}
			}
		}


		int iTotalCnt = 0 ;
		iTotalCnt = gbs.Goods_BBS_Cnt_New_Filter_2021(iModelno,iGroupModelno, iPoint, nnos, shopcodes, isPhoto, strBbsModelno, strNo);

		Goods_BBS_List_Data[] goods_BBS_List_Data = null;

		out.println("{");
		out.println("	\"list\":[");
		if(iTotalCnt > 0) {
			/* 전체 댓글 조회 */
			goods_BBS_List_Data = gbs.Goods_BBS_List_new_Filter_2021(iModelno,iGroupModelno, iPage, iPageSize, "", nnos, iPoint, shopcodes, isPhoto, strBbsModelno, strNo);

			for(int i = 0; i < goods_BBS_List_Data.length; i++) {
				if(i>0) out.println(",");

				String strUserID = goods_BBS_List_Data[i].getUserid();
				String strShop_code = goods_BBS_List_Data[i].getShop_code();
				String title = goods_BBS_List_Data[i].getTitle();
				String strOrg_content = goods_BBS_List_Data[i].getContents();
				boolean bldelFlag = false;
				if ("0".equals(strShop_code)  && !"".equals(sUserId) && (sUserId.equals(strUserID) || cb.GetCookie("MEM_INFO","USER_GROUP").equals("1") || cb.GetCookie("MEM_INFO","USER_GROUP").equals("2"))) {
					bldelFlag = true;
				}


				//주제필터 적용
				if(strWord_code != null && !strWord_code.equals("") && intGoodsDataCnt > 0){

					String strTmp_No1 = "";
					String strTmp_No2 = "";

					for(int j=0; j<intGoodsDataCnt; j++) {
						strTmp_No1 = vip_comment_filtering_data[j].getNo();
						strTmp_No2 = goods_BBS_List_Data[i].getNo()+ "";

						if(vip_comment_filtering_data[j].getHighlighting_word() != null && !"".equals(vip_comment_filtering_data[j].getHighlighting_word()) && strTmp_No1.equals(strTmp_No2)){
							strOrg_content = strOrg_content.replace(vip_comment_filtering_data[j].getHighlighting_word(),"<span class=\"hglight\">"+vip_comment_filtering_data[j].getHighlighting_word()+"</span>");
							break;
						}
					}
				}


				out.println("	{");
				out.println("	\"modelno\":\""+goods_BBS_List_Data[i].getModelno()+"\", ");
				out.println("	\"no\":\""+goods_BBS_List_Data[i].getNo()+"\", ");

				if(!goods_BBS_List_Data[i].getShop_code().equals("0")){
					out.println("	\"usernm\":\""+goods_BBS_List_Data[i].getUsernm().replaceAll("(?<=.{2}).", "*")+"\", ");
					if (goods_BBS_List_Data[i].getUserid().length() > 2) {
						out.println("	\"userid\":\""+goods_BBS_List_Data[i].getUserid().substring(0, 2)+"****"+"\", ");
					} else {
						out.println("	\"userid\":\""+goods_BBS_List_Data[i].getUserid()+"****"+"\", ");
					}
					out.println("	\"is_sns\":\"N\", ");
				}else{
					out.println("	\"usernm\":\""+goods_BBS_List_Data[i].getUsernm()+"\", ");
					if (goods_BBS_List_Data[i].getUserid().length() > 2) {
						out.println("	\"userid\":\""+goods_BBS_List_Data[i].getUserid().substring(0, 2)+"****"+"\", ");
					} else {
						out.println("	\"userid\":\""+goods_BBS_List_Data[i].getUserid()+"****"+"\", ");
					}

					// SNS (네이버, 카카오) 로그인 계정 체크 :
					if (gbs.isSnsUser(goods_BBS_List_Data[i].getUserid())) {
						out.println("	\"is_sns\":\"Y\", ");
					} else {
						out.println("	\"is_sns\":\"N\", ");
					}
				}
				if( (title.trim().equals("") && !strOrg_content.trim().equals("")) || (title.trim().equals("null") && !strOrg_content.trim().equals("null"))){			//제목만 없을경우 내용을 제목으로 대체
					out.println("	\"title\":\""+toJS2(strOrg_content)+"\", ");
					out.println("	\"contents\":\""+toJS3(strOrg_content)+"\", ");
				}else if( (title.trim().equals("") && strOrg_content.trim().equals("")) || (title.trim().equals("null") && strOrg_content.trim().equals("null"))){		//제목,컨텐츠 둘다없을경우 예외처리
					out.println("	\"title\":\"평점만 제공되는 상품평입니다.\", ");
					out.println("	\"contents\":\"평점만 제공되는 상품평입니다.\", ");
				}else{
					out.println("	\"title\":\""+toJS2(title)+"\", ");
					out.println("	\"contents\":\""+toJS3(strOrg_content)+"\", ");
				}

				out.println("	\"contentsByte\":\""+goods_BBS_List_Data[i].getContents().getBytes().length+"\", ");
				out.println("	\"regdate\":\""+goods_BBS_List_Data[i].getRegdate()+"\", ");
				out.println("	\"shop_code\":\""+strShop_code+"\", ");
				out.println("	\"shop_name\":\""+toJS2(goods_BBS_List_Data[i].getShop_name())+"\", ");
				out.println("	\"delflag\":\""+goods_BBS_List_Data[i].getDelflag()+"\", ");
				out.println("	\"event_idx\":\""+goods_BBS_List_Data[i].getEvent_idx()+"\", ");
				out.println("	\"recommend\":\""+goods_BBS_List_Data[i].getRecommend()+"\", ");
				out.println("	\"delbtn\":"+bldelFlag+", ");
				out.println("	\"point\":\""+goods_BBS_List_Data[i].getPoint()+"\", ");
				out.println("	\"imgsrv_flg\":\""+goods_BBS_List_Data[i].getImgsrv_flg()+"\", ");
				out.println("	\"imgurl_org\":\""+goods_BBS_List_Data[i].getImgurl_org().replaceAll("\\\\", "/")+"\", ");
				out.println("	\"list_idx\":\""+goods_BBS_List_Data[i].getList_idx()+"\" ,");
				JSONArray addlist =  new JSONArray();
				if(goods_BBS_List_Data[i].getImgsrv_flg().equals("Y")){
					addlist = gbs.getPhoto_ImageList(goods_BBS_List_Data[i].getShop_code(), goods_BBS_List_Data[i].getBbsid());
				}
				out.println("	\"photo_list\":"+addlist.toString());
				out.print("	}");
			}
		}
		out.println("\r\n	],");
		out.println("	\"iTotalCnt\":\""+iTotalCnt+"\", ");
		out.println("	\"page\":\""+iPage+"\", ");
		out.println("	\"pagesize\":\""+((iTotalCnt/iPageSize) + 1)+"\", ");
		out.println("	\"iPageSize\":\""+iPageSize+"\" ");
		out.println("}");
	} else if ( pType.equals("SL") ) {
		//쇼핑몰 리스트 (에누리 PC, [PC/M] VIP)
		Goods_BBS_List_Data[] goods_BBS_List_Data = null;
		JSONArray rtnJSONArray = new JSONArray();
		goods_BBS_List_Data = gbs.Goods_BBS_Commend_Shop_List(iModelno,iGroupModelno);

		for(int i = 0; i < goods_BBS_List_Data.length; i++) {
			JSONObject tmpObject = new JSONObject();
			tmpObject.put("shop_code",goods_BBS_List_Data[i].getShop_code());
			tmpObject.put("shop_name",goods_BBS_List_Data[i].getShop_name());
			rtnJSONArray.put(tmpObject);
		}
		ret = new JsonResponse(true).setData(rtnJSONArray).setTotal(rtnJSONArray.length());
		out.println(ret.toString());
	} else if ( pType.equals("GI") ) {
		//상품평 등록 (에누리 PC, [PC/M] VIP, MINI VIP)
		String contents = HtmlStr.xssFilter(ChkNull.chkStr(request.getParameter("contents"), ""));	// 스크립트 방지 처리함.
		JSONObject tmpJSONObject = new JSONObject();
		//contents = URLDecoder.decode(contents, "UTF-8");
		boolean procSuccessFlag = false;
		if(sUserId.length()>0){
			procSuccessFlag = gbs.Goods_BBS_Insert(iModelno, usernmSet, ip, "", "", contents, "", sUserId, "", 0);
			//Know_box_Proc.update_Kbnum(iModelno, 1); //글갯수 업데이트
		}
		tmpJSONObject.put("flag",procSuccessFlag);
		ret = new JsonResponse(true).setData(tmpJSONObject);
		out.println(ret.toString());
	} else if ( pType.equals("GD") ) {
		//상품평 삭제 (에누리 PC, [PC/M] VIP, MINI VIP)
		
		int del_no = ChkNull.chkInt(request.getParameter("no"));
		String del_pass = ChkNull.chkStr(request.getParameter("delpass"));

		//비밀번호 체크
		int deleteRtn = 0;
		boolean procSuccessFlag = false;
		String userid = "";
		String usernm = "";
		String strIsPassCaps = "";
		String errCode = "";
		boolean validPwd = false; //비번체크 결과
		JSONObject tmpJSONObject = new JSONObject();
		if (!sSnsType.isEmpty() && (sSnsType.equals("K") || sSnsType.equals("N")) ) {
			Goods_BBS_List_Data gb_data = gbs.Goods_BBS_One(iModelno, del_no, sUserId);

			/*************************************************************************
				SNS 사용자에 대한 사용자 정보를 DB를 통해서 다시 체크 한다.
				패스워드가 없으므로 쿠키값만 가지고 의존하지 않음.
			*************************************************************************/
			boolean validSsnUser = Sns_Login.bSnsMember(sUserId);


			if(gb_data==null) {
				deleteRtn = 0;
				procSuccessFlag = false;
			} else {
				if (validSsnUser) {
					deleteRtn = gbs.Goods_BBS_Delete(iModelno, del_no, ip, sUserId, usernmSet);
					Know_box_Proc.update_Kbnum(iModelno, -1);
					procSuccessFlag = true;
				} else {
					deleteRtn = 0;
					procSuccessFlag = false;
				}
			}
			tmpJSONObject.put("flag",procSuccessFlag);
			tmpJSONObject.put("passflag",true);
			ret = new JsonResponse(true).setData(tmpJSONObject);
			out.println(ret.toString());
		} else {
			Goods_BBS_List_Data gb_data = gbs.Goods_BBS_One(iModelno, del_no,"");
			if(gb_data==null){
				deleteRtn = 0;
				procSuccessFlag = false;
			} else {
				userid = gb_data.getUserid();
				usernm = gb_data.getUsernm();
				if(!userid.equals("")){ //회원 비번 체크
					strIsPassCaps = Members_Proc.getUserIsPassCaps(userid);

					Members_Data members_data = Members_Proc.Login_Check( userid , del_pass ); //사용자 정보
					errCode = ChkNull.chkStr(members_data.getErrCode());
					if(errCode.trim().length() == 0){ //정상
						validPwd = true;
					}
				}else{ //비회원 비번 체크
					int iNickCheck = Members_Proc.Nick_Login_Check(usernm, del_pass);
					if(iNickCheck==0){
						validPwd = true;
					}
				}

				if (validPwd) {
					deleteRtn = gbs.Goods_BBS_Delete(iModelno, del_no, ip, userid, usernmSet);
					Know_box_Proc.update_Kbnum(iModelno, -1);
					procSuccessFlag = true;
				} else {
					deleteRtn = 0;
					procSuccessFlag = false;
				}
				tmpJSONObject.put("flag",procSuccessFlag);
				tmpJSONObject.put("passflag",validPwd);
				ret = new JsonResponse(true).setData(tmpJSONObject);
				out.println(ret.toString());
			}
		}
	
	} else if ( pType.equals("ML") ) { //미니vip bbs list
		//미니vip bbs list (MINI VIP)
		int iPoint = ChkNull.chkInt(request.getParameter("iPoint"), 0);
		String nnos = ChkNull.chkStr(request.getParameter("nnos"), "");
		String shopcodes = ChkNull.chkStr(request.getParameter("shopcodes"), "");
		String isPhoto = ChkNull.chkStr(request.getParameter("isPhoto"), "");

		int iPage = ChkNull.chkInt(request.getParameter("page"), 1);
		int iPageSize = ChkNull.chkInt(request.getParameter("pagesize"), 30); //페이지당 게시물수
		int iPageCount = 0;

		int iTotalCnt = gbs.Mini_Goods_BBS_Cnt_New(iModelno,iGroupModelno, iPoint, nnos, shopcodes);

		Goods_BBS_List_Data[] goods_BBS_List_Data = null;

		out.println("{");
		if(iTotalCnt > 0) {
			/* 전체 댓글 조회 */
			goods_BBS_List_Data = gbs.Mini_Goods_BBS_List_new(iModelno,iGroupModelno, iPage, iPageSize, "", nnos, iPoint, shopcodes);

			out.println("	\"list\":[");
			for(int i = 0; i < goods_BBS_List_Data.length; i++) {
				if(i>0) out.println(",");

				String strUserID = goods_BBS_List_Data[i].getUserid();
				String strShop_code = goods_BBS_List_Data[i].getShop_code();
				String strTitle = goods_BBS_List_Data[i].getTitle();
				String strContent = goods_BBS_List_Data[i].getContents();
				boolean bldelFlag = false;
				if ("0".equals(strShop_code)  && !"".equals(sUserId) && (sUserId.equals(strUserID) || cb.GetCookie("MEM_INFO","USER_GROUP").equals("1") || cb.GetCookie("MEM_INFO","USER_GROUP").equals("2"))) {
					bldelFlag = true;
				}

				out.println("	{");
				out.println("	\"modelno\":\""+goods_BBS_List_Data[i].getModelno()+"\", ");
				out.println("	\"no\":\""+goods_BBS_List_Data[i].getNo()+"\", ");
				if(!goods_BBS_List_Data[i].getShop_code().equals("0")){
					out.println("	\"usernm\":\""+goods_BBS_List_Data[i].getUsernm().replaceAll("(?<=.{2}).", "*")+"\", ");
					if (goods_BBS_List_Data[i].getUserid().length() > 2) {
						out.println("	\"userid\":\""+goods_BBS_List_Data[i].getUserid().substring(0, 2)+"****"+"\", ");
					} else {
						out.println("	\"userid\":\""+goods_BBS_List_Data[i].getUserid()+"****"+"\", ");
					}
					out.println("	\"is_sns\":\"N\", ");
				}else{
					out.println("	\"usernm\":\""+goods_BBS_List_Data[i].getUsernm()+"\", ");
					if (goods_BBS_List_Data[i].getUserid().length() > 2) {
						out.println("	\"userid\":\""+goods_BBS_List_Data[i].getUserid().substring(0, 2)+"****"+"\", ");
					} else {
						out.println("	\"userid\":\""+goods_BBS_List_Data[i].getUserid()+"****"+"\", ");
					}

					// SNS (네이버, 카카오) 로그인 계정 체크 :
					if (gbs.isSnsUser(goods_BBS_List_Data[i].getUserid())) {
						out.println("	\"is_sns\":\"Y\", ");
					} else {
						out.println("	\"is_sns\":\"N\", ");
					}
				}
				if( (strTitle.trim().equals("") && !strContent.trim().equals("")) || (strTitle.trim().equals("null") && !strContent.trim().equals("null"))){			//제목만 없을경우 내용을 제목으로 대체
					out.println("	\"title\":\""+toJS2(strContent)+"\", ");
					out.println("	\"contents\":\""+toJS3(strContent)+"\", ");
				}else if( (strTitle.trim().equals("") && strContent.trim().equals("")) || (strTitle.trim().equals("null") && strContent.trim().equals("null"))){		//제목,컨텐츠 둘다없을경우 예외처리
					out.println("	\"title\":\"평점만 제공되는 상품평입니다.\", ");
					out.println("	\"contents\":\"평점만 제공되는 상품평입니다.\", ");
				}else{
					out.println("	\"title\":\""+toJS2(strTitle)+"\", ");
					out.println("	\"contents\":\""+toJS3(strContent)+"\", ");
				}

				out.println("	\"regdate\":\""+goods_BBS_List_Data[i].getRegdate()+"\", ");
				out.println("	\"shop_code\":\""+strShop_code+"\", ");
				out.println("	\"shop_name\":\""+toJS2(goods_BBS_List_Data[i].getShop_name())+"\", ");
				out.println("	\"delflag\":\""+goods_BBS_List_Data[i].getDelflag()+"\", ");
				out.println("	\"event_idx\":\""+goods_BBS_List_Data[i].getEvent_idx()+"\", ");
				out.println("	\"recommend\":\""+goods_BBS_List_Data[i].getRecommend()+"\", ");
				out.println("	\"delbtn\":"+bldelFlag+", ");
				out.println("	\"point\":\""+goods_BBS_List_Data[i].getPoint()+"\", ");
				out.println("	\"imgsrv_flg\":\""+goods_BBS_List_Data[i].getImgsrv_flg()+"\", ");
				out.println("	\"imgurl_org\":\""+goods_BBS_List_Data[i].getImgurl_org().replaceAll("\\\\", "/")+"\" ");
				out.print("	}");
			}
			out.println("\r\n	],");
		}
		out.println("	\"iTotalCnt\":\""+iTotalCnt+"\", ");
		out.println("	\"page\":\""+iPage+"\", ");
		out.println("	\"pagesize\":\""+((iTotalCnt/iPageSize) + 1)+"\", ");
		out.println("	\"iPageSize\":\""+iPageSize+"\" ");
		out.println("}");
	}else if(pType.equals("MD")){
		String isPhoto = ChkNull.chkStr(request.getParameter("isphoto"),"Y");
		int intSpmCd = ChkNull.chkInt(request.getParameter("shop_code"), 0);
		int iPoint = ChkNull.chkInt(request.getParameter("point"), 0); 
		int intListIdx = ChkNull.chkInt(request.getParameter("idx"), 0);
		int intNo = ChkNull.chkInt(request.getParameter("no"), 0); 
		Goods_BBS_List_Data[] gbldList = null;
		Goods_BBS_List_Data gbld = new Goods_BBS_List_Data();

		int intGoodsDataCnt = 0;
		String strNo = "";
		String strBbsModelno = iModelno+"";
		if(intNo > 0){
			strNo = intNo+"";
		}

		/* 전체 댓글 조회 */
		gbldList = gbs.Goods_BBS_Next_Prev_One(iModelno, iGroupModelno, intListIdx, isPhoto, iPoint,intSpmCd,strBbsModelno,strNo);
		int iBbs_num = gbs.Goods_BBS_List_Photo_Cnt(iModelno, iGroupModelno);

		JSONObject detailJSONObject = new JSONObject();
		JSONArray detailJSONArray = new JSONArray();


		if(gbldList != null){
			for(int i=0;i<gbldList.length;i++){
				gbld = gbldList[i];
				int next_idx = 0;
        		int prev_idx = 0;

				if(gbld != null){
					int modelno = gbld.getModelno();
					int no = gbld.getNo();
					int list_idx = gbld.getList_idx();
					String shopcode = gbld.getShop_code();
					String username = gbld.getUsernm();
					String userid = gbld.getUserid();
					String title = gbld.getTitle();
					String contents = gbld.getContents();
					String regdate = gbld.getRegdate();
					String shopname = gbld.getShop_name();
					int point = gbld.getPoint();
					String imgsrv_flg = gbld.getImgsrv_flg();
					String imgurl_org =gbld.getImgurl_org();
					boolean is_sns = gbs.isSnsUser(userid);
						
					String usernameView = "";
					String titleView ="";
					String contentsView = "";

					boolean delBtnFlag = false;
					if ("0".equals(shopcode)  && !"".equals(cb.GetCookie("MEM_INFO","USER_ID")) && (cb.GetCookie("MEM_INFO","USER_ID").equals(userid) || cb.GetCookie("MEM_INFO","USER_GROUP").equals("1") || cb.GetCookie("MEM_INFO","USER_GROUP").equals("2"))) {
						delBtnFlag = true;
					}

					if(shopcode.equals("0")){
						username = username;
					}else {
						username = username.replaceAll("(?<=.{2}).", "*");
					}

					if(userid.length() > 2){
						userid = userid.substring(0, 2)+"****";
					}else {
						userid = userid+"****";
					}
					//에누리 회원 + SNS 회원이면 닉네임
					//나머지는 ID
					if(shopcode.equals("0") && is_sns){
						usernameView = username;
					}else {
						usernameView = userid;
					}
					if(title.trim().equals("") || title.trim().equals("null")){
						if(!contents.trim().equals("") && !contents.trim().equals("null")){
							titleView = contents;
							contentsView = contents;
						}else{
							titleView = "평점만 제공되는 상품평입니다.";
							contentsView = "평점만 제공되는 상품평입니다.";
						}
					}else{
						titleView = title;
						contentsView = contents;
					}
					if(gbldList.length == 1){		//하나만있음
						prev_idx = 0;
						next_idx = 0;
					}else if(gbldList.length==2){
						if(i==0){
							if(intListIdx==list_idx){ 	//처음에 같으면 처음 
								next_idx = list_idx+1;	//다음번호있음
							}else{
								next_idx = 0;			//다음번호없음 이전번호있음
								prev_idx = list_idx-1;
							}
						}else{	
							if(intListIdx==list_idx){ 	//처음에 같으면 처음 
								prev_idx = list_idx-1;
								next_idx = 0;	//다음번호있음
							}else{
								prev_idx = list_idx-1;
								next_idx = list_idx+1;	//다음번호있음
							}
						}
					}else{								//세개일경우 둘다있음
						next_idx = list_idx+1;
						prev_idx = list_idx-1;
					}
					JSONObject tmpObject = new JSONObject();
					JSONArray addlist =  gbs.getPhoto_ImageList(gbld.getShop_code(), gbld.getBbsid());
					tmpObject.put("modelno", modelno);
					tmpObject.put("no",no);
					tmpObject.put("username",usernameView);
					tmpObject.put("regdate",regdate);
					tmpObject.put("imgsrv_flg",imgsrv_flg);
					tmpObject.put("imgurl_org",imgurl_org.replaceAll("\\\\", "/"));
					tmpObject.put("shopcode",shopcode);
					tmpObject.put("shopname",shopname);
					tmpObject.put("title",titleView);
					tmpObject.put("contents",contentsView);
					tmpObject.put("point",point);
					tmpObject.put("delbtnflag",delBtnFlag);
					tmpObject.put("imglist",addlist);
					tmpObject.put("list_idx",list_idx);
					tmpObject.put("next_idx",next_idx);
					tmpObject.put("prev_idx",prev_idx);
					detailJSONArray.put(tmpObject);
				}
			}
			ret = new JsonResponse(true).setData(detailJSONArray).setTotal(iBbs_num);
		}else{
			ret = new JsonResponse(false).setData(detailJSONArray);
		}
		out.println(ret.toString());
	} else if ( pType.equals("PT") ) {
		//이미지 500
		Goods_BBS_List_Data[] goods_BBS_List_Data = null;
		JSONArray imageJSONObject = new JSONArray();
		goods_BBS_List_Data = gbs.Goods_BBS_List_Photo(iModelno, iGroupModelno);

		int iBbs_num = gbs.Goods_BBS_List_Photo_Cnt(iModelno, iGroupModelno);

		if (goods_BBS_List_Data != null) {
			for(int i = 0; i < goods_BBS_List_Data.length; i++) {
				JSONObject tmpObject = new JSONObject();
				int no = goods_BBS_List_Data[i].getNo();
				int list_idx = goods_BBS_List_Data[i].getList_idx();
				String imgurl_org = goods_BBS_List_Data[i].getImgurl_org().replaceAll("\\\\", "/");
				tmpObject.put("no",no);
				tmpObject.put("list_idx",list_idx);
				tmpObject.put("imgurl_org",imgurl_org);
				imageJSONObject.put(tmpObject);
			}
			rtnJSONObject.put("imageList",imageJSONObject);
			ret = new JsonResponse(true).setData(imageJSONObject).setTotal(iBbs_num);
		}else{
			ret = new JsonResponse(false).setData(imageJSONObject);
		}
		out.println(ret.toString());
	}
/*
 else if ( pType.equals("SGD") ) {		// SNS 로그인 시 삭제 API 추가 : SNS 사용자는 비번 체크를 진행 하지 않는다.
		//소셜 상품평 삭제 ([PC/M] VIP)
		String sSnsType = cb.GetCookie("MEM_INFO","SNSTYPE");

		if (!sSnsType.isEmpty() && (sSnsType.equals("K") || sSnsType.equals("N")) ) {

			int del_no = ChkNull.chkInt(request.getParameter("del_no"));

			/*************************************************************************
				SNS 사용자에 대한 사용자 정보를 DB를 통해서 다시 체크 한다.
				패스워드가 없으므로 쿠키값만 가지고 의존하지 않음.
			*************************************************************************
			boolean validSsnUser = Sns_Login.bSnsMember(sUserId);

			//비밀번호 체크
			int deleteRtn = 0;
			String userid = "";
			String usernm = "";
			String strIsPassCaps = "";
			String errCode = "";

			Goods_BBS_List_Data gb_data = gbs.Goods_BBS_One(iModelno, del_no, sUserId);

			if(gb_data==null) {
				deleteRtn = 0;
			} else {
				userid = gb_data.getUserid();
				usernm = gb_data.getUsernm();

				if (validSsnUser) {
					deleteRtn = gbs.Goods_BBS_Delete(iModelno, del_no, ip, sUserId, usernmSet);
					Know_box_Proc.update_Kbnum(iModelno, -1);
				} else {
					deleteRtn = 0;
				}
			}

			out.println("{");
			out.println("	\"flag\":\""+(deleteRtn > 0 ? true : false)+"\" ");
			out.println("}");
		} else {
			out.println("{");
			out.println("	\"flag\":\""+ false +"\" ");
			out.println("}");
		}

	}
*/
%>
