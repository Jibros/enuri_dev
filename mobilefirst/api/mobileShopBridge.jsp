<%@page import="com.enuri.bean.edeal.Edeal_Order_Proc"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Shop_Bridge_Log_Data"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Shop_Bridge_Log_Proc"%>
<jsp:useBean id="Moble_Shop_Bridge_Log_Data" class="com.enuri.bean.mobile.Mobile_Shop_Bridge_Log_Data"
	scope="page" />
<jsp:useBean id="Moble_Shop_Bridge_Log_Proc" class="com.enuri.bean.mobile.Mobile_Shop_Bridge_Log_Proc"
	scope="page" />
<%@page import="com.enuri.bean.event.Members_Friend_Proc2"%>
<%@ page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_PD_Data"%>
<%@ page import="com.enuri.bean.mobile.PDManager_T1_Data"%>
<%@page import="com.enuri.bean.member.Join_Data"%>
<%
//t1=@@@&enuri_id=@@@&shop_code=@@@&order_no=@@@&user_data=@@@
	//20171113 손진욱 t1 pd 모듈
	PDManager_Proc pdmanager = new PDManager_Proc();
	PDManager_T1_Data t1Data = pdmanager.getT1(request);
	
	String strLoginYN = ChkNull.chkStr(request.getParameter("loginYN"),"");
	String strShopcode = ChkNull.chkStr(request.getParameter("shopcode"),"");
	String strServerNm = ChkNull.chkStr(request.getServerName());
	boolean blCheck_t1 = false;

	String strT1_fdate = "";
	String strT1_enuriid = "";
	String strT1_userdata = "";
	String strAppType = "A";
	
	if (t1Data != null && t1Data.isData() && t1Data.isInFireDate()) {
		strT1_enuriid = t1Data.getStrT1_enuriid();
		strT1_userdata = t1Data.getStrT1_userdata();
		if(strT1_userdata.length()>16) strAppType = "I";
		strT1_fdate = t1Data.getStrT1_fdate();
		blCheck_t1 = true;
	}
	
	boolean returnVal = false;
	
	if(blCheck_t1){
		Mobile_Shop_Bridge_Log_Data msbld = new Mobile_Shop_Bridge_Log_Data();
		
		msbld.setEnr_usr_id(strT1_enuriid);
		msbld.setEnr_usr_dat(strT1_userdata);
		msbld.setSpm_cd(strShopcode);
		msbld.setLogin_yn(strLoginYN);
		msbld.setMobl_mchnt_dcd(strAppType);
		
		returnVal = Moble_Shop_Bridge_Log_Proc.insertShopBridgeLog(msbld);
		
		//////////////////////쇼핑몰 연결 프로모션///////////////////////
		SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
		String strToday = formatter.format(new Date()); 	
		int intToday = Integer.parseInt(strToday);
		
		boolean blCerti = false; //본인인증 여부
		boolean IsEnuriEmployee = false; // 임직원여부
		int intEventReturnCd = -5; // 1 : 지급완료 , 0 : 지급 X, -1 : 본인 인증X, -2 : 임직원 O, -3 : 쇼핑몰 중복(본인인증키값 기준) , -5 : 초기값
		int intSpmCd = Integer.parseInt(strShopcode);
		boolean blEventChk = false;
		String strEvntCd = Moble_Shop_Bridge_Log_Proc.getEventId(intSpmCd); //event_main에서 가져오기  
		String strConf_ci_key = "";
		int intRewardPoint = 0;
		
       	Edeal_Order_Proc edeal_order_proc = new Edeal_Order_Proc();
       	if(strT1_enuriid.length()>0) 	IsEnuriEmployee = edeal_order_proc.isEnuriEmployee(strT1_enuriid);
		
       	if(!IsEnuriEmployee) { //임직원X
       		Join_Data join_Data = new Join_Data();
       		Members_Friend_Proc2 members_Friend_Proc2 = new Members_Friend_Proc2();
       		join_Data =  members_Friend_Proc2.getMemberData(strT1_enuriid);
       		strConf_ci_key = join_Data.getConf_ci_key();//본인인증여부
       		
       		if(!strConf_ci_key.equals("")) { //본인인증 O
       			blEventChk =true;
       		} else { //본인인증 X
       			intEventReturnCd = -1 ;
       		}
		} else { //임직원O
			intEventReturnCd = -2 ;
		}
		
		if (blEventChk) {
			int intEvntChkResult = -1; 
			intEvntChkResult = Moble_Shop_Bridge_Log_Proc.connShopEventChk(intSpmCd, strT1_enuriid, strConf_ci_key); //중복 확인
			if(intEvntChkResult == 0) { //중복 X
				try{
					intEventReturnCd = Moble_Shop_Bridge_Log_Proc.insertConnShopEventReward(strEvntCd, strT1_enuriid, intSpmCd, strConf_ci_key); //중복이 아닐 경우 이머니 지급
					intRewardPoint = Moble_Shop_Bridge_Log_Proc.getEventReward(strEvntCd);
				}catch(Exception e){}
			} else { //중복 O
				intEventReturnCd = -3;
			}
		}
		
		out.println("{");
		out.println("	   \"sEnuri_id\": \""+ strT1_enuriid +"\", ");
		out.println("	   \"sUser_data\": \""+ strT1_userdata +"\", ");
		out.println("	   \"sShop_code\": \""+ strShopcode +"\", ");
		out.println("	   \"sLoginYN\": \""+ strLoginYN +"\", ");
		out.println("	   \"strAppType\": \""+ strAppType +"\", ");
		/*쇼핑몰연결 프로모션*/
		out.println("	   \"connShopEventObj\": { ");
		out.println("	   				\"returnCode\": \""+ intEventReturnCd +"\", ");
		out.println("	   				\"rewardPoint\": \""+ intRewardPoint +"\", ");
		out.println("	   				\"url\": \"http://"+strServerNm+"/mobilefirst/event2021/m_connShopEvt.jsp\" ");
		out.println("	   	} ");
		/**/
		out.println("}");
	}
%>