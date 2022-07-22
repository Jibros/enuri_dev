<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.util.common.Ca_Ad_Keyword"%>
<%@ page import="com.enuri.bean.main.Mobile_Category_Proc"%>
<%@ page import="com.enuri.bean.main.Mobile_Category_Data"%>
<%@ page import="com.enuri.bean.logdata.Model_log_Proc"%>
<%@ page import="com.enuri.bean.logdata.Model_log_Data"%>
<jsp:useBean id="Model_log_Proc" class="com.enuri.bean.logdata.Model_log_Proc" scope="page" />
<jsp:useBean id="Goods_Data" class="com.enuri.bean.main.Goods_Data" scope="page" />
<jsp:useBean id="Mobile_Category_Data" class="com.enuri.bean.main.Mobile_Category_Data" scope="page" />
<jsp:useBean id="Mobile_Goods_Proc" class="com.enuri.bean.mobile.Mobile_Goods_Proc" scope="page" />
<jsp:useBean id="Ca_Ad_Keyword" class="com.enuri.util.common.Ca_Ad_Keyword" scope="page" />
<%
	int intModelno = ChkNull.chkInt(request.getParameter("modelno"),0);
	String strTmp_modelnos = ChkNull.chkStr(request.getParameter("modelnos"),"");
	boolean blChk_group = false;
	
	if(strTmp_modelnos.indexOf(",") > -1){
		intModelno= Mobile_Goods_Proc.get_Minpricemodelno_group(strTmp_modelnos);	//그룹모델일때 기본정보들은 그 그룹에서 제일 최저가를 가진 모델이 대표가 됨.
		blChk_group = true;
	}
	
	String cUserId = cb.GetCookie("MEM_INFO","USER_ID");

	long lngMinprice,lngAvgprice,lngMaxprice,lngP_pl_no,lngTlc_min_prc,lngCash_min_prc;
	int intPopular,intSum_popular,intRefid,intKb_num,intMallcnt,intModelno_group;
	String strTlc_yn = "";
	String strCashMin_yn = "";
	String strModelnm,strFactory,strSpec,strC_date,strImgchk,strImgchk2,strImgchk3,strConstrain,strManual_link,strLinkserviceflag,strG_size,strFunc,strKeyword;
	String strJobcode,strModdate,strCondiname,strFactory_etc,strP_imgurl,strP_imgurl2,strP_imgurlflag,strBox_modelnm,strKeyword2;
	String strSpec_group = "";
	String strCa_code = "";
	String strCate = "";
	String strCate2 = "";
	String strCate4 = "";
	String strCate6 = "";
	String strCate8 = "";
	boolean blBigimg = true;
	
	String strCateName = "";
	
	String strImageurl_middle = "";
	String smallImgUrlFinder = "";
	
	Cookie[] carr = request.getCookies();
	String strAd_id = "";
	 
	try {
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("adid")){
		    	strAd_id = carr[i].getValue();
		    	break;
		    } 
		}
	} catch(Exception e) {
	}

	//2015.10.12. shwoo 추가
	String strBrand = "";
	String strView_modelnm = "";
%>
<%@ include file="/include/IncSponsorGoods_2010.jsp"%>
{
<%
/*
Modelno	모델번호
Modelnm	모델명
Factory	제조사
Spec	요약설명
C_date	등록일
Imgchk	이미지코드
Constrain	단종코드
Minprice	최저가
Avgprice	평균가
Maxprice	최고가
Popular	인기도
Sum_popular	그룹인기도
Refid	문의코드
Manual_link	설명서링크
Linkserviceflag	설명서서비스 유무
G_size	크기정보
Func	상세설명
Kb_num	지식통 글 개수
Keyword	검색키워드
Jobcode	작코드
Moddate	반영일
Mallcnt	몰 수
Condiname	조건명
Ca_code	분류코드
Factory_etc	혼합
P_pl_no	매칭 사용이미지 pl_no
P_imgurl	웹이미지
P_imgurl2	유사상품 웹이미지
P_imgurlflag	구분코드
Modelno_group	대표모델번호
Box_modelnm	대표모델명
Refermodelno	사용안함
Keyword2	카피문구

Spec_group		그룹 요약설명 (*추가 2014.11.26.)
*/
try {
	Goods_Data spec_view = null;
	if(blChk_group){
		spec_view = Mobile_Goods_Proc.Goods_One_Group(intModelno, strTmp_modelnos);
	}else{
		spec_view = Mobile_Goods_Proc.Goods_One_Top(intModelno);		
	}
	
	if(spec_view != null){
		strModelnm = spec_view.getModelnm();
		strFactory = spec_view.getFactory();
		strSpec = spec_view.getSpec();
		strC_date = spec_view.getC_date();
		strImgchk = spec_view.getImgchk();
		strImgchk2 = spec_view.getImgchk2();
		strImgchk3 = spec_view.getImgchk3();
		strConstrain = spec_view.getConstrain();
		lngMinprice = spec_view.getMinprice();
		lngAvgprice = spec_view.getAvgprice();
		lngMaxprice = spec_view.getMaxprice();
		intPopular = spec_view.getPopular();
		intSum_popular = spec_view.getSum_popular();
		intRefid = spec_view.getRefid();
		strManual_link = spec_view.getManual_link();
		strLinkserviceflag = spec_view.getLinkserviceflag();
		strG_size = spec_view.getG_size();
		strFunc = spec_view.getFunc();
		intKb_num = spec_view.getKb_num();
		strKeyword = spec_view.getKeyword();
		strJobcode = spec_view.getJobcode();
		strModdate = spec_view.getModdate();
		intMallcnt = spec_view.getMallcnt();
		strCondiname = spec_view.getCondiname();
		strCa_code = spec_view.getCa_code();
		strFactory_etc = spec_view.getFactory_etc();
		lngP_pl_no = spec_view.getP_pl_no();
		strP_imgurl = spec_view.getP_imgurl();
		strP_imgurl2 = spec_view.getP_imgurl2();
		strP_imgurlflag = spec_view.getP_imgurlflag();
		intModelno_group = spec_view.getModelno_group();
		strBox_modelnm = spec_view.getBox_modelnm();
		strKeyword2 = spec_view.getKeyword2();
		strBrand = spec_view.getBrand();
		lngTlc_min_prc = spec_view.getTlc_min_prc();
		lngCash_min_prc = spec_view.getCash_min_prc();
		//모델명 변경 2015.10.12.
		String[] strModelno_new = getModel_FBN(strCa_code, strModelnm, strFactory, strBrand);
		strView_modelnm = strModelno_new[1] + " "+ strModelno_new[2] + " "+ strModelno_new[0];
		strView_modelnm = strView_modelnm.replace("  "," ");

		strSpec_group = spec_view.getSpec_group();
		
		if(strCa_code.length() > 0){
			strCate2 = strCa_code.substring(0,2);
		}
		if(strCa_code.length() > 2){
			strCate4 = strCa_code.substring(0,4);
		}
		if(strCa_code.length() > 4){
			strCate6 = strCa_code.substring(0,6);
		}
		if(strCa_code.length() > 7){
			strCate8 = strCa_code.substring(0,8);
		}
		//System.out.println("strCate2>>"+strCate2);
		//상품창에 맞게 변형후 JSON
		//모델명
		if(!strCate2.equals("93")){ 
			if(strView_modelnm.lastIndexOf("[")>0){
				strView_modelnm = strView_modelnm.substring(0,strView_modelnm.lastIndexOf("["));
			}
		}else{
			//if(strModelnm.indexOf("_") > -1){
			//	strModelnm = strModelnm.substring(0,strModelnm.lastIndexOf("_"));
			//}
		} 
		//출시일
		if(!strCate2.equals("15")){
			if (DateUtil.RtnDateComment(strC_date,"2010_list","").equals("예정")){
				strC_date = "출시예정";
			}else{
				strC_date = "'"+strC_date.substring(2,4)+"년 "+Integer.parseInt(strC_date.substring(5,7))+"월 출시";	
			}
		}
		//상단 키워드2 
		//if (strKeyword2.trim().length() > 0 && !strCate4.equals("0703") && !strCate4.equals("0714") && !strCate4.equals("0925") && !CutStr.cutStr(strCate4,2).equals("14") && !CutStr.cutStr(strCate4,2).equals("15")){
			strKeyword2 = ReplaceStr.replace(strKeyword2,"★","");
			strKeyword2 = ReplaceStr.replace(strKeyword2,"▶","");
			strKeyword2 = ReplaceStr.replace(strKeyword2,"\"","&quot;");
		//} 

		if(strCate4.equals("0703") || strCate4.equals("0925") || strCate6.equals("070120") || strCate6.equals("070121") || strCate6.equals("070122") || strCate6.equals("070123")){
			strKeyword2 = "";
		}
		//이미지
		String strImageurl = ImageUtil.getImageSrc(strCa_code,intModelno,strImgchk,lngP_pl_no,strP_imgurl,strP_imgurlflag);
        //원본이미지(앱에 보내주는용)
        String strImageurl_org =  strImageurl;
		
		strImageurl_middle = strImageurl;

		if(strImgchk2 != null && !strImgchk2.equals("")){
			strImageurl_middle  = ConfigManager.PHOTO_ENURI_COM+"/data/images/service/middle/"+ImageUtil.ImgFolder((int)intModelno)+"/"+ intModelno +".jpg";
    	}else if(strImgchk3 != null && strImgchk3.equals("1")){
    		strImageurl_middle  = ConfigManager.PHOTO_ENURI_COM+"/data/images/service/img_300/"+ImageUtil.ImgFolder((int)intModelno)+"/"+ intModelno +".jpg";
		}
		
		if(isAdultCate(strCate6) && !cb.GetCookie("MEM_INFO", "ADULT").equals("1")){
			//strImageurl = ConfigManager.IMG_ENURI_COM+"/2012/list/19_2.gif";
			strImageurl_middle = ConfigManager.IMG_ENURI_COM + "/images/home/thum_adult.gif";
		}
		
		//큰이미지 유무
		if (strImgchk.equals("3") || strImgchk.equals("9") || strImgchk.equals("4") || strImgchk.equals("5") ||  strImgchk.equals("0") ||  strImgchk.equals("8")){
			blBigimg = false;
		}
		
		//파워링크용
		Mobile_Category_Proc mobile_category_proc = new Mobile_Category_Proc();
		Mobile_Category_Data[] mobile_mcategory_data = mobile_category_proc.Mobile_Category(strCate4, "2");

		if(strCa_code.length() > 2 && mobile_mcategory_data != null && mobile_mcategory_data.length > 0){
			strCateName = mobile_mcategory_data[0].getC_name();
		}
		
		String ad_command = Ca_Ad_Keyword.Ca_Ad_Google_Call(strCate4);
		
		if(ad_command.equals("")){
			if(strCa_code != null && !strCa_code.equals("") && strCa_code.length() >= 4 &&  strCa_code.substring(0,2).equals("08") && !strCa_code.substring(0,4).equals("0811")) {
				ad_command = strModelnm;  //스폰서 링크 검색어(화장품 카테고리는 상품명으로)
			} else {
				if(strCateName.indexOf("<") > -1){
					if(strCateName.length() > strCateName.indexOf("<")) {
						ad_command = strCateName.substring(strCateName.indexOf("<")+1,strCateName.length()).trim();  //스폰서 링크 검색어(중분류명)
					} else {
						ad_command = strCateName;
					}
				}
			}
		}
		ad_command = ad_command.replaceAll("\"","&#34;");
		
		strSpec = ReplaceStr.replace(strSpec, "</", "****");
		strSpec = ReplaceStr.replace(strSpec, "/", " / ");
		strSpec = ReplaceStr.replace(strSpec, "****", "</");
		strSpec = ReplaceStr.replace(strSpec, "   /   ", " / ");
		strSpec = ReplaceStr.replace(strSpec, "  /  ", " / ");
		
		strSpec_group = ReplaceStr.replace(strSpec_group, "</", "****");
		strSpec_group = ReplaceStr.replace(strSpec_group, "/", " / ");
		strSpec_group = ReplaceStr.replace(strSpec_group, "****", "</");
		strSpec_group = ReplaceStr.replace(strSpec_group, "   /   ", " / ");
		strSpec_group = ReplaceStr.replace(strSpec_group, "  /  ", " / ");
		
		//strCondiname = ReplaceStr.replace(strCondiname, "특가!", "");
		//strCondiname = ReplaceStr.replace(strCondiname, "#", "");
		//strCondiname = ReplaceStr.replace(strCondiname, "`", "");
		//strCondiname = ReplaceStr.replace(strCondiname, "!", "");
		//strCondiname = ReplaceStr.replace(strCondiname, "*", "");
		//strCondiname = ReplaceStr.replace(strCondiname, ",", "");

		strCondiname = strCondiname.replace("`","");
		strCondiname = strCondiname.replace("!",""); 
		strCondiname = strCondiname.replace("#","");
		strCondiname = strCondiname.replace("&","");
		if(strCate4.equals("0304") || strCate4.equals("0305") || strCate4.equals("2117") || CutStr.cutStr(strCa_code,8).equals("03532217") ){
			strCondiname = strCondiname.replace(".","");
		}
		if(strCondiname.length() > 1 ) {
			if(strCondiname.substring(0,1).equals(".")){
				strCondiname = strCondiname.substring(1,strCondiname.length());
			}
		}
		//strCondiname = ReplaceStr.replace(strCondiname, ".", "");
		if(lngTlc_min_prc>0){
			strTlc_yn = "Y";
		}
		
		out.println(" \"modelno\": "+ spec_view.getModelno() +", ");
		out.println(" \"modelnm\": \""+ toJS(strView_modelnm) +"\", ");
		out.println(" \"factory\": \""+ toJS(strFactory) +"\", ");
		out.println(" \"spec\": \""+ toJS(strSpec) +"\", ");
		out.println(" \"c_date\": \""+ toJS(strC_date) +"\", ");
		out.println(" \"imgchk\": \""+ toJS(strImgchk) +"\", ");
		out.println(" \"constrain\": \""+ toJS(strConstrain) +"\", ");
		out.println(" \"minprice\": "+ lngMinprice +", ");
		out.println(" \"avgprice\": "+ lngAvgprice +", ");
		out.println(" \"maxprice\": "+ lngMaxprice +", ");
		if(strTlc_yn=="Y" && lngTlc_min_prc > 0){
			out.println(" \"priceString\": \"TLC\", ");
		}else if(strC_date.indexOf("예정") > -1){ 
			out.println(" \"priceString\": \"출시예정\", ");	
		//}else if(lngMinprice <= 1 && ( strCate4.equals("0304") || strCate4.equals("0305") || strCate4.equals("0353"))){
		//	out.println(" \"priceString\": \"별도확인\", ");
			//out.println(" \"priceString\": \"-\", ");	
		}else if(strConstrain.equals("1") && lngMinprice == 0){
			out.println(" \"priceString\": \"품절\", ");
		}else if(strConstrain.equals("2")){
			out.println(" \"priceString\": \"단종\", ");
		}else{
			out.println(" \"priceString\": \"\", ");	
		}
		out.println(" \"tlc_min_prc\": "+ lngTlc_min_prc +", ");
		out.println(" \"popular\": "+ intPopular +", ");
		out.println(" \"sum_popular\": "+ intSum_popular +", ");
		out.println(" \"refid\": "+ intRefid +", ");
		out.println(" \"manual_link\": \""+ toJS(strManual_link) +"\", ");
		out.println(" \"linkserviceflag\": \""+ toJS(strLinkserviceflag) +"\", ");
		out.println(" \"g_size\": \""+ toJS(strG_size) +"\", ");
//		out.println(" \"func\": \""+ toJS(strFunc) +"\", ");
		out.println(" \"func\": \"\", ");
		out.println(" \"kb_num\": "+ intKb_num +", ");
		out.println(" \"keyword\": \""+ toJS(strKeyword) +"\", ");
		out.println(" \"jobcode\": \""+ toJS(strJobcode) +"\", ");
		out.println(" \"moddate\": \""+ toJS(strModdate) +"\", ");
		out.println(" \"mallcnt\": "+ intMallcnt +", ");
		out.println(" \"condiname\": \""+ toJS(strCondiname) +"\", ");
		out.println(" \"ca_code\": \""+ toJS(strCa_code) +"\", ");
		out.println(" \"factory_etc\": \""+ toJS(strFactory_etc) +"\", ");
		out.println(" \"pl_no\": "+ lngP_pl_no +", ");
		out.println(" \"imgurl\": \""+ toJS(strImageurl_middle) +"\", ");
		out.println(" \"imgurl2\": \""+ toJS(strP_imgurl2) +"\", ");
		out.println(" \"imgurl3\": \""+ toJS(strImageurl) +"\", ");
        out.println(" \"imgurl_org\": \""+ toJS(strImageurl_org) +"\", ");
		out.println(" \"imgurlflag\": \""+ toJS(strP_imgurlflag) +"\", ");
		out.println(" \"modelno_group\": "+ intModelno_group +", ");
		out.println(" \"box_modelnm\": \""+ toJS(strBox_modelnm) +"\", ");
		out.println(" \"keyword2\": \""+ toJS(strKeyword2) +"\", ");
		out.println(" \"bigimg\": \""+ blBigimg +"\", ");
		out.println(" \"sponsor\": \""+ getIsSponserGoods(intModelno) +"\", ");
		out.println(" \"cate4\": \""+ toJS(strCate4) +"\", ");
		out.println(" \"catename\": \""+ toJS(strCateName) +"\", ");
		out.println(" \"ad_command\": \""+ toJS(ad_command) +"\", ");
		out.println(" \"spec_group\": \""+ toJS(strSpec_group) +"\" ");
	} 
	
	//log 추가 2014.09.02
	boolean insertchk2 = false;
	String strFromHit = "0";
	int iHotIcon = 0;
	String M_Ip = request.getRemoteAddr(); 
	String strReferer = ChkNull.chkStr(request.getHeader("REFERER"),"");
	
	if (strReferer.trim().toLowerCase().indexOf("enuri.com") >= 0 && strReferer.trim().toLowerCase().indexOf("/detail.jsp") >= 0) {
		try {
		    String strRefererM = strReferer;
		    if (strRefererM.indexOf("?") >= 0){
		        strRefererM = strRefererM.substring(0,strRefererM.lastIndexOf("?"));
		    }
		   
		    if(!fn_chk_log_ip(M_Ip)){	//shwoo. 170831. 특정아이피 VIP에서 제외
		    	//System.out.println(">>>>>>>>>"+M_Ip);
			    insertchk2 = Model_log_Proc.Mobile_Model_log_Insert5(output, M_Ip, strCa_code, intModelno, iHotIcon, strFromHit,strRefererM,cUserId,strAd_id);
		    }
		      
		} catch(Exception pe) {} 
	}
} catch(Exception e) {
}
%>
}
<%!
	public boolean fn_chk_log_ip(String m_ip){
		boolean blRtn = false;
		StringBuffer strEx_ip = new StringBuffer();
		
		strEx_ip.append("^106.102.1.107^106.102.1.109^106.102.1.110^106.102.1.135^106.102.1.139^106.102.1.153^106.102.1.156^106.102.1.157^106.102.1.160^106.102.1.181^106.102.1.200^106.102.1.216^106.102.1.217^106.102.1.226^106.102.1.230");
		strEx_ip.append("^106.102.1.243^106.102.1.254^106.102.1.27^106.102.1.41^106.102.1.42^106.102.1.46^106.102.1.5^106.102.1.57^106.102.1.59^106.102.1.6^106.102.1.62^106.102.1.71^106.102.1.79^106.102.1.8^106.102.1.80^106.102.1.87");
		strEx_ip.append("^106.102.130.101^106.102.130.232^106.102.130.79^110.70.14.11^110.70.14.231^110.70.14.233^110.70.14.9^110.70.15.181^110.70.15.193^110.70.15.222^110.70.15.9^110.70.26.136^110.70.26.35^110.70.27.237^110.70.47.205");
		strEx_ip.append("^110.70.47.59^110.70.51.166^110.70.51.85^110.70.52.151^110.70.52.197^110.70.52.80^110.70.54.93^110.70.55.147^110.70.55.177^110.70.55.214^110.70.56.169^110.70.57.146^110.70.57.205^110.70.58.99^117.111.1.221");
		strEx_ip.append("^117.111.1.236^117.111.1.243^117.111.1.30^117.111.10.197^117.111.10.218^117.111.10.39^117.111.12.158^117.111.13.187^117.111.13.66^117.111.15.117^117.111.15.210^117.111.15.224^117.111.15.3^117.111.16.104");
		strEx_ip.append("^117.111.16.127^117.111.16.39^117.111.17.218^117.111.17.239^117.111.17.33^117.111.18.32^117.111.18.45^117.111.18.83^117.111.18.93^117.111.19.134^117.111.19.21^117.111.19.33^117.111.19.65^117.111.2.178");
		strEx_ip.append("^117.111.2.230^117.111.2.231^117.111.2.58^117.111.28.192^117.111.4.88^117.111.4.95^119.193.5.151^175.223.10.144^175.223.10.243^175.223.11.110^175.223.11.157^175.223.11.175^175.223.11.176^175.223.11.230");
		strEx_ip.append("^175.223.11.232^175.223.11.59^175.223.14.131^175.223.14.229^175.223.14.235^175.223.14.239^175.223.14.52^175.223.14.53^175.223.15.231^175.223.15.37^175.223.16.106^175.223.16.32^175.223.17.165^175.223.17.201");
		strEx_ip.append("^175.223.17.221^175.223.17.235^175.223.17.6^175.223.18.184^175.223.18.203^175.223.18.51^175.223.18.70^175.223.19.144^175.223.2.205^175.223.20.163^175.223.20.37^175.223.21.116^175.223.21.165^175.223.21.52");
		strEx_ip.append("^175.223.22.170^175.223.23.166^175.223.23.242^175.223.23.59^175.223.23.82^175.223.26.141^175.223.26.142^175.223.26.205^175.223.26.23^175.223.26.235^175.223.26.96^175.223.27.12^175.223.27.209^175.223.27.89");
		strEx_ip.append("^175.223.3.227^175.223.3.228^175.223.3.247^175.223.30.242^175.223.30.68^175.223.31.26^175.223.31.31^175.223.31.88^175.223.33.103^175.223.33.20^175.223.33.229^175.223.33.88^175.223.33.90^175.223.34.157");
		strEx_ip.append("^175.223.34.167^175.223.35.200^175.223.36.186^175.223.37.134^175.223.38.87^175.223.39.165^175.223.44.239^175.223.44.94^175.223.48.190^175.223.48.2^175.223.49.146^175.223.49.76^211.246.69.148^211.36.133.117");
		strEx_ip.append("^211.36.133.127^211.36.133.145^211.36.133.146^211.36.133.151^211.36.133.176^211.36.133.20^211.36.133.205^211.36.133.218^211.36.133.223^211.36.133.239^211.36.133.243^211.36.133.244^211.36.133.25^211.36.133.31");
		strEx_ip.append("^211.36.133.33^211.36.133.37^211.36.133.38^211.36.133.61^211.36.133.62^211.36.133.72^211.36.133.89^211.36.142.244^211.36.142.31^211.36.142.41^211.36.142.57^211.36.142.66^211.36.142.7^211.36.142.92^218.238.99.80");
		strEx_ip.append("^223.33.164.38^223.33.164.71^223.33.165.2^223.33.165.223^223.38.11.200^223.38.11.89^223.38.11.92^223.38.8.102^223.38.8.139^223.38.8.161^223.38.8.25^223.62.10.178^223.62.10.42^223.62.10.74^223.62.11.141");
		strEx_ip.append("^223.62.11.196^223.62.162.39^223.62.162.9^223.62.163.117^223.62.163.158^223.62.163.234^223.62.169.4^223.62.172.128^223.62.172.168^223.62.172.214^223.62.173.122^223.62.173.157^223.62.188.157^223.62.188.42");
		strEx_ip.append("^223.62.188.89^223.62.203.127^223.62.203.155^223.62.203.166^223.62.203.176^223.62.21.129^223.62.21.97^223.62.212.66^223.62.216.100^223.62.216.168^223.62.216.229^223.62.8.239^223.62.8.244^39.7.15.23");
		strEx_ip.append("^39.7.15.240^39.7.15.72^39.7.18.203^39.7.19.163^39.7.46.143^39.7.50.225^39.7.51.145^39.7.51.155^39.7.51.254^39.7.53.147^39.7.54.202^39.7.54.5^39.7.55.187^39.7.55.41^39.7.58.101^39.7.58.252^39.7.58.34");
		strEx_ip.append("^39.7.58.6^39.7.58.82^39.7.59.136^39.7.59.42^52.78.145.74^52.78.234.216^66.249.71.23^66.249.71.83^66.249.71.85^66.249.71.87^66.249.79.58^66.249.79.61^66.249.79.80^");
		strEx_ip.append("^223.62.162.140^");
		
		if(strEx_ip.indexOf("^"+m_ip+"^") > -1){
			blRtn = true;
		}
		
		return blRtn;	
	}
%>