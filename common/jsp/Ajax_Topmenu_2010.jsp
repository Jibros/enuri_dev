<%@ page contentType="text/html; charset=utf-8"%><%@ page import="java.util.*"%><%@ page import="com.enuri.util.common.*"%><%@ page import="com.enuri.include.RandomMain"%><%@ page import="com.enuri.bean.main.Shop_subcate_Data"%><%@ page import="com.enuri.bean.main.Shop_subcate_Proc"%><jsp:useBean id="RandomMain" class="com.enuri.include.RandomMain" scope="page" /><jsp:useBean id="Shop_subcate_Data" class="com.enuri.bean.main.Shop_subcate_Data" /><jsp:useBean id="Shop_subcate_Proc" class="com.enuri.bean.main.Shop_subcate_Proc" /><%@ page import="com.enuri.bean.main.Category_Data"%><%@ page import="com.enuri.bean.main.Category_Proc"%><jsp:useBean id="Category_Data" class="com.enuri.bean.main.Category_Data" scope="page" /><jsp:useBean id="Category_Proc" class="com.enuri.bean.main.Category_Proc" scope="page" />
<%!
public String getCateLink(String strCate) {
    String goLinkStr = "";
    String insertLogNum = "";
    String fashionPage = "";
    
    if(strCate.equals("091211")) {
        goLinkStr = "window.open('/fashion/Fashion_SubList.jsp?cate=14020917&from=topmenu','enuri_fashion','toolbar=yes,menubar=yes,status=yes,location=yes,scrollbars=yes,resizable=yes,top=0,left=0,width='+screen.availWidth+',height='+screen.availHeight);";
    }
    if(strCate.equals("100618")) {
        goLinkStr = "window.open('/fashion/Fashion_SubList.jsp?cate=140409&from=topmenu','enuri_fashion','toolbar=yes,menubar=yes,status=yes,location=yes,scrollbars=yes,resizable=yes,top=0,left=0,width='+screen.availWidth+',height='+screen.availHeight);";
    }
    if(strCate.substring(0,2).equals("15")) {
        goLinkStr = "/view/Listmp3.jsp?cate="+strCate;
    }
    if(strCate.substring(0,4).equals("0313")) {
      goLinkStr = "/view/Listmp3.jsp?cate="+strCate + "&brname=med";
     }
    if(strCate.substring(0,4).equals("0335")) {
      goLinkStr = "/view/Listmp3.jsp?cate="+strCate + "&brname=med";
     }
    if(strCate.substring(0,2).equals("14") ) {
        if(strCate.equals("148210")  || strCate.equals("148415") ||  strCate.equals("148508") || strCate.equals("148304") || strCate.equals("148305") || 
            strCate.equals("148351") || strCate.equals("148308") || strCate.equals("148406") || strCate.equals("148410") || 
            strCate.equals("148408") || strCate.equals("148411") ||  strCate.equals("148538") || strCate.equals("148442") || 
            strCate.equals("148509") || strCate.equals("148425") || strCate.equals("148510") || strCate.equals("148209"))
        {
            fashionPage = "1";
        }else if( strCate.equals("148438") || strCate.equals("148515") || strCate.equals("148536") ||
            strCate.equals("148414") || strCate.equals("148331") || strCate.equals("148343") || strCate.equals("148214") ||
            strCate.equals("148253")  || strCate.equals("148261") || strCate.equals("148216")  || strCate.equals("148311"))
        {
            fashionPage = "2";
        }else if(strCate.equals("148248") || strCate.equals("148519") || strCate.equals("148227") || strCate.equals("148220") || strCate.equals("148378") || 
            strCate.equals("148318")  || strCate.equals("148419") || 
            strCate.equals("148501") ||  strCate.equals("148502") || strCate.equals("148521") || strCate.equals("148209") || 
            strCate.equals("148312") || strCate.equals("148403") ||  strCate.equals("148313") || strCate.equals("148293") || strCate.equals("148574") || strCate.equals("148217") )
        {
            fashionPage = "3";
        }else if(strCate.equals("148421") || strCate.equals("148320") || 
            strCate.equals("148303") || strCate.equals("148321") || strCate.equals("148205")  || strCate.equals("148207") || 
            strCate.equals("148221"))
        {
            fashionPage = "4";
        }
        goLinkStr = "/view/fusion/Fusion.jsp?cate="+strCate;
        if(strCate.equals("145103")) goLinkStr += "&brand=%uC2A4%uC640%uCE58";
        if(strCate.equals("145108")) goLinkStr += "&brand=%uD3EC%uCCB4";
        if(strCate.equals("145104")) goLinkStr += "&brand=%uCE74%uC2DC%uC624";
        if(strCate.equals("145212")) goLinkStr += "&brand=%uC81C%uC774%uC5D0%uC2A4%uD2F0%uB098";
        if(strCate.equals("145405")) goLinkStr += "&brand=%uC5D8%uCE78%uD1A0";
        if(strCate.equals("145507")) goLinkStr += "&brand=%uC324%uC18C%uB098%uC774%uD2B8";
        if(strCate.equals("150709")) goLinkStr += "&brand2no=4924&brandName=%uC885%uAC00%uC9D1";
        if(strCate.equals("1458")) goLinkStr += "&brand2no=&ganada=&brandcate=";
        if(strCate.equals("1463")) goLinkStr = "/view/fusion/Fusion.jsp?cate=14570697";
        if(strCate.equals("1463")) goLinkStr = "/view/fusion/Fusion.jsp?cate=14570697";
        if(CutStr.cutStr(strCate,4).equals("1482")) goLinkStr = "/fashion/brand/Clothes_Brand_List.jsp?cate="+strCate+"&brand_page="+fashionPage;
        if(CutStr.cutStr(strCate,4).equals("1483")) goLinkStr = "/fashion/brand/Clothes_Brand_List.jsp?cate="+strCate+"&brand_page="+fashionPage;
        if(CutStr.cutStr(strCate,4).equals("1484")) goLinkStr = "/fashion/brand/Clothes_Brand_List.jsp?cate="+strCate+"&brand_page="+fashionPage;
        if(CutStr.cutStr(strCate,4).equals("1485")) goLinkStr = "/fashion/brand/Clothes_Brand_List.jsp?cate="+strCate+"&brand_page="+fashionPage;
        
        // 명품관 
        if(CutStr.cutStr(strCate,4).equals("1459")) {
            goLinkStr = "/view/fusion/Fusion_Masterpiece.jsp?cate="+strCate;
            if(strCate.equals("1459")) goLinkStr = "/view/fusion/Fusion_Masterpiece.jsp?cate=1459";
            if(strCate.equals("145920")) goLinkStr = "/view/fusion/Fusion_Masterpiece.jsp?cate=145920";
        }
    }
 
    // 인기패션 신규 변경 링크 20091111
    if(CutStr.cutStr(strCate, 4).equals("1471") || CutStr.cutStr(strCate, 4).equals("1472") || CutStr.cutStr(strCate, 4).equals("1473")) {
        if(strCate.length()==4) {
            //goLinkStr = "/fashion/clothes/Clothes_SubList.jsp?caCodeFlag=true&curStrCate="+strCate;
            goLinkStr = "/fashion/clothes/Clothes_StyleList.jsp?cate="+strCate;
        } else {
            goLinkStr = "/fashion/clothes/Clothes_StyleList.jsp?cate="+strCate;
        }
        insertLogNum = "3158";
    }

    if(strCate.equals("020908") || strCate.equals("021014") || strCate.equals("021410") ) {
        goLinkStr = "/view/Smilecat.jsp";
    }
    if(strCate.equals("1695") || strCate.equals("0695") || strCate.equals("1595")) {
        goLinkStr = "/view/Listmp3.jsp?cate=2199";
    }
    if(strCate.equals("020808") || strCate.equals("070406")) {
        goLinkStr = "/view/Listmp3.jsp?cate=0219";
    }
    if(strCate.substring(0,4).equals("1210")) {
        if(strCate.length()==4) {
            goLinkStr = "/view/Listmp3.jsp?cate=1603";
        } else {
            goLinkStr = "/view/Listmp3.jsp?cate=1603"+strCate.substring(4,6);
        }
    }
    if(strCate.equals("0491") || strCate.equals("0796")) {
        goLinkStr = "/view/Listmp3.jsp?cate=1890";
    }
    if(strCate.equals("147609"))    goLinkStr = "/view/Listmp3.jsp?cate=091209";
    if(strCate.equals("038026"))    goLinkStr = "/view/Listmp3.jsp?cate=222811";
    if(strCate.equals("038002"))    goLinkStr = "/view/Listmp3.jsp?cate=222711";
    if(strCate.equals("038003"))    goLinkStr = "/view/Listmp3.jsp?cate=222611";
    if(strCate.equals("038004"))    goLinkStr = "/view/Listmp3.jsp?cate=222211";
    if(strCate.equals("038005"))    goLinkStr = "/view/Listmp3.jsp?cate=222115";
    if(strCate.equals("038006"))    goLinkStr = "/view/Listmp3.jsp?cate=221312";
    if(strCate.equals("038007"))    goLinkStr = "/view/Listmp3.jsp?cate=221212";
    if(strCate.equals("038008"))    goLinkStr = "/view/Listmp3.jsp?cate=2211";
    if(strCate.equals("038009"))    goLinkStr = "/view/Listmp3.jsp?cate=2211";
    if(strCate.equals("038010"))    goLinkStr = "/view/Listmp3.jsp?cate=221121";
    if(strCate.equals("038027"))    goLinkStr = "/view/Listmp3.jsp?cate=22112106";
    if(strCate.equals("038011"))    goLinkStr = "/view/Listmp3.jsp?cate=221122";
    if(strCate.equals("038012"))    goLinkStr = "/view/Listmp3.jsp?cate=221108";
    if(strCate.equals("038013"))    goLinkStr = "/view/Listmp3.jsp?cate=221124";
    if(strCate.equals("038014"))    goLinkStr = "/view/Listmp3.jsp?cate=221107";
    if(strCate.equals("038015"))    goLinkStr = "/view/Listmp3.jsp?cate=221110";
    if(strCate.equals("038016"))    goLinkStr = "/view/Listmp3.jsp?cate=221119";
    if(strCate.equals("038017"))    goLinkStr = "/view/Listmp3.jsp?cate=221104";
    if(strCate.equals("038018"))    goLinkStr = "/view/Listmp3.jsp?cate=221129";
    if(strCate.equals("038019"))    goLinkStr = "/view/Listmp3.jsp?cate=221125";
    if(strCate.equals("038021"))    goLinkStr = "/view/Listmp3.jsp?cate=221130";
    if(strCate.equals("035207"))    goLinkStr = "/view/Listmp3.jsp?cate=0353";
    if(strCate.equals("035208"))    goLinkStr = "/view/Listmp3.jsp?cate=035401";
    
    if(strCate.equals("1588")) goLinkStr = "/view/Listmp3.jsp?cate=150603";
    
    if(strCate.equals("0680"))  goLinkStr = "/view/Listmp3.jsp?cate=0201";
    if(strCate.equals("059501"))    goLinkStr = "/view/Listmp3.jsp?cate=0501";
    if(strCate.equals("059502"))    goLinkStr = "/view/Listmp3.jsp?cate=050124";
    if(strCate.equals("059503"))    goLinkStr = "/view/Listmp3.jsp?cate=050125";
    if(strCate.equals("059504"))    goLinkStr = "/view/Listmp3.jsp?cate=050111";
    if(strCate.equals("059505"))    goLinkStr = "/view/Listmp3.jsp?cate=050117";
    if(strCate.equals("059506"))    goLinkStr = "/view/Listmp3.jsp?cate=050106";
    if(strCate.equals("059507"))    goLinkStr = "/view/Listmp3.jsp?cate=050101";
    if(strCate.equals("059508"))    goLinkStr = "/view/Listmp3.jsp?cate=050110";
    if(strCate.equals("059509"))    goLinkStr = "/view/Listmp3.jsp?cate=050116";
    if(strCate.equals("059510"))    goLinkStr = "/view/Listmp3.jsp?cate=0505";
    if(strCate.equals("059511"))    goLinkStr = "/view/Listmp3.jsp?cate=050501";
    if(strCate.equals("059512"))    goLinkStr = "/view/Listmp3.jsp?cate=050503";
    if(strCate.equals("059513"))    goLinkStr = "/view/Listmp3.jsp?cate=050502";
    if(strCate.equals("059514"))    goLinkStr = "/view/Listmp3.jsp?cate=050505";
    if(strCate.equals("059515"))    goLinkStr = "/view/Listmp3.jsp?cate=050514";
    if(strCate.equals("059516"))    goLinkStr = "/view/Listmp3.jsp?cate=050506";
    if(strCate.equals("059517"))    goLinkStr = "/view/Listmp3.jsp?cate=050508";
    if(strCate.equals("059518"))    goLinkStr = "/view/Listmp3.jsp?cate=050504";
    if(strCate.equals("059519"))    goLinkStr = "/view/Listmp3.jsp?cate=050515";
    if(strCate.equals("059520"))    goLinkStr = "/view/Listmp3.jsp?cate=050513";
    if(strCate.equals("059521"))    goLinkStr = "/view/Listmp3.jsp?cate=0530";
    if(strCate.equals("068001"))    goLinkStr = "/view/Listmp3.jsp?cate=0201";
    if(strCate.equals("068002"))    goLinkStr = "/view/Listmp3.jsp?cate=020129";
    if(strCate.equals("068003"))    goLinkStr = "/view/Listmp3.jsp?cate=020123";
    if(strCate.equals("068004"))    goLinkStr = "/view/Listmp3.jsp?cate=020103";
    if(strCate.equals("068005"))    goLinkStr = "/view/Listmp3.jsp?cate=020105";
    if(strCate.equals("068006"))    goLinkStr = "/view/Listmp3.jsp?cate=020117";
    if(strCate.equals("068007"))    goLinkStr = "/view/Listmp3.jsp?cate=020116";
    if(strCate.equals("068008"))    goLinkStr = "/view/Listmp3.jsp?cate=020115";
    if(strCate.equals("068009"))    goLinkStr = "/view/Listmp3.jsp?cate=020128";
    if(strCate.equals("068010"))    goLinkStr = "/view/Listmp3.jsp?cate=020101";
    if(strCate.equals("068011"))    goLinkStr = "/view/Listmp3.jsp?cate=0224";
    if(strCate.equals("059801"))    goLinkStr = "/view/Listmp3.jsp?cate=0516";
    if(strCate.equals("059401")) goLinkStr = "/view/Listmp3.jsp?cate=050408";
    if(strCate.equals("059402")) goLinkStr = "/view/Listmp3.jsp?cate=050407";
    if(strCate.equals("059403")) goLinkStr = "/view/Listmp3.jsp?cate=050413";
    if(strCate.equals("059404")) goLinkStr = "/view/Listmp3.jsp?cate=050425";
    if(strCate.equals("059405")) goLinkStr = "/view/Listmp3.jsp?cate=050417";
    if(strCate.equals("081018"))    goLinkStr = "/view/Listmp3.jsp?cate=081017";
    if(strCate.equals("059802"))    goLinkStr = "/view/Listmp3.jsp?cate=051616";
    if(strCate.equals("059803"))    goLinkStr = "/view/Listmp3.jsp?cate=051608";
    if(strCate.equals("059804"))    goLinkStr = "/view/Listmp3.jsp?cate=051609";
    if(strCate.equals("059805"))    goLinkStr = "/view/Listmp3.jsp?cate=051607";
    if(strCate.equals("059806"))    goLinkStr = "/view/Listmp3.jsp?cate=051614";
    if(strCate.equals("059807"))    goLinkStr = "/view/Listmp3.jsp?cate=0504";
    if(strCate.equals("059808"))    goLinkStr = "/view/Listmp3.jsp?cate=050416";
    if(strCate.equals("059809"))    goLinkStr = "/view/Listmp3.jsp?cate=050401";
    if(strCate.equals("059810"))    goLinkStr = "/view/Listmp3.jsp?cate=050407";
    if(strCate.equals("059811"))    goLinkStr = "/view/Listmp3.jsp?cate=050413";
    if(strCate.equals("059812"))    goLinkStr = "/view/Listmp3.jsp?cate=050425";
    if(strCate.equals("059813"))    goLinkStr = "/view/Listmp3.jsp?cate=050417";
    if(strCate.equals("147608"))    goLinkStr = "/view/Listmp3.jsp?cate=091222";
    if(strCate.equals("147623"))    goLinkStr = "/view/Listmp3.jsp?cate=091215";
    if(strCate.equals("147620"))    goLinkStr = "/view/Listmp3.jsp?cate=091228";
    if(strCate.equals("147622"))    goLinkStr = "/view/Listmp3.jsp?cate=091220";
    if(strCate.equals("147621"))    goLinkStr = "/view/Listmp3.jsp?cate=091223";
    if(strCate.equals("147625"))    goLinkStr = "/view/Listmp3.jsp?cate=091225";
    if(strCate.equals("147614"))    goLinkStr = "/view/Listmp3.jsp?cate=091214";
    if(strCate.equals("147613"))    goLinkStr = "/view/Listmp3.jsp?cate=091213";
    if(strCate.equals("147612"))    goLinkStr = "/view/Listmp3.jsp?cate=091212";
    if(strCate.equals("147615"))    goLinkStr = "/view/Listmp3.jsp?cate=091215";
    if(strCate.equals("147628"))    goLinkStr = "/view/Listmp3.jsp?cate=091208";
    if(strCate.equals("147626"))    goLinkStr = "/view/Listmp3.jsp?cate=091227";
    if(strCate.equals("147627"))    goLinkStr = "/view/Listmp3.jsp?cate=090116";
    if(strCate.equals("145408"))    goLinkStr = "/view/Listmp3.jsp?cate=091907";
    //if(strCate.equals("162204"))  goLinkStr = "/view/Listmp3.jsp?cate=15091104";
    //if(strCate.equals("162205"))  goLinkStr = "/view/Listmp3.jsp?cate=15091105";
    if(strCate.equals("162206"))    goLinkStr = "/view/Listmp3.jsp?cate=15091101";
    //if(strCate.equals("162202"))  goLinkStr = "/view/Listmp3.jsp?cate=15091103";
    
    if(strCate.equals("9764"))  goLinkStr = "/view/Listmp3.jsp?cate=030529";
    if(strCate.equals("0380"))  goLinkStr = "/view/Listmp3.jsp?cate=2211";
    if(strCate.equals("0379"))  goLinkStr = "/view/Listmp3.jsp?cate=2241";
    if(strCate.equals("0342"))  goLinkStr = "/view/Listmp3.jsp?cate=2208";
    if(strCate.equals("037904"))    goLinkStr = "/view/Listmp3.jsp?cate=224311";
    if(strCate.equals("037920"))   goLinkStr = "/view/Listmp3.jsp?cate=224411";
    if(strCate.equals("037902"))    goLinkStr = "/view/Listmp3.jsp?cate=2241&gb1=16192&gb2=13939";
    if(strCate.equals("037921"))    goLinkStr = "/view/Listmp3.jsp?cate=2241&gb1=16192&gb2=15803";
    if(strCate.equals("037922"))    goLinkStr = "/view/Listmp3.jsp?cate=2241&gb1=16192&gb2=15804";
    if(strCate.equals("038009")) goLinkStr = "/view/Listmp3.jsp?cate=222711";
    if(strCate.equals("9762"))  goLinkStr = "/view/Listmp3.jsp?cate=2208";
    if(strCate.equals("1218"))  goLinkStr = "/view/Listmp3.jsp?cate=120509";
    if(strCate.equals("1217"))  goLinkStr = "/view/Listmp3.jsp?cate=0512";
    if(strCate.equals("1684"))  goLinkStr = "/view/Listmp3.jsp?cate=0514";
    if(strCate.equals("1685"))  goLinkStr = "/view/Listmp3.jsp?cate=0510";
    if(strCate.equals("1686"))  goLinkStr = "/view/Listmp3.jsp?cate=0515";
    if(strCate.equals("1474"))  goLinkStr = "/view/Listmp3.jsp?cate=0913";
    if(strCate.equals("1475"))  goLinkStr = "/view/Listmp3.jsp?cate=0923";
    if(strCate.equals("1476"))  goLinkStr = "/view/Listmp3.jsp?cate=0912";
    if(strCate.equals("1477"))  goLinkStr = "/view/Listmp3.jsp?cate=1015";
    if(strCate.equals("1698"))  goLinkStr = "/view/Listmp3.jsp?cate=1817";
    if(strCate.equals("1616"))  goLinkStr = "/view/Listmp3.jsp?cate=1813";
    if(strCate.equals("1617"))  goLinkStr = "/view/Listmp3.jsp?cate=0213";
    if(strCate.equals("1619"))  goLinkStr = "/view/Listmp3.jsp?cate=0408";
    if(strCate.equals("1630"))  goLinkStr = "/view/Listmp3.jsp?cate=1209";
    if(strCate.equals("0819"))  goLinkStr = "/view/Listmp3.jsp?cate=1620";
    if(strCate.equals("1618"))  goLinkStr = "/view/Listmp3.jsp?cate=0513";
    if(strCate.equals("1696"))  goLinkStr = "/view/Listmp3.jsp?cate=0523";
    if(strCate.equals("1641")) goLinkStr = "/view/Listmp3.jsp?cate=160215";
    if(strCate.equals("0786"))  goLinkStr = "/view/Listmp3.jsp?cate=0420";
    if(strCate.equals("2111"))  goLinkStr = "/car/Index.jsp";
    if(strCate.equals("1465"))  goLinkStr = "/fashion/season/Fashion_Plan_Main.jsp";
    if(strCate.equals("0416"))  goLinkStr = "/view/Listprinter.jsp?cate=040207";
    if(strCate.equals("1002"))  goLinkStr = "/view/Listmp3.jsp?cate=0812";
    if(strCate.equals("1006"))  goLinkStr = "/fashion/Fashion_SubList.jsp?cate=1413";
    if(strCate.equals("0415"))  goLinkStr = "/view/Listmp3.jsp?cate=040207";
    if(strCate.equals("1214"))  goLinkStr = "/view/Listmp3.jsp?cate=1613";
    if(strCate.equals("1811"))  goLinkStr = "/view/Listmp3.jsp?cate=161308";
    if(strCate.equals("1212"))  goLinkStr = "/view/Listmp3.jsp?cate=1607";
    if(strCate.equals("1211"))  goLinkStr = "/view/Listmp3.jsp?cate=1606";
    if(strCate.equals("1216"))  goLinkStr = "/view/Listmp3.jsp?cate=1631";
    if(strCate.equals("2117"))  goLinkStr = "/view/Listmp3.jsp?cate=2117";
    if(strCate.equals("2118"))  goLinkStr = "/view/Listmp3.jsp?cate=210906";
    if(strCate.equals("2119"))  goLinkStr = "/view/Listmp3.jsp?cate=210902";
    if(strCate.equals("1697"))  goLinkStr = "/view/Listmp3.jsp?cate=060615";
    if(strCate.equals("0690"))  goLinkStr = "/view/Listmp3.jsp?cate=0506";
    if(strCate.equals("1809"))  goLinkStr = "/view/Listmp3.jsp?cate=0345";
    if(strCate.equals("1810"))  goLinkStr = "/view/Listmp3.jsp?cate=021239";
    if(strCate.equals("0693"))  goLinkStr = "/view/Listmp3.jsp?cate=161308";
    if(strCate.equals("0694"))  goLinkStr = "/view/Listmp3.jsp?cate=9003";
    //if(strCate.equals("041101"))goLinkStr = "/view/Listmp3.jsp?cate=0404";
    //if(strCate.equals("0307"))    goLinkStr = "/view/Listmp3.jsp?cate=0402";
    if(strCate.equals("1806"))  goLinkStr = "/view/Listmp3.jsp?cate=0527";
    if(strCate.equals("1222") || strCate.equals("0292"))    goLinkStr = "/view/move_mall.jsp";
    if(strCate.equals("1223"))  goLinkStr = "/view/Listmp3.jsp?cate=0507";
    if(strCate.equals("0541"))    goLinkStr = "/view/List.jsp?cate=051622";
    if(strCate.equals("0291"))  goLinkStr = "/view/Listmp3.jsp?cate=9418";
    if(strCate.equals("9601"))  goLinkStr = "/view/Listmp3.jsp?cate=0209";
    if(strCate.equals("9602"))  goLinkStr = "/view/Listmp3.jsp?cate=0221";
    if(strCate.equals("9603"))  goLinkStr = "/view/Listmp3.jsp?cate=0225";
    if(strCate.equals("9604"))  goLinkStr = "/view/Listmp3.jsp?cate=0206";
    if(strCate.equals("9605"))  goLinkStr = "/view/Listmp3.jsp?cate=0222";
    if(strCate.equals("9606"))  goLinkStr = "/view/Listmp3.jsp?cate=2201";
    if(strCate.equals("2116"))  goLinkStr = "/view/Listmp3.jsp?cate=211333";
    if(strCate.equals("0594"))  goLinkStr = "/view/Listmp3.jsp?cate=0504";
    if(strCate.equals("0293"))  goLinkStr = "/view/Listmp3.jsp?cate=2208";
    //if(strCate.equals("9608"))    goLinkStr = "/view/Listmp3.jsp?cate=034209";
    if(strCate.equals("9609"))  goLinkStr = "/view/Listmp3.jsp?cate=0207";
    if(strCate.equals("0293"))  goLinkStr = "/view/Listmp3.jsp?cate=2208";
    if(strCate.equals("1591"))  goLinkStr = "/view/Listmp3.jsp?cate=150210";
    if(strCate.equals("1592"))  goLinkStr = "/view/Listmp3.jsp?cate=150211";
    if(strCate.equals("1593"))  goLinkStr = "/view/Listmp3.jsp?cate=150501"; 
    if(strCate.equals("0204"))  goLinkStr = "/view/Listmp3.jsp?cate=0203";
    if(strCate.equals("1027"))  goLinkStr = "/view/Listmp3.jsp?cate=101211";
    if(strCate.equals("092106")) goLinkStr = "/view/fusion/Fusion.jsp?cate=14550908&factory=&in_keyword=";  
    if(strCate.equals("0689"))  goLinkStr = "/view/Listmp3.jsp?cate=061116";
    if(strCate.equals("0688"))  goLinkStr = "/view/Listmp3.jsp?cate=0224";         
    if(strCate.equals("0821"))  goLinkStr = "/view/Listmp3.jsp?cate=080809";
    if(strCate.equals("2110"))  goLinkStr = "/view/Paxinsu.jsp"; // 자동차 보험
    if(strCate.equals("1021"))  goLinkStr = "/view/Insurance_Insvalley.jsp?rtnurl=http://insvalley.enuri.com/join_site/dmz_snu.jsp?h_targetPage=/goods/gallerylist.jsp||market_cd=D04||market_point_cd=PLA_20100825004&ac=SNU_B_2010082500003"; // 어린이 보험
    if(strCate.equals("2111_1")) goLinkStr = "/car/Index.jsp";
    if(strCate.equals("121007")) goLinkStr = "/view/Listmp3.jsp?cate=160307";
    if(strCate.equals("970205")) goLinkStr = "/view/Listmp3.jsp?cate.value=211309";
//  if(strCate.equals("150601")) goLinkStr = "/view/Listmp3.jsp?cate=100506";
//  if(strCate.equals("150602")) goLinkStr = "/view/Listmp3.jsp?cate=100502";
//  if(strCate.equals("150603")) goLinkStr = "/view/Listmp3.jsp?cate=100515";
    if(strCate.equals("150605")) goLinkStr = "/view/Listmp3.jsp?cate=100501";
    if(strCate.equals("021203")) goLinkStr = "/view/Listmp3.jsp?cate=0217";
//  if(strCate.equals("091411")) goLinkStr = "/view/Listmp3.jsp?cate=0916";
    if(strCate.equals("100202")) goLinkStr = "/view/Listmp3.jsp?cate=081202";
    if(strCate.equals("1582")) goLinkStr = "/knowbox/planList.jsp?ppno=184";
    if(strCate.equals("100204")) goLinkStr = "/view/Listmp3.jsp?cate=081206";
    if(strCate.equals("100201")) goLinkStr = "/view/Listmp3.jsp?cate=081201";
    if(strCate.equals("100203")) goLinkStr = "/view/Listmp3.jsp?cate=081203";
    if(strCate.equals("100207")) goLinkStr = "/view/Listmp3.jsp?cate=081207";
    if(strCate.equals("100205")) goLinkStr = "/view/Listmp3.jsp?cate=081205";
    if(strCate.equals("100206")) goLinkStr = "/view/Listmp3.jsp?cate=081204";
    if(strCate.equals("100208")) goLinkStr = "/view/Listmp3.jsp?cate=081208";
    if(strCate.equals("081306")) goLinkStr = "/view/Listmp3.jsp?cate=0521";
    if(strCate.equals("021806")) goLinkStr = "/view/Listmp3.jsp?cate=0217";
    if(strCate.equals("100614")) goLinkStr = "/view/Listmp3.jsp?cate=090903";
    if(strCate.equals("090808")) goLinkStr = "/view/Listmp3.jsp?cate=0913";
    if(strCate.equals("140806")) goLinkStr = "/view/Listmp3.jsp?cate=0914";
    if(strCate.equals("147629")) goLinkStr = "/view/Listmp3.jsp?cate=091229";
    if(strCate.equals("020407")) goLinkStr = "/view/Listmp3.jsp?cate=0692";
    if(strCate.equals("021907")) goLinkStr = "/view/Listmp3.jsp?cate=070401";
    if(strCate.equals("971301")) goLinkStr = "/view/Listmp3.jsp?cate=2113";
    if(strCate.equals("971302")) goLinkStr = "/view/Listmp3.jsp?cate=2116";
    if(strCate.equals("971303")) goLinkStr = "/view/Listmp3.jsp?cate=2101";
    if(strCate.equals("971304")) goLinkStr = "/view/Listmp3.jsp?cate=2117";
    if(strCate.equals("971305")) goLinkStr = "/view/Listmp3.jsp?cate=21090402";
    if(strCate.equals("971306")) goLinkStr = "/view/Listmp3.jsp?cate=210902";
    if(strCate.equals("163208")) goLinkStr = "/view/Listmp3.jsp?cate=1625";
    if(strCate.equals("0383")) goLinkStr = "/view/Listmp3.jsp?cate=0222";
    if(strCate.equals("0381")) goLinkStr = "/view/Listmp3.jsp?cate=0212";
    if(strCate.equals("0382")) goLinkStr = "/view/Listmp3.jsp?cate=0217";
    if(strCate.equals("0595")) goLinkStr = "/view/Listmp3.jsp?cate=0501";
    if(strCate.equals("0598")) goLinkStr = "/view/Listmp3.jsp?cate=0516";
    if(strCate.equals("052205")) goLinkStr = "/view/Listmp3.jsp?cate=162905";
    if(strCate.equals("052206")) goLinkStr = "/view/Listmp3.jsp?cate=162906";
    if(strCate.equals("052207")) goLinkStr = "/view/Listmp3.jsp?cate=162907";
    if(strCate.equals("189008")) goLinkStr = "/view/Listmp3.jsp?cate=040207";
    if(strCate.equals("121208")) goLinkStr = "/view/Listmp3.jsp?cate=160708";
    if(strCate.equals("189013")) goLinkStr = "/view/Listmp3.jsp?cate=1505";
    if(strCate.equals("07090710")) goLinkStr = "/view/Listmp3.jsp?cate=02081201";
    if(strCate.equals("02120702")) goLinkStr = "/view/Listmp3.jsp?cate=210113";
    if(strCate.equals("0317")) goLinkStr = "/view/Listmp3.jsp?cate=9716";
    if(strCate.equals("0320")) goLinkStr = "/view/Listmp3.jsp?cate=9720";
    if(strCate.equals("9720")) goLinkStr = "/view/Listmp3.jsp?cate=9720";
    if(strCate.equals("1587")) goLinkStr = "/view/Listmp3.jsp?cate=150815";
    if(strCate.equals("147609")) goLinkStr = "/view/Listmp3.jsp?cate=091226";
    if(strCate.equals("970205")) goLinkStr = "/view/Listmp3.jsp?cate=211309";
    //if(strCate.equals("0307")) goLinkStr = "/view/Listmp3.jsp?cate=031112";
    if(strCate.equals("9718")) goLinkStr = "/view/Listmp3.jsp?cate=020115";
    if(strCate.equals("9719")) goLinkStr = "/view/Listmp3.jsp?cate=020916";
    if(strCate.equals("971801")) goLinkStr = "/view/Listmp3.jsp?cate=02011501";
    if(strCate.equals("971802")) goLinkStr = "/view/Listmp3.jsp?cate=02011502";
    if(strCate.equals("971803")) goLinkStr = "/view/Listmp3.jsp?cate=02011503";
    if(strCate.equals("971804")) goLinkStr = "/view/Listmp3.jsp?cate=02011512";
    if(strCate.equals("941817")) goLinkStr = "/view/Listmp3.jsp?cate=1812";
    if(strCate.equals("971805")) goLinkStr = "/view/Listmp3.jsp?cate=02011511";
    if(strCate.equals("971806")) goLinkStr = "/view/Listmp3.jsp?cate=02011521";
    if(strCate.equals("971901")) goLinkStr = "/view/Listmp3.jsp?cate=02091601";
    if(strCate.equals("971902")) goLinkStr = "/view/Listmp3.jsp?cate=02091602";
    if(strCate.equals("971612")) goLinkStr = "/view/Listmp3.jsp?cate=0319";
    if(strCate.equals("972006")) goLinkStr = "/view/Listmp3.jsp?cate=0319"; 
    if(strCate.equals("101907")) goLinkStr = "/view/Listmp3.jsp?cate=040813"; 
    if(strCate.equals("0525")) goLinkStr = "/view/Listmp3.jsp?cate=162908";
    if(strCate.equals("092709")) goLinkStr = "/tour2012/Tour_Index.jsp";
    if(strCate.equals("092710")) goLinkStr = "/view/Listmp3.jsp?cate=150807";
    if(strCate.equals("030429")) goLinkStr = "/view/Listmp3.jsp?cate=0319";
    if(strCate.equals("1099")) goLinkStr = "/view/Listmp3.jsp?cate=900509";
    if(strCate.equals("9717")) goLinkStr = "/view/Listmp3.jsp?cate=900509";
    if(strCate.equals("0699")) goLinkStr = "/view/Listmp3.jsp?cate=900510";
    if(strCate.equals("1594")) goLinkStr = "/view/Listmp3.jsp?cate=900510";
    if(strCate.equals("0290")) goLinkStr = "/view/Listmp3.jsp?cate=900509";
    if(strCate.equals("0490")) goLinkStr = "/view/Listmp3.jsp?cate=900509";
    if(strCate.equals("0899")) goLinkStr = "/view/Listmp3.jsp?cate=900506";
    if(strCate.equals("0525")) goLinkStr = "/view/Listmp3.jsp?cate=162908";
    if(strCate.equals("2123")) goLinkStr = "/view/Listmp3.jsp?cate=212202";
    if(strCate.equals("2124")) goLinkStr = "/view/Listmp3.jsp?cate=210804";
    if(strCate.equals("2125")) goLinkStr = "/view/Listmp3.jsp?cate=210316";
    if(strCate.equals("040130")) goLinkStr = "/view/Listmp3.jsp?cate=0420";
    if(strCate.equals("042014")) goLinkStr = "/view/Listmp3.jsp?cate=0401";
    if(strCate.equals("092101")) goLinkStr = "/view/fusion/Fusion.jsp?cate=145504";
    if(strCate.equals("180812")) goLinkStr = "/view/Listmp3.jsp?cate=1807"; 
    if(strCate.equals("022711")) goLinkStr = "/view/Listmp3.jsp?cate=0227";        
    if(strCate.equals("1288")) goLinkStr = "/view/Listmp3.jsp?cate=180204";  
    if(strCate.equals("022311")) goLinkStr = "/view/Listmp3.jsp?cate=0223";        
    if(strCate.equals("0821")) goLinkStr = "/view/Listmp3.jsp?cate=080809";        
    if(strCate.equals("0830")) goLinkStr = "/view/brandlist/Brandlist.jsp?cmdChg=YES&cmd=imglist&cate=08&from=search&skeyword=%BF%A1%B6%D9%B5%E5&brandCate=0811&brand2No=4356&cate_keyword=Y&hyphen_2=false";
 // if(strCate.equals("150604")) goLinkStr = "/view/Listmp3.jsp?cate=100505";
    if(strCate.equals("161408")) goLinkStr = "/view/Listmp3.jsp?cate=161410";
    if(strCate.equals("092109")) goLinkStr = "/tour2012/Tour_Index.jsp";
    if(strCate.equals("0824")) goLinkStr = "/view/Listmp3.jsp?cate=08061108";      
    if(strCate.equals("1481")) goLinkStr = "/fashion/brand/Clothes_Brand_List.jsp?cate=1481&brand2no=&brandcate=";      
    if(strCate.equals("148101")) goLinkStr = "/fashion/brand/Clothes_Brand_List.jsp?cate=148101";   
    if(strCate.equals("148102")) goLinkStr = "/fashion/brand/Clothes_Brand_List.jsp?cate=148102";   
    if(strCate.equals("148103")) goLinkStr = "/fashion/brand/Clothes_Brand_List.jsp?cate=148103";   
    if(strCate.equals("148104")) goLinkStr = "/fashion/brand/Clothes_Brand_List.jsp?cate=148104";   
    if(strCate.equals("090410")) goLinkStr = "/view/Listmp3.jsp?cate=15010304";        
    if(strCate.equals("092908")) goLinkStr = "/view/Listmp3.jsp?cate=150103";       
    if(strCate.equals("032810")) goLinkStr = "/view/Flower_Easyflower.jsp?cate=&menu=false&flag=73";
    if(strCate.equals("12281001")) goLinkStr = "/view/Flower_Easyflower.jsp?cate=&menu=false&flag=73";      
    if(strCate.equals("12281002")) goLinkStr = "/view/Listmp3.jsp?cate=15081301";  
    if(strCate.equals("1694")) goLinkStr = "/view/Listmp3.jsp?cate=162908";        
    if(strCate.equals("162106")) goLinkStr = "/view/Listmp3.jsp?cate=162115";
    if(strCate.equals("1497"))  goLinkStr = "/view/fusion/Fusion.jsp?cate=14540702";
    if(strCate.equals("0991")) goLinkStr = "/view/Listmp3.jsp?cate=0515";
    if(strCate.equals("0992")) goLinkStr = "/view/Listmp3.jsp?cate=0510";
    if(strCate.equals("0993")) goLinkStr = "/view/Listmp3.jsp?cate=0521";
    if(strCate.equals("1823")) goLinkStr = "/view/Listmp3.jsp?cate=18190501";
    if(strCate.equals("900305")) goLinkStr = "/tour2012/Tour_Index.jsp?skind=3";
    if(strCate.equals("941815"))    goLinkStr = "/view/Listmp3.jsp?cate=1510"; 
    if(strCate.equals("0994"))  goLinkStr = "/tour2012/Tour_Index.jsp"; 
    if(strCate.equals("0995"))  goLinkStr = "/view/Tour_Tourjockey.jsp";
    if(strCate.equals("122810")) goLinkStr = "/view/Flower365.jsp";
    if(strCate.equals("1512"))  goLinkStr = "/view/Listmp3.jsp?cate=150509";
    if(strCate.equals("9610")) goLinkStr = "/view/Listmp3.jsp?cate=020928";
    if(strCate.equals("0528")) goLinkStr = "/view/Listmp3.jsp?cate=0610";
    if(strCate.equals("0910")) goLinkStr = "/view/Listmp3.jsp?cate=091103";
    if(strCate.equals("0697")) goLinkStr = "/view/Listmp3.jsp?cate=0502";
    if(strCate.equals("0698")) goLinkStr = "/view/Listmp3.jsp?cate=0503";
    if(strCate.equals("0827")) goLinkStr = "/view/Listmp3.jsp?cate=080809"; 
    if(strCate.equals("0829")) goLinkStr = "/view/Listmp3.jsp?cate=080413";
    if(strCate.equals("0902"))  goLinkStr = "/view/Listmp3.jsp?cate=092311";
    if(strCate.equals("0529"))  goLinkStr = "/view/Listmp3.jsp?cate=0418";
    //if(strCate.equals("1028"))    goLinkStr = "/view/Listmp3.jsp?cate=1620";
    if(strCate.equals("1589")) goLinkStr = "/view/Listmp3.jsp?cate=150811";        
    if(strCate.equals("163810")) goLinkStr = "/view/Flower_Easyflower.jsp?cate=&menu=false&flag=73";
    if(strCate.equals("0334")) goLinkStr = "/view/Listmp3.jsp?cate=180219";    
    if(strCate.equals("033401")) goLinkStr = "/view/Listmp3.jsp?cate=181811";  
    if(strCate.equals("033402")) goLinkStr = "/view/Listmp3.jsp?cate=18181112";    
    if(strCate.equals("033403")) goLinkStr = "/view/Listmp3.jsp?cate=18181113";    
    if(strCate.equals("033404")) goLinkStr = "/view/Listmp3.jsp?cate=18181114";    
    if(strCate.equals("033405")) goLinkStr = "/view/Listmp3.jsp?cate=18181110";    
    if(strCate.equals("033406")) goLinkStr = "/view/Listmp3.jsp?cate=18181111";        
    if(strCate.equals("033414")) goLinkStr = "/view/Listmp3.jsp?cate=18181115";
    if(strCate.equals("033407")) goLinkStr = "/view/Listmp3.jsp?cate=181812";  
    if(strCate.equals("033408")) goLinkStr = "/view/Listmp3.jsp?cate=18181211";    
    if(strCate.equals("033409")) goLinkStr = "/view/Listmp3.jsp?cate=18181208";    
    if(strCate.equals("033410")) goLinkStr = "/view/Listmp3.jsp?cate=18181209";    
    if(strCate.equals("033411")) goLinkStr = "/view/Listmp3.jsp?cate=18181210";    
    if(strCate.equals("033412")) goLinkStr = "/view/Listmp3.jsp?cate=18181212";    
    if(strCate.equals("033413")) goLinkStr = "/view/Listmp3.jsp?cate=181813";  
    if(strCate.equals("021422")) goLinkStr = "/view/Listmp3.jsp?cate=034210";  
    if(strCate.equals("0823")) goLinkStr = "/view/Listmp3.jsp?cate=08010212";
    if(strCate.equals("0877")) goLinkStr = "/view/Listmp3.jsp?cate=080227";
    if(strCate.equals("0876")) goLinkStr = "/view/Listmp3.jsp?cate=080612";
    if(strCate.equals("1285")) goLinkStr = "/view/Listmp3.jsp?cate=164514";
    if(strCate.equals("1627")) goLinkStr = "/view/Listmp3.jsp?cate=181814";
    if(strCate.equals("162713")) goLinkStr = "/view/Listmp3.jsp?cate=181811";
    if(strCate.equals("162714")) goLinkStr = "/view/Listmp3.jsp?cate=18181112";
    if(strCate.equals("162715")) goLinkStr = "/view/Listmp3.jsp?cate=18181113"; 
    if(strCate.equals("162716")) goLinkStr = "/view/Listmp3.jsp?cate=18181114";
    if(strCate.equals("162717")) goLinkStr = "/view/Listmp3.jsp?cate=18181110";
    if(strCate.equals("162718")) goLinkStr = "/view/Listmp3.jsp?cate=18181111";
    if(strCate.equals("162726")) goLinkStr = "/view/Listmp3.jsp?cate=18181115";
    if(strCate.equals("162719")) goLinkStr = "/view/Listmp3.jsp?cate=181812";
    if(strCate.equals("162720")) goLinkStr = "/view/Listmp3.jsp?cate=18181211";
    if(strCate.equals("162721")) goLinkStr = "/view/Listmp3.jsp?cate=18181208";
    if(strCate.equals("162722")) goLinkStr = "/view/Listmp3.jsp?cate=18181209";
    if(strCate.equals("162723")) goLinkStr = "/view/Listmp3.jsp?cate=18181210";
    if(strCate.equals("162724")) goLinkStr = "/view/Listmp3.jsp?cate=18181212";
    if(strCate.equals("162725")) goLinkStr = "/view/Listmp3.jsp?cate=181813";
    if(strCate.equals("0419")) goLinkStr = "/view/Listmp3.jsp?cate=1803";
    if(strCate.equals("975501")) goLinkStr = "/view/Listmp3.jsp?cate=9752";    
    if(strCate.equals("975502")) goLinkStr = "/view/Listmp3.jsp?cate=9753";    
    if(strCate.equals("975503")) goLinkStr = "/view/Listmp3.jsp?cate=9754";
    if(strCate.equals("2122")) goLinkStr = "/view/Listmp3.jsp?cate=212211";
    if(strCate.equals("2123")) goLinkStr = "/view/Listmp3.jsp?cate=210815";
    if(strCate.equals("2124")) goLinkStr = "/view/Listmp3.jsp?cate=210804";
    if(strCate.equals("2125")) goLinkStr = "/view/Listmp3.jsp?cate=212209";
    if(strCate.equals("2126")) goLinkStr = "/view/Listmp3.jsp?cate=212210";
    if(strCate.equals("2127")) goLinkStr = "/view/Listmp3.jsp?cate=210302";
    if(strCate.equals("8901"))  goLinkStr = "/view/Listmp3.jsp?cate=0515";
    if(strCate.equals("8902"))  goLinkStr = "/view/Listmp3.jsp?cate=0510";
    if(strCate.equals("8903"))  goLinkStr = "/view/Listmp3.jsp?cate=0516";
    if(strCate.equals("8904"))  goLinkStr = "/view/Listmp3.jsp?cate=1636"; 
    if(strCate.equals("037917")) goLinkStr = "/view/Listmp3.jsp?cate=224120";
    if(strCate.equals("8905"))  goLinkStr = "/view/Listmp3.jsp?cate=061104";
    if(strCate.equals("8906"))  goLinkStr = "/view/Listmp3.jsp?cate=0904";
    if(strCate.equals("8907"))  goLinkStr = "/view/Listmp3.jsp?cate=0929";
    if(strCate.equals("8908"))  goLinkStr = "/view/Listmp3.jsp?cate=0521";
    if(strCate.equals("8909"))  goLinkStr = "/view/Listmp3.jsp?cate=1501";
    if(strCate.equals("030434")) goLinkStr = "/view/Listmp3.jsp?cate=03043404";
    if(strCate.equals("030522")) goLinkStr = "/view/Listmp3.jsp?cate=03052201";
    if(strCate.equals("0910")) goLinkStr = "/view/Listmp3.jsp?cate=091113";
    if(strCate.equals("1586")) goLinkStr = "/view/Listmp3.jsp?cate=150802";
    if(strCate.equals("9611")) goLinkStr = "/view/Listmp3.jsp?cate=2202";
    if(strCate.equals("0797")) goLinkStr = "/view/Listmp3.jsp?cate=0402";
    if(strCate.equals("0223")) goLinkStr = "/view/Listmp3.jsp?cate=021247";
    if(strCate.equals("0226")) goLinkStr = "/view/Listmp3.jsp?cate=2206";
    if(strCate.equals("1820")) goLinkStr = "/view/Listmp3.jsp?cate=121505";
    if(strCate.equals("1585")) goLinkStr = "/view/Listmp3.jsp?cate=15030701";  
    if(strCate.equals("1229")) goLinkStr = "/view/Listmp3.jsp?cate=122612";
    if(strCate.equals("1583")) goLinkStr = "/view/Listmp3.jsp?cate=150103";    
    if(strCate.equals("1584")) goLinkStr = "/view/Listmp3.jsp?cate=150111";    
    //if(strCate.equals("1582")) goLinkStr = "/view/plan/Plan_List.jsp?currpage=&lstPageSize=25&lstOrder=WP_TODAY+DESC&lstCategory=&lstTitle=%BC%B3%BC%B1%B9%B0+%C4%FC%B9%E8%BC%DB&lstChange=ImgChange2&lstShopnm=&tab_gubun=&lstType=&lstType1=&lstType2=ImgNum&lstPpno=184&tab_gubun_img=&singoChk=&titlepage=&firstpage=N&isallpage=&text_search=";  
    if(strCate.equals("1581"))  goLinkStr = "/view/Listmp3.jsp?cate=150205";
    if(strCate.equals("1579"))  goLinkStr = "/view/Listmp3.jsp?cate=150212";
    if(strCate.equals("1580"))  goLinkStr = "/view/Listmp3.jsp?cate=150207";
    if(strCate.equals("1891"))  goLinkStr = "/view/Listmp3.jsp?cate=120509";
    if(strCate.equals("94181510"))  goLinkStr = "/view/Listmp3.jsp?cate=1511";
    if(strCate.equals("0886"))  goLinkStr = "/view/Listmp3.jsp?cate=080418";
    if(strCate.equals("0887"))  goLinkStr = "/view/Listmp3.jsp?cate=080602";
    if(strCate.equals("0384"))  goLinkStr = "/view/Listmp3.jsp?cate=2202";
    if(strCate.equals("0385"))  goLinkStr = "/view/Listmp3.jsp?cate=2201";
    if(strCate.equals("0680"))  goLinkStr = "/view/Listmp3.jsp?cate=0201";
    if(strCate.equals("0294")) goLinkStr = "/view/Listmp3.jsp?cate=9750";   
    if(strCate.equals("9756")) goLinkStr = "/view/Listmp3.jsp?cate=2211";
    if(strCate.equals("038007")) goLinkStr = "/view/Listmp3.jsp?cate=221212";
    if(strCate.equals("038004")) goLinkStr = "/view/Listmp3.jsp?cate=222211";
    if(strCate.equals("038022")) goLinkStr = "/view/Listmp3.jsp?cate=222312";
    if(strCate.equals("038009")) goLinkStr = "/view/Listmp3.jsp?cate=2211";
    if(strCate.equals("975608")) goLinkStr = "/view/Listmp3.jsp?cate=221121";
    if(strCate.equals("975609")) goLinkStr = "/view/Listmp3.jsp?cate=221122";
    if(strCate.equals("975610")) goLinkStr = "/view/Listmp3.jsp?cate=031323";
    if(strCate.equals("975611")) goLinkStr = "/view/Listmp3.jsp?cate=221108";
    if(strCate.equals("975612")) goLinkStr = "/view/Listmp3.jsp?cate=221124";
    if(strCate.equals("975613")) goLinkStr = "/view/Listmp3.jsp?cate=221107";
    if(strCate.equals("975614")) goLinkStr = "/view/Listmp3.jsp?cate=221104";
    if(strCate.equals("975625")) goLinkStr = "/view/Listmp3.jsp?cate=221129";
    if(strCate.equals("975615")) goLinkStr = "/view/Listmp3.jsp?cate=221119";
    if(strCate.equals("975617")) goLinkStr = "/view/Listmp3.jsp?cate=221125";
    if(strCate.equals("975618")) goLinkStr = "/view/Listmp3.jsp?cate=221110";
    
    if(strCate.equals("0811")) goLinkStr = "/view/Listbrand.jsp?cate=0811";
    if(strCate.equals("1206")) goLinkStr = "/view/Listbrand.jsp?cate=1206";
    if(strCate.equals("2112")) goLinkStr = "/view/Listbrand.jsp?cate=2112";
    if(strCate.equals("0410")) goLinkStr = "/view/Listmp3.jsp?cate=2203";
    if(strCate.equals("0417")) goLinkStr = "/view/Listmp3.jsp?cate=0305";
    if(strCate.equals("0706")) goLinkStr = "/view/Listmp3.jsp?cate=2207";
    if(strCate.equals("1692")) goLinkStr = "/view/Listmp3.jsp?cate=1225";
    if(strCate.equals("0213")) goLinkStr = "/view/Listmp3.jsp?cate=021528";
    if(strCate.equals("1821")) goLinkStr = "/view/Listmp3.jsp?cate=181914";
    if(strCate.equals("1893")) goLinkStr = "/view/Listmp3.jsp?cate=180204";
    if(strCate.equals("1892")) goLinkStr = "/view/Listmp3.jsp?cate=181814";
    if(strCate.equals("050412")) goLinkStr = "/view/Listmp3.jsp?cate=050425";

    if(strCate.equals("9763"))  goLinkStr = "/view/Listmp3.jsp?cate=0219";
    if(strCate.equals("976301"))    goLinkStr = "/view/Listmp3.jsp?cate=021919";
    if(strCate.equals("976302"))    goLinkStr = "/view/Listmp3.jsp?cate=021901";    
    if(strCate.equals("976303"))    goLinkStr = "/view/Listmp3.jsp?cate=021902";
    if(strCate.equals("976304"))    goLinkStr = "/view/Listmp3.jsp?cate=021903";
    if(strCate.equals("976305"))    goLinkStr = "/view/Listmp3.jsp?cate=021904";    
    if(strCate.equals("976306"))    goLinkStr = "/view/Listmp3.jsp?cate=021905";
    if(strCate.equals("976307"))    goLinkStr = "/view/Listmp3.jsp?cate=021908";
    if(strCate.equals("976308"))    goLinkStr = "/view/Listmp3.jsp?cate=021909";
    if(strCate.equals("976309"))    goLinkStr = "/view/Listmp3.jsp?cate=021910";
    if(strCate.equals("976310"))    goLinkStr = "/view/Listmp3.jsp?cate=021911";
    if(strCate.equals("1574"))  goLinkStr = "/view/Listmp3.jsp?cate=150105";
    if(strCate.equals("1575"))  goLinkStr = "/view/Listmp3.jsp?cate=150113";
    if(strCate.equals("1576"))  goLinkStr = "/view/Listmp3.jsp?cate=150108";
    if(strCate.equals("1577"))  goLinkStr = "/view/Listmp3.jsp?cate=150114";
    if(strCate.equals("060524"))    goLinkStr = "/view/Listmp3.jsp?cate=060524";

    if(strCate.equals("0824")) goLinkStr = "/view/brandlist/Brandlist.jsp?cate=08&brandCate=0811&brand2No=3004";
    if(strCate.equals("9757")) goLinkStr = "/view/Listmp3.jsp?cate=2241";
    if(strCate.equals("975701")) goLinkStr = "/view/Listmp3.jsp?cate=034110";
    if(strCate.equals("037905")) goLinkStr = "/view/Listmp3.jsp?cate=224209"; 
    if(strCate.equals("037908")) goLinkStr = "/view/Listmp3.jsp?cate=2241";
    if(strCate.equals("037909")) goLinkStr = "/view/Listmp3.jsp?cate=224111";
    if(strCate.equals("037910")) goLinkStr = "/view/Listmp3.jsp?cate=224112";
    if(strCate.equals("037914")) goLinkStr = "/view/Listmp3.jsp?cate=224106";
    if(strCate.equals("975713")) goLinkStr = "/view/Listmp3.jsp?cate=224113";
    if(strCate.equals("037911")) goLinkStr = "/view/Listmp3.jsp?cate=224113";
    if(strCate.equals("037912")) goLinkStr = "/view/Listmp3.jsp?cate=224107";
    if(strCate.equals("037913")) goLinkStr = "/view/Listmp3.jsp?cate=224114";
    if(strCate.equals("037916")) goLinkStr = "/view/Listmp3.jsp?cate=224115";
    if(strCate.equals("037915")) goLinkStr = "/view/Listmp3.jsp?cate=224118";
    if(strCate.equals("037918")) goLinkStr = "/view/Listmp3.jsp?cate=224116";
    if(strCate.equals("975719")) goLinkStr = "/view/Listmp3.jsp?cate=033517"; 
    if(strCate.equals("975720")) goLinkStr = "/view/Listmp3.jsp?cate=033509";
    
    if(strCate.equals("038101")) goLinkStr = "/view/Listmp3.jsp?cate=0359";
    if(strCate.equals("038102")) goLinkStr = "/view/Listmp3.jsp?cate=035909";
    if(strCate.equals("038103")) goLinkStr = "/view/Listmp3.jsp?cate=035941";
    if(strCate.equals("038104")) goLinkStr = "/view/Listmp3.jsp?cate=035933";
    if(strCate.equals("038105")) goLinkStr = "/view/Listmp3.jsp?cate=035942";
    if(strCate.equals("038106")) goLinkStr = "/view/Listmp3.jsp?cate=035939";
    if(strCate.equals("038107")) goLinkStr = "/view/Listmp3.jsp?cate=035937";
    if(strCate.equals("038108")) goLinkStr = "/view/Listmp3.jsp?cate=035947";
    if(strCate.equals("038109")) goLinkStr = "/view/Listmp3.jsp?cate=0345";
    if(strCate.equals("038110")) goLinkStr = "/view/Listmp3.jsp?cate=034520";
    if(strCate.equals("038111")) goLinkStr = "/view/Listmp3.jsp?cate=034509";
    if(strCate.equals("038112")) goLinkStr = "/view/Listmp3.jsp?cate=034502";
    if(strCate.equals("038113")) goLinkStr = "/view/Listmp3.jsp?cate=034515";
    if(strCate.equals("038114")) goLinkStr = "/view/Listmp3.jsp?cate=034516";
    if(strCate.equals("038115")) goLinkStr = "/view/Listmp3.jsp?cate=034507";
    if(strCate.equals("038116")) goLinkStr = "/view/Listmp3.jsp?cate=034550";
    if(strCate.equals("038117")) goLinkStr = "/view/Listmp3.jsp?cate=034521";
    
    
    if(strCate.equals("038301")) goLinkStr = "/view/Listmp3.jsp?cate=0222";
    if(strCate.equals("038302")) goLinkStr = "/view/Listmp3.jsp?cate=022211";
    if(strCate.equals("038303")) goLinkStr = "/view/Listmp3.jsp?cate=022221";
    if(strCate.equals("038304")) goLinkStr = "/view/Listmp3.jsp?cate=022201";
    if(strCate.equals("038305")) goLinkStr = "/view/Listmp3.jsp?cate=022209";
    if(strCate.equals("038306")) goLinkStr = "/view/Listmp3.jsp?cate=022208";
    if(strCate.equals("038307")) goLinkStr = "/view/Listmp3.jsp?cate=2201";
    if(strCate.equals("038308")) goLinkStr = "/view/Listmp3.jsp?cate=220128";
    if(strCate.equals("038309")) goLinkStr = "/view/Listmp3.jsp?cate=220114";
    if(strCate.equals("038310")) goLinkStr = "/view/Listmp3.jsp?cate=220119";
    if(strCate.equals("038311")) goLinkStr = "/view/Listmp3.jsp?cate=220120";
    if(strCate.equals("038312")) goLinkStr = "/view/Listmp3.jsp?cate=220103";
    if(strCate.equals("038313")) goLinkStr = "/view/Listmp3.jsp?cate=220117";
    if(strCate.equals("038315")) goLinkStr = "/view/Listmp3.jsp?cate=220113";
    if(strCate.equals("038316")) goLinkStr = "/view/Listmp3.jsp?cate=220112";
    if(strCate.equals("038317")) goLinkStr = "/view/Listmp3.jsp?cate=220122";
    if(strCate.equals("038318")) goLinkStr = "/view/Listmp3.jsp?cate=2202";




    if(strCate.equals("038201")) goLinkStr = "/view/Listmp3.jsp?cate=0217";
    if(strCate.equals("038202")) goLinkStr = "/view/Listmp3.jsp?cate=021709";
    if(strCate.equals("038203")) goLinkStr = "/view/Listmp3.jsp?cate=021710";
    if(strCate.equals("038204")) goLinkStr = "/view/Listmp3.jsp?cate=021716";
    if(strCate.equals("038205")) goLinkStr = "/view/Listmp3.jsp?cate=021714";
    if(strCate.equals("038206")) goLinkStr = "/view/Listmp3.jsp?cate=021705";
    if(strCate.equals("038207")) goLinkStr = "/view/Listmp3.jsp?cate=021716";
    if(strCate.equals("038208")) goLinkStr = "/view/Listmp3.jsp?cate=021711";
    if(strCate.equals("038209")) goLinkStr = "/view/Listmp3.jsp?cate=0318";
    if(strCate.equals("038210")) goLinkStr = "/view/Listmp3.jsp?cate=031815";
    if(strCate.equals("038211")) goLinkStr = "/view/Listmp3.jsp?cate=031801";
    if(strCate.equals("038212")) goLinkStr = "/view/Listmp3.jsp?cate=031811";
    if(strCate.equals("038213")) goLinkStr = "/view/Listmp3.jsp?cate=031809";
    if(strCate.equals("038214")) goLinkStr = "/view/Listmp3.jsp?cate=031807";
    if(strCate.equals("038215")) goLinkStr = "/view/Listmp3.jsp?cate=031806";

    
    
    
    
    if(strCate.equals("038005")) goLinkStr = "/view/Listmp3.jsp?cate=222115";
    if(strCate.equals("038020")) goLinkStr = "/view/Listmp3.jsp?cate=2211&gb1=16193&gb2=14469";
    if(strCate.equals("975605")) goLinkStr = "/view/Listmp3.jsp?cate=0313&gb1=16192&gb2=10759";
    if(strCate.equals("975606")) goLinkStr = "/view/Listmp3.jsp?cate=0313&gb1=16193&gb2=10720";
    //if(strCate.equals("037904")) goLinkStr = "/view/Listmp3.jsp?cate=0313&gb1=17354&gb2=13088";
    if(strCate.equals("975704")) goLinkStr = "/view/Listmp3.jsp?cate=0313&gb1=16192&gb2=10844";
    if(strCate.equals("975721")) goLinkStr = "/view/Listmp3.jsp?cate=0313&gb1=16192&gb2=10847";
    if(strCate.equals("038006")) goLinkStr = "/view/Listmp3.jsp?cate=221312";
    if(strCate.equals("037906")) goLinkStr = "/view/Listmp3.jsp?cate=2241&gb1=18267&gb2=12907";
    if(strCate.equals("037903")) goLinkStr = "/view/Listmp3.jsp?cate=2241&gb1=16192&gb2=12700";
    if(strCate.equals("038003")) goLinkStr = "/view/Listmp3.jsp?cate=222611";
    
    //컴퓨터쪽_시작 
    if(strCate.equals("0791")) goLinkStr = "/view/Listmp3.jsp?cate=0404";
    if(strCate.equals("0792")) goLinkStr = "/view/Listmp3.jsp?cate=2203";
    if(strCate.equals("0793")) goLinkStr = "/view/Listmp3.jsp?cate=0305";
    if(strCate.equals("0794")) goLinkStr = "/view/Listmp3.jsp?cate=0401";
    if(strCate.equals("0795")) goLinkStr = "/view/Listmp3.jsp?cate=0405";
    if(strCate.equals("0492")) goLinkStr = "/view/Listmp3.jsp?cate=0712";
    if(strCate.equals("0493")) goLinkStr = "/view/Listmp3.jsp?cate=0702";
    if(strCate.equals("0494")) goLinkStr = "/view/Listmp3.jsp?cate=0709";
    if(strCate.equals("0495")) goLinkStr = "/view/Listmp3.jsp?cate=0710";
    if(strCate.equals("0496")) goLinkStr = "/view/Listmp3.jsp?cate=0704";
    if(strCate.equals("0497")) goLinkStr = "/view/Listmp3.jsp?cate=2207";
    if(strCate.equals("0498")) goLinkStr = "/view/Listmp3.jsp?cate=0714";
    if(strCate.equals("0796")) goLinkStr = "/view/Listmp3.jsp?cate=1890";
    if(strCate.equals("0798")) goLinkStr = "/view/Listmp3.jsp?cate=0408";
    if(strCate.equals("0781")) goLinkStr = "/view/Listmp3.jsp?cate=0414";
    if(strCate.equals("0782")) goLinkStr = "/view/Listmp3.jsp?cate=0402";
    if(strCate.equals("0783")) goLinkStr = "/view/Listmp3.jsp?cate=040207";
    if(strCate.equals("0784")) goLinkStr = "/view/Listmp3.jsp?cate=1803";
    if(strCate.equals("0785")) goLinkStr = "/view/Listmp3.jsp?cate=2205";
    if(strCate.equals("0407")) goLinkStr = "/view/Listmp3.jsp?cate=2205";
    if(strCate.equals("0214")) goLinkStr = "/view/Listmp3.jsp?cate=2201";
    if(strCate.equals("0231")) goLinkStr = "/view/Listmp3.jsp?cate=2202";
    if(strCate.equals("0481")) goLinkStr = "/view/Listmp3.jsp?cate=0713";
    if(strCate.equals("0482")) goLinkStr = "/view/Listmp3.jsp?cate=0707";
    if(strCate.equals("0483")) goLinkStr = "/view/Listmp3.jsp?cate=0708";
    if(strCate.equals("0484")) goLinkStr = "/view/Listmp3.jsp?cate=0703";
    if(strCate.equals("0485")) goLinkStr = "/view/Listmp3.jsp?cate=0705";
    if(strCate.equals("0486")) goLinkStr = "/view/Listmp3.jsp?cate=0711";
    if(strCate.equals("0487")) goLinkStr = "/view/Listmp3.jsp?cate=0701";
    if(strCate.equals("0780")) goLinkStr = "/view/Listmp3.jsp?cate=0418";
    if(strCate.equals("1293")) goLinkStr = "/view/Listmp3.jsp?cate=040207";
    //컴퓨터쪽_끝

    
    if(strCate.equals("082201")) goLinkStr = "/view/brandlist/Brandlist.jsp?cate=08&brandCate=0811&brand2No=3004";
    if(strCate.equals("082202")) goLinkStr = "/view/brandlist/Brandlist.jsp?cate=08&brandCate=0811&brand2No=4356";
    if(strCate.equals("082203")) goLinkStr = "/view/brandlist/Brandlist.jsp?cate=08&brandCate=0811&brand2No=5876";
    if(strCate.equals("082204")) goLinkStr = "/view/brandlist/Brandlist.jsp?cate=08&brandCate=0811&brand2No=9496";
    if(strCate.equals("082205")) goLinkStr = "/view/brandlist/Brandlist.jsp?cate=08&brandCate=0811&brand2No=5309";
    if(strCate.equals("082206")) goLinkStr = "/view/brandlist/Brandlist.jsp?cate=08&brandCate=0811&brand2No=7703";
    if(strCate.equals("082207")) goLinkStr = "/view/brandlist/Brandlist.jsp?cate=08&brandCate=0811&brand2No=5792";
    if(strCate.equals("082208")) goLinkStr = "/view/brandlist/Brandlist.jsp?cate=08&brandCate=0811&brand2No=7423";
    if(strCate.equals("082209")) goLinkStr = "/view/brandlist/Brandlist.jsp?cate=08&brandCate=0811&brand2No=8534";
                                    
    
    if(strCate.equals("9723")) goLinkStr = "/view/Listmp3.jsp?cate=0304";
    if(strCate.equals("9724")) goLinkStr = "/view/Listmp3.jsp?cate=2211";
    if(strCate.equals("9721")) goLinkStr = "/view/Listmp3.jsp?cate=0305";
    if(strCate.equals("9725")) goLinkStr = "/view/Listmp3.jsp?cate=0404";
    if(strCate.equals("9726")) goLinkStr = "/view/Listmp3.jsp?cate=2203";
    if(strCate.equals("9727")) goLinkStr = "/view/Listmp3.jsp?cate=0212";
    if(strCate.equals("9729")) goLinkStr = "/view/Listmp3.jsp?cate=021247";
    if(strCate.equals("9730")) goLinkStr = "/view/Listmp3.jsp?cate=0345";
    if(strCate.equals("9731")) goLinkStr = "/view/Listmp3.jsp?cate=0318";
    if(strCate.equals("9760")) goLinkStr = "/view/Listmp3.jsp?cate=03043404";
    if(strCate.equals("9761")) goLinkStr = "/view/Listmp3.jsp?cate=03052201";
    
    if(strCate.equals("0681"))  goLinkStr = "/view/Listmp3.jsp?cate=0211";
    if(strCate.equals("0682"))  goLinkStr = "/view/Listmp3.jsp?cate=0215";
    if(strCate.equals("0683"))  goLinkStr = "/view/Listmp3.jsp?cate=0208";
    if(strCate.equals("0684"))  goLinkStr = "/view/Listmp3.jsp?cate=0357";
    if(strCate.equals("0685"))  goLinkStr = "/view/Listmp3.jsp?cate=0203";
    if(strCate.equals("0686"))  goLinkStr = "/view/Listmp3.jsp?cate=0220";
    if(strCate.equals("0687"))  goLinkStr = "/view/Listmp3.jsp?cate=2206";
    if(strCate.equals("0597"))  goLinkStr = "/view/Listmp3.jsp?cate=0610";
    if(strCate.equals("1684"))  goLinkStr = "/view/Listmp3.jsp?cate=0514";
    if(strCate.equals("1685"))  goLinkStr = "/view/Listmp3.jsp?cate=0510";
    if(strCate.equals("1686"))  goLinkStr = "/view/Listmp3.jsp?cate=0515";
    if(strCate.equals("1697"))  goLinkStr = "/view/Listmp3.jsp?cate=060615";
    if(strCate.equals("1289"))  goLinkStr = "/view/Listmp3.jsp?cate=1803";
    if(strCate.equals("1290"))  goLinkStr = "/view/Listmp3.jsp?cate=1822";
    if(strCate.equals("1291"))  goLinkStr = "/view/Listmp3.jsp?cate=1801";
    if(strCate.equals("1292"))  goLinkStr = "/view/Listmp3.jsp?cate=1802";
    if(strCate.equals("1293"))  goLinkStr = "/view/Listmp3.jsp?cate=040207";
    if(strCate.equals("1294"))  goLinkStr = "/view/Listmp3.jsp?cate=0402";
    if(strCate.equals("1295"))  goLinkStr = "/view/Listmp3.jsp?cate=0527";
    if(strCate.equals("1296"))  goLinkStr = "/view/Listmp3.jsp?cate=1807";
    if(strCate.equals("1297"))  goLinkStr = "/view/Listmp3.jsp?cate=1808";
    if(strCate.equals("1218"))  goLinkStr = "/view/Listmp3.jsp?cate=120509";
    if(strCate.equals("1212"))  goLinkStr = "/view/Listmp3.jsp?cate=1607";  
        
    if(strCate.equals("1805")) goLinkStr = "/view/Listmp3.jsp?cate=0402";    
    if(strCate.equals("1804")) goLinkStr = "/view/Listprinter.jsp?cate=040207";  
    if(strCate.equals("1815")) goLinkStr = "/view/Listmp3.jsp?cate=0408";    
    if(strCate.equals("1816")) goLinkStr = "/view/Listmp3.jsp?cate=021528";  
    if(strCate.equals("0216")) goLinkStr = "/view/Listmp3.jsp?cate=1817";    
    if(strCate.equals("092913")) goLinkStr = "/view/Listmp3.jsp?cate=0904";
    if(strCate.equals("092908")) goLinkStr = "/view/Listmp3.jsp?cate=150103";
    if(strCate.equals("090411")) goLinkStr = "/view/Listmp3.jsp?cate=0929";
    if(strCate.equals("0230"))  goLinkStr = "/view/Listmp3.jsp?cate=0345";  
    if(strCate.equals("2121"))  goLinkStr = "/view/Listmp3.jsp?cate=211332";    
    
    if(strCate.equals("9721")) goLinkStr = "/view/Listmp3.jsp?cate=0305";
    if(strCate.equals("972102")) goLinkStr = "/view/Listmp3.jsp?cate=030509";
    if(strCate.equals("972103")) goLinkStr = "/view/Listmp3.jsp?cate=030550";
    if(strCate.equals("972104")) goLinkStr = "/view/Listmp3.jsp?cate=030501";
    if(strCate.equals("972105")) goLinkStr = "/view/Listmp3.jsp?cate=030502";
    if(strCate.equals("972106")) goLinkStr = "/view/Listmp3.jsp?cate=030551";
    if(strCate.equals("972107")) goLinkStr = "/view/Listmp3.jsp?cate=030503";
    if(strCate.equals("972108")) goLinkStr = "/view/Listmp3.jsp?cate=030504";
    if(strCate.equals("972109")) goLinkStr = "/view/Listmp3.jsp?cate=030505";
    if(strCate.equals("972110")) goLinkStr = "/view/Listmp3.jsp?cate=030510";
    if(strCate.equals("972111")) goLinkStr = "/view/Listmp3.jsp?cate=030560";
    if(strCate.equals("9751")) goLinkStr = "/view/Listmp3.jsp?cate=2241";
    if(strCate.equals("9758")) goLinkStr = "/view/Listmp3.jsp?cate=0304";
    if(strCate.equals("9759")) goLinkStr = "/view/Listmp3.jsp?cate=0305";
    if(strCate.equals("1628"))  goLinkStr = "/view/Listmp3.jsp?cate=164514";
    if(strCate.equals("1690"))  goLinkStr = "/view/Listmp3.jsp?cate=164704";
    
    if(strCate.equals("1224")) goLinkStr = "/view/Listmp3.jsp?cate=169310";    
    if(strCate.equals("122401")) goLinkStr = "/view/Listmp3.jsp?cate=169311";  
    if(strCate.equals("122402")) goLinkStr = "/view/Listmp3.jsp?cate=169312";  
    if(strCate.equals("122403")) goLinkStr = "/view/Listmp3.jsp?cate=169313";  
    if(strCate.equals("122404")) goLinkStr = "/view/Listmp3.jsp?cate=169314";  
    if(strCate.equals("079006")) goLinkStr = "/view/Listmp3.jsp?cate=07900601";    
    if(strCate.equals("062123")) goLinkStr = "/view/Listmp3.jsp?cate=150809";    
    if(strCate.equals("1578")) goLinkStr = "/view/Listmp3.jsp?cate=150811";
    
    if(CutStr.cutStr(strCate, 4).equals("2126")){
        //if(strCate.equals("2126")) goLinkStr = "/view/Listmp3.jsp?cate=0918";
        
        if(strCate.equals("212611")) goLinkStr = "/view/Listmp3.jsp?cate=091802";
        if(strCate.equals("212601")) goLinkStr = "/view/Listmp3.jsp?cate=091809";
        if(strCate.equals("212602")) goLinkStr = "/view/Listmp3.jsp?cate=091810";
        if(strCate.equals("212612")) goLinkStr = "/view/Listmp3.jsp?cate=091806";
        if(strCate.equals("212603")) goLinkStr = "/view/Listmp3.jsp?cate=091803";
        if(strCate.equals("212604")) goLinkStr = "/view/Listmp3.jsp?cate=091812";
        if(strCate.equals("212605")) goLinkStr = "/view/Listmp3.jsp?cate=091804";
        if(strCate.equals("212606")) goLinkStr = "/view/Listmp3.jsp?cate=091813";
        if(strCate.equals("212607")) goLinkStr = "/view/Listmp3.jsp?cate=091811";
        if(strCate.equals("212608")) goLinkStr = "/view/Listmp3.jsp?cate=091807";
        if(strCate.equals("212609")) goLinkStr = "/view/Listmp3.jsp?cate=091808";
        if(strCate.equals("212610")) goLinkStr = "/view/Listmp3.jsp?cate=091805";
        
        insertLogNum = "5312";
    }
    /*휴대폰 액세서리*/
    if(CutStr.cutStr(strCate, 6).equals("038008") ){
        goLinkStr = "/view/Listmp3.jsp?cate=2211&brname=med";
    }
    if(CutStr.cutStr(strCate, 6).equals("037907") ){
        goLinkStr = "/view/Listmp3.jsp?cate=2241&brname=med";
    }   

    // 식품>모바일 쿠폰 (1590) → 오피스/취미>상품권/e쿠폰/워터파크>먹거리 (181903)
    if(strCate.equals("1590")) {
        goLinkStr = "/view/Listmp3.jsp?cate=181919";
    } 
                    
    if(goLinkStr.length()==0) {
        goLinkStr = "/view/Listmp3.jsp?cate="+strCate;
    }
    if(goLinkStr.indexOf("window.open")==-1) {
        goLinkStr = "top.location.href='"+goLinkStr+"';";
    }
    if(strCate.equals("9713")) {
        goLinkStr = "return false;";
    }
    
    // 로그 추가
    if(strCate.equals("2198")) insertLogNum = "8743";
    if(strCate.equals("9416")) insertLogNum = "2824";
    if(strCate.equals("9416")) insertLogNum = "2823";
    if(strCate.equals("1620")) insertLogNum = "3621";
    if(strCate.equals("9721")) insertLogNum = "5166"; 
    if(strCate.equals("9718")) insertLogNum = "5171";
    if(strCate.equals("9722")) insertLogNum = "5263";   
    if(strCate.equals("0345")) insertLogNum = "6030";   
    if(strCate.equals("0692")) insertLogNum = "6031";   
    if(strCate.equals("0527")) insertLogNum = "6032";   
    if(strCate.equals("0824")) insertLogNum = "6055";   
    if(strCate.equals("0828")) insertLogNum = "6054";    
    if(strCate.equals("1209")) insertLogNum = "6062";    
    if(strCate.equals("1630")) insertLogNum = "6063";    
    if(strCate.equals("0821")) insertLogNum = "6092";    
    if(strCate.equals("1028")) insertLogNum = "6511";    
    if(strCate.equals("0829")) insertLogNum = "6560";    
    if(strCate.equals("0230")) insertLogNum = "6918";  
    if(strCate.equals("0887")) insertLogNum = "10094";
    if(strCate.equals("0886")) insertLogNum = "10093";
    if(strCate.equals("1225")) insertLogNum = "10148"; 
    if(strCate.equals("1692")) insertLogNum = "10149"; 
    if(strCate.equals("0504")) insertLogNum = "10134";

    // 혼수쪽 개별로그 삭제
    if(strCate.equals("1019")) insertLogNum = "2848";
    if(strCate.equals("0416")) insertLogNum = "2398";
    if(strCate.equals("2112")) insertLogNum = "1263";
    if(strCate.equals("2117")) insertLogNum = "1387";
    if(strCate.equals("2118")) insertLogNum = "1388";
    if(strCate.equals("2111")) insertLogNum = "351";
    if(strCate.equals("1017")) insertLogNum = "2466";
    if(strCate.equals("1471")) insertLogNum = "3150";
    if(strCate.equals("1472")) insertLogNum = "3151";
    if(strCate.equals("1473")) insertLogNum = "3152";
    if(strCate.equals("0594")) insertLogNum = "10133";
    if(strCate.equals("0819")) insertLogNum = "2711";
    if(strCate.equals("1465")) insertLogNum = "4533";
    if(strCate.equals("1463")) insertLogNum = "4532";
    if(strCate.equals("1021")) insertLogNum = "4756";

    if(strCate.equals("9723")) insertLogNum = "6212";
    if(strCate.equals("9724")) insertLogNum = "6213";
    if(strCate.equals("9721")) insertLogNum = "6214";
    if(strCate.equals("9716")) insertLogNum = "6215";
    if(strCate.equals("9725")) insertLogNum = "6216";
    if(strCate.equals("9726")) insertLogNum = "6217";
    if(strCate.equals("9727")) insertLogNum = "6218";
    if(strCate.equals("9729")) insertLogNum = "6219";
    if(strCate.equals("9730")) insertLogNum = "6220";
    if(strCate.equals("9731")) insertLogNum = "6221";
    if(strCate.equals("1627")) insertLogNum = "6763";
    if(strCate.equals("082201")) insertLogNum = "6254";
    if(strCate.equals("082202")) insertLogNum = "6255";
    if(strCate.equals("082203")) insertLogNum = "6256";
    if(strCate.equals("082204")) insertLogNum = "6257";
    if(strCate.equals("082205")) insertLogNum = "6258";
    if(strCate.equals("082206")) insertLogNum = "6259";
    if(strCate.equals("082207")) insertLogNum = "6260";
    if(strCate.equals("082208")) insertLogNum = "6261";
    if(strCate.equals("082209")) insertLogNum = "6262";
    if(strCate.equals("0689")) insertLogNum = "6437";
    if(strCate.equals("1509")) insertLogNum = "6877";
    if(strCate.equals("051516")) insertLogNum = "6911";
    if(strCate.equals("1821")) insertLogNum = "8662";
    if(strCate.equals("1820")) insertLogNum = "8661";
    if(strCate.equals("1578")) insertLogNum = "8647";
    if(strCate.equals("1580")) insertLogNum = "8645";
    if(strCate.equals("1579")) insertLogNum = "8644";
    if(strCate.equals("1592")) insertLogNum = "8643";
    if(strCate.equals("1581")) insertLogNum = "8642";
    if(strCate.equals("1591")) insertLogNum = "8641";
    
    if(strCate.equals("120503")) insertLogNum = "8087";
    if(strCate.equals("120215")) insertLogNum = "8752";
    if(strCate.equals("9419")) insertLogNum = "5835";
    if(strCate.equals("1222")) insertLogNum = "5834";
    if(strCate.equals("0902")) insertLogNum = "6490";
    if(strCate.equals("0923")) insertLogNum = "6491";
    if(strCate.equals("0334")) insertLogNum = "6695";
    if(strCate.equals("0876")) insertLogNum = "6764";
    if(strCate.equals("0877")) insertLogNum = "6765";
    if(strCate.equals("0823")) insertLogNum = "6766";
        
    if(strCate.equals("0991")) insertLogNum = "6697";
    if(strCate.equals("0992")) insertLogNum = "6698";
    if(strCate.equals("0993")) insertLogNum = "6699";
    if(strCate.equals("0994")) insertLogNum = "6700";
    if(strCate.equals("0995")) insertLogNum = "6701";
    if(strCate.equals("1577")) insertLogNum = "8691";
    if(strCate.equals("1576")) insertLogNum = "8690";
    if(strCate.equals("1575")) insertLogNum = "8689";
    if(strCate.equals("1574")) insertLogNum = "8688";
    if(strCate.equals("145408")) insertLogNum = "8692";
    if(strCate.equals("1891")) insertLogNum = "8731";
    if(strCate.equals("1892")) insertLogNum = "8730";
    if(strCate.equals("1893")) insertLogNum = "8729";
    if(strCate.equals("1628")) insertLogNum = "8732";
    if(strCate.equals("2119")) insertLogNum = "5500";
    if(strCate.equals("2122")) insertLogNum = "9180";
    if(strCate.equals("2108")) insertLogNum = "9179";
    if(strCate.equals("2127")) insertLogNum = "9178";
    if(strCate.equals("2126")) insertLogNum = "9177";
    if(strCate.equals("2125")) insertLogNum = "9176";
    if(strCate.equals("2124")) insertLogNum = "9175";
    if(strCate.equals("2123")) insertLogNum = "9174";
    
    if(strCate.equals("1809")) insertLogNum = "6565";
    if(strCate.equals("1810")) insertLogNum = "6566";
    if(strCate.equals("1811")) insertLogNum = "6567";
    if(strCate.equals("0688")) insertLogNum = "6584";
    if(strCate.equals("0693")) insertLogNum = "6585";
    if(strCate.equals("1474")) insertLogNum = "6642";
    if(strCate.equals("1475")) insertLogNum = "6643";
    if(strCate.equals("1476")) insertLogNum = "6644";
    if(strCate.equals("1477")) insertLogNum = "6645";
    if(strCate.equals("9750")) insertLogNum = "6658";
    if(strCate.equals("1482")) insertLogNum = "6660";
    if(strCate.equals("1483")) insertLogNum = "6661";
    if(strCate.equals("1484")) insertLogNum = "6662";
    if(strCate.equals("1485")) insertLogNum = "6663";
    if(strCate.equals("1693")) insertLogNum = "6681"; 
    if(strCate.equals("1598")) insertLogNum = "6679";
    if(strCate.equals("1498")) insertLogNum = "6678";
    if(strCate.equals("9751")) insertLogNum = "6738";
    //if(strCate.equals("2198")) insertLogNum = "6767";
    if(strCate.equals("8901")) insertLogNum = "6836";
    if(strCate.equals("8902")) insertLogNum = "6837";
    if(strCate.equals("8903")) insertLogNum = "6838";
    if(strCate.equals("8904")) insertLogNum = "6839";
    if(strCate.equals("8905")) insertLogNum = "6840";
    if(strCate.equals("8906")) insertLogNum = "6841";
    if(strCate.equals("8907")) insertLogNum = "6842";
    if(strCate.equals("8908")) insertLogNum = "6843";
    if(strCate.equals("8909")) insertLogNum = "6844";
    if(strCate.equals("0516")) insertLogNum = "6845";
    if(strCate.equals("1636")) insertLogNum = "6846";
    if(strCate.equals("0904")) insertLogNum = "6847";
    if(strCate.equals("0929")) insertLogNum = "6848";
    if(strCate.equals("1501")) insertLogNum = "6849";
    if(strCate.equals("1506")) insertLogNum = "7899";
    if(strCate.equals("1590")) insertLogNum = "7900";
    if(strCate.equals("102406")) insertLogNum = "8663";

    if(strCate.equals("034010") || strCate.equals("975702")) insertLogNum = "7399";  
    if(strCate.equals("034110") || strCate.equals("975701")) insertLogNum = "7398";  
    if(strCate.equals("034315") || strCate.equals("038005")) insertLogNum = "7396";  
    if(strCate.equals("033912") || strCate.equals("038004")) insertLogNum = "7395";   
    if(strCate.equals("033812") || strCate.equals("038007")) insertLogNum = "7394";   
    if(strCate.equals("033712")) insertLogNum = "7393";  
    if(strCate.equals("0335") || strCate.equals("9757")) insertLogNum = "7392";  
    if(strCate.equals("0313") || strCate.equals("9756")) insertLogNum = "7391";  
    if(strCate.equals("0313") || strCate.equals("9756")) insertLogNum = "7391";  
    if(strCate.equals("034409") || strCate.equals("037905")) insertLogNum = "7729";  
    if(strCate.equals("038008")) insertLogNum = "7397";
    if(strCate.equals("037907")) insertLogNum = "7400";
     
    if(strCate.equals("1587")) insertLogNum = "8983";
    if(strCate.equals("0515")) insertLogNum = "6737";
    if(strCate.equals("0510")) insertLogNum = "6736";
    if(strCate.equals("0521")) insertLogNum = "6735";   
    if(strCate.equals("1224")) insertLogNum = "6768";   
    if(strCate.equals("0419")) insertLogNum = "6778";   
    if(strCate.equals("9760")) insertLogNum = "7090";    
    if(strCate.equals("9761")) insertLogNum = "7089"; 
    if(strCate.equals("975724")) insertLogNum = "7582"; 
    if(strCate.equals("038006")) insertLogNum = "8599";
    if(strCate.equals("038003")) insertLogNum = "8042";
    if(strCate.equals("030434")) insertLogNum = "7090";
    if(strCate.equals("030522")) insertLogNum = "7089";
    if(strCate.equals("1697")) insertLogNum = "8640";  
    if(strCate.equals("2196")) insertLogNum = "7853";
    if( strCate.substring(0,4).equals("2197") ){
        insertLogNum = "7342"; 
    }
     
    if(strCate.length()==4) goLinkStr = "insertLog(130);"+goLinkStr;
    if(strCate.length()==6) goLinkStr = "insertLog(129);"+goLinkStr;
    if(strCate.equals("2111")) goLinkStr = "Cmd_AutoVisit();"+goLinkStr;
    if(insertLogNum.length()>0) goLinkStr = "insertLog("+insertLogNum+");"+goLinkStr;
    
    //if(strCate.equals("1017")) goLinkStr = "insertLog(3772);"+goLinkStr;
    //if(strCate.equals("1017")) { 
        //goLinkStr = "insertLog(3772);booklayerShow();";
    //}
    if(strCate.equals("2110")) goLinkStr = "insertLog(4168);"+goLinkStr;
    if(strCate.equals("0527")) goLinkStr = "insertLog(5615);"+goLinkStr;
    if(strCate.substring(0,2).equals("04")||strCate.substring(0,2).equals("07")) {
       goLinkStr = "insertLogCate(10408,'"+strCate+"');"+goLinkStr;
    }
    if(strCate.substring(0,2).equals("12")||strCate.substring(0,2).equals("18")) {
       goLinkStr = "insertLogCate(10409,'"+strCate+"');"+goLinkStr;
    }
    if(strCate.substring(0,2).equals("03") ||strCate.substring(0,2).equals("22")) {
       goLinkStr = "insertLogCate(10415,'"+strCate+"');"+goLinkStr;
    }
    if(strCate.substring(0,2).equals("02")||strCate.substring(0,2).equals("05")||strCate.substring(0,2).equals("06")) {
       goLinkStr = "insertLogCate(10416,'"+strCate+"');"+goLinkStr;
    }
    if(strCate.substring(0,2).equals("09")) {
       goLinkStr = "insertLogCate(10417,'"+strCate+"');"+goLinkStr;
    }
    if(strCate.substring(0,2).equals("21")) {
       goLinkStr = "insertLogCate(10418,'"+strCate+"');"+goLinkStr;
    }
    if(strCate.substring(0,2).equals("10")) {
       goLinkStr = "insertLogCate(10419,'"+strCate+"');"+goLinkStr;
    }
    if(strCate.substring(0,2).equals("16")) {
       goLinkStr = "insertLogCate(10420,'"+strCate+"');"+goLinkStr;
    }
    if(strCate.substring(0,2).equals("14")) {
       goLinkStr = "insertLogCate(10421,'"+strCate+"');"+goLinkStr;
    }
    if(strCate.substring(0,2).equals("08")) {
       goLinkStr = "insertLogCate(10422,'"+strCate+"');"+goLinkStr;
    }
    if(strCate.substring(0,2).equals("15")) {
       goLinkStr = "insertLogCate(10423,'"+strCate+"');"+goLinkStr;
    }

    
    return goLinkStr;
} 
public HashMap getEtcCateHash(){
        HashMap etcCateHash = new HashMap();
        String etcComma = "<font style=font-size:8pt>..</font>"; //말줄임표는 8pt 
        String etcComma2 = ".."; //말줄임표는 8pt
        String etcBlank1 = "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/blank.gif' width='6px' height='1px' align='absmiddle'>"; 
        String etcBlank2 = "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/blank.gif' width='10px' height='5px' align='absmiddle'>";
        String etcBlank3 = "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/blank.gif' width='10px' height='5px' align='absmiddle'>";
        
        etcCateHash.put("022107", "렌즈,후드"+etcComma2);
        etcCateHash.put("022205", "삼성");
        etcCateHash.put("022110", "촬영용품");
        etcCateHash.put("211723", "스마트컨슈머 우수");
        etcCateHash.put("022119", "기타");
        etcCateHash.put("022120", "성능별 선택");
        etcCateHash.put("020915", "방수디카,방수케이스");
        etcCateHash.put("020109", "동영상,홈네트워크"+etcComma2);
        etcCateHash.put("020917", "콤팩트 하이엔드");
        etcCateHash.put("040711", "케이블형");
        etcCateHash.put("022201", "화각별");
        etcCateHash.put("068006", "인치별");
        etcCateHash.put("022204", "소니");
        etcCateHash.put("021413", "촬영보조");
        etcCateHash.put("021112", "프로젝터 대여");
        etcCateHash.put("020701", "필름카메라");
        etcCateHash.put("023103", "반사판");
        etcCateHash.put("220203", "반사판");
        etcCateHash.put("020615", "방수,3D촬영");
        etcCateHash.put("020931", "방수,셀카"+etcComma2);
        //etcCateHash.put("020931", "<star1>기능별<star2><br>"+etcBlank1+"(3D,방수"+etcComma+")"+etcBlank1);
        etcCateHash.put("020622", "<star1>프로젝터<star2><br>내장"+etcBlank1);
        etcCateHash.put("023101", "촬영세트");
        etcCateHash.put("220201", "촬영세트");
        etcCateHash.put("022113", "미러리스");
        etcCateHash.put("022212", "미러리스용"); 
        etcCateHash.put("022114", "브랜드별(캐논,니콘,소니"+etcComma2+")");
        etcCateHash.put("181707", "<star1>액세서리<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(렌즈,어댑터,기타)</font>"+etcBlank1);    
        etcCateHash.put("164607", "<star1>액세서리<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(렌즈,어댑터,기타)</font>"+etcBlank1);        
        etcCateHash.put("021319", "블루레이");
        etcCateHash.put("036014", "<star1>인기제조사<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(소니,애플,젠하이저"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("040113", "<star1>인기브랜드<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(삼성,LG,HP,TG삼보)</font>"+etcBlank1);
        etcCateHash.put("042013", "<star1><ingi1>인기브랜드<ingi2><star2><br>"+etcBlank1+"<font style=font-size:8pt;>(삼성,LG,레노버,애플)</font>"+etcBlank1);
        etcCateHash.put("021713", "<star1>기능별<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(골전도,밸런스드아마추어"+etcComma2+")</font>"+etcBlank1); 
        etcCateHash.put("021235", "아이리버,코원");
        etcCateHash.put("021236", "소니,아이스테이션,빌립");  
        etcCateHash.put("022213", "애칭,용도별");
        etcCateHash.put("022209", "후드,용품");
        etcCateHash.put("020325", "추천 코너(학습,인테리어 등)");
        etcCateHash.put("023105", "테이블,기타");
        etcCateHash.put("020605", "고화질(Full-HD)");
        etcCateHash.put("020604", "스마트");
        etcCateHash.put("021246", "기타(코원,소니..)");   
        etcCateHash.put("020116", "스마트TV");
        etcCateHash.put("020121", "<font style=font-size:8pt>인터넷,Wi-Di,무선랜</font>");
        etcCateHash.put("021326", "대여순위 TOP10");
        etcCateHash.put("038003", "갤럭시 S3 용");
        etcCateHash.put("038005", "갤럭시 노트 용");
        etcCateHash.put("038006", "아이폰 5,5S,5C 용");
        etcCateHash.put("038007", "아이폰 4,4S 용");
        etcCateHash.put("038004", "갤럭시 노트2 용");
        etcCateHash.put("038022", "<new1>갤럭시 노트3 용<new2>");
        etcCateHash.put("037904", "아이패드 미니 용");
        etcCateHash.put("037905", "아이패드 2,3,4세대 공용");
        etcCateHash.put("037903", "갤럭시 노트 10.1 용");
        etcCateHash.put("037906", "넥서스7 2세대 용");
        etcCateHash.put("0200612", "후드,렌즈캡,어댑터"+etcComma2);
        etcCateHash.put("181302", "키보드,일반피아노,페달"+etcComma2);
        etcCateHash.put("164302", "키보드,일반피아노,페달"+etcComma2);
        etcCateHash.put("181301", "어쿠스틱,일렉트릭,기타줄"+etcComma2);
        etcCateHash.put("164301", "어쿠스틱,일렉트릭,기타줄"+etcComma2);
        etcCateHash.put("021903", "케이블연결");
        etcCateHash.put("021909", "케이블연결");     
        etcCateHash.put("040121", "일반");        
        etcCateHash.put("040123", "TV겸용");      
        
        etcCateHash.put("092010", "아이스박스,쿨러백");
        etcCateHash.put("092011", "손난로,핫팩");
        etcCateHash.put("059813", "손난로,핫팩");
        etcCateHash.put("034506", "화면(3.5\\\",4.3\\\""+etcComma+")");
        etcCateHash.put("034513", "멀티미디어(동영상,WiFi,DMB"+etcComma+")");
        etcCateHash.put("180106", "연필깎이,가위"+etcComma);
        //etcCateHash.put("120810", "침대커버,요,이불,베개"+etcComma);
        etcCateHash.put("180123", "모니터클립,클리너"+etcComma);
        etcCateHash.put("182212", "볼펜심,만년필 잉크"+etcComma);
        etcCateHash.put("080220", "코팩,아이패치"+etcComma2);
        etcCateHash.put("180117", "레이저포인터,서류함"+etcComma2);
        etcCateHash.put("180802", "내화,방도,철제금고");
        etcCateHash.put("180803", "수제금고,내화캐비닛"+etcComma);
        etcCateHash.put("180810", "실물화상기,타자기"+etcComma);
        etcCateHash.put("030422", "부가기능<br>"+etcBlank1+"<font style=font-size:8pt>(AM OLED,DivX 재생"+etcComma+")</font>");
        etcCateHash.put("030421", "화제의폰<br>"+etcBlank1+"<font style=font-size:8pt>(아이폰,갤럭시,아트릭스)</font>");
        etcCateHash.put("069207", "단어학습기,디지털어학기"+etcComma);
        etcCateHash.put("031313", "카메라기능용,TV수신,<br>"+etcBlank1+"수화기,휴대폰줄"+etcComma);
        etcCateHash.put("030423", "Bar형,폴더형,슬라이드"+etcComma);
        etcCateHash.put("031806", "차량용,사무용,기타");
        etcCateHash.put("180208", "지구본,저금통,소품함"+etcComma); 
        etcCateHash.put("180204", "2013년 캘린더,다이어리");
        etcCateHash.put("180206", "네임스티커,스탬프");
        etcCateHash.put("180219", "2012년 캘린더,다이어리");
        etcCateHash.put("031310", "차량용<br>"+etcBlank1+"<font style=font-size:8pt>(거치대,충전기,핸드프리)</font>");
        etcCateHash.put("031914", "스마트패드<br>"+etcBlank1+"<font style=font-size:8pt>(갤럭시탭,아이패드"+etcComma+")</font>");
        etcCateHash.put("052701", "유선");
        etcCateHash.put("052703", "무선");
        etcCateHash.put("080601", "바디클렌저,비누");
        etcCateHash.put("080617", "바디크림,오일");
        etcCateHash.put("052714", "유무선,무무선");
        etcCateHash.put("052702", "키폰,핸즈프리"+etcComma);
        etcCateHash.put("211720", "신기술,하이패스겸용"+etcComma);
        etcCateHash.put("052705", "인테리어(캐릭터,클래식)");
        etcCateHash.put("052710", "생활용");
        etcCateHash.put("052709", "액세서리"+etcBlank2+"<br><font style=font-size:8pt>(배터리,충전기"+etcComma+")</font>");
        etcCateHash.put("052715", "배터리,헤드셋");
        etcCateHash.put("180303", "인기브랜드"+etcBlank2+"<br>"+"(더블에이,밀크,한솔)");
        etcCateHash.put("080722", "인기브랜드"+etcBlank2+"<br><font style=font-size:8pt>"+etcBlank2+"(케라시스,팬틴"+etcComma+")</font>");
        etcCateHash.put("051521", "혈당지,소모품");
        etcCateHash.put("030505", "<star1>운영체제별<star2><br>"+etcBlank1+"<font style=font-size:8pt>(iOS,안드로이드,윈도"+etcComma+")</font>"+etcBlank1);
        etcCateHash.put("181918", "패스트푸드,편의점");
        etcCateHash.put("181915", "백화점,구두,마트");
        etcCateHash.put("071214", "저장방식(SLC,MLC)");
        etcCateHash.put("164715", "백화점,구두,마트");
        etcCateHash.put("080225", "재질,기능별"+etcBlank2+"<br>"+"<font style=font-size:8pt>(하이드로겔,순면"+etcComma2+")</font>"+etcBlank1);     
        etcCateHash.put("080230", "인기브랜드"+etcBlank2+"<br>"+"<font style=font-size:8pt>(하유미,이니스프리"+etcComma2+")</font>"+etcBlank1);       
        
        etcCateHash.put("181919", "커피,디저트,베이커리");
        etcCateHash.put("164719", "커피,디저트,베이커리");
        etcCateHash.put("034521", "액세서리"+etcBlank2+"<br><font style=font-size:8pt>"+etcBlank1+"(필름,케이스,기타"+etcComma+")</font>");
        etcCateHash.put("181214", "위생,생활용품"+etcBlank2+"<br>"+"<font style=font-size:8pt>(배변판,샴푸,린스,집"+etcComma2+")</font>"+etcBlank1);  
        etcCateHash.put("164214", "위생,생활용품"+etcBlank2+"<br>"+"<font style=font-size:8pt>(배변판,샴푸,린스,집"+etcComma2+")</font>");        
        etcCateHash.put("181215", "패션,놀이"+etcBlank2+"<br>"+"<font style=font-size:8pt>(의류,목줄,훈련용품"+etcComma2+")</font>"+etcBlank1); 
        etcCateHash.put("164215", "패션,놀이"+etcBlank2+"<br>"+"<font style=font-size:8pt>(의류,목줄,훈련용품"+etcComma2+")</font>");   
        etcCateHash.put("181217", "위생,생활용품"+etcBlank2+"<br>"+"<font style=font-size:8pt>(배변용모래,식기,철장"+etcComma2+")</font>"+etcBlank1);  
        etcCateHash.put("164217", "위생,생활용품"+etcBlank2+"<br>"+"<font style=font-size:8pt>(배변용모래,식기,철장"+etcComma2+")</font>");    
        etcCateHash.put("181218", "놀이,기타"+etcBlank2+"<br>"+"<font style=font-size:8pt>(캣타워,스크래처,가슴줄"+etcComma2+")</font>"+etcBlank1);   
        etcCateHash.put("164218", "놀이,기타"+etcBlank2+"<br>"+"<font style=font-size:8pt>(캣타워,스크래처,가슴줄"+etcComma2+")</font>"); 
        etcCateHash.put("181307", "교본,소품"+etcBlank2+"<br><font style=font-size:8pt>"+etcBlank1+"(보면대,메트로놈"+etcComma+")</font>");
        etcCateHash.put("164307", "교본,소품"+etcBlank2+"<br><font style=font-size:8pt>"+etcBlank1+"(보면대,메트로놈"+etcComma+")</font>");
    
        etcCateHash.put("180304", "포토용지,인화지");
        etcCateHash.put("093106", "텐트펙,텐트폴,로프"+etcComma2); 
        etcCateHash.put("070903", "유무선공유기");
        etcCateHash.put("070906", "무선(AP),유선공유기");
        etcCateHash.put("041005", "보호필름");
        etcCateHash.put("040419", "13인치");
        etcCateHash.put("040418", "~12인치");
        etcCateHash.put("040515", "광시야각,미니,터치"+etcComma);
        etcCateHash.put("041010", "무선모뎀<br>"+etcBlank1+"<font style=font-size:8pt>(와이브로,HSDPA)</font>");
        etcCateHash.put("040428", "하스웰CPU,윈도8");
        etcCateHash.put("040433", "애플 맥북");
        etcCateHash.put("093203", "전선릴,휴대전원");
        etcCateHash.put("093209", "손난로,핫팩");
        etcCateHash.put("093207", "프로젝터,스크린,라디오"+etcComma);
        etcCateHash.put("093206", "모기향,살충제"+etcComma);
        etcCateHash.put("093205", "전선릴,구급함"+etcComma);
        etcCateHash.put("982102", "<star1>인기시리즈<star2><br>"+etcBlank1+"<font style=font-size:8pt>(아이패드,갤럭시탭"+etcComma+")</font>"+etcBlank1);
        etcCateHash.put("040508", "~19\\\"");
        etcCateHash.put("040512", "일반");
        etcCateHash.put("040504", "TV겸용");
        etcCateHash.put("040510", "일반");
        etcCateHash.put("040503", "TV겸용");
        etcCateHash.put("040509", "일반");
        etcCateHash.put("040501", "TV겸용");
        etcCateHash.put("040805", "주변기기,기타");
        etcCateHash.put("982105", etcBlank1+"8\\\"~");
        etcCateHash.put("982104", "~7\\\"");
        etcCateHash.put("040412", "저가형 노트북");
        etcCateHash.put("040820", "닌텐도 3DS");
        etcCateHash.put("030446", "공기계,해외쇼핑");
        etcCateHash.put("040202", "포토프린터,기타"+etcBlank2+"<br>"+etcBlank1+"(라벨,바코드,플로터"+etcComma+")");
        etcCateHash.put("040517", "<star1>주변기기<star2><br>"+etcBlank1+"(브라켓,암,어댑터"+etcComma+")"+etcBlank1);
        etcCateHash.put("040519", "초고해상도,멀티터치"+etcComma);
        etcCateHash.put("219808", "스노우체인,타이어");
        etcCateHash.put("040219", "스마트,3D프린터"+etcComma);
        etcCateHash.put("022220", "기타");
        etcCateHash.put("022216", "기타");
        etcCateHash.put("022201", "화각,용도별");
        
                        
        etcCateHash.put("051609", "전기장판,전기요");
        etcCateHash.put("050109", "<star1>인기브랜드<star2><br>"+etcBlank1+"<font style=font-size:8pt>(휘센,하우젠,위니아"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("050212", "인기브랜드<font style=font-size:8pt>(트롬,삼성,클라쎄)</font>");
        etcCateHash.put("050306", "물걸레청소기,먼지떨이"+etcComma);
        //etcCateHash.put("050216", "세탁세제,호스,거름망"+etcComma);
        etcCateHash.put("050303", "스팀패드,먼지봉투"+etcComma);
        etcCateHash.put("051110", "<star1>인기브랜드<star2><br>"+etcBlank1+"<font style=font-size:8pt>(필립스,브라운"+etcComma2+")</font>"+etcBlank2);
        etcCateHash.put("051404", "구강세정,칫솔살균기"+etcComma);
        etcCateHash.put("051002", "핸디형 안마기"); 
        etcCateHash.put("051017", "쿠션형 안마기");
        etcCateHash.put("051004", "발,다리 안마기");
        etcCateHash.put("051018", "공기압 안마기");
        etcCateHash.put("052608", "칫솔걸이,양치컵"+etcComma);
        etcCateHash.put("051308", "인기브랜드"+etcBlank2+"<br>"+"<font style=font-size:8pt>(게이트맨,이지온"+etcComma2+")</font>");
        etcCateHash.put("051313", "기능별"+etcBlank2+"<br><font style=font-size:8pt;>(보안,안전기능"+etcComma2+")</font>");
        etcCateHash.put("051303", "유리문,샷시용"); 
        etcCateHash.put("051311", "DVR, CCTV 렌즈"+etcComma);
        etcCateHash.put("051314", "형태별"+etcBlank2+"<br>"+"<font style=font-size:8pt>(주키,보조키"+etcComma2+")</font>");
        etcCateHash.put("052107", "치아미백,페이스롤러"); 
        etcCateHash.put("051510", "신종플루예방"); 
        etcCateHash.put("050309", "로봇(방식별,기능별,사용시간"+etcComma2+" )");
        etcCateHash.put("051112", "3헤드~");
        etcCateHash.put("051611", "인기브랜드"+etcBlank2+"<br>"+"<font style=font-size:8pt>(일월,구들장,한일"+etcComma2+")</font>");
        etcCateHash.put("050313", "인기브랜드(LG,삼성"+etcComma2+")");
        etcCateHash.put("050314", "흡입력별"); 
        etcCateHash.put("051410", "인기제조사"+etcBlank2+"<br>"+"(노비타,동양매직"+etcComma2+")");
        etcCateHash.put("051910", "기능별<br><font style=font-size:8pt>(상부급수,분무구"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("050415", "벽걸이형,부착형"+etcComma);
        etcCateHash.put("050417", "손난로,핫팩"+etcComma);
        etcCateHash.put("050805", "<star1>인기브랜드<star2><br>"+"<font style=font-size:8pt>(유닉스,필립스"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("181308", "<star1>교재용악기<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(멜로디언,리코더"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("164308", "<star1>교재용악기<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(멜로디언,리코더"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("051913", "<star1>인기제조사<star2><br>"+"<font style=font-size:8pt>(리홈,한일,삼성"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("050709", "<star1>인기브랜드<star2><br>"+etcBlank1+"<font style=font-size:8pt>(테팔,필립스"+etcComma2+")</font>"+etcBlank2);
        etcCateHash.put("050603", "인기브랜드"+etcBlank2+"<br>"+"<font style=font-size:8pt>(LG,삼성,위니아"+etcComma2+")</font>");
        etcCateHash.put("050215", "의류 관리기");
        etcCateHash.put("050710", "스타일러"+etcBlank2+"<br>(의류 관리기)");
        //etcCateHash.put("050211", "기능별(스팀,Air세탁,알레르기"+etcComma2+")");
        etcCateHash.put("050219", "인기브랜드(삼성,LG,대우)");
        etcCateHash.put("051916", "인기브랜드"+etcBlank2+"<br><blank1>(LG,위닉스,삼성)");
        etcCateHash.put("050512", "인기브랜드"+etcBlank2+"<br><font style=font-size:8pt;>(한일,신일산업,보국"+etcComma2+")</font>");
        //etcCateHash.put("051105", "여성제모기");
        etcCateHash.put("051106", "코털,수염정리기");
        etcCateHash.put("051615", "2014년형");
        
        etcCateHash.put("050116", "<star1>액세서리<star2><br>"+etcBlank1+"<font style=font-size:8pt>(리모컨,필터"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("050513", "<star1>액세서리<star2><br>"+etcBlank1+"<font style=font-size:8pt>(날개,커버,배터리"+etcComma2+")</font>"+etcBlank1);    
        etcCateHash.put("050508", "<star1>휴대용 선풍기<star2><br>"+etcBlank1+"<font style=font-size:8pt>(USB,차량용"+etcComma2+")</font>"+etcBlank1);       
        etcCateHash.put("050605", "<star1>액세서리<star2><br>"+etcBlank1+"<font style=font-size:8pt>(필터,리모컨"+etcComma2+")</font>"+etcBlank1);   
        etcCateHash.put("181310", "<star1>대여악기<star2><br>"+etcBlank1+"<font style=font-size:8pt>(현악기,관악기)</font>"+etcBlank1);
        etcCateHash.put("051205", "<star1>액세서리<star2><br><font style=font-size:8pt>(노루발,바늘"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("093103", "알파인용"+etcBlank2+"<br>"+"(솔캠,백패킹)");
        etcCateHash.put("093102", "오토캠핑용"+etcBlank2+"<br>"+"(가족여행)");
        etcCateHash.put("093210", "루프백,루프박스,캠핑카"+etcComma);
        etcCateHash.put("093104", "기능별"+etcBlank2+"<br>"+"(팝업,난방텐트"+etcComma2+")");
        //etcCateHash.put("122518", "인기브랜드"+etcBlank2+"<br>"+"(다이아소닉,필립스,3M)");
        etcCateHash.put("051207", "<star1>인기브랜드<star2><br><font style=font-size:8pt>(부라더,엘나,싱거)</font>"+etcBlank1);
        etcCateHash.put("051301", "도난경보기,차임벨");
        etcCateHash.put("051304", "탐지기,미아방지기");
        etcCateHash.put("051614", "손난로,발난로"+etcComma);
        etcCateHash.put("059806", "손난로,발난로"+etcComma);
        etcCateHash.put("051113", "면도날,쉐이빙,면도크림"); 
        etcCateHash.put("052601", "음파식");
        etcCateHash.put("090521", "가성비↑");
        etcCateHash.put("051302", "방식별"+etcBlank2+"<br>"+"<font style=font-size:8pt>(터치,버튼"+etcComma2+")</font>");
        etcCateHash.put("051503", "<star1>물리치료기<star2><br>"+etcBlank1+"<font style=font-size:8pt>(저주파,적외선"+etcComma2+")</font>"+etcBlank2);
        etcCateHash.put("051519", "<star1>인기브랜드"+etcBlank2+"<star2><br>"+"<font style=font-size:8pt>(아큐첵,오므론,브라운"+etcComma2+")</font>");
        //etcCateHash.put("050310", "기능별(스마트,자동충전"+etcComma2+")");
        etcCateHash.put("051316", "<star1>호신용품<star2><br>"+etcBlank1+"<font style=font-size:8pt>(스프레이,호신봉"+etcComma2+")</font>"+etcBlank2);
        //etcCateHash.put("051919", "<star1>인테리어<star2><br>"+etcBlank1+"<font style=font-size:8pt>(캐릭터,실내분수"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("050714", "액세서리"+etcBlank2+"<br><font style=font-size:8pt;>(노루발,바늘"+etcComma2+")</font>");
        etcCateHash.put("051907", "<star1>소모품<star2><br>"+etcBlank1+"<font style=font-size:8pt>(필터,첨가제)</font>"+etcBlank1);
        etcCateHash.put("053005", "<star1>인기제조사<star2><br>"+etcBlank1+"<font style=font-size:8pt>(LG,삼성,위닉스"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("053010", "<star1>액세서리<star2><br>"+etcBlank1+"<font style=font-size:8pt>(필터,Y호스"+etcComma2+")</font>"+etcBlank1);
        
        etcCateHash.put("082607", "인기브랜드"+etcBlank2+"<br><font style=font-size:8pt>(OPI,아리따움"+etcComma2+")</font>");
        etcCateHash.put("083408", "미스트,수분크림"+etcComma);
        etcCateHash.put("080911", "인기브랜드"+etcBlank2+"<br>"+etcBlank1+"<font style=font-size:8pt;>(비오템옴므,보닌"+etcComma2+")</font>");
        etcCateHash.put("080311", "세트,소품(브러쉬,퍼프)");
        etcCateHash.put("081208", "인기브랜드"+etcBlank2+"<br>"+etcBlank1+"<font style=font-size:8pt>(캘리포니아베이비,버츠비"+etcComma2+")</font>");
        etcCateHash.put("030450", "기능별"+etcBlank2+"<br>"+etcBlank1+"<font style=font-size:8pt>(광대역 LTE-A, QHD 화면"+etcComma2+")</font>");
        etcCateHash.put("091814", "인기브랜드"+etcBlank2+"<br>"+etcBlank1+"<font style=font-size:8pt>(혼다,야마하,대림자동차"+etcComma2+")</font>");
        etcCateHash.put("213102", "인기브랜드"+etcBlank2+"<br>"+etcBlank1+"<font style=font-size:8pt>(GS칼텍스,모빌,불스원"+etcComma2+")</font>");
        etcCateHash.put("213113", "탈취,세정"+etcBlank2+"<br>"+etcBlank1+"<font style=font-size:8pt>(실내용,에바클리너"+etcComma2+")</font>");
        etcCateHash.put("213108", "미션오일,기타"+etcBlank2+"<br>"+etcBlank1+"<font style=font-size:8pt>(브레이크액,파워스티어링"+etcComma2+")</font>");
        etcCateHash.put("031817", "인기브랜드 "+etcBlank2+"<br>"+etcBlank1+"<font style=font-size:8pt>(LG,소니,자브라"+etcComma2+")</font>");
        etcCateHash.put("210818", "인기브랜드"+etcBlank2+"<br>"+etcBlank1+"<font style=font-size:8pt>(불스원,소낙스,훠링"+etcComma2+")</font>");
        etcCateHash.put("210820", "유리관리"+etcBlank2+"<br>"+etcBlank1+"<font style=font-size:8pt>(발수코팅,김서림방지"+etcComma2+")</font>");
        etcCateHash.put("210810", "흠집제거"+etcBlank2+"<br>"+etcBlank1+"<font style=font-size:8pt>(컴파운드,도색"+etcComma2+")</font>");
        etcCateHash.put("091815", "바이크용품"+etcBlank2+"<br>"+etcBlank1+"<font style=font-size:8pt>(내비,엔진오일,튜닝용품"+etcComma2+")</font>");
        etcCateHash.put("091805", "바이크부품"+etcBlank2+"<br>"+etcBlank1+"<font style=font-size:8pt>(배터리,구동장치,제동장치"+etcComma2+")</font>");
        etcCateHash.put("081304", "가위,브러쉬,미용재료"+etcComma);
        etcCateHash.put("081308", "타투,타월,면도기");
        etcCateHash.put("080608", "인기브랜드"+etcBlank2+"<br><font style=font-size:8pt>(세타필,더바디샵"+etcComma2+")</font>");
        etcCateHash.put("090503", "생활용");
        etcCateHash.put("103005", "물총,비눗방울");
        
        etcCateHash.put("220805", "MS,기타");
        etcCateHash.put("034205", "MS,기타");                   
        etcCateHash.put("060102", "인기브랜드<br>"+etcBlank1+"<font style=font-size:8pt>(쿠쿠,쿠첸,리홈)</font>");
        etcCateHash.put("060203", "3도어,4도어");
        etcCateHash.put("060208", "인기브랜드<br>"+"<font style=font-size:8pt>(디오스,지펠,클라쎄"+etcComma2+")</font>");
        etcCateHash.put("060207", "제빙기,와인"+etcComma2); 
        etcCateHash.put("062102", "복합,스팀형(광파,스팀"+etcComma+")");
        etcCateHash.put("060605", "우유거품기,여과지"+etcComma);
        etcCateHash.put("061108", "탄산수,팝콘제조기"+etcComma);
        etcCateHash.put("062009", "인기브랜드<br>"+"<font style=font-size:8pt>(루펜,비움,애플,클리베)</font>");
        etcCateHash.put("060615", "휘핑기,템퍼"+etcComma);
        etcCateHash.put("060818", "에어프라이어");
        //etcCateHash.put("060621", "캡슐커피 머신<br>"+"(네스프레소,돌체구스토"+etcComma+")");
        etcCateHash.put("060621", "캡슐커피머신");
        etcCateHash.put("060617", "캡슐커피");
        etcCateHash.put("062115", "인기브랜드<br>"+"<font style=font-size:8pt>(광파오븐,스마트오븐,매직스팀)</font>");
        etcCateHash.put("060112", "압력패킹,내솥");
        etcCateHash.put("062116", "광파오븐");
        etcCateHash.put("062117", "스마트오븐");
        etcCateHash.put("062118", "매직스팀오븐");
        etcCateHash.put("060615", "휘핑기,템퍼"+etcComma);
        etcCateHash.put("060407", "인기브랜드<br>"+etcBlank1+"<font style=font-size:8pt;>(삼성,LG,대우"+etcComma2+")</font>");
        etcCateHash.put("061017", "<star1>부속품<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(호스,밸브,코크"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("060619", "인기브랜드<br>"+"(네스프레소,돌체구스토"+etcComma2+")");
        etcCateHash.put("060408", "액세서리<br>"+etcBlank1+"<font style=font-size:8pt;>(조리용기,부속품)</font>");
        //etcCateHash.put("062119", "인기브랜드<br>"+"<font style=font-size:8pt;>(LG,삼성,대우)</font>");
        etcCateHash.put("062122", "조리용기,제빵용품,주방저울");
        etcCateHash.put("061101", "두부,영양식"+etcComma); 
        etcCateHash.put("061109", "요구르트"); 
            
        etcCateHash.put("060204", "2도어");
        etcCateHash.put("060310", "인기브랜드");
        etcCateHash.put("034504", "필름,케이스,충전기"+etcComma2+"");
        etcCateHash.put("034510", "필름,케이스,조명"+etcComma2+"");
        etcCateHash.put("181920", "숙박,여행(리조트,호텔"+etcComma2+")");
        etcCateHash.put("164720", "숙박,여행(리조트,호텔"+etcComma2+")");
                        
        etcCateHash.put("162401", "용도(일반,전골"+etcComma+")");
        etcCateHash.put("162412", "재질,형태(스텐,양수"+etcComma+")");
        etcCateHash.put("162403", "후라이팬,멀티팬,양면팬"+etcComma+"");
        etcCateHash.put("162408", "인기브랜드(테팔,키친아트)");
        etcCateHash.put("162808", "인기브랜드<br>"+etcBlank1+"<font style=font-size:8pt>(키친플라워,키친아트,삼미"+etcComma2+")</font>");
        etcCateHash.put("160907", "<star1>조리도구<star2><br>"+"<font style=font-size:8pt>(국자,뒤집개,알뜰주걱"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("160910", "<star1>주방도구<star2><br>"+"<font style=font-size:8pt>(모양틀,채반,오프너"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("160908", "<star1>인기브랜드<star2><br>"+etcBlank1+"<font style=font-size:8pt>(헹켈,도루코,드레텍"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("161103", "주방도구"+etcBlank2+"<br>"+"<font style=font-size:8pt>(프라이팬정리,타월걸이"+etcComma2+")</font>");
        etcCateHash.put("161210", "인기브랜드<br>"+etcBlank1+"<font style=font-size:8pt>(한국도자기,행남자기,보덤)</font>");
        etcCateHash.put("160807", "인기브랜드<br>"+etcBlank1+"<font style=font-size:8pt>(슈피겔라우,리델"+etcComma2+")</font>");
        etcCateHash.put("162504", "표백제,얼룩제거제");
        etcCateHash.put("162408", "인기브랜드<br>"+etcBlank1+"<font style=font-size:8pt>(테팔,키친아트)</font>");
        etcCateHash.put("162106", "<star1>인기브랜드<star2><br><font style=font-size:8pt>(락앤락,글라스락,코멕스"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("162308", "인기브랜드"+etcBlank2+"<br>"+"<font style=font-size:8pt>(코렐,한국도자기,행남자기"+etcComma2+")</font>");
        etcCateHash.put("162315", "명품브랜드"+etcBlank2+"<br>"+"<font style=font-size:8pt>(포트메리온,레녹스,에밀앙리"+etcComma2+")</font>");
        etcCateHash.put("160508", "칫솔,치약,가글"+etcComma); 
        etcCateHash.put("160507", "욕실잡화<br>"+etcBlank1+"<font style=font-size:8pt>(대야,바가지,욕실화"+etcComma2+")</font>");
        etcCateHash.put("160501", "변기커버,발매트"+etcComma);
        etcCateHash.put("160504", "샤워기,수전");
        etcCateHash.put("160502", "욕실장,선반");
        etcCateHash.put("160508", "칫솔,치실,치간칫솔");
        etcCateHash.put("160515", "치약,가글액,구강스프레이");
        etcCateHash.put("160514", "세면기,양변기");
        etcCateHash.put("160511", "욕조,욕조덮개");
        etcCateHash.put("052607", "일반칫솔,치약,미백제"+etcComma);
        etcCateHash.put("160503", "비누받침,수건걸이"+etcComma);
        etcCateHash.put("162604", "재질별"+etcBlank2+"<br>"+etcBlank2+"(스텐,알루미늄,마그네슘"+etcComma2+")");
        etcCateHash.put("162610", "국내"+etcBlank2+"<br>"+etcBlank2+"(해피콜,네오플램,풍년"+etcComma2+")");
        etcCateHash.put("162613", "해외"+etcBlank2+"<br>"+etcBlank2+"(테팔,휘슬러,르크루제"+etcComma2+")");
        etcCateHash.put("160912", "저울,타이머,계량컵"+etcComma);
        etcCateHash.put("160201", "전동드릴,드라이버");
        etcCateHash.put("162108", "<star1>보온,보냉<star2><br>"+etcBlank1+"<font style=font-size:8pt>(보온도시락,보온병"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("162009", "여성청결제,티슈,찜질패드");
        etcCateHash.put("163202", "빨래판,세탁망"+etcComma2);
        etcCateHash.put("163201", "세탁물 보관함,빨래집게"+etcComma2);
        etcCateHash.put("163204", "청소도구<br>"+"<font style=font-size:8pt>(빗자루,먼지떨이,유리닦이"+etcComma2+")</font>");
        etcCateHash.put("163213", "테이프클리너,매직블럭");
        etcCateHash.put("162912", "인기브랜드<br>"+etcBlank1+"<font style=font-size:8pt>(에프킬라,하마시리즈,페브리즈"+etcComma2+")</font>");
        etcCateHash.put("162512", "인기브랜드<br>"+etcBlank1+"<font style=font-size:8pt>(액츠,샤프란,다우니"+etcComma2+")</font>");
        etcCateHash.put("161109", "밀봉도구,랩,호일,위생백"+etcComma);
        etcCateHash.put("161410", "인기브랜드<br>"+etcBlank1+"<font style=font-size:8pt>(크리넥스,깨끗한나라,코디"+etcComma2+")</font>");
        etcCateHash.put("162901", "방향제<br>"+etcBlank1+"<font style=font-size:8pt>(실내용,차량용"+etcComma2+")</font>");
        etcCateHash.put("162910", "향초,디퓨저");
        etcCateHash.put("162903", "새집증후군");
        etcCateHash.put("180204", "2014 다이어리,캘린더");
        etcCateHash.put("050514", "날개없는 선풍기");
        etcCateHash.put("050501", "스탠드형 선풍기");
        etcCateHash.put("050503", "탁상용 선풍기");
        etcCateHash.put("050502", "벽걸이형 선풍기");
        etcCateHash.put("050505", "타워형 선풍기");
        etcCateHash.put("050504", "업소,산업용 선풍기");
        etcCateHash.put("162909", "해충,쥐퇴치<br>"+etcBlank1+"<font style=font-size:8pt>(바퀴벌레,개미,파리"+etcComma2+")</font>");
        etcCateHash.put("163509", "인기브랜드"+etcBlank2+"<br>"+"(에네루프,에너자이저,깜냥"+etcComma2+")");
        etcCateHash.put("162011", "좋은느낌,화이트,애니데이"+etcComma2);
        etcCateHash.put("162012", "위스퍼,바디피트,예지미인"+etcComma2);
        etcCateHash.put("162014", "나트라케어,유기농본"+etcComma2);
        etcCateHash.put("161306", "거실등,방등,펜던트"+etcComma);
        etcCateHash.put("122506", "펜던트,매립등,야외등"+etcComma);
        etcCateHash.put("163604", "<ingi1>마스크<ingi2><br>"+etcBlank1+"<font style=font-size:8pt>(미세먼지차단,황사용,어린이용"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("163601", "<star1>렌즈,눈관리<star2><br>"+etcBlank1+"<font style=font-size:8pt>(렌즈세척액,습윤제"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("163602", "<star1>귀,코,입 관리<star2><br>"+etcBlank1+"<font style=font-size:8pt>(귀마개,구강거울"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("163609", "<star1>간병,보조<star2><br>"+etcBlank1+"<font style=font-size:8pt>(욕창방지매트,이동식변기"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("163611", "<star1>의료소모품<star2><br>"+etcBlank1+"<font style=font-size:8pt>(알콜솜,링겔대,주사기"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("181207", "<star1>생활용품<star2><br>"+etcBlank1+"<font style=font-size:8pt>(식기,울타리,장난감"+etcComma2+")</font>"+etcBlank1);           
        etcCateHash.put("181221", "관리,장식용품"+etcBlank2+"<br>"+"<font style=font-size:8pt>(여과기,펌프,수초"+etcComma2+")</font>"+etcBlank1);            
        etcCateHash.put("164221", "관리,장식용품"+etcBlank2+"<br>"+"<font style=font-size:8pt>(여과기,펌프,수초"+etcComma2+")</font>");      
        etcCateHash.put("181809", "포장지,쇼핑백");
        etcCateHash.put("161108", "고무장갑,수세미,세제통"+etcComma);
        etcCateHash.put("161105", "식탁소품,냄비받침,밥상보"+etcComma);
        etcCateHash.put("161104", "앞치마,조리사복,주방장갑"+etcComma);
        etcCateHash.put("161113", "식기,기타"+etcBlank2+"<br>"+"<font style=font-size:8pt>(접시,젓가락,위생장갑"+etcComma2+")</font>");
        etcCateHash.put("161214", "와인마개,코르크따개,와인랙"+etcComma2);
        etcCateHash.put("163704", "해빙기,스프레이건,포장기"+etcComma2);
        etcCateHash.put("032804", "<star1>실내분수,조화<star2><br>"+etcBlank1+"<font style=font-size:8pt>(인조잔디,비누꽃"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("032805", "화분대"+etcBlank2+"<br>"+"(화분,화병,이끼"+etcComma2+")");
        etcCateHash.put("122805", "화분,화분대"+etcBlank2+"<br>"+"(화병,수반,이끼"+etcComma2+")");
        etcCateHash.put("032806", "원예도구"+etcBlank2+"<br>"+"(원예가위,모종삽,온도계"+etcComma2+")");
        etcCateHash.put("181908", "주유,통화,메시지,인화권"+etcComma);
        etcCateHash.put("164708", "주유,통화,메시지,인화권"+etcComma);
        etcCateHash.put("181916", "외식,영화(빕스,CGV"+etcComma+")");
        //etcCateHash.put("164716", "외식,영화(빕스,CGV"+etcComma+")");
        etcCateHash.put("163507", "방사선측정,산업저울"+etcComma2);
        etcCateHash.put("181912", "오션월드,플레이도시"+etcComma);
        etcCateHash.put("163701", "에어드릴,에어타카"+etcComma);
        etcCateHash.put("163702", "유압잭,바이스"+etcComma);
        etcCateHash.put("070311", "자동 오버클럭(XMP)");
        etcCateHash.put("163703", "용접봉,용접기"+etcComma);
        etcCateHash.put("163705", "컴프레서,발전기"+etcComma);
        etcCateHash.put("163805", "화분대"+etcBlank2+"<br>"+"(화분,화병,이끼"+etcComma2+")");
        etcCateHash.put("163806", "원예도구"+etcBlank2+"<br>"+"(원예가위,모종삽,지지대"+etcComma2+")");
        etcCateHash.put("122806", "원예도구"+etcBlank2+"<br>"+"(원예가위,모종삽,지지대"+etcComma2+")");
        etcCateHash.put("163810", "꽃배달");
        etcCateHash.put("169301", "조리도구,보온<br>"+"(군고구마냄비,보온병"+etcComma2+")");
        etcCateHash.put("169315", "청소용품<br>"+"(밀대청소기,곰팡이제거제"+etcComma2+")");
        etcCateHash.put("169316", "새단장,정리<br>"+"(페인트,벽지,압축팩"+etcComma2+")");
        etcCateHash.put("169302", "커피,티포트");
        etcCateHash.put("169304", "개인난방<br>"+"(온풍기,손난로"+etcComma2+")");
        etcCateHash.put("169311", "침구,담요<br>"+"(오리털이불,무릎담요"+etcComma2+")");
        etcCateHash.put("169305", "방풍,제설<br>"+"(문풍지,동파방지,제설용품"+etcComma2+")");
        etcCateHash.put("169306", "공기정청,가습");
        etcCateHash.put("163110", "문풍지,방풍비닐");
        etcCateHash.put("020616", "스파이캠");
        etcCateHash.put("070301", "DDR,SDRAM");
        etcCateHash.put("070304", "DDR,SDRAM");
        etcCateHash.put("030448", "LTE-A, LTE폰");
    
        
        etcCateHash.put("093012", "그립,헤드,샤프트"+etcComma2);
        etcCateHash.put("061113", "처리기");
        etcCateHash.put("163513", "<star1>접착,보수<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(페인트,글루건"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("122606", "<star1>접착,보수<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(글루건,왁스"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("163512", "<star1>소형기계<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(컴프레서,발전기,해빙기"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("163516", "<star1>안전용품<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(마스크,안전화,소화기"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("160207", "<star1>공구브랜드<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(보쉬,블랙앤데커,계양"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("160216", "<star1>측정공구<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(온습도계,전기측정,캘리퍼스"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("160220", "송풍기,세척기,광택기");
        etcCateHash.put("163106", "<star1>접착,보수<star2><br>"+etcBlank1+"<font style=font-size:8pt>(글루건,왁스"+etcComma2+")</font>"+etcBlank1);  
        //etcCateHash.put("163110", "단열용품<br><font style=font-size:8pt>(단열에어캡,방풍비닐,문풍지"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("160610", "인기브랜드"+etcBlank2+"<br><font style=font-size:8pt>(카파,골든벨시계"+etcComma2+")</font>");
        etcCateHash.put("122710", "인기브랜드"+etcBlank2+"<br><font style=font-size:8pt>(카파,골든벨시계"+etcComma2+")</font>");
        etcCateHash.put("160611", "<star1>장식소품<star2><br>"+etcBlank1+"<font style=font-size:8pt>(장식인형,오르골,기념패"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("122711", "<star1>장식소품<star2><br>"+etcBlank1+"<font style=font-size:8pt>(장식인형,오르골,기념패"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("160601", "<star1>벽장식<star2><br>"+etcBlank1+"<font style=font-size:8pt>(우편함,인터폰박스,문패"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("122701", "<star1>벽장식<star2><br>"+etcBlank1+"<font style=font-size:8pt>(우편함,인터폰박스,문패"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("181801", "<star1>백일,돌잔치<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(데코,답례품,액자"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("181803", "<star1>할로윈,코스프레<star2><br>"+"(의상,가면,소품"+etcComma2+")");
        etcCateHash.put("164503", "할로윈,코스프레"+etcBlank2+"<br>"+"(의상,가면,소품"+etcComma2+")");   
        etcCateHash.put("181810", "<star1>수집<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(우표,화폐,골동품"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("164510", "<star1>수집<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(우표,화폐,골동품"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("162104", "양념통");
        etcCateHash.put("051101", "<star1>면도날,소모품<star2><br>"+etcBlank1+"<font style=font-size:8pt>(면도망,날,로션"+etcComma2+")</font>"+etcBlank2);
        etcCateHash.put("160309", "<star1>인기브랜드<star2><br>"+etcBlank1+"<font style=font-size:8pt>(창신리빙,락앤락,카노"+etcComma2+")</font>"+etcBlank1); 
        etcCateHash.put("181203", "인기브랜드"+etcBlank2+"<br>"+"<font style=font-size:8pt>(ANF,네슬레퓨리나,로얄캐닌"+etcComma2+")</font>");
        etcCateHash.put("032810", "꽃배달");
        etcCateHash.put("050816", "겟잇뷰티 방송제품");
        etcCateHash.put("181812", "트리장식<br>"+"(전구,인형,볼,종"+etcComma+")");
        etcCateHash.put("164512", "트리장식"+etcBlank2+"<br>"+"(전구,인형,볼,종"+etcComma2+")");  
        etcCateHash.put("181813", "벽장식,산타복,카드"+etcComma);
        etcCateHash.put("164513", "벽장식,산타복,카드"+etcComma);
        etcCateHash.put("181802", "<star1>생일,돌잔치<star2><br>"+"(데코,돌잡이,답례품"+etcComma+")");
        etcCateHash.put("164502", "생일,돌잔치"+etcBlank2+"<br>"+"(데코,돌잡이,답례품"+etcComma2+")");   
        //etcCateHash.put("030431", "아이폰5, 아이폰4S"+etcComma);
        etcCateHash.put("030432", "갤럭시S5,노트3"+etcComma);
        //etcCateHash.put("030501", "<new1>아이패드<new2>");
        etcCateHash.put("030520", "갤럭시 노트, 탭");
        etcCateHash.put("030523", "엑스페리아, 넥서스"+etcComma);
        etcCateHash.put("030553", "LG,소니"+etcComma);
        etcCateHash.put("030502", "<ingi1>슬레이트7<ingi2>");
        
        etcCateHash.put("038015", "거치대(탁상용,차량용)");
        etcCateHash.put("038018", "이어폰,이어셋");
        etcCateHash.put("038019", "터치펜,기타");
        etcCateHash.put("103008", "수영장기저귀,비치가운"+etcComma);
        etcCateHash.put("103003", "구명조끼,물안경"+etcComma);
        etcCateHash.put("103002", "풀장,목욕완구"+etcComma);  
        etcCateHash.put("103011", "씽씽이,콩콩이,호핑볼"+etcComma);
        etcCateHash.put("061115", "쓰레기통");
        etcCateHash.put("061120", "탈수,냉동고"+etcComma);
        etcCateHash.put("020907", "부가기능<br>"+etcBlank1+"<font style=font-size:8pt>(GPS,터치모니터"+etcComma2+")</font>");
        etcCateHash.put("020919", "신개념 디카<br>"+etcBlank1+"<font style=font-size:8pt>(듀얼 모니터,AM-OLED"+etcComma2+")</font>");
        etcCateHash.put("021406", "전용프린터");
        etcCateHash.put("021416", "속가방,렌즈케이스,레인커버"+etcComma);
        etcCateHash.put("020610", "케이블,가방"+etcComma);
        etcCateHash.put("020710", "가방,렌즈,플래시"+etcComma);
        etcCateHash.put("021202", "인기브랜드<br>"+"<font style=font-size:8pt>(아이팟,옙,코원"+etcComma2+")</font>");
        etcCateHash.put("021210", "인기브랜드<br>"+"<font style=font-size:8pt>(옙,아이리버,코원)</font>");
        etcCateHash.put("021204", "케이스,보호필름"+etcComma);
        etcCateHash.put("021809", "동영상 MP3(미니 PMP)");
        //etcCateHash.put("021805", "케이스,스킨,스피커"+etcComma);
        etcCateHash.put("021804", "인기브랜드<br>"+etcBlank1+"<font style=font-size:8pt>(아이스테이션,코원,빌립"+etcComma2+")</font>");
        etcCateHash.put("021812", "신기술 PMP<br>"+etcBlank1+"<font style=font-size:8pt>(HD급재생,HDMI단자"+etcComma2+")</font>");
        etcCateHash.put("021230", "신기술MP3<br>"+etcBlank1+"<font style=font-size:8pt>(AM-OLED,인터넷,블루투스"+etcComma2+")</font>");
        etcCateHash.put("021224", "방수,스포츠<br>"+etcBlank1+"<font style=font-size:8pt>(선글라스,시계"+etcComma2+")</font>");
        etcCateHash.put("022001", "유선");
        etcCateHash.put("022002", "무선");
        etcCateHash.put("022004", "업소용");
        etcCateHash.put("020611", "촬영기능<br>"+etcBlank1+"<font style=font-size:8pt;>(야간촬영,듀얼레코딩"+etcComma2+")</font>");
        etcCateHash.put("020613", "인기브랜드<br>"+etcBlank1+"<font style=font-size:8pt>(소니,산요,삼성,캐논)</font>");
        //etcCateHash.put("021110", "부가기능<br>"+"<font style=font-size:8pt;>(Full-HD,TV수신"+etcComma2+")</font>");
        //etcCateHash.put("021122", "용도별<br>"+"<font style=font-size:8pt;>(휴대용,회의실용"+etcComma2+")</font>");
        //etcCateHash.put("021114", "3D영상");
        etcCateHash.put("021237", "인기브랜드");
        etcCateHash.put("021524", "블루레이");
        etcCateHash.put("021525", "DVD");
        etcCateHash.put("021526", "어린이");
        etcCateHash.put("021130", "회의실,강당");
        etcCateHash.put("020319", "기능별");
        //etcCateHash.put("021123", "방식별<br>"+"<font style=font-size:8pt;>(DLP,LCD,LCos)</font>");
        etcCateHash.put("021124", "인기브랜드"+etcBlank2+"<br><font style=font-size:8pt;>(LG,옵토마,카시오"+etcComma2+")</font>");
        etcCateHash.put("020921", "캐논");
        etcCateHash.put("020922", "삼성");
        etcCateHash.put("020924", "올림푸스(뮤,PEN..)");
        etcCateHash.put("020927", "니콘");
        etcCateHash.put("021426", "겨울용품");
        etcCateHash.put("021404", "그립,기타");
        etcCateHash.put("021419", "전원,배터리");
        etcCateHash.put("022206", "기타");
        etcCateHash.put("031816", "차량용,펜형,기타");
        etcCateHash.put("020929", "에누리 추천<font style=font-size:8pt;>(나들이,인물,연예인"+etcComma2+")</font>");
        etcCateHash.put("020928", "<new1>방수카메라<font style=font-size:8pt;>(물놀이용)</font><new2>");
        etcCateHash.put("021513", "DivX<font style=font-size:8pt;>(HDD)</font>");
        etcCateHash.put("021521", "케이블,리모컨..");
        etcCateHash.put("020904", "기타");
        etcCateHash.put("020926", "<ingi1>스마트디카<ingi2>");
        etcCateHash.put("020108", "주방,욕실,무선"+etcComma);
        etcCateHash.put("020110", "셋탑박스,안테나,리모컨"+etcComma);
        etcCateHash.put("020805", "케이블,장식장"+etcComma);
        etcCateHash.put("021711", "연장선,이어폰캡"+etcComma);
        etcCateHash.put("021317", "<star1>음악,다큐<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(가요,팝,스포츠,종교"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("021801", "일반");
        etcCateHash.put("021802", "DMB");
        etcCateHash.put("021803", "내비");
        etcCateHash.put("020817", "스마트");
        etcCateHash.put("022303", "아이리버,코원,소니");
        etcCateHash.put("022515", "스마트");
         
        etcCateHash.put("071305", "하드랙,카드리더"+etcComma);
        etcCateHash.put("071012", "마우스패드,손목받침"+etcComma);
        //etcCateHash.put("070705", "그래픽쿨러,방열판"+etcComma);
        etcCateHash.put("070801", "칩셋별");
        etcCateHash.put("070802", "CPU별");
        etcCateHash.put("070803", "기능별");
        etcCateHash.put("070804", "칩셋별");
        etcCateHash.put("070805", "CPU별");
        etcCateHash.put("070806", "기능별");
        etcCateHash.put("070306", "SDRAM");
        etcCateHash.put("070305", "DDR2");
        etcCateHash.put("070310", "DDR3,DDR3L");
        etcCateHash.put("071002", "유선 광");
        etcCateHash.put("071003", "무선 광");
        etcCateHash.put("071008", "레이저");
        etcCateHash.put("071004", "유선");
        etcCateHash.put("071005", "무선");
        etcCateHash.put("070701", "인텔");
        etcCateHash.put("070702", "AMD");
        etcCateHash.put("070703", "CPU");
        etcCateHash.put("070704", "케이스");
        etcCateHash.put("971507", "<star1>무선모뎀<star2><br>"+etcBlank1+"<font style=font-size:8pt>(와이브로,HSDPA)</font>"+etcBlank1);
        etcCateHash.put("071112", "서버용,UPS"+etcComma);
        etcCateHash.put("071011", "<star1>게임용<star2><br>"+etcBlank1+"<font style=font-size:8pt>(높은dpi,무게추,동시입력키"+etcComma+")</font>"+etcBlank1);
        etcCateHash.put("070511", "엔비디아 지포스");
        etcCateHash.put("070510", "AMD 라데온");
        etcCateHash.put("070504", "TV카드");
        etcCateHash.put("071007", "프리젠터,터치패드,펜마우스"+etcComma2);
        etcCateHash.put("070909", "<star1>영상어댑터<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(Air 플레이어)</font>"+etcBlank1);
        etcCateHash.put("021123", "<star1>방식별<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(DLP,LCoS"+etcComma+")</font>"+etcBlank1);
        etcCateHash.put("021110", "<star1>기능별<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(Full-HD,3D"+etcComma+")</font>"+etcBlank1);
        etcCateHash.put("070216", "액세서리(파우치,연결케이블)");
        etcCateHash.put("071213", "스마트폰 연결(OTG)");
        etcCateHash.put("040442", "15인치 내장그래픽");
        etcCateHash.put("040422", "15인치 고속그래픽");
        
        etcCateHash.put("041004", "멀티부스트,키패드"+etcComma);
        etcCateHash.put("040603", "GPS,거치대"+etcComma);
        etcCateHash.put("040706", "클리너,리모컨"+etcComma);
        etcCateHash.put("041405", "개발,기타");
        etcCateHash.put("040715", "<star1>청소용품<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(스프레이,티슈,브러쉬"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("220515", "<star1>청소용품<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(스프레이,티슈,브러쉬"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("040716", "<star1>배선정리<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(타이,밴드,정리함"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("220516", "<star1>배선정리<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(타이,밴드,정리함"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("040709", "<star1>모니터용품<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(암,받침대,분배기"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("220509", "<star1>모니터용품<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(암,받침대,분배기"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("040710", "<star1>USB용품,기타<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(허브,선풍기,토이"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("220510", "<star1>USB용품,기타<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(허브,선풍기,토이"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("041808", "<star1>관련용품<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(케이블,하우징,어댑터"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("041806", "세트<font style=font-size:8pt;>(녹화기,카메라set"+etcComma2+")</font>");
        etcCateHash.put("041015", "차량용(거치대,충전기)");
        etcCateHash.put("041017", "업그레이드(SSD,RAM..)");
        etcCateHash.put("220317", "업그레이드(SSD,RAM..)");
        
        etcCateHash.put("210702", "핸들커버,기어커버"+etcComma);
        etcCateHash.put("210507", "내장(계기판,기어"+etcComma);
        etcCateHash.put("210505", "외장(몰딩,스포일러"+etcComma);
        etcCateHash.put("211307", "보호필름,리모컨,배터리"+etcComma);
        etcCateHash.put("210411", "멀티소켓,인버터,릴레이");
        etcCateHash.put("211510", "한국");
        etcCateHash.put("211511", "금호");
        etcCateHash.put("211512", "넥센");
        etcCateHash.put("211513", "미쉐린");
        ///etcCateHash.put("211310", "올인원/매립형");
        etcCateHash.put("211313", "거치대,안테나");
        etcCateHash.put("211607", "내비 일체형");
        etcCateHash.put("212202", "배터리");
        etcCateHash.put("212106", "후방카메라,카메라감지");
        etcCateHash.put("210109", "액세서리,케이블"+etcComma);
        etcCateHash.put("210110", "안테나,레벨미터,리모컨"+etcComma);
        etcCateHash.put("210304", "그릴,스포일러"+etcComma);
        etcCateHash.put("210401", "LED,HID"+etcComma);
        etcCateHash.put("210421", "할로겐,제논");
        etcCateHash.put("210402", "일반,기타");
        etcCateHash.put("210404", "LED");
        etcCateHash.put("210408", "네온램프");
        etcCateHash.put("210409", " LED튜닝");
        etcCateHash.put("210501", "서스펜션튜닝<br><font style=font-size:8pt>(스트럿바,쇼바,스프링"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("212203", "관련용품<br>"+"<font style=font-size:8pt;>(배터리충전기,접지용품"+etcComma2+")</font>");
        etcCateHash.put("210504", "점화플러그,점화케이블"+etcComma);
        etcCateHash.put("210506", "스타트버튼,경음기(혼)");
        etcCateHash.put("210519", "휠,커버,캡"+etcComma);
        etcCateHash.put("210520", "그릴,스포일러"+etcComma);
        etcCateHash.put("210813", "엔진오일");
        etcCateHash.put("210802", "부동액,미션오일"+etcComma);
        etcCateHash.put("210819", "광택,코팅제");
        etcCateHash.put("210903", "가습기,냉온장고,카포트"+etcComma);
        etcCateHash.put("210913", "도난방지,음주측정기"+etcComma);
        etcCateHash.put("210918", "카시트,보조시트,안전놀이방"+etcComma);
        etcCateHash.put("210903", "전기편의용품"+etcBlank2+"<br>"+etcBlank1+"<font style=font-size:8pt;>(냉온장고,공기청정기"+etcComma2+")</font>");
        etcCateHash.put("211508", "<star1>기능성 타이어<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(컴포트형,스포츠형,연비향상"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("212009", "DIY<font style=font-size:8pt>(내장재,계기판"+etcComma2+")</font>");
        etcCateHash.put("211504", "휠,커버,캡"+etcComma);
        etcCateHash.put("211506", "에어펌프,게이지,펑크수리"+etcComma);
        etcCateHash.put("150802", "페레로로쉐,허쉬"+etcComma);
        etcCateHash.put("210514", "스트럿바,스태빌라이저"+etcComma);
        //etcCateHash.put("210518", "브레이크패드,디스크"+etcComma);
        etcCateHash.put("212610", "내비게이션,GPS,<br>"+etcBlank1+"엔진오일,배터리"+etcComma2);
        etcCateHash.put("219708", "내장용품<br>"+etcBlank1+"<font style=font-size:8pt;>(시트,도어,대시보드"+etcComma2+")</font>");
        etcCateHash.put("219709", "외장용품"+etcBlank2+"<br><font style=font-size:8pt;>(자전거캐리어,카텐트"+etcComma2+")</font>");
        etcCateHash.put("219710", "유아용품<br>"+etcBlank1+"<font style=font-size:8pt;>(카시트,안전놀이방"+etcComma2+")</font>");
        etcCateHash.put("211312", "유가정보,안전운행"+etcComma);
        etcCateHash.put("211419", "대시보드,도어,기어커버"+etcComma);
        etcCateHash.put("211319", "스마트내비");
        etcCateHash.put("212012", "노트북, 스마트패드");
        etcCateHash.put("210915", "휴대폰거치대,충전기");
        etcCateHash.put("211331", "전원,메모리,안테나"+etcComma);
        etcCateHash.put("219609", "<star1>안전용품<star2><br>"+etcBlank1+"<font style=font-size:8pt>(소화기,랜턴,경광등"+etcComma2+")</font>");
        etcCateHash.put("212005", "트렁크정리함,콘솔박스"+etcComma);              
        etcCateHash.put("211603", "케이블,리더기,거치대"+etcComma);  
        etcCateHash.put("211707", "케이블,외장GPS"+etcComma);
        etcCateHash.put("120211", "싱글,슈퍼싱글");
        etcCateHash.put("120212", "더블,퀸,킹");
        etcCateHash.put("219612", "냉온장고,카포트,에어펌프"+etcComma);
        etcCateHash.put("219604", "여름시트,방석,안전놀이방"+etcComma);
        etcCateHash.put("219602", "에어컨필터,공기청정기"+etcComma);
        
        etcCateHash.put("145603", "<star1>기타지갑<star2><br>"+etcBlank1+"<font style=font-size:8pt>(카드지갑,머니클립"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("145908", "<star1>패션잡화<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(벨트,쥬얼리,넥타이"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("145608", "<star1><ingi1>인기브랜드<ingi2><star2><br>"+etcBlank1+"<font style=font-size:8pt;>(MCM,루이까또즈"+etcComma2+")</font>");
                
        etcCateHash.put("090104", "고글,보호대,헬멧"+etcComma);
        etcCateHash.put("090118", "장갑,마스크,비니"+etcComma);
        etcCateHash.put("090119", "가방,벨트,왁스"+etcComma);
        etcCateHash.put("090406", "<star1>일반운동기구<star2><br>"+etcBlank1+"<font style=font-size:8pt>(거꾸리,승마기,트램폴린"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("090408", "근력밴드,철봉바,악력기"+etcComma);
        etcCateHash.put("090409", "<star1>소품,잡화<star2><br>"+etcBlank1+"<font style=font-size:8pt>(장갑,모래주머니,중량조끼"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("090904", "수영용품<br>"+etcBlank1+"<font style=font-size:8pt>(오리발,가방,타월"+etcComma2+")</font>");
        etcCateHash.put("090905", "<ingi1>물놀이용품<ingi2><br>"+etcBlank1+"<font style=font-size:8pt>(튜브,구명조끼,스노클"+etcComma2+")</font>");
        etcCateHash.put("090514", "부품류,펌프,수리공구"+etcComma);
        etcCateHash.put("090515", "속도계,가방,물통"+etcComma);
        etcCateHash.put("090513", "헬멧,보호대,신발"+etcComma);
        etcCateHash.put("090609", "<star1>X-GAME<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(스케이트보드,스카이콩콩"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("090602", "트레이닝,슬라럼"+etcComma);
        etcCateHash.put("090605", "보호대,헬멧,가방"+etcComma);
        etcCateHash.put("092503", "안경착용");
        etcCateHash.put("181713", "스포츠,등산,공연용");
        etcCateHash.put("164613", "스포츠,등산,공연용");
        etcCateHash.put("092504", "기능별 "+etcBlank1+"<br>(변색렌즈,주야겸용"+etcComma+")");
        etcCateHash.put("121316", "소재별커튼"+etcBlank1+"<br>(린넨,쉬폰커튼)");
        etcCateHash.put("092506", "기능별 "+etcBlank1+"<br>(주야겸용,안경착용"+etcComma+")");
        etcCateHash.put("092508", "인기브랜드 "+etcBlank2+"<br>(오클리,루디프로젝트"+etcComma+")");
        etcCateHash.put("092408", "거치대,물통걸이,스탠드"+etcComma2);
        etcCateHash.put("092414", "속도계,내비게이션,GPS"+etcComma2);
        etcCateHash.put("090613", "피겨,아이스스케이트"); 
        etcCateHash.put("090713", "스피닝릴,베이트릴");
        etcCateHash.put("092512", "브랜드 "+etcBlank1+"<br>(오클리,시마노"+etcComma+")");
        etcCateHash.put("092505", "브랜드 "+etcBlank1+"<br>(일렉트릭,본지퍼"+etcComma+")");
        etcCateHash.put("091208", "축구복,배드민턴복"+etcComma);
        //etcCateHash.put("090504", "<star1>어린이용<star2><br>"+etcBlank1+"<font style=font-size:8pt>(세발자전거,씽씽이"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("090501", "<star1>인기브랜드<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(삼천리,트렉,알톤"+etcComma2+")</font>"+etcBlank1);  
        etcCateHash.put("092904", "<star1>다이어트용품<star2><br>"+etcBlank1+"<font style=font-size:8pt>(줄넘기,짐볼,아령"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("092905", "<star1>의류,신발,잡화<star2><br>"+etcBlank1+"<font style=font-size:8pt>(근력밴드,마스크,워킹화"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("092014", "그늘막(타프)");
        etcCateHash.put("092009", "<star1>인기브랜드<star2><br>"+etcBlank1+"<font style=font-size:8pt>(코베아,콜맨"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("100922", "비눗방울,물총"+etcComma);
        etcCateHash.put("093101", "<star1>인기브랜드<star2><br>"+etcBlank1+"<font style=font-size:8pt>(코베아,콜맨"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("092012", "텐트펙,텐트폴,로프"+etcComma2);
        etcCateHash.put("090310", "스패츠,나침반,GPS"+etcComma);
        etcCateHash.put("090325", "아이젠,안전모,피켈"+etcComma);
        etcCateHash.put("091618", "클라이마,ZX,바운스"+etcComma);
        etcCateHash.put("090327", "아이젠,스패츠,핫팩"+etcComma);
        etcCateHash.put("091103", "야구용품");
        etcCateHash.put("092903", "<star1>다이어트<star2><br>"+etcBlank1+"<font style=font-size:8pt>(워킹화,훌라후프"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("103010", "<star1>활동놀이<star2><br>"+etcBlank1+"<font style=font-size:8pt>(농구,야구,낚시"+etcComma2+")</font>"+etcBlank1);
        
                        
        etcCateHash.put("090314", "모자,양말,장갑"+etcComma);
        etcCateHash.put("071006", "타블렛(디지타이저)");
        etcCateHash.put("092004", "다용도칼,수납가방"+etcComma);
        etcCateHash.put("092102", "안전용품 "+etcBlank1+"<br>(자물쇠,전대,네임택"+etcComma+")");
        etcCateHash.put("092103", "편의용품 "+etcBlank1+"<br>(목쿠션,멀티플러그"+etcComma+")");
        etcCateHash.put("092113", "휴식"+etcBlank1+"<br>(그늘막,파라솔,해먹"+etcComma+")");
        etcCateHash.put("092112", "취사용품"+etcBlank1+"<br>(버너,코펠,조리도구"+etcComma+")");
        etcCateHash.put("092114", "물놀이용품"+etcBlank1+"<br>(수영복,튜브,비치모자"+etcComma+")");
        etcCateHash.put("092110", "<star1>나홀로 여행<star2><br><font style=font-size:8pt>(텐트,코펠,전투식량"+etcComma2+")</font>"+etcBlank1);  
        etcCateHash.put("092116", "<star1>단풍여행<star2><br><font style=font-size:8pt>(등산화,돗자리,자켓"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("092104", "<star1>신혼여행<star2><br><font style=font-size:8pt>(커플수영복,비치웨어"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("092117", "<star1>눈꽃여행<star2><br><font style=font-size:8pt>(손난로,넥워머,장갑"+etcComma2+")</font>"+etcBlank1);  
        etcCateHash.put("092107", "<star1>봄나들이<star2><br><font style=font-size:8pt>(돗자리,도시락,물병"+etcComma2+")</font>"+etcBlank1);  
        etcCateHash.put("092022", "쿠커 "+etcBlank1+"<br><font style=font-size:8pt>(냄비,압력밥솥,팬"+etcComma+")</font>");
        etcCateHash.put("092112", "취사용품"+etcBlank2+"<br><font style=font-size:8pt>(버너,코펠,조리도구"+etcComma+")</font>");
        etcCateHash.put("092114", "물놀이용품"+etcBlank2+"<br><font style=font-size:8pt>(수영복,튜브,비치모자"+etcComma+")</font>");
        etcCateHash.put("091302", "티셔츠,니트");
        etcCateHash.put("091306", "티셔츠,니트");
        etcCateHash.put("091903", "축구화,농구화"+etcComma2);
        etcCateHash.put("091906", "밴드,보호대,양말"+etcComma2);
        etcCateHash.put("091506", "경기복,기타");
        etcCateHash.put("091512", "루나,프리런,에어맥스"+etcComma);
        etcCateHash.put("121314", "샤워,속커튼,바란스"+etcComma);
        etcCateHash.put("091514", "가방,장갑,공,구기용품"+etcComma);
        etcCateHash.put("091606", "가방,모자,장갑"+etcComma);
        etcCateHash.put("090120", "눈썰매,스케이트,피겨복"+etcComma);
        etcCateHash.put("091110", "스포츠타월,보호대,점수판"+etcComma);
        etcCateHash.put("092413", "신발,장갑,보호장비"+etcComma);
        etcCateHash.put("092702", "버너,코펠,물병,컵"+etcComma);
        etcCateHash.put("092703", "미용기,아이스박스"+etcComma);
        etcCateHash.put("092704", "구급함,랜턴,다용도칼"+etcComma);
        etcCateHash.put("092705", "얼음목도리,미니선풍기"+etcComma);
        etcCateHash.put("092707", "튜브,물안경,구명조끼"+etcComma);
        etcCateHash.put("090415", "<star1>복부,진동<star2><br>"+etcBlank1+"<font style=font-size:8pt>(트위스트,다이어트벨트"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("092310", "모자,양말,장갑,세제"+etcComma);
        etcCateHash.put("211718", "<star1>신기술<star2><br>"+etcBlank1+"<font style=font-size:8pt>(WiFi,음성인식"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("092313", "<star1>인기브랜드<star2><br>"+etcBlank1+"<font style=font-size:8pt>(네파,K2,밀레,아이더"+etcComma2+")</font>"+etcBlank1);
        //etcCateHash.put("092309", "<star1>기능성웨어<star2><br>"+etcBlank1+"<font style=font-size:8pt>(언더웨어,세트"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("080703", "<star1>스타일링<star2><br>"+etcBlank1+"<font style=font-size:8pt>(왁스,헤어스프레이"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("090121", "브랜드별<br>"+"<font style=font-size:8pt>(펠리체,STL,골드윈"+etcComma2+")</font>");
        etcCateHash.put("090418", "격투기용품<br>"+etcBlank1+"<font style=font-size:8pt>(글러브,마우스피스,신발)</font>");
        //etcCateHash.put("091911", "트레이닝화,복싱화"+etcComma);
        etcCateHash.put("092912", "짐볼,돔볼,폼롤러"+etcComma);
        etcCateHash.put("092902", "<star1>마사지<star2><br>"+etcBlank1+"<font style=font-size:8pt>(덜덜이,벨트마사지"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("181405", "<star1>바둑,추석놀이<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(장기,당구,체스"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("164405", "<star1>바둑,민속놀이<star2><br>"+etcBlank1+"<font style=font-size:8pt;>(장기,당구,체스"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("181415", "인기시리즈<br>"+"<font style=font-size:8pt>(아이언맨,포켓몬스터"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("164415", "인기시리즈"+etcBlank2+"<br>"+"(어벤져스,골판지전사"+etcComma2+")");    
        etcCateHash.put("092403", "안장,타이어"+etcComma);
        etcCateHash.put("092411", "MTB,로드용");
        etcCateHash.put("091309", "우산,토시,벨트"+etcComma);
        etcCateHash.put("090328", "브랜드(트렉스타,K2"+etcComma+")");
                                    
        etcCateHash.put("102401", "<ingi1>모형,작동완구<ingi2><br><font style=font-size:8pt>(로봇,자동차,팽이"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("100508", "아이배냇,베비언스 ");
        etcCateHash.put("102409", "로봇(또봇,로보카폴리"+etcComma2+")");
        etcCateHash.put("102203", "감각발달완구(에듀볼,오볼"+etcComma2+")");
        etcCateHash.put("100501", "수입,산양,특수분유"+etcComma);
        etcCateHash.put("101310", "인기브랜드<br><font style=font-size:8pt>(구니카,리틀타익스"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("101102", "창의력교구<br><font style=font-size:8pt>(가베,점토,자석"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("100905", "가게,공구놀이"+etcComma);
        etcCateHash.put("100917", "스포츠,낚시놀이"+etcComma);
        etcCateHash.put("101004", "신생아완구<br><font style=font-size:8pt>(아기체육관,딸랑이"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("100916", "피규어,기타<br><font style=font-size:8pt>(실바니안,뚱이"+etcComma2+")</font>"+etcBlank1);
        //etcCateHash.put("100917", "활동놀이<br><font style=font-size:8pt>(스포츠,운전"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("100703", "형태별(팬티형,밴드형"+etcComma+")");
        etcCateHash.put("210809", "세차용품(청소기,타월"+etcComma+")");
        etcCateHash.put("210806", "세정제(휠세정,카샴푸"+etcComma+")");
        etcCateHash.put("210821", "코팅제(유리막,언더"+etcComma+")");
        etcCateHash.put("210819", "광택제(도장용,타이어"+etcComma+")");
        etcCateHash.put("213101", "합성유,광유");
        etcCateHash.put("213103", "0W-30,5W-20,10W-40"+etcComma);
        etcCateHash.put("213107", "냉각수,부동액"+etcComma);
        //etcCateHash.put("100704", "천기저귀,커버/밴드"+etcComma);
        etcCateHash.put("100405", "놀잇감,보호대,안전가드"+etcComma);
        etcCateHash.put("101202", "안전용품<br>"+etcBlank1+"<font style=font-size:8pt>(미아방지,잠금장치"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("101206", "건강용품<br>"+etcBlank1+"<font style=font-size:8pt>(체온계,코흡입기,체중계"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("100107", "머리띠,머리핀,목걸이"+etcComma); 
        etcCateHash.put("101312", "씽씽이,콩콩이,호핑볼"+etcComma); 
        etcCateHash.put("101305", "볼텐트,놀이텐트"+etcComma); 
        etcCateHash.put("101304", "그네,미끄럼틀,시소"); 
        etcCateHash.put("100116", "선글라스,머리핀,앞치마"+etcComma); 
        etcCateHash.put("100109", "장마,휴가철<br><font style=font-size:8pt>(우산,우의,썬캡)</font>"+etcBlank1);
        etcCateHash.put("100710", "인기브랜드");
        etcCateHash.put("100705", "형태별");
        etcCateHash.put("182205", "크레파스,색연필");
        etcCateHash.put("182207", "찰흙,판화,화구");
        etcCateHash.put("182209", "제도용품,만화용품");
        etcCateHash.put("101002", "몰펀,맥포머스"+etcComma2);
        etcCateHash.put("100402", "보행기,쏘서,점퍼루");
        etcCateHash.put("100711", "항균물티슈");
        etcCateHash.put("060224", "김치냉장겸용");
        etcCateHash.put("100101", "캐리어,숄더백,비치백"+etcComma2);
        etcCateHash.put("100117", "미아방지,가방,밴드"+etcComma2);
        etcCateHash.put("100103", "책가방,휠팩");
        etcCateHash.put("102007", "손,입,구강,제균,비데");
        etcCateHash.put("102008", "페넬로페,하기스,DR.아토");
        etcCateHash.put("102009", "몽드드");
        etcCateHash.put("100317", "더블하트,유피스,아벤트");
        etcCateHash.put("100505", "간식<font style=font-size:8pt>(초콜릿,쌀과자,과일칩"+etcComma+")</font>");
        etcCateHash.put("100715", "오보소,나비잠,큐티"+etcComma);
        etcCateHash.put("100718", "친환경<font style=font-size:8pt>(네띠,오어니스트"+etcComma+")</font>");
        etcCateHash.put("100307", "이유용컵<font style=font-size:8pt>(빨대컵,스파우트컵"+etcComma+")</font>");
        etcCateHash.put("100323", "조리기(전동식,수동식)");
        etcCateHash.put("101205", "욕조타월<br><font style=font-size:8pt>(욕조,목욕의자,탕온계"+etcComma2+")</font>");
        etcCateHash.put("101216", "샴푸,바디<br><font style=font-size:8pt>(헤어케어,바디클렌저"+etcComma2+")</font>");
        etcCateHash.put("101512", "앤디애플,월튼키즈,리바이스키즈"+etcComma); 
        etcCateHash.put("101513", "휠라,노스페이스,아디다스"+etcComma); 
        etcCateHash.put("102304", "태교용품<font style=font-size:8pt>(도서,CD"+etcComma+")</font>");
        etcCateHash.put("102308", "케어용품<font style=font-size:8pt>(화장품,스틸티"+etcComma+")</font>");
        etcCateHash.put("102305", "<ingi1>신생아의류<ingi2><br>"+"<font style=font-size:8pt>(배냇저고리,손싸개"+etcComma2+")</font>"+etcBlank2);
        etcCateHash.put("100114", "크록스,나이키,뉴발란스"+etcComma);
        etcCateHash.put("100115", "부츠(가죽,어그,털신"+etcComma+")");
        etcCateHash.put("162213", "위패,향로,돗자리"+etcComma2);
        etcCateHash.put("122521", "펜던트,매립등,야외등"+etcComma2);
        etcCateHash.put("101201", "형태별<br>"+"(양면,단면,폴더형,퍼즐형"+etcComma2+")");
        etcCateHash.put("101213", "인기브랜드<br>"+"(파크론,LG하우시스,알집매트)"); 
        etcCateHash.put("101214", "인기캐릭터<br>"+"(뽀로로,옐로우베어,피셔프라이스)"); 
        etcCateHash.put("038015", "거치대(탁상용,차량용)");
        etcCateHash.put("037914", "거치대(탁상용,차량용)");
        etcCateHash.put("035331", "스마트,셀카"+etcComma2);
        etcCateHash.put("035515", "방수,3D촬영");
        etcCateHash.put("035510", "케이블,가방"+etcComma2);
        etcCateHash.put("035420", "성능별 선택");
        etcCateHash.put("035407", "렌즈,후드"+etcComma2);
        etcCateHash.put("038108", "케이스,케이블,이어폰"+etcComma2);
        etcCateHash.put("038117", "필름,케이스,기타"+etcComma2);
        etcCateHash.put("038208", "연장선,이어폰캡"+etcComma2);
        etcCateHash.put("038215", "차량용,사무용,기타"+etcComma2);
                
        etcCateHash.put("101507", "수영복,구명조끼,비치가운"+etcComma);
        etcCateHash.put("100406", "유모차+카시트");
        etcCateHash.put("093202", "나이프,멀티툴");
        etcCateHash.put("100301", "젖병세정제,세정솔");
        etcCateHash.put("100310", "젖병소독기,건조대"+etcComma);
        etcCateHash.put("100510", "인기제조사");
        etcCateHash.put("100811", "기저귀정리함,교환대");
        etcCateHash.put("100507", "연령별<font style=font-size:8pt>(분유,이유식,두유"+etcComma2+")</font>");
        etcCateHash.put("100502", "이유식<font style=font-size:8pt>(레토르트,수제"+etcComma2+")</font>");
        etcCateHash.put("100517", "건강식품<font style=font-size:8pt>(홍삼,유산균,비타민"+etcComma2+")</font>");
        etcCateHash.put("100509", "연령별");
        etcCateHash.put("211414", "계절시트");
        etcCateHash.put("102309", "출산선물,제대혈"+etcComma);
        etcCateHash.put("100702", "하기스");
        etcCateHash.put("100712", "마미포코,토디앙,마망");
        etcCateHash.put("100708", "군,메리즈,무니망");
        etcCateHash.put("100713", "팸퍼스,리베로,러브스");
        etcCateHash.put("100707", "체중별,성별");
        etcCateHash.put("100408", "인기브랜드<br>"+"(맥클라렌,퀴니,잉글레시나"+etcComma2+")");
        etcCateHash.put("100415", "인기브랜드<br>"+"(에르고,맨듀카,포그내,포브)");
        etcCateHash.put("100403", "형태별<br>"+"(아기띠,힙시트,망토,워머"+etcComma2+")");
        etcCateHash.put("100401", "형태별<br>"+"(디럭스,휴대용"+etcComma2+")");
        etcCateHash.put("100404", "형태별<br>"+"(바구니형,일체형,분리형)");
        etcCateHash.put("100410", "인기브랜드<br>"+"(브라이택스,다이치,그라코"+etcComma2+")");
        etcCateHash.put("100417", "액세서리 <br>"+"(컵홀더,고리,담요"+etcComma2+")");
        etcCateHash.put("100418", "안전용품<br>"+"(ISOFIX,안전벨트"+etcComma2+")");
        etcCateHash.put("100419", "액세서리<br>"+"(침받이,워머,신생아패드"+etcComma2+")");
        etcCateHash.put("100110", "구두,실내화"+etcComma);
        etcCateHash.put("100108", "장마용품,마스크"+etcComma);
        etcCateHash.put("100115", "부츠(어그,가죽,패딩"+etcComma+")");
        etcCateHash.put("101208", "구강티슈,세정제,칫솔"+etcComma);
        etcCateHash.put("101207", "손톱깎이,가위,면봉"+etcComma);
        etcCateHash.put("021247", "케이스,케이블,이어폰"+etcComma);
        etcCateHash.put("120909", "스탠드옷걸이,폴행거");
        etcCateHash.put("164809", "스탠드옷걸이,폴행거");
        
        
        etcCateHash.put("120203", "접이식침대,돌침대"+etcComma);
        etcCateHash.put("121305", "블라인드,버티컬,홀딩도어"+etcComma);
        etcCateHash.put("120207", "협탁,부부테이블"+etcComma);
        etcCateHash.put("120213", "인기브랜드<br>"+etcBlank1+"<font style=font-size:8pt>(에이스침대,한샘"+etcComma2+")</font>");
        etcCateHash.put("120413", "인기브랜드<br>"+etcBlank1+"<font style=font-size:8pt>(한샘,이케아,치코"+etcComma2+")</font>");
        etcCateHash.put("120113", "소파베드,리클라이너,빈백"+etcComma);
        etcCateHash.put("120115", "<star1>거실의자<star2><br>"+etcBlank1+"<font style=font-size:8pt>(흔들의자,좌식의자"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("120107", "CD장,오디오장,장식장"+etcComma2);
        etcCateHash.put("120117", "<star1>인기브랜드<star2><br>"+etcBlank1+"<font style=font-size:8pt>(리바트,한샘,까사미아"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("120114", "1인용,2인용,3인용"+etcComma);
        etcCateHash.put("120508", "좌식의자,하이팩"+etcComma);
        etcCateHash.put("120906", "<star1>인기브랜드<star2><br>"+etcBlank1+"<font style=font-size:8pt>(왕자행거,가화행거"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("164806", "<star1>인기브랜드<star2><br>"+etcBlank1+"<font style=font-size:8pt>(왕자행거,가화행거"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("120312", "기능성식탁<br><font style=font-size:8pt>(아일랜드식탁,렌지대겸용"+etcComma2+")</font>");
        etcCateHash.put("120309", "<star1>인기브랜드<star2><br>"+etcBlank1+"<font style=font-size:8pt>(한샘,리바트,에넥스"+etcComma2+")</font>");
        etcCateHash.put("120811", "매트커버,요,이불,베개"+etcComma);
        etcCateHash.put("120813", "카페트,러그,발매트");
        etcCateHash.put("121504", "식탁,주방커버"); 
        etcCateHash.put("121503", "선풍기커버,의자커버"+etcComma);
        etcCateHash.put("121505", "십자수,퀼트,수예용품");
        etcCateHash.put("120402", "침대");
        etcCateHash.put("120404", "책상,의자");
        etcCateHash.put("120406", "침대"); 
        etcCateHash.put("040811", "PS3,PS2");
        etcCateHash.put("040817", "PS비타,PSP");
        etcCateHash.put("120407", "책상,책장,의자");
        etcCateHash.put("120409", "침실세트");
        etcCateHash.put("120701", "서랍장");
        etcCateHash.put("060718", "아이스크림제조");
        etcCateHash.put("121306", "커튼봉,집게,링,고리"+etcComma);
        etcCateHash.put("121310", "대나무발,비즈발"+etcComma);
        etcCateHash.put("120516", "모니터받침,책상유리"+etcComma2);
        etcCateHash.put("120518", "2인용,좌식,독서실책상"+etcComma);
        etcCateHash.put("120522", "장식장겸용,맞춤형,부품"+etcComma);
        etcCateHash.put("121908", "회의실,로비,강의실의자"+etcComma2);
        etcCateHash.put("121909", "발받침,의자매트,의자부품"+etcComma2);
        etcCateHash.put("121901", "<star1>인기브랜드<star2><br>"+etcBlank1+"<font style=font-size:8pt>(듀오백,우리들체어,퍼시스"+etcComma2+")</font>");
        etcCateHash.put("120821", "<star1>인기브랜드<star2><br>"+etcBlank1+"<font style=font-size:8pt>(아망떼,동진침장,한샘"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("121315", "<star1>인기브랜드<star2><br>"+etcBlank1+"<font style=font-size:8pt>(쁘리엘르,아망떼,바자르"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("120519", "<star1>인기브랜드<star2><br>"+etcBlank1+"<font style=font-size:8pt>(한샘,나산가구,방송협찬"+etcComma2+")</font>");
        etcCateHash.put("120514", "삼나무(친환경)");
        etcCateHash.put("120817", "베개,베개커버");
        etcCateHash.put("120804", "유아,아동침구");
        etcCateHash.put("120204", "스프링,독립스프링,메모리폼"+etcComma2);
        etcCateHash.put("145510", "클래식<br>"+"(시슬리,루이까또즈"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("145511", "캐주얼<br>"+"(키플링,만다리나덕"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("145512", "비즈니스<br>"+"(쌤소나이트,닥스"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("145513", "여행 <br>"+"(아메리칸투어리스터,던롭"+etcComma2+")</font>"+etcBlank1);
                                         
        etcCateHash.put("080604", "제모,슬리밍,가슴관리");
        //etcCateHash.put("080709", "컬러링,펌");
        etcCateHash.put("081307", "거울");
        etcCateHash.put("081009", "<star1>인기브랜드<star2><br>"+etcBlank1+"<font style=font-size:8pt>(불가리,샤넬"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("081611", "<star1>인기브랜드<star2><br>"+etcBlank1+"<font style=font-size:8pt>(화이트,위스퍼"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("081706", "<star1>인기브랜드<star2><br>"+etcBlank1+"<font style=font-size:8pt>(설화수,더후,SK-II"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("080213", "자외선차단제"); 
        etcCateHash.put("080613", "손세정제");
        etcCateHash.put("035937", "iPod,삼성"+etcComma);
        etcCateHash.put("081301", "<star1>아이<star2><br><font style=font-size:8pt>(뷰러,속눈썹,쌍꺼풀"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("081201", "<star1>유아목욕<star2><br>"+etcBlank1+"<font style=font-size:8pt>(바디클렌저,샴푸"+etcComma2+")</font>");
        etcCateHash.put("100202", "<star1>기초케어<star2><br>"+etcBlank1+"<font style=font-size:8pt>(스킨,로션,크림,오일)</font>");
        etcCateHash.put("100207", "<star1>기능성케어<star2><br>"+etcBlank1+"<font style=font-size:8pt>(선케어,기저귀발진"+etcComma2+")</font>");
        etcCateHash.put("100201", "<star1>유아목욕<star2><br>"+etcBlank1+"<font style=font-size:8pt>(바디클렌저,샴푸"+etcComma2+")</font>");
        etcCateHash.put("120302", "시스템키친");
        etcCateHash.put("149801", "의류<br>"+etcBlank1+"<font style=font-size:8pt>(패딩,야상,코트,기모티셔츠"+etcComma2+")</font>");
        etcCateHash.put("149802", "신발<br>"+etcBlank1+"<font style=font-size:8pt>(어그부츠,워커,모카신"+etcComma2+")</font>");
        etcCateHash.put("149803", "잡화<br>"+etcBlank1+"<font style=font-size:8pt>(장갑,목도리,레깅스"+etcComma2+")</font>");
        etcCateHash.put("159805", "<star1>커피,코코아,차<star2><br><font style=font-size:8pt>(커피,율무차,핫초코,전통차"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("159802", "<star1>면,국물요리<star2><br><font style=font-size:8pt>(라면,우동,스프,누룽지"+etcComma2+")</font>"+etcBlank1);  
        etcCateHash.put("159803", "<star1>즉석,가공식품<star2><br><font style=font-size:8pt>(순대,만두,찐빵,어묵"+etcComma2+")</font>"+etcBlank1);  
        etcCateHash.put("159804", "<star1>안주류<star2><br><font style=font-size:8pt>(마른안주,햄,골뱅이"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("159801", "<star1>농산물<star2><br>"+etcBlank1+"<font style=font-size:8pt>(귤,감,고구마,감자"+etcComma2+")</font>"+etcBlank1);            
        
        etcCateHash.put("145122", "캐릭터시계<br>"+etcBlank1+"<font style=font-size:8pt>(월트디즈니,레고,헬로키티"+etcComma2+")</font>"+etcBlank1);       
        etcCateHash.put("145103", "캐주얼시계<br>"+etcBlank1+"<font style=font-size:8pt>(스와치,시티즌,캘빈클라인"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("145104", "스포츠시계<br>"+etcBlank1+"<font style=font-size:8pt>(G-SHOCK,타이맥스,순토"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("145108", "정장시계<br>"+etcBlank1+"<font style=font-size:8pt>(로만손,루이까또즈,로즈몽"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("145110", "시계줄,보관함"+etcComma);
        etcCateHash.put("145109", "명품시계<br>"+etcBlank1+"<font style=font-size:8pt>(세이코,알마니,D&G"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("145211", "쥬얼리소품<br>"+etcBlank1+"<font style=font-size:8pt>(진열대,브로치"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("145215", "<ingi1>인기브랜드<ingi2><br>"+etcBlank1+"<font style=font-size:8pt;>(제이에스티나,골든듀"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("145212", "브랜드쥬얼리<br>"+"<font style=font-size:8pt>(제이에스티나,골든듀"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("145507", "<ingi1>인기브랜드<ingi2><br>"+etcBlank1+"<font style=font-size:8pt>(MCM,루이까또즈"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("145405", "<ingi1>인기브랜드<ingi2><br>"+etcBlank1+"<font style=font-size:8pt>(컨버스,랜드로바,탐스"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("145407", "기능화<br>"+etcBlank1+"<font style=font-size:8pt>(효도화,간호화"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("145404", "깔창,신발끈,방수,클리너"+etcComma);
        etcCateHash.put("145410", "구두,클래식<br>"+"(무크,탠디,소다"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("145411", "스니커즈,운동화<br>"+"(랜드로바,컨버스,닥터마틴"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("145412", "운동화<br>"+"(포니,루릭"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("145413", "시즌<br>"+"(버켄스탁,크록스"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("145417", "캐주얼화<br>"+"(플랫,옥스포드화"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("145708", "잡화세트,라이터"+etcComma);
        etcCateHash.put("145907", "패션소품<br>"+"<font style=font-size:8pt>(넥타이핀,라이터"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("148101", "<star1>여성브랜드<star2><br><font style=font-size:8pt>(SOUP,나이스클랍,르샵"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("148102", "<star1>남성브랜드<star2><br><font style=font-size:8pt>(지이크,STCO,보닌"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("148103", "<star1>캐주얼브랜드<star2><br><font style=font-size:8pt>(게스,지오다노,폴햄"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("148104", "<star1>언더웨어브랜드<star2><br><font style=font-size:8pt>(비비안,트라이,BYC"+etcComma2+")</font>"+etcBlank1);
    
       etcCateHash.put("219809", "배터리,점화플러그");
       etcCateHash.put("219808", "스노우체인");
       etcCateHash.put("219803", "스노우타이어");
       etcCateHash.put("219815", "스키,보드캐리어,루프박스");
       etcCateHash.put("219810", "부동액,김서림방지제,성에제거"+etcComma);
        

        etcCateHash.put("090414", "<star1>다이어트<star2><br>"+etcBlank1+"<font style=font-size:8pt>(DVD,워킹화,마스크"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("081018", "추천향수");
        etcCateHash.put("160312", "매직행거,옷걸이,바지걸이"+etcComma);
        etcCateHash.put("160307", "옷커버,선풍기커버"+etcComma);
        etcCateHash.put("971605", "공용<br>"+"(충전기,터치펜,케이블"+etcComma+")");
        etcCateHash.put("971601", "아이폰");
        etcCateHash.put("971603", "아이폰 전용");
        etcCateHash.put("971604", "아이팟 전용");
        etcCateHash.put("971607", "아이팟 연결<br>"+etcBlank1+"<font style=font-size:8pt>(오디오,홈시어터"+etcComma2+")</font>");
        etcCateHash.put("971608", "차량용<br>"+etcBlank1+"<font style=font-size:8pt>(카팩,시거잭,거치대)</font>");
        etcCateHash.put("020711", "액세서리");
        etcCateHash.put("980115", "3D입체영상 TV");
        etcCateHash.put("975719", "방수팩,키스킨,조이스틱"+etcComma);
        etcCateHash.put("975720", "차량용거치대"); 
        
        etcCateHash.put("975501", "아이폰,아이패드");
        etcCateHash.put("975502", "갤럭시S2,노트,갤럭시탭"+etcComma2);
        etcCateHash.put("975503", "베가,옵티머스");
        etcCateHash.put("975618", "거치대(탁상용,차량용)");
        etcCateHash.put("975709", "터치펜,배터리팩,무선모뎀..");
        etcCateHash.put("975710", "차량용(거치대,충전기..)");
        etcCateHash.put("975617", "터치펜,기타");
        etcCateHash.put("180208", "스케줄러,캘린더");
        etcCateHash.put("180207", "지구본,저금통");
        etcCateHash.put("180211", "독서대,북마크");
        etcCateHash.put("060214", "LG");
        etcCateHash.put("060215", "삼성");
        etcCateHash.put("060216", "기타브랜드");
        etcCateHash.put("060222", "위니아만도");
        etcCateHash.put("060909", "LG");
        etcCateHash.put("060912", "삼성");
        etcCateHash.put("060910", "동부대우");
        etcCateHash.put("060504", "인덕션");
        etcCateHash.put("062127", "LG 광파");
        etcCateHash.put("062128", "삼성 스마트");
        etcCateHash.put("062129", "동양매직");
        etcCateHash.put("060610", "반,전자동머신");
        etcCateHash.put("060908", "위니아만도");
        
        
        etcCateHash.put("021418", "스튜디오용<br>"+etcBlank1+"<font style=font-size:8pt>(배경지,반사판,조명"+etcComma2+")</font>");
        etcCateHash.put("022606", "랜케이블");
        etcCateHash.put("050815", "<star1>여행용<star2><br><font style=font-size:8pt>(드라이어,스트레이터)</font>"+etcBlank1);
        etcCateHash.put("060515", "레인지+그릴");
        etcCateHash.put("060710", "반죽,제면기");
        etcCateHash.put("070615", "전원,변환케이블"+etcComma);
        etcCateHash.put("071207", "부가기능<br>"+etcBlank1+"<font style=font-size:8pt>(OTG,보안강화,방수"+etcComma2+")</font>");
        etcCateHash.put("071208", "USB허브,케이블,복사기"); 
        etcCateHash.put("030431", "아이폰5s,5c"+etcComma);
        etcCateHash.put("030522", "사양비교");
        etcCateHash.put("038001", "<b style='cursor:default;'>전용 액세서리</b>");
        etcCateHash.put("037901", "<b style='cursor:default;'>전용 액세서리</b>");
        etcCateHash.put("038301", "<b>렌즈, 필터</b>");
        etcCateHash.put("038307", "<b>디카용 액세서리</b>");
        etcCateHash.put("038318", "<b>반사판, 조명, 배경지</b>");
        etcCateHash.put("038101", "<b>MP3,PMP,녹음기</b>");
        etcCateHash.put("038109", "<b>전자책, 전자사전</b>");
        etcCateHash.put("038201", "<b>이어폰,헤드폰</b>");
        etcCateHash.put("038209", "<b>블루투스</b>");
        etcCateHash.put("068001", "<b>TV</b>");
        etcCateHash.put("068011", "<b>TV액세서리</b>");
        etcCateHash.put("059801", "<b>온열매트,전기장판</b>");
        etcCateHash.put("059807", "<b>난방기,보일러</b>");
        etcCateHash.put("059501", "<b>에어컨,냉난방</b>");
        etcCateHash.put("059510", "<b>선풍기,냉풍기</b>");
        etcCateHash.put("059521", "<b>제습기</b>");
        etcCateHash.put("060118", "TV광고모델(블랙펄,클래식..)");
        //etcCateHash.put("060220", "3,4도어(T타입,V9100..)");
        
        //패션예외
        etcCateHash.put("147628", "축구복,배드민턴복"+etcComma);
        etcCateHash.put("147608", "바람막이,자켓");
        
        //식품 예외
        etcCateHash.put("150101", "<star1>건강보조식품<star2><br><font style=font-size:8pt>"+etcBlank1+"(오메가3,글루코사민"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("150103", "<star1>다이어트 보조식품<star2><br><font style=font-size:8pt>"+etcBlank1+"(허벌라이프,CLA"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("150111", "<star1>헬스보조제,미용<star2><br><font style=font-size:8pt>"+etcBlank1+"(콜라겐,알로에"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("150705", "<star1>조미료,향신료<star2><br><font style=font-size:8pt>"+etcBlank1+"(설탕,소금,다시다"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("150207", "<star1>버섯<star2><br><font style=font-size:8pt>(영지,상황,표고"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("150402", "<star1>해산물<star2><br><font style=font-size:8pt>(전복,조개,게"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("150404", "<star1>건어물<star2><br><font style=font-size:8pt>(마른오징어,멸치,육포"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("150704", "<star1>양념,장<star2><br><font style=font-size:8pt>(고추장,된장,간장"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("150905", "<star1>건강식품<star2><br><font style=font-size:8pt>"+etcBlank1+"(정관장,비타민,꿀"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("150803", "라면,냉면,스파게티"); 
        etcCateHash.put("150804", "<star1>즉석,냉동식품<star2><br><font style=font-size:8pt>(즉석밥,카레,국"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("150503", "<star1>음료,생수<star2><br><font style=font-size:8pt>"+etcBlank1+"(혼합차,두유,캔커피"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("150508", "<star1>주스<star2><br><font style=font-size:8pt>"+etcBlank1+"(오렌지,푸룬주스"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("150801", "<star1>과자,아이스크림<star2><br><font style=font-size:8pt>"+etcBlank1+"(시리얼,스낵,쿠키"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("151002", "<star1>즉석밥,카레,덮밥<star2><br><font style=font-size:8pt>"+etcBlank1+"(햇반,즉석카레,스프,죽"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("151010", "<star1>즉석국,탕,찌개<star2><br><font style=font-size:8pt>"+etcBlank1+"(즉석국,삼계탕,사골곰국"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("150602", "종류별"+etcBlank2+"<br>(포기김치,총각김치"+etcComma2+")");
        etcCateHash.put("150601", "인기브랜드"+etcBlank2+"<br>(종가집,하선정"+etcComma2+")");
        //etcCateHash.put("150603", "<star1>김장재료<star2><br><font style=font-size:8pt>"+etcBlank1+"(절임배추,무,고춧가루"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("151012", "<star1>간편조리식<star2><br><font style=font-size:8pt>"+etcBlank1+"(월남쌈,순대,족발,떡볶이"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("151009", "<star1>면류<star2><br><font style=font-size:8pt>"+etcBlank1+"(당면,국수,스파게티"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("151003", "햄,어묵,냉장식품");
        etcCateHash.put("151007", "돈까스,만두,냉동식품");
        etcCateHash.put("150701", "<star1>김치<star2><br><font style=font-size:8pt>(포기김치,총각김치,동치미"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("150709", "<star1>김치 브랜드<star2><br><font style=font-size:8pt>(CJ햇김치,종가집,홍진경"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("150710", "<star1><ingi1>김장재료<ingi2><star2><br><font style=font-size:8pt>(절임배추,무,고춧가루"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("150807", "<img src="+ConfigManager.IMG_ENURI_COM+"/images/main_2007/hot.gif border=0 align=abstop> 바캉스 먹거리");
        etcCateHash.put("151302", "<star1>탄산,이온음료<star2><br><font style=font-size:8pt>"+etcBlank1+"(콜라,사이다,이온음료"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("151305", "<star1>주스<star2><br><font style=font-size:8pt>"+etcBlank1+"(오렌지,자몽,블루베리"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("151303", "<star1>건강,기능성음료<star2><br><font style=font-size:8pt>"+etcBlank1+"(환자영양,식초음료"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("151008", "치즈,버터,마가린");
        etcCateHash.put("150504", "<star1>곡물,과실,건강차<star2><br><font style=font-size:8pt>"+etcBlank1+"(율무차,유자차"+etcComma2+")</font>"+etcBlank1);
        etcCateHash.put("150501", "커피믹스,음료,코코아"+etcComma);
        etcCateHash.put("150510", "원두,캡슐,원두스틱"+etcComma);
        
        return etcCateHash;
}
%>
<%
    String strUserAgentStr = ChkNull.chkStr(request.getHeader("User-Agent"));
    try {
        String strSep = "--";
        HashMap menuMainHashMap = new HashMap();
        HashMap menuLocHashMap = new HashMap();
        ArrayList menuMainHashMapKeys = new ArrayList();

        // 메뉴 순서대로 정렬해서 데이터를 가져옴 0202
        String strCaLOrder = ConfigManager.RequestStr(request, "_o", "");
        String strMobleAg = ConfigManager.RequestStr(request, "_m", "");
        Category_Data[] category_data = null;
        if (strCaLOrder.trim().length() > 0 ){
            int intLOrder = Integer.parseInt(strCaLOrder);
            String strCaLCode = "";
            switch (intLOrder){
				/*                
				0680 TV → 0201
				0697 세탁기,건조기 → 0502
				0681 프로젝터,스크린 → 0211
				0682 블루레이,DVD,DivX → 0215
				0683 홈시어터,HiFi → 0208
				0684 도킹오디오,스피커 → 0357
				0685 오디오,카세트,라디오 → 0203
				0686 마이크,노래반주기 → 0220
				0687 케이블,젠더 → 2206
				0688 TV용 액세서리 → 0224
				*/
				case 1: strCaLCode = "03,2208,2201,2202"; break;
                case 2: strCaLCode = "05,06,0201,0502,0211,0215,0208,0357,0203,0220,2206,0224"; break;
                case 3: strCaLCode = "07,04,2203,2204,0305,1803,2203,2205,2207"; break;
                case 4: strCaLCode = "09"; break;
                case 5: strCaLCode = "21"; break;
                case 6: strCaLCode = "10,0812"; break;
                case 7: strCaLCode = "12,1803,1822,1801,1802,1803,0402,0527,1807,1808,1607"; break;
                case 8: strCaLCode = "16,0606,0514,0510,0515"; break;
                case 9: strCaLCode = "14,0923,0912"; break;
                case 10: strCaLCode = "08"; break;
                case 11: strCaLCode = "15"; break;                                
            }
            category_data = Category_Proc.Category_Top_List_ByLCode(strCaLCode);
        }else{
            category_data = Category_Proc.Category_Top_List();
        }

        String pstrPastLcode = "";
        String pstrPastMcode = "";
        String pstrPastScode = "";
        
        for(int i=0; i<category_data.length; i++) {
            
            String ca_code2 = category_data[i].getCa_code().trim();
            String ca_code3 = category_data[i].getCa_code_2().trim();

            String ca_Lcode = ca_code2.substring(0,2);
            String ca_Mcode = ca_code2.substring(2,4);
            String ca_Scode = "00";
            if(ca_code3.length()>=6) {
                ca_Scode = ca_code3.substring(4,6);
            }

            String c_name_2 = category_data[i].getC_name().trim().replaceAll("\"","&#34;");
            String c_name_3 = category_data[i].getC_name_2().trim().replaceAll("\"","&#34;");
            String c_knowbox_2 = category_data[i].getC_knowbox().trim();
            String c_location = category_data[i].getC_location().trim();

            //탑메뉴에서 분류안나오는 분류(막는분류)
            if(ControlUtil.compareValOR(new String[]{ca_code3, 
                "164219", "164220", "164222", "164314", "164316", "164413", "164515", "164606", "164612", "060823", "164514", "162617", "082614",
                "030408", "030409", "040110", "040111", "091215", "121309", "070204", "111009", "021709", "030440", "180801", "181222", "180122",
                "111601", "120201", "021133", "070809", "070810", "050111", "060101", "040819", "120101", "020925", "070307", "090614", "053005",
                "120104", "060221", "071409", "130602", "130606", "130707", "130701", "091405", "071410", "051801", "022211", "050715", "103009",
                "111505", "060505", "050208", "081005", "040911", "040912", "040913", "111404", "070514", "050213", "101211", "020818", "022221",
                "040307", "020302", "210112", "051015", "071009", "071010", "040208", "070401", "070706", "070707", "030706", "060628", "092416",
                "070308", "034210", "034214", "070509", "030707", "030202", "040304", "040205", "071101", "071102", "070201", "060519", "120216",
                "111011", "111009", "090608", "111401", "081411", "081412", "020816", "110909", "110910", "120801", "120805", "120216", "050423",
                "091509", "091510", "091511", "069204", "020306", "210710", "211309", "100617", "092412", "122008", "030429", "180212", "041801",
                "090108", "081601", "081605", "060506", "100506", "161308", "022711", "180218", "060605", "080419", "150815", "101421", "021134",
                "100504", "100701", "111310", "120401", "120405", "210512", "110808", "021710", "121107", "051309", "031801", "031809", "021425",
                "060607", "040818", "061911", "020402", "061809", "021323", "022710", "021231", "020824", "041412", "975007", "103004", "036121",
                "111710", "091301", "091305", "050702", "060307", "120512", "120523", "140804", "140805", "181101", "092607", "181814", "145408",
                "091806", "060911", "071201", "040214", "160204", "101408", "211326", "021428", "100510", "021901", "021905", "120311", "221131",
                "161211", "051108", "051621", "181111", "062007", "060405", "060501", "101504", "091907", "092608", "041022", "051317", "101420", "101419",
                "040608", "162409", "162316", "162410", "163112", "060711", "060627", "061012", "162508", "122009", "180812", "070911", "070912",
                "090910", "090507", "100809", "091312", "022007", "022013", "051012", "051509", "060302", "070406", "060616", "070619", "145514",
                "060517", "050813", "052108", "062109", "061111", "060814", "021015", "021411", "080217", "081509", "080309", "080408", "020127",
                "100911", "101009", "162809", "101307", "091802", "051407", "090321", "092307", "092008", "100409", "100411", "120818", "181815",
                "211417", "091509", "091510", "091511", "091614", "091615", "091401", "071306", "071307", "040718", "120712", "070150", "120823",
                "210115", "091410", "160613", "121509", "211311", "021708", "211719", "020408", "100717", "181211", "070151", "181413", "092908",
                "020808", "162709", "162710", "163206", "163207", "163208", "162510", "090322", "090315", "060915", "060502", "150511", "051117", 
                "091224", "022101", "022111", "210117", "189001", "189005", "189009", "162111", "211610", "040426", "102010", "102011", "093110",
                "162010", "162908", "060614", "020314", "020407", "081306", "090404", "163608", "040720", "060918", "210906", "092018", "051924",
                "021528", "180816", "060821", "062126", "062130", "082610", "976302", "976306", "030561", "120830", "220609", "220520", "120823",
                "021806", "090520", "092410", "100719", "181706", "181712", "092510", "092511", "092509", "069203", "162611", "210815", "211507",
                "100111", "052309", "211307", "212109", "210816", "147623", "972006", "060819", "052120", "080914", "061116", "092017", "035201", 
                "035325", "035521", "035401", "035701", "035705", "035815", "035820", "122508", "122515", "122612", "122713", "122808", "122809",
                "147624", "180113", "180212", "180210", "971609", "050416", "121910", "041012", "041110", "021322", "041014", "022312", "035941",
                "021805", "100109", "100113", "040714", "050814", "052109", "210616", "093111", "030428", "090417", "090411", "150607", "121317",
                "219613", "219614", "092415", "060116", "210817", "210619", "092016", "090324", "101113", "052610", "180815", "061116", "220312",
                "031317", "022408", "022409", "150709", "162712", "210417", "052609", "211518", "212209", "022507", "022508", "092118", "220518", "220518", "220312",
                "080411", "101115", "102208", "090326", "051516", "031901", "031905", "161114", "181314", "182210", "182211", "220410",
                "031912", "102307", "100319", "102406", "210914", "022609", "163710", "092913", "061118", "181316", "975020", "087808", "220322", "220719", "220718",
                "163711", "160811", "160812", "160813", "080713", "972103", "087801", "080234", "070618", "100416", "042010", "220128", "220810", "220814", "220810",
                "070618", "082508", "082509", "212611", "212612", "051114", "022015", "161110", "020119", "060524", "092024", "038024", "150811",
                "032808", "032809", "032807", "219711", "219712", "219713", "122104", "122108", "122112", "162208", "030560", "092316", "092317",  
                "972106", "040432", "050616", "092109", "092111", "160313", "160516", "033209", "033210", "033208", "021240", "070219", "037919",  
                "040712", "040713", "041809", "051310", "061016", "086602", "086605", "040432", "052712", "052716", "052713", "030439",
                "060217", "161212", "161409", "163510", "162013", "101016", "163713", "082811", "082812", "162115", "120310", "093213", "050621",  
                "162114", "148105", "148106", "148107", "148108", "081311", "180308", "020314", "020323", "020324", "975015", "021901", "212018",     
                "052114", "052115", "052113", "081211", "081212", "021237", "090322", "060313", "080115", "161315", "021905", "101215", "219816",      
                "121913", "163808", "163809", "163807", "033401", "033407", "100920", "100921", "169317", "169309", "169310", "169307", "219817",     
                "033510", "162713", "162719", "030521", "022410", "162614", "038009", "037908", "100720", "210422", "210423", "210424", "062124", "020330", "145496",  
                "181219", "181220", "033714", "033814", "033914", "034014", "034114", "083109", "083110", "102313", "102312", "091113", "145497", "122519", "122522", 
                "080705", "080718", "051520", "020621", "975721", "211332", "079011", "079012", "083210", "083211", "040443", "083420", "035220",
                "050425", "148578", "213111", "213112", "210830", "210831", "092115",     
                "083212", "150312", "150313", "150210", "150211", "120215", "090828", "090819", "093009", "093010", "093011", "091314",
                "091315", "100320", "100321", "100322", "020122", "021328", "081017", "081019", "081008", "080124", "083411", "145414", "042014", "040130",  
                "083418", "083419", "040205", "040208", "092017", "040522", "040523", "040524", "900312", "900313", "900314", "083421", "036009", "036010", "036111", "036112",
                "148395", "148331", "148343", "148378", "148308", "148397", "148398", "148396", "148303", "051418", "051422", "022501",
                // ---------- 패션 분류 변경 일괄 빼기 ----------------
                "148203", "148206", "148211", "148212", "148215", "148224",
                "148229", "148293", "148231", "148232", "148233", "148234", "148235", "148571", "148569", "148570", "148568",
                "148315", "148316", "148319", "148624", "148325", "148326", "148328", "148330", "148573", "148576", "148504", "148575",
                "148333", "148335", "148401", "148402", "148418", "148431", "148409", "148413", "148572", "148577",
                "148420", "148426", "148423", "148424", "148427", "148404", "148429", "148430", "148432", "148433", "148434", "148435",
                "148506", "148520", "148522", "148523", "148524", "148525", "148580", "148579", "148581",
                "148526", "148529", "148530", "148531", "148532", "148534", "148535", "148324", "148238", "148239",
                "148241", "148242", "148236", "148237", "148336", "148337", "148337", "148340", "148339", "148341", "148342",
                "148422", "148417", "148439", "148440", "148441", "148405", "148338", "148412",
                "148246", "148249", "148243", "148244", "148245", "148564", "148566", "148567", "148565",
                "148345", "148347", "148344", "148346", "148349", "148348",
                "148443", "148444", "148445", "148446", "148447", "148448", "148449",
                "148507", "148511", "148527", "148582", "148583", "148584", 
                "148296", "148297", "148298", "148255", "148226", "148274", "148202", "148292", "148258", "148294", "148295",
                "148250","148251","148252","148213","148254",
                "148201","148355","148309","148354",
                "148266","148240","148207","148307","148327","148437","148457","148416","148408","148512","148533","148517","148537",
                "148356","148352","148329","148350","148301","148353",
                "148450","148451","148452","148453","148454","148455","148456",
                "148257","148256","148259","148260","148228","148262","148263","148219",
                "148360","148361","148362","148363","148357","148358","148359",
                "148436","148428","148458","148459","148460","148461","148462","148463","148464",
                "148503","148528","148253","148248","148227",
                "148265","148268","148267","148269","148270","148271","148272",
                "148225","148273","148275","148276","148277","148222",
                "148264","148323","148368","148369","148549","148550",
                "148370","148365","148366","148367","148465","148466",
                "148467","148468","148469","148470","148471","148472","148473","148474",
                "148407","148475","148476","148477","148478","148505","148539","148540",
                "148541","148542","148543","148544","148513","148545","148516","148546",
                "148547","148548",
                "148493","148494","148495","148496","148497","148498",
                "148558","148559","148560","148561","148518","148562","148563",
                "148386","148322","148387","148306","148389","148385","148392","148393","148394","148390","148317","148333","148391","148388","148302",
                "148223","148283","148284","148285","148286","148287","148288","148289","148290","148218","148291","148278","148279","148280","148281","148282",
                "148371","148377","148372","148376","148383","148381","148380","148379","148373","148382","148374","148384","148375",
                "148479","148480","148481","148482","148483","148484","148485","148486","148487","148488","148489","148490","148491","148492",
                "148551","148552","148553","148554","148555","148556","148514","148557",
                "148247","148208","148364","148314","148334",

                // ---------- 패션 분류 변경 일괄 빼기 ----------------
            })) { 
            } else {

                if(!pstrPastLcode.equals(ca_Lcode)) {  
                    menuMainHashMapKeys.add(ca_Lcode+"_Mcate");
                    menuMainHashMap.put(ca_Lcode+"_Mcate", new ArrayList());
                    if(ca_Mcode.length()>0) {
                        menuMainHashMapKeys.add(ca_Lcode+ca_Mcode+"_Scate");
                        menuMainHashMap.put(ca_Lcode+ca_Mcode+"_Scate", new ArrayList());
                    }
                } else if(!pstrPastMcode.equals(ca_Mcode)) {
                    if(ca_Mcode.length()>0) {
                        menuLocHashMap.put(ca_Lcode+ca_Mcode, c_location);
                        menuMainHashMapKeys.add(ca_Lcode+ca_Mcode+"_Scate");
                        menuMainHashMap.put(ca_Lcode+ca_Mcode+"_Scate", new ArrayList());
                    }
                }
                
                if(ca_code3.equals("030501")) { //통화요금비교(0309)
                    //((ArrayList)menuMainHashMap.get("03_Mcate")).add("09"+strSep+"통화요금비교"+strSep+"0309"+strSep+"0");
                    //menuMainHashMapKeys.add("0309_Scate");
                    //menuMainHashMap.put("0309_Scate", new ArrayList());
                } else if(ca_code3.equals("130101")) { //의류의  리바이스 예외.
                    ((ArrayList)menuMainHashMap.get("13_Mcate")).add("99"+strSep+"리바이스,빈폴,아베크..."+strSep+"1399"+strSep+"0");
                    menuMainHashMapKeys.add("1399_Scate");
                    menuMainHashMap.put("1399_Scate", new ArrayList());
                }
                if(c_name_2.trim().length()>0) {
                    if(pstrPastLcode.equals(ca_Lcode)) {
                        if(!pstrPastMcode.equals(ca_Mcode)) {
                            if((ca_Lcode.equals("08") && ca_Mcode.equals("11")) || (ca_Lcode.equals("12") && ca_Mcode.equals("06")) || (ca_Lcode.equals("09") && ca_Mcode.equals("14"))  || (ca_Lcode.equals("11") && ca_Mcode.equals("12"))  || (ca_Lcode.equals("11") && ca_Mcode.equals("18")) ) {
                                ((ArrayList)menuMainHashMap.get(ca_Lcode+"_Mcate")).add(ca_Mcode + strSep + "<b>"+c_name_2+"</b>" + strSep + ca_Lcode + ca_Mcode + strSep + c_location + strSep + c_knowbox_2);
                            } else if((ca_Lcode.equals("21") && ca_Mcode.equals("11")) || (ca_Lcode.equals("21") && ca_Mcode.equals("10"))) {
                                ((ArrayList)menuMainHashMap.get(ca_Lcode+"_Mcate")).add(ca_Mcode + strSep + c_name_2 + strSep + ca_Lcode + ca_Mcode + strSep + c_location + strSep + c_knowbox_2);
                            } else if(ca_Lcode.equals("14") && ca_Mcode.equals("09")) {
                                ((ArrayList)menuMainHashMap.get(ca_Lcode+"_Mcate")).add(ca_Mcode + strSep + "<font color=ff0000><b>" + c_name_2 + "</b></font>" + strSep + ca_Lcode + ca_Mcode + strSep + c_location + strSep + c_knowbox_2);
                            } else {
                                ((ArrayList)menuMainHashMap.get(ca_Lcode+"_Mcate")).add(ca_Mcode + strSep + c_name_2 + strSep + ca_Lcode + ca_Mcode + strSep + c_location + strSep + c_knowbox_2);
                            }
                        }
                        ((ArrayList)menuMainHashMap.get(ca_Lcode+ca_Mcode+"_Scate")).add(ca_Scode + strSep + c_name_3 + strSep + ca_Lcode + ca_Mcode + ca_Scode + strSep + c_location + strSep + c_knowbox_2);
                    } else if(!pstrPastLcode.equals(ca_Lcode)) {
                        if((ca_Lcode.equals("08") && ca_Mcode.equals("11")) ||(ca_Lcode.equals("12") && ca_Mcode.equals("06")) || (ca_Lcode.equals("09") && ca_Mcode.equals("14")) || (ca_Lcode.equals("21") && ca_Mcode.equals("12"))) {
                            ((ArrayList)menuMainHashMap.get(ca_Lcode+"_Mcate")).add(ca_Mcode + strSep + "<b>" + c_name_2 + "</b>" + strSep + ca_Lcode + ca_Mcode + strSep + c_location + strSep + c_knowbox_2);
                        } else {
                            ((ArrayList)menuMainHashMap.get(ca_Lcode+"_Mcate")).add(ca_Mcode + strSep + c_name_2 + strSep + ca_Lcode + ca_Mcode + strSep + c_location + strSep + c_knowbox_2);
                        }
                        ((ArrayList)menuMainHashMap.get(ca_Lcode+ca_Mcode+"_Scate")).add(ca_Scode + strSep + c_name_3 + strSep + ca_Lcode + ca_Mcode + ca_Scode + strSep + c_location + strSep + c_knowbox_2);

                    }
                }
                pstrPastLcode = ca_Lcode;
                pstrPastMcode = ca_Mcode;
                pstrPastScode = ca_Scode;
            }
        }

        // it 분류 일 경우 예외처리 98번
        /*
        String where_full=" where ca_code3 <> '070204' and ca_code3 <> '970207' and ca_code3 <> '034210' " +
            " and ca_code3 <> '030409' and ca_code3 <> '030410' and ca_code3 <> '020607' and ca_code3 <> '020925'" +
            " and ca_code3 <> '040808' and ca_code3 <> '040810' and ca_code3 <> '020816' and ca_code3 <> '070201' and ca_code3 <> '021221'" +
            " and ca_code3 <> '021514' and ca_code3 <> '211309' and ca_code3 <> '021211' and ca_code3 <> '021232' and ca_code3 <> '021231'" +
            " and ca_code3 <> '021511' and ca_code3 <> '040813' and ca_code3 <> '030105' and ca_code3 <> '021805' and ca_code3 <> '022507'" +
            " and ca_code3 <> '021206' and ca_code3 <> '071201' and ca_code3 <> '021902' and ca_code3 <> '021909' and ca_code3 <> '022508'" +
            " and ca_code3 <> '021910' and ca_code3 <> '211311' and ca_code3 <> '031901'" +     
            " and ca_code3 <> '022101' and ca_code3 <> '022111' and ca_code3 <> '040426' and ca_code3 <> '031914' and ca_code3 <> '031905'" + 
            " and ca_code3 <> '021515' and ca_code3 <> '020808' and ca_code3 <> '021907' and ca_code3 <> '030112' and ca_code3 <> '021806'" +  
            " and ca_code3 <> '971609' and ca_code3 <> '030428' and ca_code3 <> '972006' and ca_code3 <> '972103' and ca_code3 <> '031912'" +
            " and ca_code3 <> '972106' and ca_code3 <> '040432' "; 
        String order_by= " order by c_itsort, c_seqno2, c_seqno3";
        Category_Data[] category_it_data = Category_Proc.Category_It_List(where_full,order_by);
        pstrPastLcode = "";
        pstrPastMcode = "";
        pstrPastScode = "";
        menuMainHashMapKeys.add("98_Mcate");
        menuMainHashMap.put("98_Mcate", new ArrayList());
        for(int i=0; i<category_it_data.length; i++) {
            String ca_code2 = category_it_data[i].getCa_code().trim();
            String ca_code3 = category_it_data[i].getCa_code_2().trim();

            String ca_Lcode = ca_code2.substring(0,2);
            String ca_Mcode = ca_code2.substring(2,4);
            String ca_Scode = "00";
            if(ca_code3.length()>=6) {
                ca_Scode = ca_code3.substring(4,6);
            }
            String c_name_2 = category_it_data[i].getC_name().trim().replaceAll("\"","&#34;");
            String c_name_3 = category_it_data[i].getC_name_2().trim().replaceAll("\"","&#34;");
            String c_knowbox_2 = category_it_data[i].getC_knowbox().trim();
            String c_location = category_it_data[i].getC_location().trim();
            if(c_location.length()==0) c_location = "0";
            
            if(!pstrPastLcode.equals(ca_Lcode)) {
                if(ca_Mcode.length()>0) {
                    menuMainHashMapKeys.add(ca_Lcode+ca_Mcode+"98_Scate");
                    menuMainHashMap.put(ca_Lcode+ca_Mcode+"98_Scate", new ArrayList());
                }
            } else if(!pstrPastMcode.equals(ca_Mcode)) {
                if(ca_Mcode.length()>0) {
                    menuMainHashMapKeys.add(ca_Lcode+ca_Mcode+"98_Scate");
                    menuMainHashMap.put(ca_Lcode+ca_Mcode+"98_Scate", new ArrayList());
                }
            }
            if(c_name_2.trim().length()>0) {
                if(pstrPastLcode.equals(ca_Lcode)) {
                    if(!pstrPastMcode.equals(ca_Mcode)) {
                        if((ca_Lcode.equals("08") && ca_Mcode.equals("11")) || (ca_Lcode.equals("12") && ca_Mcode.equals("06")) || (ca_Lcode.equals("09") && ca_Mcode.equals("14"))  || (ca_Lcode.equals("11") && ca_Mcode.equals("12"))  || (ca_Lcode.equals("11") && ca_Mcode.equals("18")) ) {
                            ((ArrayList)menuMainHashMap.get("98_Mcate")).add(ca_Mcode + strSep + "<b>"+c_name_2+"</b>" + strSep + ca_Lcode + ca_Mcode + strSep + c_location + strSep + c_knowbox_2);
                        } else if((ca_Lcode.equals("21") && ca_Mcode.equals("11")) || (ca_Lcode.equals("21") && ca_Mcode.equals("10"))) {
                            ((ArrayList)menuMainHashMap.get("98_Mcate")).add(ca_Mcode + strSep + c_name_2 + strSep + ca_Lcode + ca_Mcode + strSep + c_location + strSep + c_knowbox_2);
                        } else if(ca_Lcode.equals("14") && ca_Mcode.equals("09")) {
                            ((ArrayList)menuMainHashMap.get("98_Mcate")).add(ca_Mcode + strSep + "<font color=ff0000><b>" + c_name_2 + "</b></font>" + strSep + ca_Lcode + ca_Mcode + strSep + c_location + strSep + c_knowbox_2);
                        } else {
                            ((ArrayList)menuMainHashMap.get("98_Mcate")).add(ca_Mcode + strSep + c_name_2 + strSep + ca_Lcode + ca_Mcode + strSep + c_location + strSep + c_knowbox_2);
                        }
                    }
                    ((ArrayList)menuMainHashMap.get(ca_Lcode+ca_Mcode+"98_Scate")).add(ca_Scode + strSep + c_name_3 + strSep + ca_Lcode + ca_Mcode+ca_Scode + strSep + c_location + strSep + c_knowbox_2);
                } else if(!pstrPastLcode.equals(ca_Lcode)) {
                    if((ca_Lcode.equals("08") && ca_Mcode.equals("11")) ||(ca_Lcode.equals("12") && ca_Mcode.equals("06")) || (ca_Lcode.equals("09") && ca_Mcode.equals("14")) || (ca_Lcode.equals("21") && ca_Mcode.equals("12"))) {
                        ((ArrayList)menuMainHashMap.get("98_Mcate")).add(ca_Mcode + strSep + "<b>" + c_name_2 + "</b>" + strSep + ca_Lcode + ca_Mcode + strSep + c_location + strSep + c_knowbox_2);
                    } else {
                        ((ArrayList)menuMainHashMap.get("98_Mcate")).add(ca_Mcode + strSep + c_name_2 + strSep + ca_Lcode + ca_Mcode + strSep + c_location + strSep + c_knowbox_2);
                    }
                    ((ArrayList)menuMainHashMap.get(ca_Lcode+ca_Mcode+"98_Scate")).add(ca_Scode + strSep + c_name_3 + strSep + ca_Lcode + ca_Mcode + ca_Scode + strSep + c_location + strSep + c_knowbox_2);
                }
            }
            pstrPastLcode = ca_Lcode;
            pstrPastMcode = ca_Mcode;
            pstrPastScode = ca_Scode;
        }
        */
        // 추가 분류의 경우 분류 데이터를 입력
        for(int i=0; i<menuMainHashMapKeys.size(); i++) {
            String keyTemp = (String)menuMainHashMapKeys.get(i);
            ArrayList tempAryList = (ArrayList)menuMainHashMap.get(keyTemp);

            if(keyTemp!=null) {
                // 노트북 일 경우의 추가 분류
                if(keyTemp.indexOf("0404_")>-1) {
                    for(int j=0; j<tempAryList.size(); j++) {
                        if(menuMainHashMap.containsKey("9417_Scate")) {
                            ((ArrayList)menuMainHashMap.get("9417_Scate")).add(tempAryList.get(j).toString());
                        }
                    }
                }
                // 커피용품 일 경우의 추가 분류
                if(keyTemp.indexOf("0606_")>-1) {
                    for(int j=0; j<tempAryList.size(); j++) {
                        if(menuMainHashMap.containsKey("1697_Scate")) {
                            ((ArrayList)menuMainHashMap.get("1697_Scate")).add(tempAryList.get(j).toString());
                        }
                    }
                }
                // 신종플루예방 일 경우의 추가 분류
                //if(keyTemp.indexOf("0523_")>-1) {
                //  for(int j=0; j<tempAryList.size(); j++) {
                //      if(menuMainHashMap.containsKey("1696_Scate")) {
                //          ((ArrayList)menuMainHashMap.get("1696_Scate")).add(tempAryList.get(j).toString());
                //      }
                //  }
                //}
                // 무전기 일 경우의 추가 분류
                if(keyTemp.indexOf("0305_")>-1) {
                    for(int j=0; j<tempAryList.size(); j++) {
                        if(menuMainHashMap.containsKey("0309_Scate")) {
                            ((ArrayList)menuMainHashMap.get("0309_Scate")).add(tempAryList.get(j).toString());
                        }
                    }
                }
                // 회사용품 모음 일 경우의 추가 분류
                if(keyTemp.indexOf("1890_")>-1) {
                    for(int j=0; j<tempAryList.size(); j++) {
                        if(menuMainHashMap.containsKey("0491_Scate")) {
                            ((ArrayList)menuMainHashMap.get("0491_Scate")).add(tempAryList.get(j).toString());
                        }
                    }
                }
            }
        }
 
        // 묶음 카테
        // 묶음 카테 시작
        String PStartCate = "103001,103006,050613,101205,038016,035953,164213,164216,164209,164312,164301,164409,164505,164511,164602,053007,164609,092003,051116,101401,101422,101417,975005,061113,210904,182201,182205,181409,145510,021128,050105,030401,040102,040103,040303,050716,050711,040817,040902,040908,040907,161312," +
        "060202,070511,070224,070402,070801,070804,120211,120204,120116,120111,130603,130612,130702,130708,163110,022217,022214,169311," +
        "980301,050209,091406,091402,111506,091212,111408,031803,031814,031314,031902,031906,161213,121902,169304,060907,220610,220511," +
        "071002,071004,070301,070304,034202,034208,030701,030203,120501,120521,091803,060908,051017,050414,052601,090310,051501,041020," +
        "040308,071103,071108,070207,111012,111005,090601,111411,081406,081404,020810,020819,110901,110907,051802,220105,220802,220808,220802," +
        "981701,981704,981110,980602,060308,051111,181102,061001,181805,090115,210121,122001,122005,101201,163805,060601,080404," +
        "980801,980502,081602,081606,100511,100702,111301,120402,181104,981003,071302,071304,101109,022701,100708,035209,035205,035322,035523,035416,035702,035708,035416,035802,035805," +
        "120406,110801,020310,021701,021704,060110,051314,040823,981712,060621,100102,211328,060813,100415,021902,150802,122512,122610,122801,122805,122704," +
        "071401,071403,020405,980901,981402,111707,091302,091306,051619,102003,211510,181312,181301,021908,092318,092321," +
        "061901,980807,071202,981802,981907,981909,982003,211316,160201,161201,091809,211715,101108,080405,122520,122523," +
        "062001,060401,060514,091902,040607,162401,162403,060701,181702,181709,060113,102009,212202,022610,163812,082609,150501,150601," +
        "162501,090901,981521,981501,121301,121307,981204,100807,022001,022010,162101,162602,162601,022301,070213,091103,040711,145410,220320,220709,220713," +
        "162801,100408,100410,120812,120824,211414,091502,091505,091609,091612,163212,163214,189002,189010,021405,976303,976307,212004," + 
        "160604,162308,162001,101505,162906,020409,211611,100703,980517,092512,092505,180202,020922,100303,051914,"+
        "091421,091430,020303,162704,162705,980804,090328,022116,210118,211601,147612,021522,087809,083414,083405,092113,092101,"+
        "981603,971603,070701,070703,060508,100103,092403,093102,030424,092402,101014,090407,210608,150302,150306,"+
        "163701,163707,160801,160805,160803,080707,080706,972104,972107,087802,080225,070609,070613,082501,082505,212601,212603,042001,"+
        "051109,022003,161101,181201,032812,032805,122101,122105,122109,050601,160302,160508,211322,083201,083203,083206,"+
        "033201,033205,041811,061015,086603,086606,052701,052710,030432,060214,052605,163505,162011,060314,181811,093201,"+
        "163712,082801,082804,180802,180804,081309,021225,102301,102305,079001,079007,164511,061109,093002,122514,212005,210809,210819,"+
        "180301,120703,052101,052102,070106,070119,020309,020321,180207,180205,975002,161107,150202,150203,080903,219824,219808,"+
        "081202,081210,033402,033408,100918,100919,033501,030551,162714,162720,082604,162610,062119,062132,020804,021902,021908,"+
        "038010,037909,037915,210421,210402,210409,181213,181216,169315,083102,083106,070504,120301,120305,020623,100308,100301,180806,020823,"+
        "100311,060818,062105,080121,083401,083405,083409,040209,040201,040512,040510,040509,181209,161314,145401,145418,213101,213105,"+
        "900309,070903,070905,051419,052702,021131,051420,060802,060522,040418,022509,030554,041403,083420,083416,036117,036114,036001,036004,031803,031814"; 
   
        // 묶음 카테 처리
        String PAllCate = "103001,103002,103003,103006,103007,103008,101422,101423,101417,101424,101425,122520,122521,122523,122506,050613,050620,101205,101216,037915,037916,037917,037918,164511,164512,164513,035953,035948,082604,082615,060802,060801,035949,035937,051914,051925,164213,164214,164215,164216,164217,164218,164209,164221,164312,164302,164301,164315,164409,164402,164410,164407,164415,164503,164505,164502,164504,164511,164512,164513,164602,164605,053007,053008,053009,164609,164610,164613,122512,122509,122514,122507,122704,122712,122705,122709,122610,122611,122801,122802,122805,122813,122806,092302,092303,092318,092319,092320,092321,092003,092022,092023,092021,051116,051105,103001,083414,083415,083405,083406,083407,181805,181802,181804,181803,101401,101415,101416,975005,975003,975018,975019,050711,050712,050713,050714,061120,061113,061115,210904,210912,182201,182202,182203,182204,182212,182205,182206,182207,182208,182209,181415,181409,181402,181410,181407,145510,145511,145512,145513,120301,120312,062132,090317,021128,021130,021131,021132,121301,121314,121302,121303,121316,121311,121307,145410,181301,181315,145411,145413,041403,041408,040418,040419,040421,040427," +
        "050104,050105,050120,030401,030403,030405,040102,040103,040106,040107,093102,093103,093104,040817,163212,070504,070507,030434,150802,150809,087809,087810,087811," +
        "040823,040824,040811,040809,040902,040903,040820,040905,040908,040909,040910,040907,040906,060202,060220,060224,060204,062001,041020,041021,041003,041021,060813,060820," +
        "070402,070411,070403,070404,070511,120824,120811,120820,070510,070224,070202,070216,070203,070801,070802,070803,070804,062002,062003,090115,090121,150602,150601,021902,021903,021904,021908,021909,021910," + 
        "070805,070806,210608,210609,210610,210611,120211,120212,120203,120204,120214,120513,120116,050102,120109,120110,060508,060504,150501,150512,150510,220320,220321,220303,220709,220710,220711,220713,220714," +
        "120111,120112,130603,130604,130610,130612,130613,130614,130615,130702,130703,130704,130705,130706,130708,130709,130710,980301,031306,220105,220127,220802,220801,220803,220805,220812,220808,220813,220815,220816,220802,220801,220803,220805,220812," +
        "980303,980305,020308,020310,020301,020318,050209,050210,981005,981004,981006,210118,031314,031316,031309,031320,093201,093211,093212," +
        "050211,050212,091406,091407,091402,111506,111507,051620,051619,090325,090310,062132,062133,062134,062103,062120,062119,035205,035219,035209,035212,035210,035211,035216,035213,035322,035321,035323,035327,035304,035523,035519,035520,035416,035417,035418,035419,035702,035703,035704,035708,035709,035710,035802,035817,035805,035803,035818,035819," +
        "060503,111408,111409,111410,040303,040305,040302,982003,982004,982005,051002,051017,051004,051018,211513,211514,161215,034212,212005,212004," +
        "071002,071003,071007,071008,071004,162602,162616,162601,162615,981603,981604,981605,091103,091112,083416,083417,083404,220610,220601,220602,220603,220511,220519," + 
        "070301,070302,070311,070309,070304,070305,070310,034203,034201,090328,034205,030701,030702,030203,030204,040308,040309,071005,021522,021523,021524,021525,021526,021527" +
        "071103,071104,071105,071115,071113,071112,071108,071109,070207,070208,111012,111013,111005,111014,111006,111007,090601,090602,090610," +
        "111411,111412,081406,081407,081401,081402,081405,081404,081408,110901,110902,110903,110905,110906,110907,211322,211323,211324,211325," +
        "110911,110908,091212,091213,981701,981707,071202,071203,071204,071205,071206,981907,981908,981909,981902,981903,980510,980517," +
        "981711,981704,981709,981110,981111,981103,981802,981803,981804,981804,981805,981806,181713,181709,181710,181702,181705,163801,163812,163802,163805,163813,163806," +
        "211316,211308,120812,120828,120816,980602,980603,980604,981408,060113,060114,060115,100715,093002,093003,093004,060601,060629,060606,060626,060622," + 
        "021206,980801,980824,980802,980808,980806,980501,980502,981202,981204,981212,980820,980822,100103,100101,092403,092411,161310," +
        "081602,081603,081604,081606,081607,211412,211413,211414,211415,210116,030431,030432,030410,041810,080404,080418,080903,080908,080916," +
        "081602,081603,081604,081606,081607,100511,100512,100508,100513,100514,181102,181103,032812,060311,060314,060304,040720,040711,040719," +
        "111312,111301,120402,120403,120404,120410,120406,120407,120408,120409,110801,110802,110803,110804,110805,021701,211715,211716,211717," +
        "021702,021703,021704,021705,060110,161309,161312,080405,080409,080410,020822,020823,020825,051410,051409,051419,051420,051421," +
        "060108,060109,120113,051302,051313,051314,051308,071110,040812,040803,981712,981703,071401,071402,071403,071406,071404,100408,100417,100412,100401,100418,100410,100404," +
        "020405,020406,980901,980902,980903,980904,981407,981402,120114,211510,211511,211512,211513,211515,211514,051303,219824,219809,219810,219808,219803,219823," +
        "981406,120411,111707,111709,071111,181104,181105,181106,163110,163111,101201,101213,145401,145416,145417,145415,145418,145402," +
        "091302,091303,091304,091306,091307,091308,050705,050707,050716,051802,051803,060308,060309,060310,181811,181812,181813,060907,060914," +
        "120521,120504,120522,120501,120502,120518,120516,091803,091804,060908,060912,060909,060910,061901,061902,061903,061904,980807,980804," +
        "160201,160205,161201,161203,161204,161207,161213,161214,051111,051112,051103,060401,060404,060402,060405,060501,060514,060515,160604,160612,980823," +
        "091901,091902,091911,040607,040603,971603,971604,971605,971611,160605,160610,100415,100419,100403,082609,082605,042001,042002,042003,060525," +
        "162401,162402,162412,162403,162404,060701,060712,060617,060621,060610,060611,061001,061002,061018,061004,061013,162501,162502,162505,162504,090901,090902,090903," +
        "162101,162102,162308,162315,162001,162002,162004,162006,162008,101513,101505,101506,162905,162906,162911,162907,"+
        "981527,981501,981517,981518,981519,981521,981522,100807,100808,062009,090407,090408,090405,070213,070220,040512,040504,040510,040503,040509,040501," +
        "022001,022016,022002,162801,162802,162803,091809,091810,210121,210102,210114,210120,022116,022117,022118,022119,100303,100316,100317,022008,020315," +
        "091501,091502,091516,091512,091505,091506,091608,091609,091619,091612,091605,180816,180806,180810,210809,210806,210819,210821," +
        "071301,071315,071302,071303,071304,091427,091428,181312,181302,092113,092112,092114,092101,092108,092102,092103,213101,213103,213104,213105,213106,213107," + 
        "020303,020312,020313,091430,091513,091617,162701,162702,162703,162704,162705,100102,100115,100110,101512,100114," +
        "162707,163202,163201,163203,163210,163204,163211,163214,163213,090308,090318,090319,090320,981003,162708,162610,162613,080618,"  +
        "189002,189003,189004,189010,189011,189012,189014,211601,211602,981012,020409,020410,211611,211613,091914,030424,030425,030426,030427," +
        "092512,092502,092503,092504,092506,092505,092508,147612,147613,210620,210617,210608,"+
        "180202,180209,180206,070701,070702,070703,070704,070705,070710,050414,050402,050405,022214,022215,022216,022217,022218,022219,022220,033501,033502,033503,033504,033505,"+
        "031814,031812,031802,031803,031808,031816,031810,022003,022014,101014,101015,101002,022301,022302,022303,162714,162715,162716,162717,162718,"+
        "092414,092402,092408,020921,020922,020923,020904,100703,100707,100722,100702,100712,100708,100713,022601,022610,022602,022603,162720,162721,162722,162723,162724,"+
        "102001,102002,102003,102004,102012,102008,102009,102013,122001,122002,122003,122004,122005,122006,122007,122010,101108,101117,101111,"+
        "031902,031904,031906,031907,031908,031909,031910,022005,052601,052618,052604,052617,212202,212203,121902,121903,121905,120305,120306,"+ 
        "101110,101109,101114,101118,022010,022011,022012,091618,061109,061101,061117,976303,976304,976305,"+
        "163701,163702,163703,163704,163705,163707,163708,163709,087802,087803,087804,087805,087806,087807,080225,080230,,976307,976308,976309,900309,900310,900311,"+
        "160801,160810,160805,160802,160809,160803,160806,080707,080722,080706,080711,080702,972104,972105,972109,972107,972108,"+
        "070609,070610,070611,070613,070614,052501,082501,082502,082503,082505,082506,082507,212601,212602,212603,212604,212605,"+
        "022701,022702,022703,022704,022705,022706,022707,022708,022709,051109,051107,161101,161102,161103,083102,083103,083104,"+
        "181201,181208,181202,181212,032801,032802,032803,032805,032806,031903,122101,122102,122103,122105,122106,122107,122109,122110,122111,"+
        "050602,050601,050610,160302,160306,160303,160311,"+
        "160508,160515,020927,033201,033202,033203,033204,033205,033206,033207,033414,162726,210404,210421,210401,210402,210404,210409,210408,210416,060522,060523,"+
        "041811,041803,041804,041805,061015,061011,086603,086604,086606,086607,086608,161107,161113,083106,083107,083108,"+
        "052701,052703,052702,052715,052714,052710,052711,052709,060214,060215,060216,052605,052606,163505,163511,163508,163509,162011,162012,"+
        "163712,163706,034208,034216,034215,034213,034202,082801,082802,082803,082804,082805,082806,082807,180802,180803,162014,150202,150208,150203,150209,"+
        "180804,180811,180813,180805,081309,081302,021225,021226,021246,032813,051501,051502,051504,051505,150302,150310,"+
        "180301,180302,180313,180303,180312,120703,120706,120704,120705,020309,020319,020321,020322,020820,150311,150306,150309,"+
        "052101,052105,052102,052112,070102,070103,070106,070109,070120,070121,070122,070119,070123,020810,020817,020801,020819,020820,"+
        "180206,180207,180205,180211,180216,081202,081209,081206,081207,081210,030554,030555,030556,036117,036118,036119,036120,036114,036115,036116,036001,036002,036003,036004,036005,031803,031802,031808,031810,031816,031814,031812,"+
        "975002,975017,033402,033403,033404,033405,033406,033408,033409,033410,033411,033412,100918,100904,100914,100913,100919,100905,"+
        "169315,169316,169301,169304,169305,030551,030552,030553,030524,169311,169312,169313,169314,211328,211329,211331,"+
        "038010,038027,038011,038021,038012,038013,038014,038015,038016,038017,038018,038019,038021,100926,100925,021902,021903,021904,021908,021909,021910,"+ 
        "037909,037910,037914,975713,037911,037912,037913,037916,037915,037918,037917,020619,020623,020620,022509,022512,022510,022511,022516,022513,"+ 
        "021405,021427,181213,181214,181215,181216,181217,181218,102301,102302,102303,102308,102305,102310,052117,052103,052118,100324,100323,040422,040442,"+
        "079001,079002,079003,079004,079005,079006,079007,079008,079009,083201,083202,083203,083204,083205,083206,083207,083208,020804,"+
        "100320,100308,100307,100301,100310,100311,100312,060818,060803,062105,062125,062125,080120,080121,080122,"+
        "083401,083402,083403,083405,083406,083407,083409,083410,040210,040220,040209,040206,040203,040201,040202,181222,181209,181221,161314,161315,161307,070903,070906,070901,070908,070905,070902,070910,070904";  
        
        // 인기마크 붙이는 카테고리  
        String ingiCate = "092007,038110,051603,068002,038026,037922,037909,035333,038206,038211,035512,068004,093111,040131,093107,092019,050501,030501,210302,219603,020103,069204,051510,050305,030429,150711,042012," + 
            "160201,070202,211313,120701,102204,211723,100102,090822,090823,030448,220802," + 
            "022113,034505,052609,062117,051418,060308,053001,034520,"+ 
            "210410,211316,120205,031303,050202,060110,101014,030417,210813,040528,"+
            "100903,211601,050702,061004,041411,040446,050621,040823,031811,"+
            "091512,090503,031902,060202,060501,093006,093002,020120,"+ 
            "091802,050801,051309,102409,022514,091430,020933,030552,090402,090712,"+
            "090910,092603,092001,150105,030525,060918,060903,020130,"+
            "091612,091902,092313,090319,090302,181312,034202,051920,051003,092510,"+
            "062121,038009,037920,037909,091311,021125,040129,092318,"+
            "021715,071304,040403,071013,070511,070701,020120,036015,030520,061104,093211,093212"; 
                 
  
        // 묶음 카테 이름 정의   
        HashMap groupCateHash = new HashMap();
        groupCateHash.put("050613", "050621"+strSep+"<ingi1>에어워셔<ingi2>"+strSep+"2");
        groupCateHash.put("145401", "145496"+strSep+"여성화"+strSep+"4");
        groupCateHash.put("145418", "145497"+strSep+"남성화"+strSep+"2");
        groupCateHash.put("219824", "219816"+strSep+"겨울철 차량 점검"+strSep+"3");
        groupCateHash.put("219808", "219817"+strSep+"눈길 안전 운전"+strSep+"3");
        groupCateHash.put("082604", "082614"+strSep+"기초소품"+strSep+"2");
        groupCateHash.put("164511", "164514"+strSep+"크리스마스 트리"+strSep+"3");
        groupCateHash.put("060802", "060823"+strSep+"전기 프라이팬"+strSep+"2");
        groupCateHash.put("035953", "035941"+strSep+"MP3"+strSep+"4");
        groupCateHash.put("093201", "093213"+strSep+"랜턴,라이팅"+strSep+"3");
        groupCateHash.put("036117", "036111"+strSep+"DSLR"+strSep+"4");
        groupCateHash.put("036114", "036121"+strSep+"미러리스용"+strSep+"3");
        groupCateHash.put("036001", "036009"+strSep+"이어폰"+strSep+"3");
        groupCateHash.put("036004", "036010"+strSep+"헤드폰"+strSep+"2");
        groupCateHash.put("031803", "031801"+strSep+"블루투스셋"+strSep+"5");
        groupCateHash.put("031814", "031809"+strSep+"블루투스 스피커"+strSep+"2");
        groupCateHash.put("164213", "164219"+strSep+"애견용품"+strSep+"3");
        groupCateHash.put("164216", "164220"+strSep+"고양이용품"+strSep+"3");
        groupCateHash.put("164209", "164222"+strSep+"관상어용품"+strSep+"2");
        groupCateHash.put("164312", "164314"+strSep+"건반악기"+strSep+"2");
        groupCateHash.put("164301", "164316"+strSep+"기타(Guitar)"+strSep+"2");
        groupCateHash.put("164409", "164413"+strSep+"프라모델,모형"+strSep+"5");
        groupCateHash.put("164505", "164515"+strSep+"파티"+strSep+"4");
        groupCateHash.put("164602", "164606"+strSep+"망원경"+strSep+"2");
        groupCateHash.put("164609", "164612"+strSep+"쌍안경"+strSep+"3");
        groupCateHash.put("053007", "053005"+strSep+"인기제조사"+strSep+"3");
        groupCateHash.put("021902", "021901"+strSep+"탁상용"+strSep+"3");
        groupCateHash.put("035209", "035201"+strSep+"제조사별"+strSep+"6");
        groupCateHash.put("035205", "035220"+strSep+"렌즈,액세서리"+strSep+"2");
        groupCateHash.put("035322", "035325"+strSep+"제조사별"+strSep+"5");
        groupCateHash.put("035523", "035521"+strSep+"화질별"+strSep+"3");
        groupCateHash.put("035416", "035401"+strSep+"제조사별"+strSep+"4");
        groupCateHash.put("035702", "035701"+strSep+"탁상용"+strSep+"3");
        groupCateHash.put("035708", "035705"+strSep+"휴대용"+strSep+"3");
        groupCateHash.put("035802", "035815"+strSep+"TV,AV"+strSep+"2");
        groupCateHash.put("035805", "035820"+strSep+"스마트홈"+strSep+"4");
        groupCateHash.put("050711", "050715"+strSep+"재봉틀"+strSep+"4");
        groupCateHash.put("182201", "182210"+strSep+"필기류"+strSep+"5");
        groupCateHash.put("182205", "182211"+strSep+"화방용품"+strSep+"5");
        groupCateHash.put("022509", "022501"+strSep+"제조사별"+strSep+"6");
        groupCateHash.put("040418", "040443"+strSep+"화면 크기별"+strSep+"6");
        groupCateHash.put("161314", "161315"+strSep+"전구"+strSep+"2");
        groupCateHash.put("181209", "181222"+strSep+"관상어용품"+strSep+"2");
        //groupCateHash.put("021518", "021511"+strSep+"블루레이,DVD,DivX"+strSep+"5");
        groupCateHash.put("021522", "021528"+strSep+"타이틀"+strSep+"6");
        groupCateHash.put("020810", "020816"+strSep+"홈시어터"+strSep+"3");
        groupCateHash.put("020819", "020818"+strSep+"HiFi"+strSep+"2");
        groupCateHash.put("034202", "034210"+strSep+"메모리카드"+strSep+"5");
        groupCateHash.put("092318", "092316"+strSep+"남성의류"+strSep+"3");
        groupCateHash.put("092321", "092317"+strSep+"여성의류"+strSep+"3");
        groupCateHash.put("034208", "034214"+strSep+"카드리더"+strSep+"4");
        groupCateHash.put("021128", "021133"+strSep+"공간별"+strSep+"2");
        groupCateHash.put("021131", "021134"+strSep+"용도별"+strSep+"2");
        groupCateHash.put("051914", "051924"+strSep+"미니가습기"+strSep+"2");
        groupCateHash.put("050105", "050111"+strSep+"가정용"+strSep+"4");
        groupCateHash.put("030401", "030409"+strSep+"통신사"+strSep+"3");
        //groupCateHash.put("030446", "030447"+strSep+"무약정"+strSep+"2");
        groupCateHash.put("040102", "040110"+strSep+"사무용PC"+strSep+"2");
        groupCateHash.put("040103", "040111"+strSep+"게임용PC"+strSep+"2");
        groupCateHash.put("040303", "040307"+strSep+"일반스캐너"+strSep+"3");
        groupCateHash.put("040817", "040819"+strSep+"휴대용"+strSep+"3");
        groupCateHash.put("040902", "040911"+strSep+"브랜드PC"+strSep+"3" );
        groupCateHash.put("040908", "040912"+strSep+"조립PC"+strSep+"3");
        groupCateHash.put("040907", "040913"+strSep+"형태별"+strSep+"2");
        groupCateHash.put("060202", "060221"+strSep+"가정용"+strSep+"4");
        groupCateHash.put("060214", "060217"+strSep+"인기브랜드"+strSep+"3");
        groupCateHash.put("070511", "070509"+strSep+"그래픽카드(VGA)"+strSep+"2");
        groupCateHash.put("070224", "070204"+strSep+"외장하드"+strSep+"4");
        groupCateHash.put("070402", "070401"+strSep+"PC스피커"+strSep+"4");
        groupCateHash.put("070301", "070307"+strSep+"데스크탑용"+strSep+"4");
        groupCateHash.put("070304", "070308"+strSep+"노트북용"+strSep+"3");
        groupCateHash.put("070801", "070809"+strSep+"인텔 CPU용"+strSep+"3");
        groupCateHash.put("070804", "070810"+strSep+"AMD CPU용"+strSep+"3");
        groupCateHash.put("071002", "071009"+strSep+"마우스"+strSep+"4");
        groupCateHash.put("071004", "071010"+strSep+"키보드"+strSep+"2");
        groupCateHash.put("120211", "120201"+strSep+"침대"+strSep+"3");
        groupCateHash.put("120204", "120216"+strSep+"매트리스"+strSep+"2");
        groupCateHash.put("120116", "120101"+strSep+"TV 거실장"+strSep+"2");
        groupCateHash.put("120111", "120104"+strSep+"소파"+strSep+"5");
        groupCateHash.put("212005", "212018"+strSep+"정리함/홀더/포켓"+strSep+"2");
        groupCateHash.put("111408", "111404"+strSep+"여행가방"+strSep+"3");
        groupCateHash.put("130603", "130602"+strSep+"인기 브랜드"+strSep+"3");
        groupCateHash.put("130702", "130701"+strSep+"임부복"+strSep+"5");
        groupCateHash.put("130708", "130707"+strSep+"빅사이즈"+strSep+"3");
        groupCateHash.put("130612", "130606"+strSep+"인기 아이템"+strSep+"3");
        groupCateHash.put("050209", "050208"+strSep+"드럼세탁기"+strSep+"3");
        groupCateHash.put("091406", "091405"+strSep+"아디다스"+strSep+"2");
        groupCateHash.put("091402", "091401"+strSep+"나이키"+strSep+"3");
        groupCateHash.put("111506", "091405"+strSep+"아디다스"+strSep+"2");
        groupCateHash.put("030701", "030707"+strSep+"복합기"+strSep+"2");
        groupCateHash.put("030203", "030202"+strSep+"복합기"+strSep+"2");
        groupCateHash.put("040308", "040304"+strSep+"복합기"+strSep+"2");
        groupCateHash.put("071103", "071101"+strSep+"케이스"+strSep+"5");
        groupCateHash.put("071108", "071102"+strSep+"파워서플라이"+strSep+"5");
        groupCateHash.put("070207", "070201"+strSep+"HDD"+strSep+"2");
        groupCateHash.put("111012", "111011"+strSep+"벨트"+strSep+"2");
        groupCateHash.put("111005", "111009"+strSep+"지갑"+strSep+"4");
        groupCateHash.put("090601", "090608"+strSep+"인라인 스케이트"+strSep+"3");
        groupCateHash.put("111411", "111401"+strSep+"정장가방"+strSep+"2");
        groupCateHash.put("081406", "081411"+strSep+"1차 세안용"+strSep+"5");
        groupCateHash.put("081404", "081412"+strSep+"2차 세안용"+strSep+"2");
        groupCateHash.put("110901", "110909"+strSep+"여성용"+strSep+"5");
        groupCateHash.put("110907", "110910"+strSep+"남성용"+strSep+"2");
        groupCateHash.put("020310", "020306"+strSep+"HiFi"+strSep+"4");
        groupCateHash.put("081602", "081601"+strSep+"형태별"+strSep+"3");
        groupCateHash.put("081606", "081605"+strSep+"두께별"+strSep+"2");
        groupCateHash.put("100511", "100506"+strSep+"국산분유"+strSep+"5");
        groupCateHash.put("100703", "100701"+strSep+"일회용 기저귀"+strSep+"2");
        groupCateHash.put("100702", "100719"+strSep+"국내브랜드"+strSep+"4");
        groupCateHash.put("100708", "100720"+strSep+"해외브랜드"+strSep+"2");
        groupCateHash.put("102003", "102010"+strSep+"형태별"+strSep+"5");
        groupCateHash.put("102009", "102011"+strSep+"인기브랜드"+strSep+"3");
        groupCateHash.put("111301", "111310"+strSep+"여성화"+strSep+"2");
        groupCateHash.put("120402", "120401"+strSep+"유아가구"+strSep+"5");
        groupCateHash.put("120406", "120405"+strSep+"아동가구"+strSep+"4");
        groupCateHash.put("110801", "110808"+strSep+"재질"+strSep+"5");
        groupCateHash.put("091212", "091215"+strSep+"트레이닝복"+strSep+"2");
        groupCateHash.put("021701", "021709"+strSep+"이어폰"+strSep+"3");
        groupCateHash.put("021704", "021710"+strSep+"헤드폰"+strSep+"2");
        groupCateHash.put("051116", "051117"+strSep+"여성용"+strSep+"2");
        groupCateHash.put("051314", "051309"+strSep+"<ingi1>도어록<ingi2>"+strSep+"5");
        groupCateHash.put("040823", "040818"+strSep+"가정용"+strSep+"5");
        groupCateHash.put("150802", "150815"+strSep+"초콜릿,사탕,DIY"+strSep+"2");
        groupCateHash.put("020405", "020402"+strSep+"라디오"+strSep+"2");
        groupCateHash.put("111707", "111710"+strSep+"우산,양산"+strSep+"2");
        groupCateHash.put("091302", "091301"+strSep+"남성의류"+strSep+"3");
        groupCateHash.put("091306", "091305"+strSep+"여성의류"+strSep+"3");
        groupCateHash.put("050716", "050702"+strSep+"<ingi1>스팀다리미<ingi2>"+strSep+"3");
        groupCateHash.put("051802", "051801"+strSep+"학습용 스탠드"+strSep+"2");
        groupCateHash.put("060308", "060307"+strSep+"식기세척기"+strSep+"3");
        groupCateHash.put("060314", "060302"+strSep+"살균건조기"+strSep+"3");
        groupCateHash.put("120501", "120512"+strSep+"책상"+strSep+"4");
        groupCateHash.put("120521", "120523"+strSep+"<ingi1>책장<ingi2>"+strSep+"3");
        groupCateHash.put("091803", "091806"+strSep+"오토바이"+strSep+"2");
        groupCateHash.put("060908", "060911"+strSep+"인기브랜드"+strSep+"4");
        groupCateHash.put("060907", "060915"+strSep+"스탠드형"+strSep+"2");
        //groupCateHash.put("060903", "060918"+strSep+"<ingi1>뚜껑식<ingi2>"+strSep+"2");
        groupCateHash.put("061901", "061911"+strSep+"찻잔,머그컵"+strSep+"4");
        groupCateHash.put("071202", "071201"+strSep+"형태별"+strSep+"5");
        groupCateHash.put("211316", "211309"+strSep+"거치형"+strSep+"2");
        groupCateHash.put("160201", "160204"+strSep+"전동공구"+strSep+"2");
        groupCateHash.put("161201", "161211"+strSep+"찻잔,컵"+strSep+"5");
        groupCateHash.put("161213", "161212"+strSep+"와인용품"+strSep+"2");
        groupCateHash.put("051111", "051108"+strSep+"전기면도기"+strSep+"3");
        groupCateHash.put("051619", "051621"+strSep+"<ingi1>온수매트<ingi2>"+strSep+"2");
        groupCateHash.put("181102", "181101"+strSep+"학습용스탠드"+strSep+"2");
        groupCateHash.put("181104", "181111"+strSep+"인테리어 스탠드"+strSep+"3");
        groupCateHash.put("062001", "062007"+strSep+"음식물 처리기"+strSep+"4");
        groupCateHash.put("060401", "060405"+strSep+"작동 방식"+strSep+"3");
        groupCateHash.put("060514", "060501"+strSep+"<ingi1>가스레인지<ingi2>"+strSep+"3");
        groupCateHash.put("091902", "091907"+strSep+"운동화"+strSep+"4");
        groupCateHash.put("040607", "040608"+strSep+"액세서리"+strSep+"2");
        groupCateHash.put("162401", "162409"+strSep+"냄비"+strSep+"3");
        groupCateHash.put("162403", "162410"+strSep+"후라이팬"+strSep+"2");
        groupCateHash.put("060701", "060711"+strSep+"믹서기"+strSep+"2");
        groupCateHash.put("060621", "060627"+strSep+"에스프레소추출"+strSep+"4");
        groupCateHash.put("162501", "162508"+strSep+"세탁 세제,비누"+strSep+"4");
        groupCateHash.put("090901", "090910"+strSep+"수영복"+strSep+"3");
        groupCateHash.put("100807", "100809"+strSep+"침구,매트"+strSep+"2");
        groupCateHash.put("022001", "022007"+strSep+"마이크"+strSep+"5");
        groupCateHash.put("022010", "022013"+strSep+"방송음향기기"+strSep+"3");
        groupCateHash.put("162801", "162809"+strSep+"한식기"+strSep+"3");
        groupCateHash.put("091809", "091802"+strSep+"<ingi1>스쿠터<ingi2>"+strSep+"2");
        groupCateHash.put("100408", "100409"+strSep+"유모차"+strSep+"4");
        groupCateHash.put("100415", "100403"+strSep+"아기띠,망토,워머"+strSep+"3");
        groupCateHash.put("100410", "100411"+strSep+"<ingi1>카시트<ingi2>"+strSep+"3");
        groupCateHash.put("120812", "120818"+strSep+"요,이불"+strSep+"3");
        groupCateHash.put("120824", "120823"+strSep+"여름침구"+strSep+"3");
        groupCateHash.put("090115", "090108"+strSep+"스키,보드복"+strSep+"2" );
        groupCateHash.put("211414", "211417"+strSep+"시트커버"+strSep+"4");
        groupCateHash.put("091502", "091509"+strSep+"운동화"+strSep+"4");
        groupCateHash.put("091505", "091510"+strSep+"의류"+strSep+"3");
        groupCateHash.put("091609", "091614"+strSep+"운동화"+strSep+"4");
        groupCateHash.put("091612", "091615"+strSep+"의류"+strSep+"3");
        groupCateHash.put("091421", "091409"+strSep+"푸마"+strSep+"3");
        groupCateHash.put("091430", "091410"+strSep+"노스페이스"+strSep+"3");
        groupCateHash.put("162704", "162709"+strSep+"트리"+strSep+"6");
        groupCateHash.put("162705", "162710"+strSep+"트리장식"+strSep+"3");
        groupCateHash.put("021204", "021221"+strSep+"iPod 전용"+strSep+"3");
        groupCateHash.put("163212", "163206"+strSep+"세탁"+strSep+"5");
        groupCateHash.put("163214", "163207"+strSep+"청소"+strSep+"4");
        groupCateHash.put("090328", "090321"+strSep+"등산화"+strSep+"6");
        groupCateHash.put("022116", "022101"+strSep+"제조사별"+strSep+"4");
        groupCateHash.put("210118", "210117"+strSep+"카비디오"+strSep+"2");
        groupCateHash.put("189002", "189001"+strSep+"오피스"+strSep+"3");
        groupCateHash.put("189010", "189009"+strSep+"리빙"+strSep+"4");
        groupCateHash.put("162101", "162111"+strSep+"밀폐용기"+strSep+"2");
        groupCateHash.put("162308", "162316"+strSep+"브랜드"+strSep+"2");
        groupCateHash.put("211601", "211610"+strSep+"하이패스"+strSep+"2");
        groupCateHash.put("162001", "162010"+strSep+"형태별"+strSep+"5");
        groupCateHash.put("101505", "101504"+strSep+"아동의류"+strSep+"4");
        groupCateHash.put("162906", "162908"+strSep+"<ingi1>모기퇴치<ingi2>"+strSep+"4"); 
        groupCateHash.put("020409", "020408"+strSep+"포터블카세트"+strSep+"2");
        groupCateHash.put("211611", "211612"+strSep+"차량용 블랙박스"+strSep+"2");
        groupCateHash.put("181702", "181706"+strSep+"망원경"+strSep+"2");
        groupCateHash.put("181709", "181712"+strSep+"쌍안경"+strSep+"3");
        groupCateHash.put("092512", "092510"+strSep+"<ingi1>스포츠글라스<ingi2>"+strSep+"4");
        groupCateHash.put("092505", "092511"+strSep+"고글"+strSep+"2");
        groupCateHash.put("162602", "162611"+strSep+"프라이팬"+strSep+"2");
        groupCateHash.put("162601", "162617"+strSep+"냄비"+strSep+"2");
        groupCateHash.put("100102", "100111"+strSep+"신발"+strSep+"3");
        groupCateHash.put("211715", "211719"+strSep+"채널별"+strSep+"3");
        groupCateHash.put("180202", "180210"+strSep+"다이어리"+strSep+"2");
        groupCateHash.put("180207", "180212"+strSep+"데스크,책소품"+strSep+"2");
        groupCateHash.put("180205", "180218"+strSep+"디자인,팬시"+strSep+"3");
        groupCateHash.put("145510", "145514"+strSep+"<ingi1>인기브랜드<ingi2>"+strSep+"4");
        groupCateHash.put("070701", "070706"+strSep+"CPU"+strSep+"2");
        groupCateHash.put("070703", "070707"+strSep+"쿨러"+strSep+"4");
        groupCateHash.put("050414", "050416"+strSep+"전기히터"+strSep+"3");
        groupCateHash.put("022217", "022211"+strSep+"DSLR용"+strSep+"4");
        groupCateHash.put("022214", "022221"+strSep+"미러리스용"+strSep+"3");
        groupCateHash.put("060508", "060524"+strSep+"전기레인지"+strSep+"2");
        groupCateHash.put("031803", "031801"+strSep+"블루투스셋"+strSep+"5");
        groupCateHash.put("031814", "031809"+strSep+"블루투스 스피커"+strSep+"2");
        groupCateHash.put("100103", "100109"+strSep+"가방"+strSep+"2");
        groupCateHash.put("181409", "181413"+strSep+"프라모델,모형"+strSep+"5");
        groupCateHash.put("092403", "092412"+strSep+"부품"+strSep+"2"); 
        groupCateHash.put("093102", "093111"+strSep+"<ingi1>텐트<ingi2>"+strSep+"3");
        groupCateHash.put("030424", "030428"+strSep+"브랜드"+strSep+"4");
        groupCateHash.put("092402", "092415"+strSep+"장착용품"+strSep+"3");
        groupCateHash.put("060113", "060116"+strSep+"인기브랜드"+strSep+"3");
        groupCateHash.put("020922", "020925"+strSep+"제조사별"+strSep+"5");
        groupCateHash.put("122001", "122008"+strSep+"정원용 가구"+strSep+"5");
        groupCateHash.put("122005", "122009"+strSep+"정원 인테리어"+strSep+"3");
        groupCateHash.put("031314", "031317"+strSep+"케이스,보호필름"+strSep+"5");
        groupCateHash.put("181805", "181815"+strSep+"파티"+strSep+"4");
        groupCateHash.put("031902", "031901"+strSep+"통신사"+strSep+"3");
        groupCateHash.put("031906", "031905"+strSep+"브랜드"+strSep+"4");
        groupCateHash.put("052601", "052609"+strSep+"<ingi1>성인 전동칫솔<ingi2>"+strSep+"3");
        groupCateHash.put("212202", "212209"+strSep+"차량용배터리"+strSep+"2");
        groupCateHash.put("101201", "101211"+strSep+"놀이방매트"+strSep+"2");    
        groupCateHash.put("101205", "101215"+strSep+"목욕용품"+strSep+"2");     
        groupCateHash.put("080405", "080411"+strSep+"아이메이크업"+strSep+"3");      
        groupCateHash.put("101108", "101113"+strSep+"유아 도서"+strSep+"3");
        groupCateHash.put("101109", "101115"+strSep+"어린이 도서"+strSep+"4");                  
        groupCateHash.put("090310", "090326"+strSep+"등산장비"+strSep+"2");     
        groupCateHash.put("100303", "100319"+strSep+"<ingi1>분유수유<ingi2>"+strSep+"3");   
        groupCateHash.put("163701", "163710"+strSep+"산업공구,기계"+strSep+"5");              
        groupCateHash.put("122512", "122508"+strSep+"학습용 스탠드"+strSep+"2");  
        groupCateHash.put("122514", "122515"+strSep+"전구"+strSep+"2");
        groupCateHash.put("122520", "122519"+strSep+"LED조명"+strSep+"2"); 
        groupCateHash.put("122523", "122522"+strSep+"일반조명"+strSep+"2"); 
        groupCateHash.put("122610", "122612"+strSep+"단열용품"+strSep+"2"); 
        groupCateHash.put("122704", "122713"+strSep+"시계"+strSep+"4");   
        groupCateHash.put("122801", "122808"+strSep+"식물"+strSep+"2");   
        groupCateHash.put("122805", "122809"+strSep+"원예용품"+strSep+"3"); 
        groupCateHash.put("163707", "163711"+strSep+"편의,안전설비"+strSep+"3");      
        groupCateHash.put("220610", "220609"+strSep+"AV케이블"+strSep+"4");
        groupCateHash.put("022610", "022609"+strSep+"AV케이블"+strSep+"4");
        groupCateHash.put("080707", "080713"+strSep+"기본케어"+strSep+"2");
        groupCateHash.put("080706", "080705"+strSep+"<ingi1>집중케어<ingi2>"+strSep+"3");
        groupCateHash.put("061113", "061116"+strSep+"음식물처리기"+strSep+"3");
        groupCateHash.put("972104", "972103"+strSep+"화면크기별"+strSep+"2");
        groupCateHash.put("972107", "972106"+strSep+"운영체제별"+strSep+"3");
        groupCateHash.put("087802", "087801"+strSep+"겟잇뷰티"+strSep+"6");
        groupCateHash.put("087809", "087808"+strSep+"홈쇼핑"+strSep+"3");
        //groupCateHash.put("080228", "080233"+strSep+"나이트케어"+strSep+"3");
        groupCateHash.put("080225", "080234"+strSep+"시트팩"+strSep+"2");
        groupCateHash.put("210904", "210906"+strSep+"주차 편의용품"+strSep+"2");
        groupCateHash.put("070609", "070619"+strSep+"데이터 케이블"+strSep+"3");
        groupCateHash.put("220709", "220719"+strSep+"데이터 케이블"+strSep+"3");
        groupCateHash.put("070613", "070618"+strSep+"AV케이블"+strSep+"2");    
        groupCateHash.put("220713", "220718"+strSep+"AV케이블"+strSep+"2");        
        groupCateHash.put("211510", "211507"+strSep+"제조사별"+strSep+"6");     
        groupCateHash.put("082501", "082508"+strSep+"꾸며봐 대학 새내기"+strSep+"3");       
        groupCateHash.put("082505", "082509"+strSep+"멋내봐 사회 초년생"+strSep+"3");       
        groupCateHash.put("212601", "212611"+strSep+"스쿠터"+strSep+"2");      
        groupCateHash.put("212603", "212612"+strSep+"오토바이"+strSep+"3");                                                       
        groupCateHash.put("022701", "022711"+strSep+"iPod전용"+strSep+"9");                                                     
        groupCateHash.put("051109", "051114"+strSep+"날면도기"+strSep+"2");                                                   
        groupCateHash.put("022003", "022015"+strSep+"노래반주기"+strSep+"2");                                                              
        groupCateHash.put("161101", "161110"+strSep+"수납"+strSep+"3");                                                                         
        groupCateHash.put("181201", "181211"+strSep+"사료,간식"+strSep+"4");                                                                  
        groupCateHash.put("032812", "032808"+strSep+"식물"+strSep+"4");                                                                 
        groupCateHash.put("032805", "032809"+strSep+"원예용품"+strSep+"3");                                                               
        groupCateHash.put("122101", "122104"+strSep+"봄햇살이 스며드는 거실"+strSep+"3"); 
        groupCateHash.put("122105", "122108"+strSep+"화사한 부부침실"+strSep+"3"); 
        groupCateHash.put("122109", "122112"+strSep+"새싹을 닮은 아이방"+strSep+"3");   
        //groupCateHash.put("162211", "162208"+strSep+"제기,제기함"+strSep+"4"); 
        groupCateHash.put("050601", "050616"+strSep+"공기청정기"+strSep+"3");    
        groupCateHash.put("160302", "160313"+strSep+"정리함"+strSep+"4");  
        groupCateHash.put("160508", "160516"+strSep+"구강용품"+strSep+"2"); 
        groupCateHash.put("033201", "033209"+strSep+"수집"+strSep+"4");   
        groupCateHash.put("033205", "033210"+strSep+"이색취미"+strSep+"3"); 
        groupCateHash.put("041811", "041801"+strSep+"카메라"+strSep+"5");  
        groupCateHash.put("086603", "086602"+strSep+"어버이날,스승의날"+strSep+"2");    
        groupCateHash.put("086606", "086605"+strSep+"두근두근 성년의날"+strSep+"3");     
        groupCateHash.put("052701", "052712"+strSep+"일반 전화기"+strSep+"3");
        groupCateHash.put("052702", "052716"+strSep+"기타 전화기"+strSep+"2");
        groupCateHash.put("052710", "052713"+strSep+"무전기"+strSep+"3");   
        groupCateHash.put("030432", "030440"+strSep+"브랜드"+strSep+"4");                                                                                  
        groupCateHash.put("052605", "052610"+strSep+"칫솔살균기"+strSep+"3");                                                                                    
        groupCateHash.put("163505", "163510"+strSep+"배터리,충전기"+strSep+"4");                                                                                  
        groupCateHash.put("162011", "162013"+strSep+"인기브랜드"+strSep+"3");                                                                                
        groupCateHash.put("101014", "101016"+strSep+"블록"+strSep+"3");                                                                       
        groupCateHash.put("163712", "163713"+strSep+"안전용품"+strSep+"2");                                                                                 
        groupCateHash.put("082801", "082811"+strSep+"자외선 차단제"+strSep+"3");                                                                                  
        groupCateHash.put("082804", "082812"+strSep+"바디케어"+strSep+"4");                                                             
        groupCateHash.put("180802", "180801"+strSep+"금고"+strSep+"2");                                                                                                       
        groupCateHash.put("180804", "180815"+strSep+"금융기기"+strSep+"4");             
        groupCateHash.put("081309", "081311"+strSep+"페이스"+strSep+"2");  
        groupCateHash.put("021225", "021237"+strSep+"인기브랜드"+strSep+"3");    
        groupCateHash.put("030554", "030561"+strSep+"형태별"+strSep+"3");
        groupCateHash.put("180301", "180308"+strSep+"복사용지"+strSep+"5"); 
        groupCateHash.put("120703", "120712"+strSep+"수납장"+strSep+"4");  
        groupCateHash.put("052101", "052114"+strSep+"피부,얼굴관리"+strSep+"4");  
        groupCateHash.put("052102", "052115"+strSep+"몸매관리,교정"+strSep+"3");
        groupCateHash.put("020309", "020314"+strSep+"오디오"+strSep+"3");  
        groupCateHash.put("020321", "020323"+strSep+"라디오"+strSep+"2");   
        groupCateHash.put("211322", "211326"+strSep+"지도별"+strSep+"4");  
        //groupCateHash.put("210302", "210316"+strSep+"<ingi1>와이퍼<ingi2>"+strSep+"2");   
        groupCateHash.put("081202", "081211"+strSep+"유아 기본케어"+strSep+"2");   
        groupCateHash.put("081210", "081212"+strSep+"유아 기능성케어"+strSep+"3"); 
        groupCateHash.put("121902", "121913"+strSep+"학생,사무용"+strSep+"3");
        groupCateHash.put("163812", "163808"+strSep+"식물"+strSep+"3");
        groupCateHash.put("163805", "163809"+strSep+"원예용품"+strSep+"3");
        groupCateHash.put("022301", "022312"+strSep+"케이스,보호필름"+strSep+"3");
        groupCateHash.put("090407", "090417"+strSep+"웨이트 트레이닝"+strSep+"3");
        groupCateHash.put("210608", "210616"+strSep+"<ingi1>캐리어<ingi2>"+strSep+"3");        
        groupCateHash.put("181811", "181814"+strSep+"크리스마스"+strSep+"3");
        //groupCateHash.put("219808", "219816"+strSep+"겨울철 필수 아이템"+strSep+"4");
        //groupCateHash.put("219812", "219817"+strSep+"따뜻한 실내"+strSep+"3");
        //groupCateHash.put("219814", "219818"+strSep+"스마트한 여행"+strSep+"3");
        groupCateHash.put("975002", "975015"+strSep+"TV,AV"+strSep+"2");
        groupCateHash.put("975005", "975020"+strSep+"스마트홈"+strSep+"4");
        groupCateHash.put("033402", "033401"+strSep+"트리"+strSep+"6");
        groupCateHash.put("033408", "033407"+strSep+"트리장식"+strSep+"5");
        groupCateHash.put("100918", "100920"+strSep+"인형"+strSep+"4");
        groupCateHash.put("100919", "100921"+strSep+"역할놀이완구"+strSep+"4");
        groupCateHash.put("169315", "169317"+strSep+"겨울철 끝마무리"+strSep+"2");
        groupCateHash.put("169304", "169309"+strSep+"추위대비 완전무장"+strSep+"3");
        groupCateHash.put("169311", "169310"+strSep+"포근한 겨울침구,홈데코"+strSep+"4");
        groupCateHash.put("033501", "033510"+strSep+"케이스,보호필름"+strSep+"5");
        groupCateHash.put("030551", "030560"+strSep+"인기제조사"+strSep+"3");
        groupCateHash.put("162714", "162713"+strSep+"트리"+strSep+"6");
        groupCateHash.put("162720", "162719"+strSep+"트리장식"+strSep+"5");
        groupCateHash.put("038016", "038024"+strSep+"<b style='cursor:default;'>주변기기</b>"+strSep+"5");
        groupCateHash.put("038010", "038009"+strSep+"<b style='cursor:default;'>범용 액세서리</b>"+strSep+"7");
        groupCateHash.put("037909", "037908"+strSep+"<b style='cursor:default;'>범용 액세서리</b>"+strSep+"6");
        groupCateHash.put("037915", "037919"+strSep+"<b style='cursor:default;'>주변기기</b>"+strSep+"4");
        groupCateHash.put("161107", "161114"+strSep+"일회용품"+strSep+"2");
        groupCateHash.put("210421", "210422"+strSep+"헤드램프"+strSep+"2");
        groupCateHash.put("210402", "210423"+strSep+"실내등,미등"+strSep+"2");
        groupCateHash.put("210409", "210424"+strSep+"기타램프"+strSep+"3");
        groupCateHash.put("181213", "181219"+strSep+"애견용품"+strSep+"3");
        groupCateHash.put("181216", "181220"+strSep+"고양이용품"+strSep+"3");
        groupCateHash.put("020823", "020824"+strSep+"스피커"+strSep+"3");
        groupCateHash.put("083102", "083109"+strSep+"자신만만 대학새내기"+strSep+"3");
        groupCateHash.put("083106", "083110"+strSep+"위풍당당 사회초년생"+strSep+"3");           
        groupCateHash.put("070213", "070219"+strSep+"NAS(네트워크하드)"+strSep+"2");          
        groupCateHash.put("120305", "120310"+strSep+"주방수납"+strSep+"2");
        groupCateHash.put("120301", "120311"+strSep+"식탁"+strSep+"2");
        groupCateHash.put("101401", "101421"+strSep+"인기캐릭터"+strSep+"3");
        groupCateHash.put("101422", "101420"+strSep+"여아 완구"+strSep+"2");
        groupCateHash.put("101417", "101419"+strSep+"남아 완구"+strSep+"3");
        groupCateHash.put("181312", "181314"+strSep+"건반악기"+strSep+"2");
        groupCateHash.put("181301", "181316"+strSep+"기타(Guitar)"+strSep+"2");               
        groupCateHash.put("051501", "051520"+strSep+"건강측정기"+strSep+"4");        
        groupCateHash.put("020623", "020621"+strSep+"화질별"+strSep+"3"); 
        groupCateHash.put("103001", "103004"+strSep+"물놀이용품"+strSep+"3");
        groupCateHash.put("103006", "103009"+strSep+"수영복,비치웨어"+strSep+"3");  
        groupCateHash.put("211328", "211332"+strSep+"액세서리"+strSep+"3"); 
        groupCateHash.put("091103", "091113"+strSep+"야구"+strSep+"2");   
        groupCateHash.put("079001", "079011"+strSep+"부품"+strSep+"6");   
        groupCateHash.put("079007", "079012"+strSep+"완제품"+strSep+"3");
        groupCateHash.put("150202", "150210"+strSep+"쌀,잡곡"+strSep+"2");
        groupCateHash.put("150203", "150211"+strSep+"과일"+strSep+"2");
        groupCateHash.put("093002", "093011"+strSep+"골프화"+strSep+"3");
        groupCateHash.put("220105", "220128"+strSep+"가방"+strSep+"2");
        groupCateHash.put("220802", "220810"+strSep+"메모리카드"+strSep+"5");
        groupCateHash.put("220802", "220810"+strSep+"메모리카드"+strSep+"5");
        groupCateHash.put("220808", "220814"+strSep+"카드리더"+strSep+"4");
        groupCateHash.put("060601", "060628"+strSep+"드립커피추출"+strSep+"4");       
        groupCateHash.put("100308", "100320"+strSep+"이유식기,턱받이"+strSep+"4");
        groupCateHash.put("100301", "100321"+strSep+"세정,소독"+strSep+"2");
        groupCateHash.put("100311", "100322"+strSep+"모유수유"+strSep+"2");
        groupCateHash.put("060818", "060819"+strSep+"튀김기"+strSep+"2");
        groupCateHash.put("060813", "060821"+strSep+"<ingi1>전기포트<ingi2>"+strSep+"2");
        groupCateHash.put("062105", "062124"+strSep+"홈베이킹"+strSep+"2");     
        groupCateHash.put("062119", "062126"+strSep+"<ingi1>전자레인지<ingi2>"+strSep+"2");
        groupCateHash.put("062132", "062130"+strSep+"전기오븐"+strSep+"4");
       // groupCateHash.put("022413", "022414"+strSep+"셋탑박스"+strSep+"2");
        groupCateHash.put("080121", "080124"+strSep+"기능성"+strSep+"3");
        groupCateHash.put("040209", "040205"+strSep+"복합기"+strSep+"3");
        groupCateHash.put("040711", "040720"+strSep+"멀티탭"+strSep+"2");
        groupCateHash.put("220511", "220520"+strSep+"멀티탭"+strSep+"2");
        groupCateHash.put("040201", "040208"+strSep+"프린터"+strSep+"4");
        groupCateHash.put("040512", "040522"+strSep+"27 인치~"+strSep+"2");
        groupCateHash.put("040510", "040523"+strSep+"23,24 인치"+strSep+"2");
        groupCateHash.put("040509", "040524"+strSep+"~22 인치"+strSep+"2");
        groupCateHash.put("041020", "041022"+strSep+"가방,파우치"+strSep+"3");
        groupCateHash.put("220320", "220322"+strSep+"가방,파우치"+strSep+"3");
        groupCateHash.put("061109", "061118"+strSep+"웰빙제조기"+strSep+"3");
        groupCateHash.put("180806", "180816"+strSep+"사무기기"+strSep+"2");
        groupCateHash.put("082609", "082610"+strSep+"장식소품"+strSep+"2");
//      groupCateHash.put("050408", "050419"+strSep+"<ingi1>온풍기/팬히터<ingi2>"+strSep+"2");
        groupCateHash.put("080404", "080419"+strSep+"립메이크업"+strSep+"2");
        groupCateHash.put("976303", "976302"+strSep+"탁상용"+strSep+"3");
        groupCateHash.put("976307", "976306"+strSep+"휴대용"+strSep+"3");
        //groupCateHash.put("080602", "080619"+strSep+"기초/마사지"+strSep+"3");
        groupCateHash.put("042001", "042010"+strSep+"인치별"+strSep+"3");
        groupCateHash.put("080903", "080914"+strSep+"기초(스킨,로션)"+strSep+"3");        
        groupCateHash.put("900309", "900314"+strSep+"세트상품"+strSep+"3");
        groupCateHash.put("070903", "070911"+strSep+"공유기,랜카드"+strSep+"4");
        groupCateHash.put("070905", "070912"+strSep+"네트워크장비"+strSep+"4");
        groupCateHash.put("051419", "051418"+strSep+"<ingi1>비데<ingi2>"+strSep+"3");
        groupCateHash.put("051420", "051422"+strSep+"온수기"+strSep+"2");
        groupCateHash.put("060522", "060502"+strSep+"빌트인"+strSep+"2");
        groupCateHash.put("150501", "150511"+strSep+"커피"+strSep+"3");
        groupCateHash.put("092101", "092111"+strSep+"해외여행준비물"+strSep+"4");
        groupCateHash.put("092113", "092115"+strSep+"바캉스용품"+strSep+"3");
                
        //IT상품예외... 
        groupCateHash.put("980301", "030409"+strSep+"통신사"+strSep+"3");
        groupCateHash.put("971603", "971609"+strSep+"액세서리"+strSep+"4");
        groupCateHash.put("981402", "030105"+strSep+"전자사전"+strSep+"3");
        groupCateHash.put("981701", "040808"+strSep+"플레이스테이션"+strSep+"3");
        groupCateHash.put("981704", "040810"+strSep+"X박스"+strSep+"2");
        groupCateHash.put("981712", "040813"+strSep+"닌텐도"+strSep+"2");
        groupCateHash.put("981802", "071201"+strSep+"형태별"+strSep+"5");
        groupCateHash.put("981907", "070201"+strSep+"HDD"+strSep+"2");
        groupCateHash.put("981909", "070204"+strSep+"외장 HDD"+strSep+"3");
        groupCateHash.put("981114", "020816"+strSep+"조합형"+strSep+"2");
        groupCateHash.put("060110", "060101"+strSep+"가정용"+strSep+"3");
        groupCateHash.put("071401", "071409"+strSep+"CD"+strSep+"2");
        groupCateHash.put("071403", "071410"+strSep+"DVD"+strSep+"3");
        groupCateHash.put("982003", "021910"+strSep+"단품 스피커"+strSep+"3");
        groupCateHash.put("051017", "051015"+strSep+"안마,마사지기"+strSep+"4");
        groupCateHash.put("061001", "061012"+strSep+"정수기"+strSep+"5");
        groupCateHash.put("121301", "121309"+strSep+"커튼"+strSep+"4");
        groupCateHash.put("121307", "121317"+strSep+"여름용"+strSep+"3");
        groupCateHash.put("981204", "021511"+strSep+"DVD,DivX플레이어"+strSep+"3");  
        groupCateHash.put("071302", "071306"+strSep+"HDD"+strSep+"3");
        groupCateHash.put("071304", "071307"+strSep+"SSD(메모리)"+strSep+"2");
        groupCateHash.put("210121", "210115"+strSep+"카오디오"+strSep+"3");
        groupCateHash.put("161312", "161308"+strSep+"학습용 스탠드"+strSep+"3");
        groupCateHash.put("163110", "163112"+strSep+"단열용품"+strSep+"2");
        groupCateHash.put("160604", "160613"+strSep+"시계"+strSep+"4");
        groupCateHash.put("980825", "021232"+strSep+"인기브랜드"+strSep+"5");
        groupCateHash.put("980602", "022101"+strSep+"DSLR"+strSep+"3");
        groupCateHash.put("147612", "147623"+strSep+"트레이닝복"+strSep+"2");
        groupCateHash.put("160801", "160811"+strSep+"글라스"+strSep+"2");
        groupCateHash.put("160805", "160812"+strSep+"액세서리"+strSep+"3");
        groupCateHash.put("160803", "160813"+strSep+"보관"+strSep+"2");
        groupCateHash.put("061015", "061016"+strSep+"정수기필터"+strSep+"2");
        groupCateHash.put("070106", "070150"+strSep+"ODD(드라이브)"+strSep+"4");
        groupCateHash.put("070119", "070151"+strSep+"공디스크"+strSep+"5");
        groupCateHash.put("162610", "162614"+strSep+"인기브랜드"+strSep+"2");
        groupCateHash.put("021405", "021428"+strSep+"가방"+strSep+"2");
        groupCateHash.put("070504", "070514"+strSep+"TV수신"+strSep+"2");
        groupCateHash.put("102301", "102312"+strSep+"임부용품"+strSep+"4");
        groupCateHash.put("102305", "102313"+strSep+"신생아용품"+strSep+"2");
        groupCateHash.put("083201", "083210"+strSep+"지켜주자 아이피부"+strSep+"2");
        groupCateHash.put("150302", "150312"+strSep+"돼지고기"+strSep+"2");
        groupCateHash.put("150306", "150313"+strSep+"소고기"+strSep+"3");                                          
        groupCateHash.put("083401", "083411"+strSep+"선크림"+strSep+"3");
        groupCateHash.put("083405", "083419"+strSep+"바디 관리"+strSep+"3");
        groupCateHash.put("083414", "083418"+strSep+"피부 진정"+strSep+"2");
        groupCateHash.put("083416", "083420"+strSep+"피부톤 연출"+strSep+"3");
        groupCateHash.put("092003", "092024"+strSep+"주방용품"+strSep+"4");
        //groupCateHash.put("083409", "083413"+strSep+"메이크업"+strSep+"2");
        //groupCateHash.put("050309", "050311"+strSep+"로봇"+strSep+"2");
        groupCateHash.put("145410", "145414"+strSep+"인기브랜드"+strSep+"3");
        groupCateHash.put("041403", "041412"+strSep+"사무,회계"+strSep+"2");
        groupCateHash.put("150601", "150607"+strSep+"김치"+strSep+"2");
        groupCateHash.put("213101", "213111"+strSep+"엔진오일"+strSep+"3");
        groupCateHash.put("213105", "213112"+strSep+"첨가제"+strSep+"3");
        groupCateHash.put("210809", "210830"+strSep+"세차"+strSep+"2");
        groupCateHash.put("210819", "210831"+strSep+"광택,코팅제"+strSep+"2");

                
        // 재정의 된 이름 "051611", "인

        
        HashMap etcCateHash = new HashMap();
        etcCateHash = getEtcCateHash(); 

        
        // MCate 추가 내용(검은색으로 중간 제목 넣음, 링크 없음)
        HashMap etcMCateNameHash = new HashMap();
        etcMCateNameHash.put("0304", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_54.gif' width='138px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("0352", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_55.gif' width='138px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("0359", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_60.gif' width='138px' height='19px' align='absmiddle'>");    
        etcMCateNameHash.put("0680", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_06.gif' width='152px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("0601", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_07_1.gif' width='152px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("0503", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_05_1.gif' width='152px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("0501", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_04_3.gif' width='152px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("1208", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_21.gif' width='134px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("1289", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_57.gif' width='134px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("1202", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_22.gif' width='134px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("1602", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_23.gif' width='140px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("1626", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_24.gif' width='140px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("1642", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_58.gif' width='140px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("1603", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_25_1.gif' width='140px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("1684", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_53.gif' width='140px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("0903", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_13_2.gif' width='146px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("0908", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_16.gif' width='146px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("0912", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_14.gif' width='146px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("0915", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_15.gif' width='146px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("0905", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_18_1.gif' width='146px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("0909", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_59_2.gif' width='146px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("0404", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_08.gif' width='134px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("0402", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_45.gif' width='134px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("0494", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_40.gif' width='134px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("0702", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_42.gif' width='134px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("0710", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_43.gif' width='134px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("0707", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_41.gif' width='134px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("2117", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_11.gif' width='148px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("2104", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_48.gif' width='148px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("2115", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_46.gif' width='148px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("2108", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_47.gif' width='148px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("1010", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_19.gif' width='134px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("1007", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_20.gif' width='134px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("1482", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_29.gif' width='108px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("1471", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_30_1.gif' width='108px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("1455", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_31.gif' width='108px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("0807", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_32.gif' width='134px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("0801", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_33.gif' width='134px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("1591", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_34_1.gif' width='148px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("1506", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_35.gif' width='148px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("1574", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_36.gif' width='148px' height='19px' align='absmiddle'>");
        etcMCateNameHash.put("1505", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/topcate3/top_cate_37.gif' width='148px' height='19px' align='absmiddle'>");
        //etcMCateNameHash.put("0782", "프린터, 용품");
        //etcMCateNameHash.put("0785", "소모품"); 
                        
        // MCate 추가 내용(검은색으로 중간 제목 넣음, 링크 없음)
        //HashMap etcMCateNameHash = new HashMap();
        //etcMCateNameHash.put("1809", "학습가전 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("1893", "오피스용품 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("1812", "취미, 애완, 상품권 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("0307", "사무기기 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("0516", "계절가전 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu//arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("0506", "생활가전 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu//arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("0602", "냉장고, 세탁, 청소기 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu//arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("0601", "주방가전 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu//arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("1613", "인테리어, 수납 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("1615", "취미, 애완, 상품권 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("1626", "주방용품 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("0209", "카메라, 렌즈 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("0212", "음향가전 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("2117", "차량용 iT상품 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("2115", "자동차용품 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("0920", "아웃도어, 레저 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("0912", "스포츠 패션 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("0991", "건강가전, 헬스 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("0915", "인기 브랜드 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("0908", "골프 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("0901", "스키, 헬스, 구기 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu//arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("0905", "자전거, 익스트림 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("1010", "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/santa_claus.png' width='20px' height='20px' align='absmiddle'>크리스마스 완구 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("1010", "완구, 교육 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("1208", "침구, 홈데코 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("1202", "가구 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("1605", "욕실, 위생용품 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("1005", "<span style='position:relative;margin-top:-3px;'>&nbsp;<img src='"+ConfigManager.IMG_ENURI_COM+"/images/blank.gif' align='absmiddle' width='1' height='20px'></span>유아동 용품 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("1602", "공구, 전기, 기계 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("1482", "브랜드의류 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("1471", "보세의류 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("1455", "패션, 잡화 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("0791", "컴퓨터 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("0713", "부품 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("0493", "주변기기 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("0481", "부품 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("0782", "프린터, 용품");
        //etcMCateNameHash.put("0785", "소모품"); 
        //etcMCateNameHash.put("0408", "게임, 소모품 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("0801", "기초, 메이크업 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("0807", "바디, 헤어, 소품 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("0823", "대박 이슈 상품 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("1591", "쌀, 과일, 축산, 수산<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu//arrow/arr.gif' width='5px' height='9px' align='absmiddle'  style='padding-right:23px;'>");
        //etcMCateNameHash.put("1506", "김치, 라면, 즉석, 가공<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu//arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("1574", "홍삼, 건강, 다이어트<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu//arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("1505", "커피, 음료, 과자<img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu//arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("9601", "카메라/캠코더 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu//arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("9605", "액세서리 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu//arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        //etcMCateNameHash.put("0201", "영상가전 <img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu//arrow/arr.gif' width='5px' height='9px' align='absmiddle'>");
        
        // 중분류 결합 메뉴  
        String[] mCateSum1 = {"0410", "0792"};
        String[] mCateSum2 = {"2204", "2204"};
        String[] mCateSumName = {"노트북용 액세서리","노트북용 액세서리"}; 
        
        // 메뉴 출력
        // 출력 데이터를 저장하는 해쉬함수
        HashMap outDivHash = new HashMap();

        for(int i=0; i<menuMainHashMapKeys.size(); i++) {
            String outStr = "";
            String firstStr = "";
            String endStr = "";
            boolean twoColsFlag = false;

            String keyTemp = (String)menuMainHashMapKeys.get(i);
            ArrayList tempAryList = (ArrayList)menuMainHashMap.get(keyTemp);

            String[] keyTempAry = keyTemp.split("_");

            // 중분류인지 소분류인지 판단
            boolean MCateFlag = false;
            if(keyTempAry[0].length()==2) {
                MCateFlag = true;
            } 

            // 지식통 메뉴를 위한 데이터 출력
            /*
            if(MCateFlag) {
                String outKbStr = "";
                for(int j=0; j<tempAryList.size(); j++) {
                    
                    String dataTemp = tempAryList.get(j).toString();
                    String[] dataTempAry = dataTemp.split(strSep);

                    if(j==0) outKbStr += "parent.KbMenuData['"+keyTemp+"'] = '";
                    if(dataTempAry.length>4 && dataTempAry[4].equals("1")) {
                        outKbStr += dataTempAry[1] + ":" + dataTempAry[2];
                        if(j<tempAryList.size()-1) outKbStr += "|";
                    }
                    if(j==tempAryList.size()-1) {
                        if(outKbStr.charAt(outKbStr.length()-1)=='|') 
                            outKbStr = outKbStr.substring(0, outKbStr.length()-1);
                        outKbStr += "';";
                    }
                }
                if(outKbStr.indexOf("'';")==-1) out.println(outKbStr);
            }
            */
            
            firstStr = "";
            String groupId = "";
            String lineHeight = "";
            int groupCnt = 0;
            String groupCateFirst = "";

            for(int j=0; j<tempAryList.size(); j++) {
                String dataTemp = tempAryList.get(j).toString();
                String[] dataTempAry = dataTemp.split(strSep);
                boolean cateShowFlag = true;

                // 중분류의 예외 결합 실행  시 제거 부분

 
                for(int k=0; k<mCateSum2.length; k++) {
                    if(mCateSum2[k].equals(dataTempAry[2])) cateShowFlag = false;
                }
                // 나오지 말아야할 분류를 세팅함
                if(!cateShowFlag ||   
                    (keyTempAry[0].equals("98") && j>13) ||
                    dataTempAry[2].equals("021411") || (keyTempAry[0].equals("06") && j>19)  || (keyTempAry[0].equals("05") && j>19) || 
                    dataTempAry[1].equals("temp") || (keyTempAry[0].equals("21") && j>26) || dataTempAry[2].equals("1481") || 
                    dataTempAry[2].equals("1502") || dataTempAry[2].equals("1209") || 
                    dataTempAry[2].equals("0411") ||   
                    dataTempAry[2].equals("9752") || dataTempAry[2].equals("9753") || dataTempAry[2].equals("9754") ||
                    dataTempAry[2].equals("9724") || dataTempAry[2].equals("9751") || dataTempAry[2].equals("0343") || 
                     dataTempAry[2].equals("9608") || dataTempAry[2].equals("1501") || 
                    (keyTempAry[0].equals("16") && j>29) ||
                    (keyTempAry[0].equals("07") && j>12) || (keyTempAry[0].equals("04") && j>13)|| (keyTempAry[0].equals("03") && j>17)
                    ) { 
                } else { 
 
                    if(MCateFlag && !twoColsFlag && !keyTempAry[0].equals("98") && !keyTempAry[0].equals("14_1") && dataTempAry[3].equals("1")) {
                        outStr += "</td>";
                        outStr += "<td style='width:2px;'><img id='middleLineImg' style='top-margin:47px;bottom-margin:47px;' width='2' height='0' src="+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/line.gif><td>";
                        outStr += "<td valign='top' class='menu_m_right' width='50%'>";
                        twoColsFlag = true;
                    }
                    
                    int tempOldGroupCnt = groupCnt;
                    
                    // 묶음카테의 제목을 보여줌
                    if(!MCateFlag && PStartCate.indexOf(dataTempAry[2])>-1) {
                        if(groupCateHash.containsKey(dataTempAry[2])) {
                            String[] pstrcateTmp = groupCateHash.get(dataTempAry[2]).toString().split(strSep);
                            groupId = dataTempAry[2];
                            groupCnt = Integer.parseInt(pstrcateTmp[2]);
                            if(pstrcateTmp[0].equals("971609")){
                                outStr += "<div style='height:15px;margin:2px 2px 1px 2px;' id='group"+groupId+"' name='group"+groupId+"'><a name=subMenuName href='#' "+makeGroupSOverClickFunction(strUserAgentStr,groupId,getCateLink(pstrcateTmp[0]),strMobleAg)+"><star1>"+pstrcateTmp[1]+"<IMG src='"+ConfigManager.ConstBlankImgSrc+"' width=4 border=0 align=abstop><IMG SRC="+ConfigManager.IMG_ENURI_COM+"/images/topmenu/ingi_star.gif width=6px height=5px style='margin:0px 1px 5px 1px;' border=0 align=abstop><star2></a></div>";
                            }else if(pstrcateTmp[0].equals("038024") || pstrcateTmp[0].equals("037919") ||pstrcateTmp[0].equals("037908") ||pstrcateTmp[0].equals("038009") ){
                                outStr += "<div style='height:17px;margin:2px 2px 1px 2px;' id='group"+groupId+"' name='group"+groupId+"'><star1>"+pstrcateTmp[1]+"<star2></div>";
                            }else{
                                outStr += "<div style='height:17px;margin:2px 2px 1px 2px;' id='group"+groupId+"' name='group"+groupId+"'><a name=subMenuName href='#' "+makeGroupSOverClickFunction(strUserAgentStr,groupId,getCateLink(pstrcateTmp[0]),strMobleAg)+"><star1>"+pstrcateTmp[1]+"<star2></a></div>";
                            }
                            // 특정 그룹 상위카테의 하위 아이템을 예외처리하기 위해 저장
                            groupCateFirst = pstrcateTmp[0];
                        }
                    } 

                    String menuDivStyle = "";
                    String dataCateTemp = dataTempAry[2];
                    String cateNameTemp = "";
                    String etcNameCate = dataCateTemp;
                    //out.println("groupCnt="+groupCnt);
                    
                    //if(tempOldGroupCnt==0 && groupCnt>1) {
                        //맨처음
                    //}
                    
                    if(groupCnt>0 && !groupCateFirst.equals("037908") && !groupCateFirst.equals("038307") && !groupCateFirst.equals("037919") && !groupCateFirst.equals("038109") && !groupCateFirst.equals("038318") && !groupCateFirst.equals("038009") && !groupCateFirst.equals("038024")) {
                        if(groupCnt>1) {
                            if(etcCateHash.containsKey(etcNameCate) && etcCateHash.get(etcNameCate).toString().indexOf("<br>") > -1) { 
                                lineHeight = " style='<position1>height:32px;margin:0px 2px 0px 2px;'";
                            }else{
                                lineHeight = " style='<position1>height:18px;margin:0px 2px 0px 2px;'";
                            }
                        } else if(groupCnt==1) {
                            //맨끝
                            if(etcCateHash.containsKey(etcNameCate) && etcCateHash.get(etcNameCate).toString().indexOf("<br>") > -1) { 
                                lineHeight = " style='<position2>height:32px;margin:0px 2px -1px 2px;'";
                            }else{
                                lineHeight = " style='<position2>height:18px;margin:0px 2px -1px 2px;'";
                            }
                        }
                    } else {
                        if(etcCateHash.containsKey(etcNameCate) && etcCateHash.get(etcNameCate).toString().indexOf("<br>") > -1) { 
                            lineHeight = " style='height:30px;margin:3px 2px 3px 2px;' ";
                        }else{
                        //얜데
                            lineHeight = " style='height:15px;margin:2px 2px 3px 2px;' ";
                        }
                    }
 
                    if(MCateFlag) {
                        // 신차 비교 와 패션 위에 선넣기 예외처리 
                        if( dataTempAry[2].equals("1588") || dataTempAry[2].equals("0809") ||   dataTempAry[2].equals("0305") || dataTempAry[2].equals("1587") ||  dataTempAry[2].equals("2111") || dataTempAry[2].equals("9759") || dataTempAry[2].equals("9750") || dataTempAry[2].equals("1498")  ||  dataTempAry[2].equals("1890") || dataTempAry[2].equals("0921")  || dataTempAry[2].equals("0294")  || dataTempAry[2].equals("1221")  || dataTempAry[2].equals("0790") || dataTempAry[2].equals("1021") || dataTempAry[2].equals("1206") || dataTempAry[2].equals("1509") || dataTempAry[2].equals("1475")  || dataTempAry[2].equals("0822") || dataTempAry[2].equals("1582") || dataTempAry[2].equals("1694") || dataTempAry[2].equals("0694")|| dataTempAry[2].equals("1586")) {
                            //if(keyTempAry[0].equals("09")) {
                                //outStr += "<div style='height:1px;width:110px;overflow:hidden;background-repeat:repeat-x;background-image:url("+ConfigManager.IMG_ENURI_COM+"/images/topmenu/top_dot.gif);margin-top:2px;margin-bottom:0px;'><img src='"+ConfigManager.ConstBlankImgSrc+"' height=1 ></div>";
                            //}else {
                                outStr += "<div style='height:1px;overflow:hidden;background-repeat:repeat-x;background-image:url("+ConfigManager.IMG_ENURI_COM+"/images/topmenu/top_dot.gif);margin-top:2px;margin-bottom:0px;'><img src='"+ConfigManager.ConstBlankImgSrc+"' height=1 ></div>";
                            //}
                        }   
                        
                        String layerShowType = "1";
                        if(twoColsFlag) layerShowType = "3";
                        if(MCateFlag && !keyTempAry[0].equals("98") && (dataTempAry[2].substring(0, 2).equals("04") || dataTempAry[2].substring(0, 2).equals("06") )) layerShowType = "2";
                        if(!keyTempAry[0].equals("98") && etcMCateNameHash.containsKey(dataTempAry[2])) {
                            //if( dataTempAry[2].equals("0782") || dataTempAry[2].equals("0785") ) { 
                                //outStr += "<div style='overflow:hidden;height:1px;line-height:1px;background-repeat:repeat-x;background-image:url("+ConfigManager.IMG_ENURI_COM+"/images/topmenu/top_dot.gif);margin-top:2px;margin-bottom:0px;'><img src='"+ConfigManager.ConstBlankImgSrc+"' style='height:1px;width:1px;'></div>";
                            //}
                            if( dataTempAry[2].equals("0481") || dataTempAry[2].equals("1809") || dataTempAry[2].equals("0713") || dataTempAry[2].equals("0408")){
                                outStr += "<div onMouseOver='mDivOver();' style='cursor:text;font-weight:bold;height:19px;padding-top:25px;'>"+etcMCateNameHash.get(dataTempAry[2]).toString()+"</div>";
                            }else if(dataTempAry[2].equals("1623") || dataTempAry[2].equals("1513") || dataTempAry[2].equals("2108") || dataTempAry[2].equals("0516") || dataTempAry[2].equals("0359") || dataTempAry[2].equals("0991") || dataTempAry[2].equals("0402")  || dataTempAry[2].equals("0494") || dataTempAry[2].equals("0402") || dataTempAry[2].equals("0710") || dataTempAry[2].equals("0707") || dataTempAry[2].equals("0909") || dataTempAry[2].equals("1289") || dataTempAry[2].equals("0807")|| dataTempAry[2].equals("0510") || dataTempAry[2].equals("1622")  || dataTempAry[2].equals("1622")   || dataTempAry[2].equals("1642") || dataTempAry[2].equals("1626") || dataTempAry[2].equals("1684") || dataTempAry[2].equals("0514") || dataTempAry[2].equals("1605") || dataTempAry[2].equals("0909")){ 
                                outStr += "<div onMouseOver='mDivOver();' style='cursor:text;font-weight:bold;height:19px;padding-top:15px;'>"+etcMCateNameHash.get(dataTempAry[2]).toString()+"</div>";
                            }else if( dataTempAry[2].equals("0807") || dataTempAry[2].equals("1471") || dataTempAry[2].equals("2104") || dataTempAry[2].equals("2108") || dataTempAry[2].equals("0506") || dataTempAry[2].equals("0503") || dataTempAry[2].equals("0601") || dataTempAry[2].equals("0345") || dataTempAry[2].equals("0511") || dataTempAry[2].equals("1506") || dataTempAry[2].equals("1505") || dataTempAry[2].equals("0217")) {
                                outStr += "<div onMouseOver='mDivOver();' style='cursor:text;font-weight:bold;height:19px;padding-top:13px;'>"+etcMCateNameHash.get(dataTempAry[2]).toString()+"</div>";
                            }else if(dataTempAry[2].equals("0352")) {
                                outStr += "<div onMouseOver='mDivOver();' style='cursor:text;font-weight:bold;height:19px;padding-top:14px;'>"+etcMCateNameHash.get(dataTempAry[2]).toString()+"</div>";
                            }else if(dataTempAry[2].equals("0915") || dataTempAry[2].equals("0905") || dataTempAry[2].equals("0909") || dataTempAry[2].equals("0912")   ) {
                                outStr += "<div onMouseOver='mDivOver();' style='cursor:text;font-weight:bold;height:19px;padding-top:16px;'>"+etcMCateNameHash.get(dataTempAry[2]).toString()+"</div>";
                            //}else if(dataTempAry[2].equals("0782") || dataTempAry[2].equals("0785")) {
                                //outStr += "<div onMouseOver='mDivOver();' style='cursor:text;'>"+etcMCateNameHash.get(dataTempAry[2]).toString()+"</div>";
                            }else{ 
                                outStr += "<div onMouseOver='mDivOver();' style='height:20px;cursor:text;font-weight:bold;'>"+etcMCateNameHash.get(dataTempAry[2]).toString()+"</div>";
                            }
                            
                        } 
                        
                        // 해당 중분류명 위에 공백
                        if( dataTempAry[2].equals("1206_1")) { 
                            outStr += "<div onMouseOver='mDivOver();' style='height:50px;cursor:text;'></div>";
                        }else if(  dataTempAry[2].equals("0294_1") ) { 
                            outStr += "<div onMouseOver='mDivOver();' style='height:47px;cursor:text;'></div>";
                        }else if( dataTempAry[2].equals("1890")  ) {
                            outStr += "<div onMouseOver='mDivOver();' style='height:45px;cursor:text;'></div>";
                        }else if( dataTempAry[2].equals("0294")) {
                            outStr += "<div onMouseOver='mDivOver();' style='height:30px;cursor:text;'></div>";
                        }else if( dataTempAry[2].equals("2111") || dataTempAry[2].equals("1582") || dataTempAry[2].equals("1021") || dataTempAry[2].equals("1206") || dataTempAry[2].equals("1509")) {
                            outStr += "<div onMouseOver='mDivOver();' style='line-height:5px;height:5px;cursor:text;'> <!-- --> </div>";
                        }else if(dataTempAry[2].equals("9758")) {
                            outStr += "<div onMouseOver='mDivOver();' style='margin:0px;padding:0px;height:1px;line-height:1px;cursor:text;'> <!--  --> </div>";
                        }
        
                        if(!keyTempAry[0].equals("98") && (dataTempAry[2].equals("2112_1")) || dataTempAry[2].equals("1890") || dataTempAry[2].equals("0790")) {
                            menuDivStyle = "style='font-weight:bold;' ";
                        }
                        
                        if(keyTempAry[0].equals("98")) {
                            String onClickLink = getCateLink(dataTempAry[2]); 
                            if(dataCateTemp.equals("9702")) onClickLink = "insertLog(3178);" + onClickLink;
                            if(dataCateTemp.equals("9715")) onClickLink = "insertLog(3179);" + onClickLink;
                            if(dataCateTemp.equals("0304")) onClickLink = "insertLog(3180);" + onClickLink;
                            if(dataCateTemp.equals("0209")) onClickLink = "insertLog(3181);" + onClickLink;
                            if(dataCateTemp.equals("0221")) onClickLink = "insertLog(3182);" + onClickLink;
                            if(dataCateTemp.equals("0212")) onClickLink = "insertLog(3183);" + onClickLink;
                            if(dataCateTemp.equals("0218")) onClickLink = "insertLog(3184);" + onClickLink;
                            if(dataCateTemp.equals("0201")) onClickLink = "insertLog(3185);" + onClickLink;
                            if(dataCateTemp.equals("0215")) onClickLink = "insertLog(3186);" + onClickLink;
                            if(dataCateTemp.equals("0301")) onClickLink = "insertLog(3187);" + onClickLink;
                            if(dataCateTemp.equals("0404")) onClickLink = "insertLog(3188);" + onClickLink;
                            if(dataCateTemp.equals("0408")) onClickLink = "insertLog(3189);" + onClickLink;
                            if(dataCateTemp.equals("0319")) onClickLink = "insertLog(5177);" + getCateLink("031901");
                            if(dataCateTemp.equals("9716")) onClickLink = "insertLog(5205);" + onClickLink;
                            if(dataCateTemp.equals("9720")) onClickLink = "insertLog(5206);" + onClickLink;
                            if(dataCateTemp.equals("9713")){
                                outStr += "<div "+menuDivStyle+"><a href='#' "+makeMOverClickFunction(strUserAgentStr,layerShowType,dataCateTemp+"98",onClickLink,strMobleAg)+">";
                            }else{  
                                outStr += "<div "+menuDivStyle+"><a href='#' "+makeMOverClickFunction(strUserAgentStr,layerShowType,dataCateTemp+"98",onClickLink,strMobleAg)+">";
                            }               
                        } else { 
                        //클릭안되는 중분류
                            if(dataCateTemp.equals("0822") || dataCateTemp.equals("9755") ){
                                outStr += "<div "+menuDivStyle+"><a href='#' "+makeMOverClickFunction(strUserAgentStr,layerShowType,dataCateTemp,"",strMobleAg)+" >";
                            //}else if(dataCateTemp.equals("0782") || dataCateTemp.equals("0783") || dataCateTemp.equals("0784") || dataCateTemp.equals("0785") || dataCateTemp.equals("0706") || dataCateTemp.equals("0796") ){
                                //outStr += "<div "+menuDivStyle+" style='height:20px;font-family:맑은 고딕;font-size:8pt;color:#3D3D3D;padding-left:10px;' onmouseover=\\\"CmdMcodeOver(this, "+layerShowType+");CmdSubMenuOver(this,'"+dataCateTemp+"');\\\"  onClick=\\\""+getCateLink(dataTempAry[2])+"\\\">";
                            }else if(dataCateTemp.equals("0611_1")){ 
                                outStr += "<div "+menuDivStyle+" style='height:34px;'><a href='#' "+makeMOverClickFunction(strUserAgentStr,layerShowType,dataCateTemp,getCateLink(dataTempAry[2]),strMobleAg)+">"; 
                            }else{ 
                                outStr += "<div "+menuDivStyle+"><a href='#' "+makeMOverClickFunction(strUserAgentStr,layerShowType,dataCateTemp,getCateLink(dataTempAry[2]),strMobleAg)+" >";
                            }
                        }
                    } else {
                        if(groupCnt>0) {
                            if(groupCateFirst.equals("037908") || groupCateFirst.equals("038307") || groupCateFirst.equals("037919")  ||  groupCateFirst.equals("038109") || groupCateFirst.equals("038318") ||  groupCateFirst.equals("038009")||  groupCateFirst.equals("038024")){
                                outStr += "<div id='group"+groupId+"' "+lineHeight+" style='color:#000000;margin:0px;padding:0px;' name='group"+groupId+"' "+menuDivStyle+"><a name=subMenuName href='#'<subcolorset2> " + makeSOverClickFunction(strUserAgentStr,true,strMobleAg)+"\\\""+getCateLink(dataCateTemp)+"\\\">";
                                groupCnt--;
                            }else{
                                outStr += "<div id='group"+groupId+"' "+lineHeight+" style='margin:0px;padding:0px;' name='group"+groupId+"' "+menuDivStyle+"><a name=subMenuName href='#' <subcolorset> " + makeSOverClickFunction(strUserAgentStr,true,strMobleAg)+"\\\""+getCateLink(dataCateTemp)+"\\\">";
                                groupCnt--;
                            }
                        } else {
                            if(dataCateTemp.equals("038001")  || dataCateTemp.equals("037901") || dataCateTemp.equals("037919")|| dataCateTemp.equals("038024") || dataCateTemp.equals("037908")|| dataCateTemp.equals("038009") ){
                                outStr += "<div "+menuDivStyle+" "+lineHeight+" style='margin:0px;padding:3px 0px 0px 0px;'>";
                            }else if(dataCateTemp.equals("038008") || dataCateTemp.equals("037907")){
                                outStr += "<div"+lineHeight+" style='margin:0px;padding:0px 0px 0px 0px;' "+menuDivStyle+"><a name=subMenuName href='#' " + makeSOverClickFunction(strUserAgentStr,false,strMobleAg);
                                /*
                                if(dataCateTemp.equals("038008")){
                                    outStr += " onClick=insertLog(7397);smart_cate();>";
                                }else if(dataCateTemp.equals("037907")){
                                    outStr += " onClick=insertLog(7400);smart_cate();>";
                                }
                                */
                                /*휴대폰 액세서리*/
                                if (dataCateTemp.equals("038008") || dataCateTemp.equals("037907")){
                                    outStr += " onClick=\\\""+getCateLink(dataCateTemp)+"\\\">";
                                }
                            }else if( dataTempAry[2].equals("038007") || dataTempAry[2].equals("038004") || dataTempAry[2].equals("038009") || dataTempAry[2].equals("038024") || dataTempAry[2].equals("038020") ||  dataTempAry[2].equals("038026") || dataTempAry[2].equals("038022") ||  dataTempAry[2].equals("038002") || dataTempAry[2].equals("038003")  || dataTempAry[2].equals("038006") || dataTempAry[2].equals("975724")
                                    || dataTempAry[2].equals("037906")  || dataTempAry[2].equals("037905") || dataTempAry[2].equals("037904")  || dataTempAry[2].equals("037920")  || dataTempAry[2].equals("037921") || dataTempAry[2].equals("037922") || dataTempAry[2].equals("975704") || dataTempAry[2].equals("975721")  || dataTempAry[2].equals("037903")       
                            ){  
                                outStr += "<div "+lineHeight+" style='margin:0px;padding:3px 0px 0px 0px;' "+menuDivStyle+"><a name=subMenuName href='#' " + makeSOverClickFunction(strUserAgentStr,true,strMobleAg)+"\\\""+getCateLink(dataCateTemp)+"\\\">";
                            }else{
                                outStr += "<div "+lineHeight+" style='' "+menuDivStyle+"><a name=subMenuName <EventReview> href='#' " + makeSOverClickFunction(strUserAgentStr,true,strMobleAg)+"\\\""+getCateLink(dataCateTemp)+"\\\">";
                            }
                        } 
                    } 

                    // 묶음카테 형태를 보여줌 
                    // 한칸띄기
                    if(!MCateFlag && PAllCate.indexOf(dataCateTemp)>-1 ) {
                        //if(etcCateHash.containsKey(etcNameCate) && etcCateHash.get(etcNameCate).toString().indexOf("<br>") > -1) {
                        if(groupCateFirst.equals("037908") || groupCateFirst.equals("038307") || groupCateFirst.equals("037919") ||  groupCateFirst.equals("038109") ||  groupCateFirst.equals("038318") ||  groupCateFirst.equals("038009") ||  groupCateFirst.equals("038024")){
                            outStr += "<<blankImg>align='absmiddle' width='10' height='5'>";
                        }
                        //}
                    }else if( dataTempAry[2].equals("038007") || dataTempAry[2].equals("038004") || dataTempAry[2].equals("038009") || dataTempAry[2].equals("038024") || dataTempAry[2].equals("038020") ||  dataTempAry[2].equals("038026") || dataTempAry[2].equals("038022") || dataTempAry[2].equals("038002") || dataTempAry[2].equals("038003") || dataTempAry[2].equals("038006") || dataTempAry[2].equals("975724")
                            || dataTempAry[2].equals("037906") || dataTempAry[2].equals("037905") || dataTempAry[2].equals("037904") || dataTempAry[2].equals("037920") || dataTempAry[2].equals("037921") || dataTempAry[2].equals("037922") || dataTempAry[2].equals("975704") || dataTempAry[2].equals("975721") || dataTempAry[2].equals("037903")
                            || dataTempAry[2].equals("038008") || dataTempAry[2].equals("037907") 
                             )
                    { 
                        outStr += "<<blankImg>align='absmiddle' width='10' height='5'>";                    
                    } else if(!MCateFlag) {
                        outStr += "<star1>";
                    }
                    // 소분류 인기 붙이기

 
                    if(!MCateFlag && ingiCate.indexOf(dataTempAry[2])>-1) {
                        outStr += "<ingi1>";
                    }
                    if(etcCateHash.containsKey(etcNameCate)) { 
                        cateNameTemp = etcCateHash.get(etcNameCate).toString();
                        if(cateNameTemp.indexOf("<br>") > -1 && !MCateFlag && PAllCate.indexOf(dataCateTemp)>-1 ){ 
                        }
                        outStr += cateNameTemp; 
                    } else {
                        // 중분류 인기마크 붙이기
                        //좌측

                        if(ControlUtil.compareValOR(new String[]{dataTempAry[2],
                            "1582","1509","0501","0352","0360","1582","0713","1586","1629","1205","1222","0292","1823","1574","1578","1588","0809","1587","2115","1455","1459","1821","0217","0201","9603","1892","1005","0695","1695","0481","0905","0908","0909","0910","1595","1007","0313"}) || (!keyTempAry[0].substring(keyTempAry[0].length()-2).equals("98") && ControlUtil.compareValOR(new String[]{dataTempAry[2],"0404_1"}))) 
                        {
                            if(!keyTempAry[0].substring(keyTempAry[0].length()-2).equals("98") && ControlUtil.compareValOR(new String[]{dataTempAry[2],"0201_1"}) ){
                            }else if(keyTempAry[0].substring(keyTempAry[0].length()-2).equals("98") && ControlUtil.compareValOR(new String[]{dataTempAry[2],"0304","0212","1809"}) ){
                            }else{ 
                                outStr += "<img src="+ConfigManager.IMG_ENURI_COM+"/images/topmenu/ingi_star.gif width=6px height=5px style='margin:0px 1px 5px 1px;' border=0 align=abstop>";
                            }
                        }
                        if(MCateFlag) {
                            // 중분류의 예외 결합 실행  시 제목변경


                            for(int k=0; k<mCateSum1.length; k++) {
                                if(mCateSum1[k].equals(dataTempAry[2])) {
                                    dataTempAry[1] = mCateSumName[k];
                                }
                            }
                            // 스포츠일때 제목 변경

                            if(dataTempAry[2].equals("1643")) { 
                                dataTempAry[1] = "악기, 디지털피아노";
                            }
                            if(keyTempAry[0].substring(keyTempAry[0].length()-2).equals("98") && ControlUtil.compareValOR(new String[]{dataTempAry[2],"0319"}) ){
                                dataTempAry[1] = "<span>스마트폰</span>";
                            } 
                            if(keyTempAry[0].substring(keyTempAry[0].length()-2).equals("98") && ControlUtil.compareValOR(new String[]{dataTempAry[2],"0225"}) ){
                                dataTempAry[1] = "<span onclick='insertLog(5178);'>하이브리드 디카</span>";
                            } 
                            if(dataTempAry[2].equals("9758") ||dataTempAry[2].equals("9759")) { 
                                dataTempAry[1] = "<b>"+dataTempAry[1]+"</b><img src="+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/point2.gif border=0 align=abstop>";
                            }
                            if(dataTempAry[2].equals("0305")) { 
                                dataTempAry[1] = "태블릿PC&nbsp;<img src="+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/point2.gif border=0 align=abstop>&nbsp;전자책";
                            }
                            if(dataTempAry[2].equals("0304")) { 
                                dataTempAry[1] = "휴대폰&nbsp;<img src="+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/point2.gif border=0 align=abstop>&nbsp;스마트폰";
                            }
                            if(dataTempAry[2].equals("0914")) {
                                dataTempAry[1] = "뉴발란스, 노스페이스..";
                            }
                            if(dataTempAry[2].equals("0380")) {
                                dataTempAry[1] = "액세서리";
                            }
                            if(dataTempAry[2].equals("0379")) {
                                dataTempAry[1] = "액세서리";
                            }
                            if(dataTempAry[2].equals("0602")) {
                                dataTempAry[1] = "냉장고";
                            }
                            if(dataTempAry[2].equals("0609")) {
                                dataTempAry[1] = "김치냉장고";
                            }
                            if(dataTempAry[2].equals("0601")) {
                                dataTempAry[1] = "전기밥솥";
                            }
                            if(dataTempAry[2].equals("0621")) {
                                dataTempAry[1] = "오븐,전자레인지";
                            }
                            if(dataTempAry[2].equals("0605")) {
                                dataTempAry[1] = "가스,전기레인지";
                            }
                            if(dataTempAry[2].equals("0606")) {
                                dataTempAry[1] = "커피메이커,머신";
                            }
                            if(dataTempAry[2].equals("0608")) {
                                dataTempAry[1] = "전기포트,그릴,튀김기";
                            }
                            if(dataTempAry[2].equals("0611")) { 
                                dataTempAry[1] = "홍삼액, 식품건조기";
                            } 
                            if(dataTempAry[2].equals("0502")) {
                                dataTempAry[1] = "세탁,건조기";
                            }
                            if(dataTempAry[2].equals("0211")) {
                                dataTempAry[1] = "프로젝터,스크린";
                            }
                            if(dataTempAry[2].equals("0215")) {
                                dataTempAry[1] = "블루레이,DVD,DivX";
                            }
                            if(dataTempAry[2].equals("0203")) {
                                dataTempAry[1] = "오디오,카세트,라디오";
                            }
                            if(dataTempAry[2].equals("0220")) {
                                dataTempAry[1] = "마이크,노래반주기";
                            }
                            if(dataTempAry[2].equals("0801")) { 
                                dataTempAry[1] = "기초(스킨, 로션..)";
                            }
                            if(dataTempAry[2].equals("2113")) { 
                                dataTempAry[1] = "내비게이션";
                            }
                            if(dataTempAry[2].equals("9762")) { 
                                dataTempAry[1] = "메모리카드, 카드리더";
                            } 
                            if(dataTempAry[2].equals("0790")) { 
                                dataTempAry[1] = "악마의게임 디아3";
                            }
                            if(dataTempAry[2].equals("0485")) { 
                                dataTempAry[1] = "그래픽, TV카드";
                            }
                            if(dataTempAry[2].equals("1022")) { 
                                dataTempAry[1] = "신생아, 감각발달완구";
                            }
                            if(dataTempAry[2].equals("0380")) { 
                                dataTempAry[1] = "<span style=font-size:8pt;>액세서리,주변기기</span>";
                            }
                            if(dataTempAry[2].equals("0379")) { 
                                dataTempAry[1] = "<span style=font-size:8pt;>액세서리,주변기기</span>";
                            }
                            if(dataTempAry[2].equals("0484")) { 
                                dataTempAry[1] = "램(RAM)";
                            }
                            if(dataTempAry[2].equals("1586") || dataTempAry[2].equals("0358") || dataTempAry[2].equals("1512") || dataTempAry[2].equals("1021") || dataTempAry[2].equals("0291") || dataTempAry[2].equals("0294") || dataTempAry[2].equals("1582")  || dataTempAry[2].equals("1481") ||  dataTempAry[2].equals("1694") || dataTempAry[2].equals("0694")|| dataTempAry[2].equals("1586")) { 
                                dataTempAry[1] = "<b>"+dataTempAry[1]+"</b>";
                            }
                            //if(dataTempAry[2].equals("0501") ) { 
                                //dataTempAry[1] = ""+dataTempAry[1]+"<img src="+ConfigManager.IMG_ENURI_COM+"/images/topmenu/air_book(1).gif width=43px height=10px border=0 align=bottom style='margin:0px 1px 1px 3px;'>";
                            //}
                            //if(dataTempAry[2].equals("0507")) { 
                                //dataTempAry[1] = dataTempAry[1]+"&nbsp;";
                            //} 
                            //if(dataTempAry[2].equals("0608")) { 
                                //dataTempAry[1] = "&nbsp;"+dataTempAry[1];
                            //}
                            if(dataTempAry[2].equals("0688")) { 
                                dataTempAry[1] = "TV용 액세서리, 셋톱박스";
                            }
                            if(dataTempAry[2].equals("1813")) { 
                                dataTempAry[1] = "악기,디지털피아노";
                            }
                           // if(dataTempAry[2].equals("0504")) { 
                          //      dataTempAry[1] = "전기,가스,석유히터";
                           // }
                            if(dataTempAry[2].equals("2122")) { 
                                dataTempAry[1] = "멀티소켓,전기용품";
                            }
                            // 시즌기획일 경우 변경  
                            if(dataTempAry[2].equals("1465")) { 
                                dataTempAry[1] = "<img src="+ConfigManager.IMG_ENURI_COM+"/images/topmenu/ingi_star.gif width=6px height=5px border=0 align=abstop style='margin:0px 1px 5px 1px;'>쌀쌀한데 뭐입지?!";
                            }
                            if(dataTempAry[2].equals("1640")) {
                                dataTempAry[1] = "<img src="+ConfigManager.IMG_ENURI_COM+"/images/main_2007/19top4.png width=18px height=14px border=0 align=absmiddle><<blankImg>align=absmiddle height=10 width=1>"+dataTempAry[1]+"";
                            }  
                            if(dataTempAry[2].equals("0817")) { 
                                dataTempAry[1] = "<img src="+ConfigManager.IMG_ENURI_COM+"/images/main_2007/icon_deadline.gif width=32px height=8px border=0 align=abstop><<blankImg>align=absmiddle height=10 width=1> "+dataTempAry[1];
                            }
                            if( dataTempAry[2].equals("1481")) {
                                dataTempAry[1] = dataTempAry[1] + "<img src="+ConfigManager.IMG_ENURI_COM+"/images/topmenu/ingi_star.gif width=6px height=5px border=0 align=abstop style='margin:0px 1px 5px 1px;'>";
                            }
                            if(dataTempAry[2].equals("1224") || dataTempAry[2].equals("1027")  || dataTempAry[2].equals("1010") || dataTempAry[2].equals("1221") || dataTempAry[2].equals("1099") || dataTempAry[2].equals("0820") ) {
                                dataTempAry[1] = dataTempAry[1] + "<img src="+ConfigManager.IMG_ENURI_COM+"/images/topmenu/ingi_star.gif width=6px height=5px border=0 align=abstop style='margin:0px 1px 5px 1px;'>";
                            }
                            if(dataTempAry[2].equals("1594") || dataTempAry[2].equals("1694")) {
                                dataTempAry[1] = dataTempAry[1] + "<img src="+ConfigManager.IMG_ENURI_COM+"/images/topmenu/ingi_star.gif width=6px height=5px border=0 align=abstop style='margin:0px 1px 5px 1px;'>";
                            }
                            if( dataTempAry[2].equals("1501") || dataTempAry[2].equals("2197") ||  dataTempAry[2].equals("0831") || dataTempAry[2].equals("0699")  || dataTempAry[2].equals("0927") || dataTempAry[2].equals("9717") || dataTempAry[2].equals("0290") || dataTempAry[2].equals("0490")  || dataTempAry[2].equals("2198") || dataTempAry[2].equals("0334")   ) {
                                dataTempAry[1] = "<img src="+ConfigManager.IMG_ENURI_COM+"/images/topmenu/ingi_star.gif width=6px height=5px border=0 align=abstop style='margin:0px 1px 5px 1px;'>"+dataTempAry[1];
                            }
                            if(dataTempAry[2].equals("1497")) {
                                dataTempAry[1] = "<img src="+ConfigManager.IMG_ENURI_COM+"/images/topmenu/ingi_star.gif width=6px height=5px style='margin:0px 1px 5px 1px;' border=0 align=abstop>"+dataTempAry[1];
                            }
                            if(dataTempAry[2].equals("0926") || dataTempAry[2].equals("2196") || dataTempAry[2].equals("1498")) {
                                dataTempAry[1] = "<img src="+ConfigManager.IMG_ENURI_COM+"/images/topmenu/ingi_star.gif width=6px height=5px border=0 align=abstop style='margin:0px 1px 5px 1px;'>"+dataTempAry[1];
                            }
                            if(dataTempAry[2].equals("0899") || dataTempAry[2].equals("0827") ) {
                                dataTempAry[1] = dataTempAry[1] + "<img src="+ConfigManager.IMG_ENURI_COM+"/images/topmenu/ingi_star.gif width=6px height=5px border=0 align=abstop style='margin:0px 1px 5px 1px;'>";
                            }
                            if(dataTempAry[2].equals("1586") || dataTempAry[2].equals("1509") ||  dataTempAry[2].equals("1587") || dataTempAry[2].equals("0927") || dataTempAry[2].equals("1582") || dataTempAry[2].equals("0899") || dataTempAry[2].equals("0820") || dataTempAry[2].equals("1498") || dataTempAry[2].equals("0926") || dataTempAry[2].equals("1458") || dataTempAry[2].equals("9717") || dataTempAry[2].equals("0290") || dataTempAry[2].equals("0490") || dataTempAry[2].equals("1099") || dataTempAry[2].equals("0699") || dataTempAry[2].equals("1594") ) {
                                dataTempAry[1] = "<b>" + dataTempAry[1] + "</b>";
                            }
                            if(dataTempAry[2].equals("9760") || dataTempAry[2].equals("9761")) { 
                                dataTempAry[1] = "<img src="+ConfigManager.IMG_ENURI_COM+"/images/topmenu/ingi_star.gif width=6px height=5px border=0 align=abstop style='margin:0px 1px 5px 1px;'> "+dataTempAry[1];
                            }
                            if( dataTempAry[2].equals("0828") || dataTempAry[2].equals("0832")   || dataTempAry[2].equals("9610")) {
                                dataTempAry[1] =  "<img src="+ConfigManager.IMG_ENURI_COM+"/images/topmenu/ingi_star.gif width=6px height=5px border=0 align=abstop style='margin:0px 1px 5px 1px;'>"+dataTempAry[1];
                            }
                        }
                        cateNameTemp = dataTempAry[1];
                        if(dataTempAry[2].length() == 4){
                           outStr += dataTempAry[1].replace(",",", ");
                          }else{
                           outStr += dataTempAry[1]; 
                          }
                        //우측 인기마크
                        if(ControlUtil.compareValOR(new String[]{dataTempAry[2],"1225","1289","1288","1229","1285","1602","1622","1642","0680","0225","1585","1622","0877","1484","1589","1512","0821","0807","0291","0923","0931","0404","0790","0791","2199","2117","0523","1615","0502","1809"})) {
                            if(keyTempAry[0].substring(keyTempAry[0].length()-2).equals("98") && ControlUtil.compareValOR(new String[]{dataTempAry[2],"0201"}) ){
                            }else{
                                outStr += "<img src="+ConfigManager.IMG_ENURI_COM+"/images/topmenu/ingi_star.gif width=6px height=5px style='margin:0px 1px 5px 1px;' border=0 align=abstop>";
                            }
                        }
                    }
                    // 소분류 인기 붙이기

                    if(!MCateFlag && ingiCate.indexOf(dataTempAry[2])>-1) {
                        outStr += "<ingi2>";
                    }
                    // 묶음카테 형태를 보여줌  왼쪽블랭크

                    if(!MCateFlag && PAllCate.indexOf(dataCateTemp)>-1) {
                        outStr += "<<blankImg> align='absmiddle' width='10' height='5'>";
                        
                        if( dataTempAry[2].equals("102305") || dataTempAry[2].equals("181214") || dataTempAry[2].equals("181215") || dataTempAry[2].equals("181217") || dataTempAry[2].equals("181218")){
                            outStr += "&nbsp;</span>";
                        }
                    }else if( dataTempAry[2].equals("038007") || dataTempAry[2].equals("038004") || dataTempAry[2].equals("038009") || dataTempAry[2].equals("038024") || dataTempAry[2].equals("038020") ||  dataTempAry[2].equals("038026") || dataTempAry[2].equals("038022") || dataTempAry[2].equals("038002") ||  dataTempAry[2].equals("038026") || dataTempAry[2].equals("038003")  || dataTempAry[2].equals("038006") || dataTempAry[2].equals("038002") || dataTempAry[2].equals("975724")
                            || dataTempAry[2].equals("037906") || dataTempAry[2].equals("037905") || dataTempAry[2].equals("037904") || dataTempAry[2].equals("037920") || dataTempAry[2].equals("037921") || dataTempAry[2].equals("037922") || dataTempAry[2].equals("975704") || dataTempAry[2].equals("975721") || dataTempAry[2].equals("037903")
                            || dataTempAry[2].equals("038008") || dataTempAry[2].equals("037907") 
                                 
                            )
                            
                    {   
                    } else {
                //  if( dataTempAry[2].equals("068002")|| dataTempAry[2].equals("068003")  || dataTempAry[2].equals("068004") || dataTempAry[2].equals("068005") || dataTempAry[2].equals("068006")  || dataTempAry[2].equals("068007") || dataTempAry[2].equals("068008")|| dataTempAry[2].equals("068009") || dataTempAry[2].equals("068010")){
                //          outStr += "<<blankImg> align='absmiddle' width='10' height='5'>";
                //          }else{
                        outStr += "<star2>";
                //      }
                    } 
                    if(cateNameTemp.indexOf(">+<")>-1 || cateNameTemp.indexOf("<star1>")>-1) {
                        if(outStr.lastIndexOf("<star1>")>-1) {
                            outStr = outStr.substring(0, outStr.lastIndexOf("<star1>")) + outStr.substring(outStr.lastIndexOf("<star1>")+7);

                        }
                        if(outStr.lastIndexOf("<star2>")>-1) {
                            outStr = outStr.substring(0, outStr.lastIndexOf("<star2>")) + outStr.substring(outStr.lastIndexOf("<star2>")+7);
                        }
                    }  
                    if(!MCateFlag && j == tempAryList.size()-1){
                        outStr += "<div style='height:2px;line-height:2px;margin:0px;padding:0px;'></div>";
                    }
                    outStr += "</a></div>";
                    // 해당 중분류명 아래에 공백0611 실선
                    if(  dataTempAry[2].equals("") ) {
                        outStr += "<div onMouseOver='mDivOver();' style='cursor:text;'> <!--  --> </div>";
                    }
                    if(dataTempAry[2].equals("038008") || dataTempAry[2].equals("038015") ||  dataTempAry[2].equals("037907") ||  dataTempAry[2].equals("037914") || dataTempAry[2].equals("059509") || dataTempAry[2].equals("059520") || dataTempAry[2].equals("059806") || dataCateTemp.equals("068010") || dataTempAry[2].equals("038306")|| dataTempAry[2].equals("038317")|| dataTempAry[2].equals("038108")|| dataTempAry[2].equals("038208")){
                        outStr += "<div style='overflow:hidden;height:1px;line-height:1px;background-repeat:repeat-x;background-image:url("+ConfigManager.IMG_ENURI_COM+"/images/topmenu/top_dot.gif);margin:5px 0px 2px 3px;'><img src='"+ConfigManager.ConstBlankImgSrc+"' style='height:1px;width:1px;'></div>";
                    }
                } 
            }
            if(MCateFlag  && !keyTempAry[0].equals("06")&& !keyTempAry[0].equals("04")) {
                String[] menuMCateAry   =   {"03", "05", "07", "09", "21", "10", "12", "16", "14", "08", "15"}; 
                int[] menuBtnHeightAry  =   { 13,  25,   23,   36,   43,   23,  95,   80,   27,   45,   55};
                //int[] menuBtnHeightAry    =   { 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 0,};
                int menuBtnHeight = 0; 
                for(int j=0; j<menuMCateAry.length; j++) { 
                    if(keyTempAry[0].equals(menuMCateAry[j])) {
                        menuBtnHeight = menuBtnHeightAry[j];
                    }
                } 
                String overKey = keyTempAry[0];
                if(overKey.equals("98")) overKey = "97";
                if(overKey.equals("06")) overKey = "05";
                if(overKey.equals("04")) overKey = "07";
                outStr += "<div id='allShowBtnDiv' style='position:relative;bottom:0px;cursor:default;padding-top:"+menuBtnHeight+"px;' onMouseOver='mDivOver();'>";
                //outStr += "<div id='allShowBtnDiv' style='cursor:default;' onMouseOver='mDivOver();'><table width='100%' border=0 cellspacing=0 cellpadding=0><tr><td style='border:1px solid #ff0000;' height='"+menuBtnHeight+"px' valign='bottom' align='right' style='font-size:17px;'>";
                outStr += "<img src='"+ConfigManager.IMG_ENURI_COM+"/images/topmenu/open_tx.gif'  onclick=\\\"insertLog(423);Cmd_Sitemap('"+overKey+"');\\\" style='cursor:pointer;'>";
                //outStr += "</td><td valign='bottom' style='padding-bottom:3px;' align='right'><img src='"+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/arrow/btn_close.gif' width='9px' height='9px' align='absmiddle' onclick='CmdHideMenu();' style='cursor:pointer;'></td></tr></table>";
                //outStr += "</td></tr></table>";
                outStr += "</div>";
            }

            endStr = "";

            String classNameStr = "";
            if(MCateFlag) {
                if(twoColsFlag) {
                    classNameStr = "menu_m_left";
                } else {
                    classNameStr = "menu_m_right";
                }
            }
            if(ControlUtil.compareValOR(new String[]{keyTempAry[0],"10","08","15","14"})) {
                if(MCateFlag && !twoColsFlag) {
                    classNameStr = "menu_m_left";
                    outStr = outStr.replaceAll("this, 1", "this, 2");
                }
            } 

            if(MCateFlag) {
                firstStr += " class='"+classNameStr+"'>";
            }

            // 왼쪽 레이어의 위치를 바꿈
            if(twoColsFlag) {
                outStr = outStr.replaceAll("this, 1", "this, 2");
                outStr = outStr.replaceAll("this, 3", "this, 1");
            }

            if(!keyTempAry[0].equals("04") && !keyTempAry[0].equals("07") && !keyTempAry[0].equals("05") && !keyTempAry[0].equals("06")) {
                outStr = firstStr + outStr + endStr;
            }

            if(tempAryList.size()>1) {
                outDivHash.put(keyTempAry[0], outStr);
            }
        }

        // 원분류를 이용하는 카테고리의 디자인을 변경(좌,우 구분 변경)
        String[] mCate1 = {"0680","0688","0385","0384","1684","1685","1686","0597","0697","0681","0682","0683","0684","0685","0686","0687","1289","1290","1291","1292","1294","1295","1296","1297","1618","1619","1616","1630","1214","1212","1211","1216","1811","9403","9408","9409","9410","9411","9412","9401","9415","9402","9404","9405","9406","0780","9411","9412","9413","9414","9407","1474","1475","1477","0690","1809","0694","1806","1223","0791","0792","0793","0417","0794","0795","0492","0493","0494","0495","0496","0497","0991","0992","0993","9601","9602","9603","9604","9605","9606","9609","0291","9724","9725","9726","9727","9730","9731","1805","0815","0528","0697","0698","1475","1028","0529","9751","0419","8901","8902","8903","8904","8906","8907","8908","8909","1002","9762","9607","9611","0797","0798","0781","0782","0784","0785","0481","0482","0483","0484","0485","0486","0487","0293","0786","0294","0226","0214","0231","0407","0342","0410","0706"};
        String[] mCate2 = {"0201","0224","2201","2202","0514","0510","0515","0610","0502","0211","0215","0208","0357","0203","0220","2206","1803","1822","1801","1802","0402","0527","1807","1808","0513","0408","1813","1209","1613","1607","1606","1631","1613","0401","0602","0609","0605","1202","1201","0201","1623","0208","0502","0503","0501","0418","1202","1201","1208","1213","0601","0913","0920","1015","0506","0345","9003","0527","0507","0404","2203","0305","0305","0401","0405","0712","0702","0709","0710","0704","2207","0515","0510","0521","0209","0221","0225","0206","0222","2201","0207","9418","0313","0404","2203","0212","0345","0318","0402","0408","0610","0502","0503","0923","1620","0418","0335","1803","0515","0510","0516","1636","0904","0929","0521","1501","0812","2208","2208","2202","0402","0408","0414","0402","1803","2205","0713","0707","0708","0703","0705","0711","0701","2208","0420","9750","2206","2201","2202","2205","2208","2203","2207"};

        for(int i=0; i<mCate1.length; i++) {
            String tempCateData = "";
            if (outDivHash.get(mCate2[i]) != null){
                tempCateData = outDivHash.get(mCate2[i]).toString();
                outDivHash.put(mCate1[i], tempCateData);
            }
        }

        // 중분류의 예외 결합
        for(int k=0; k<mCateSum1.length; k++) { 
            String tempCateData1 = "";
            String tempCateData2 = "";
            if (outDivHash.get(mCateSum1[k]) != null){
                tempCateData1 = outDivHash.get(mCateSum1[k]).toString();
            }
            if (outDivHash.get(mCateSum2[k]) != null){
                tempCateData2 = outDivHash.get(mCateSum2[k]).toString();
            }
//          String cateMidleStr = "<div style='width:100%;height:1px;background-image:url("+ConfigManager.IMG_ENURI_COM+"/images/main_2008/topmenu/bg_2.gif);margin-top:3px;'><img src='"+ConfigManager.ConstBlankImgSrc+"' height=1 width=1></div>";
            String cateMidleStr = "<div style='overflow:hidden;height:1px;line-height:1px;background-repeat:repeat-x;background-image:url("+ConfigManager.IMG_ENURI_COM+"/images/topmenu/top_dot.gif);margin:2px 0px 2px 3px;'><img src='"+ConfigManager.ConstBlankImgSrc+"' style='height:1px;width:1px;'></div>";
            String tmpmCateSumName1 = "";
            String tmpmCateSumName2 = "";

            tempCateData1 = tempCateData1.replace("</div></td></tr></table>", "</div>");
            if(tempCateData2.indexOf("<div")>0) {
                tempCateData2 = tempCateData2.substring(tempCateData2.indexOf("<div"));;
            }

            if(mCateSum1[k].equals("9417")){    tmpmCateSumName1 = "<span style=padding-left:6px;padding-top:2px;height:17px;cursor-pointer:none;color:#014C90;><b>노트북↓</b></span>";        
                                                tmpmCateSumName2 = "<span style=padding-left:6px;padding-top:2px;height:17px;cursor-pointer:none;color:#014C90;><b>데스크탑↓</b></span>";
            }
            outDivHash.put(mCateSum1[k], tmpmCateSumName1+tempCateData1+cateMidleStr+tmpmCateSumName2+tempCateData2);
        }

        // 실제 출력하는 부분

        Iterator outDivKey = outDivHash.keySet().iterator();
        for(int i=0; outDivKey.hasNext(); i++) {
            String tempKey = outDivKey.next().toString();

            boolean printFlag = true;

            // 중분류의 예외 결합 실행  시 제거 부분

            for(int k=0; k<mCateSum2.length; k++) {
                if(mCateSum2[k].equals(tempKey)) printFlag = false;
            }

            // 소분류 보여주지 말아야 할 예외처리
            if(ControlUtil.compareValOR(new String[]{tempKey,"1697","2122","1696","1811","0309","0334","0223","1809"})) {
                printFlag = false;
            }
            if(printFlag) out.println("parent.menuAry['"+tempKey+"']=\"" + outDivHash.get(tempKey).toString() + "\";");
        }

    } catch(Exception e) {
        out.println("e.toString() = "+e.toString());
    }
    /*
%>
if(menuDataType==1) {
    onTopMenuOnClickFlag = false;
    CmdMenuClick(selectObj, selectMenuNum);
}
if(menuDataType==2) {
    onKbMenuOnClickFlag = false;
    CmdKBOver(0, null);
}
<%
    */
%>
<%!
    private String makeMOverClickFunction(String strAgent,String layerShowType,String strSubCate,String strClickLink,String strMobleAg){
        boolean bMobile = false;
        String strReturn = "";

        if( (strAgent.indexOf("Android") >= 0 && strAgent.indexOf("Linux") >= 0 ) || (strAgent.indexOf("iPhone") >= 0 && strAgent.indexOf("Mac") >= 0) || (strAgent.indexOf("iPad") >= 0 && strAgent.indexOf("Mac") >= 0)   || strMobleAg.equals("y")  ){
            bMobile = true;
        }

        if (bMobile){
            strReturn +=" ontouchstart=\\\"CmdMobileClick(this, "+layerShowType+",'"+strSubCate+"',function(){"+strClickLink+"})\\\"";
            //strReturn +=" onclick=\\\"CmdMobileClick(this, "+layerShowType+",'"+strSubCate+"',function(){"+strClickLink+"})\\\"";
        }else{
            strReturn +=" onmouseover=\\\"CmdMcodeOver(this, "+layerShowType+");CmdSubMenuOver(this,'"+strSubCate+"');\\\"";
            if (strClickLink.trim().length() > 0 ){
                strReturn +=" onclick=\\\""+strClickLink+"\\\" onfocus=\\\"this.blur()\\\" ";
            }
        }
        return strReturn;
    }
    private String makeSOverClickFunction(String strAgent,boolean bEvent,String strMobleAg){
        boolean bMobile = false;
        String strReturn = "";
        if( (strAgent.indexOf("Android") >= 0 && strAgent.indexOf("Linux") >= 0 ) || (strAgent.indexOf("iPhone") >= 0 && strAgent.indexOf("Mac") >= 0) || (strAgent.indexOf("iPad") >= 0 && strAgent.indexOf("Mac") >= 0)  || strMobleAg.equals("y") ){
            bMobile = true;
        }
        if (!bMobile){
            strReturn +=" <mouseOverOut> ";
        }
        if (bEvent){
            if (bMobile){
                strReturn +="ontouchstart=";
            }else{
                strReturn +="onfocus=\\\"this.blur()\\\"  onclick=";
            }
        }
        return strReturn;
    }
    private String makeGroupSOverClickFunction(String strAgent,String groupId, String strClickLink,String strMobleAg){
        boolean bMobile = false;
        String strReturn = "";

        if( (strAgent.indexOf("Android") >= 0 && strAgent.indexOf("Linux") >= 0 ) || (strAgent.indexOf("iPhone") >= 0 && strAgent.indexOf("Mac") >= 0) || (strAgent.indexOf("iPad") >= 0 && strAgent.indexOf("Mac") >= 0) || strMobleAg.equals("y")  ){
            bMobile = true;
        }
        

        if (bMobile){
            strReturn +=" ontouchstart=\\\"CmdMobileGroupClick(function(){"+strClickLink+"})\\\"";
        }else{
            strReturn +=" onmouseover=\\\"CmdGroupCcodeOver(this,'group"+groupId+"', 1);\\\" onmouseout=\\\"CmdGroupCcodeOut(this,'group"+groupId+"', 1);\\\" onfocus=\\\"this.blur()\\\"  onclick=\\\""+strClickLink+"\\\"";
        }
        return strReturn;   
    }
    
%>