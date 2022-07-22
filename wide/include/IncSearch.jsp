<%@ page import="com.diquest.ir.common.msg.protocol.query.QuerySet" %>
<%@ page import="com.diquest.ir.common.msg.protocol.query.Query" %>
<%@ page import="com.diquest.ir.common.msg.protocol.query.SelectSet" %>
<%@ page import="com.diquest.ir.common.msg.protocol.query.FilterSet" %>
<%@ page import="com.diquest.ir.common.msg.protocol.query.WhereSet" %>
<%@ page import="com.diquest.ir.common.msg.protocol.result.ResultSet" %>
<%@ page import="com.diquest.ir.common.msg.protocol.result.Result" %>
<%@ page import="com.diquest.ir.common.msg.protocol.query.OrderBySet" %>
<%@ page import="com.diquest.ir.common.msg.protocol.query.GroupBySet" %>
<%@ page import="com.diquest.ir.common.msg.protocol.result.GroupResult" %>
<%@ page import="com.diquest.ir.common.msg.protocol.Protocol" %>
<%@ page import="com.diquest.ir.common.exception.IRException" %>
<%@ page import="com.diquest.ir.client.util.PostPageNavigator" %>
<%@ page import="com.diquest.ir.client.command.CommandSearchRequest"%>
<%@ page import="com.diquest.ir.common.msg.protocol.query.QueryParser"%>
<%@ page import="com.enuri.bean.search.SearchFunction"%>
<%@ page import="com.enuri.bean.search.CSearchClient"%>
<%@ page import="com.enuri.bean.search.CSearchResult"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Random"%>
<%!
	private final int RESEARCH_EXCLUDE_ENABLED = 0x01; // 제외
	private final int RESEARCH_FUZZY_ENABLED = 0x02; // 유사
	
	private final int SYNONYM_ENABLED = 0x01; // 유의어 적용
	private final int BOOST_ENABLED = 0x02; // 부스팅 적용
	private final int ALPASPLIT_ENABLED = 0x04; // 영문+숫자 강제 분리
	private final boolean MODEL_FACTORY_SYNONYM_ENABLED = true; // model_factory 필드 유의어 적용여부
	
	private final int OPT_FLAG_GROUP_BRAND = 0x01; // 브랜드(기본) - 집계 
	private final int OPT_FLAG_GROUP_BRAND2 = 0x02; // 제조사 브랜드가 같을 경우 null 처리 - 집계	
	private final int OPT_FLAG_LIST_ETC_CATE = 0x04; // 기타분류 - 목록 검색 여부
	private final int OPT_FLAG_BRAND_ID = 0x08; // 브랜드 아이디로 검색, 집계
	private final int OPT_FLAG_FACTORY_ID = 0x10; // 제조사 아이디로 검색, 집계
	private final int OPT_FLAG_DC_RT3 = 0x20; // PC or 모바일가 (dc_rt3) - 검색, 집계
	private final int OPT_FLAG_R_MODELNO = 0x40; // 기준모델로 반환여부
	private final int OPT_FLAG_LP_SRP_POPULAR = 0x80; // LP(popular2), SRP(popular) 다른 기준으로 정렬처리
	private final int OPT_FLAG_SUB_PRICE = 0x100; // 가격검색 시 sub_models로 필터링 처리
	private final int OPT_FLAG_CORE_SPEC_ONLY = 0x200; // 속성 집계시 spect_type= 'c' 인것만 노출 
	private final int OPT_FLAG_KEYWORD_DETAIL = 0x400; // 검색시 키워드 검색시 구분 검색 (브랜드, 제조사, 속성등)
	private final int OPT_FLAG_PRICE_GROUP1 = 0x800; // 가격 집계 (가격비교)
	private final int OPT_FLAG_PRICE_GROUP2 = 0x1000; // 가격 집계 (일반상품)
	private final int OPT_FLAG_PRICE_GROUP3 = 0x2000; // 가격 집계  (전체)

	private final int INNER_HIT_SORT_MINPRICE_ASC = 0;
	private final int INNER_HIT_SORT_MINPRICE_DESC = 1;
	private final int INNER_HIT_SORT_PC = 2;
	private final int INNER_HIT_SORT_ETC = 3;
	
	private final int OPT_FLAG = OPT_FLAG_FACTORY_ID | OPT_FLAG_R_MODELNO | OPT_FLAG_SUB_PRICE | OPT_FLAG_CORE_SPEC_ONLY | OPT_FLAG_PRICE_GROUP3; // 옵션 flag
	
	private final String[] HOST_IP = { "192.168.213.168:8080", "192.168.213.169:8080", "192.168.213.168:9080", "192.168.213.169:9080"  };
	private final String[] ETC_HOST_IP = { "192.168.213.163", "192.168.213.164", "192.168.213.167" };
	
	public String getStrHostIp() {
		Random rd = new Random();
		int randInt = rd.nextInt(HOST_IP.length);
		String hostIp = HOST_IP[randInt];
		return hostIp;
	}

	public String getEtcHostIp() {
		Random rd = new Random();
		int randInt = rd.nextInt(ETC_HOST_IP.length);
		String hostIp = ETC_HOST_IP[randInt];
		return hostIp;
	}

	public String getUserAddr(HttpServletRequest request){
		String ip = request.getHeader("log.user_ip");
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-Forwarded-For");
		}
		if(ip != null && ip.indexOf(",")>-1) {
			ip = ip.split(",")[0];
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip == null ? "" : ip;
	}
	
	public String getUserAgent(HttpServletRequest request){
		String agent = request.getHeader("log.user_agent");
		if(agent == null || agent.length() == 0) {
			agent = request.getHeader("User-Agent");
		}
		return agent == null ? "" : agent;
	}	
	
	public String getUserID(HttpServletRequest request) throws Exception {
		String id = request.getHeader("log.user_id");
		if(id == null || id.length() == 0) {
			CookieBean cb = new CookieBean(request.getCookies());
			id = cb.GetCookie("MEM_INFO", "USER_ID");
		}
		return id == null ? "" : id;
	}	
	
	public String getSessionID(HttpServletRequest request){
		Cookie[] a = request.getCookies();
		if(a != null) {
			for(Cookie c : a){
				String name = c.getName();
				if("JSESSIONID".equals(name)) 
					return c.getValue();				
			}	
		}		
		return "";
	}
	
	public String getQueryString(HttpServletRequest request) throws Exception {
		Enumeration<String> names = request.getParameterNames();
		StringBuilder sb = new StringBuilder();
		while (names.hasMoreElements()) {
			String name = names.nextElement();
			String value = request.getParameter(name);
			if (value != null && value.length() > 0) {
				sb.append("&").append(URLEncoder.encode(name, "UTF-8")).append("=").append(URLEncoder.encode(value, "UTF-8"));
			}
		}
		return sb.length() > 0 ? sb.substring(1) : null;
	}
%>
<%
	//final String strHostSet = "192.168.213.125"; // ES 쿼리빌더
	//final String etcHostSet = "192.168.213.123"; // ES 코디네이터 노드
	final String strHostSet = getStrHostIp(); // ES 쿼리빌더
	final String etcHostSet = getEtcHostIp(); // ES 코디네이터 노드

	final int intEtcPortSet = 9200;
	final int intPortSet = 8080;
	final String strCollectionName = "enuri-srp";
	final String strAutoMakerCollectionName = "enuri-smartmaker";
	final String strEnuriOvsCollectionName = "enuri-ovs";
	final String strGroupName = "main";
	final String strEnuriOvsGroupName = "ovs";
	final String strKbCollectionName = "KNOWBOX";
	final String strProfileName = "";
	final int intTimeOut = 13000;
	final int intMinPool = 1;
	final int intMaxPool = 10;

	boolean bThesaurusOption = true;
	boolean bEnuriSynonym = true;
	boolean bBigram = false;
%>
<%!
	private static final byte TYPE_ALPHA = 0x01;
	private static final byte TYPE_NUM = 0x02;
	private static final byte TYPE_KOREAN = 0x03;
	private static final byte TYPE_DASH = 0x04;
	private static final byte TYPE_OTHER = 0x05;
	private static final String WHITE_SPACE = " ";
	private static final int MIN_TEXT_SIZE = 2;

	public boolean isAddSearchCate(String strCate){
		boolean bReturn = false;
	    if ("1650".equals(strCate)){
	    	bReturn = true;
	    }
		return bReturn;

	}
	public String getAddSearchCateKeyword(String strCate){
		String strReturn = "";
		try{
			SearchFunction searchfunction = new SearchFunction();
			strReturn = searchfunction.getAddSearchCateKeyword(strCate).trim();
		}catch(Exception e){
		}
		return 	strReturn;
	}
	public String seperate(String input) {
		/*
		try {
			SearchFunction searchfunction = new SearchFunction();
			if (searchfunction.checkUserDic(input)){
				return input;
			}
		}catch(Exception e) {
			return input;
		}


		if(input == null) return "";
		StringBuffer sb = new StringBuffer();
		char[] keyword = input.toCharArray();
		int wordStart = 0;
		int wordLength = 0;
		int length = keyword.length;
		try {
			for(int i = 0; i < length; i++) {
				if(isWhiteSpace(keyword[i])) {	// 기본 입력을 조건에 맞게 공백 단위로 나눔
					String strTemp = new String(keyword,wordStart, wordLength);
					String newWord = getNewWord(keyword, wordStart, wordLength);
					sb.append(newWord);
					sb.append(WHITE_SPACE);
					wordStart = i + 1;
					wordLength = 0;
				} else {
					wordLength++;
				}
			}
			if(wordLength > 0) {	// 나머지 입력에 대해서 seperate check
				String strTemp = new String(keyword,wordStart, wordLength);
				String newWord = getNewWord(keyword, wordStart, wordLength);
				sb.append(newWord);
			}
		} catch(Exception e) {
			return input;
		}
		return sb.toString();
		*/
		return input;
	}
    public String seperate_noresult(String input) {
        if(input == null) return "";
        StringBuffer sb = new StringBuffer();
        char[] keyword = input.toCharArray();
        int wordStart = 0;
        int wordLength = 0;
        int length = keyword.length;
        try {
            for(int i = 0; i < length; i++) {
                if(isWhiteSpace(keyword[i])) {  // 기본 입력을 조건에 맞게 공백 단위로 나눔
                    String strTemp = new String(keyword,wordStart, wordLength);
                    String newWord = getNewWord(keyword, wordStart, wordLength);
                    sb.append(newWord);
                    sb.append(WHITE_SPACE);
                    wordStart = i + 1;
                    wordLength = 0;
                } else {
                    wordLength++;
                }
            }
            if(wordLength > 0) {    // 나머지 입력에 대해서 seperate check
                String strTemp = new String(keyword,wordStart, wordLength);
                String newWord = getNewWord(keyword, wordStart, wordLength);
                sb.append(newWord);
            }
        } catch(Exception e) {
            return input;
        }
        return sb.toString();
    }

	private String getNewWord(char[] input, int start, int length) {
		String strTemp = new String(input, start, length);

		try {
			SearchFunction searchfunction = new SearchFunction();
			if (searchfunction.checkUserDic(strTemp)){
				return strTemp;
			}
		}catch(Exception e) {
			return strTemp;
		}

		if(length < 2) return new String(input, start, length);

		StringBuffer sb = new StringBuffer();

		int offSet = start;
		int termOffSet = offSet, termLength = 0;
		byte prevType = getCtype(input[offSet]);
		byte currType;
		byte prevTermType = getCtype(input[offSet]);	// 이전에 나눠진 term
		byte currTermType = getCtype(input[offSet]);	// 현재 확인 중인 term

		boolean isStart = false;
		boolean splitCondition = true;

		String prevTerm = "";
		String currTerm = "";
		while(offSet < start + length){
			currType = getCtype(input[offSet]);
//			if(currType == TYPE_OTHER) {	// 특수문자가 포함되어 있으면 무조건 원래의 키워드를 돌려 줌 (특수 기호는 없다고 가정, because 전처리로 특수기호가 없는 키워드가 넘어옴)
//				return new String(input, start, length);
//			}
			if(prevType != currType){	// 현재 문자와 이전 문자의 타입이 다른 경우
				currTerm = new String(input, termOffSet, termLength);	// 타입이 바뀌기 전까지의 키워드
				currTermType = prevType;

				sb.append(prevTerm);

				if(prevTerm.length() > 0) {
					isStart = true;
				}

				if(chkSeperateCondition(prevTermType, currTermType, prevTerm, currTerm)) {
					if(!isStart) {
						isStart = true;
					} else {
						sb.append(WHITE_SPACE);
					}
				}

				termOffSet = offSet;
				termLength = 0;
				prevTerm = currTerm;
				prevTermType = currTermType;
				prevType = currType;
			}

			termLength++;
			offSet++;
		}

		currTerm = new String(input, termOffSet, termLength);	// 타입이 바뀌기 전까지의 키워드
		currTermType = prevType;

		sb.append(prevTerm);
		if(chkSeperateCondition(prevTermType, currTermType, prevTerm, currTerm)) {
			sb.append(WHITE_SPACE);
		}
		sb.append(currTerm);
		return sb.toString();
	}

	private boolean chkSeperateCondition(byte prevTermType, byte currTermType, String prevTerm, String currTerm) {
		/*
		if(prevTermType == TYPE_KOREAN) {
			return true;
		} else if(currTermType == TYPE_KOREAN) {
			return true;
		} else {
			if(prevTerm.length() >= MIN_TEXT_SIZE && currTerm.length() >= MIN_TEXT_SIZE) {
				return true;
			} else {
				return false;
			}
		}
		*/
		if (prevTermType == TYPE_ALPHA && currTermType == TYPE_NUM){
			return true;
		}else if(currTermType == TYPE_ALPHA && prevTermType == TYPE_NUM){
			return true;
		}else{
			return false;
		}
	}

	private byte getCtype(char ch){
		if(isAlpha(ch)){
			return TYPE_ALPHA;
		} else if(isDigit(ch)) {
			return TYPE_NUM;
		} else if(isKorean(ch)) {
			return TYPE_KOREAN;
		}
		return TYPE_OTHER;
	}

	private boolean isWhiteSpace(final char ch) {
		return ch <= 0x0020 && ((1L << 0x0009 | 1L << 0x000A | 1L << 0x000C | 1L << 0x000D | 1L << 0x0020) >> ch & 1L) != 0;
	}

	public static final boolean isDigit(char c) {
		if (c >= '0' && c <= '9')
			return true;
		return false;
	}
	public static final boolean isAlpha(char c) {
		if (c >= 'a' && c <= 'z' || c >='A' && c <= 'Z')
			return true;
		return false;
	}

	public static final boolean isKorean(char c) {
		if (c >= '\uAC00' && c <= '\uD7A4') {
			return true;
		}
		return false;
	}
	private String get5910FreeInterest(){
		return "BC,KB국민,현대,롯데,농협NH,하나SK카드 6개월 무이자할부";
	}
	private HashMap getCardNameHash(){
		Pricelist_Proc pricelist_proc = new Pricelist_Proc();
		java.util.HashMap cardNameHash = new java.util.HashMap();
		String[][] cardInfoAry = pricelist_proc.getPriceList_CardEvent();
		String cardShopCodes = "|";
		String cardName = "";
		if(cardInfoAry!=null) {
			for(int i=0; i<cardInfoAry.length; i++) {
				cardName = "";
				cardShopCodes += cardInfoAry[i][0]+"|";
				//카드명 변경시 IncCardName.jsp, IncCardName_kr.jsp, IncSearch.jsp 동시 수정 필요
				if(cardInfoAry[i][3].equals("1")) cardName = "BC카드";
				if(cardInfoAry[i][3].equals("2")) cardName = "KB카드";
				if(cardInfoAry[i][3].equals("3")) cardName = "롯데카드";
				if(cardInfoAry[i][3].equals("4")) cardName = "삼성카드";
				if(cardInfoAry[i][3].equals("5")) cardName = "신한카드";
				if(cardInfoAry[i][3].equals("6")) cardName = "씨티카드";
				if(cardInfoAry[i][3].equals("7")) cardName = "우리카드";
				if(cardInfoAry[i][3].equals("8")) cardName = "외환카드";
				if(cardInfoAry[i][3].equals("9")) cardName = "하나카드";
				if(cardInfoAry[i][3].equals("A")) cardName = "현대카드";
				if(cardInfoAry[i][3].equals("B")) cardName = "CJ카드";
				if(cardInfoAry[i][3].equals("C")) cardName = "NH카드";
				if(cardInfoAry[i][3].equals("D")) cardName = "SC은행카드";
				if(cardInfoAry[i][3].equals("E")) cardName = "IBK카드";

				cardName += "|"+cardInfoAry[i][4]; //카드 제한 문구
				if(cardNameHash.containsKey(cardInfoAry[i][0])){
					cardName = (String)cardNameHash.get(cardInfoAry[i][0]) + ":" + cardName;
				}
				cardNameHash.put(cardInfoAry[i][0], cardName);
			}
		}
		return cardNameHash;
	}
	private String getRemoveCardSale(HashMap cardNameHash, String strPlGoodsNmM, int szVcode){
		return getRemoveCardSale(cardNameHash, strPlGoodsNmM, szVcode, 0, "", "", null);
	}
	private String getRemoveCardSale(HashMap cardNameHash, String strPlGoodsNmM, int szVcode, long mPrice, String szCategory, String strFreeinterest, String[][] cardFreeAry){

		//상품명 강제변경
		strPlGoodsNmM = getGoodsNmReplace2(szVcode, strPlGoodsNmM, mPrice, szCategory, false, strFreeinterest, cardFreeAry);

		String tempCardName = getCardNmEvent(cardNameHash, szVcode+"", strPlGoodsNmM, mPrice, szCategory);

		String[] arrTempCardName = null;
		if(tempCardName.indexOf(",")>0){
			arrTempCardName = tempCardName.split(",");
		}

		//카드할인 문구 삭제
		strPlGoodsNmM = getGoodsNmCardReplace(szVcode, strPlGoodsNmM, tempCardName, arrTempCardName, mPrice, szCategory, false);

		return strPlGoodsNmM;
	}
%>
<%@ include file="/include/IncDetailCommon_2010.jsp"%>
<%@ include file="/lsv2016/include/detail/IncDetailInfo.jsp"%>