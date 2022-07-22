<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.enuri.util.common.ConfigManager"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>





<%
	String app_type = ConfigManager.RequestStr(request, "app_type", "N");

	String strversion = ConfigManager.RequestStr(request, "version", "0.0.0");

	int version = 0;
	if (strversion.length() >= 5) {
		try {
			version = Integer.parseInt(strversion.substring(0, 1)) * 100
					+ Integer.parseInt(strversion.substring(2, 3)) * 10
					+ Integer.parseInt(strversion.substring(4, 5));
		} catch (Exception e) {
		}
	}
	JSONObject print = new JSONObject();
	{

		JSONObject nufari = new JSONObject();
		{

			JSONArray shopCodes = new JSONArray();
			//shopCodes.put("4027");
			JSONObject nufariand = new JSONObject();
			nufariand.put("delay", "1");//1,7,30
			nufariand.put("show", "N");
			nufariand.put("msg", "[G마켓 구매 적립 일시 중지 안내]\n내부 시스템 문제로 인해 G마켓 e머니 적립이 일시 중단되었습니다.\n해당 기간 내 구매 시 e머니 적립이 되지 않으니 참고 부탁드립니다.\n(G마켓 외 제휴몰 구매 적립 정상 지급)\n감사합니다.");
			nufariand.put("button_type", "1");//1은 닫기만//2는 button_move 버튼 들어감
			nufariand.put("button_move_text", "이건 액션");//버튼텍스트
			nufariand.put("button_move_url", "http://m.enuri.com/mobilefirst/detail.jsp?modelno=12577689");//이동은 스킴, 프리토큰,
			//샵코드 없으면 조건 없이 누파리 뜨면 띄움
			nufariand.put("shopcode", shopCodes); 
			

			JSONObject nufariios = new JSONObject();
			nufariios.put("delay", "1");//1,7,30,-1영원히 보지 않기 
			nufariios.put("show", "N");
			nufariios.put("msg", "[G마켓 구매 적립 일시 중지 안내]\n내부 시스템 문제로 인해 G마켓 e머니 적립이 일시 중단되었습니다.\n해당 기간 내 구매 시 e머니 적립이 되지 않으니 참고 부탁드립니다.\n(G마켓 외 제휴몰 구매 적립 정상 지급)\n감사합니다.");
			nufariios.put("button_type", "1");//1은 닫기만//2는 button_move 버튼 들어감
			nufariios.put("button_move_text", "이건 액션");//버튼텍스트
			nufariios.put("button_move_url", "http://m.enuri.com/mobilefirst/detail.jsp?modelno=12577689");//이동은 스킴, 프리토큰,
			//샵코드 없으면 조건 없이 누파리 뜨면 띄움
			nufariios.put("shopcode", shopCodes);
			
			nufari.put("Android", nufariand);
			nufari.put("iOS", nufariios);
		}

		print.put("nufari", nufari);

		JSONObject mymenu = new JSONObject();
		{
			JSONObject mymenuand = new JSONObject();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		    Date beginDate =  new Date();
		    Date endDate = formatter.parse("20211110");//20180901 은 20180831날 까지임
		    long diff = endDate.getTime() - beginDate.getTime();
		    // 노출 날짜 제한
		    if (diff >= 0 ){
		    	mymenuand.put("delay", "7");//1,7,30
				mymenuand.put("show", "Y");
		    }else{
		    	mymenuand.put("delay", "1");//1,7,30
				mymenuand.put("show", "N");
		    }
		   /*
		   딱한번 띄우는 처리 
		   long diffDays = diff / (24 * 60 * 60 * 1000);			
			if(diffDays == 0)
			{
				mymenuand.put("delay", "1");//1,7,30
				mymenuand.put("show", "N");
			}else 
			{
				mymenuand.put("delay", Long.toString(diffDays));//1,7,30
				mymenuand.put("show", "Y");
			} */
			/* mymenuand.put("delay", "1");//1,7,30
			mymenuand.put("show", "N"); */
			mymenuand.put("msg", 		
			
					"안녕하세요.\n"+
					"에누리 가격비교서비스를 이용해주시는 회원 여러분께 감사드리며, 티몬 e머니 적립기준이 변경되어 안내드립니다.\n"+
"\n"+
					"■ 티몬 상품권 구매 e머니 적립종료\n"+
"\n"+
					"1. 적용 시점\n"+
					"2020. 11. 1(일) 00시 구매 건부터 적용\n"+
					"2. 변경 내용\n"+
					"상품권: 0.2% → 0%(상품권 카테고리 기본적립 종료)\n"+
					"이 외 카테고리는 현재 적립률이 유지됩니다.\n"+
"\n"+
					"감사합니다.\n"

					);

			
			
			mymenuand.put("button_type", "1");//1은 닫기만//2는 button_move 버튼 들어감
			mymenuand.put("button_move_text", "약관보기");//버튼텍스트
			mymenuand.put("button_move_url", "http://m.enuri.com/m/login/policy_shopping_report.jsp?freetoken=login_title");//이동은 스킴, 프리토큰,

			JSONObject mymenuios = new JSONObject();
			 // 노출 날짜 제한
		    if (diff >= 0 ){
		    	mymenuios.put("delay", "7");//1,7,30
		    	mymenuios.put("show", "Y");
		    }else{
		    	mymenuios.put("delay", "1");//1,7,30
		    	mymenuios.put("show", "N");
		    }
		/*
		딱한번 띄우는 처리 
		if(diffDays ==0)
			{
				mymenuios.put("delay", "1");//1,7,30
				mymenuios.put("show", "N");
			}else 
			{
				mymenuios.put("delay", Long.toString(diffDays));//1,7,30
				mymenuios.put("show", "Y");
			}  */
			/* mymenuios.put("delay","1");//1,7,30
			mymenuios.put("show", "N"); */
			mymenuios.put("msg", 						

					"안녕하세요.\n"+
					"에누리 가격비교서비스를 이용해주시는 회원 여러분께 감사드리며, 티몬 e머니 적립기준이 변경되어 안내드립니다.\n"+
"\n"+
					"■ 티몬 상품권 구매 e머니 적립종료\n"+
"\n"+
					"1. 적용 시점\n"+
					"2020. 11. 1(일) 00시 구매 건부터 적용\n\n"+
					"2. 변경 내용\n"+
					"상품권: 0.2% → 0%\n"+
					"(상품권 카테고리 기본적립 종료)\n\n"+
					"이 외 카테고리는 현재 적립률이 유지됩니다.\n"+
"\n"+
					"감사합니다.\n");

			mymenuios.put("button_type", "1");//1은 닫기만//2는 button_move 버튼 들어감
			
			mymenuios.put("button_move_text", "약관보기");//버튼텍스트
			mymenuios.put("button_move_url", "http://m.enuri.com/m/login/policy_shopping_report.jsp?freetoken=event");//이동은 스킴, 프리토큰,

			mymenu.put("Android", mymenuand);
			mymenu.put("iOS", mymenuios);
		}
		print.put("mymenu", mymenu);
	}
	out.println(print.toString());
%>