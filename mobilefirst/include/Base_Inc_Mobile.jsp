<%@ page import="java.util.*,java.text.*,java.net.*"%>
<%@ page import="com.enuri.include.*"%>
<%@ page import="com.enuri.util.etc.*"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.util.image.*"%>
<%@ page import="com.enuri.util.http.*"%>
<%@ page import="com.enuri.util.date.*"%>
<%@ page import="com.enuri.bean.main.Category_Data"%>
<%@ page import="com.enuri.bean.main.Category_Proc"%>
<jsp:useBean id="Category_Data" class="com.enuri.bean.main.Category_Data" scope="page" />
<jsp:useBean id="Category_Proc" class="com.enuri.bean.main.Category_Proc" scope="page" />
<%
	response.setContentType("text/html;charset=UTF-8");
	response.setHeader("Pragma","No-cache");
	response.setDateHeader("Expires",-1);
	response.setHeader("Cache-Control","no-cache");

	CookieBean cb = null;
	cb = new CookieBean( request.getCookies());
	String output = cb.GetCookie( "MYINFO","TMP_ID");

	if(output.equals("")){
		output = Category_Proc.getTmpID();
		cb.SetCookie("MYINFO","TMP_ID", output);
		cb.SetCookieExpire("MYINFO", 3600*24*30);
		cb.responseAddCookie(response);
	}
	if( CvtStr.isNumeric(cb.GetCookie("MYINFO","TMP_ID"))==false){
		output = Category_Proc.getTmpID();
		cb.SetCookie("MYINFO","TMP_ID", output);
		cb.SetCookieExpire("MYINFO", 3600*24*30);
		cb.responseAddCookie(response);
	}

	Calendar cal = Calendar.getInstance();

	String IMG_ENURI_COM = "http://img.enuri.info";

%>
<%!
	public static String getDate()
	{
	   DecimalFormat df = new DecimalFormat("00");
	   Calendar calendar = Calendar.getInstance();


	   String year = Integer.toString(calendar.get(Calendar.YEAR)); //년도를 구한다
	   String month = df.format(calendar.get(Calendar.MONTH) + 1); //달을 구한다
	   String day = df.format(calendar.get(Calendar.DATE)); //날짜를 구한다
	   String date = month+"월" + day+"일";

	   return date;
	}

	public static String toJS(String str){
		return toJS2(str);
	}

	public static String toJS2(String str){
		return str.replace("\\", "\\\\")
					.replace("\"", "\\\"")
					.replace("&" , "&amp;")
					.replace("\'", "&apos;")
					.replace("\b", "\\b")
					.replace("\f", "\\f")
					.replace("\n", "\\n")
					.replace("\r", "\\r")
					.replace("\t", "\\t");
	}

	public static String toDateText(String str, String strSearch){	//목록에서 사용하는 날짜(출시일)
		Calendar cal = Calendar.getInstance();
		if(str.length()==10) {
			String nowYear = cal.get(cal.YEAR) + "";

			// 현재 년도랑 같을 경우에만  년, 월로 표시
			if(str.substring(0, 4).equals(nowYear)) {
				str = str.substring(2, 7);
				if(strSearch.equals("Y")){
					str = "'" + ReplaceStr.replace(str, "-0", "년 ") + "월";
				}else{
					str = "'" + ReplaceStr.replace(str, "-0", "년 ") + "월 출시";
				}
			} else {
				if(strSearch.equals("Y")){
					str = str.substring(2, 4) + "년";
				}else{
					str = str.substring(2, 4) + "년 출시";
				}
			}
		}
		 return str;
	}

	public static String toNumFormat(long num) {
		DecimalFormat df = new DecimalFormat("#,###");
		return df.format(num);
	}

	public static String toUrlCode(String strShop_url){

		String strMobile_url = "";

		//쇼핑몰에 따른 모바일 url & 수익코드 변경
		if(strShop_url.indexOf("auction.co.kr") > 0){
			if(strShop_url.indexOf("&pc=589") > 0){
				strMobile_url = strShop_url.replace("&pc=589","&pc=805");
			}else{
				strMobile_url = strShop_url;
			}
		}else if(strShop_url.indexOf("gmarket.co.kr") > 0){
				if(strShop_url.indexOf("jaehuid=200002673") > 0){
					strMobile_url = strShop_url.replace("jaehuid=200002673","jaehuid=200006254");
				}else{
					strMobile_url = strShop_url;
				}
		}else if(strShop_url.indexOf("11st") > 0){
			if(strShop_url.indexOf("prdNo=") > 0){
				strMobile_url = strShop_url.substring(strShop_url.indexOf("prdNo=")+6,strShop_url.length());
				if(strMobile_url.indexOf("&tid=1000000125") > 0 ){
					strMobile_url = strMobile_url.replace("&tid=1000000125","");
				}
				strMobile_url = "http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1000993624&prdNo="+strMobile_url+"&apInfo=5910_mobile";
			}else{
				strMobile_url = strShop_url+"&apInfo=5910_mobile";
			}
		}else if(strShop_url.indexOf("lotteimall.com") > 0){
			if(strShop_url.indexOf("goods_no=") > -1){
				strMobile_url = strShop_url.substring(strShop_url.indexOf("goods_no=")+9,strShop_url.length());
				strMobile_url = "http://m.lotteimall.com/coop/affilGate.lotte?chl_no=140764&chl_dtl_no=2540376&returnUrl=/goods/viewGoodsDetail.lotte?goods_no="+strMobile_url;
			}else{
				strMobile_url = strShop_url;
			}
		}else if(strShop_url.indexOf("dnshop") > 0){
			strMobile_url = strShop_url.replace("dnshop_partner_02","dnshop_partner_54").replace("Sid=0024_A8000000_00_00","Sid=0024_M8000000_00_00").replace("Psid=010000","Psid=010001");
		}else if(strShop_url.indexOf(".lotte.com") > 0){
			if(strShop_url.indexOf("goods_no=") > 0){
				strMobile_url = strShop_url.substring(strShop_url.indexOf("goods_no=")+9,strShop_url.length());
				strMobile_url = "http://m.lotte.com/product/product_view.do?c=mlotte&udid=&v=&cn=120632&cdn=984879&goods_no="+strMobile_url;
			}else{
				strMobile_url = strShop_url;
			}
		}else if(strShop_url.indexOf("emart") > 0){
			if(strShop_url.indexOf("item_id=") > 0){
				strMobile_url = strShop_url.substring(strShop_url.indexOf("item_id=")+8,strShop_url.length());
				strMobile_url = "http://m.emartmall.com/mobile/MobileItem.do?method=getItemInfoViewDtl&item_id="+strMobile_url;
			}else{
				strMobile_url = strShop_url;
			}
		}else if(strShop_url.indexOf("cjmall") > 0 || strShop_url.indexOf("cjonstyle.com") > 0){
			if(strShop_url.indexOf("item_cd=") > 0){
				strMobile_url = strShop_url.substring(strShop_url.indexOf("item_cd=")+8,strShop_url.length());
				strMobile_url = "http://mw.cjmall.com/m/prd/detail_cate.jsp?app_cd=ENURI&item_cd="+strMobile_url;
			}else if(strShop_url.indexOf("infl_cd=I0647") > 0){
				strMobile_url = strShop_url.replace("infl_cd=I0647", "infl_cd=I0580");
			}else{
				strMobile_url = strShop_url;
			}
		}else if(strShop_url.indexOf("galleria.co.kr") > 0){
			if(strShop_url.indexOf("channel_id=2763") > 0){
				strMobile_url = strShop_url.replace("channel_id=2763","channel_id=2764");
			}else if(strShop_url.indexOf("chnl_no=2763") > 0){
				strMobile_url = strShop_url.replace("chnl_no=2763","chnl_no=2764");
			}else{
				strMobile_url = strShop_url;
			}
		/*
		 * 2017.01.10. shwoo. 이재환 요청으로 우체국 모바일 예외처리 제외.
		}else if(strShop_url.indexOf("epost.go.kr") > 0){
			//https://mall.epost.go.kr/cgi-bin/epostpartner_bbr.cgi?p=enuri&Gbn=1&CateCode=130804&GoodsIdn=33393
			//-->변환
			//http://mall.epost.go.kr/hybrid.goods.RetrieveNewMobileWebEcGoodsDetailInfo.mall?cateCode=130804&goodsIdn=33393
			if(strShop_url.indexOf("?") > 0){
				strMobile_url = strShop_url.substring(strShop_url.indexOf("?")+1,strShop_url.length()).replace("CateCode=","cateCode=").replace("GoodsIdn=","goodsIdn=");
				strMobile_url = "http://mall.epost.go.kr/hybrid.goods.RetrieveNewMobileWebEcGoodsDetailInfo.mall?"+strMobile_url;
			}
		*/
		}else if(strShop_url.indexOf("g9.co.kr") > 0){
			if(strShop_url.indexOf("200006435") > 0){
				strMobile_url = strShop_url.replace("200006435","200006436");
			}else{
				strMobile_url = strShop_url;
			}
		}else if(strShop_url.indexOf("coupang.com") > 0){
			strMobile_url = strShop_url;
			
			if(strMobile_url.indexOf("utm_campaign=PC_EP") > 0){
				strMobile_url = strMobile_url.replace("utm_campaign=PC_EP","utm_campaign=Mobile_EP");
			}
			if(strMobile_url.indexOf("src=1032035") > 0){
				strMobile_url = strMobile_url.replace("src=1032035","src=1033035");
			}
			if(strMobile_url.indexOf("src=1032001") > 0){
				strMobile_url = strMobile_url.replace("src=1032001", "src=1033035");
			}
		}else if(strShop_url.indexOf("qoo10.com") > 0){
			strMobile_url = strShop_url;
			
			if(strMobile_url.indexOf("2026003151") > 0){
				strMobile_url = strMobile_url.replace("2026003151","2026048152");
			}
		}else if(strShop_url.indexOf("www.elandmall.com") > 0){
			strMobile_url = strShop_url;
			
			if(strMobile_url.indexOf("chnl_no=ENW") > 0){
				strMobile_url = strMobile_url.replace("chnl_no=ENW", "chnl_no=ENM");
			}
		//}else if(strShop_url.indexOf(".istyle24.com") > 0){
		//	strMobile_url = strShop_url;
			
		//	if(strMobile_url.indexOf("cid=enuri") > 0){
		//		strMobile_url = strMobile_url.replace("cid=enuri", "cid=menuri");
		//	}
		}else if(strShop_url.indexOf("www.akmall.com") > 0){
			strMobile_url = strShop_url;
			
			if(strMobile_url.indexOf("assc_comp_id=12189") > 0){
				strMobile_url = strMobile_url.replace("assc_comp_id=12189", "assc_comp_id=26392");
			}
		}else if(strShop_url.indexOf("www.hyundaihmall.com") > 0){
			//2018-10-10.shwoo 추가 (#30674)
			strMobile_url = strShop_url;
			
			//20201-09 shwoo(#37780) 현대몰 022로 사용요청 아래 예외처리 삭제 ---> 이후 이상없을시 IF문 자체 제거 
			//if(strMobile_url.indexOf("ReferCode=022") > 0){
			//	strMobile_url = strMobile_url.replace("ReferCode=022", "ReferCode=s49");
			//}
		}else{
			strMobile_url = strShop_url;
		}

		return strMobile_url;
	}

	//성인카테고리 여부
	public boolean isAdultCate(String strCate){
		boolean isAdult = false;
		
		if( CutStr.cutStr(strCate,6).equals("163630")  || CutStr.cutStr(strCate,6).equals("931004") || CutStr.cutStr(strCate,6).equals("051523") || CutStr.cutStr(strCate,6).equals("051513") ){
			isAdult = true;
		}
		return isAdult;
	}
	
	
%>