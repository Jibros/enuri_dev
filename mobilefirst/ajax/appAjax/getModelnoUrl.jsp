<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="com.enuri.include.*"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.bean.main.AutoPriceComp_Proc"%>
<jsp:useBean id="AutoPriceComp_Proc" class="AutoPriceComp_Proc" scope="page" />
<%	
	int shop_code=0;
	String goodscode="";
	String shop_url = java.net.URLDecoder.decode(ChkNull.chkStr(request.getParameter("shop_url")));
	String enuriModelno = ChkNull.chkStr(request.getParameter("enuriModelno"), "");
	String enuriPl_no = ChkNull.chkStr(request.getParameter("enuriPl_no"), "");

	int modelno=0;
	if(shop_url.equals("")){
		shop_url = "http://www.11st.co.kr/product/SellerProductDetail.tmall?method=getSellerProductDetail&prdNo=941575644";
	}
	String shop_url_lower = shop_url.toLowerCase();
	int intS = 0;
	int intE = 0;

	// �μ��
	if(shop_url_lower.indexOf(".auction.co.kr")>-1 && shop_url_lower.indexOf("detailview")>-1 && 
		(shop_url_lower.indexOf("itemno=")>-1 || shop_url_lower.indexOf("viewitem/vip/martondetailview/")>-1) && 
		shop_url_lower.indexOf(".gmarket.co.kr")<0) {
		if(shop_url_lower.indexOf("itemno=")>-1) {
			if(shop_url_lower.indexOf("through.auction.co.kr/common/saferedirect.aspx")>-1) {
				intS = shop_url_lower.indexOf("itemno=")+"itemno=".toLowerCase().length();
				intE = shop_url_lower.indexOf("&",shop_url_lower.indexOf("itemno="));
				if(intE == -1){
					intE=shop_url.length();
				}
				goodscode = shop_url.substring(intS,intE).trim();
			} else {
				intS = shop_url_lower.indexOf("itemno=")+"itemno=".toLowerCase().length();
				intE = shop_url_lower.indexOf("*",shop_url_lower.indexOf("itemno="));
				if(intE == -1) {
					intE=shop_url.length();
				}
				goodscode = shop_url.substring(intS,intE).trim();
			}
		}

		if(shop_url_lower.indexOf("viewitem/vip/martondetailview/")>-1) {
			goodscode = shop_url.substring(shop_url_lower.indexOf("viewitem/vip/martondetailview/")+"viewitem/vip/martondetailview/".length());
			goodscode = goodscode.replaceAll("/", "");
		}
		shop_code=4027;

	// 吏�留�耳�
	} else if(shop_url_lower.indexOf(".gmarket.co.kr")>-1 && shop_url_lower.indexOf("jaehuid=200004367")<0 && 
		(shop_url_lower.indexOf("detailview/item")>-1 || shop_url_lower.indexOf("challenge/neo_goods/")>-1) && shop_url_lower.indexOf("goodscode=")>-1) {
		shop_code = 536;
		intS = shop_url_lower.indexOf("goodscode=")+"goodscode=".toLowerCase().length();
		intE = shop_url_lower.indexOf("*",shop_url_lower.indexOf("goodscode="));
		if(intE == -1) {
			intE=shop_url.length();
		}
		goodscode = shop_url.substring(intS,intE).trim();

	//11踰�媛�-����
	} else if(shop_url_lower.indexOf("book.11st.co.kr")>-1 && shop_url_lower.indexOf("gdsno=")>-1) {
		//http://book.11st.co.kr/Goods.do?cmd=detail&gdsNo=M0000001106066&dispCtgNo=null
		shop_code = 6378;
		intS = shop_url_lower.indexOf("gdsno=")+"gdsno=".toLowerCase().length();
		intE = shop_url_lower.indexOf("*",shop_url_lower.indexOf("gdsno="));
		if(intE == -1) {
			intE=shop_url.length();
		}
		goodscode = shop_url.substring(intS,intE).trim();
	   	
	//11踰�媛�
	} else if(shop_url_lower.indexOf(".11st.co.kr")>-1 && shop_url_lower.indexOf("sellerproductdetail")>-1 && shop_url_lower.indexOf("prdno=")>-1) {
		shop_code = 5910;
		intS = shop_url_lower.indexOf("prdno=")+"prdno=".toLowerCase().length();
		intE = shop_url_lower.indexOf("*",shop_url_lower.indexOf("prdno="));
		if(intE == -1) {
			intE=shop_url.length();
		}
		goodscode = shop_url.substring(intS,intE).trim();
		
	//�명�고����
	} else if(shop_url_lower.indexOf("book.interpark.com")>-1 && shop_url_lower.indexOf("sc.prdno=")>-1) {
		shop_code = 55;
		intS = shop_url_lower.indexOf("sc.prdno=")+"sc.prdno=".toLowerCase().length();
		intE = shop_url_lower.indexOf("*",shop_url_lower.indexOf("sc.prdno="));
		if(intE == -1) {
			intE=shop_url.length();
		}
		goodscode = "B" + shop_url.substring(intS,intE).trim();

	} else if(shop_url_lower.indexOf("shoes.interpark.com")>-1 && shop_url_lower.indexOf("prdno=")>-1) {
		shop_code = 55;
		intS = shop_url_lower.indexOf("prdno=")+"prdno=".toLowerCase().length();
		intE = shop_url_lower.indexOf("*",shop_url_lower.indexOf("prdno="));
		if(intE == -1) {
			intE=shop_url.length();
		}
		goodscode = shop_url.substring(intS,intE).trim();

	} else if(shop_url_lower.indexOf(".interpark.com")>-1 && shop_url_lower.indexOf("method=detail")>-1 && shop_url_lower.indexOf("sc.prdno=")>-1) {
		shop_code = 55;
		intS = shop_url_lower.indexOf("sc.prdno=")+"sc.prdno=".toLowerCase().length();
		intE = shop_url_lower.indexOf("*",shop_url_lower.indexOf("sc.prdno="));
		if(intE == -1) {
			intE=shop_url.length();
		}
		goodscode = shop_url.substring(intS,intE).trim();

		if(shop_url_lower.indexOf("mart.interpark.com")>-1) {
			goodscode = "77" + goodscode;
		}

	//���ㅼ��(1878)
	} else if(shop_url_lower.indexOf(".dnshop.com")>-1 && shop_url_lower.indexOf("pid=")>-1) {
		shop_code = 1878;
		intS = shop_url_lower.indexOf("pid=")+"pid=".toLowerCase().length();
		intE = shop_url_lower.indexOf("*",shop_url_lower.indexOf("pid="));
		if(intE == -1) {
			intE=shop_url.length();
		}
		goodscode = shop_url.substring(intS,intE).trim();	

	//�����곗�쇳��(974)
	} else if(shop_url_lower.indexOf(".nseshop.com")>-1 && shop_url_lower.indexOf("good_id=")>-1) {
		shop_code = 974;
		intS = shop_url_lower.indexOf("good_id=")+"good_id=".toLowerCase().length();
		intE = shop_url_lower.indexOf("*",shop_url_lower.indexOf("good_id="));
		if(intE == -1){
			intE=shop_url.length();
		}
	   	goodscode = shop_url.substring(intS,intE).trim();	 

	//CJMALL(806)
	} else if(shop_url_lower.indexOf(".cjmall.com")>-1 && shop_url_lower.indexOf("item_cd=")>-1) {
		shop_code = 806;
		intS = shop_url_lower.indexOf("item_cd=")+"item_cd=".toLowerCase().length();
		intE = shop_url_lower.indexOf("*",shop_url_lower.indexOf("item_cd="));
		if(intE == -1) {
			intE=shop_url.length();
		}
	   	goodscode = shop_url.substring(intS,intE).trim();

	//濡��고���쇳��(806)
	} else if(shop_url_lower.indexOf(".lotteimall.com")>-1 && shop_url_lower.indexOf("i_code=")>-1) {
		shop_code = 663;
		intS = shop_url_lower.indexOf("i_code=")+"i_code=".toLowerCase().length();
		intE = shop_url_lower.indexOf("*",shop_url_lower.indexOf("i_code="));
		if(intE == -1) {
			intE=shop_url.length();
		}
		goodscode = shop_url.substring(intS,intE).trim();
	   	
	//�대��몃ぐ(374)
	} else if(shop_url_lower.indexOf(".emartmall.com")>-1 && shop_url_lower.indexOf("product4_10151_")>-1) {
		shop_code = 374;
		intS = shop_url_lower.indexOf("product4_10151_")+"product4_10151_".length();
		intE = shop_url_lower.indexOf("?",shop_url_lower.indexOf("product4_10151_"));
		if(intE == -1) {
			intE=shop_url.length();
		}
		goodscode = shop_url.substring(intS,intE).trim();

	//AK紐�(90)
	} else if(shop_url_lower.indexOf(".akmall.com")>-1 && shop_url_lower.indexOf("goods_cd=")>-1) {
		shop_code = 90;
		intS = shop_url_lower.indexOf("goods_cd=")+"goods_cd=".toLowerCase().length();
		intE = shop_url_lower.indexOf("*",shop_url_lower.indexOf("goods_cd="));
		if(intE == -1) {
			intE=shop_url.length();
		}
		goodscode = shop_url.substring(intS,intE).trim();

	//gsshop.com(75)
	} else if(shop_url_lower.indexOf(".gsshop.com")>-1 && shop_url_lower.indexOf("prdid=")>-1) {
		shop_code = 75;
		intS = shop_url_lower.indexOf("prdid=")+"prdid=".toLowerCase().length();
		intE = shop_url_lower.indexOf("*",shop_url_lower.indexOf("prdid="));
		if(intE == -1) {
			intE=shop_url.length();
		}
		goodscode = shop_url.substring(intS,intE).trim();
	   	
	//shinsegae.com(47)
	} else if(shop_url_lower.indexOf(".shinsegae.com")>-1 && shop_url_lower.indexOf("item_id=")>-1) {
		shop_code = 47;
		intS = shop_url_lower.indexOf("item_id=")+"item_id=".toLowerCase().length();
		intE = shop_url_lower.indexOf("*",shop_url_lower.indexOf("item_id="));
		if(intE == -1) {
			intE=shop_url.length();
		}
		goodscode = shop_url.substring(intS,intE).trim();
	   	
	//lotte.com(49)
	} else if(shop_url_lower.indexOf(".lotte.com")>-1 && shop_url_lower.indexOf("viewgoodsdetail")>-1 && shop_url_lower.indexOf("goods_no=")>-1) {
		shop_code = 49;
		intS = shop_url_lower.indexOf("goods_no=")+"goods_no=".toLowerCase().length();
		intE = shop_url_lower.indexOf("*",shop_url_lower.indexOf("goods_no="));
		if(intE == -1) {
			intE=shop_url.length();
		}
		goodscode = shop_url.substring(intS,intE).trim();   	
	   	
	//hyundaihmall.com(57)
	} else if(shop_url_lower.indexOf(".hyundaihmall.com")>-1 && shop_url_lower.indexOf("itemcode=")>-1) {
		shop_code = 57;
		intS = shop_url_lower.indexOf("itemcode=")+"itemcode=".toLowerCase().length();
		intE = shop_url_lower.indexOf("*",shop_url_lower.indexOf("itemcode="));
		if(intE == -1){
			intE=shop_url.length();
		}
	   	goodscode = shop_url.substring(intS,intE).trim();  
	
	//homeplus.co.kr(6361)
	} else if(shop_url_lower.indexOf(".homeplus.co.kr")>-1 && shop_url_lower.indexOf("i_style=")>-1) {
		shop_code = 6361;
		intS = shop_url_lower.indexOf("i_style=")+"i_style=".toLowerCase().length();
		intE = shop_url_lower.indexOf("*",shop_url_lower.indexOf("i_style="));
		if(intE == -1) {
			intE=shop_url.length();
		}
		goodscode = shop_url.substring(intS,intE).trim();	   	

	//yes24.com(3367)
	} else if(shop_url_lower.indexOf("www.yes24.com")>-1 && shop_url_lower.indexOf("24/goods/")>-1) {
		shop_code=3367;
		intS = shop_url_lower.indexOf("24/goods/")+"24/goods/".toLowerCase().length();
		intE = shop_url_lower.indexOf("?",shop_url_lower.indexOf("24/goods/"));
		if(intE == -1){
			intE=shop_url.length();
		}
		goodscode = shop_url.substring(intS,intE).trim();

	//aladin.co.kr(4861)
	} else if(shop_url_lower.indexOf("www.aladin.co.kr")>-1 && shop_url_lower.indexOf("isbn=")>-1) {
		shop_code = 4861;
		intS = shop_url_lower.indexOf("isbn=")+"isbn=".toLowerCase().length();
		intE = shop_url_lower.indexOf("*",shop_url_lower.indexOf("isbn="));
		if(intE == -1) {
			intE=shop_url.length();
		}
		goodscode = shop_url.substring(intS,intE).trim();	   	

	//bandinlunis.com(4858)
	} else if(shop_url_lower.indexOf("www.bandinlunis.com")>-1 && shop_url_lower.indexOf("prodid=")>-1) {
		shop_code = 4858;
		intS = shop_url_lower.indexOf("prodid=")+"prodid=".toLowerCase().length();
		intE = shop_url_lower.indexOf("*",shop_url_lower.indexOf("prodid="));
		if(intE == -1) {
			intE=shop_url.length();
		}
		goodscode = shop_url.substring(intS,intE).trim();	   	

	}

	if(goodscode.indexOf("*")>-1) {
		goodscode = goodscode.substring(0, goodscode.indexOf("*"));
	}
%>
{
<%
	if(goodscode.length()>0) {
		String findValue = AutoPriceComp_Proc.GoodscodeToModelnos(goodscode, shop_code);
		String[] modelnosAry = findValue.split("\t");
		int listCnt = 0;

		out.println("	\"modelList\" : [");
		if(modelnosAry!=null) {
			for(int i=0; i<modelnosAry.length; i++) {
				if(modelnosAry[i].indexOf("-")>-1) {
					// modelno|plno
					String[] goodsAry = modelnosAry[i].split("-");

					if(listCnt>0) out.println(",");
					out.println("		{");
					out.println("			\"modelno\" : \""+goodsAry[0]+"\",");
					out.println("			\"plno\" : \""+goodsAry[1]+"\"");
					out.print("		}");

					listCnt++;
				}
			}
		}
		out.println(" ");
		out.println("	],");
		out.println("	\"totalCnt\" : \""+listCnt+"\"");
	}
%>
}
<%
/*	
--.dnshop.com
--.nseshop.com
--.cjmall.com
--.lotteimall.com
--.gmarket.co.kr
--.emartmall.com
.njoyny.com(����)
--.akmall.com
--.gsshop.com
--.shinsegae.com
--.lotte.com
--.interpark.com
--.hyundaihmall.com
--.auction.co.kr
--.11st.co.kr
--.homeplus.co.kr
*/
%>