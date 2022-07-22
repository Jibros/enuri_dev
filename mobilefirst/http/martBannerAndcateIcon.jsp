<%@page import="com.enuri.util.common.CommonFtp"%>
<%@page import="com.oroinc.net.ftp.*"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.Writer"%>
<%@page import="java.io.UnsupportedEncodingException;"%>
<%@page import="java.io.FileNotFoundException;"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%
            JSONObject jsonMainBanner = new JSONObject();
            JSONArray jSONArray = new JSONArray();
            
            JSONObject jsonTemp = new JSONObject();
            jsonTemp.put("img", "http://img.enuri.gscdn.com/images/mobilefirst/planlist/B_20160530164500/B_20160530164500_main.png");
            jsonTemp.put("txt", "기획전");
            jsonTemp.put("link", "http://m.enuri.com/mobilefirst/planlist.jsp?t=B_20160530164500");
            jsonTemp.put("sdata", "20160601");
            jsonTemp.put("edata:", "20160831");
            jsonTemp.put("aos", "Y");
            jsonTemp.put("ios", "Y");
            
            jSONArray.put(jsonTemp);
            
            jsonTemp = new JSONObject();
            jsonTemp.put("img", "http://img.enuri.gscdn.com/images/mobilefirst/planlist/B_20160530115900/B_20160530115900_main.png");
            jsonTemp.put("txt", "기획전");
            jsonTemp.put("link", "http://m.enuri.com/mobilefirst/planlist.jsp?t=B_20160530115900");
            jsonTemp.put("sdata", "20160601");
            jsonTemp.put("edata:", "20160831");
            jsonTemp.put("aos", "Y");
            jsonTemp.put("ios", "Y");
            jSONArray.put(jsonTemp);
            
            jsonMainBanner.put("banner", jSONArray);
            
            JSONObject jsonCate = new JSONObject();
            jSONArray = new JSONArray(); 
            
            jsonTemp = new JSONObject();
            jsonTemp.put("iconImg", "http://storage.enuri.gscdn.com/Web_Storage/pic_upload/mobile/160330135853_main.jpg");
            jsonTemp.put("txt", "신선식품");
            jsonTemp.put("cateCode", "15130102");
            jSONArray.put(jsonTemp);
            
            jsonTemp = new JSONObject();
            jsonTemp.put("iconImg", "http://storage.enuri.gscdn.com/Web_Storage/pic_upload/mobile/160330135853_main.jpg");
            jsonTemp.put("txt", "육류/생성");
            jsonTemp.put("cateCode", "15600");
            jSONArray.put(jsonTemp);
            
            jsonTemp = new JSONObject();
            jsonTemp.put("iconImg", "http://storage.enuri.gscdn.com/Web_Storage/pic_upload/mobile/160330135853_main.jpg");
            jsonTemp.put("txt", "음류/유제품");
            jsonTemp.put("cateCode", "15600");
            jSONArray.put(jsonTemp);
            
            jsonTemp = new JSONObject();
            jsonTemp.put("iconImg", "http://storage.enuri.gscdn.com/Web_Storage/pic_upload/mobile/160330135853_main.jpg");
            jsonTemp.put("txt", "라면/과자/햄");
            jsonTemp.put("cateCode", "15600");
            jSONArray.put(jsonTemp);
            
            jsonTemp = new JSONObject();
            jsonTemp.put("iconImg", "http://storage.enuri.gscdn.com/Web_Storage/pic_upload/mobile/160330135853_main.jpg");
            jsonTemp.put("txt", "냉장/냉동식품");
            jsonTemp.put("cateCode", "15600");
            jSONArray.put(jsonTemp);
            
            jsonTemp = new JSONObject();
            jsonTemp.put("iconImg", "http://storage.enuri.gscdn.com/Web_Storage/pic_upload/mobile/160330135853_main.jpg");
            jsonTemp.put("txt", "기저귀/유아");
            jsonTemp.put("cateCode", "15600");
            jSONArray.put(jsonTemp);
            
            jsonTemp = new JSONObject();
            jsonTemp.put("iconImg", "http://storage.enuri.gscdn.com/Web_Storage/pic_upload/mobile/160330135853_main.jpg");
            jsonTemp.put("txt", "헤어/뷰티");
            jsonTemp.put("cateCode", "15600");
            jSONArray.put(jsonTemp);
            
            jsonTemp = new JSONObject();
            jsonTemp.put("iconImg", "http://storage.enuri.gscdn.com/Web_Storage/pic_upload/mobile/160330135853_main.jpg");
            jsonTemp.put("txt", "세제/주방용품");
            jsonTemp.put("cateCode", "15600");
            jSONArray.put(jsonTemp);
            
            jsonTemp = new JSONObject();
            jsonTemp.put("iconImg", "http://storage.enuri.gscdn.com/Web_Storage/pic_upload/mobile/160330135853_main.jpg");
            jsonTemp.put("txt", "생활용품");
            jsonTemp.put("cateCode", "15600");
            jSONArray.put(jsonTemp);
            
            jsonCate.put("cateIcon", jSONArray);
            
            JSONObject jsonInfo =new JSONObject();
            jsonInfo.put("icon", jsonCate);
            jsonInfo.put("top", jsonMainBanner);
            
            String fileName = "bannerAndCate.json";
            if(jsonFileWrite(jsonInfo,filePath+fileName)){
                ftpSend(fileName);
            }
%>
<%!

    private boolean jsonFileWrite(JSONObject jSONObject,String fileName){
        
        boolean result = false;
        
        try {
            //파일생성
            File file = new File(fileName);
            file.createNewFile();

            BufferedWriter wt = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), "UTF-8"));
            
            wt.write(jSONObject.toString());
            wt.close();
            
            logInfo(fileName+" createFile completion");
            
            result = true;
        } catch (IOException e) {
            logFail("********* MoblieMartGoodsAgent jsonFileWrite**************:"+e);
            System.out.println("********* MoblieMartGoodsAgent jsonFileWrite **************:"+e);
        }
        
        return result; 

    }


%>



<%!    
    //운영에 생성된 파일들 전송
    public boolean ftpSend(ArrayList ipList) throws ExceptionManager{
        
        boolean result = false; 

        int port = 21;
        String ftpId = "lena";
        String ftpPw = "#cloud2021";
        
        try {
            
            String putUrl = "/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/http/json/";
            
            //ftp 전송
            for(int i = 0; i<ipList.size() ;i++){
                
                //CommonFtp(String ip, int port , String id , String pw)        
                CommonFtp commonFtp = new CommonFtp((String)ipList.get(i),port,ftpId,ftpPw); 
                commonFtp.login();
                commonFtp.cd("/was/lena/1.3/depot/lena-application/ROOT/mobilefirst/http/json");
                commonFtp.put("bannerAndCate.json","bannerAndCate.json",putUrl);
                
                commonFtp.disconnect();
                
                System.out.println((String)ipList.get(i)+" 전송 완료");
                
            }
            result = true;
        } catch (Exception e) {
            System.out.println("Mobile_gnb_Proc ftp 전송 오류"+e);
            result = true;
        }

        
        return result ;
        
    }
%>
