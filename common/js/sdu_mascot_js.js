//Modified by the CoffeeCup HTML Editor++
//http://www.coffeecup.com
// Global variables for platform branching
var isNav, isIE
if (parseInt(navigator.appVersion) >= 4) {
	if (navigator.appName == "Netscape") {
		isNav = true
	} else {
		isIE = true
	}
}

// ***Begin CSS custom API Functions***
// Set zIndex property
function setZIndex(obj, zOrder) {
	obj.zIndex = zOrder
}
// Position an object at a specific pixel coordinate
function shiftTo(obj, x, y) {
	if (isNav) {
		obj.moveTo(x,y)
	} else {
		obj.pixelLeft = x
		obj.pixelTop = y
	}
}
// ***End API Functions***

// Global holds reference to selected element
var selectedObj
// Globals hold location of click relative to element
var offsetX, offsetY

// Find out which element has been clicked on
function setSelectedElem(evt) {
	if (isNav) {
		// declare local var for use in upcoming loop
		var testObj
		// make copies of event coords for use in upcoming loop
		var clickX = evt.pageX
		var clickY = evt.pageY
		// loop through all layers (starting with frontmost layer)
		// to find if the event coordinates are in the layer
		if(document.layers){
			for (var i = document.layers.length - 1; i >= 0; i--) {
				testObj = document.layers[i]
				if ((clickX > testObj.left) &&
					(clickX < testObj.left + testObj.clip.width) &&
					(clickY > testObj.top) &&
					(clickY < testObj.top + testObj.clip.height)) {
						// if so, then set the global to the layer, bring it
						// forward, and get outa here
						selectedObj = testObj
						setZIndex(selectedObj, 100)
						return
				}
			}
		}
	} else {
		// use IE event model to get the targeted element
		var imgObj = window.event.srcElement
		// make sure it's one of our planes
		if (imgObj.parentElement.id.indexOf("plane") != -1) {
			// then set the global to the style property of the element,
			// bring it forward, and say adios
			selectedObj = imgObj.parentElement.style
			setZIndex(selectedObj,100)
			return
		}
	}
	// the user probably clicked on the background
	selectedObj = null
	return
}
// Drag an element
function dragIt(evt) {
	// operate only if a plane is selected
	if (selectedObj) {
		if (isNav) {
			shiftTo(selectedObj, (evt.pageX - offsetX), (evt.pageY - offsetY))

		} else {
			//shiftTo(selectedObj, (window.event.clientX - offsetX), (window.event.clientY - offsetY))
			// prevent further system response to dragging in IE
			return false
		}
	}
}
// Set globals to connect with selected element
function engage(evt) {
	setSelectedElem(evt)
	if (selectedObj) {
		// set globals that remember where the click is in relation to the
		// top left corner of the element so we can keep the element-to-cursor
		// relationship constant throughout the drag
		if (isNav) {
			offsetX = evt.pageX - selectedObj.left
			offsetY = evt.pageY - selectedObj.top
		} else {
			offsetX = window.event.offsetX
			offsetY = window.event.offsetY
		}
	}
	// block mouseDown event from forcing Mac to display
	// contextual menu.
	return false
}
// Restore elements and globals to initial values
function release(evt) {
	if (selectedObj) {
		setZIndex(selectedObj, 0)
		selectedObj = null
	}
}
// Turn on event capture for Navigator
function setNavEventCapture() {
	if (isNav) {
		document.captureEvents(Event.MOUSEDOWN | Event.MOUSEMOVE | Event.MOUSEUP)
	}
}
// Assign event handlers used by both Navigator and IE (called by onLoad)
function init() {
	if (isNav) {
		setNavEventCapture()
	}
	// assign functions to each of the events (works for both Navigator and IE)
	//document.onmousedown = engage
	//document.onmousemove = dragIt
	//document.onmouseup = release
}
