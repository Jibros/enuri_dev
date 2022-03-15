function objDetectBrowser() {
  var strUA, s, i;
  this.isIE = false;
  this.isNS = false;
  this.version = null;
  strUA = navigator.userAgent; 
 
  s = "MSIE";
  if ((i = strUA.indexOf(s)) >= 0) {
    this.isIE = true;
    this.version = parseFloat(strUA.substr(i + s.length));
    return;
  }
 
  s = "Netscape6/";
  if ((i = strUA.indexOf(s)) >= 0) {
    this.isNS = true;
    this.version = parseFloat(strUA.substr(i + s.length));
    return;
  }
 
  s = "Gecko";
  if ((i = strUA.indexOf(s)) >= 0) {
    this.isNS = true;
    this.version = 6.1;
    return;
  }
}

var objDetectBrowser = new objDetectBrowser();
var gvActiveButton = null;

if (objDetectBrowser.isIE)
  document.onmousedown = mousedownPage;
if (objDetectBrowser.isNS)
  document.addEventListener("mousedown", mousedownPage, true);
  
function mousedownPage(event) {

  var objElement;

  if (!gvActiveButton)
    return;

  if (objDetectBrowser.isIE)
    objElement = window.event.srcElement;
  if (objDetectBrowser.isNS)
    objElement = (event.target.className ? event.target : event.target.parentNode);

	
  if (objElement == gvActiveButton)
    return;
  
  if (objElement.className != "menuButton"  && objElement.className != "menuItem" && objElement.className != "menuItem2" &&
      objElement.className != "menuItemSep" && objElement.className != "menu" && objElement.className != "menu_red")
    resetButton(gvActiveButton);
  
}

function mouseoverButton(objMnuButton, strMenuName) {
  if (gvActiveButton && gvActiveButton != objMnuButton) {
    resetButton(gvActiveButton);
    
  if (strMenuName)
    clickButton(objMnuButton, strMenuName);
  }
}

function clickButton(objMnuButton, strMenuName) {
  objMnuButton.blur();
  if (!objMnuButton.menu)
    objMnuButton.menu = document.getElementById(strMenuName);

  if (gvActiveButton && gvActiveButton != objMnuButton)
      resetButton(gvActiveButton);	
	
  if (gvActiveButton)
    resetButton(objMnuButton);
  else
    pulldownMenu(objMnuButton);

  return false;
}

function pulldownMenu(objMnuButton) {
  objMnuButton.className = "menuButtonActive";
  
  if (objDetectBrowser.isIE && !objMnuButton.menu.firstChild.style.width) {
    objMnuButton.menu.firstChild.style.width = objMnuButton.menu.firstChild.offsetWidth + "px";
  }
  
  x = objMnuButton.offsetLeft;
  y = objMnuButton.offsetTop + objMnuButton.offsetHeight;
  if (objDetectBrowser.isIE) {
    x += -1;
    y += 1;
  }
  if (objDetectBrowser.isNS && objDetectBrowser.version < 6.1)
    y--;

  objMnuButton.menu.style.left = x + "px";
  objMnuButton.menu.style.top  = y + "px";
  objMnuButton.menu.style.visibility = "visible";
  
  gvActiveButton = objMnuButton;
}

function resetButton(objMnuButton) {

  objMnuButton.className = "menuButton";
  if (objMnuButton.menu)
    objMnuButton.menu.style.visibility = "hidden";
  gvActiveButton = null;
}

function resetButton2(obj) {
    obj.style.display = "none";
  gvActiveButton = null;
}

function CmdMouseOver(Obj,n)
{
	if(n==1)
	{
		Obj.style.backgroundColor="#08246B";
		Obj.style.color="#FFFFFF";
	}
	else
	{
		Obj.style.backgroundColor="#FFFFFF";
		Obj.style.color="#000000";
	}
}