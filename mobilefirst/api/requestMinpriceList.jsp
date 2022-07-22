<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding="utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.depart.Save_Goods_Proc"%>
<%@ page import="com.enuri.bean.mobile.depart.Save_Goods_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
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
%>
{
<%
		int dataType = Integer.parseInt(ChkNull.chkStr(request.getParameter("dataType"), "1"));
		int appType = Integer.parseInt(ChkNull.chkStr(request.getParameter("appType"), "1"));
		String pageString = ChkNull.chkStr(request.getParameter("pageNum"), "1");
		if (pageString.equals("NaN"))
			pageString = "1";
		// 페이징 관련 추가
		int pageNum = 1;
		int pageGap = 50;
		int totalCnt = 0;
		int allTotalCnt = 0;
		int pageStart = (pageNum - 1) * pageGap + 1;
		int pageEnd = pageStart + pageGap - 1;
		int pageMax = 1;
		String listTypeStr = ChkNull.chkStr(request.getParameter("listType"), "1");
		String folder_idStr = ChkNull.chkStr(request.getParameter("folder_id"), "0");
		String paramFolder = ChkNull.chkStr(request.getParameter("folder"), "all");
		String strUserId = pdData.getEnuri_id();
		String mailYN = ChkNull.chkStr(request.getParameter("mailYN"), "");
		String goodsNumList = ChkNull.chkStr(request.getParameter("goodsNumList"), "");
		// listType:1 최근본
		// listType:2 찜
		// listType:9 검색에서 최근본 보기
		int listType = 1;
		int folder_id = 0;
		try {
			listType = Integer.parseInt(listTypeStr);
		} catch (Exception e) {
		}
		try {
			folder_id = Integer.parseInt(folder_idStr);
		} catch (Exception e) {
		}
		int goodsCnt = 0;
		long priceSum = 0;
		Save_Goods_Proc save_goods_proc = new Save_Goods_Proc();
		Goods_Data[] goods_data = null;
		Save_Goods_Data[] save_goods_folder = null;

		// 찜 상품일 때 폴더 정보 읽어옴
		totalCnt = save_goods_proc.getSaveGoodListCnt(strUserId, folder_id);
		allTotalCnt = save_goods_proc.getSaveGoodListCnt(strUserId, 0);
		pageMax = (int) Math.ceil((double) totalCnt / pageGap);

		String minAppId = "", minAppType = "";

		if (pdData.getAppid() != null && pdData.getAppid().length() == 5) {
			minAppType = pdData.getAppid().substring(0, 1);
			minAppId = pdData.getAppid().substring(1);
		}

		try {
			goods_data = save_goods_proc.getSaveGoodListWithMinpriceAlarm(minAppId, minAppType, strUserId);
		} catch (Exception e) {
		}
		//goods_data = save_goods_proc.getSaveGoodListWithMinpriceAlarm(strUserId);

		int totalLength = 0;
		totalLength = totalCnt;
		out.println("   \"myGoodsTotalCnt\":\"" + totalLength + "\",");
		out.println("   \"myGoodsAllTotalCnt\":\"" + allTotalCnt + "\",");
		if (goods_data != null && goods_data.length > 0) {
			String strSearckKeywordSynonym = "";
			out.println("   \"goodsList\": [");
			boolean listFirstPrintFlag = false;
			for (int i = 0; i < goods_data.length; i++) {
				Goods_Data data = goods_data[i];

				int modelno = data.getModelno();
				long p_pl_no = data.getP_pl_no();
				String ca_code = data.getCa_code();
				String modelnm = data.getModelnm().replaceAll("\"", "\\\\\"");
				long minprice = data.getMinprice3();
				int sale_cnt = data.getSale_cnt();
				String factory = data.getFactory();
				String imgchk = data.getImgchk();
				String p_imgurl = data.getP_imgurl();
				int gb1_no = data.getGb1_no();
				String url1 = data.getUrl1();
				String p_imgurlflag = data.getP_imgurlflag();
				String smallImageUrl = ImageUtil.getImageSrc(CutStr.cutStr(ca_code, 4), modelno, imgchk,
						p_pl_no, p_imgurl, p_imgurlflag);
				String middleImageUrl = ImageUtil.getImageSrc(CutStr.cutStr(ca_code, 4), modelno, imgchk,
						p_pl_no, p_imgurl, p_imgurlflag);
				String strImageurl_middle = middleImageUrl;
				String smallImgUrlFinder = "/data/images/service/small/";
				int smallFinderIdx = middleImageUrl.indexOf(smallImgUrlFinder);
				String strConstrain = data.getStrConstrain();
				//String strConstrain = "";
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
					java.util.Calendar calend = java.util.Calendar.getInstance();
					String nowYear = calend.get(cal.YEAR) + "";
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
					if (listFirstPrintFlag)
						out.print(",\r\n");
					// 금액의 총합을 구함
					priceSum += minprice;

					// 가격 정보 보여주기
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
					if(minPriceText.equals("미정")) {
					     c_dateStr = "출시예정";
					} else {
					     if(p_pl_no==0) {
					           c_dateStr += " 출시";
					     }
					}
					if(c_dateStr.indexOf("예정") > -1){
					     minPriceText = "출시예정";
					     c_dateStr = "출시예정";
					}
					 */

					out.println("              {");
					/* out.println("                \"modelno\":\""+modelno+"\", ");
					out.println("             \"p_pl_no\":\""+p_pl_no+"\", ");
					out.println("             \"pList_modelno\":\""+goods_data[i].getModelno_group()+"\", "); */

					out.println("             \"modelno\":\"" + modelno + "\", ");
					out.println("             \"p_pl_no\":\"" + p_pl_no + "\", ");
					out.println("           \"adultImageFlag\":\"" + adultImageFlag + "\", ");
					out.println("             \"price\":\"" + minprice + "\", ");
					out.println("             \"modelnm\":\"" + modelnm + "\", ");
					out.println("             \"imgurl\":\"" + p_imgurl + "\", ");
					out.println("             \"ca_code\":\"" + ca_code + "\", ");
					out.println("             \"c_date\":\"" + c_date + "\", ");
					out.println("             \"smallImageUrl\":\"" + smallImageUrl + "\", ");
					/* middleImageUrl 추가  */
					out.println("             \"middleImageUrl\":\"" + middleImageUrl + "\", ");
					out.println("             \"pList_modelno\":\"" + data.getModelno_group() + "\", ");
					out.println("             \"folder_id\":\"" + data.getFolder_id() + "\", ");
					out.println("             \"reg_date\":\"" + data.getModdate() + "\", ");
					//out.println("             \"c_date\":\""+c_date+"\", ");
					out.println("             \"c_dateStr\":\"" + c_dateStr + "\", ");
					out.println("             \"minPriceText\":\"" + minPriceText + "\", ");
					out.println("             \"alarm_minprice\":\"" + data.getAlarmMinprice() + "\", ");
					out.println("             \"push_yn\":\"" + data.getPushYn() + "\", ");
					out.println("             \"alarm_onoff\":\"" + data.getMinpriceAlarmOnOff() + "\", ");
					out.println("             \"minprice_regdate\":\"" + data.getMinpriceRegDate() + "\", ");
					out.println("             \"factory\":\"" + strFactory + "\" ");
					out.println("              }");

					goodsCnt++;
					listFirstPrintFlag = true;
				}
			}
			out.println("\r\n    ], ");
		}
		out.println("   \"goodsCnt\":\"" + goodsCnt + "\",");
		out.println("     \"priceSum\":\"" + FmtStr.moneyFormat(priceSum + "") + "\", ");
		if (strUserId.length() > 0) {
			save_goods_folder = save_goods_proc.getSaveFolderList(strUserId, true);
			if (save_goods_folder != null && save_goods_folder.length > 0) {
				out.println("     \"folderCnt\":\"" + save_goods_folder.length + "\",");
				out.println("   \"folderList\": [");
				for (int i = 0; i < save_goods_folder.length; i++) {
					if (save_goods_folder[i].getFolder_id() > 0) {
						if (i > 0)
							out.print(",\r\n");
						out.println("              {");
						out.println("             \"folder_id\":\"" + save_goods_folder[i].getFolder_id()
								+ "\", ");
						out.println("           \"folder_name\":\"" + "찜폴더" + (i + 1) + "\", ");
						//         out.println("             \"folder_name\":\""+save_goods_folder[i].getFolder_name()+"\", ");
						out.println("             \"folder_cnt\":\"" + save_goods_folder[i].getFolderItemCnt()
								+ "\" ");
						out.print("                }");
					}
				}
				out.println("\r\n    ]");
			}
		}
%>}

<%
	}
%>

