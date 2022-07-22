<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="com.enuri.bean.main.brandplacement.DBDataTable"%>
<%@ page import="com.enuri.util.seed.Seed_Proc"%>
<%@ page import="com.enuri.bean.main.brandplacement.DBWrap"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.RSAMains"%>
<%@ page import="com.enuri.bean.mobile.CRSA"%>
<%@ page import="com.enuri.util.date.DateUtil"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ include file="/mobiledepart/include/common.jsp"%>
<%@ page import="com.enuri.api.Pricelist_Api"%>
<%@ page import="com.enuri.bean.mobile.depart.Save_Goods_Proc"%>
<%@ page import="com.enuri.bean.mobile.depart.Save_Goods_Data"%>
<%@ page import="com.enuri.bean.main.Save_PriceList_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@ page import="com.enuri.bean.main.depart.Depart_Goods_Proc"%>
<%@ page import="com.enuri.bean.main.depart.Depart_Goods_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Know_termdic_title_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Know_termdic_title_Data"%>
<jsp:useBean id="Searchfunction" class="com.enuri.bean.search.SearchFunction" />
<jsp:useBean id="Know_termdic_title_Proc" class="Know_termdic_title_Proc" scope="page" />
<jsp:useBean id="Pricelist_Proc" class="com.enuri.bean.main.Pricelist_Proc" scope="page" />
<jsp:useBean id="Mobile_Push_Proc" class="com.enuri.bean.mobile.Mobile_Push_Proc" scope="page" />
<%@ page import="com.enuri.bean.mobile.FactoryBrand_Proc"%>
<%@ page import="com.enuri.bean.mobile.FactoryBrand_Data"%>
<jsp:useBean id="FactoryBrand_Proc" class="FactoryBrand_Proc" scope="page" />
<%@ include file="/include/IncSearch.jsp"%>
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%
CRSA rsa = new CRSA();

//구분자 = Part + code
//		Part  : A ( Aos) , I ( Ios )
//		code : 1001 ( core )
//appid , uuid,id,t1
//ti 풀어서 넘어온 uuid 랑 pd에 있는 uuid가 동일하면 t1을 새로 말아서 던져줌.

//Ios sample
//appid=I1001&time=20160616165512&uuid=98BA2085-AFB7-45AA-BB21-E9032DDFB44F&id=en724&pw=en0724
//String strSample = "QPjisj5L_hJrzKwaNZOeoP-jxgVKPVWKlfPc8IXnSV-_mnNxQ88ZTnzFvMnjOnX3c8Sm9ypaxemKXav3rhtqXIbKkz0BLvNg7fbehC4VmQq597MUFh8krE-ztwDuWOqYdczKUlmYNai7RGch3HV8UWf38LsT1rJS8m8cE6rMFrQ=";

String strT1 = ChkNull.chkStr(request.getParameter("t1"));
String strRSA = ChkNull.chkStr(request.getParameter("pd"));

String deviceType = ChkNull.chkStr(request.getParameter("deviceType"), "");

//String strT1 = "c441kLn_MkWFS0u9Fdx4CD6dN5xEAuSqs3mO2tYoerOg6dmU9b2oStbqHP5Kla1pMSuVwWg-7heSADtiNBVGDZd-L4zw_IfbAgr28pQ05YBk1dvheoqtypvTLymD6_l-srucoL92WWVyhe2tXLdwiKIbYrsnOGYln8ah03lK1ss=";
//String strRSA = "CZrAfC9T5iUni8qaNHxB7lPJa4FCq6tqrOMVirbnZRiqWNd9SThaO1EwcS0VMHKBopYlXC_X1Yt6fBOwjALQg0Oj9GdSSqh8dLnR2RfIXJI-Mnfphv2Ltg-RJfKEwrXq70lkRb_e0lqjiVlZVTKwvdqyeeQRSqZ-xZ4VXuxNVa0=";

strT1 = strT1.replaceAll("[-]","+");
strT1 = strT1.replaceAll("[_]","/");

boolean blCheck_t1 = false;
boolean blCheck_pd = false;

String strT1_fdate = "";
String strT1_enuriid = "";
String strT1_userdata = "";

String sApp_type 				= "";
String sTime		 			= "";
String sUuid						= "";
String sEnuri_id				= "";

String strFdate = "";

String strR_id = "";
String strT1_Rsa = "";
String strR_code = "";
String strR_msg = "";

String browser = request.getHeader("User-Agent");

String strApp_type = "";

if((browser+"").indexOf("Darwin") > -1){
strApp_type = "I";
}else{
strApp_type = "A";
}

if(!strT1.equals("")){
	//t1에 값이 있으면, 값 해독후 판단 진행
	String strT1_rsa = rsa.decryptByPrivate_mobile(strT1);

	if(strT1_rsa != null && !strT1_rsa.equals("")){
		String[] arrT1_rsa = strT1_rsa.split("[|][|]");
		
		if(arrT1_rsa != null && arrT1_rsa.length > 0){
			for(int i = 0; i < arrT1_rsa.length; i++){
				//out.println("arrT1_rsa["+ i +"]==="+arrT1_rsa[i] + "<br>");
				if(i == 1){
					strT1_fdate = arrT1_rsa[i];
				}else if(i == 2){
					strT1_enuriid  = arrT1_rsa[i];
				}else if(i == 3){
					strT1_userdata  = arrT1_rsa[i];
				}
			}
			
			blCheck_t1 = true;
		}
	}
}

if(blCheck_t1){
	Mobile_Push_Proc mobile_push_proc = new Mobile_Push_Proc();

	int vReturn = 0;

	boolean vTrue = false;

	String strRSA2 = ""; 
 
	if(strRSA != null && !strRSA.equals("")){
		strRSA = strRSA.replaceAll("[-]","+");
		strRSA = strRSA.replaceAll("[_]","/");
		
		if(strRSA.length() > 0){ 	  
			strRSA2	= mobile_push_proc.longdecrypt3(strRSA);   //RSA 타는것
		}
	
		if(strRSA2 != null && !strRSA2.equals("")){
			if(strRSA2.indexOf("appid") > -1 && strRSA2.indexOf("time") > -1 && strRSA2.indexOf("uuid") > -1 && strRSA2.indexOf("id") > -1){
				vTrue = true;
			}   
			
			if(vTrue){
			 	String astrRSA[] = strRSA2.split("&");
			 	
				int intRSACnt = astrRSA.length; 
			
				if(vTrue && strRSA2.length() > 0 && intRSACnt == 4){
			
					for (int i=0 ; i<intRSACnt ; i++){
						if(i == 0)	 sApp_type 		= astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length()).trim();
						if(i == 1)	 sTime 				= astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length()).trim();
						if(i == 2)	 sUuid 				= astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length()).trim();
						if(i == 3)	 sEnuri_id 			= astrRSA[i].substring(astrRSA[i].indexOf("=") + 1, astrRSA[i].length()).trim();
					}
					
					//out.println("sApp_type>>"+sApp_type +"<br>");
					//out.println("sTime>>"+sTime +"<br>");
					//out.println("sUuid>>>"+sUuid +"<br>");
					//out.println("sEnuri_id>>>"+sEnuri_id +"<br>");
					blCheck_pd = true;
				}
			}
		}
	}
}

boolean blOk = false; //전부 맞으면 true;
if(blCheck_t1 && blCheck_pd){
	if(strT1_userdata.trim().equals(sUuid.trim())){
		blOk = true;
	}
}

if(blOk){
	
%>
{
<%
// 데이터의 타입
// 보여줘야할 데이터를 구분해서 필요없는 것을 뺌
// 최근본 찜 목록에서는 모든 데이터가 필요하고 목록이나 메인의 간략 보기에는 단순 정보만 필요
// dataType이 2인 경우 이미지와 상품번호만 노출
int dataType = Integer.parseInt(ChkNull.chkStr(request.getParameter("dataType"), "1"));
int appType = Integer.parseInt(ChkNull.chkStr(request.getParameter("appType"), "1"));

String pageString = ChkNull.chkStr(request.getParameter("pageNum"),"1");
if(pageString.equals("NaN")) pageString = "1"; 

// 페이징 관련 추가
int pageNum = 1;
int pageGap = 50;
int totalCnt = 0;
int allTotalCnt = 0;
int pageStart = (pageNum-1) * pageGap + 1;
int pageEnd = pageStart + pageGap - 1;
int pageMax = 1;

String listTypeStr = ChkNull.chkStr(request.getParameter("listType"), "1");
String folder_idStr = ChkNull.chkStr(request.getParameter("folder_id"), "0");
String paramFolder = ChkNull.chkStr(request.getParameter("folder"), "all");
String strUserId = sEnuri_id;

String mailYN = ChkNull.chkStr(request.getParameter("mailYN"), "");
String goodsNumList = ChkNull.chkStr(request.getParameter("goodsNumList"), "");

// listType:1 최근본
// listType:2 찜
// listType:9 검색에서 최근본 보기
int listType = 1;
int folder_id = 0;
try {
	listType = Integer.parseInt(listTypeStr);
} catch(Exception e) {}
try {
	folder_id = Integer.parseInt(folder_idStr);
} catch(Exception e) {}

int goodsCnt = 0;
long priceSum = 0;

Save_Goods_Proc save_goods_proc = new Save_Goods_Proc();
Goods_Data[] goods_data = null;
Save_Goods_Data[] save_goods_folder = null;
// 찜 상품일 때 폴더 정보 읽어옴
totalCnt = save_goods_proc.getSaveGoodListCnt(strUserId, folder_id);

allTotalCnt = save_goods_proc.getSaveGoodListCnt(strUserId, 0);

pageMax = (int)Math.ceil((double)totalCnt/pageGap);
//goods_data = save_goods_proc.getSaveGoodListPage(strUserId, folder_id, pageNum, pageGap);
goods_data = save_goods_proc.getSaveGoodList_app(strUserId);

int totalLength = 0;


totalLength = totalCnt;

out.println("	\"myGoodsTotalCnt\":\""+totalLength+"\",");
out.println("	\"myGoodsAllTotalCnt\":\""+allTotalCnt+"\",");

if(goods_data!=null && goods_data.length>0) {
	String strSearckKeywordSynonym = "";

	out.println("	\"goodsList\": [");
	boolean listFirstPrintFlag = false;
	for(int i=0; i<goods_data.length; i++) {

		int modelno = goods_data[i].getModelno();
		long p_pl_no = goods_data[i].getP_pl_no();
		String ca_code = goods_data[i].getCa_code();
		String modelnm = goods_data[i].getModelnm();
		long minprice = goods_data[i].getMinprice3();
		int sale_cnt = goods_data[i].getSale_cnt();
		String factory = goods_data[i].getFactory();
		String imgchk = goods_data[i].getImgchk();
		String p_imgurl = goods_data[i].getP_imgurl();
		int gb1_no = goods_data[i].getGb1_no();
		String url1 = goods_data[i].getUrl1();
		String p_imgurlflag = goods_data[i].getP_imgurlflag();
		String smallImageUrl = ImageUtil.getImageSrc(CutStr.cutStr(ca_code,4), modelno, imgchk, p_pl_no, p_imgurl, p_imgurlflag);
		String middleImageUrl = "";
		//String strFolder_id = goods_data[i].getFolder_id();
		String strFactory = ChkNull.chkStr(goods_data[i].getFactory());
		String strBrand = ChkNull.chkStr(goods_data[i].getBrand());
		int mallcnt =  goods_data[i].getMallcnt3();
		
		// 출시일
		String c_date = goods_data[i].getC_date();
		c_date = CutStr.cutStr(c_date,10);
		String c_dateStr = c_date;
		
		if(c_dateStr.length()==10) {
			java.util.Calendar calend = java.util.Calendar.getInstance();
			String nowYear = calend.get(cal.YEAR) + "";

			// 현재 년도랑 같을 경우에만  년, 월로 표시
			if(c_dateStr.substring(0, 4).equals(nowYear)) {
				c_dateStr = c_dateStr.substring(2, 7);
				c_dateStr = ReplaceStr.replace(c_dateStr, "-0", "-");
			} else {
				c_dateStr = c_dateStr.substring(2, 4);
			}
		}
		if(c_dateStr.indexOf("-")>-1) {
			c_dateStr = "'" + ReplaceStr.replace(c_dateStr, "-", "년 ") + "월";
		} else {
			c_dateStr = "'" + c_dateStr+ "년";
		}
		
		
		if(modelno > 0){

			String strModelnmText[] = getModel_FBN(ca_code, modelnm, strFactory ,strBrand);
			String strNm_factory = toJS2(strModelnmText[1]);
			String strNm_brand   = toJS2(strModelnmText[2]); 
			String strNm_model  = toJS2(strModelnmText[0]);

			if(!ca_code.equals("93")){ 
				if(strNm_model.lastIndexOf("[")>0){ 
					strNm_model = strNm_model.substring(0,strNm_model.lastIndexOf("["));
				} 
			}
			
			String modelName = strNm_factory + " "+ strNm_brand+ " "+ strNm_model; 
			modelnm = toJS2(modelName.replace("  "," ").trim());
		
		}

		modelnm = ReplaceStr.replace(modelnm,"[일반]","");

		// 모델명과 조건명[ 사이 한칸 공백
		modelnm = ReplaceStr.replace(modelnm, "[", " [");

		if(modelnm.length()>0) {
			if(listFirstPrintFlag) out.print(",\r\n");

			// 금액의 총합을 구함
			priceSum += minprice;
			
			// 가격 정보 보여주기
			String minPriceText = "";
			if(mallcnt==1 && DateUtil.getDaysBetween(c_date,DateStr.nowStr())>0) {
				minPriceText = "미정";
				mallcnt = 0;
			//} else if((goods_data[i].getOpenexpectflag().equals("1") || DateUtil.getDaysBetween(c_date,DateStr.nowStr())>0 ) && goods_data[i].getIsgroup() != 1) {
			//	minPriceText = "미정";
			//	mallcnt = 0;
			} else {
				if ((CutStr.cutStr(ca_code,4).equals("0304") || CutStr.cutStr(ca_code,4).equals("0305") || CutStr.cutStr(ca_code,4).equals("0353")) && minprice==0){
					minPriceText = "클릭";
					if(deviceType.equals("m") && goods_data[i].getMallcnt3()==0){
						minPriceText = "별도확인";
					}
				}
			}

			if(minPriceText.length()==0 && minprice==0) {
				minPriceText = "단종/품절";
			}
			if(minPriceText.equals("미정")) {
				c_dateStr = "출시예정";
				mallcnt = 0; 
			} else {
				if(p_pl_no==0) {
					c_dateStr += " 출시";
				}
			}
			if(c_dateStr.indexOf("예정") > -1){
				minPriceText = "출시예정";
				c_dateStr = "출시예정"; 
			}
			
			out.println("			{");
			/* out.println("			\"modelno\":\""+modelno+"\", ");
			out.println("			\"p_pl_no\":\""+p_pl_no+"\", ");
			out.println("			\"pList_modelno\":\""+goods_data[i].getModelno_group()+"\", "); */
			
			out.println("			\"modelno\":\""+modelno+"\", ");
			out.println("			\"p_pl_no\":\""+p_pl_no+"\", ");
			out.println("			\"price\":\""+minprice+"\", ");
			out.println("			\"modelnm\":\""+modelnm+"\", ");
			out.println("			\"imgurl\":\""+p_imgurl+"\", ");
			out.println("			\"ca_code\":\""+ca_code+"\", ");
			out.println("			\"c_date\":\""+c_date+"\", ");
			out.println("			\"smallImageUrl\":\""+smallImageUrl+"\", ");
			out.println("			\"pList_modelno\":\""+goods_data[i].getModelno_group()+"\", ");
			out.println("			\"folder_id\":\""+goods_data[i].getFolder_id()+"\", ");
			out.println("			\"reg_date\":\""+goods_data[i].getModdate()+"\", ");
			out.println("			\"c_date\":\""+c_date+"\", ");
			out.println("			\"c_dateStr\":\""+c_dateStr+"\", ");
			out.println("			\"minPriceText\":\""+minPriceText+"\" ");
			out.println("			}");
				
			goodsCnt++;
			listFirstPrintFlag = true;
		}
	}
	out.println("\r\n	], ");
}
out.println("	\"goodsCnt\":\""+goodsCnt+"\",");
out.println("	\"priceSum\":\""+FmtStr.moneyFormat(priceSum+"")+"\", ");




if(strUserId.length()>0) {
	save_goods_folder = save_goods_proc.getSaveFolderList(strUserId, true);

	if(save_goods_folder!=null && save_goods_folder.length>0) {
out.println("	\"folderCnt\":\""+save_goods_folder.length+"\",");
out.println("	\"folderList\": [");
for(int i=0; i<save_goods_folder.length; i++) {
	if(save_goods_folder[i].getFolder_id()>0) {
		if(i>0) out.print(",\r\n");
		out.println("			{");
		out.println("			\"folder_id\":\""+save_goods_folder[i].getFolder_id()+"\", ");
		out.println("			\"folder_name\":\""+save_goods_folder[i].getFolder_name()+"\", ");
		out.println("			\"folder_cnt\":\""+save_goods_folder[i].getFolderItemCnt()+"\" ");
		out.print("			}");
	}
}
out.println("\r\n	]");
	}
}
%>}
<%}%>

