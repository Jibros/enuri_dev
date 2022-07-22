<%@ page import="java.io.*" %>
<%@page import="org.json.simple.parser.*" %>
<%
/*
{
	"shopcode" : 4027,
	"logno_view" : "12628",
	"logno_click" : "12629",
	"s_date" : "2015.06.29. 14:00",
	"e_date" : "2015.08.31. 23:59",
	"category" : ["02","03","05","06","09","10","12","15","16","21","24"],
	"is_icon_view" : "N"
}	
 */
JSONParser parser = new JSONParser();
//Object obj = parser.parse(new FileReader("webapps/ROOT/lsv2016/include/detail/mini_shop_bid.json"));
Object obj = parser.parse(new FileReader("/was/lena/1.3/depot/lena-application/ROOT/lsv2016/include/detail/mini_shop_bid.json"));

int intBidShopcode_1 = 0;  			//첫번째 쇼핑몰번호
int intBidShopcode_2 = 0;  			//두번째 쇼핑몰번호

String strS_date_1 = "";  				//첫번째 시작일시
String strE_date_1 = ""; 				//첫번째 종료일시
String strS_date_2 = "";  				//두번째 시작일시
String strE_date_2 = ""; 				//두번째 종료일시

String is_icon_view_1 = "";				// 스폰서 아이콘 노출 여부에 대한 플래그 - N 일경우 Shop_bid Flag 값을 변경 하지 않는다. 
String is_icon_view_2 = "";	

boolean blShop_bid = false;
boolean blShop_bid_1 = false;
boolean blShop_bid_2 = false;
int tmpShopBidCate_lowcnt = 0;	//동일최저가갯수
int tmpShopBidCate_idx_1 = 0;
int tmpShopBidCate_idx_2 = 0;
int tmpShopBidCate_reidx_1 = 0;
int tmpShopBidCate_reidx_2 = 0;

String nowDateTime = com.enuri.util.date.DateStr.nowStr("yyyy.MM.dd. HH:mm");

if(obj != null){		//상위입찰이 있으면...
	org.json.simple.JSONObject jsonObject = (org.json.simple.JSONObject) obj;
	org.json.simple.JSONArray jsonArray = (org.json.simple.JSONArray) jsonObject.get("bidlist");
	
	for(int i = 0; i < jsonArray.size(); i++){	
		org.json.simple.JSONObject jsonTemp = (org.json.simple.JSONObject)jsonArray.get(i);

		org.json.simple.JSONArray cateList = (org.json.simple.JSONArray) jsonTemp.get("category");
		
		String strShopcode = (String) jsonTemp.get("shopcode");  			//쇼핑몰번호
		if(i == 0){
			intBidShopcode_1 = Integer.parseInt(strShopcode);
			strLogno_view_1 = (String) jsonTemp.get("logno_view");  		//view 개별로그
			strLogno_click_1 = (String) jsonTemp.get("logno_click");  		//click out 개별로그
			strS_date_1 = (String) jsonTemp.get("s_date");  				//시작일시
			strE_date_1 = (String) jsonTemp.get("e_date"); 					//종료일시 
			
			is_icon_view_1 = (String) jsonTemp.get("is_icon_view");  		// 스폰서 아이콘 노출 여부
			
			if(nowDateTime.compareTo(strS_date_1)>0 && nowDateTime.compareTo(strE_date_1)<=0){					//상위입찰이 있고, 날짜가 해당이 되면... 
				if(!strCate2.equals("")){																									//카테고리가 있고
					 for(int ii = 0; ii < cateList.size(); ii++){																			//해당카테고리이면...
						 if(cateList.get(ii).equals(strCate2)){
							 blShop_bid = true;
							 blShop_bid_1 = true;
						 }
					 }
				}
			}
			
		}else if(i == 1){
			intBidShopcode_2 = Integer.parseInt(strShopcode);
			strLogno_view_2 = (String) jsonTemp.get("logno_view");  		//view 개별로그
			strLogno_click_2 = (String) jsonTemp.get("logno_click");  		//click out 개별로그
			strS_date_2 = (String) jsonTemp.get("s_date");  				//시작일시
			strE_date_2 = (String) jsonTemp.get("e_date"); 					//종료일시 
			
			is_icon_view_2 = (String) jsonTemp.get("is_icon_view");  		// 스폰서 아이콘 노출 여부
			
			if(nowDateTime.compareTo(strS_date_2)>0 && nowDateTime.compareTo(strE_date_2)<=0){					//상위입찰이 있고, 날짜가 해당이 되면... 
				if(!strCate2.equals("")){																									//카테고리가 있고
					 for(int ii = 0; ii < cateList.size(); ii++){																			//해당카테고리이면...
						 if(cateList.get(ii).equals(strCate2)){
							 blShop_bid = true;
							 blShop_bid_2 = true;
						 }
					 }
				}
			}
		}
	}

	/*
	System.out.println("intBidShopcode_1>>>"+intBidShopcode_1 +"<br>");
	System.out.println("strLogno_view_1>>>"+strLogno_view_1 +"<br>");
	System.out.println("strLogno_click_1>>>"+strLogno_click_1 +"<br>");
	System.out.println("strS_date_1>>>"+strS_date_1 +"<br>");
	System.out.println("strE_date_1>>>"+strE_date_1 +"<br>");
	System.out.println("intBidShopcode_2>>>"+intBidShopcode_2 +"<br>");
	System.out.println("strLogno_view_2>>>"+strLogno_view_2 +"<br>");
	System.out.println("strLogno_click_2>>>"+strLogno_click_2 +"<br>");
	System.out.println("strS_date_2>>>"+strS_date_2 +"<br>");
	System.out.println("strE_date_2>>>"+strE_date_2 +"<br>");
	
	System.out.println("blShop_bid>>>"+blShop_bid +"<br>");
	System.out.println("blShop_bid_1>>>"+blShop_bid_1 +"<br>");
	System.out.println("blShop_bid_2>>>"+blShop_bid_2 +"<br>");
	*/
}

if(blShop_bid){	//상위입찰기간이며, 카테고리까지 맞으면 쇼핑몰 상위입찰 시작
	//1위 찾기
	Pricelist_Data tempShopBidCateData_1 = null;
    Pricelist_Data tempShopBidCateData_2 = null;
	//동일 최저가 몇개인지 : 2개 이상일때만 의미있음
	
	long tmpShopBidCate_price = aszPlist[0].getInstance_price();
	
	for(int ii=0; ii<aszPlist.length && aszPlist[ii].getInstance_price() == tmpShopBidCate_price;ii++) {
			tmpShopBidCate_lowcnt++;
	}
	
	//out.println("blShop_bid_1>>"+blShop_bid_1 + "<br>");
	//out.println("blShop_bid_1>>"+blShop_bid_2 + "<br>");
	//out.println("tmpShopBidCate_lowcnt>>"+tmpShopBidCate_lowcnt + "<br>");
	if(blShop_bid_1 && tmpShopBidCate_lowcnt > 1){
		if(tmpShopBidCate_idx_1==0){
			//쇼핑몰 상품 찾기 (상품코드로 못찾았을때도)
			for(int ii=0; ii<aszPlist.length && aszPlist[ii].getInstance_price() == tmpShopBidCate_price; ii++) {
				if(tempShopBidCateData_1==null){
					tempShopBidCateData_1 = aszPlist[ii].cloneMe();
					tmpShopBidCate_reidx_1 = ii+1;
				}
				if(aszPlist[ii].getShop_code() == intBidShopcode_1){
					tmpShopBidCate_idx_1 = ii+1;
				}
				if(tmpShopBidCate_reidx_1>0 && tmpShopBidCate_idx_1>0){
					break;
				}
			}
		}
		//재정렬
		if(tempShopBidCateData_1 != null && tmpShopBidCate_idx_1 > 0){
			if(tmpShopBidCate_idx_1 != tmpShopBidCate_reidx_1){
				aszPlist[tmpShopBidCate_reidx_1-1] = aszPlist[tmpShopBidCate_idx_1-1].cloneMe();
				aszPlist[tmpShopBidCate_idx_1-1] = tempShopBidCateData_1.cloneMe();
			}
			
			if (is_icon_view_1.equals("Y")) {
				aszPlist[tmpShopBidCate_reidx_1-1].setShop_bid(1);
			}
			aszPlist[tmpShopBidCate_reidx_1-1].setShop_bid_catetype(strCate4);
		}
	}
	
	 //2위 찾기
	if(blShop_bid_2 && tmpShopBidCate_lowcnt > 1){
	    if(tmpShopBidCate_idx_2==0){
	    	if(tmpShopBidCate_idx_1 == 0){
	    		tmpShopBidCate_reidx_1 = 0;
	    	}
	        //쇼핑몰 상품 찾기 (상품코드로 못찾았을때도)
	        for(int ii=tmpShopBidCate_reidx_1; ii<aszPlist.length && aszPlist[ii].getInstance_price() == tmpShopBidCate_price;ii++) {
                if(tempShopBidCateData_2==null){
                    tempShopBidCateData_2 = aszPlist[ii].cloneMe();
                    tmpShopBidCate_reidx_2 = ii+1;
                }
                if(aszPlist[ii].getShop_code()==intBidShopcode_2){
                    tmpShopBidCate_idx_2 = ii+1;
                }
	            if(tmpShopBidCate_reidx_2>0 && tmpShopBidCate_idx_2>0){
	                break;
	            }
	        }
	    }
	    //2위 재정렬
	    if(tempShopBidCateData_2 != null && tmpShopBidCate_idx_2 > 0){
	        if(tmpShopBidCate_idx_2!=tmpShopBidCate_reidx_2){
	            aszPlist[tmpShopBidCate_reidx_2-1] = aszPlist[tmpShopBidCate_idx_2-1].cloneMe();
	            aszPlist[tmpShopBidCate_idx_2-1] = tempShopBidCateData_2.cloneMe();
	        }
	        
	        if (is_icon_view_1.equals("Y")) {
	        	aszPlist[tmpShopBidCate_reidx_2-1].setShop_bid(2);
			}	        
	        aszPlist[tmpShopBidCate_reidx_2-1].setShop_bid_catetype(strCate4);
	        //if(shopBidGoods[1].equals(aszPlist[tmpShopBidCate_reidx_2-1].getGoodscode())){
	        //    aszPlist[tmpShopBidCate_reidx_2-1].setShop_bid_goodscode(aszPlist[tmpShopBidCate_reidx_2-1].getGoodscode());
	        //}
	    }else{
	        tmpShopBidCate_reidx_2 = 0;
	    }
	}
	
	//System.out.println("tmpShopBidCate_idx_1>>"+tmpShopBidCate_idx_1);
	//System.out.println("tmpShopBidCate_idx_2>>"+tmpShopBidCate_idx_2);
	//System.out.println("tmpShopBidCate_reidx_1>>"+tmpShopBidCate_reidx_1);
	//System.out.println("tmpShopBidCate_reidx_2>>"+tmpShopBidCate_reidx_2);
}

%>