
function juminlength()
{
var t = document.myForm.jumin1.value ;

	if ( t.length == 6 )
	{
		window.document.myForm.jumin2.focus();
	} 

return true ; 

}

function jumin_ok() {   
    if (!checkJuminId(myForm.jumin1,myForm.jumin2)) {
		myForm.jumin1.value="";
		myForm.jumin2.value="";
		alert("\n 주민등록번호가 유효하지 않습니다.");
		myForm.jumin1.focus();
		return false;   
    }else{
		if(myForm.jumin2.value.charAt(0)=="1"){
			//myForm.AppSex[0].checked=true;
		}
		if(myForm.jumin2.value.charAt(0)=="2"){
			//myForm.AppSex[1].checked=true;
		}
    }
}
function checkJuminId(First,second) {    
    var temp_num = new Array(13);
    var last_num,i,j;    
    var FirstId = First.value;
    var secondId = second.value;

        
	if ((FirstId != "") && (secondId != "")) {
		for (i=0 ; i<=5; i++) {
			temp_num[i] = FirstId.charAt(i);
		}
		for (j=0 ; j<=7; j++) {
		    var n = j+6;
			temp_num[n] = secondId.charAt(j);
		}
		last_num = 11 - ((temp_num[0]*2 + temp_num[1]*3 + temp_num[2]*4 + temp_num[3]*5 + temp_num[4]*6 + temp_num[5]*7 + temp_num[6]*8 + temp_num[7]*9 + temp_num[8]*2 + temp_num[9]*3 + temp_num[10]*4 + temp_num[11]*5) % 11);
		if (last_num > 9) { last_num = last_num % 10}
		if (last_num != temp_num[12]) {
		   return false;         
		} else {
		   return true;         		
		}
	}
}