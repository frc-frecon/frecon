//Create the input-group-btn span to work with bootstrap
function createSpan () {
	var span = document.createElement("span");
	span.className = "input-group-btn";
	return span;
}
//
// Creates a button that will add a ammount to a input field
//
function createAddButton(ifield, label, amount) {
	var widget = document.createElement("button");
	widget.type = "button";
	widget.className = "btn btn-default";
	widget._InputField = ifield;
	widget.appendChild(document.createTextNode(label));

	// Add event handle to update input field amount
	widget.addEventListener("click", function() {
		var adjustedValue = parseInt(this._InputField.value) + amount;
		if(adjustedValue < 0) {
			adjustedValue = 0;
		}
		this._InputField.value = adjustedValue;
	});

	return widget;
}

//
// Appends new DOM node after sibling node already in the document
// (NOTE: This method was included only because we don't think
// JavaScript supplies it by default).
//
function appendAfter(sibling, newDomNode) {
	var insertBeforeNode = sibling.nextSibling;
	if (insertBeforeNode == null) {
		// "sibling" was last child, append to end of parent's children
		sibling.parentNode.appendChild(newDomNode);
	} else {
		// "sibling" has a node which follows it, insert before that one
		sibling.parentNode.insertBefore(newDomNode, insertBeforeNode);
	}
}

//
// Adds increment/decrement button to the end of the specified
// ifield and sets the value to 0 if not currently set.
//
function addIncDecButtonsToInput(ifield) {
	if (ifield.value == "") {
		ifield.value = "0";
	}
	// Create button to add 1
	var incButton = createAddButton(ifield, "+", +1);
	// Create button to add 2
	var decButton = createAddButton(ifield, "-", -1);

	var span = createSpan();
	// Create the input-group-btn span
	appendAfter(ifield, span);
	//append buttons inside span
	span.appendChild(incButton);
	span.appendChild(decButton);
}

//
// Searches page for input buttons with addIncDec in class name
// and adds increment and decrement buttons for each input found
//
function addIncDecButtonsToPage() {
	// Get list of all input fields on page
	var ifields = document.body.getElementsByTagName("input");

	// Go through all input fields on page and for each input
	// field which has "addIncDec" somewhere in it's class name
	// add the increment/decrement buttons
	for (var i = 0; i < ifields.length; i++) {
		ifield = ifields[i];
		if (ifield.className && (ifield.className.indexOf("addIncDec") >= 0)) {
			addIncDecButtonsToInput(ifield);
		}
	}
}

// Example of updating all of the input fields on the page after
// the page is loaded
window.addEventListener("load", function() {
	addIncDecButtonsToPage();
});
