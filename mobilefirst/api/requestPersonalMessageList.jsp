<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding="utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="org.json.*"%>
<%@ page import="com.enuri.bean.mobile.depart.Save_Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@ include file="/include/IncSearch.jsp"%>
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%@ page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_PD_Data"%>
<%
	boolean bAdultKeyword = false;
	String strCate = "";
%>
<%@ include file="/include/IncAdultKeywordCheck_2010.jsp"%>

<%
	//20171113 손진욱 t1 pd 모듈
	PDManager_Proc pdmanager = new PDManager_Proc();
	PDManager_PD_Data pdData = pdmanager.chkT1PD(request);
	String deviceType = ChkNull.chkStr(request.getParameter("deviceType"), "");

	if (pdData != null) {
		
		String appId = "", appType = "";

		if (pdData.getAppid() != null && pdData.getAppid().length() == 5) {
			appType = pdData.getAppid().substring(0, 1);
			appId = pdData.getAppid().substring(1);
		}

		JSONArray minpriceList = getMinpriceList(appId, appType, pdData.getEnuri_id(), deviceType);
		out.println(minpriceList.toString(4));
	}

%>


<%!public JSONArray getMinpriceList(String appId, String appType, String strUserId, String deviceType) {
		Save_Goods_Proc save_goods_proc = new Save_Goods_Proc();
		Goods_Data[] goods_data = null;
		JSONObject result = new JSONObject();
		JSONArray goodsList = new JSONArray();

		int dateRange = 90; //30일 이내 리스트
		try {
			goods_data = save_goods_proc.getSendMinpriceDataList(appId, appType, strUserId, dateRange);
		} catch (Exception e) {
		}
	

		if (goods_data != null && goods_data.length > 0) {
			String msgType = "M";

			for (Goods_Data data : goods_data) {
				int modelno = data.getModelno();
				long p_pl_no = data.getP_pl_no();
				String ca_code = data.getCa_code();
				String modelnm = data.getModelnm();
				long minprice = data.getMinprice3();
				int sale_cnt = data.getSale_cnt();
				String factory = data.getFactory();
				String imgchk = data.getImgchk();
				String p_imgurl = data.getP_imgurl();
				int gb1_no = data.getGb1_no();
				String url1 = data.getUrl1();
				String p_imgurlflag = data.getP_imgurlflag();
				String smallImageUrl = "";
				String middleImageUrl = "";

				try {
					smallImageUrl = ImageUtil.getImageSrc(CutStr.cutStr(ca_code, 4), modelno, imgchk, p_pl_no,
							p_imgurl, p_imgurlflag);
					middleImageUrl = ImageUtil.getImageSrc(CutStr.cutStr(ca_code, 4), modelno, imgchk, p_pl_no,
							p_imgurl, p_imgurlflag);
				} catch (Exception e) {
					//ignore
				}

				String strImageurl_middle = middleImageUrl;
				String smallImgUrlFinder = "/data/images/service/small/";
				int smallFinderIdx = middleImageUrl.indexOf(smallImgUrlFinder);
				String strConstrain = data.getStrConstrain();
				String p_imgurl2 = data.getP_imgurl2();

				// 500이미지로 변경
				if (smallFinderIdx > -1) {
					strImageurl_middle = middleImageUrl.substring(0, smallFinderIdx);
					strImageurl_middle += "/data/images/service/middle/";
					strImageurl_middle += middleImageUrl.substring(smallFinderIdx + smallImgUrlFinder.length());
					int lastDotIdx = strImageurl_middle.lastIndexOf(".");
					strImageurl_middle = strImageurl_middle.substring(0, lastDotIdx) + ".jpg";
				}

				if (!strConstrain.equals("5")) {
					middleImageUrl = strImageurl_middle;
				} else {
					middleImageUrl = data.getP_imgurl2();
				}

				String strFactory = ChkNull.chkStr(data.getFactory());
				String strBrand = ChkNull.chkStr(data.getBrand());
				int mallcnt = data.getMallcnt3();
				String strAdultCookie = "";
				String adultImageFlag = "N";

				if (modelno > 0) {
					if (ca_code != null && ca_code.length() > 0 && isAdultCate(ca_code)) { //성인용품
						adultImageFlag = "Y";
					}
				} else {
					String strTmp_img = getSearchGoodsImage(true, "1", smallImageUrl, false);
					if (strTmp_img.indexOf("2012/search/19_50.gif") > -1) {
						adultImageFlag = "Y";
					}
				}

				// 출시일
				String c_date = data.getC_date();
				c_date = CutStr.cutStr(c_date, 10);
				String c_dateStr = c_date;

				if (c_dateStr.length() == 10) {
					Calendar calend = Calendar.getInstance();
					String nowYear = calend.get(Calendar.YEAR) + "";
					// 현재 년도랑 같을 경우에만  년, 월로 표시
					if (c_dateStr.substring(0, 4).equals(nowYear)) {
						c_dateStr = c_dateStr.substring(2, 7);
						c_dateStr = ReplaceStr.replace(c_dateStr, "-0", "-");
					} else {
						c_dateStr = c_dateStr.substring(2, 4);
					}
				}

				if (c_dateStr.indexOf("-") > -1) {
					c_dateStr = "'" + ReplaceStr.replace(c_dateStr, "-", "년 ") + "월";
				} else {
					c_dateStr = "'" + c_dateStr + "년";
				}

				if (modelno > 0) {
					String strModelnmText[] = getModel_FBN(ca_code, modelnm, strFactory, strBrand);
					String strNm_factory = toJS2(strModelnmText[1]);
					String strNm_brand = toJS2(strModelnmText[2]);
					String strNm_model = toJS2(strModelnmText[0]);
					if (!ca_code.equals("93")) {
						if (strNm_model.lastIndexOf("[") > 0) {
							strNm_model = strNm_model.substring(0, strNm_model.lastIndexOf("["));
						}
					}

					String modelName = strNm_factory + " " + strNm_brand + " " + strNm_model;
					modelnm = toJS2(modelName.replace("  ", " ").trim());
				}

				modelnm = ReplaceStr.replace(modelnm, "[일반]", "");

				// 모델명과 조건명[ 사이 한칸 공백
				modelnm = ReplaceStr.replace(modelnm, "[", " [");
				if (modelnm.length() > 0) {

					String minPriceText = "";

					// PC 판매업체 수 == 1, 모바일 판매업체 수 == 0, 현재 날짜가 출시일보다 미래일 경우
					if (data.getMallcnt() == 1 && data.getMallcnt3() == 0
							&& DateUtil.getDaysBetween(c_date, DateStr.nowStr()) > 0) {
						minPriceText = "출시예정";
						c_dateStr = "출시예정";
					} else if (data.getMallcnt3() == 0 && minprice == 0) {
						minPriceText = "단종/품절";
					} else if (p_pl_no == 0) {
						c_dateStr += " 출시";
					}

					/*
					if(mallcnt==1 && DateUtil.getDaysBetween(c_date,DateStr.nowStr())>0) {
						minPriceText = "미정";
						mallcnt = 0;
					}
					else {
						if ((CutStr.cutStr(ca_code,4).equals("0304") || CutStr.cutStr(ca_code,4).equals("0305") || CutStr.cutStr(ca_code,4).equals("0353")) && minprice==0){
							minPriceText = "클릭";
							if(deviceType.equals("m") && data.getMallcnt3()==0){
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
					
					if(c_dateStr.indexOf("예정") > -1) {
					     minPriceText = "출시예정";
					     c_dateStr = "출시예정";
					}
					 */

					try {

						JSONObject object = new JSONObject();

						object.put("msgType", msgType);
						object.put("modelno", String.valueOf(modelno));
						object.put("p_pl_no", p_pl_no);
						object.put("adultImageFlag", adultImageFlag);
						object.put("real_price", minprice);
						object.put("push_price", data.getAlarmPushPrice());
						object.put("modelnm", modelnm);
						object.put("imgurl", p_imgurl);
						object.put("ca_code", ca_code);
						object.put("c_date", c_date);
						object.put("smallImageUrl", smallImageUrl);
						object.put("middleImageUrl", middleImageUrl);
						object.put("pList_modelno", data.getModelno_group());
						object.put("minprice_regdate", data.getMinpriceRegDate());
						object.put("c_dateStr", c_dateStr);
						object.put("minPriceText", minPriceText);
						object.put("alarm_minprice", data.getAlarmMinprice());
						object.put("send_date", data.getSendDate());

						//모바일용 판매업체 수
						object.put("mallcnt", data.getMallcnt3());

						goodsList.put(object);
					} catch (JSONException e) {
						continue;
					}
				}

			}
		}
		return goodsList;
	}%>

