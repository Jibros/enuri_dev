	// 검색 키워드 replace
	function replace(src, delWrd) 
	{
		var newSrc;
			newSrc = "";
		var i;
		for(i=0;i<src.length;i++)
		{
			if (src.charAt(i) == "-" || src.charAt(i) == ",")
			{
				newSrc = newSrc + " ";
			}
			else
			{
				if(src.charAt(i) == delWrd) {}
				else
				{
					newSrc = newSrc + src.charAt(i);
				}
			}
		}
		return newSrc;
	}
	
	function proc_keyword(strkeyword)
	{
		var schWrd;
		schWrd = strkeyword;
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
		schWrd = replace(schWrd, "|");
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
		schWrd = replace(schWrd, "_");
		schWrd = replace(schWrd, "-");
		
		return schWrd;
		
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
			theForm.action = "/Search/Searchlist.jsp";
			theForm.submit();
		*/
		}
		else if ( theForm.search_all[1].checked ) {	// 결과내 검색						 
			theForm.page.value = '';
			theForm.search.value = 'YES';
			theForm.cmdChg.value = 'YES';		
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
				theForm.action = "/Search/Searchlist.jsp";
				theForm.submit();
			}
			else if ( theForm.search_all[1].checked ) {	// 결과내 검색						 				
				return false;
			}
		}
		
	}
	
*/

