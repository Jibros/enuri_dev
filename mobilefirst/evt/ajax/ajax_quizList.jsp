<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
    JSONObject jSONObject = new JSONObject();	 
    String sdt = StringUtils.defaultString(request.getParameter("sdt"),"");
    jSONObject = getTodayQuiz(sdt);    
	out.println(jSONObject.toString());
%>

<%!
public JSONObject getTodayQuiz(String sdt) {
    //JSONArray jSONArray = new JSONArray();
    JSONObject jSONObject = new JSONObject();  

	if(sdt.length()==0) {
		sdt = new SimpleDateFormat("yyyyMMdd").format(new Date()).toString();
	}
	if(sdt.compareTo("20170313")>0) {
		sdt = "20170313";
	}
    try{
        if(sdt.equals("20170221")){
            jSONObject.put("quest", "어디서도 볼 수 없는 파격적인 추가할인을 받는 에누리앱전용 혜택은?");
            jSONObject.put("answer1", "aDEAL");
            jSONObject.put("answer2", "eDEAL");
            jSONObject.put("answer3", "xDEAL");
            jSONObject.put("correct", "2");
            jSONObject.put("hint", "/mobilefirst/event2016/mobile_eal.jsp?");
            jSONObject.put("linkYN", "Y");
        }
        else if(sdt.equals("20170222")){
            jSONObject.put("quest", "이번 달에 앱에서 1만원 이상 몇 번 구매하면 던킨도너츠를 100% 받을까요?");
            jSONObject.put("answer1", "3번");
            jSONObject.put("answer2", "30번");
            jSONObject.put("answer3", "300번");
            jSONObject.put("correct", "1");
            jSONObject.put("hint", "/mobilefirst/evt/buy_event.jsp?tab=1&");
            jSONObject.put("linkYN", "Y");
        }
        else if(sdt.equals("20170223")){
            jSONObject.put("quest", "파격적인 에누리앱 단독특가! eDEAL의 내일의 상품은?");
            jSONObject.put("answer1", "하와이 여행권");
            jSONObject.put("answer2", "이디야 커피");
            jSONObject.put("answer3", "벤츠 e220d");
            jSONObject.put("correct", "2");
            jSONObject.put("hint", "/mobilefirst/event2016/mobile_eal.jsp?"); 
            jSONObject.put("linkYN", "Y");
        }
        else if(sdt.equals("20170224")){
            jSONObject.put("quest", "이번 달에 일요일에 에누리를 출석하면 받을 수 있는 추가혜택은?");
            jSONObject.put("answer1", "비타300");
            jSONObject.put("answer2", "비타500");
            jSONObject.put("answer3", "비타700");
            jSONObject.put("correct", "2");
            jSONObject.put("hint", "/mobilefirst/evt/visit_event.jsp?");
            jSONObject.put("linkYN", "Y");
        }
        else if(sdt.equals("20170225")){
            jSONObject.put("quest", "오직 단 한 번! 에누리앱에서 처음 구매하면 받을 수 있는 혜택은?");
            jSONObject.put("answer1", "ⓔ1,000");
            jSONObject.put("answer2", "ⓔ2,000");
            jSONObject.put("answer3", "ⓔ3,000");
            jSONObject.put("correct", "3");
            jSONObject.put("hint", "/mobilefirst/event2016/purchase_event.jsp?");
            jSONObject.put("linkYN", "Y");
        }
        else if(sdt.equals("20170226")){
            jSONObject.put("quest", "회사에 지친 그대를 위한 에누리 직장공감! 지금 공감 주제는?");
            jSONObject.put("answer1", "직장운세");
            jSONObject.put("answer2", "최악의 직원");
            jSONObject.put("answer3", "점심메뉴");
            jSONObject.put("correct", "1");
            jSONObject.put("hint", "/mobilefirst/evt/office_workers201702.jsp?");
            jSONObject.put("linkYN", "Y");
        }
        else if(sdt.equals("20170227")){
            jSONObject.put("quest", "파격적인 에누리앱 단독특가! eDEAL의 내일의 상품은?");
            jSONObject.put("answer1", "화이트 애니데이");
            jSONObject.put("answer2", "1년 휴가권");
            jSONObject.put("answer3", "남극펭귄");
            jSONObject.put("correct", "1");
            jSONObject.put("hint", "/mobilefirst/event2016/mobile_eal.jsp?");
            jSONObject.put("linkYN", "Y");
        }
        else if(sdt.equals("20170228")){
            jSONObject.put("quest", "앱에서 신학기선물 구매하고 이벤트에 응모하면 받을 수 있는 선물은?");
            jSONObject.put("answer1", "라이언쿠션");
            jSONObject.put("answer2", "라이언담요");
            jSONObject.put("answer3", "라이언칫솔");
            jSONObject.put("correct", "1");
            jSONObject.put("hint", "/mobilefirst/evt/newSemester.jsp?");
            jSONObject.put("linkYN", "Y");
        }
        else if(sdt.equals("20170301")){
            jSONObject.put("quest", "에누리는 공정거래위원회 조사에서 가격비교 상품 정보일치율 몇 위를 기록했을까요?");
            jSONObject.put("answer1", "10위");
            jSONObject.put("answer2", "1위");
            jSONObject.put("answer3", "5위");
            jSONObject.put("correct", "2");
            jSONObject.put("hint", " 에누리 가격비교는 2014년 10월 공정거래위원회와 소비자원의 가격 비교 운영 실태조사에서 가격 비교 상품 정보 일치율 100%를 기록하면서 가격비교 사이트 1위를 차지했습니다.<br>앞으로도 더욱 편리하고 정확한 최저가 쇼핑을 위해 노력하겠습니다!");
            jSONObject.put("linkYN", "N");
        }
        else if(sdt.equals("20170302")){
            jSONObject.put("quest", "친구를 에누리앱으로 초대해서 ⓔ10,000 혜택을 받을 수 있는 친구수는 몇 명일까요?");
            jSONObject.put("answer1", "제한 없음");
            jSONObject.put("answer2", "1명");
            jSONObject.put("answer3", "5000명");
            jSONObject.put("correct", "1");
            jSONObject.put("hint", "/mobilefirst/event2016/friend_201701.jsp?");
            jSONObject.put("linkYN", "Y");
        }
        else if(sdt.equals("20170303")){
            jSONObject.put("quest", "파격적인 에누리앱 단독특가! eDEAL의 오픈시각은?");
            jSONObject.put("answer1", "새벽 4시");
            jSONObject.put("answer2", "아침 10시");
            jSONObject.put("answer3", "저녁 11시");
            jSONObject.put("correct", "2");
            jSONObject.put("hint", "/mobilefirst/event2016/mobile_eal.jsp?"); 
            jSONObject.put("linkYN", "Y");
        }
        else if(sdt.equals("20170304")){
            jSONObject.put("quest", "원하는 생활쿠폰으로 교환할 수 있는 e머니! 구매 후 적립되는 쇼핑몰이 아닌 곳은?");
            jSONObject.put("answer1", "위메프");
            jSONObject.put("answer2", "11번가");
            jSONObject.put("answer3", "옥션");
            jSONObject.put("correct", "1");
            jSONObject.put("hint", "[앱 구매 자동적립 쇼핑몰]<br>G마켓, 옥션, 11번가, 인터파크, 티몬, GS SHOP, CJmall, SSG"
                    +"<br>※ 구매금액은 배송비, 설치비, 할인, 쇼핑몰 포인트 등 제외한 상품 결제금액만 반영됩니다."); 
            jSONObject.put("linkYN", "N");
        }
        else if(sdt.equals("20170305")){
            jSONObject.put("quest", "파격적인 에누리앱 단독특가! eDEAL의 내일의 상품은?");
            jSONObject.put("answer1", "아이폰8");
            jSONObject.put("answer2", "우주선");
            jSONObject.put("answer3", "미정");
            jSONObject.put("correct", "3");
            jSONObject.put("hint", "/mobilefirst/event2016/mobile_eal.jsp?");
            jSONObject.put("linkYN", "Y");
        }
        else if(sdt.equals("20170306")){
            jSONObject.put("quest", "오직 단 한 번! 에누리앱에서 첫구매혜택ⓔ3,000을 받으려면 얼마 이상 구매해야 할까요?");
            jSONObject.put("answer1", "100만원");
            jSONObject.put("answer2", "10만원");
            jSONObject.put("answer3", "1만원");
            jSONObject.put("correct", "3");
            jSONObject.put("hint", "/mobilefirst/event2016/purchase_event.jsp?");
            jSONObject.put("linkYN", "Y");
        }
        else if(sdt.equals("20170307")){
            jSONObject.put("quest", "이번 달에 일요일에 에누리를 출석하면 받을 수 있는 추가혜택은?");
            jSONObject.put("answer1", "벤츠 e220d");
            jSONObject.put("answer2", "비타500");
            jSONObject.put("answer3", "갤럭시8");
            jSONObject.put("correct", "2");
            jSONObject.put("hint", "/mobilefirst/evt/visit_event.jsp?");
            jSONObject.put("linkYN", "Y");
        }
        else if(sdt.equals("20170308")){
            jSONObject.put("quest", "에누리는 2015년, 17년에 '소비자가 뽑은 가장 OOOO 브랜드' 대상을 받았습니다. 어떤 상일까요?");
            jSONObject.put("answer1", "사랑하는");
            jSONObject.put("answer2", "즐겨찾는");
            jSONObject.put("answer3", "신뢰하는");
            jSONObject.put("correct", "3");
            jSONObject.put("hint", " 에누리닷컴은 '2017 소비자가 뽑은 가장 신뢰하는 브랜드' 가격비교 부문에서 대상을 받았습니다."+
            "<br>2015년에 이어 2회째 수상에 감사드리며, 앞으로도 소비자를 최우선으로 생각하는 에누리 가격비교가 되도록 노력하겠습니다!");
            jSONObject.put("linkYN", "N");
        }
        else if(sdt.equals("20170309")){
            jSONObject.put("quest", "파격적인 에누리앱 단독특가! eDEAL의 내일의 상품은?");
            jSONObject.put("answer1", "수영장");
            jSONObject.put("answer2", "국대떡볶이");
            jSONObject.put("answer3", "에어컨");
            jSONObject.put("correct", "2");
            jSONObject.put("hint", "/mobilefirst/event2016/mobile_eal.jsp?");
            jSONObject.put("linkYN", "Y");
        }
        else if(sdt.equals("20170310")){
            jSONObject.put("quest", "이번 달에 앱에서 1만원 이상 3번 구매하면 100% 받을 수 있는 것은?");
            jSONObject.put("answer1", "꽃다발");
            jSONObject.put("answer2", "존경");
            jSONObject.put("answer3", "파리바게트 커피");
            jSONObject.put("correct", "3");
            jSONObject.put("hint", "/mobilefirst/evt/buy_event.jsp?tab=1&");
            jSONObject.put("linkYN", "Y");
        }
        else if(sdt.equals("20170311")){
            jSONObject.put("quest", "친구를 에누리앱으로 초대해서 친구가 첫구매를 하면 어떤 혜택을 받을 수 있을까요?");
            jSONObject.put("answer1", "친구만 ⓔ100");
            jSONObject.put("answer2", "나만 ⓔ100");
            jSONObject.put("answer3", "각각 ⓔ5,000");
            jSONObject.put("correct", "3");
            jSONObject.put("hint", "/mobilefirst/event2016/friend_201701.jsp?");
            jSONObject.put("linkYN", "Y");
        }
        else if(sdt.equals("20170312")){
            jSONObject.put("quest", "지금 에누리PC와 앱에서 진행중인 이벤트가 아닌 것은?");
            jSONObject.put("answer1", "첫구매 혜택");
            jSONObject.put("answer2", "크리스마스 소원");
            jSONObject.put("answer3", "출석체크");
            jSONObject.put("correct", "2");
            jSONObject.put("hint", "/mobilefirst/renew/plan.jsp?menu=E&");
            jSONObject.put("linkYN", "Y");
        }
        else if(sdt.equals("20170313")){
            jSONObject.put("quest", "파격적인 에누리앱 단독특가! eDEAL의 내일의 상품은?");
            jSONObject.put("answer1", "젖병세정제");
            jSONObject.put("answer2", "명품가방");
            jSONObject.put("answer3", "아우디 a6");
            jSONObject.put("correct", "1");
            jSONObject.put("hint", "/mobilefirst/event2016/mobile_eal.jsp?");
            jSONObject.put("linkYN", "Y");
        }
       
    }catch(JSONException ex){
        
    }
    return jSONObject;
}

%>