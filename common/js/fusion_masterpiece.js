function cmdClickMasterpieceLoc(strCate){
	//location.href = "/view/fusion/Fusion_Masterpiece.jsp?cate="+strCate;
	document.frmList.cate.value = strCate;
	document.frmList.in_keyword.value = "";
	document.frmList.factory.value = "";
	document.frmList.m_price.value = "";
	document.frmList.page.value = "";
	document.frmList.submit();
}
function cmdClickMaterpieceLoc_factory(strCate,factory){
	//location.href = "/view/fusion/Fusion_Masterpiece.jsp?cate="+strCate+"&factory="+factory;
	document.frmList.cate.value = strCate;
	document.frmList.in_keyword.value = "";
	document.frmList.factory.value = factory;
	document.frmList.m_price.value = "";
	document.frmList.page.value = "";
	document.frmList.submit();	
}
function DivMainScroll1(){
	if( document.all("hdnScrollPo") == "[object]"){
		document.all("hdnScrollPo").value = ganada1.scrollTop;
	}
}
function CmdGanaList( glname , ganada ){
	var varForm = document.frmMsgList;
	varForm.glname.value = glname ;
	varForm.ganada.value = ganada ;
	//varForm.cate.value = "1460" ; //명품관 brand 코드가 1460에서 145920으로 변경 @091120 by bada7998
	varForm.cate.value = "145920" ;

	varForm.submit();
}