


<%
	try 
	{
	Category_Data[] category_data = Category_Proc.Category_Top_List();

	//0.코드, 1.코드명, 2.글자폰트, 3.글짜색깔, 4. 글짜굵기, 5.TD색깔, 6.TD Over색깔, 7.글짜Over색깔, 8.글짜Over굵기, 9 소메뉴Left, Top, Width, Height
%>

<script language=javascript>
<!--
<%
	String pstrPastLcode = "";
	String pstrPastMcode = "";
	String pstrPastScode = "";
	
	for(int i=0; i<category_data.length;i++)
	{	
		String ca_code2 = category_data[i].getCa_code().trim();
		String ca_code3 = category_data[i].getCa_code_2().trim();
		
		String ca_Lcode = ca_code2.substring(0,2);
		String ca_Mcode = ca_code2.substring(2,4);		
		String ca_Scode = "00";
		if(ca_code3.length()>=6){
  		ca_Scode = ca_code3.substring(4,6);
  	}
		//out.println(ca_code3+"=="+ca_Lcode+"=="+ca_Mcode+"=="+ca_Scode);

		String c_name_2 = category_data[i].getC_name().replaceAll("\"","&#34;");
		String c_name_3 = category_data[i].getC_name_2().replaceAll("\"","&#34;");		
		
		//String c_name_2 = category_data[i].getC_name();
		//String c_name_3 = category_data[i].getC_name_2();

		String c_knowbox_2 = category_data[i].getC_knowbox().trim();
		
		//묶음 분류 예외처리.. 중복해서 나올때 소카테고리 if문에 걸어줌. shwoo
		if(ca_code3.equals("030408") || ca_code3.equals("030409")|| ca_code3.equals("030410")|| ca_code3.equals("020111")|| ca_code3.equals("020607") || ca_code3.equals("040110") || ca_code3.equals("040111") ||	ca_code3.equals("040511") || ca_code3.equals("091207") || ca_code3.equals("070208") ||	ca_code3.equals("070209") || ca_code3.equals("111009") || ca_code3.equals("111601") || ca_code3.equals("120201") || ca_code3.equals("120503")  || ca_code3.equals("040401") || ca_code3.equals("021101") || ca_code3.equals("070801") || ca_code3.equals("070802")|| ca_code3.equals("070803")|| ca_code3.equals("070804")|| ca_code3.equals("070805")|| ca_code3.equals("070806") || ca_code3.equals("050111") || ca_code3.equals("060101") || ca_code3.equals("020906") || ca_code3.equals("070506") || ca_code3.equals("040808") || ca_code3.equals("120101") || ca_code3.equals("120104")  || ca_code3.equals("210612")  || ca_code3.equals("060209")  || ca_code3.equals("050207") || ca_code3.equals("050308") || ca_code3.equals("130602") || ca_code3.equals("130606") || ca_code3.equals("130707") || ca_code3.equals("130701") || ca_code3.equals("091405") || ca_code3.equals("091401") || ca_code3.equals("091202")|| ca_code3.equals("111505") || ca_code3.equals("111501") || ca_code3.equals("090410") || ca_code3.equals("060505") || ca_code3.equals("081005") || ca_code3.equals("070204"))
		{
		
		}else{
		%>
		
			<% if(!pstrPastLcode.equals(ca_Lcode)){ %>
				var Ary_<%=ca_Lcode%>_Mcate = new Array();
				var Ary_<%=ca_Lcode%><%=ca_Mcode%>_Scate = new Array(); 
			<% }else if(!pstrPastMcode.equals(ca_Mcode)){%> 
				var Ary_<%=ca_Lcode%><%=ca_Mcode%>_Scate = new Array();  
			<% }%>
	
			<% if(ca_code3.equals("030102")){ //통화요금비교(0309)%>
				Ary_03_Mcate[Ary_03_Mcate.length] = "09" + strSep + "통화요금비교" + strSep + "돋음" + strSep + "#000000" + strSep + "normal" + strSep + "#FFFFFF" + strSep + "#ACD1D0" + strSep + "#093691" + strSep + "normal" + strSep + "100" + strSep + "50" + strSep + "200" + strSep + "300" + strSep + "0" + strSep + "0309";
				var Ary_0309_Scate = new Array();
				
			<% }else if(ca_code3.equals("080101")){ //화장품 브랜드검색(0811)%>
				//Ary_08_Mcate[Ary_08_Mcate.length] = "11" + strSep + "<b>브랜드검색</b>" + strSep + "돋음" + strSep + "#000000" + strSep + "normal" + strSep + "#FFFFFF" + strSep + "#ACD1D0" + strSep + "#093691" + strSep + "normal" + strSep + "100" + strSep + "50" + strSep + "200" + strSep + "300" + strSep + 0;
				//var Ary_0811_Scate = new Array();
			<% }else if(ca_code3.equals("110301")){ //화장품 브랜드검색(1112)%>
				//Ary_11_Mcate[Ary_11_Mcate.length] = "12" + strSep + "명품(브랜드)" + strSep + "돋음" + strSep + "#000000" + strSep + "normal" + strSep + "#FFFFFF" + strSep + "#ACD1D0" + strSep + "#093691" + strSep + "normal" + strSep + "100" + strSep + "50" + strSep + "200" + strSep + "300" + strSep + 0;
				//var Ary_1112_Scate = new Array();
			
			<% }else if(ca_code3.equals("210904")){ //자동차보험(2110)과 자동차 홈페이지%>
				//Ary_21_Mcate[Ary_21_Mcate.length] = "10" + strSep + "차보험비교" + strSep + "돋음" + strSep + "#000000" + strSep + "normal" + strSep + "#FFFFFF" + strSep + "#ACD1D0" + strSep + "#093691" + strSep + "normal" + strSep + "100" + strSep + "50" + strSep + "200" + strSep + "300" + strSep + 0;
				//var Ary_2110_Scate = new Array();
				//Ary_21_Mcate[Ary_21_Mcate.length] = "11" + strSep + "자동차홈페이지" + strSep + "돋음" + strSep + "#000000" + strSep + "normal" + strSep + "#FFFFFF" + strSep + "#ACD1D0" + strSep + "#093691" + strSep + "normal" + strSep + "100" + strSep + "50" + strSep + "200" + strSep + "300" + strSep + 0;
				//var Ary_2111_Scate = new Array();
			<% }else if(ca_code3.equals("090301") && false ){ //패션의  나이키 예외.%>
				Ary_09_Mcate[Ary_09_Mcate.length] = "99" + strSep + "나이키,아디다스,리복" + strSep + "돋음" + strSep + "#000000" + strSep + "normal" + strSep + "#FFFFFF" + strSep + "#ACD1D0" + strSep + "#093691" + strSep + "normal" + strSep + "100" + strSep + "50" + strSep + "200" + strSep + "300" + strSep + "0" + strSep + "0999";
				var Ary_0999_Scate = new Array();
					
			<% }else if(ca_code2.equals("1112") && false ){ //패션의  나이키 예외.%>
				Ary_11_Mcate[Ary_11_Mcate.length] = "99" + strSep + "나이키,아디다스,리복" + strSep + "돋음" + strSep + "#000000" + strSep + "normal" + strSep + "#FFFFFF" + strSep + "#ACD1D0" + strSep + "#093691" + strSep + "normal" + strSep + "100" + strSep + "50" + strSep + "200" + strSep + "300" + strSep + "0" + strSep + "1199";
				var Ary_1199_Scate = new Array();
				
			<% }else if(ca_code3.equals("130101")){ //의류의  리바이스 예외.%>
				Ary_13_Mcate[Ary_13_Mcate.length] = "99" + strSep + "리바이스,빈폴,아베크..." + strSep + "돋음" + strSep + "#000000" + strSep + "normal" + strSep + "#FFFFFF" + strSep + "#ACD1D0" + strSep + "#093691" + strSep + "normal" + strSep + "100" + strSep + "50" + strSep + "200" + strSep + "300" + strSep + "0" + strSep + "1399";
				var Ary_1399_Scate = new Array();
			<%}%>
			
			<% 
			if(pstrPastLcode.equals(ca_Lcode)){			
				if(!pstrPastMcode.equals(ca_Mcode)){
					if((ca_Lcode.equals("08") && ca_Mcode.equals("11")) || (ca_Lcode.equals("12") && ca_Mcode.equals("06")) || (ca_Lcode.equals("09") && ca_Mcode.equals("14"))  || (ca_Lcode.equals("21") && ca_Mcode.equals("12"))){
				%>
						Ary_<%=ca_Lcode%>_Mcate[Ary_<%=ca_Lcode%>_Mcate.length] = "<%=ca_Mcode%>" + strSep + "<b><%=c_name_2%></b>" + strSep + "돋음" + strSep + "#000000" + strSep + "normal" + strSep + "#FFFFFF" + strSep + "#ACD1D0" + strSep + "#093691" + strSep + "normal" + strSep + "100" + strSep + "50" + strSep + "200" + strSep + "300" + strSep + <%=c_knowbox_2%> + strSep + "<%=ca_Lcode+ca_Mcode%>";
				<%
					}else{
				%>
						Ary_<%=ca_Lcode%>_Mcate[Ary_<%=ca_Lcode%>_Mcate.length] = "<%=ca_Mcode%>" + strSep + "<%=c_name_2%>" + strSep + "돋음" + strSep + "#000000" + strSep + "normal" + strSep + "#FFFFFF" + strSep + "#ACD1D0" + strSep + "#093691" + strSep + "normal" + strSep + "100" + strSep + "50" + strSep + "200" + strSep + "300" + strSep + <%=c_knowbox_2%> + strSep + "<%=ca_Lcode+ca_Mcode%>";
				<% 
					}
				} 
				%>
				Ary_<%=ca_Lcode%><%=ca_Mcode%>_Scate[Ary_<%=ca_Lcode%><%=ca_Mcode%>_Scate.length] = "<%=ca_Scode%>" + strSep + "<%=c_name_3%>" + strSep + "돋음" + strSep + "#093691" + strSep + "normal" + strSep + "#ACD1D0" + strSep + "#5CACAB" + strSep + "#FFFFFF" + strSep + "normal" + strSep + "<%=ca_Lcode+ca_Mcode+ca_Scode%>";
				
			<% 
			}else if(!pstrPastLcode.equals(ca_Lcode))
			{
				if((ca_Lcode.equals("08") && ca_Mcode.equals("11")) || (ca_Lcode.equals("12") && ca_Mcode.equals("06")) || (ca_Lcode.equals("09") && ca_Mcode.equals("14")) || (ca_Lcode.equals("21") && ca_Mcode.equals("12"))){
			%>
					Ary_<%=ca_Lcode%>_Mcate[Ary_<%=ca_Lcode%>_Mcate.length] = "<%=ca_Mcode%>" + strSep + "<b><%=c_name_2%></b>" + strSep + "돋음" + strSep + "#000000" + strSep + "normal" + strSep + "#FFFFFF" + strSep + "#ACD1D0" + strSep + "#093691" + strSep + "normal" + strSep + "100" + strSep + "50" + strSep + "200" + strSep + "300" + strSep + <%=c_knowbox_2%> + strSep + "<%=ca_Lcode+ca_Mcode%>";;				
			<%
				}else{
			%>
					Ary_<%=ca_Lcode%>_Mcate[Ary_<%=ca_Lcode%>_Mcate.length] = "<%=ca_Mcode%>" + strSep + "<%=c_name_2%>" + strSep + "돋음" + strSep + "#000000" + strSep + "normal" + strSep + "#FFFFFF" + strSep + "#ACD1D0" + strSep + "#093691" + strSep + "normal" + strSep + "100" + strSep + "50" + strSep + "200" + strSep + "300" + strSep + <%=c_knowbox_2%> + strSep + "<%=ca_Lcode+ca_Mcode%>";;		
			<%
				}			
			%>
				Ary_<%=ca_Lcode%><%=ca_Mcode%>_Scate[Ary_<%=ca_Lcode%><%=ca_Mcode%>_Scate.length] = "<%=ca_Scode%>" + strSep + "<%=c_name_3%>" + strSep + "돋음" + strSep + "#093691" + strSep + "normal" + strSep + "#ACD1D0" + strSep + "#5CACAB" + strSep + "#FFFFFF" + strSep + "normal"+ strSep + "<%=ca_Lcode+ca_Mcode+ca_Scode%>";
			<% 
			} 
			%>
			
			
			
			
			<%
				pstrPastLcode = ca_Lcode;
				pstrPastMcode = ca_Mcode;
				pstrPastScode = ca_Scode;
			%>
		<%
		}

		//out.println(category_data[i].getCa_code() + "==" + category_data[i].getCa_code_2() + "<BR>");
	
	} 
	//out.println("OK=="+category_data.length);
	
	

  String where_full=" WHERE a.ca_code=b.ca_code2";
  where_full=where_full+" AND a.c_level=2 AND b.c_level=3";
  where_full=where_full+" AND a.C_ITSORT>0 AND a.C_SEQNO>0 AND b.C_SEQNO>0 ";
  where_full=where_full+" AND b.ca_code NOT IN ('020906','030409','030410','020607','020111','040401','040808','070208','070209')";
  String order_by = " ORDER BY a.c_itsort, b.c_seqno";
  
  where_full="";
  order_by= "";

  Category_Data[] category_it_data = Category_Proc.Category_It_List(where_full,order_by);
	 //System.out.println(where_full);
   //System.out.println(order_by);
  int intGRsCnt = category_it_data.length;
  
  //Dim strTL, strTM,strTS, intTM 
  int intTM = 0;
  String strTL = "98";
%>
	var Ary_<%=strTL%>_Mcate = new Array();
<%
  for(int pintFor=0;pintFor<intGRsCnt;pintFor++){
	//astrGList[3,pintFor] = ReplaceStr.replace(astrGList[3,pintFor],"\"\"","&#34;"); //CM_NAME
	//astrGList[4,pintFor] = ReplaceStr.replace(astrGList[4,pintFor],"\"\"","&#34;"); //CS_NAME
	String c_name = ReplaceStr.replace(ReplaceStr.replace(category_it_data[pintFor].getC_name(),"\"\"","&#34;"),"\"","&#34;");
	String c_name_2 = ReplaceStr.replace(ReplaceStr.replace(category_it_data[pintFor].getC_name_2(),"\"\"","&#34;"),"\"","&#34;");
%>
	/////////////////////////////////////
	
  	<%
  	if(!(pstrPastLcode+pstrPastMcode).equals(category_it_data[pintFor].getCa_code())){
  		intTM = intTM+1;
  	}else{
  		if(pintFor > 1){
  			if(!category_it_data[pintFor-1].getCa_code().substring(0,4).equals(category_it_data[pintFor].getCa_code())){
  				intTM = intTM + 1;
  			}
  		}
  		
  	}
  	//strTM = Right("0"+intTM,2);
  	String strTM = ""+intTM;
  	if(strTM.length()<2){
  	  strTM="0"+strTM;
  	}
  	
  	if(!(pstrPastLcode+pstrPastMcode).equals(category_it_data[pintFor].getCa_code())){
  	%> 
  		Ary_<%=strTL%>_Mcate[Ary_<%=strTL%>_Mcate.length] = "<%=strTM%>" + strSep + "<%=c_name%>" + strSep + "돋음" + strSep + "#000000" + strSep + "normal" + strSep + "#FFFFFF" + strSep + "#ACD1D0" + strSep + "#093691" + strSep + "normal" + strSep + "100" + strSep + "50" + strSep + "200" + strSep + "300" + strSep + <%=category_it_data[pintFor].getC_knowbox()%> + strSep + "<%=category_it_data[pintFor].getCa_code()%>";  	
  		var Ary_<%=strTL%><%=strTM%>_Scate = new Array();
  	<% 
  	} 
  	
  	if(!category_it_data[pintFor].getCa_code_2().equals("")){
  	%>
  		Ary_<%=strTL%><%=strTM%>_Scate[Ary_<%=strTL%><%=strTM%>_Scate.length] = "<%=category_it_data[pintFor].getCa_code_2().substring(4,6)%>" + strSep + "<%=c_name_2%>" + strSep + "돋음" + strSep + "#093691" + strSep + "normal" + strSep + "#ACD1D0" + strSep + "#5CACAB" + strSep + "#FFFFFF" + strSep + "normal" + strSep + "<%=category_it_data[pintFor].getCa_code_2()%>";	
  	<%
  		pstrPastLcode = category_it_data[pintFor].getCa_code_2().substring(0,2);
  		pstrPastMcode = category_it_data[pintFor].getCa_code_2().substring(2,4);
  		pstrPastScode = category_it_data[pintFor].getCa_code_2().substring(4,6);
  	}
  } 

//쇼핑몰코드 추가 Written by ssauravy 2005.05.25
//(536, 55, 75 , 52, 1878, 57, 47, 663, 806, 49, 3367, 3368)


	//int AryShopcode[] = {536, 55, 75 , 52, 1878, 57, 47, 663, 806, 49, 3367, 3368};
	//int AryShopcode[] = {536, 55, 75 , 52, 1878, 57, 663, 806, 3367};
	//String AryShopName[] = {"G마켓", "인터파크", "GS이숍" , "CSClub", "디앤샵", "Hmall", "우리닷컴", "CJmall","<b>책</b>(yes24)"};
	int AryShopcode[] = {536, 55, 75 , 52, 1878, 57, 663, 806};
	String AryShopName[] = {"G마켓", "인터파크", "GS이숍" , "CSClub", "디앤샵", "Hmall", "우리닷컴", "CJmall"};
	int ishopcode=0;
	int isubcate =0;
%>
	
	var Ary_31_Mcate = new Array();
	<% for(ishopcode=0; ishopcode< AryShopcode.length;ishopcode++ ){
		Shop_subcate_Data[] subcate = Shop_subcate_Proc.getData_Code(AryShopcode[ishopcode]);
		int lensubcate =0;
		if(subcate!=null){
			lensubcate = subcate.length;
		}
	%>
		Ary_31_Mcate[Ary_31_Mcate.length] = "<%=AryShopcode[ishopcode]%>" + strSep + "<%=AryShopName[ishopcode]%>" + strSep + "돋음" + strSep + "#000000" + strSep + "normal" + strSep + "#FFFFFF" + strSep + "#ACD1D0" + strSep + "#093691" + strSep + "normal" + strSep + "100" + strSep + "50" + strSep + "200" + strSep + "300" + strSep + "0" + strSep + "<%=AryShopcode[ishopcode]%>" ;
		<%for(isubcate=0; isubcate<lensubcate;isubcate++){%>
			<%if(isubcate==0){%>
				Ary_31_<%=subcate[isubcate].getShop_code()%>_Scate = new Array();
			<%}%>
			Ary_31_<%=subcate[isubcate].getShop_code()%>_Scate[Ary_31_<%=subcate[isubcate].getShop_code()%>_Scate.length] = "<%=subcate[isubcate].getSsc_num()%>" + strSep + "<%=subcate[isubcate].getSsc_cate()%>" + strSep + "돋음" + strSep + "#093691" + strSep + "normal" + strSep + "#ACD1D0" + strSep + "#5CACAB" + strSep + "#FFFFFF" + strSep + "normal"+ strSep + "<%=subcate[isubcate].getSsc_url()%>";	
		<%}%>
	<%}%>
	//Ary_31_3367_Scate = new Array();
	// shwoo 2005-06-28 업체추가 
	//할인점 추가
	Ary_31_SaleOff_Scate = new Array();
	
	Ary_31_SaleOff_Scate[Ary_31_SaleOff_Scate.length] = "1" + strSep + "이마트" + strSep + "돋음" + strSep + "#093691" + strSep + "normal" + strSep + "#ACD1D0" + strSep + "#5CACAB" + strSep + "#FFFFFF" + strSep + "normal"+ strSep + "http://www.emart.co.kr"+ strSep +"374"+ strSep+"3"+ strSep+"0";
	Ary_31_SaleOff_Scate[Ary_31_SaleOff_Scate.length] = "2" + strSep + "신선식품" + strSep + "돋음" + strSep + "#093691" + strSep + "normal" + strSep + "#ACD1D0" + strSep + "#5CACAB" + strSep + "#FFFFFF" + strSep + "normal"+ strSep + "http://www.emart.co.kr/ctg/LCateMainFrame.jsp?ctg_id=29090&img_ctg_id=29090"+ strSep +"374"+ strSep+"0"+ strSep+"1";
	Ary_31_SaleOff_Scate[Ary_31_SaleOff_Scate.length] = "3" + strSep + "가공식품(전국)" + strSep + "돋음" + strSep + "#093691" + strSep + "normal" + strSep + "#ACD1D0" + strSep + "#5CACAB" + strSep + "#FFFFFF" + strSep + "normal"+ strSep + "http://www.emart.co.kr/ctg/LCateMainFrame.jsp?ctg_id=29094&img_ctg_id=29094"+ strSep +"374"+ strSep+"0"+ strSep+"1";
	Ary_31_SaleOff_Scate[Ary_31_SaleOff_Scate.length] = "4" + strSep + "수퍼존(전국)" + strSep + "돋음" + strSep + "#093691" + strSep + "normal" + strSep + "#ACD1D0" + strSep + "#5CACAB" + strSep + "#FFFFFF" + strSep + "normal"+ strSep + "http://www.emart.co.kr/ctg/LCateMainFrame.jsp?ctg_id=29088&img_ctg_id=29088"+ strSep +"374"+ strSep+"0"+ strSep+"1";
	Ary_31_SaleOff_Scate[Ary_31_SaleOff_Scate.length] = "5" + strSep + "농협" + strSep + "돋음" + strSep + "#093691" + strSep + "normal" + strSep + "#ACD1D0" + strSep + "#5CACAB" + strSep + "#FFFFFF" + strSep + "normal"+ strSep + "http://shopping.nonghyup.com"+ strSep +"3337"+ strSep+"2"+ strSep+"0";
	Ary_31_SaleOff_Scate[Ary_31_SaleOff_Scate.length] = "6" + strSep + "산지직거래(전국)" + strSep + "돋음" + strSep + "#093691" + strSep + "normal" + strSep + "#ACD1D0" + strSep + "#5CACAB" + strSep + "#FFFFFF" + strSep + "normal"+ strSep + "http://shopping.nonghyup.com/commodity/02/cmdt_kind_main.jsp"+ strSep +"3337"+ strSep+"0"+ strSep+"1";
	Ary_31_SaleOff_Scate[Ary_31_SaleOff_Scate.length] = "7" + strSep + "하나로클럽" + strSep + "돋음" + strSep + "#093691" + strSep + "normal" + strSep + "#ACD1D0" + strSep + "#5CACAB" + strSep + "#FFFFFF" + strSep + "normal"+ strSep + "http://shopping.nonghyup.com/commodity/05/cmdt05_main.jsp"+ strSep +"3337"+ strSep+"0"+ strSep+"1";
	Ary_31_SaleOff_Scate[Ary_31_SaleOff_Scate.length] = "8" + strSep + "홈플러스" + strSep + "돋음" + strSep + "#093691" + strSep + "normal" + strSep + "#ACD1D0" + strSep + "#5CACAB" + strSep + "#FFFFFF" + strSep + "normal"+ strSep + "http://store.homeplus.co.kr"+ strSep +"3336"+ strSep+"0"+ strSep+"0";
	
	//Ary_31_Flower_Scate = new Array();
	
	Ary_31_Book_Scate = new Array();
	
//-->
</script>
<%
	}
	catch (Exception ex)
	{
		System.out.println(ex.getMessage());
	}
	
	
	
	
%>		