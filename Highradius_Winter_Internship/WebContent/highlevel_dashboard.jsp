<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@page import="java.sql.*,java.util.*,com.highradius.internship.*"%>     
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
//level name as get parameter
String level_name = (String)request.getParameter("level");
//page no passed in get parameter
String spageid=request.getParameter("page"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="css/dashboard.css">
    <script src="https://use.fontawesome.com/releases/v5.15.1/js/all.js" data-auto-replace-svg="nest"></script>
    <script type="text/javascript" src="js/index.js"></script>
<title><%=level_name %></title>
</head>
<body>
	<%//top logo div %>
	<div class="top">
        <div class="logo">
            <img class="image" src="images/hrc-logo.svg">
        </div>
        <div class="comp_name">
            <p style="color: rgb(133, 171, 241);">ABC</p>
            <p>PRODUCT</p>
        </div>
    </div>
    <br>
    <%//div for approve,reject and search fields in higher Level Dashboard %>
    <div class="container1" style="border:.6rem solid #e3e5e8; margin: .75rem .75rem .75rem .75rem; padding: 1.25rem;">
    <div class="change_buttons">
        	<button class="add_button" id="buttons1" disabled="disabled" onclick="enableButton_ar()">APPROVE</button> &nbsp; &nbsp;
        	<button class="edit_button" id="buttons2" disabled="disabled" onClick="enableButton_ar1()">REJECT</button>
        	<div class="search-wrapper">
	 			<img src="images/magnifying-glass.svg" class="search-icon"/>
     			<input type="text" id="myinput" class="search-input" placeholder="Search" onkeyup="search()" />
    		</div>
	</div>
	<table id="mytable" >
			<tr class="tr0">  
				<th >&nbsp;</th>
				<th >Order Date</th>
				<th >Order_Id</th>
				<th >Customer_Name</th>
				<th >Customer_ID</th>
				<th >Order_Amount</th>
				<th >Approval_Status</th>
				<th >Approved_By</th>
				<th >Notes</th>
    		</tr>
    	
    	<%//count the records
    	Class.forName("com.mysql.jdbc.Driver");
    	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/winter_internship","root","1431");
    	Statement st= con.createStatement();
    	ResultSet rs=null;
    	if(level_name.equals("Level 2")){
    		rs=st.executeQuery("select count(*) from order_details where Order_Amount between 10000 and 50001");
    	}else{
    		rs=st.executeQuery("select count(*) from order_details where Order_Amount > 50001");
    	}
    	String s="";
    	if(rs.next()) 
    	{
    		  s = rs.getString(1);
    		 // System.out.println(s);
    	}
    	
    	int total=5;
		int trow=Integer.parseInt(s);
		//int lim=(int)Math.ceil(trow/10);
		int lim=trow/total;
		//out.print(lim);
		if(trow%total!=0)
		{
			lim=lim+1;
			
		}
		
    	  
    	int pageid=Integer.parseInt(spageid);  
    	int store_pageid=pageid;
    	
    	int row_count=0;
    	
			row_count=Integer.parseInt(rs.getString(1));
			String row1=Integer.toString(row_count);
			
    		
    	if(pageid==1){}  
    	else{  
    	    pageid=pageid-1;  
    		pageid=pageid*total+1;  
    	} 
    	int newpage=lim;
		int next=store_pageid;
		int prev=store_pageid;
		if(store_pageid==1)
		{
			prev=1;
		}
		else
		{
			prev=prev-1;
		}
		if(store_pageid==newpage)
		{
			next=newpage;
		}
		else
		{
			next=next+1;
		}
		int s1=(total*store_pageid)-(total-1);
		int s2=(total*store_pageid);
		if(s2>row_count)
		{
			s2=row_count;
		}
		//List<pojo> list=AddData.getRecords(pageid,total);
		
		List<pojo> list=AddData.getRecords(pageid,total,level_name);
		if(level_name.equals("Level 2")){
			
    		int index=0;
    		for(pojo e:list){
    			
    			%>
        		<tr class="rows">
        		<td><input class="chb" type="checkbox" onClick="enableButtonHighlevel(<%= index%>)"></td>
    			<td style="text-align: center;"><%= e.getOrder_Date() %></td>
    			<td style="text-align: center;"><%= e.getOrder_ID() %></td>
    			<td style="text-align: center;"><%= e.getCustomer_Name() %></td>
    			<td style="text-align: center;"><%= e.getCustomer_ID() %></td>
    			<td style="text-align: center;"><%= e.getOrder_Amount() %></td>
    			<td style="text-align: center;"><%= e.getApproval_Status() %></td>
    			<td style="text-align: center;"><%= e.getApproved_By() %></td>
    			<td style="text-align: center;"><%= e.getNotes() %></td>
    		</tr>
       			
        	<%index++; }  }
			else if(level_name.equals("Level 3")){
				int index=0;
    		for(pojo e:list){
    			
    			%>
        		<tr class="rows">
        		<td><input class="chb" type="checkbox" onClick="enableButtonHighlevel(<%= index%>)"></td>
    			<td style="text-align: center;"><%= e.getOrder_Date() %></td>
    			<td style="text-align: center;"><%= e.getOrder_ID() %></td>
    			<td style="text-align: center;"><%= e.getCustomer_Name() %></td>
    			<td style="text-align: center;"><%= e.getCustomer_ID() %></td>
    			<td style="text-align: center;"><%= e.getOrder_Amount() %></td>
    			<td style="text-align: center;"><%= e.getApproval_Status() %></td>
    			<td style="text-align: center;"><%= e.getApproved_By() %></td>
    			<td style="text-align: center;"><%= e.getNotes() %></td>
    		</tr>
       
        	<%index++; } }

    	//pagination div%>
	
  	</table>  		
    <div class="bottom">
    	<button  onclick="window.location.href='highlevel_dashboard.jsp?page=1&level=<%=level_name %>';" style="background-color: #AED6F1;border:none;height:25px;width:25px;border-radius:5px;"> <i class="fas fa-angle-double-left" ></i></button> &nbsp;
    	<button onclick="window.location.href='highlevel_dashboard.jsp?page=<%=prev %>&level=<%=level_name %>';" style="background-color: #AED6F1;border:none;height:25px;width:25px;border-radius:5px;"> <i class="fas fa-angle-left" ></i></button> &nbsp;
    	<span style="font-size:16px;">page</span>&nbsp;
    	<span style="font-size:16px;background-color: #AED6F1;"><%=store_pageid%></span>&nbsp;
    	<span style="font-size:16px;">of <%=lim%></span>&nbsp;
		<button  onclick="window.location.href='highlevel_dashboard.jsp?page=<%=next %>&level=<%=level_name %>';" style="background-color: #AED6F1;border:none;height:25px;width:25px;border-radius:5px;"> <i class="fas fa-angle-right" ></i></button> &nbsp;
    	<button onclick="window.location.href='highlevel_dashboard.jsp?page=<%=newpage%>&level=<%=level_name %>';" style="background-color: #AED6F1;border:none;height:25px;width:25px;border-radius:5px;"> <i class="fas fa-angle-double-right" ></i></button> &nbsp; &nbsp;
		
		<p style="font-size:16px;">Customers <%=s1 %>-<%=s2 %> of <%=row_count %></p>
		
	</div>
	</div>
	<form action="approve.jsp?page=<%=store_pageid %>&level=<%=level_name %>" id="myForm" method="post">
		<input type="hidden" id="order_id_dummy" name="order_id_dummy" type="text">
	</form>
	<form action="reject.jsp?page=<%=store_pageid %>&level=<%=level_name %>" id="rejectForm" method="post">
		<input type="hidden" id="order_id_dummy_r" name="order_id_dummy_r" type="text">
	</form>
</body>
</html>