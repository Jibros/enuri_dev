<%@page import="org.json.JSONException"%>
<%@page import="com.enuri.bean.main.Goods_Proc"%>
<%@page import="com.enuri.bean.main.Goods_Data"%>
<%@page import="com.enuri.bean.main.Main_Plan_Goods_Data"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.enuri.bean.main.brandplacement.DBWrap"%>
<%@page import="com.enuri.bean.main.brandplacement.DBDataTable"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%!
private int getImgCode(String Imgurl){
	try{
		URL url = new URL(Imgurl);
		HttpURLConnection connection = (HttpURLConnection)url.openConnection();
		connection.setRequestMethod("GET");
		connection.connect();

		int code = connection.getResponseCode();
		return code;
	}catch(Exception ex){
		return 404;
	}
}
public String getGoodsImgSrc(int nModelNo){
	try{
		Goods_Data goods_data = new Goods_Proc().Goods_Detailmulti_One(nModelNo, "Detailmulti");
		String strVIPImageUrl = ImageUtil_lsv.getVIPImageSrc(goods_data);
		return strVIPImageUrl;
	}catch(Exception ex){
		return "";
	}
}
%>
<%
int exh_id = ChkNull.chkInt(request.getParameter("exh_id"),5); // 2017 가정의달 5

String[] layouts = new String[]{"R","T"};
//String[] layouts = new String[]{"T"};
String suffix = "_dev";

if (request.getServerName().equals("enuri.com") || request.getServerName().equals("www.enuri.com") || request.getServerName().equals("m.enuri.com")){
	suffix = "_real";
}
JSONObject jret = new JSONObject();
StringBuffer groupquery = new StringBuffer();
StringBuffer tagsquery = new StringBuffer();
StringBuffer goodsquery = new StringBuffer();
StringBuffer cmexquery =new StringBuffer();
String strLine = System.getProperty("line.separator");
for(String layout:layouts){
	groupquery.setLength(0);
	groupquery.append(" select group_id, title1,title2, layout from "+strLine);
	groupquery.append(" tbl_sp_exh_group"+suffix+strLine);
	groupquery.append(" where "+strLine);
	groupquery.append(" exh_id = ? "+strLine);
	groupquery.append(" and layout = ? "+strLine);
	groupquery.append(" order by  sort asc "+strLine);
	//out.println(String.valueOf(exh_id));
	//out.print(groupquery);
	DBDataTable dtgroup = new DBWrap("main2004").setQuery(groupquery.toString()).addParameter(exh_id).addParameter(layout).selectAllTry();
//	DBDataTable dtgroup = new DBWrap("main2004").setQuery(groupquery).selectAllTry();
	JSONArray jsonGroup = dtgroup.toJson();

	String goodsjson = "";

	String[][] cmex_more = new String[][]{
		new String[]{"/cmexhibition/exhibition_view_E.jsp?adsNo=551","/mobilefirst/planlist.jsp?t=B_20170830111111&freetoken=plan"},
		new String[]{"/cmexhibition/exhibition_view_E.jsp?adsNo=557","/mobilefirst/planlist.jsp?t=B_20170901099999&freetoken=plan"},
		new String[]{"/cmexhibition/exhibition_view_E.jsp?adsNo=558","/mobilefirst/planlist.jsp?t=B_20170816202020&freetoken=plan"},
		new String[]{"/cmexhibition/exhibition_view_E.jsp?adsNo=571","/mobilefirst/planlist.jsp?t=B_20170818091801&freetoken=plan"},
		new String[]{"/cmexhibition/exhibition_view_E.jsp?adsNo=564","/mobilefirst/planlist.jsp?t=B_2017090121112&freetoken=plan"},
	};
	/*
	String[][] cmex_more = new String[][]{
		new String[]{"http://www.enuri.com/list.jsp?cate=1501","/mobilefirst/list.jsp?cate=1501&freetoken=list"},
		new String[]{"http://www.enuri.com/list.jsp?cate=080106","/mobilefirst/list.jsp?cate=080106&freetoken=list"},
		new String[]{"http://www.enuri.com/list.jsp?cate=0810","/mobilefirst/list.jsp?cate=0810&freetoken=list"},
		new String[]{"http://www.enuri.com/list.jsp?cate=1452","/mobilefirst/list.jsp?cate=1452&freetoken=list"},
		new String[]{"http://www.enuri.com/list.jsp?cate=164715","/mobilefirst/list.jsp?cate=164715&freetoken=list"},
		new String[]{"http://www.enuri.com/list.jsp?cate=164716","/mobilefirst/list.jsp?cate=164716&freetoken=list"},
	};
	*/
	for (int i=0;i<dtgroup.count();i++){
		String group_id = dtgroup.parse(i,"GROUP_ID","0");

		tagsquery.setLength(0); 
		tagsquery.append(" select "+strLine);
		tagsquery.append(" keyword,p_url,m_url "+strLine);
		tagsquery.append(" from tbl_sp_exh_tag"+suffix+strLine);
		tagsquery.append(" where "+strLine);
		tagsquery.append(" display='Y' "+strLine);
		tagsquery.append(" and group_id = ? "+strLine);
		tagsquery.append(" order by sort asc "+strLine);

		DBDataTable dttags = new DBWrap("main2004").setQuery(tagsquery.toString()).addParameter(group_id).selectAllTry();
		((JSONObject) jsonGroup.get(i)).put("TAGS", dttags.toJson());
		//*********************
		String adsQuery = "select max(adsno) adsno from tbl_sp_exh_cmex_ads"+suffix+" where group_id = ? "+strLine;

		DBDataTable dtAds = new DBWrap("main2004").setQuery(adsQuery).addParameter(group_id).selectAllTry();
		((JSONObject) jsonGroup.get(i)).put("CMEX_ADSNO", dtAds.parse(0,"ADSNO",-1));
		//*********************
		goodsquery.setLength(0);

		goodsquery.append("select t.* "+strLine);
		goodsquery.append("       , (select max(shop_code) "+strLine);
		goodsquery.append("            from tbl_pricelist "+strLine);
		goodsquery.append("           where modelno = t.modelno "+strLine);
		goodsquery.append("             and price = t.minprice "+strLine);
		goodsquery.append("             and status in ( '0', '8', '9' ) "+strLine);
		goodsquery.append("             and srvflag in ( '0', 'L', 'R' ) "+strLine);
		goodsquery.append("             and price > 0)                               as PC_MINSHOP "+strLine);
		goodsquery.append("       , (select max(shop_code) "+strLine);
		goodsquery.append("            from tbl_pricelist "+strLine);
		goodsquery.append("           where modelno = t.modelno "+strLine);
		goodsquery.append("             and instance_price = t.minprice3 "+strLine);
		goodsquery.append("             and status in ( '0', '8', '9' ) "+strLine);
		goodsquery.append("             and srvflag in ( '0', 'L', 'R', 'M' ) "+strLine);
		goodsquery.append("             and instance_price > 0)                      as MOBILE_MINSHOP "+strLine);
		goodsquery.append("       , (select max(shop_name) "+strLine);
		goodsquery.append("            from tbl_shoplist "+strLine);
		goodsquery.append("           where shop_code = (select max(shop_code) "+strLine);
		goodsquery.append("                                from tbl_pricelist "+strLine);
		goodsquery.append("                               where modelno = t.modelno "+strLine);
		goodsquery.append("                                 and price = t.minprice "+strLine);
		goodsquery.append("                                 and status in ( '0', '8', '9' ) "+strLine);
		goodsquery.append("                                 and srvflag in ( '0', 'L', 'R' ) "+strLine);
		goodsquery.append("                                 and price > 0))          as PC_MINSHOP_NAME "+strLine);
		goodsquery.append("       , (select max(shop_name) "+strLine);
		goodsquery.append("            from tbl_shoplist "+strLine);
		goodsquery.append("           where shop_code = (select max(shop_code) "+strLine);
		goodsquery.append("                                from tbl_pricelist "+strLine);
		goodsquery.append("                               where modelno = t.modelno "+strLine);
		goodsquery.append("                                 and instance_price = t.minprice3 "+strLine);
		goodsquery.append("                                 and status in ( '0', '8', '9' ) "+strLine);
		goodsquery.append("                                 and srvflag in ( '0', 'L', 'R', 'M' ) "+strLine);
		goodsquery.append("                                 and instance_price > 0)) as MOBILE_MINSHOP_NAME "+strLine);
		goodsquery.append("  from (select distinct exh_goods.goods_type "+strLine);
		goodsquery.append("                        , exh_goods.modelno "+strLine);
		goodsquery.append("                        , 'http://storage.enuri.info/pic_upload/sp_exh/'  || exh_goods.img_src as IMG_SRC "+strLine);
		goodsquery.append("                        , exh_goods.title1 "+strLine);
		goodsquery.append("                        , exh_goods.title2 "+strLine);
		goodsquery.append("                        , exh_goods.url "+strLine);
		goodsquery.append("                        , exh_goods.url_mobile "+strLine);
		goodsquery.append("                        , exh_goods.sort "+strLine);
		goodsquery.append("                        , b.minprice           as MINPRICE "+strLine);
		goodsquery.append("                        , b.minprice3          as MINPRICE3 "+strLine);
		goodsquery.append("          from tbl_sp_exh_goods"+suffix+" exh_goods "+strLine);
		goodsquery.append("               left outer join tbl_goods goods on exh_goods.modelno = goods.modelno "+strLine);
		goodsquery.append("               left join dbenuri.tbl_goods_sum b "+strLine);
		goodsquery.append("                      on goods.modelno = b.modelno "+strLine);
		goodsquery.append("                         and exh_goods.goods_type = 'M' "+strLine);
		goodsquery.append("         where exh_goods.group_id = ? "+strLine);
		goodsquery.append("           and exh_goods.display = 'Y') t "+strLine);
		goodsquery.append(" order by t.sort asc");
		//*********************
		//System.out.println(goodsquery.toString());
		DBDataTable dtgoods = new DBWrap("main2004").setQuery(goodsquery.toString()).addParameter(group_id).selectAllTry();

		// out.println(goodsquery.toString());
		// out.println("===");
		for (int j=0;j<dtgoods.count();j++){
			int nModelno = dtgoods.parse(j,"MODELNO",0);
			dtgoods.get(j).put("GOODS_IMG", getGoodsImgSrc(nModelno));

			String pc_minshop = dtgoods.parse(j,"PC_MINSHOP","");
			if (pc_minshop.equals("") == false){
				pc_minshop = "http://img.enuri.info/images/home/malllogo/" + pc_minshop + "_m.jpg";
			}

			dtgoods.get(j).put("PC_MINSHOP_LOGO", pc_minshop);

			String mobile_minshop = dtgoods.parse(j,"MOBILE_MINSHOP","");
			if (mobile_minshop.equals("") == false){
				mobile_minshop = "http://img.enuri.info/images/home/malllogo/" + mobile_minshop + "_m.jpg";
			}

			dtgoods.get(j).put("MOBILE_MINSHOP_LOGO", mobile_minshop);
		}


		((JSONObject) jsonGroup.get(i)).put("GOODS", dtgoods.toJson());

		cmexquery.setLength(0);

		
		cmexquery.append("select * "+strLine);
		cmexquery.append("  from (select * "+strLine);
		cmexquery.append("          from (select t1.modelno "+strLine);
		cmexquery.append("                       , t1.modelname "+strLine);
		cmexquery.append("                       , (select min(b.minprice) "+strLine);
		cmexquery.append("                            from dbenuri.tbl_goods a "+strLine);
		cmexquery.append("                                 left join dbenuri.tbl_goods_sum b "+strLine);
		cmexquery.append("                                        on a.modelno = b.modelno "+strLine);
		cmexquery.append("                           where t1.modelno = a.modelno) as MINPRICE "+strLine);
		cmexquery.append("                       , (select min(b.minprice3) "+strLine);
		cmexquery.append("                            from dbenuri.tbl_goods a "+strLine);
		cmexquery.append("                                 left join dbenuri.tbl_goods_sum b "+strLine);
		cmexquery.append("                                        on a.modelno = b.modelno "+strLine);
		cmexquery.append("                           where t1.modelno = a.modelno) as MINPRICE3 "+strLine);
		cmexquery.append("                       , (select min(factory) "+strLine);
		cmexquery.append("                            from tbl_goods "+strLine);
		cmexquery.append("                           where t1.modelno = modelno)   as FACTORY "+strLine);
		cmexquery.append("                       , (select max(nvl(b.mallcnt3, b.mallcnt)) "+strLine);
		cmexquery.append("                            from dbenuri.tbl_goods a "+strLine);
		cmexquery.append("                                 left join dbenuri.tbl_goods_sum b "+strLine);
		cmexquery.append("                                        on a.modelno = b.modelno "+strLine);
		cmexquery.append("                           where t1.modelno = a.modelno) as MALLCNT "+strLine);
		cmexquery.append("                       , ''                              as DELIVERYINFO "+strLine);
		cmexquery.append("                  from (select t3.* "+strLine);
		cmexquery.append("                          from tbl_cmex_ads_ex_bannertitle t1 "+strLine);
		cmexquery.append("                               , tbl_cmex_ads_ex_detail t2 "+strLine);
		cmexquery.append("                               , tbl_cmex_ads_ex_goods t3 "+strLine);
		cmexquery.append("                         where t1.adsbannertitleno = t2.adsbannertitleno "+strLine);
		cmexquery.append("                           and t1.detailtabtype = t2.tabtype "+strLine);
		cmexquery.append("                           and t2.detailno = t3.detailno "+strLine);
		cmexquery.append("                           and t3.useyn = 'Y' "+strLine);
		cmexquery.append("                           and adsno in (select adsno "+strLine);
		cmexquery.append("                                           from tbl_sp_exh_cmex_ads"+suffix+strLine);
		cmexquery.append("                                          where group_id = ?) "+strLine);
		cmexquery.append("                        union "+strLine);
		cmexquery.append("                        select t3.* "+strLine);
		cmexquery.append("                          from tbl_cmex_ads_ex_bannertitle t1 "+strLine);
		cmexquery.append("                               , tbl_cmex_ads_ex_goods t3 "+strLine);
		cmexquery.append("                         where t1.adsbannertitleno = t3.adsbannertitleno "+strLine);
		cmexquery.append("                           and t3.useyn = 'Y' "+strLine);
		cmexquery.append("                           and adsno in (select adsno "+strLine);
		cmexquery.append("                                           from tbl_sp_exh_cmex_ads"+suffix+strLine);
		cmexquery.append("                                          where group_id = ?)) t1 ");
		cmexquery.append("                 order by dbms_random.random) t ");
		cmexquery.append("         where minprice > 0 ");
		cmexquery.append("           and minprice3 > 0) t ");
		cmexquery.append(" where rownum <= 4");


		DBDataTable dtcmex = new DBWrap("main2004").setQuery(cmexquery.toString()).addParameter(group_id).addParameter(group_id).selectAllTry();

		for (int j=0;j<dtcmex.count();j++){
			int nModelno = dtcmex.parse(j,"MODELNO",0);
			dtcmex.get(j).put("GOODS_IMG", getGoodsImgSrc(nModelno));


			String pc_minshop = dtcmex.parse(j,"PC_MINSHOP","");
			if (pc_minshop.equals("") == false){
				pc_minshop = "http://img.enuri.info/images/home/malllogo/" + pc_minshop + "_m.jpg";
			}

			dtcmex.get(j).put("PC_MINSHOP_LOGO", pc_minshop);

			String mobile_minshop = dtcmex.parse(j,"MOBILE_MINSHOP","");
			if (mobile_minshop.equals("") == false){
				mobile_minshop = "http://img.enuri.info/images/home/malllogo/" + mobile_minshop + "_m.jpg";
			}

			dtcmex.get(j).put("MOBILE_MINSHOP_LOGO", mobile_minshop);
		}

		((JSONObject) jsonGroup.get(i)).put("CMEX_GOODS", dtcmex.toJson());

		try{
			((JSONObject) jsonGroup.get(i)).put("CMEX_MORE_PC", cmex_more[i][0]);
			((JSONObject) jsonGroup.get(i)).put("CMEX_MORE_MOBILE", cmex_more[i][1]);

		}catch(Exception ex){}
	}
	jret.put(layout, jsonGroup);
	//jret.add(jsonGroup);
}
//*******************************
// 하드코딩 배너.
// 타이틀, 이미지, 링크. (모바일용 이미지하고 링크 있으면 여기 추가.)
String[][] banners = new String[][]{
new String[]{"아이디어 주방용품","/mobilefirst/news_detail.jsp?kbno=654727"},
new String[]{"빈집 지키기","/mobilefirst/news_detail.jsp?kbno=655593"},
new String[]{"외식상품권","/mobilefirst/list.jsp?cate=164716&freetoken=list"},
new String[]{"판매1등! 스팸8호","/mobilefirst/detail.jsp?modelno=12438669&freetoken=vip"},
new String[]{"딱! 선물용 하루견과","/mobilefirst/detail.jsp?modelno=11972813&freetoken=vip"},
new String[]{"CJ 한뿌리","/mobilefirst/detail.jsp?modelno=727826&freetoken=vip"},
new String[]{"~1만원대 선물","/mobilefirst/planlist.jsp?t=B_20170906110001&freetoken=plan"},
new String[]{"생활용품 선물세트","/mobilefirst/list.jsp?cate=080824&freetoken=list"},
new String[]{"화장품 세트","/mobilefirst/list.jsp?cate=080106&freetoken=list"},
new String[]{"온가족 보드게임","/mobilefirst/list.jsp?cate=164404&freetoken=list"},
};

JSONArray jaBanners = new JSONArray();

int cnt = 0;
for (String[] banner:banners){
	JSONObject joBanner = new JSONObject();
	joBanner.put("TITLE", banner[0]);
	joBanner.put("MOBILE_URL", banner[1]);
	jaBanners.add(joBanner);
	cnt++;

}
JSONArray sa = new JSONArray();

Collections.shuffle(jaBanners);

for(int i =0 ; i < jaBanners.size() ; i ++ ){
	sa.add(jaBanners.get(i));
	if ( i == 4) break;
}

//System.out.println("i : "+sa.size());

jret.put("B", sa);


JSONArray moreArray = new JSONArray();


jret.put("more", moreArray);


JSONArray tipArray = new JSONArray();


jret.put("tip", tipArray);


out.print(jret.toJSONString());
%>