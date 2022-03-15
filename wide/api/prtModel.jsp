<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>
<%@ include file="/wide/include/IncSearch.jsp"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<jsp:useBean id="Goods_Proc" class="com.enuri.bean.main.Goods_Proc" scope="page" />
<%

	/**
	 * @history
	 	2021.03.09. 최조작성
	 	원본 lsv2016/include/IncListPrinter.jsp
	*/
	
	int intPrtModelNo = ChkNull.chkInt(request.getParameter("prtModelNo"), 0);

	JsonResponse ret = null;
	if(intPrtModelNo==0) {
		ret = new JsonResponse(false).setCode(10).setParam(request);
		out.print(ret);
		return;
	}
	
	Goods_Proc goods_proc = new Goods_Proc();
	Goods_Data goods_print_data = Goods_Proc.Goods_One(intPrtModelNo,0);
	
	if(goods_print_data!=null){
		
		String strSelectedPrintModelName = goods_print_data.getModelnm();
		String strSelectedPrintFactory = goods_print_data.getFactory();
		String strSelectedPrintSpec = toJS2(goods_print_data.getSpec());
		String strPrintImage = ImageUtil_lsv.getImageSrc(goods_print_data);
		long lngMinprice =  goods_print_data.getMinprice();
		
		Map<String, Object> retMap = new JsonMap<String, Object>();
		retMap.put("modelname", "\""+toJS2(strSelectedPrintModelName)+"\"");
		retMap.put("factory", "\""+toJS2(strSelectedPrintFactory)+"\"");
		retMap.put("spec", "\""+toJS2(strSelectedPrintSpec)+"\"");
		retMap.put("image", "\""+toJS2(strPrintImage)+"\"");
		retMap.put("price", "\""+lngMinprice+"\"");
	
		ret = new JsonResponse(true).setData(retMap);
		
	} else {
		ret = new JsonResponse(false).setMessage("data empty");
	}
	out.print(ret);
	
%>