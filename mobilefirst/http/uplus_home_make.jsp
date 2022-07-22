<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*,java.text.*,java.net.*"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.simple.*"%>
<%@page import="java.io.*"%>
<%@page import="com.enuri.util.common.*"%>
<%
	if (!valideIp(request.getRemoteAddr())){
		System.out.println("uplus Invalid Request Ip : " + request.getRemoteHost());
		return;
	}

    String callback = StringUtils.defaultString(request.getParameter("callback"));
	StringBuilder  htmlTmp = new StringBuilder();
    
    String fileGoods = "/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/api/main/mobile_mainlistfix.json";	//상품
	String fileBanner = "/was/lena/1.3/depot/lena-application/ROOT/mobilenew/gnb/category/mainBanner.json"; //메인배너
    
    htmlTmp.append("<link rel='stylesheet' type='text/css' href='http://imgenuri.enuri.gscdn.com/images/mobilefirst/css/enuri_up.css' />");
	htmlTmp.append("<div class='Maincontent'>");
	htmlTmp.append("        <ul class='m_depth'>");
	htmlTmp.append("            <li><span>디지털/가전</span></li>");
	htmlTmp.append("            <li><span>컴퓨터</span></li>");
	htmlTmp.append("            <li><span>스포츠/자동차</span></li>");
	htmlTmp.append("            <li><span>유아/식품</span></li>");
	htmlTmp.append("            <li><span>가구/생활/건강</span></li>");
	htmlTmp.append("            <li><span>패션/잡화</span></li>");
	htmlTmp.append("            <li><span>도서/여행/취미</span></li>");
	htmlTmp.append("            <li><span>쇼핑팁</span></li>");
	htmlTmp.append("        </ul>");
	/*
	htmlTmp.append("        <!-- 메인 배너 -->");
	htmlTmp.append("        <h3 class='maintit'>오늘의 혜택</h3>");
	htmlTmp.append("        <div class='mainbnr'>");
	htmlTmp.append("            <button type='button' class='slick-prev slick-arrow'>Previous</button>");
	htmlTmp.append("            <button type='button' class='slick-next slick-arrow'>Previous</button>");
	htmlTmp.append("            <ul class='evtbnr'>");
	
	JSONArray jsonArray =  fileJsonArrayRead(fileBanner);
	//jsonArray = shuffleJsonArray(jsonArray);
	for(int i=0; i < jsonArray.size() ; i++){
	   JSONObject jo = (JSONObject)jsonArray.get(i);
	   String img =  (String)jo.get("TARGET");
	   String jurl1 =  (String)jo.get("JURL1");
	   String txt1 =  (String)jo.get("TXT1");
	   
	   if("banner_2_samsung".equals(txt1))          continue;
	   
	   if( i == 0 ) 	       htmlTmp.append("                <li data-id='"+i+"' onclick=\"enuriHome.enuri_goLink('"+jurl1+"' , '"+txt1+"')\"><img src='"+img+"' alt=''  /></li>     ");
	   else	               htmlTmp.append("                <li data-id='"+i+"' style=\"display:none\" onclick=\"enuriHome.enuri_goLink('"+jurl1+"' , '"+txt1+"')\"><img src='"+img+"' alt=''  /></li>     ");
	}
	htmlTmp.append("            </ul>");
	htmlTmp.append("        </div>");
	*/
	htmlTmp.append("        <!--// 메인 배너 -->");
	htmlTmp.append("        <!-- 오늘의 추천상품 -->");
	htmlTmp.append("        <h3 class='maintit'>에누리 추천상품</h3>");
	htmlTmp.append("         <div class='today_goods'>");
	htmlTmp.append("            <ul class='today_list'>");
	htmlTmp.append( makeList(fileJsonRead(fileGoods)) );
	htmlTmp.append("            </ul>");
	htmlTmp.append("         </div>");
	htmlTmp.append("        <!--// 오늘의 추천상품 -->");
	htmlTmp.append("        <!--  인기쇼핑몰 -->");
	htmlTmp.append("        <div class='shop_mall'>");
	htmlTmp.append("            <h3 class='maintit'>인기 쇼핑몰</h3>");
	htmlTmp.append("            <ul class='newMallList'>");
	htmlTmp.append("                <!--1번줄-->");
	htmlTmp.append("                <li><a href='javascript:///'><img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/tmp/logo_gmarket.gif' alt='지마켓'></a></li>                                               ");
	htmlTmp.append("                <li><a href='javascript:///'><img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/tmp/logo_auction.gif' alt='옥션'></a></li>                                                 ");
	htmlTmp.append("                <li><a href='javascript:///'><img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/tmp/logo_11st.gif' alt='11번가'></a></li>                                                  ");
	htmlTmp.append("                <li><a href='javascript:///'><img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/tmp/logo_interpark.gif' alt='인터파크'></a></li>                                           ");
	htmlTmp.append("                <!--2번줄-->");
	htmlTmp.append("                <li><a href='javascript:///'><img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/tmp/img_logo02.gif' alt='신세계몰'></a></li>                                               ");
	htmlTmp.append("                <li><a href='javascript:///'><img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/tmp/logo_lotte.gif' alt='롯데닷컴'></a></li>                                               ");
	htmlTmp.append("                <li><a href='javascript:///'><img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/tmp/img_logo03.gif' alt='현대H몰'></a></li>                                                ");
	htmlTmp.append("                <li><a href='javascript:///'><img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/tmp/img_logo_AKmall.gif' alt='ak mall'></a></li>                                           ");
	htmlTmp.append("                <!--3번줄-->");
	htmlTmp.append("                <li><a href='javascript:///'><img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/tmp/img_logo05.gif' alt='GS SHOP'></a></li>                                                ");
	htmlTmp.append("                <li><a href='javascript:///'><img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/tmp/img_logo06.gif' alt='CJmall'></a></li>                                                 ");
	htmlTmp.append("                <li><a href='javascript:///'><img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/tmp/img_logo07.gif' alt='롯데 홈쇼핑'></a></li>                                           ");
	htmlTmp.append("                <li><a href='javascript:///'><img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/tmp/img_logo09.gif' alt='홈앤쇼핑'></a></li>                                               ");
	htmlTmp.append("                <!-- 4번째줄 -->");
	htmlTmp.append("                <li><a href='javascript:///'><img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/tmp/logo_wema.gif' alt='위메프'></a></li>                                                  ");
	htmlTmp.append("                <li><a href='javascript:///'><img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/tmp/logo_timon.gif' alt='티몬'></a></li>                                                   ");
	htmlTmp.append("                <li><a href='javascript:///'><img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/tmp/logo_boribori.gif' alt='보리보리'></a></li>                                                 ");
	htmlTmp.append("                <li><a href='javascript:///'><img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/tmp/logo_g9.gif' alt='G9'></a></li>                                                        ");
	htmlTmp.append("                <!--5번줄-->");
	htmlTmp.append("                <li><a href='javascript:///'><img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/tmp/logo_ellotte.gif' alt='엘롯데'></a></li>                                               ");
	htmlTmp.append("                <li><a href='javascript:///'><img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/tmp/img_logo04.gif' alt='갤러리아'></a></li>                                               ");
	htmlTmp.append("                <li><a href='javascript:///'><img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/tmp/img_logo_ns.gif' alt='NSmall'></a></li>                                              ");
	htmlTmp.append("                <li><a href='javascript:///'><img src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/images/tmp/img_logo11.gif' alt='이마트'></a></li>");
	htmlTmp.append("            </ul>");
	htmlTmp.append("        </div>");
	//htmlTmp.append("        <!--  인기쇼핑몰 -->");
	//htmlTmp.append("        <ul class='family_app'>");
	//htmlTmp.append("        <li><a href='javascript:enuriHome.goSmartInstall();'>스마트택배</a></li>");
    //htmlTmp.append("        <li><a href='javascript:enuriHome.goHotDealInstall();'>소셜가격비교</a></li>");
    //htmlTmp.append("        <li><a href='javascript:enuriHome.goHomeShoppingInstall();'>홈쇼핑 가격비교</a></li>");
    //htmlTmp.append("        <li><a href='javascript:enuriHome.directBuyInstall();'>해외직구</a></li>");
	//htmlTmp.append("        </ul>");
	htmlTmp.append("    </div>");
    
    htmlTmp.append("<script type='text/javascript' src='http://imgenuri.enuri.gscdn.com/images/mobilefirst/js/uplusHome.js'></script>");
    htmlTmp.append("<script language='JavaScript' src='http://imgenuri.enuri.gscdn.com/common/js/Log_Tail_Mobile.js'></script>    ");
    
    JSONObject jSONObject = new JSONObject(); 
    jSONObject.put("uplusGoodsList",htmlTmp.toString());
    
    if(!callback.equals("")){
       out.println(callback+"("+jSONObject.toString()+")");
    }
%>
<%!
    private JSONArray fileJsonRead(String filepath){
    
    StringBuilder sbJson = new StringBuilder(); 
    try{
        FileInputStream fis = new FileInputStream(new File(filepath)); 
        InputStreamReader isr = new InputStreamReader(fis,"UTF-8"); 
        BufferedReader br = new BufferedReader(isr);    
    
        while(true){
            String str = br.readLine();
            if(str==null) break;
            sbJson.append(str);
        }
    }catch(Exception e){
        e.printStackTrace();
    }
    
        JSONArray ja = new JSONArray(); 
	    try{
	        org.json.simple.parser.JSONParser jSONParser = new org.json.simple.parser.JSONParser();  
		    JSONObject jsonObject = (JSONObject) jSONParser.parse(sbJson.toString());
		    ja = (JSONArray)jsonObject.get("MainJsonfix"); 
	    
	    }catch(Exception e){}
	    return ja;
    }
%>
<%!
    private JSONArray fileJsonArrayRead(String filepath){
    StringBuilder sbJson = new StringBuilder(); 
    try{
        FileInputStream fis = new FileInputStream(new File(filepath)); 
        InputStreamReader isr = new InputStreamReader(fis,"UTF-8"); 
        BufferedReader br = new BufferedReader(isr);    
        while(true){
            String str = br.readLine();
            if(str==null) break;
            sbJson.append(str);
        }
    }catch(Exception e){
        e.printStackTrace();
    }
        JSONArray ja = new JSONArray(); 
        try{
            org.json.simple.parser.JSONParser jSONParser = new org.json.simple.parser.JSONParser();  
            ja = (JSONArray) jSONParser.parse(sbJson.toString());
        
        }catch(Exception e){}
        return ja;
    }
%>

<%!
private String makeList(JSONArray ja){
    StringBuilder sb = new StringBuilder();
    String fileMBanner = "/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/ajax/middle_banner.json"; //미들배너
    JSONArray jsonMArray =  fileJsonArrayRead(fileMBanner);
    jsonMArray = shuffleJsonArray(jsonMArray);
    
    for(int i=0; i < ja.size() ; i ++){
        
        JSONObject jSONObject = (JSONObject)ja.get(i);
        String modelnm = StringUtils.defaultString((String)jSONObject.get("modelnm"),"");
        String modelno = StringUtils.defaultString((String)jSONObject.get("modelno"),"");
        String pl_no = StringUtils.defaultString((String)jSONObject.get("pl_no"),"");
        String part = StringUtils.defaultString((String)jSONObject.get("part"),"");
        String img = StringUtils.defaultString((String)jSONObject.get("img"),"");
        String badge_yn = StringUtils.defaultString((String)jSONObject.get("badge_yn"),"");
        
        String bbs_staravg = StringUtils.defaultString((String)jSONObject.get("bbs_staravg"),"0");
        int bbs_staravgInt = Integer.parseInt(bbs_staravg)*2;
        
        String price = StringUtils.defaultString((String)jSONObject.get("price"),"0");
        int priceInt = Integer.parseInt(price);
        price = String.format("%,d", priceInt);        
        
        String mallcnt = StringUtils.defaultString((String)jSONObject.get("mallcnt"),"0");
        String shopcode = String.valueOf(jSONObject.get("shopcode"));
		String shopImg = "http://imgenuri.enuri.gscdn.com/images/view/ls_logo/2013/Ap_logo_"+shopcode+".png";
        
        String section = StringUtils.defaultString((String)jSONObject.get("section"));
        String section_txt = StringUtils.defaultString((String)jSONObject.get("section_txt"));
        String categorynm = StringUtils.defaultString((String)jSONObject.get("categorynm"));
        String category = StringUtils.defaultString((String)jSONObject.get("category"));
        
        String bbs_cnt = StringUtils.defaultString((String)jSONObject.get("bbs_cnt"),"0");
        String title = StringUtils.defaultString((String)jSONObject.get("title"));
        String subtitle = StringUtils.defaultString((String)jSONObject.get("subtitle"));
        String title_bg = StringUtils.defaultString((String)jSONObject.get("title_bg"));
        String url = StringUtils.defaultString((String)jSONObject.get("url"));
        String section_url = StringUtils.defaultString((String)jSONObject.get("section_url"));
        
        if( category.equals("0304") || category.equals("0709") || category.equals("0305") || category.equals("0318") ) continue;
        
        if( "C".equals(part) ||  "T".equals(part) ){
                sb.append("                <li>                        ");
			    sb.append("                    <a href='javascript:///' data-url='"+url+"' data-shop='"+shopcode+"' data-model='"+modelno+"' data-plno='"+pl_no+"' data-part='"+part+"' data-cate='"+category+"' data-catenm='"+categorynm+"' >");
			    sb.append("                        <div class='thum'><img src='"+img+"' alt='' /></div>");
				    
				    if("Y".equals("badge_yn")){
				    sb.append("                        <span class='hotpic'>HOT PICK</span>");
				    }
                
                if(!"".equals(title)){
                String tbg = "";
                    if(!"".equals(title_bg)){
                         tbg = "style='background:"+title_bg+"'"; 
                    }
                    sb.append("                        <p class='ment' "+tbg+"  ><em>"+title+"<br />"+subtitle+"</em></p>");                    
			    }
			    
			    if("1634".equals(shopcode)){
			     sb.append("                        <span class='mall txt'>컴퓨존</span>");
			    }else if("6695".equals(shopcode)){
			    sb.append("                        <span class='mall txt'>멸치쇼핑</span>");
			    }else if("7807".equals(shopcode)){
                sb.append("                        <span class='mall txt'>넷트루</span>");
			    }else if("7939".equals(shopcode)){
	            sb.append("                        <span class='mall txt'>마리오아울렛</span>");
			    }else{
			     sb.append("                        <span class='mall'>");
			     sb.append("                              <img src='"+shopImg+"'  onerror=\"if (this.src != 'http://imgenuri.enuri.gscdn.com/images/mobilefirst/noimg_plan.png') this.src = 'http://imgenuri.enuri.gscdn.com/images/mobilefirst/noimg_plan.png'\"   alt='' /> ");
			     sb.append("                        </span>");
			    }
			    sb.append("                        <div class='titarea'><strong>"+modelnm+"</strong></div>");
			    sb.append("                        <div class='price'>");
			    sb.append("                            <span class='sale'><b>38</b>%</span>");
			    sb.append("                            <span class='prc'><b>"+price+"</b>원</span>");
			    sb.append("                        </div>");
			    sb.append("                    </a>");
			    
			    sb.append("<div class='info_btn' data-no='"+modelno+"' >");
				    
				    if(!section.equals("")){
				        sb.append("<span class='comt' >"+section_txt+"</span>");
				        
				    }else if(  !"0".equals(bbs_cnt)   ){
				        
				        sb.append("<span class='comt' >상품평 ("+bbs_cnt+")");
	                    sb.append("    <span class='star_graph ico_m'> ");
	                         if(  bbs_staravgInt > 0 ) {
	                             sb.append("<span class='ico_m' style='width:"+bbs_staravgInt+"%'>별점</span>");
	                         }
	                    sb.append("    </span> ");
	                    sb.append("</span>");
	                    sb.append("<span class='pr'>가격비교<em>"+mallcnt+"</em></span>");
				    
				    }else if( "0".equals(bbs_cnt) ){
	                    sb.append("<span class='go_store' data-cate='"+category+"' data-catenm='"+categorynm+"' ><em>"+categorynm+"</em></span>");
	                    sb.append("<span class='pr'>가격비교<em>"+mallcnt+"</em></span>");
				    }
				    
				    sb.append("</div>");
			    sb.append("</li>");
        }else if("P".equals(part) ){
        
            sb.append("<li>");
	            sb.append("<div class='guide' data-plan='"+section_url+"' data-title='"+title+"'>");
	                if("".equals(title)){
                        sb.append("<div class='cam_tip img'>");
                            sb.append("<div class='txtbox'></div>");
                            sb.append("<img src='"+img+"'  alt='' onerror=\"if (this.src != 'http://imgenuri.enuri.gscdn.com/images/mobilefirst/noimg_plan.png') this.src = 'http://imgenuri.enuri.gscdn.com/images/mobilefirst/noimg_plan.png'\" >");
                        sb.append("</div>");		                
	                }else{
	                   sb.append("<div class='cam_tip'>");
                            sb.append("<div class='txtbox'><span id='subtxt'>"+title+"<em id='ptxt'><br>"+subtitle+"</em></span></div>");
                            sb.append("<img src='"+img+"'  alt='' onerror=\"if (this.src != 'http://imgenuri.enuri.gscdn.com/images/mobilefirst/noimg_plan.png') this.src = 'http://imgenuri.enuri.gscdn.com/images/mobilefirst/noimg_plan.png'\" >");
                        sb.append("</div>");
	                }
	            
	            JSONArray subArray = (JSONArray)jSONObject.get("sublist");
	            sb.append("<ul class='buy_tip'>");
	            for( int j =0; j < subArray.size(); j++ ){
	               JSONObject planObj = (JSONObject)subArray.get(j);
	               String subimg = StringUtils.defaultString((String)planObj.get("enuri_img"),""); 
	               String subModelnm = StringUtils.defaultString((String)planObj.get("modelnm"),"");
	               String minprice3 = StringUtils.defaultString((String)planObj.get("minprice3"),"");
	               String subUrl = StringUtils.defaultString((String)planObj.get("url"),"");
	               
	               int minprice3Int = Integer.parseInt(minprice3);
                   minprice3 = String.format("%,d", minprice3Int);        
	               
	               String subShop_img = StringUtils.defaultString((String)planObj.get("shop_img"),"");
	               String subEnuri_img = StringUtils.defaultString((String)planObj.get("enuri_img"),"");
	               
	               subimg = StringUtils.replace(subimg , "http://photo3.enuri.com/" , "http://photo3.enuri.gscdn.com/");
                   subEnuri_img = StringUtils.replace(subEnuri_img , "http://photo3.enuri.com/" , "http://photo3.enuri.gscdn.com/");
	               
	               sb.append("<li data-vip='"+subUrl+"' data-nm='"+subModelnm+"' data-ord='"+(j+1)+"'>");
		               sb.append("<a href='javascript:///' >");
	                        sb.append("<img src='"+subimg+"'  onerror=\"if (this.src != '"+subEnuri_img+"') this.src = '"+subEnuri_img+"';\"   >");
	                        sb.append("<span class='tit'>"+subModelnm+"</span>");
	                        sb.append("<b>"+minprice3+"<em>원</em></b>");
	                   sb.append("</a>");
	               sb.append("</li>");
	            }
	            sb.append("</ul>");
	            sb.append("</div>");
            sb.append("</li>");
        }else if("N".equals(part)){
            /* 일반상품 제거
            sb.append("                <li>");
                sb.append("                    <a href='javascript:///' data-url='"+url+"' data-shop='"+shopcode+"' data-model='"+modelno+"' data-plno='"+pl_no+"' data-part='"+part+"' data-cate='"+category+"' data-catenm='"+categorynm+"' >");
                sb.append("                        <div class='thum'><img src='"+img+"' alt='' /></div>");
                if("Y".equals("badge_yn")){
                sb.append("                        <span class='hotpic'>HOT PICK</span>");
                }
                if(!"".equals(title)){
                String tbg = "";
                    if(!"".equals(title_bg)){
                         tbg = "style='background:"+title_bg+"'"; 
                    }
                    sb.append("                        <p class='ment' "+tbg+"  ><em>"+title+"<br />"+subtitle+"</em></p>");                    
                }
                sb.append("                        <span class='mall'><img src='"+shopImg+"' alt='' /></span>");
                sb.append("                        <div class='titarea'><strong>"+modelnm+"</strong></div>");
                sb.append("                        <div class='price'>");
                sb.append("                            <span class='sale'><b>38</b>%</span>");
                sb.append("                            <span class='prc'><b>"+price+"</b>원</span>");
                sb.append("                        </div>");
                sb.append("                    </a>");
                sb.append("                </li>");
             */
        }
        if(i == 3 ){
            if(jsonMArray.size() > 0){
                JSONObject objTemp = (JSONObject)jsonMArray.get(0);
                String TARGET = (String)objTemp.get("TARGET");
                String JURL1 = (String)objTemp.get("JURL1");
                String TXT1 = (String)objTemp.get("TXT1");
                sb.append("<li class='bnrarea'>");
                sb.append("                    <a href='javascript:///' data-url='"+JURL1+"' data-part='A' data-txt='"+TXT1+"'>");
                sb.append("<img src='"+TARGET+"' onerror=\"if (this.src != 'http://imgenuri.enuri.gscdn.com/images/mobilefirst/noimg_plan.png') this.src = 'http://imgenuri.enuri.gscdn.com/images/mobilefirst/noimg_plan.png';\">");
                sb.append("                     </a>");
                sb.append("</li>");
            }
        }
    }
    return sb.toString();
}
%>
<%!
    //랜덤
    private JSONArray shuffleJsonArray (JSONArray array) {
        // Implementing Fisher–Yates shuffle
        try{
	        Random rnd = new Random();
	            for (int i = array.size() - 1; i >= 0; i--){
	              int j = rnd.nextInt(i + 1);
	              // Simple swap
	              Object object = array.get(j);
	              array.add(j, array.get(i));
	              array.add(i, object);
	            }
        }catch(Exception e){}
        return array;
    }
%>
<%!
	private boolean valideIp(String strIp){
		boolean bReturn = false;
		String[] astrAcceptIp = {"112.175.191.131",
								 "112.175.191.147",
								 "112.175.191.157",
								 "112.175.191.174",
								 "112.175.191.175",
								 "112.175.191.179",
								 "112.175.191.186",
								 "112.175.191.187",
								 "121.189.40.130",
								 "121.170.135.148"
								 };
		
        for (int i=0;i<astrAcceptIp.length;i++){
            if(strIp.indexOf(astrAcceptIp[i]) >= 0 ){ 
                bReturn = true;
            }
        }
        return bReturn;
	}
%>