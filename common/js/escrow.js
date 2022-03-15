//
//	Escrow 공통으로 쓰이는 script //
//

// 

function OpenWindow(OpenFile,name,nWidth,nHeight,ScrollYesNo,ResizeYesNo)
{
	var newWin = window.open(OpenFile,name,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars="+ ScrollYesNo +",resizable="+ ResizeYesNo +",menubar=no");
		newWin.focus();
}

function OpenWindowYes(OpenFile,winname,nWidth,nHeight)
{
	var newWin = window.open(OpenFile,winname,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no");
		newWin.focus();
}
function OpenWindowNo(OpenFile,winname,nWidth,nHeight)
{
	var newWin = window.open(OpenFile,winname,"width="+nWidth+",height="+nHeight+",toolbar=no,directories=no,status=no,scrollbars=no,resizable=no,menubar=no");
		newWin.focus();
}
function OpenWindowPosition(OpenFile,name,nWidth,nHeight,ScrollYesNo,ResizeYesNo,lleft,ttop)
{
	var newWin = window.open(OpenFile,name,"width="+nWidth+",height="+nHeight+",left="+lleft+",top="+ttop+",toolbar=no,directories=no,status=no,scrollbars="+ ScrollYesNo +",resizable="+ ResizeYesNo +",menubar=no");
		newWin.focus();
}	

function OpenMoveLink(OpenFile,names,nWidth,nHeight,ScrollYesNo,ResizeYesNo,LocationYesNo,MenubarYesNo){
	var winsobj = window.open("",names,"width="+nWidth+",height="+nHeight+",toolbar=no,location="+ LocationYesNo +",directories=no,status=no,scrollbars="+ ScrollYesNo +",resizable="+ ResizeYesNo +",menubar="+MenubarYesNo);
		winsobj.moveTo(1,1);		
		winsobj.location.href=OpenFile;
		
}


// ### onload : parent_page scroll resize (2004.06.17 Sky)
	function CmdFrmaResize(name)
	{
	      try
	      {
	           var oBody      = parent.document.frames(name).document.body;
	           var oFrame      = parent.document.all(name);
	           oFrame.style.width  = "270px";
	           oFrame.style.height = oBody.scrollHeight ;
	           oFrame.style.height = oBody.scrollHeight + (oBody.offsetHeight-oBody.clientHeight);
				           
	           if (oFrame.style.height == "0px" || oFrame.style.width == "0px")
	           {
	                oFrame.style.width = "270px";
	                oFrame.style.height = "200px"; 
	                window.status = '';//'iframe resizing fail.';
	                 alert("실패");
	           }
	           else
	           {
	                window.status = '';
	           }
	      }
	      catch(e)
	      {
	           top.window.status = '';//'Error: ' + e.number + '; ' + e.description;
	      }
	}




// ### 입력한 글자수를 체크 (2004.09.11 Sky)
	function fc_chk_byte(aro_name,ari_max)
	{

	   var ls_str     = aro_name.value; // 이벤트가 일어난 컨트롤의 value 값
	   var li_str_len = ls_str.length;  // 전체길이

	   // 변수초기화
	   var li_max      = ari_max; // 제한할 글자수 크기
	   var i           = 0;  // for문에 사용
	   var li_byte     = 0;  // 한글일경우는 2 그밗에는 1을 더함
	   var li_len      = 0;  // substring하기 위해서 사용
	   var ls_one_char = ""; // 한글자씩 검사한다
	   var ls_str2     = ""; // 글자수를 초과하면 제한할수 글자전까지만 보여준다.

	   for(i=0; i< li_str_len; i++)
	   {
	      // 한글자추출
	      ls_one_char = ls_str.charAt(i);

	      // 한글이면 2를 더한다.
	      if (escape(ls_one_char).length > 4)
	      {
	         li_byte += 2;
	      }
	      // 그밗의 경우는 1을 더한다.
	      else
	      {
	         li_byte++;
	      }

	      // 전체 크기가 li_max를 넘지않으면
	      if(li_byte < li_max)
	      {
	         li_len = i + 1;
	      }
	   }
	   
	   // 전체길이를 초과하면
	   if(li_byte > li_max)
	   {
	      alert( li_max + " 글자를 초과 입력할수 없습니다. \n 초과된 내용은 자동으로 삭제 됩니다. ");
	      ls_str2 = ls_str.substr(0, li_len);
	      aro_name.value = ls_str2;
	      
	   }
	   aro_name.focus();   
	}

// ### Description : Enter키를 못치게한다. (2004.09.11 Sky) textarea에 Enter키를 막을때 쓰기위해..  나중에 필요하면 쓰세요.
	function fc_chk2()
	{
	   if(event.keyCode == 13)
	      event.returnValue=false;
	}
