//search function
function search() {
	  // Declare variables
	  var input, filter, table, tr, td, i, txtValue,j;
	  //getting the data of table using ID od table
	  input = document.getElementById("myinput");
	  filter = input.value.toUpperCase();
	  table = document.getElementById("mytable");
	  tr = table.getElementsByTagName("tr");

	  // Loop through all table rows, and hide those who don't match the search query
	 
	    for (i = 0; i < tr.length; i++) {
	    td = tr[i].getElementsByTagName("td")[2];
	    if (td) {
	      txtValue = td.textContent || td.innerText;
	      if (txtValue.toUpperCase().indexOf(filter) > -1) {
	        tr[i].style.display = "";
	      } else {
	    	       tr[i].style.display = "none";
	  		      }
 
	        }
	      }
  
}
//using js to active the add popup dialog box
function togglePopup(){
	   document.getElementById("popup-1").classList.toggle("active");
}
//using js to active the edit popup dialog box
function togglePopup_edit(){
	  document.getElementById("popup-2").classList.toggle("active");
}

//js function to work for checkbox available in each row
//rowN is row number of the check box
function enableButton(rowN)
{
	
	
	var row = document.getElementsByClassName('rows');
	var cb = document.getElementsByClassName('chb');
	if(cb[rowN].checked==false){
		if(rowN%2!=0)
			row[rowN].style = "background-color : #f5f5f5";
		else
			row[rowN].style = "background-color : #dbf8ff";
		document.getElementById("buttons1").disabled = true;
		return;
	}
	for(var i=0;i<row.length;i++){
		if(i%2!=0)
			row[i].style = "background-color : #f5f5f5";
		else
			row[i].style = "background-color : #dbf8ff";
	}
	for(var i=0;i<cb.length;i++){
		cb[i].checked = false;
	}
	
	cb[rowN].checked = true;
	row[rowN].style = "background-color : orange";
	document.getElementById("buttons1").disabled = false;
	
	
	
	
	document.getElementById('order_id_edit').value = (row[rowN].getElementsByTagName('td')[2]).textContent;
}
//enable reject and approve  buttons and set the order id using checkbox
function enableButtonHighlevel(rowN)
{
	
	
	var row = document.getElementsByClassName('rows');
	var cb = document.getElementsByClassName('chb');
	if(cb[rowN].checked==false){
		if(rowN%2!=0)
			row[rowN].style = "background-color : #f5f5f5";
		else
			row[rowN].style = "background-color : #dbf8ff";
		document.getElementById("buttons1").disabled = true;
		return;
	}
	for(var i=0;i<row.length;i++){
		if(i%2!=0)
			row[i].style = "background-color : #f5f5f5";
		else
			row[i].style = "background-color : #dbf8ff";
	}
	for(var i=0;i<cb.length;i++){
		cb[i].checked = false;
	}
	
	cb[rowN].checked = true;
	row[rowN].style = "background-color : orange";
	document.getElementById("buttons1").disabled = false;
	
	//order id set to two forms used in reject and approve button
	document.getElementById('order_id_dummy').value = (row[rowN].getElementsByTagName('td')[2]).textContent;
	document.getElementById('order_id_dummy_r').value = (row[rowN].getElementsByTagName('td')[2]).textContent;
	document.getElementById("buttons2").disabled = false;
	
}
//function in edit dialog box which auto populate the approved by field
function approvedBy()
{
	var val = document.getElementById('o_amount_edit').value;
	if(val<=10000)
		document.getElementById('a_by').value = "David_Lee";
	else if(val<=50000)
		document.getElementById('a_by').value = "Laura_Smith";
	else
		document.getElementById('a_by').value = "Mathhew_Vance";
}
//enabling the form and submit the form of approve
function enableButton_ar()
{
	document.getElementById("myForm").submit();  
}
//enabling the form and submit the form of reject
function enableButton_ar1()
{
	document.getElementById("rejectForm").submit();
}