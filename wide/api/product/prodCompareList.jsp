<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>\
<%@ page import="com.enuri.api.Pricelist_Api"%>\
<%@ page import="com.enuri.bean.main.Save_Goods_Proc"%>\
<%@ page import="com.enuri.bean.main.Save_Goods_Data"%>\
<%@ page import="com.enuri.bean.main.Save_PriceList_Data"%>\
<%@ page import="com.enuri.bean.main.Goods_Data"%>\
<%@ page import="com.enuri.bean.main.Goods_Proc"%>\
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>\
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>\
<%@ page import="com.enuri.bean.lsv2016.Goods_Search_Lsv_Proc"%>\
<jsp:useBean id="Pricelist_Proc" class="com.enuri.bean.main.Pricelist_Proc" scope="page" />\
<%@ include file="/lsv2016/include/IncSearch.jsp"%>
<%
	boolean bAdultKeyword = false;
%>
<%@ include file="/include/IncAdultKeywordCheck_2010.jsp" %>
{
<%
	String goodsNumList = ChkNull.chkStr(request.getParameter("goodsNumList"), "");

	int goodsCnt = 0;

	Goods_Search_Lsv_Proc save_goods_proc = new Goods_Search_Lsv_Proc();
	Goods_Data[] goods_data = null;

	String strTodayGoods = goodsNumList;

	Goods_Proc goods_proc = new Goods_Proc();
	Pricelist_Proc pricelist_proc = new Pricelist_Proc();
	ArrayList arrayTodayGoods = new ArrayList();

	if(strTodayGoods.trim().length()>0) {
		String astrTodayGoods[] = strTodayGoods.split("\\,");

		for(int i=0; i<astrTodayGoods.length; i++) {
			String strTodayGoodsOne = astrTodayGoods[i];

			if(strTodayGoodsOne.length()>1) {
				if(strTodayGoodsOne.substring(0,1).equals("G") && ChkNull.chkNumber(strTodayGoodsOne.substring(1))) {
					int nModelNo = Integer.parseInt(strTodayGoodsOne.substring(1));
					Goods_Data goods_data_one = save_goods_proc.Goods_One(nModelNo,0);

					if(goods_data_one != null) {
						goods_data_one.setProduct_id2(strTodayGoodsOne);
						goods_data_one.setModelno(nModelNo);
						goods_data_one.setKb_num1(goods_data_one.getKb_num());

						arrayTodayGoods.add(goods_data_one);
					}
				} else if (strTodayGoodsOne.substring(0,1).equals("P") && ChkNull.chkNumber(strTodayGoodsOne.substring(1))) {
					long nPlNo = Long.parseLong(strTodayGoodsOne.substring(1));
					Pricelist_Data pricelist_data_info = save_goods_proc.getPricelistData(nPlNo);

					if(pricelist_data_info != null) {
						Goods_Data goods_data_one = new Goods_Data();

						goods_data_one.setProduct_id2(strTodayGoodsOne);
						goods_data_one.setCa_code(pricelist_data_info.getCa_code());
						goods_data_one.setModelnm(pricelist_data_info.getGoodsnm());
						goods_data_one.setMinprice(pricelist_data_info.getPrice_long());
						goods_data_one.setMinprice3(pricelist_data_info.getInstance_price());
						goods_data_one.setP_imgurl(pricelist_data_info.getImgurl());
						goods_data_one.setGoods_info(pricelist_data_info.getDeliveryinfo());
						goods_data_one.setGoods_info_date(pricelist_data_info.getFreeinterest());
						goods_data_one.setMallcnt(1);
						goods_data_one.setFunc(pricelist_data_info.getSrvflag());

						arrayTodayGoods.add(goods_data_one);
					}
				}
			}
		}
		goods_data = (Goods_Data[])arrayTodayGoods.toArray(new Goods_Data[0]);
	}

	if(goods_data!=null && goods_data.length>0) {
        HashMap cardNameHash  = getCardNameHash();

        out.println("	\"goodsList\": [");
		for(int i=0; i<goods_data.length; i++) {
			int modelno = goods_data[i].getModelno();
			String modelnm = goods_data[i].getModelnm();
			modelnm = ReplaceStr.replace(goods_data[i].getModelnm(),"\\","&#8361");
			String p_imgurl = goods_data[i].getP_imgurl();
			long minprice = goods_data[i].getMinprice();
			long minprice3 = goods_data[i].getMinprice3();
			String prodNo = goods_data[i].getProduct_id2();
			//현금몰, tlc 가격 추가 (2019.12.16)
			long cash_min_prc = goods_data[i].getCash_min_prc();
			String cash_min_prc_yn = goods_data[i].getCash_min_prc_yn();
			long tlc_min_prc = goods_data[i].getTlc_min_prc();

			int kb_num = goods_data[i].getKb_num();
			String kb_title = HtmlStr.removeHtml(goods_data[i].getKb_title());
			kb_title = ReplaceStr.replace(ReplaceStr.replace(ReplaceStr.replace(kb_title,"'",""),"\"",""),"[뉴스]","");

			modelnm = ReplaceStr.replace(modelnm,"\"","&quot;");

			boolean IsAdultFlag = false;
			if(cb.GetCookie("MEM_INFO","ADULT")!=null) {
				String adultStr = cb.GetCookie("MEM_INFO","ADULT");
				// 성인인증 됨
				if(adultStr.equals("1")) IsAdultFlag = true;
			}

			// 성인구분 넣어줘야함
			goods_data[i].setAdultChk(IsAdultFlag);
			String smallImageUrl = p_imgurl;
			if(goods_data[i].getModelno()>0) {
				smallImageUrl = ImageUtil_lsv.getImageSrc(goods_data[i]);
			} else {
				String strAdultCookie = "";
				if(cb.GetCookie("MEM_INFO","ADULT") != null) {
					strAdultCookie = cb.GetCookie("MEM_INFO","ADULT");
				}

				boolean bAdult = false;
				if (adultKeywordCheck(modelnm) || adultCategoryCheck(goods_data[i].getCa_code())){
					bAdult = true;
				}
				smallImageUrl = getSearchGoodsImage(bAdult,strAdultCookie,smallImageUrl,false);

				// plno상품의 경우는 getSearchGoodsImage를 이용해 성인용 체크를 하고 이미지는
				// 아래와 같이 변경해야함
				if(smallImageUrl.indexOf("2012/search/19_50.gif")>-1) {
					smallImageUrl = "http://img.enuri.info/images/home/thum_adult.gif";
				}
			}

			if(modelnm.length()>0) {
				if(goodsCnt>0) out.print(",\r\n");

				out.println("			{");
				out.println("			\"prodNo\":\""+prodNo+"\", ");
				out.println("			\"modelno\":\""+modelno+"\", ");
				out.println("			\"minprice\":\""+minprice+"\", ");
				out.println("			\"minprice3\":\""+minprice3+"\", ");
				out.println("			\"modelnm\":\""+toJS2(modelnm)+"\", ");
				out.println("			\"smallImageUrl\":\""+smallImageUrl+"\", ");
				out.println("			\"cash_min_prc\":\""+cash_min_prc+"\", ");
				out.println("			\"cash_min_prc_yn\":\""+cash_min_prc_yn+"\", ");
				out.println("			\"tlc_min_prc\":\""+tlc_min_prc+"\" ");
				out.print("			}");

				goodsCnt++;
			}
		}
		out.println("\r\n	], ");
	}
	out.println("	\"goodsCnt\":\""+goodsCnt+"\" ");
%>
}