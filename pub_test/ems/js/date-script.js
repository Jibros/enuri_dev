Date.prototype.toTimeStampHH = function() {
							
	var yy = this.getFullYear();
	var month = this.getMonth() + 1;
	var dd = this.getDate();
	
	var hh = this.getHours();
	var mm = '00';
	
	if(month < 10)
		month = '0' + month;
		
	if(dd < 10)
		dd = '0' + dd;
		
	if(hh < 10)
		hh = '0' + hh;
	
	return yy + '-' + month + '-' + dd + ' ' + hh + ':' + mm;
}

Date.prototype.toTimeStampM0 = function() {
	
	var yy = this.getFullYear();
	var month = this.getMonth() + 1;
	var dd = this.getDate();
	
	var hh = this.getHours();
	var mm = Math.floor(this.getMinutes() / 10) + '0';
	
	if(month < 10)
		month = '0' + month;
		
	if(dd < 10)
		dd = '0' + dd;
		
	if(hh < 10)
		hh = '0' + hh;
	
	return yy + '-' + month + '-' + dd + ' ' + hh + ':' + mm;
}

Date.prototype.toTimeStamp = function() {
		
	var yy = this.getFullYear();
	var month = this.getMonth() + 1;
	var dd = this.getDate();
	
	var hh = this.getHours();
	var mm = this.getMinutes();
	
	if(month < 10)
		month = '0' + month;
		
	if(dd < 10)
		dd = '0' + dd;
		
	if(hh < 10)
		hh = '0' + hh;
	
	if(mm < 10)
		mm = '0' + mm;
	
	return yy + '-' + month + '-' + dd + ' ' + hh + ':' + mm;
}

Date.prototype.twoLineString = function() {
	
	var yy = this.getFullYear();
	var month = this.getMonth() + 1;
	var dd = this.getDate();
	
	var hh = this.getHours();
	var mm = this.getMinutes();
	var ss = this.getSeconds();
	
	if(month < 10)
		month = '0' + month;
		
	if(dd < 10)
		dd = '0' + dd;
		
	if(hh < 10)
		hh = '0' + hh;
	
	if(mm < 10)
		mm = '0' + mm;
	
	if(ss < 10)
		ss = '0' + ss;
	
	return yy + '-' + month + '-' + dd + '<br>' + hh + ':' + mm + ':' + ss;
}

String.prototype.toDate = function(format) {
  var normalized      = this.replace(/[^a-zA-Z0-9]/g, '-');
  var normalizedFormat= format.toLowerCase().replace(/[^a-zA-Z0-9]/g, '-');
  var formatItems     = normalizedFormat.split('-');
  var dateItems       = normalized.split('-');

  var monthIndex  = formatItems.indexOf("mm");
  var dayIndex    = formatItems.indexOf("dd");
  var yearIndex   = formatItems.indexOf("yyyy");
  var hourIndex     = formatItems.indexOf("hh");
  var minutesIndex  = formatItems.indexOf("mi");
  var secondsIndex  = formatItems.indexOf("ss");

  var today = new Date();

  var year  = yearIndex>-1  ? dateItems[yearIndex]    : today.getFullYear();
  var month = monthIndex>-1 ? dateItems[monthIndex]-1 : today.getMonth()-1;
  var day   = dayIndex>-1   ? dateItems[dayIndex]     : today.getDate();

  var hour    = hourIndex>-1      ? dateItems[hourIndex]    : today.getHours();
  var minute  = minutesIndex>-1   ? dateItems[minutesIndex] : today.getMinutes();
  var second  = secondsIndex>-1   ? dateItems[secondsIndex] : today.getSeconds();

  return new Date(year,month,day,hour,minute,second);
};