function calculateOffsetLeft(field) {
  return calculateOffset(field, "offsetLeft");
}

function calculateOffsetTop(field) {
  return calculateOffset(field, "offsetTop");
}

function calculateOffset(field, attr) {
  var offset = 0;
  while(field) {
    offset += field[attr]; 
    field = field.offsetParent;
   }
  return offset;
}

//�ڵ��ϼ� ã�� �� �̺�Ʈ üũ.
function Tom(){
	this.version="1.0";
	this.name = "AutoComplete Tom";
	this.oForm = null;							//�˻��� �Է� Form��ü
	this.sCollection = null; //�ݷ��� ����.		//�ڵ��ϼ� �ش� �ݷ���
	this.oKeyword = null;						//�˻�Ű���� �Է� Text��ü
	this.sOldkwd = "";							//�����˻���
	this.sNewkwd = "";							//�ű԰˻���
	this.oAc_lyr = null;						//�ڵ��ϼ� ��ü���̾ü
	this.oAc_ifr = null;						//�ڵ��ϼ�ó�� �����Ӱ�ü
	this.oImg_Toggle = null;					//�˻�Ű���� �Է� Text��ü�� ���� ����̹�����ü
	this.sImg_Toggle_on = "http://img.enuri.info/images/main_2007/search_arr_off.gif";
	this.sImg_Toggle_off = "http://img.enuri.info/images/main_2007/search_arr_on.gif"; 
	this.sSkipWrd = "����������������������������";	//�ڵ��ϼ� skip�ܾ�
	this.bSkipTF = false;						//�ڵ��ϼ� skip�ܾ� ����� ������� ����
	this.TimerInterval = 200; 					//�ڵ��ϼ� üũ�ֱ�1000�� 1��
	this.act =0; 								//�ڵ��ϼ� ���������� ���� (0:����, 1:����)
	this.sSubmitFunctionName = "";
	this.isExistSkipwrd = function(){
		var ret = false;
		s = arguments[0]; 
		t = arguments[1];
		for(i=0;i<s.length;i++){
			if(t.indexOf(s.substring(i, i+1)) < 0){
				ret = false;
			}else{
				ret = true;
				break;
			}
		}
		return ret;
	};
	
	this.toggle = function(){
		if(this.oAc_ifr!=null){
			obj = document.frames(this.oAc_ifr.name);
			obj.Jerry_on_off();
		}
	};
	this.find = function(){
		if(this.act){
			return;
		}else{
			if(this.bSkipTF){
				if(this.isExistSkipwrd(this.oKeyword.value.trim(), this.sSkipWrd)){
					return;
				}
			}
			this.act=1;
			this.sNewkwd = this.oKeyword.value.trim();
			//obj = document.frames(this.oAc_ifr.name);
			obj = document.getElementById("ifr_ac").contentWindow;
			obj.Jerry_AutoSearch( this);
			this.sOldkwd = this.sNewkwd;
			this.act=0;
		}		
	};
}

function hideAutoComLayer(){
	document.getElementById('ac_layer').style.display='none';
}