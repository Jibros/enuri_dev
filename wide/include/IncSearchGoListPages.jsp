<%@page import="com.enuri.util.common.ChkNull"%>
<%@ page import="com.enuri.bean.logdata.Srp_Log_Pc_Proc"%>
<%
	String strCaCode = "";
	String strReturnRedirectPage = "";

	/* 특정 단어와 복합된 키워드일때에도 분류검색이 되도록 처리 (toodoo 2008.06.16)
	 * 주의 : 복합단어를 앞쪽에 위치시켜주세요
	 * 		 그중 특정단어일때 정렬기준도 설정(기본 인기순정렬됩니다)
	 *		 /fashion/include/Inc_Fashion_SearchReturnCate.jsp 도 같이 수정해야함
	 **/
%>
	<%@include file="/lsv2016/include/IncMatchingKeyword.jsp"%>
<%
	String strGetLink = ChkNull.chkStr(request.getParameter("getlink"),"").trim();
	String strKeywordListGo = ConfigManager.RequestStr(request, "keyword", "");
	
	// 키워드의 특수문자 제거
	strKeywordListGo = ChkNull.StringReplace(strKeywordListGo);
	
	// 키워드 100글자 넘을경우 자르기
	if(strKeywordListGo.length()>100) {
		strKeywordListGo = strKeywordListGo.substring(0,100);
	}
	
	String keywordReplaceSet = ReplaceStr.replace(strKeywordListGo, "무료배송", "");
	strCaCode = getKeywordMatchingCategory(keywordReplaceSet, strMatchingCateAdd, strMatchingCateExcept);
	
	Search_Category_Proc search_category_proc = new Search_Category_Proc();
	String strSearchLogCate = "";
	if(strCaCode.trim().length()>0) {
		strReturnRedirectPage = getReturnRedirectPage(strCaCode, keywordReplaceSet);
		strSearchLogCate = strCaCode;
	} else {
		strReturnRedirectPage = getReturnBrandRedirectPage(keywordReplaceSet, strMatchingCateAdd);
	}
	if(strReturnRedirectPage.trim().length()==0) {
		strReturnRedirectPage = getExtendsSearchKeyword(keywordReplaceSet, strKeywordListGo);
	}
	if(strKeyword.trim().length()>0 && !strGetLink.equals("y")) {
		String strSearchHistoryEnagle = cb.GetCookie("MYSEARCHHISTORY2","NOSAVE");
		if(!strSearchHistoryEnagle.equals("n")) {
			String strSearchHistory = cb.GetCookie("MYSEARCHHISTORY2","SEARCHKEYWORD");
			String strSearchS = "";
			String strInsertSearchS = "";
			String strSearch1 = "";
			String strSearch2 = "";

			if(strCaCode.trim().length()>0) {
				strSearchS = "C:" + strKeyword+"__"+getDate();
			} else {
				strSearchS = "S:" + strKeyword+"__"+getDate();
			}
			strInsertSearchS = strSearchS;
			if(strSearchHistory!=null & "".equals(strSearchHistory)==false) {
				String astrSearchHistory[] = strSearchHistory.split("\\,");
				int intSearchHistoryCnt = astrSearchHistory.length;
				if(intSearchHistoryCnt>=12) {
					intSearchHistoryCnt = 12;
				}

				for(int si=0; si<intSearchHistoryCnt; si++) {
					strSearch1 = astrSearchHistory[si];
					strSearch2 = strSearchS;
					if(strSearch1.indexOf("__") > -1){
						strSearch1 = strSearch1.substring(0, strSearch1.indexOf("__"));
					}
					if(strSearch2.indexOf("__") > -1){
						strSearch2 = strSearch2.substring(0, strSearch2.indexOf("__"));
					}
					if (!strSearch1.equals(strSearch2)){
						strInsertSearchS = strInsertSearchS + ","+astrSearchHistory[si];
					}
				}
			}
			if(strInsertSearchS.trim().length()>0) {
				if(strInsertSearchS.substring(strInsertSearchS.length()-1,strInsertSearchS.length()).equals(",")) {
					strInsertSearchS = CutStr.cutStr(strInsertSearchS,strInsertSearchS.length()-1);
				}
			}
			cb.SetCookie("MYSEARCHHISTORY2", "SEARCHKEYWORD", strInsertSearchS);
			cb.SetCookieExpire("MYSEARCHHISTORY2", 3600*24*30);
			cb.responseAddCookie(response);

			String ipaddress = ChkNull.chkStr(ConfigManager.szConnectIp(request), "");
			String strTmpId = cb.GetCookie("MYINFO","TMP_ID");
			String userid = cb.GetCookie("MEM_INFO","USER_ID");

			//검색 키워드 로그 저장
			Srp_Log_Pc_Proc srpLogPcProc = new Srp_Log_Pc_Proc();
			srpLogPcProc.srpLogPcInsert(strTmpId, userid, ipaddress, strKeyword);
		}
	}

	if(strReturnRedirectPage.trim().length()>0 && strKeyword.indexOf("무료배송")>=0) {
		strReturnRedirectPage = strReturnRedirectPage + "&nocharge=Y";
	}
	String strKeywordRedirect = "";
	if(strKeyword.trim().equals("에누리닷컴") || strKeyword.trim().equals("에누리 닷컴") || strKeyword.trim().equals("에누리 닷 컴")) {
		strKeywordRedirect = "/etc/enuri_intro/Enuriintro.jsp";
	}
	if(strKeyword.trim().equals("꽃배달") || strKeyword.trim().equals("꽃배달서비스") || strKeyword.trim().equals("꽃배달 서비스") || strKeyword.trim().equals("꽃배달써비스") || strKeyword.trim().equals("꽃 배달서비스")
			 || strKeyword.trim().equals("꽃 배달") || strKeyword.trim().equals("축하화환") || strKeyword.trim().equals("축하 화환") || strKeyword.trim().equals("근조화환") || strKeyword.trim().equals("근조 화환")
			 || strKeyword.trim().equals("당일꽃배달") || strKeyword.trim().equals("당일 꽃배달") || strKeyword.trim().equals("당일배송 꽃") || strKeyword.trim().equals("당일꽃배달서비스") || strKeyword.trim().equals("당일 꽃배달서비스")
			 || strKeyword.trim().equals("개업화분") || strKeyword.trim().equals("개업 화분") || strKeyword.trim().equals("화환배달") || strKeyword.trim().equals("화환 배달") || strKeyword.trim().equals("화분배달")
			 || strKeyword.trim().equals("화분 배달")) {
		strKeywordRedirect = "/view/Flower_Easyflower.jsp?cate=&menu=false&flag=73";
	}
	/*
	#34714 보험 관련 예외처리 삭제
	if(strKeyword.trim().equals("보험비교") || strKeyword.trim().equals("보험")) {
		//strKeywordRedirect = "http://www.enuri.com/view/Insurance_Insvalley.jsp?rtnurl=http://insvalley.enuri.com/join_site/dmz_snu.jsp";
		strKeywordRedirect = "http://www.enuri.com/view/Insurance_Insvalley.jsp?rtnurl=http%3A%2F%2Fenuri.insvalley.com%2Fjoin_site%2Fdmz_snu.jsp";
	}
	if(strKeyword.trim().equals("의료실비")) {
		strKeywordRedirect = "http://www.enuri.com/view/Insurance_Insvalley.jsp?rtnurl=http%3A%2F%2Fenuri.insvalley.com%2Fjoin_site%2Fdmz_snu.jsp";
	}
	if(strKeyword.trim().equals("암보험")) {
		strKeywordRedirect = "http://www.enuri.com/view/Insurance_Insvalley.jsp?rtnurl=http%3A%2F%2Fenuri.insvalley.com%2Fjoin_site%2Fdmz_snu.jsp";
	}
	if(strKeyword.trim().equals("종신보험")) {
		strKeywordRedirect = "http://www.enuri.com/view/Insurance_Insvalley.jsp?rtnurl=http%3A%2F%2Fenuri.insvalley.com%2Fjoin_site%2Fdmz_snu.jsp";
	}
	if(strKeyword.trim().equals("정기보험")) {
		strKeywordRedirect = "http://www.enuri.com/view/Insurance_Insvalley.jsp?rtnurl=http%3A%2F%2Fenuri.insvalley.com%2Fjoin_site%2Fdmz_snu.jsp";
	}
	if(strKeyword.trim().equals("태아보험")) {
		strKeywordRedirect = "http://www.enuri.com/view/Insurance_Insvalley.jsp?rtnurl=http%3A%2F%2Fenuri.insvalley.com%2Fjoin_site%2Fdmz_snu.jsp";
	}
	if(strKeyword.trim().equals("어린이보험")) {
		strKeywordRedirect = "http://www.enuri.com/view/Insurance_Insvalley.jsp?rtnurl=http%3A%2F%2Fenuri.insvalley.com%2Fjoin_site%2Fdmz_snu.jsp";
	}
	if(strKeyword.trim().equals("운전자보험")) {
		strKeywordRedirect = "http://www.enuri.com/view/Insurance_Insvalley.jsp?rtnurl=http%3A%2F%2Fenuri.insvalley.com%2Fjoin_site%2Fdmz_snu.jsp";
	}
	if(strKeyword.trim().equals("상해보험")) {
		strKeywordRedirect = "http://www.enuri.com/view/Insurance_Insvalley.jsp?rtnurl=http%3A%2F%2Fenuri.insvalley.com%2Fjoin_site%2Fdmz_snu.jsp";
	}
	if(strKeyword.trim().equals("연금보험")) {
		strKeywordRedirect = "http://www.enuri.com/view/Insurance_Insvalley.jsp?rtnurl=http%3A%2F%2Fenuri.insvalley.com%2Fjoin_site%2Fdmz_snu.jsp";
	}
	if(strKeyword.trim().equals("건강보험")) {
		strKeywordRedirect = "http://www.enuri.com/view/Insurance_Insvalley.jsp?rtnurl=http%3A%2F%2Fenuri.insvalley.com%2Fjoin_site%2Fdmz_snu.jsp";
	}
	if(strKeyword.trim().equals("치아보험")) {
		strKeywordRedirect = "http://www.enuri.com/view/Insurance_Insvalley.jsp?rtnurl=http%3A%2F%2Fenuri.insvalley.com%2Fjoin_site%2Fdmz_snu.jsp";
	}
	if(strKeyword.trim().equals("저축보험")) {
		strKeywordRedirect = "http://www.enuri.com/view/Insurance_Insvalley.jsp?rtnurl=http%3A%2F%2Fenuri.insvalley.com%2Fjoin_site%2Fdmz_snu.jsp";
	}
	if(strKeyword.trim().equals("변액보험")) {
		strKeywordRedirect = "http://www.enuri.com/view/Insurance_Insvalley.jsp?rtnurl=http%3A%2F%2Fenuri.insvalley.com%2Fjoin_site%2Fdmz_snu.jsp";
	}
	if(strKeyword.trim().equals("실버보험")) {
		strKeywordRedirect = "http://www.enuri.com/view/Insurance_Insvalley.jsp?rtnurl=http%3A%2F%2Fenuri.insvalley.com%2Fjoin_site%2Fdmz_snu.jsp";
	}
	if(strKeyword.trim().equals("상조보험")) {
		strKeywordRedirect = "http://www.enuri.com/view/Insurance_Insvalley.jsp?rtnurl=http%3A%2F%2Fenuri.insvalley.com%2Fjoin_site%2Fdmz_snu.jsp";
	}
	if(strKeyword.trim().equals("화재보험")) {
		strKeywordRedirect = "http://www.enuri.com/view/Insurance_Insvalley.jsp?rtnurl=http%3A%2F%2Fenuri.insvalley.com%2Fjoin_site%2Fdmz_snu.jsp";
	}
	if(strKeyword.trim().equals("골프보험")) {
		strKeywordRedirect = "http://www.enuri.com/view/Insurance_Insvalley.jsp?rtnurl=http%3A%2F%2Fenuri.insvalley.com%2Fjoin_site%2Fdmz_snu.jsp";
	}
	*/

	if(strKeyword.trim().equals("호텔") || strKeyword.trim().equals("호텔예약") || strKeyword.trim().equals("해외호텔") || strKeyword.trim().equals("해외호텔예약")) {
		strKeywordRedirect = "/tour2012/Tour_Hotel.jsp";
	}
	if(strKeyword.trim().equals("제주도여행") || strKeyword.trim().equals("제주도항공권") || strKeyword.trim().equals("제주도렌트카") || strKeyword.trim().equals("제주도팬션") || strKeyword.trim().equals("제주도투어") ||
		strKeyword.trim().equals("제주여행") || strKeyword.trim().equals("제주항공권") || strKeyword.trim().equals("제주렌트카") || strKeyword.trim().equals("제주투어") || strKeyword.trim().equals("제주팬션") ||
		strKeyword.trim().equals("제주랜트카") || strKeyword.trim().equals("제주펜션")) {
		strKeywordRedirect = "/tour2012/Jeju_Tour.jsp";
	}
	if(strKeyword.trim().equals("이사짐센터") || strKeyword.trim().equals("이사견적") || strKeyword.trim().equals("이사") || strKeyword.trim().equals("인테리어견적")) {
		strKeywordRedirect = "/view/move_mall.jsp";
	}
	if(strKeyword.trim().equals("할인항공권") || strKeyword.trim().equals("여행") || strKeyword.trim().equals("여행사") || strKeyword.trim().equals("여행검색") || strKeyword.trim().equals("여행패키지")
			|| strKeyword.trim().equals("동남아여행") || strKeyword.trim().equals("동남아 여행") || strKeyword.trim().equals("항공권제주") || strKeyword.trim().equals("항공권 제주") || strKeyword.trim().equals("해외여행") 
			|| strKeyword.trim().equals("해외 여행") || strKeyword.trim().equals("해외여행패키지")) {
		strKeywordRedirect = "/tour2012/Tour_Index.jsp";
	}
	//#38875 [PC] 검색 시 강제이동 처리: e쿠폰 스토어, e쿠폰스토어. shwoo. 2020-03-16
	if(strKeyword.trim().equals("e쿠폰스토어") || strKeyword.trim().equals("e쿠폰 스토어") ) { //예외처리
		strKeywordRedirect = "/estore/estore.jsp";
	}
	if(strKeywordRedirect.trim().length()>0 && !strGetLink.equals("y")) {
		response.sendRedirect(strKeywordRedirect);
		return;
	}
	if(strKeyword.trim().equals("인기패션") && !strGetLink.equals("y")) { //예외처리
		response.sendRedirect(strReturnRedirectPage);
		return;
	}
	

	boolean isMatchingKeyOrd = false;
	if(!strReturnRedirectPage.equals("")) {
		if(!strMatchingCateAddOrdCdate.equals("")) {
			String[] arrMatchingCateAddOrdCdate = strMatchingCateAddOrdCdate.split(",");
			for(int j=0; j<arrMatchingCateAddOrdCdate.length; j++) {
				if(strKeyword.indexOf(arrMatchingCateAddOrdCdate[j])>=0) {
					strReturnRedirectPage = strReturnRedirectPage + "&key=c_date%2BDESC";
					isMatchingKeyOrd = true;
					break;
				}
			}
		}
		if(!isMatchingKeyOrd && !strMatchingCateAddOrdMprice.equals("")) {
			String[] arrMatchingCateAddOrdMprice = strMatchingCateAddOrdMprice.split(",");
			for(int k=0; k<arrMatchingCateAddOrdMprice.length; k++) {
				if(strKeyword.indexOf(arrMatchingCateAddOrdMprice[k])>=0) {
					strReturnRedirectPage = strReturnRedirectPage + "&key=minprice";
					isMatchingKeyOrd = true;
					break;
				}
			}
		}
		if(!isMatchingKeyOrd && !strMatchingCateAdd.equals("")) {
			String[] arrMatchingCateAddOrd = strMatchingCateAdd.split(",");
			for(int l=0; l<arrMatchingCateAddOrd.length; l++) {
				if(strKeyword.indexOf(arrMatchingCateAddOrd[l])>=0) {
					strReturnRedirectPage = strReturnRedirectPage + "&key=popular%2BDESC";
					break;
				}
			}
		}
	}

	if(strReturnRedirectPage.trim().length()>0) {
		strReturnRedirectPage = strReturnRedirectPage;
		if(ChkNull.chkStr(request.getParameter("hyphen_2"),"").trim().length()>0) {
			strReturnRedirectPage = strReturnRedirectPage + "&hyphen_2="+ChkNull.chkStr(request.getParameter("hyphen_2"),"").trim();
		}
		if(ChkNull.chkStr(request.getParameter("utm_source"),"").trim().length()>0) {
			strReturnRedirectPage = strReturnRedirectPage + "&utm_source="+ChkNull.chkStr(request.getParameter("utm_source"),"").trim();
		}
		if(ChkNull.chkStr(request.getParameter("utm_medium"),"").trim().length()>0) {
			strReturnRedirectPage = strReturnRedirectPage + "&utm_medium="+ChkNull.chkStr(request.getParameter("utm_medium"),"").trim();
		}
		if(ChkNull.chkStr(request.getParameter("utm_campaign"),"").trim().length()>0) {
			strReturnRedirectPage = strReturnRedirectPage + "&utm_campaign="+ChkNull.chkStr(request.getParameter("utm_campaign"),"").trim();
		}
		if(!strGetLink.equals("y")) {
			response.sendRedirect(strReturnRedirectPage);
			return;
		}
	}

	if(strGetLink.equals("y")) {
		if(strKeywordRedirect.trim().length()>0) {
			strReturnRedirectPage = strKeywordRedirect;
		}
		out.print(strReturnRedirectPage);
	}
%><%!
	private String getKeywordMatchingCategory(String strKeyword, String strMatchingCateAdd, String strMatchingCateExcept) throws Exception {
		strKeyword = ReplaceSpecialKeyWord(strKeyword);
		String[] arrMatchingCateAdd = strMatchingCateAdd.split(",");

		for(int i=0; i<arrMatchingCateAdd.length; i++) {
			if(arrMatchingCateAdd[i].length()>0){
				if(strKeyword.indexOf(arrMatchingCateAdd[i])>=0) {
					if(
						!(strKeyword.indexOf("상품권") >= 0 && arrMatchingCateAdd[i].equals("상품")) &&
						!(strKeyword.toUpperCase().indexOf("추천PC") >= 0 && arrMatchingCateAdd[i].equals("추천")) &&
						!(strKeyword.indexOf("추천컴퓨터") >= 0 && arrMatchingCateAdd[i].equals("추천")) &&
						!(strKeyword.indexOf("성인기저귀") >= 0 && arrMatchingCateAdd[i].equals("인기")) &&
						!(strKeyword.indexOf("반제품") >= 0 && arrMatchingCateAdd[i].equals("제품")) &&
						!(strKeyword.indexOf("완제품") >= 0 && arrMatchingCateAdd[i].equals("제품")) &&
						!(strKeyword.indexOf("인기브랜드") >= 0 && arrMatchingCateAdd[i].equals("인기")) &&
						!(strKeyword.indexOf("인기 브랜드") >= 0 && arrMatchingCateAdd[i].equals("인기")) &&
						!(strKeyword.indexOf("인기제조사") >= 0 && arrMatchingCateAdd[i].equals("인기")) &&
						!(strKeyword.indexOf("인기 제조사") >= 0 && arrMatchingCateAdd[i].equals("인기")) &&
						!(strKeyword.indexOf("성인기저기") >= 0 && arrMatchingCateAdd[i].equals("인기")) &&
						!(strKeyword.indexOf("인기향기") >= 0 && arrMatchingCateAdd[i].equals("인기")) &&
						!(strKeyword.indexOf("저가형") >= 0 && arrMatchingCateAdd[i].equals("저가")) &&
						!(strKeyword.indexOf("메신저가방") >= 0 && arrMatchingCateAdd[i].equals("저가")) &&
						!(strKeyword.indexOf("수저가방") >= 0 && arrMatchingCateAdd[i].equals("저가")) &&
						!(strKeyword.indexOf("침구매트") >= 0 && arrMatchingCateAdd[i].equals("구매")) &&
						!(strKeyword.indexOf("커피판매기") >= 0 && arrMatchingCateAdd[i].equals("판매")) &&
						!(strKeyword.indexOf("아이디어상품") >= 0 && arrMatchingCateAdd[i].equals("상품")) &&
						!(strKeyword.indexOf("초특가") >= 0 && arrMatchingCateAdd[i].equals("특가")) &&
						!(strKeyword.indexOf("전기장판매트") >= 0 && arrMatchingCateAdd[i].equals("판매")) &&
						!(strKeyword.indexOf("커피자동판매기") >= 0 && arrMatchingCateAdd[i].equals("판매"))
					) {
						strKeyword = ReplaceStr.replace(strKeyword,arrMatchingCateAdd[i],"");
						strKeyword = strKeyword.trim();
						break;
					}
				}
			} 
		}
		if(!strKeyword.equals(" ")) { //같은 단어가 띄어쓰기로 반복된 경우 하나만 남도록 처리
			int forCnt = 0;
			for(;;) {
				if(strKeyword.indexOf("  ")>=0 && forCnt<100) {
					strKeyword = ReplaceStr.replace(strKeyword, "  ", " ");
				} else {
					break;
				}
				forCnt++;
			}
			String[] arrKeyword = strKeyword.split(" ");

			for(int i=0; i<arrKeyword.length; i++) {
				if(i==0) {
					strKeyword = arrKeyword[i];
				} else {
					if(!strKeyword.equals(arrKeyword[i])) {
						strKeyword += " " + arrKeyword[i];
					}
				}
			}
		}
		String strReturnCategory = "";
		Search_Category_Proc search_category_proc = new Search_Category_Proc();
		
		//if(strKeyword != "") strKeyword = strKeyword.replaceAll(" ", "");
		
		Search_Category_Data[]  search_category_data = search_category_proc.getDataList(strKeyword.replaceAll(" ", ""));

		if(search_category_data!=null) {
			Ep_Goods_Proc ep_goods_proc = new Ep_Goods_Proc();
			if(search_category_data.length>0  && !ep_goods_proc.getIsEpKeyword(strKeyword)) {
				strReturnCategory = search_category_data[0].getCa_code();
			}
		}
		return strReturnCategory;
	}

	private String getReturnBrandRedirectPage(String strKeyword, String strMatchingCateAdd) throws Exception {
		String strBrandRedirectExceptionKeywords[] = { "일월의료기", "FILA", "fila", "휠라", "빈폴" };
		boolean bBrandRedirectExceptionKeyword = false;
		for(int i=0; i<strBrandRedirectExceptionKeywords.length; i++) {
			if(strBrandRedirectExceptionKeywords[i].trim().equals(strKeyword)) {
				bBrandRedirectExceptionKeyword = true;
			}
		}
		if(bBrandRedirectExceptionKeyword) {
			return "";
		}
		strKeyword = ReplaceSpecialKeyWord(strKeyword);
		String strTmpKeyword = strKeyword;
		String[] arrMatchingCateAdd = strMatchingCateAdd.split(",");
		for(int i=0; i<arrMatchingCateAdd.length; i++) {
			if(strTmpKeyword.indexOf(arrMatchingCateAdd[i])>=0) {
				strTmpKeyword = ReplaceStr.replace(strTmpKeyword,arrMatchingCateAdd[i],"");
				strTmpKeyword = strTmpKeyword.trim();
				break;
			}
		}

		String strReturnRedirectPage = "";
		String sLB_Qry = "";
		String sLB_Orderby = "";
		Goods_Brand_Proc goods_brand_proc = new Goods_Brand_Proc();

		if(strReturnRedirectPage.trim().length()==0) {
			sLB_Qry = " Where (upper(gb2_brandname)=upper(?) or upper(gb2_keyword)=upper(?)) and gb2_flag='0' ";
			sLB_Orderby = " Order by gb2_no ";
			Goods_Brand_Data[] gb_datas = goods_brand_proc.Goods_Brand2_List(strTmpKeyword,sLB_Qry, sLB_Orderby);

			if(gb_datas!=null && gb_datas.length>0) {
				Goods_Brand_Data gb_data = new Goods_Brand_Data();
				if(gb_datas.length==1) {
					gb_data = gb_datas[0];
				} else {
					boolean bGet = false;
					for(int bi=0; bi<gb_datas.length; bi++) { //14예외처리
						if(gb_datas[bi].getCa_code().equals("14")) {
							gb_data = gb_datas[bi];
							bGet = true;
						}
					}
					if(!bGet) {
						gb_data = gb_datas[0];
					}
				}
				String strBrandCate = "";
				if(gb_data.getCa_code().trim().length()>2) {
					strBrandCate = gb_data.getCa_code().trim().substring(0,2);
				} else {
					strBrandCate = gb_data.getCa_code().trim();
				}

				if((strBrandCate.equals("08") || strBrandCate.equals("12") || strBrandCate.equals("11")) || (strBrandCate.equals("21") && gb_data.getGb2_gb1flag().equals("1"))) {
					String strTempBrandCate = "";
					if(strBrandCate.equals("08")) {
						strTempBrandCate = "0811";
					} else if(strBrandCate.equals("12")) {
						strTempBrandCate = "1206";
					} else if(strBrandCate.equals("21")) {
						strTempBrandCate = "2112";
					}

					strReturnRedirectPage = "/view/Listbrand.jsp?cate="+strTempBrandCate+"&gb2no="+gb_data.getGb2_no()+"&from=search&skeyword="+java.net.URLEncoder.encode(strKeyword,"UTF-8");

				} else {

					if(strBrandCate.equals("14")) {
						if(strBrandCate.equals("14")) {
							if(gb_data.getCa_code().trim().equals("1481")) {
								strReturnRedirectPage = "/fashion/brand/Clothes_Brand_List.jsp?cate="+gb_data.getCa_code()+"&brand2no="+gb_data.getGb2_no()+"&from=search&skeyword="+java.net.URLEncoder.encode(strKeyword,"UTF-8");
							} else {
								String strGb2_ganada = gb_data.getGb2_ganada();
								String strBrandGanada = "";
								if(strGb2_ganada.equals("가나")) {
									strBrandGanada = "1";
								} else if(strGb2_ganada.equals("다라")) {
									strBrandGanada = "2";
								} else if(strGb2_ganada.equals("마바")) {
									strBrandGanada = "3";
								} else if(strGb2_ganada.equals("사아")) {
									strBrandGanada = "4";
								} else if(strGb2_ganada.equals("자차")) {
									strBrandGanada = "5";
								} else if(strGb2_ganada.equals("카타")) {
									strBrandGanada = "6";
								} else if(strGb2_ganada.equals("파하")) {
									strBrandGanada = "7";
								} else if(strGb2_ganada.equals("ABC")) {
									strBrandGanada = "8";
								}
								strReturnRedirectPage = "/view/fusion/Fusion.jsp?cate=1458&brand2no="+gb_data.getGb2_no()+"&ganada="+java.net.URLEncoder.encode(strBrandGanada,"UTF-8")+"&from=search&skeyword="+java.net.URLEncoder.encode(strKeyword,"UTF-8");
							}
						}

					} else if(strBrandCate.equals("15")) {
						strReturnRedirectPage = "/view/fusion/Fusion_Brand_Sub.jsp?cate="+gb_data.getCa_code().trim()+"&brandName="+java.net.URLEncoder.encode(gb_data.getGb2_brandname(),"UTF-8")+"&brand2no="+gb_data.getGb2_no()+"&from=search&skeyword="+java.net.URLEncoder.encode(strKeyword,"UTF-8");
					}
				}

				if(strReturnRedirectPage.trim().length()>0) {
					if(goods_brand_proc.getCountBrandSearch(gb_data.getGb2_no())==0) {
						strReturnRedirectPage = "";
					}
				}
			}
		}

		Ep_Goods_Proc ep_goods_proc = new Ep_Goods_Proc();
		if(ep_goods_proc.getIsEpKeyword(strKeyword)) {
			strReturnRedirectPage = "";
		}
		return strReturnRedirectPage;
	}

	private String getReturnRedirectPage(String strCaCode,String strKeyword) throws Exception {
		strKeyword = ReplaceSpecialKeyWord(strKeyword);
		String sLMScate = "";
		String strReturnRedirectPage = "";
		if(strCaCode.length()>=2) {
			if(strCaCode.length()>=6) {
				sLMScate = strCaCode.substring(0,6);
			}
			/*
			if(strCaCode.equals("91")) {
				strReturnRedirectPage = "/tour2012/Tour_Index.jsp?from=search&skeyword="+java.net.URLEncoder.encode(strKeyword);
			} else if(strCaCode.equals("88")) {
				strReturnRedirectPage = "/view/Sslist.jsp?from=search&skeyword="+java.net.URLEncoder.encode(strKeyword,"UTF-8");
			} else if(strCaCode.equals("2111")) {
				//strReturnRedirectPage = "/car/Index.jsp?from=search&skeyword="+java.net.URLEncoder.encode(strKeyword);
			} else if(CutStr.cutStr(strCaCode,4).equals("0304")) {
				strReturnRedirectPage = "/list.jsp?cate=" + strCaCode +"&from=search&islist=Y&skeyword=" + java.net.URLEncoder.encode(strKeyword,"UTF-8");
			} else if(strCaCode.equals("0212") || sLMScate.equals("021201") || sLMScate.equals("035301") || sLMScate.equals("035302") || sLMScate.equals("035303") || sLMScate.equals("035305") ||
					sLMScate.equals("035306") || sLMScate.equals("021010") || ( !sLMScate.equals("100504") && CutStr.cutStr(strCaCode,4).equals("1005") ) || CutStr.cutStr(strCaCode,4).equals("0353") ||
					CutStr.cutStr(strCaCode,4).equals("0355") || CutStr.cutStr(strCaCode,4).equals("0401") || sLMScate.equals("021001") || sLMScate.equals("021012") || sLMScate.equals("021013")) {
				strReturnRedirectPage = "/list.jsp?cate=" + strCaCode +"&from=search&islist=Y&skeyword=" + java.net.URLEncoder.encode(strKeyword,"UTF-8");
			} else if(sLMScate.equals("040207")) {
				strReturnRedirectPage = "/list.jsp?cate=" + strCaCode +"&from=search&skeyword=" + java.net.URLEncoder.encode(strKeyword,"UTF-8");
			} else {
				strReturnRedirectPage = "/list.jsp?cate=" + strCaCode +"&from=search&islist=Y&skeyword=" + java.net.URLEncoder.encode(strKeyword,"UTF-8");
			}
			*/
			strReturnRedirectPage = "/list.jsp?cate=" + strCaCode +"&from=search&skeyword=" + java.net.URLEncoder.encode(strKeyword,"UTF-8");
		}

		return strReturnRedirectPage;
	}

	private String ReplaceSpecialKeyWord(String strKeyword) {
		strKeyword = ReplaceStr.replace(strKeyword, "-"," ");
		strKeyword = ReplaceStr.replace(strKeyword, ")"," ");
		strKeyword = ReplaceStr.replace(strKeyword, "("," ");
		strKeyword = ReplaceStr.replace(strKeyword, "^"," ");
		//strKeyword = ReplaceStr.replace(strKeyword, "&"," ");
		strKeyword = ReplaceStr.replace(strKeyword, "~"," ");
		strKeyword = ReplaceStr.replace(strKeyword, "@"," ");
		strKeyword = ReplaceStr.replace(strKeyword, "$"," ");
		strKeyword = ReplaceStr.replace(strKeyword, "%"," ");
		strKeyword = ReplaceStr.replace(strKeyword, "*"," ");
		strKeyword = ReplaceStr.replace(strKeyword, "+"," ");
		strKeyword = ReplaceStr.replace(strKeyword, "="," ");
		strKeyword = ReplaceStr.replace(strKeyword, "\\"," ");
		strKeyword = ReplaceStr.replace(strKeyword, "{"," ");
		strKeyword = ReplaceStr.replace(strKeyword, "}"," ");
		strKeyword = ReplaceStr.replace(strKeyword, "["," ");
		strKeyword = ReplaceStr.replace(strKeyword, "]"," ");
		//strKeyword = ReplaceStr.replace(strKeyword, ":"," ");
		strKeyword = ReplaceStr.replace(strKeyword, ";"," ");
		strKeyword = ReplaceStr.replace(strKeyword, "/"," ");
		strKeyword = ReplaceStr.replace(strKeyword, "<"," ");
		strKeyword = ReplaceStr.replace(strKeyword, ">"," ");
		//strKeyword = ReplaceStr.replace(strKeyword, "."," ");
		strKeyword = ReplaceStr.replace(strKeyword, ","," ");
		strKeyword = ReplaceStr.replace(strKeyword, "?"," ");
		strKeyword = ReplaceStr.replace(strKeyword, "'"," ");
		strKeyword = ReplaceStr.replace(strKeyword, "_"," ");
		strKeyword = ReplaceStr.replace(strKeyword, "`"," ");
		strKeyword = ReplaceStr.replace(strKeyword, "|"," ");
		//strKeyword = ReplaceStr.replace(strKeyword, "."," ");

		strKeyword = strKeyword.trim();
		return strKeyword;
	}

	private String getExtendsSearchKeyword(String strKeyword, String strKeywordListGo) throws Exception {
		String strReturnCategory = "";
		Search_Category_Proc search_category_proc = new Search_Category_Proc();
		
		Search_Category_Data  search_category_data = search_category_proc.getKeywordSearch(strKeyword.replaceAll(" ", ""));
		String strReturn = "";
		if(search_category_data!=null) {
			if(search_category_data.getKey_type().equals("L")) {
				strReturn = "/list.jsp?cate=" + search_category_data.getCa_code() +"&from=search&islist=Y&cate_keyword=Y&keyword=" + java.net.URLEncoder.encode(strKeywordListGo,"UTF-8") + "&skeyword=" + java.net.URLEncoder.encode(strKeywordListGo,"UTF-8");
			} else if(search_category_data.getKey_type().equals("S")) {
				strReturn = "/search.jsp?keyword=" + java.net.URLEncoder.encode(strKeywordListGo,"UTF-8") + "&from=list&cate="+search_category_data.getCa_code() + "&ext_cate_disable="+search_category_data.getCa_code();
			}
		}
		return strReturn;
	}
	public String getDate(){
		DecimalFormat df = new DecimalFormat("00");
		Calendar calendar = Calendar.getInstance();


		String year = Integer.toString(calendar.get(Calendar.YEAR)); //년도를 구한다
		String month = df.format(calendar.get(Calendar.MONTH) + 1); //달을 구한다
		String day = df.format(calendar.get(Calendar.DATE)); //날짜를 구한다
		String date = month+"월" + day+"일";

		return date;
	}

%>