<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.notification.Goods_Notification_Proc"%>
<jsp:useBean id="Goods_Notification_Proc" class="com.enuri.bean.notification.Goods_Notification_Proc" scope="page" />
<%
	String sNotiKind = "1";
	String pn_userid = ChkNull.chkStr(request.getParameter("userid"));
	if(pn_userid.equals("")) pn_userid = "null";
	String pn_modelno = ChkNull.chkStr(request.getParameter("modelno"),"");
	
	String pn_setprice = ChkNull.chkStr(request.getParameter("setprice"),"");
	String pn_mailaddr = "";
	String pn_phonenum1 = ChkNull.chkStr(request.getParameter("phonenum1"),"");
	String pn_phonenum2 = ChkNull.chkStr(request.getParameter("phonenum2"),"");
	String pn_phonenum3 = ChkNull.chkStr(request.getParameter("phonenum3"),"");
	
	pn_setprice = pn_setprice.replace(".","");
	pn_setprice = pn_setprice.replace(",","");
/*
	System.out.println("sNotiKind : "+ sNotiKind );
	System.out.println("pn_userid : "+ pn_userid  );
	System.out.println("pn_modelno : "+ pn_modelno  );
	System.out.println("pn_setprice : "+ pn_setprice  );
	
	System.out.println("pn_phonenum1 : "+ pn_phonenum1  );
	System.out.println("pn_phonenum2 : "+ pn_phonenum2  );
	System.out.println("pn_phonenum3 : "+ pn_phonenum3  );
	System.out.println("pn_phonenum : "+ pn_phonenum  );
*/
	String pn_phonenum = "";
	if( !pn_phonenum1.equals("") && !pn_phonenum2.equals("") && !pn_phonenum3.equals("") ) {
		pn_phonenum = pn_phonenum1 + "-" + pn_phonenum2 + "-" + pn_phonenum3;
	}
  	
	int n_pn_modelno = (pn_modelno.equals("")) ? 0 : Integer.parseInt(pn_modelno);
	int n_pn_setprice = (pn_setprice.equals("")) ? 0 : Integer.parseInt(pn_setprice);

	int phone_limit = 10;
	if( !pn_phonenum.equals("") && !Goods_Notification_Proc.IsAbleSendSMS(pn_phonenum, phone_limit) ) {
		pn_phonenum = "";
%>
<script type="text/javascript">
	alert("월 최대 발송량을 초과하였습니다.\n다음달에 이용해주세요");
	
	window.parent.priceNotiClose();
</script>
<%
	} else {
%>



<%
	if( !sNotiKind.equals("") && !pn_modelno.equals("")
		 && !(sNotiKind.equals("1") && pn_setprice.equals("")) && !pn_phonenum.equals("")
	 ) { // && !pn_userid.equals("")  && !pn_phonenum.equals("")
		Goods_Notification_Proc.insertNotification(pn_userid, n_pn_modelno, n_pn_setprice, sNotiKind, pn_mailaddr, pn_phonenum);
%>
<script type="text/javascript">
	alert("<%=(sNotiKind.equals("1")?"가격":"판매")%>알림이 신청되었습니다.");
	
	window.parent.priceNotiClose();
</script>
<%		
	} else {

%> 
<script type="text/javascript">
	alert("<%=(sNotiKind.equals("1")?"가격":"판매")%>알림 신청이 실패 했습니다.\n지속적인 오류 발생 시 관리자에게 문의하여 주시기 바랍니다.");
	
	window.parent.priceNotiClose();
</script>
<%		
	}
}
%>