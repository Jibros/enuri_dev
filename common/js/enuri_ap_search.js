<script language=javascript>
<!--
		function replace2(src, delWrd){
			var newSrc;
				newSrc = "";
			var i;
			for(i=0;i<src.length;i++){
				if (src.charAt(i) == "-" || src.charAt(i) == ","){
					newSrc = newSrc + " ";
				}else{
					if(src.charAt(i) == delWrd) {
					}else{
						newSrc = newSrc + src.charAt(i);
					}
				}
			}
			return newSrc;
		}
	
		function fnGoSearch(param){
			var schWrd;
			schWrd = document.frmSearch.keyword.value;
			schWrd = replace2(schWrd, "`");
			schWrd = replace2(schWrd, "~");
			schWrd = replace2(schWrd, "!");
			schWrd = replace2(schWrd, "@");
			schWrd = replace2(schWrd, "#");
			schWrd = replace2(schWrd, "$");
			schWrd = replace2(schWrd, "%");
			schWrd = replace2(schWrd, "^");
			schWrd = replace2(schWrd, "&");	//검색시 & 는 추가 2003.3 sung35 
			schWrd = replace2(schWrd, "*");
			schWrd = replace2(schWrd, "+");
			schWrd = replace2(schWrd, "=");
			schWrd = replace2(schWrd, "|");
			schWrd = replace2(schWrd, "\\");
			schWrd = replace2(schWrd, "{");
			schWrd = replace2(schWrd, "}");
			schWrd = replace2(schWrd, "[");
			schWrd = replace2(schWrd, "]");
			schWrd = replace2(schWrd, ":");
			schWrd = replace2(schWrd, ";");
			schWrd = replace2(schWrd, "\"");
			schWrd = replace2(schWrd, "<");
			schWrd = replace2(schWrd, ">");
			schWrd = replace2(schWrd, ".");
			schWrd = replace2(schWrd, ",");
			schWrd = replace2(schWrd, "?");
			schWrd = replace2(schWrd, "/");
			schWrd = replace2(schWrd, "(");
			schWrd = replace2(schWrd, ")");
			schWrd = replace2(schWrd, "'");
			schWrd = replace2(schWrd, "_");
			schWrd = replace2(schWrd, "-");
			
			schWrd = schWrd.trim();		
			var schLen;
			schLen = schWrd.length;
			
			if(schLen < 2){
				alert("2자 이상의 검색어를 넣으세요(특수문자는 제외 됩니다)~~");
				document.frmSearch.keyword.focus();
				return false;
			}				
			document.frmSearch.keyword.value = schWrd;
			if ( param == "ALL" ) {
				document.frmSearch.submit();		
			}	
		}	
//-->
</script>
