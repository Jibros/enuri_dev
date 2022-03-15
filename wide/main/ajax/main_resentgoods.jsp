<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="javax.servlet.http.Cookie"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="org.json.*"%>
<%@ page import="java.util.*"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="com.enuri.bean.main.Main_SuggestGoods_Proc"%>
<%
	//cate a = 전체
	String cate = ChkNull.chkStr(request.getParameter("cate"),"A");

	String strTodayPrices 	= "";
	
	String[] arrStrTodayGoods;
	String[] arrStrTodayPrices;
	
	ArrayList<Integer> arrTodayGoodsModelno = new ArrayList<Integer>();
	ArrayList<Long> arrTodayGoodsPlno    = new ArrayList<Long>();
	
	int iTodayCnt = 0;

    String strTodayGoods = cb.GetCookie("MYTODAYGOODS","MODELNOS");
    
    String[] todayGoods = StringUtils.split(strTodayGoods, ",");
    
    String adult= ChkNull.chkStr(cb.GetCookie("MEM_INFO","ADULT"));
    
    JSONObject result = new JSONObject ();
    
	//strTodayGoods 	= cb.GetCookie("MYTODAYGOODS","MODELNOS");
	//strTodayPrices 	= cb.GetCookie("MYTODAYGOODS","MINPRICE");

	Main_SuggestGoods_Proc main_suggestgoods_proc = new Main_SuggestGoods_Proc();
	
    //String[] resentLists = StringUtils.split(resentList, ",");
    
    ArrayList al = new ArrayList();
    
    for(int i=0; i < todayGoods.length ;i++){
    	String modelno = todayGoods[i];
    	if(modelno.indexOf("G:") > -1){
    		al.add(modelno.replace("G:", ""));
    	}
    }
    ArrayList modelnos = new ArrayList() ;
    JSONObject resultJson = new JSONObject();
    if(al.size() > 0){

    	JSONArray jsonArr = new JSONArray (); 
  		List<JSONObject> listall = new ArrayList();
        
        for(int i=0; i < al.size(); i++){
        	
        	if(i > 8) break;
        	String modelno= StringUtils.defaultString((String)al.get(i));
        	//System.out.println("modelno : "+modelno);
        	
        	//List<JSONObject> list = main_suggestgoods_proc.getGoodsFromCateLike(modelno, adult);
        	//listall.addAll(list);
        	modelnos.add(modelno);
        }
	  	//result.put("cateLikeList", shuffleJsonArray(listall));		  		
	  	//Collections.shuffle(listall);
        //result.put("cateLikeList", listall );
        
        //Collections.sort(modelnos, Collections.reverseOrder());
        
        if(modelnos.size() > 0){
        	resultJson = main_suggestgoods_proc.getGoodsFromCate(modelnos,adult); //인기상품 연관상품
            resultJson.put("myGoods",main_suggestgoods_proc.getGoodsFromMyGoods(adult,modelnos)); 
            resultJson.put("cateList",main_suggestgoods_proc.getMyGoodsCateArr(modelnos));
            resultJson.put("resentlist",modelnos);
        }
        //63461640   에누리표준PC 게이밍용 IY-331 [16GB, M2 256GB]
        // 1,509,910 65253811
        
    }
    out.println(resultJson.toString());
    /*
    A. [전체] 선택 시 > 비교제안 제공 불가 
    - 최대 15개 노출 (3판)
    - 카테고리 당 노출 수량은 PRD 의 기준을 따름 (p.22 3번 설명) 
    - 노출 상품 수량 미만 시
    ▶ 5개 이상 시 슬라이드 버튼 노출 (확보된 수량만큼 무한 롤링)
    ▶ 5개 미만 시 슬라이드 버튼 미노출 (1판만 확보된 수량만큼 노출) 

    B. 소카테고리 선택 > 비교제안 제공 불가
    - 최대 15개 노출 (3판) 
    - 1판 당 '내가본상품' 1개 고정 노출 + 그외 추천상품 5개 (6*3 =18)
    - 노출 상품 수량 15개 미만 시 
    ▶ 5개 이상 시 슬라이드 버튼 노출 
    ▶ 5개 미만 시 슬라이드 버튼 미노출 (1판만 확보된 수량만큼 노출)

    C. 소카테고리 선택 > 비교제안 제공 가능
    - 소카테고리 비교제안 탭 당 최대 15개 노출 (3판)
    - 1판 당 '내가 본 상품' 1개 고정 노출 + 그외 비교제안 상품 5개 (6*3 =18) 
    - 노출 수량 미달 시 : 
    ▶ 5개 이상 시 슬라이드 버튼 노출 
    ▶ 5개 미만 시 슬라이드 버튼 미노출 (1판만 확보된 수량만큼만 노출)
    */
%>	    