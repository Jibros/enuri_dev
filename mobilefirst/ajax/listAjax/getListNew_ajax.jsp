<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.util.http.*"%>
<%@ include file="/include/IncSearch.jsp"%>
<%@ page import="com.enuri.bean.main.Mobile_Category_Proc"%>
<%@ page import="com.enuri.bean.main.Mobile_Category_Data"%>
<%@ page import="com.enuri.bean.main.Goods_copycate_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_copycate_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Search"%>
<%@ page import="com.enuri.bean.main.Mobile_Goods"%>
<%@ page import="com.enuri.bean.knowbox.Know_termdic_title_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Know_termdic_title_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@ page import="com.enuri.bean.log.Log_main_Proc"%>
<%@ page import="com.enuri.bean.log.Log_main_Data"%>
<%@ page import="com.enuri.bean.mobile.FactoryBrand_Data"%>
<%@ page import="com.enuri.bean.mobile.FactoryBrand_Proc"%>
<%@ page import="com.enuri.util.common.Ca_Ad_Keyword"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Pricelist_Proc"%>
<jsp:useBean id="Mobile_Pricelist_Proc" class="com.enuri.bean.mobile.Mobile_Pricelist_Proc" scope="page" />

<jsp:useBean id="Goods_Proc" class="com.enuri.bean.main.Goods_Proc" scope="page" />
<jsp:useBean id="Goods_Search" class="com.enuri.bean.main.Goods_Search" scope="page" /> 
<jsp:useBean id="Know_termdic_title_Proc" class="Know_termdic_title_Proc" scope="page" />
<jsp:useBean id="Searchfunction" class="com.enuri.bean.search.SearchFunction" />
<jsp:useBean id="Pricelist_Proc" class="com.enuri.bean.main.Pricelist_Proc" scope="page" />
<jsp:useBean id="Model_log_Proc" class="com.enuri.bean.logdata.Model_log_Proc" scope="page" />
<jsp:useBean id="FactoryBrand_Proc" class="com.enuri.bean.mobile.FactoryBrand_Proc" scope="page" />
<jsp:useBean id="Ca_Ad_Keyword" class="com.enuri.util.common.Ca_Ad_Keyword" scope="page" />
<%
	String strCate = ChkNull.chkStr(request.getParameter("cate"),"");
	String strF = ChkNull.chkStr(request.getParameter("f"),"");	
	String strPCate = "";
	//System.out.println("strCate==="+strCate);
	if(!strF.equals("1")){
		//strCate = "0502";
		/*모바일 분류 히트수*/	
		Log_main_Proc log_main_proc2 = new Log_main_Proc();
		Log_main_Data log_main_data2 = new Log_main_Data();
		log_main_data2.setLm_kind(6811); 
		log_main_data2.setLm_userid("");
		log_main_data2.setLm_userip(request.getRemoteAddr());
		log_main_data2.setLm_category(strCate);
		log_main_data2.setLm_modelno(0);
		log_main_data2.setLm_vcode(0);	
		log_main_proc2.Log_main_Insert(log_main_data2);
	}
	
	String strKeyword = ChkNull.chkStr(request.getParameter("keyword"),"");//키워드

	String M_Ip = request.getRemoteAddr();

	String strQrcode = ChkNull.chkStr(request.getParameter("_qr"),"");	  
	String strApp = ChkNull.chkStr(request.getParameter("app"),"");	 
	String strTodayFlag = ChkNull.chkStr(request.getParameter("todayFlag"),"");	
	String strSimpleFlag = ChkNull.chkStr(request.getParameter("simpleFlag"),""); 
	String strPageType = ChkNull.chkStr(request.getParameter("pagetype"),"list");
	String listType = "";
	String strReferer = ChkNull.chkStr(request.getHeader("REFERER"),"");
	HttpSession Mobilesession = request.getSession(true);
	String strEnuriApp = ChkNull.chkStr((String)Mobilesession.getAttribute("enuriApp"),"");
	if(strEnuriApp.equals("Y")){
		strApp = "Y"; 
	}	
	String strFromNaver = ChkNull.chkStr((String)Mobilesession.getAttribute("fromNaver"),"");
	
	String strCate2 = "";
	String strCate4 = ""; 
	String strCate6 = "";
	String strCate8 = "";
	
	if(strCate.length()>=8){
		strCate8 = CutStr.cutStr(strCate,8);	
		strCate =  CutStr.cutStr(strCate,8);	
	}
	if(strCate.length()>=6){
		strCate6 = CutStr.cutStr(strCate,6);
		if(strCate.length() < 8){
			strCate =  CutStr.cutStr(strCate,6);	
		}
	}
	if(strCate.length()>=4){ 
		strCate4 = CutStr.cutStr(strCate,4);
		if(strCate.length() < 6){
			strCate =  CutStr.cutStr(strCate,4);	
		}
	}		
	if(strCate.length()>=2){
		strCate2 = CutStr.cutStr(strCate,2);
		if(strCate.length() < 4){
			strCate =  CutStr.cutStr(strCate,2);	
		}
	}	
	if(strCate.equals("")){
		strCate = "0404";
	}
	 
	String strKey = ChkNull.chkStr(request.getParameter("key"),"popular DESC");		

	String strModelNo_Group=""; //검색엔진에서 가져온 modelno의 집합
	String strPlNos = "";		//추가상품검색결과 Pl_no
	String strSpecs = ChkNull.chkStr(request.getParameter("spec"));
	String strSelectedSpec = ChkNull.chkStr(request.getParameter("sel_spec"));
	String strCondi=ChkNull.chkStr(request.getParameter("condi"),"");
	String order_by = "popular DESC";		
		 
	String strGetFactory = ChkNull.chkStr(request.getParameter("factory"));
	strGetFactory = ReplaceStr.replace(strGetFactory,"+"," ");
	String astrGetFactory[] = strGetFactory.split("\\,");

	String strGetShop = ChkNull.chkStr(request.getParameter("shop_code"),"");
	strGetShop = ReplaceStr.replace(strGetShop,"+"," ");
	String[] astrGetShop = strGetShop.split("\\,");	 
	
	String strSearchKind = ChkNull.chkStr(request.getParameter("searchkind"),"");//(1:에누리,2:추가검색)

	String strSKeyword = ChkNull.chkStr(request.getParameter("skeyword"),"");//분류검색어
	String strInKeyword = ChkNull.chkStr(request.getParameter("in_keyword"),"");//키워드
	String strOrgKeyword = ChkNull.chkStr(request.getParameter("keyword"),"");//키워드	 
	String strStartPrice = ChkNull.chkStr(request.getParameter("start_price"));
	String strEndPrice = ChkNull.chkStr(request.getParameter("end_price"));	
	String strMPrice = ChkNull.chkStr(request.getParameter("m_price"));
	String strBest = ChkNull.chkStr(request.getParameter("best"));
	String strAndEx = ChkNull.chkStr(request.getParameter("andEx")); //안드로이드 상품창에서 돌아가기 할때 리스팅 제대로 안됨.... 개선을 위해...
	 
	if (CutStr.cutStr(strKeyword,2).equals("%u")){
		strKeyword = CvtStr.unescape(strKeyword);
	}
	if (strKeyword.indexOf("%u") >= 0 || strKeyword.indexOf("%20") >= 0){
		strKeyword = CvtStr.unescape(strKeyword);
		
	}else if(strKeyword.indexOf("%25") >= 0){
		strKeyword = CvtStr.unescape(CvtStr.unescape(strKeyword));
	}
	
	if (CutStr.cutStr(strInKeyword,2).equals("%u")){
		strInKeyword = CvtStr.unescape(strInKeyword);
	}
	if (strInKeyword.indexOf("%u") >= 0 || strInKeyword.indexOf("%20") >= 0){
		strInKeyword = CvtStr.unescape(strInKeyword);
		
	}else if(strInKeyword.indexOf("%25") >= 0){
		strInKeyword = CvtStr.unescape(CvtStr.unescape(strInKeyword));
	}
	
	//검색관련 신규 변수 선언
	String strSearchKeyword = ""; 
	String strCopyCate = "";
	String strSeperatedKeyword = "";
	if (strStartPrice.trim().length() > 0 && strEndPrice.trim().length() > 0 ){
		strMPrice = strStartPrice + "~" + strEndPrice;
	} 	 

	//동의어 찾기
	if (strKeyword.trim().length() > 0 || isAddSearchCate(strCate)){
		strSeperatedKeyword = seperate(strKeyword);
		strSearchKeyword = Searchfunction.removeExceptionKeyword(strSeperatedKeyword);
		if (bEnuriSynonym){
			strSearchKeyword = Searchfunction.getSynonym(strSearchKeyword).trim();
		}
		strCopyCate = Searchfunction.getCopyCate(strCate);	
	}

	 
	int nPageCntCnt = 20; //'page cnt
	int cPage = ChkNull.chkInt(request.getParameter("page"),1);
	int nPageSize=ChkNull.chkInt(request.getParameter("pagesize"),0); //'목록수
	int iCnt = ChkNull.chkInt(request.getParameter("cnt"),20);
	int iEndNum = ChkNull.chkInt(request.getParameter("endnum"),20);	
	iEndNum = cPage*20; 
	
	//int iPageGroup = ChkNull.chkInt(request.getParameter("pagegroup"),1);	
	int intTotRsCnt=0; //전체 목록수		
	int intRsCnt=0;    //불러온 목록수	
	//int intPageCount=0;
	//int intTotalSize=0;
	//int intPageMod=0;	
 
	if( strBest.equals("Y") ){ 	//best_list.jsp 에서는 30개 리스팅 
		nPageCntCnt = 30; //'page cnt
		iCnt = 30;
		iEndNum = 30;	 
	}
	if(strAndEx.equals("Y")){
		iEndNum = cPage*20; 
		cPage = 1; 
		nPageCntCnt =  iEndNum;
		iCnt = iEndNum;
	}   
	// 마음열기 INFO AD 모델저장
	String[] arrInfoAdModelNo = null;

	//int intInfoAdModelNo = 0;
	int intInfoAdListCnt = 0;
	String strInfoadModels = "";
	
	Long[] lngPricelistSearch = null;
	Long[] lngPricelist = null;
	int[][] intPriceRangeAndCnt = null;
	
	int i=0;
	int j=0; 
	int intHot=0;
	int intHotCnt=0;
	int intHotNo=0;
	int intHotFactoryCnt=-1;
	int intFactoryCnt=-1;
	
	boolean bCondiCheck = false;
	boolean bMountCheck = false;
	boolean bSellCause = false;
	boolean bCountCause = false;
	boolean bInstallCause = false;
	boolean bBuyCause = false;
	
	String[] arrCondi = null;
	if (strCondi.trim().length() > 0 ){
		arrCondi = strCondi.split("_");
	}	
	
	Goods_copycate_Proc goods_copycate_proc = new Goods_copycate_Proc();
	Goods_copycate_Data[] goods_copycate_data = goods_copycate_proc.Goods_copycate_Bind_List(strCate);

	Know_termdic_title_Data[] termdictitle_data = Know_termdic_title_Proc.getList_SpecSynonym(strCate4);
	
	Mobile_Goods goods_search = new Mobile_Goods();
	Goods_Data[] goods_data = null;		
   	Goods_Data[] goods_factory_data= null;	
   	Goods_Data[] goods_factory_hot_data= null;
   	Goods_Data[] goods_factory_hot_model_data = null;
	Goods_Data[] goods_condiname_data=null;
 	Goods_Data[] goods_all_group_data = null;  
 	
 	boolean bAdultKeyword = false;
 	
	int intEnuriCnt = 0;
	int intWebCnt = 0;

	%> 
	
<%@ include file="/include/IncAdultKeywordCheck_2010.jsp"%>
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%@ include file="/include/IncSponsorGoods_2010.jsp"%>
<%@ include file="/include/IncIsGoogleSearchCate_2010.jsp"%>
<%@ include file="/include/Inc_Order_Result_Category_2010.jsp"%>

<%

	HashMap hm = new HashMap();
	
	String strCopyCateQry = strCate;
	//if(strCopyCateQry.length() > 4){
	//	strCopyCateQry = strCopyCateQry.substring(0,4);
	//}
	if(strCopyCateQry.length() >= 6){
		strCopyCateQry = strCopyCateQry.substring(0,6); 
	}
	for(i=0; i<goods_copycate_data.length;i++){
		if(goods_copycate_data[i].getCa_sub_code().length() >=6){
			strCopyCateQry = strCopyCateQry + "," + goods_copycate_data[i].getCa_sub_code().substring(0,6);		
		} 
		//strCopyCateQry = strCopyCateQry + "," + goods_copycate_data[i].getCa_sub_code().substring(0,4);			
	}
	hm.put("ca_arr_code",strCopyCateQry);
	
	String strLCopyCateQry = CutStr.cutStr(strCate,2);
	for(i=0; i<goods_copycate_data.length;i++){
		if(strLCopyCateQry.indexOf(goods_copycate_data[i].getCa_sub_code().substring(0,2))==-1){
			//strLCopyCateQry=strLCopyCateQry+","+goods_copycate_data[i].getCa_sub_code().substring(0,2);
		}
	}
	hm.put("ca_arr_lcode", strLCopyCateQry); 
	hm.put("jobcode","0");

	//goods_data = Goods_Search.getNewGoodsList(1,100,hm);
	goods_data = Goods_Search.getNewGoodsList_Mobile(cPage,nPageCntCnt,hm);
	intTotRsCnt = Goods_Search.getTotal(); 
	 
%>

<%@ include file="/include/IncMoneyStyle_2010.jsp" %>
<%@ include file="/mobilefirst/ajax/listAjax/get_IncViewGoodsData.jsp" %>