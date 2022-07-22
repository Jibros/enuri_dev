<%@page import="com.enuri.exception.ExceptionManager"%>
<%@page import="com.enuri.bean.main.Goods_Detail_Proc"%>
<%@page import="com.enuri.bean.main.Goods_Detail_Data"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.enuri.bean.event.DBWrap"%>
<%@page import="java.util.Arrays"%>
<%@page import="org.json.JSONObject"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.JSONArray"%>
<%@page import="com.enuri.bean.mobile.Mobile_GoodsToPricelist_Proc"%>
<h8>오늘의에누리<h8>
<%
	Mobile_GoodsToPricelist_Proc mgp = new Mobile_GoodsToPricelist_Proc();
	
	//String spm_cd = ChkNull.chkStr(request.getParameter("scode")); //업체코드
	String kncd = "B";	//B 특가모음 , H 핫딜베스트
	//String cate = ChkNull.chkStr(request.getParameter("cate")); //카테고리
	String cate = "";
	String kind = ChkNull.chkStr(request.getParameter("kind"),"1"); //카테고리

	String ssg = "47";	
	String interpark = "55";//	인터파크
	String gmarket = "536";//	G마켓
	String cj =  "806";    //CJmall
	String nsmall = "974";//nsmall
	String auction = "4027"; //옥션
	String st11 = "5910"; //11번가
	
	String[] VALUES = new String[] {ssg, interpark ,gmarket ,cj ,nsmall ,auction ,st11  };
	
	JSONArray jSONArray = new JSONArray();
	
	int cnt = 0;
	
	for (String v : VALUES) {
		
		if( v.equals("806") || v.equals("974") || v.equals("47") )	kncd = "H";
		else										     			kncd = "B";
		
		jSONArray = mgp.getTodayEnuriGoods(v, kncd, cate );
		
		for(int i = 0 ; i < jSONArray.length() ; i++ ){
			
			JSONObject json = jSONArray.getJSONObject(i);
			
			String cate_cd = json.getString("CATE_CD");
			String model_no = json.getString("MODEL_NO");
			String gd_nm = json.getString("GD_NM");
			String gd_prc = json.getString("GD_PRC");
			//int spm_prc = Integer.parseInt(json.getString("DC_BF_PRC"));
			String spm_cd = json.getString("SPM_CD");
			
			int enr_pp_rnk = json.getInt("RANK");
			long enr_min_prc = json.getLong("MINPRICE");
			long enr_man_prc = json.getLong("MAXPRICE");;
			String enr_reg_dtm = json.getString("C_DATE");
			//System.out.println("C_DATE:"+json.getString("C_DATE"));
			int gd_evl_cnt = json.getInt("BBS_NUM");  //상품평 수
			int odr_cnt = json.getInt("SUM_SALE_CNT");
			
			HashMap map = new HashMap (); 
			map = min_maxPrice(model_no+"" ,enr_min_prc+"");
			
			//out.println("modelno:"+model_no +" ====== "+ map.toString());
			
			long showMaxPrice = (Long)map.get("showMaxPrice");
			long showMinPrice = (Long)map.get("showMinPrice");
			
			//enr_min_prc
			StringBuilder sb = new StringBuilder();
			sb.append(" insert into TB_EXH_COLC_MODEL  (	");
			sb.append("		exh_colc_no , cate_cd , model_no ,	gd_nm ,	spm_prc , ");
			sb.append("		enr_min_prc , enr_man_prc , spm_cd , enr_reg_dtm , 	enr_pp_rnk ,");
			sb.append("		gd_evl_cnt , odr_cnt, ins_dtm   ");
			sb.append("		) " );
			sb.append(" values (  SQ_EXH_COLC_NO.nextval , ? , ? , ? , ?    , ? , ? , ? , ? , ?   , ? , ? ,  sysdate )");
			
			boolean result =  new DBWrap("main2004").setQuery(sb.toString())
			.addParameter(cate_cd).addParameter(model_no).addParameter(gd_nm).addParameter(gd_prc)
			.addParameter(showMinPrice).addParameter(showMaxPrice).addParameter(spm_cd).addParameter(enr_reg_dtm).addParameter(enr_pp_rnk)
			.addParameter(gd_evl_cnt).addParameter(odr_cnt)
			.CUDTry();
			
			/*
			map.put("cate_cd : ",cate_cd);
			map.put("model_no : ",model_no);
			map.put("gd_nm : ",gd_nm);
			map.put("gd_prc : ",gd_prc);
			map.put("showMinPrice : ",showMinPrice);
			map.put("showMaxPrice : ",showMaxPrice);
			map.put("spm_cd : ",spm_cd);
			map.put("enr_reg_dtm : ",enr_reg_dtm);
			map.put("enr_pp_rnk : ",enr_pp_rnk);
			map.put("gd_evl_cnt : ",gd_evl_cnt);
			map.put("odr_cnt : ",odr_cnt);
			*/
			cnt++;
		}
	}
	out.println("cnt"+cnt);
%>
<%!
public HashMap min_maxPrice(String modelno , String minPriceStr   ) throws ExceptionManager  {

	Goods_Detail_Proc gdp = new Goods_Detail_Proc (); 
	
	int modelNo =  Integer.parseInt(modelno);
	int minprice =  Integer.parseInt(minPriceStr); 
	
	HashMap map = new HashMap (); 
	
	// showType=1 : 1개월, showType=3 : 3개월, showType=6 : 6개월
	int showType = 3;
	int dataGap = 1;
	int showMaxCnt = 6;
	int showGraphCnt = 0;
	
	int mTotalCnt = 0;
	Goods_Detail_Proc goods_detail_proc = new Goods_Detail_Proc();
	Goods_Detail_Data[] goods_detail_tot_data = gdp.Goods_Price_List_Showtype( modelNo , 6);
	if(goods_detail_tot_data!=null){
		mTotalCnt = goods_detail_tot_data.length;
	}

	Goods_Detail_Data[] goods_detail_data = gdp.Goods_Price_List_Showtype(modelNo, showType);

	if(goods_detail_data!=null) {
		long maxPrice = 0;
		long minPrice = 0;
		long showMaxPrice = 0;
		long showMinPrice = 0;
		int itemCnt = 0;
		int totalCnt = 0;
		int maxIdx = -1;
		int minIdx = -1;

		// 총 데이터의 개수를 구함
		for(int i=0; i<goods_detail_data.length; i++) {
			totalCnt++;
		}
		if(showType==0) {
			if(mTotalCnt<12) showType = 1;
			else showType = 3;
		}

		if(showType==1) showMaxCnt = 4;
		if(totalCnt>=6){
			if(showType==3) dataGap = totalCnt/6; // 2주 단위로 보여줌
			if(showType==6) dataGap = totalCnt/6; // 4주 단위로 보여줌
		}else dataGap = 1;
		
		// 최대값, 최저값을 먼저 구함
		for(int i=0; i<goods_detail_data.length; i=i+dataGap) {
			long wg_minprice = goods_detail_data[i].getWg_minprice();

			if(i==0) {
				maxPrice = wg_minprice;
				minPrice = wg_minprice;
			} else {
				if(maxPrice<=wg_minprice) {
					maxPrice = wg_minprice;
				}
				if(minPrice>=wg_minprice) {
					minPrice = wg_minprice;
				}
			}

			itemCnt++;

			if(itemCnt==showMaxCnt) break;
		}
		
		for(int i=0; i<goods_detail_data.length; i=i+dataGap) {
			long wg_minprice = goods_detail_data[i].getWg_minprice();
			if(maxPrice==wg_minprice) {
				maxIdx = i;
				break;
			}
		}
		for(int i=0; i<goods_detail_data.length; i=i+dataGap) {
			long wg_minprice = goods_detail_data[i].getWg_minprice();
			if(minPrice==wg_minprice) {
				minIdx = i;
				break;
			}
		}

		showMaxPrice = maxPrice;
		showMinPrice = minPrice;


		// 최저가와 최고가가 같으면 모든 가격이 같은 것임
		if(maxPrice==minPrice) {
			minPrice = 0;
			maxPrice = 0;
		}

		itemCnt = 0;
		// 거꾸로 출력해야 하기 때문에 변수에 담음
		String[] outDataAry = new String[showMaxCnt];
		for(int i=0; i<showMaxCnt; i++) {
			outDataAry[i] = "";
		}

		for(int i=(showMaxCnt-1); i>=0; i--) {
			if(outDataAry[i].length()>10) {
				showGraphCnt++;
			}
		}

		// 현재 가격
		
		showGraphCnt++;
		
		map.put("showMaxPrice", showMaxPrice);
		map.put("showMinPrice", showMinPrice);
		
	}
	return map;
}

%>