//
//	Escrow �������� ���̴� script //
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
	                 alert("����");
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




// ### �Է��� ���ڼ��� üũ (2004.09.11 Sky)
	function fc_chk_byte(aro_name,ari_max)
	{

	   var ls_str     = aro_name.value; // �̺�Ʈ�� �Ͼ ��Ʈ���� value ��
	   var li_str_len = ls_str.length;  // ��ü����

	   // �����ʱ�ȭ
	   var li_max      = ari_max; // ������ ���ڼ� ũ��
	   var i           = 0;  // for���� ���
	   var li_byte     = 0;  // �ѱ��ϰ��� 2 �׹ܿ��� 1�� ����
	   var li_len      = 0;  // substring�ϱ� ���ؼ� ���
	   var ls_one_char = ""; // �ѱ��ھ� �˻��Ѵ�
	   var ls_str2     = ""; // ���ڼ��� �ʰ��ϸ� �����Ҽ� ������������ �����ش�.

	   for(i=0; i< li_str_len; i++)
	   {
	      // �ѱ�������
	      ls_one_char = ls_str.charAt(i);

	      // �ѱ��̸� 2�� ���Ѵ�.
	      if (escape(ls_one_char).length > 4)
	      {
	         li_byte += 2;
	      }
	      // �׹��� ���� 1�� ���Ѵ�.
	      else
	      {
	         li_byte++;
	      }

	      // ��ü ũ�Ⱑ li_max�� ����������
	      if(li_byte < li_max)
	      {
	         li_len = i + 1;
	      }
	   }
	   
	   // ��ü���̸� �ʰ��ϸ�
	   if(li_byte > li_max)
	   {
	      alert( li_max + " ���ڸ� �ʰ� �Է��Ҽ� �����ϴ�. \n �ʰ��� ������ �ڵ����� ���� �˴ϴ�. ");
	      ls_str2 = ls_str.substr(0, li_len);
	      aro_name.value = ls_str2;
	      
	   }
	   aro_name.focus();   
	}

// ### Description : EnterŰ�� ��ġ���Ѵ�. (2004.09.11 Sky) textarea�� EnterŰ�� ������ ��������..  ���߿� �ʿ��ϸ� ������.
	function fc_chk2()
	{
	   if(event.keyCode == 13)
	      event.returnValue=false;
	}
