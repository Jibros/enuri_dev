<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="org.json.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.enuri.util.common.ChkNull"%>

<%
	request.setCharacterEncoding("UTF-8");

	JSONArray spotLightJson = new JSONArray();

	String[] keywords = { "스마트폰", "휴대폰", "태블릿PC", "이어폰", "블루투스", 
						"내비게이션", "하이패스", "블랙박스", "TV", "디지털 카메라", 

						"DSLR", "냉장고", "김치냉장고", "청소기", "세탁기", 
						"전기장판", "히터", "가습기", "에어컨", "공기청정기", 

						"선풍기", "제습기", "노트북", "모니터", "PC", 
						"복합기", "프린터", "스피커", "그래픽카드", "USB메모리", 

						"골프", "등산의류", "등산화", "캠핑", "아웃도어", 
						"자전거", "운동화", "타이어", "후방카메라", "와이퍼", 

						"엔진오일", "기저귀", "물티슈", "분유", "유모차", 
						"로봇", "커피", "생수", "과자", "책상", 

						"장롱", "침대", "소파", "냄비", "세제", 
						"화장지", "건전지", "방향제", "커피", "찜질기", 

						"신발", "가방", "화장품", "선크림", "향수", 
						"악기", "키덜트", "복사용지", "다이어리", "상품권" };

	String[] cates = { "", "", "", "", "", 
						"", "", "", "", "", 

						"", "", "", "", "", 
						"", "", "", "", "", 

						"", "", "", "", "", 
						"", "", "", "", "", 

						"", "", "", "", "", 
						"", "", "", "", "", 

						"", "", "", "", "", 
						"", "", "", "", "", 

						"", "", "", "", "", 
						"", "", "", "", "", 

						"", "", "", "", "", 
						"", "", "", "", "",  };

	for (int i = 0 ; i < keywords.length ; i++) {
		try {
			JSONObject spotLight = new JSONObject();

			spotLight.put("keyword", keywords[i]);
			if (i < cates.length) {
				spotLight.put("cate", cates[i]);
			} else {
				spotLight.put("cate", "");
			}

			spotLightJson.put(spotLight);
		}  catch (Exception e) {}
	}

	out.print(spotLightJson);
	
%>