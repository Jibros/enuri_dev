
<!--
	// 검색 키워드 replace
	function replace(src,delWrd) 
	{
		var newSrc;
			newSrc = "";
		var i;
		for(i=0;i<src.length;i++)
		{
			if(src.charAt(i) == delWrd) {
				newSrc = newSrc + " ";
			}
			else
			{
				newSrc = newSrc + src.charAt(i);
			}
		}
		return newSrc;
	}
	
	function proc_keyword(strkeyword)
	{
		var schWrd;
		schWrd = strkeyword;
		/*
		schWrd = replace2(schWrd, "'");		
		schWrd = replace2(schWrd, "\"");				
		schWrd = replace(schWrd, "`");
		schWrd = replace(schWrd, "~");
		schWrd = replace(schWrd, "!");
		schWrd = replace(schWrd, "@");
		schWrd = replace(schWrd, "#");
		schWrd = replace(schWrd, "$");
		schWrd = replace(schWrd, "%");
		schWrd = replace(schWrd, "^");
		schWrd = replace(schWrd, "&");	//검색시 & 는 추가 2003.3 sung35 
		schWrd = replace(schWrd, "*");
		schWrd = replace(schWrd, "+");
		schWrd = replace(schWrd, "=");
		//schWrd = replace(schWrd, "|");
		schWrd = replace(schWrd, "\\");
		schWrd = replace(schWrd, "{");
		schWrd = replace(schWrd, "}");
		schWrd = replace(schWrd, "[");
		schWrd = replace(schWrd, "]");
		schWrd = replace(schWrd, ":");
		schWrd = replace(schWrd, ";");
		schWrd = replace(schWrd, "\"");
		schWrd = replace(schWrd, "<");
		schWrd = replace(schWrd, ">");
		schWrd = replace(schWrd, ".");
		schWrd = replace(schWrd, ",");
		schWrd = replace(schWrd, "?");
		schWrd = replace(schWrd, "/");
		schWrd = replace(schWrd, "(");
		schWrd = replace(schWrd, ")");
		schWrd = replace(schWrd, "'");
		//schWrd = replace(schWrd, "_");
		schWrd = replace(schWrd, "-");
		*/
		
		schWrd = replace2(schWrd, "'");		
		schWrd = replace2(schWrd, "\"");				
	    schWrd = replace2(schWrd, "^");
	    schWrd = replace2(schWrd, "&");
	    schWrd = replace2(schWrd, "~");
	    schWrd = replace2(schWrd, "!");
	    schWrd = replace2(schWrd, "@");
	    schWrd = replace2(schWrd, "$");
	    schWrd = replace2(schWrd, "%");
	    schWrd = replace2(schWrd, "*");
	    schWrd = replace2(schWrd, "+");
	    schWrd = replace2(schWrd, "=");
	    schWrd = replace2(schWrd, "\\");
	    schWrd = replace2(schWrd, "{");
	    schWrd = replace2(schWrd, "}");
	    schWrd = replace2(schWrd, "[");
	    schWrd = replace2(schWrd, "]");
	    schWrd = replace2(schWrd, ":");
	    schWrd = replace2(schWrd, ";");
	    schWrd = replace2(schWrd, "/");
	    schWrd = replace2(schWrd, "<");
	    schWrd = replace2(schWrd, ">");
	    schWrd = replace2(schWrd, "."); 
	    schWrd = replace2(schWrd, ",");
	    schWrd = replace2(schWrd, "?");
	    schWrd = replace2(schWrd, "(");
	    schWrd = replace2(schWrd, ")");
	    schWrd = replace2(schWrd, "'");
	    schWrd = replace2(schWrd, "_");
	    schWrd = replace2(schWrd, "-");
	    schWrd = replace2(schWrd, "`");
	    schWrd = replace2(schWrd, "|");
	    schWrd = schWrd.trim();		
		return schWrd;
		function replace2(src, delWrd){
			var newSrc;
				newSrc = "";
			var i;
			for(i=0;i<src.length;i++){
				if(src.charAt(i) == delWrd) {
					newSrc = newSrc + " ";
				}else{
					newSrc = newSrc + src.charAt(i);
				}			
			}
			return newSrc;
		}		
	}
	
	function frmChksearch(theForm) // 검색 
	{		
		var schWrd;
		var schLen;
		schWrd = proc_keyword(theForm.keyword.value);
		schWrd = schWrd.trim();
		schLen = schWrd.length;						
						
		if(schLen < 2)
		{
			alert("2자 이상의 검색어를 넣으세요(특수문자는 제외 됩니다)~~");
			theForm.keyword.focus();
			return false;
		}		
		else 
		{		
			theForm.keyword.value = schWrd;		
			fnGoSearch(theForm);
		}		
	}
	
	function fnGoSearch(theForm)
	{			
		if ( theForm.search_all[0].checked ) {		// 전체검색 - 통합검색창으로 전환				
		/*
			theForm.factory.value = "";			
			theForm.const_keyword.value = "";			
			theForm.key.value = "";
			theForm.page.value = "";	
			theForm.cmdChg.value = "NO";		
			theForm.action = "/Search/SearchList.jsp";
			theForm.submit();
		*/
		}
		else if ( theForm.search_all[1].checked ) {	// 결과내 검색						 
			theForm.page.value = '';
			theForm.search.value = 'YES';
			theForm.cmdChg.value = 'YES';
			//alert(theForm.const_keyword.value);
			//theForm.submit();			
		}
	}
	
	function frmChksearchBasic(theForm) // 검색 
	{
		
		var schWrd;
		var schLen;
		schWrd = proc_keyword(theForm.keyword.value);
		schLen = schWrd.length;						
						
		if(schLen < 2)
		{
			alert("2자 이상의 검색어를 넣으세요(특수문자는 제외 됩니다)~~");
			theForm.keyword.focus();
			return false;
		}		
		else 
		{	
			theForm.submit();
		}		
	}

	function frmChksearchBrand(theForm) // 검색 - 사용안함
	{
		
		var schWrd;
		var schLen;
		schWrd = proc_keyword(theForm.keyword.value);
		schLen = schWrd.length;						
						
		if(schLen < 2)
		{
			alert("2자 이상의 검색어를 넣으세요(특수문자는 제외 됩니다)~~");
			theForm.keyword.focus();
			return false;
		}		
		else 
		{	
			theForm.submit();
		}		
	}
	
	function chk(frm)
	{
		if ((event.button==2) || (event.button==3)) {
			document.all("tipNote").innerHTML = "<table bgcolor='#FFFFE1' cellpadding='0' cellspacing='0' border='1' bordercolorlight='black' bordercolordark='white'><tr><td style='font-size:9pt' height=17>&nbsp;붙여넣기는 Ctrl+V&nbsp;를 사용하세요.</td></tr></table>";
			tipNote.style.left = event.x+document.body.scrollLeft
			tipNote.style.top = event.y+document.body.scrollTop;
			tipNote.style.visibility = "visible";
		}else{
			tipNote.style.visibility = "hidden";
		}
	}

	
//  상품검색 관련 함수 - Start		
	function MM_swapImgRestore() { //v3.0
	  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
	}
	
	function MM_preloadImages() { //v3.0
	  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
	    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
	    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
	}
	
	function MM_findObj(n, d) { //v4.0
	  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
	    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
	  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
	  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
	  if(!x && document.getElementById) x=document.getElementById(n); return x;
	}
	
	function MM_swapImage() { //v3.0
	  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
	   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
	}
	
/*	
	function frmChksearchShop(theForm) // 검색 - 사용안함
	{
		var schWrd;
		var schLen;
		schWrd = proc_keyword(theForm.keyword.value);
		schLen = schWrd.length;																
						
		if(schLen < 2)
		{
			alert("2자 이상의 검색어를 넣으세요(특수문자는 제외 됩니다)~~");
			theForm.keyword.focus();
			return false;
		}		
		else 
		{		
			if ( theForm.search_all[0].checked ) {		// 전체검색 - 통합검색창으로 전환				
				theForm.factory.value = "";			
				theForm.const_keyword.value = "";			
				theForm.cmdChg.value = "NO";
				theForm.action = "/Search/SearchList.jsp";
				theForm.submit();
			}
			else if ( theForm.search_all[1].checked ) {	// 결과내 검색						 				
				return false;
			}
		}
		
	}
	
*/
	
//-->

