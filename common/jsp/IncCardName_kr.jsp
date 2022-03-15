<%
//2015.12.09 toodoo
//상품의 카드특가 체크를 위한 카드명 선언
//여러 파일에서 include하여 사용중
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
%>