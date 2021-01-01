<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*,java.sql.Date"%>     
<%
	//receiving page no from get parameter
	String spage=request.getParameter("page");
	//converting the string npage to integer
	int npage=0;
	npage=Integer.parseInt(spage);
	
	
	//Receiving all the data of add form and converting them in required data type
	
	int order_id=Integer.parseInt(request.getParameter("order_id"));
	String order_date=request.getParameter("order_date");
	String customer_name=request.getParameter("c_name");
	int customer_id=Integer.parseInt(request.getParameter("c_number"));
	int order_amount=Integer.parseInt(request.getParameter("o_amount"));
	String approved_status="";
	String approved_by="";

	//As per the order amount the feild in db i.e approved_status and approved_by is filled.
	if(order_amount<=10000)
	{
		approved_status="Approved";
		approved_by="David Lee";
	}
	else
	{
		approved_status="Awaiting Approval";
	}
	String notes=request.getParameter("notes_add");
	
	//Connecting to database to insert the data which is inserted in the dialog box
	Class.forName("com.mysql.jdbc.Driver");
	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/winter_internship","root","1431");
	
	String checkPrimary="Select count(*) from order_details where Order_Id="+order_id;
	Statement st= con.createStatement();
	ResultSet rs =st.executeQuery(checkPrimary);
	rs.next();
	String s=rs.getString(1);
	if(s.equals("1"))
	{%>
		<script>
			alert("Order Id can't have duplicate items");
			window.history.back();
		</script>

	<%}
	else{
		String sql="INSERT INTO order_details VALUES (?,?,?,?,?,?,?,?)";
		PreparedStatement pst = con.prepareStatement(sql);
		//inserting the data in their respective column in db
		pst.setInt(1,order_id);
		pst.setString(2,customer_name);
		pst.setInt(3,customer_id);
		pst.setInt(4,order_amount);
		pst.setString(7,notes);
		pst.setString(5,approved_status);
		pst.setString(6,approved_by);
		pst.setDate(8,Date.valueOf(order_date));
		pst.executeUpdate();
	
	//after adding data in db the dialog box is returned to level dashboard%>
	<jsp:forward page="level1_dashboard.jsp">
	   <jsp:param name="page" value="<%=npage %>"/>
	</jsp:forward> 
	<%}%>
	