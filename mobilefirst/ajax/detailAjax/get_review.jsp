<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="java.util.regex.*" %>
<%@ page import="com.enuri.bean.lsv2016.Goods_BBS_List_Data"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_BBS_2019"%>
<jsp:useBean id="Goods_BBS_Data" class="com.enuri.bean.main.Goods_BBS_Data" scope="page" />
<jsp:useBean id="Goods_BBS_Proc" class="com.enuri.bean.main.Goods_BBS_Proc" scope="page" />
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<jsp:useBean id="Goods_Proc" class="com.enuri.bean.main.Goods_Proc" scope="page" />
<%
	/*
	1. 예전 detail 호출 파일
	2. 22/05/31 아래로직 호출 되지 않도록 리턴 & 아래로직 주석처리 하여 반영(ksay33)
	*/
	if(1==1){
		return;
	} 
	
	int intModelno = ChkNull.chkInt(request.getParameter("modelno"),0);
	int iPageno = ChkNull.chkInt(request.getParameter("pageno"),1);
	int iPageSize = ChkNull.chkInt(request.getParameter("pagesize"),20);	//리뷰 요약은 페이지 갯수 3개로 던지면 OK
	int iTotalCnt = 0;
	int iListTotal = 0;
	int iPageCount = 0;
	int iPrevCnt = 0; 		//bbsno가 있을때 그글이 있는 페이지번호 찾아가기위해 
	int intPageCount=0; 
	
	if(iPageSize == 0){
		iPageSize = 20;
	}
	
	Goods_BBS_2019 gbs = new Goods_BBS_2019();
	Goods_BBS_List_Data[] pAryListTemp = null;
	Goods_BBS_List_Data[] pAryList = null;
	int iGroupModelno 		= gbs.getGroupModelno(intModelno);
	iTotalCnt = gbs.Goods_BBS_Cnt(intModelno,iGroupModelno);
	if(iTotalCnt>0) {
		pAryListTemp = gbs.Mini_Goods_BBS_List_new(intModelno,iGroupModelno, iPageno, iPageSize, "", "", 0, "");
	}
	String[] goodsInfoDateInfo = null;

	// 상품평을 읽어와서 저장 - 상품게시판에 상품평을 포함시킴
	int goodsInfoAddCnt = -1;
	int maxAryNum = 0;
	int tempCnt = 0;
	
	iListTotal = iTotalCnt;
	
	String cUserId = cb.GetCookie("MEM_INFO","USER_ID");

	if(pAryListTemp != null) {
		maxAryNum += pAryListTemp.length;
	}

	pAryList = new Goods_BBS_List_Data[maxAryNum];

	for(int i=0; i<pAryList.length; i++) {
		pAryList[i] = new Goods_BBS_List_Data();
		if(pAryListTemp!=null && tempCnt<pAryListTemp.length) {
			pAryList[i].setNo(pAryListTemp[tempCnt].getNo());
			pAryList[i].setModelno(pAryListTemp[tempCnt].getModelno());
			pAryList[i].setUsernm(pAryListTemp[tempCnt].getUsernm());
			pAryList[i].setTitle(pAryListTemp[tempCnt].getTitle());
			pAryList[i].setContents(pAryListTemp[tempCnt].getContents());
			pAryList[i].setRegdate(pAryListTemp[tempCnt].getRegdate());
			pAryList[i].setShop_code(pAryListTemp[tempCnt].getShop_code());
			pAryList[i].setUserid(pAryListTemp[tempCnt].getUserid());
			pAryList[i].setRecommend(pAryListTemp[tempCnt].getRecommend());
			pAryList[i].setPoint(pAryListTemp[tempCnt].getPoint());
			tempCnt++;
		}
	}

	if(iTotalCnt>0) {
		 if((iTotalCnt%iPageSize)!=0) {
		 	iPageCount = (iTotalCnt/iPageSize) +1;
	    } else {
	    	iPageCount = iTotalCnt/iPageSize;
	    }
	}

%>
{
<%
//try {

	if(pAryList != null && pAryList.length > 0) {
		int modelno1 = 0;
		int no = 0;
		int recommend = 0;
		String usernm = "";
		String ip = "";
		String pwd = "";
		String title = "";
		String contents = "";
		String regdate = "";
		String shop_code = "";
		String userid = "";
		String shop_name = "";
		int intPoint = 0;
		String strPoint = "";
		String strPoint_20 = "";
		
		int event_idx = 0;
		
		out.println("	\"reviewBody\": [");
			
		for(int i=0; i<pAryList.length; i++) {
			modelno1 = pAryList[i].getModelno();
			no = pAryList[i].getNo();
			usernm = pAryList[i].getUsernm();
			ip = pAryList[i].getIp();
			pwd = pAryList[i].getPwd();
			title = pAryList[i].getTitle();
			contents = pAryList[i].getContents();
			regdate = pAryList[i].getRegdate();
			shop_code = pAryList[i].getShop_code();
			userid = pAryList[i].getUserid();
			event_idx = pAryList[i].getEvent_idx();
			recommend = pAryList[i].getRecommend();
			regdate = regdate.replaceAll("\\.", "-");
			intPoint = pAryList[i].getPoint();
			
			if(intPoint > 0){
				strPoint = intPoint + "";
				strPoint_20 = (intPoint * 20) + "";
			}else{
				strPoint = "";
				strPoint_20 = "";
			}
	
			contents = contents.replaceAll("<a", "<ab");
			contents = contents.replaceAll("/a>", "/ab>");
			contents = contents.replaceAll("<u", "<ua");
			contents = contents.replaceAll("/u>", "/ua>");
			contents = contents.replaceAll("<A", "<ab");
			contents = contents.replaceAll("/A>", "/ab>");
			contents = contents.replaceAll("<U", "<ua");
			contents = contents.replaceAll("/U>", "/ua>");
			
			//태그제거
			contents = contents.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
			
			if(usernm.length()==0) usernm = userid;
			
			//if( usernm.length() > 3  && (shop_code.equals("90") || shop_code.equals("5910"))){
			//	usernm = usernm.substring(0,usernm.length()-3)+"***";
			//} 
			
			//제일 첫글자를 따와서 영문인지 한글인지 구분한 다음. 영문은 2자 뒤에 * 4개, 한글은 1자 뒤에 * 2개.
			boolean d = false;
			
			if(usernm.length() > 0){
				d = Pattern.matches("[ㄱ-ㅎㅏ-ㅣ가-힝]", usernm.substring(0,1));
			}else{
				//아이디가 없음 ㅡㅡ;;;;;;;;;;;
				usernm = "******";
			}
			
			if(d){
				//한글이면 홍** 해줌.
				usernm = usernm.substring(0,1) + "**";
			}else{
				//영문이면 ab**** 해줌.
				if(usernm.length() >2){
					usernm = usernm.substring(0,2) + "****";
				}else{
					usernm = usernm.substring(0,1) + "*****";
				}
			}
				
			shop_name = "";
			if(shop_code.equals("49")) shop_name = "롯데닷컴";
			if(shop_code.equals("55")) shop_name = "인터파크";
			if(shop_code.equals("4027")) shop_name = "옥션";
			if(shop_code.equals("536")) shop_name = "G마켓";
			if(shop_code.equals("5910")) shop_name = "11번가";
			if(shop_code.equals("90") || shop_code.equals("1750")) shop_name = "AKmall";
			if(shop_code.equals("75")) shop_name = "GS SHOP";
			if(shop_code.equals("57")) shop_name = "Hmall";
			if(shop_code.equals("47")) shop_name = "신세계몰";
			if(shop_code.equals("1878")) shop_name = "디앤샵";
			if(shop_code.equals("6547")) shop_name = "엘롯데";
			
			if(shop_code.equals("47")) shop_name = "신세계몰";
			if(shop_code.equals("374")) shop_name = "이마트몰";
			if(shop_code.equals("663")) shop_name = "롯데홈쇼핑";
			if(shop_code.equals("6665")) shop_name = "SSG.COM";
	
	
			if(shop_name.equals("")){
				shop_name = "에누리";
			}
			
			String strMyreply = "";
			//자기글 여부.
			if(cUserId.equals(userid)){
				strMyreply = "Y";
			}

			if(i>0) out.print("	,\r\n");
			out.println("	{ ");
			out.println("		\"no\":\""+ no +"\", ");
			out.println("		\"modelno1\":\""+ modelno1 +"\", ");
			out.println("		\"title\":\""+ toJS2(title) +"\", ");
			out.println("		\"content\":\""+ toJS2(contents) +"\", ");
			out.println("		\"shopname\":\""+ toJS2(shop_name) +"\", ");
			out.println("		\"username\":\""+ toJS2(usernm) +"\", ");
			out.println("		\"date\":\""+ toJS2(regdate) +"\", ");
			out.println("		\"myreply\":\""+ toJS2(strMyreply) +"\", ");
			out.println("		\"point\":\""+ toJS2(strPoint) +"\", ");
			out.println("		\"point_per\":\""+ toJS2(strPoint_20) +"\" ");
			out.println("	}");
		}
		out.println("	],");
		
		out.println("	\"reviewCount\":\""+ iTotalCnt +"\"  ");
	}


	//out.println(" \"modelno\": "+ intModelno +" ");
//} catch(Exception e) {
//}
%>
}