	// �˻� Ű���� replace
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
		schWrd = replace(schWrd, "&");	//�˻��� & �� �߰� 2003.3 sung35 
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
	
	function frmChksearch(theForm) // �˻� 
	{		
		var schWrd;
		var schLen;
		schWrd = proc_keyword(theForm.keyword.value);
		schWrd = schWrd.trim();
		schLen = schWrd.length;						
						
		if(schLen < 2)
		{
			alert("2�� �̻��� �˻�� ��������(Ư�����ڴ� ���� �˴ϴ�)~~");
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
		if ( theForm.search_all[0].checked ) {		// ��ü�˻� - ���հ˻�â���� ��ȯ				
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
		else if ( theForm.search_all[1].checked ) {	// ����� �˻�						 
			theForm.page.value = '';
			theForm.search.value = 'YES';
			theForm.cmdChg.value = 'YES';		
		}
	}
	
	function frmChksearchBasic(theForm) // �˻� 
	{
		
		var schWrd;
		var schLen;
		schWrd = proc_keyword(theForm.keyword.value);
		schLen = schWrd.length;						
						
		if(schLen < 2)
		{
			alert("2�� �̻��� �˻�� ��������(Ư�����ڴ� ���� �˴ϴ�)~~");
			theForm.keyword.focus();
			return false;
		}		
		else 
		{	
			theForm.submit();
		}		
	}

	function frmChksearchBrand(theForm) // �˻� - ������
	{
		
		var schWrd;
		var schLen;
		schWrd = proc_keyword(theForm.keyword.value);
		schLen = schWrd.length;						
						
		if(schLen < 2)
		{
			alert("2�� �̻��� �˻�� ��������(Ư�����ڴ� ���� �˴ϴ�)~~");
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
			document.all("tipNote").innerHTML = "<table bgcolor='#FFFFE1' cellpadding='0' cellspacing='0' border='1' bordercolorlight='black' bordercolordark='white'><tr><td style='font-size:9pt' height=17>&nbsp;�ٿ��ֱ�� Ctrl+V&nbsp;�� ����ϼ���.</td></tr></table>";
			tipNote.style.left = event.x+document.body.scrollLeft
			tipNote.style.top = event.y+document.body.scrollTop;
			tipNote.style.visibility = "visible";
		}else{
			tipNote.style.visibility = "hidden";
		}
	}

/*	
	function frmChksearchShop(theForm) // �˻� - ������
	{
			
		var schWrd;
		var schLen;
		schWrd = proc_keyword(theForm.keyword.value);
		schLen = schWrd.length;																
						
		if(schLen < 2)
		{
			alert("2�� �̻��� �˻�� ��������(Ư�����ڴ� ���� �˴ϴ�)~~");
			theForm.keyword.focus();
			return false;
		}		
		else 
		{		
			if ( theForm.search_all[0].checked ) {		// ��ü�˻� - ���հ˻�â���� ��ȯ				
				theForm.factory.value = "";			
				theForm.const_keyword.value = "";			
				theForm.cmdChg.value = "NO";
				theForm.action = "/Search/Searchlist.jsp";
				theForm.submit();
			}
			else if ( theForm.search_all[1].checked ) {	// ����� �˻�						 				
				return false;
			}
		}
		
	}
	
*/

