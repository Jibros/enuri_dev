
/// �����޽��� ���� ���� ///
var NO_BLANK = "{name+����} �ʼ��׸��Դϴ�";
var NOT_VALID = "{name+�̰�} �ùٸ��� �ʽ��ϴ�";
// var TOO_LONG = "{name}�� ���̰� �ʰ��Ǿ����ϴ� (�ִ� {maxbyte}����Ʈ)";

/// ��Ʈ�� ��ü�� �޼ҵ� �߰� ///
String.prototype.trim = function(str) { 
	str = this != window ? this : str; 
	return str.replace(/^\s+/g,'').replace(/\s+$/g,''); 
}

String.prototype.hasFinalConsonant = function(str) {
	str = this != window ? this : str; 
	var strTemp = str.substr(str.length-1);
	return ((strTemp.charCodeAt(0)-16)%28!=0);
}

String.prototype.bytes = function(str) {
	str = this != window ? this : str;
	for(j=0; j<str.length; j++) {
		var chr = str.charAt(j);
		len += (chr.charCodeAt() > 128) ? 2 : 1
	}
	return len;
}

function validate() {
	for (i = 0; i < this.elements.length; i++ ) {
		var el = this.elements[i];
		if (el.tagName == "FIELDSET") continue;
		el.value = el.value.trim();

		var minbyte = el.getAttribute("MINBYTE");
		var maxbyte = el.getAttribute("MAXBYTE");
		var minlength = el.getAttribute("MINLENGTH");
		var maxlength = el.getAttribute("MAXLENGTH");
		var option = el.getAttribute("OPTION");
		var match = el.getAttribute("MATCH");
		var glue = el.getAttribute("GLUE");
		var pattern = el.getAttribute('PATTERN');

		if (el.getAttribute("REQUIRED") != null) {
            if (el.type.toLowerCase() == "radio" || el.type.toLowerCase() == "checkbox") {
                if(!isValidChecked(this,el)) return doError(el,NO_BLANK);
            } else if (el.type.toLowerCase() == "select") {
                if(!isValidSelect(this,el)) return doError(el,NO_BLANK);
            } else {
				if (el.value == null || el.value == "") {
					return doError(el,NO_BLANK);
				}
            }
        }

		if (pattern != null && el.value != "") {
            if (!PATTERN(el,pattern)) return false;
        }

		if (minbyte != null) {
			if (el.value.bytes() < parseInt(minbyte)) {
				return doError(el,"{name+����} �ּ� "+minbyte+"����Ʈ �̻� �Է��ؾ� �մϴ�.");
			}
		}

		if (maxbyte != null && el.value != "") {
			var len = 0;
			if (el.value.bytes() > parseInt(maxbyte)) {
				return doError(el,"{name}�� ���̰� �ʰ��Ǿ����ϴ� (�ִ� "+maxbyte+"����Ʈ)");
			}
		}

		if (minlength != null) {
			if (el.value.length < parseInt(minlength)) {
				return doError(el,"{name+����} �ּ� "+length+"���� �̻� �Է��ؾ� �մϴ�.");
			}
		}

		if (maxlength != null && el.value != "") {
			var len = 0;
			if (el.value.length > parseInt(maxlength)) {
				return doError(el,"{name}�� ���ڼ��� �ʰ��Ǿ����ϴ� (�ִ� "+maxlength+"��)");
			}
		}

		if (match && (el.value != form.elements[match].value)) return doError(el,"{name+�̰�} ��ġ���� �ʽ��ϴ�");

		if (option != null && el.value != "") {
			if (el.getAttribute('SPAN') != null) {
				var _value = new Array();
				for (span=0; span<el.getAttribute('SPAN');span++ ) {
					_value[span] = this.elements[i+span].value;
				}
				var value = _value.join(glue == null ? '' : glue);
				if (!funcs[option](el,value)) return false;
			} else {
				if (!funcs[option](el)) return false;
			}
		}
	}
	return true;
}

function josa(str,tail) {
	return (str.hasFinalConsonant()) ? tail.substring(0,1) : tail.substring(1,2);
}

function doError(el,type,action) {
	var pattern = /{([a-zA-Z0-9_]+)\+?([��-��]{2})?}/;
	var name = (hname = el.getAttribute("HNAME")) ? hname : el.getAttribute("NAME");
	pattern.exec(type);
	var tail = (RegExp.$2) ? josa(eval(RegExp.$1),RegExp.$2) : "";
	alert(type.replace(pattern,eval(RegExp.$1) + tail));
	if (action == "sel") {
		el.select();
	} else if (action == "del")	{
		el.value = "";
	}
	el.focus();
	return false;
}	

/// Ư�� ���� �˻� �Լ� ���� ///
var funcs = new Array();
funcs['email'] = isValidEmail;
funcs['phone'] = isValidPhone;
funcs['userid'] = isValidUserid;
funcs['hangul'] = hasHangul;
funcs['hangulonly'] = hanOnly;
funcs['number'] = isNumeric;
funcs['engonly'] = alphaOnly;
funcs['jumin'] = isValidJumin;
funcs['bizno'] = isValidBizNo;
funcs['hanengonly'] = hanalpahOnly;
funcs['hanengnumonly'] = hanalpahnumOnly;
funcs['hannumonly'] = hannumOnly;
funcs['engnumonly'] = alpahnumOnly;
funcs['domain'] = isValidDomain;

/// ���� �˻� �Լ��� ///

function PATTERN(el,pattern) {
    pattern = eval("/"+pattern+"$/")
    return (pattern.test(el.value)) ? true : doError(el,"{name+����} ���Ŀ� ���� �ʽ��ϴ�.","del");
}

function isValidEmail(el,value) {
	var value = value ? value : el.value;
	var pattern = /^[_a-zA-Z0-9-\.]+@[\.a-zA-Z0-9-]+\.[a-zA-Z]+$/;
	return (pattern.test(value)) ? true : doError(el,NOT_VALID,"del");
}

function isValidUserid(el) {
	var pattern = /^[a-zA-Z]{1}[a-zA-Z0-9_]{4,11}$/;
	return (pattern.test(el.value)) ? true : doError(el,"{name+����} 5���̻� 12�� �̸��̾�� �ϰ�,\n ����,����, _ ���ڸ� ����� �� �ֽ��ϴ�","del");
}

function hasHangul(el) {
	var pattern = /[��-��]/;
	return (pattern.test(el.value)) ? true : doError(el,"{name+����} �ݵ�� �ѱ��� �����ؾ� �մϴ�","del");
}

function hanOnly(el) {
    var pattern = /^[��-�R]+$/;
    return (pattern.test(el.value)) ? true : doError(el,"{name+����} �ݵ�� �ѱ۷θ� �Է��ؾ� �մϴ�","del");
}

function alphaOnly(el) {
	var pattern = /^[a-zA-Z]+$/;
	return (pattern.test(el.value)) ? true : doError(el,NOT_VALID,"del");
}

function isNumeric(el) {
	var pattern = /^[0-9]+$/;
	return (pattern.test(el.value)) ? true : doError(el,"{name+����} �ݵ�� ���ڷθ� �Է��ؾ� �մϴ�","del");
}

function isValidJumin(el,value) {
    var pattern = /^([0-9]{6})-?([0-9]{7})$/; 
	var num = value ? value : el.value;
    if (!pattern.test(num)) return doError(el,NOT_VALID,"del"); 
    num = RegExp.$1 + RegExp.$2;

	var sum = 0;
	var last = num.charCodeAt(12) - 0x30;
	var bases = "234567892345";
	for (var i=0; i<12; i++) {
		if (isNaN(num.substring(i,i+1))) return doError(el,NOT_VALID,"del");
		sum += (num.charCodeAt(i) - 0x30) * (bases.charCodeAt(i) - 0x30);
	}
	var mod = sum % 11;
	return ((11 - mod) % 10 == last) ? true : doError(el,NOT_VALID,"del");
}

function isValidBizNo(el, value) { 
    var pattern = /([0-9]{3})-?([0-9]{2})-?([0-9]{5})/; 
	var num = value ? value : el.value;
    if (!pattern.test(num)) return doError(el,NOT_VALID,"del"); 
    num = RegExp.$1 + RegExp.$2 + RegExp.$3;
    var cVal = 0; 
    for (var i=0; i<8; i++) { 
        var cKeyNum = parseInt(((_tmp = i % 3) == 0) ? 1 : ( _tmp  == 1 ) ? 3 : 7); 
        cVal += (parseFloat(num.substring(i,i+1)) * cKeyNum) % 10; 
    } 
    var li_temp = parseFloat(num.substring(i,i+1)) * 5 + '0'; 
    cVal += parseFloat(li_temp.substring(0,1)) + parseFloat(li_temp.substring(1,2)); 
    return (parseInt(num.substring(9,10)) == 10-(cVal % 10)%10) ? true : doError(el,NOT_VALID,"del"); 
}

function isValidPhone(el,value) {
	var pattern = /^([0]{1}[0-9]{1,2})-?([1-9]{1}[0-9]{2,3})-?([0-9]{4})$/;
	var num = value ? value : el.value;
	if (pattern.exec(num)) {
		if(RegExp.$1 == "011" || RegExp.$1 == "016" || RegExp.$1 == "017" || RegExp.$1 == "018" || RegExp.$1 == "019") {
			if (!el.getAttribute('SPAN')) el.value = RegExp.$1 + "-" + RegExp.$2 + "-" + RegExp.$3;
		}
		return true;
	} else {
		return doError(el,NOT_VALID,"del");
	}
}

function hanalpahOnly(el) {
    var pattern = /^[��-�Ra-zA-Z]+$/;
    return (pattern.test(el.value)) ? true : doError(el,"{name+����} �ݵ�� �ѱ�,�����ڸ� ����� �� �ֽ��ϴ�","del");
}

function hanalpahnumOnly(el) {
    var pattern = /^[��-�Ra-zA-Z0-9]+$/;
    return (pattern.test(el.value)) ? true : doError(el,"{name+����} �ݵ�� �ѱ�,������,���ڸ� ����� �� �ֽ��ϴ�","del");
}

function hannumOnly(el) {
    var pattern = /^[��-�R0-9]+$/;
    return (pattern.test(el.value)) ? true : doError(el,"{name+����} �ݵ�� �ѱ�,���ڸ� ����� �� �ֽ��ϴ�","del");
}

function alpahnumOnly(el) {
    var pattern = /^[a-zA-Z0-9]+$/;
    return (pattern.test(el.value)) ? true : doError(el,"{name+����} �ݵ�� ����,���ڸ� ����� �� �ֽ��ϴ�","del");
}

function isValidDomain(el) {
    var pattern = /^.+(\.[a-zA-Z]{2,3})$/;
    return (pattern.test(el.value)) ? true : doError(el,NOT_VALID,"del");
}

function isValidChecked(fm, el) {
	fn = eval(fm.name+'.'+el.name);
	for (i=0;i<fn.length;i++) {
		if (fn[i].checked)
			return true; 
	}
	return false;    
}

function isValidSelect(fm,el) {
	fn = eval(fm.name+'.'+el.name);
	if(fn[0].selected == true) return false;
	return true;
}

var init_true;


function Initialized() {
    init_true = true;

    for (var i = 0; i < document.forms.length; i++) {
        if (document.forms[i].onsubmit) document.forms[i].oldsubmit = document.forms[i].onsubmit;
            document.forms[i].onsubmit = validate;
	}
}

window.onload = Initialized;