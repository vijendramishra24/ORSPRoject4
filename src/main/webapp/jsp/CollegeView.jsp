    
    <%@page import="com.rays.proj4.ctl.CollegeCtl"%>
<%@page import="com.rays.proj4.util.DataUtility"%>
<%@page import="com.rays.proj4.util.ServletUtility"%>

<html>
<style>
.finput {
	margin-left: 76px;
}

#btn b {
	margin-left: 69px;
}

input {
	margin-top: 4px;
	padding: 4px;
	width: 200px;
}

#btn input {
	width: 90px;
	
}

select {
	margin: 4px 0 0;
	padding: 4px;
	width: 200px;
}
</style>
<body>
<div align="center">

<form action="CollegeCtl" method="POST">
        <%@ include file="Header.jsp"%>

        <jsp:useBean id="bean" class="com.rays.proj4.bean.CollegeBean"
            scope="request"></jsp:useBean>

        <center>
             <%if(bean.getId()>0){%>
        	
       
            <h1>Update College</h1>
		<%  }else{ %>
		
		<h1>Add College</h1>
		
		<%} %>

            <H2>
                <font color="green"> <%=ServletUtility.getSuccessMessage(request)%>
                </font>
            </H2>
            <H2>
                <font color="red"> <%=ServletUtility.getErrorMessage(request)%>
                </font>
            </H2>

</div>
	<div style="margin-left: 500px">

            <input type="hidden" name="id" value="<%=bean.getId()%>"> <input
                type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
            <input type="hidden" name="modifiedBy"
                value="<%=bean.getModifiedBy()%>"> <input type="hidden"
                name="createdDatetime"
                value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
            <input type="hidden" name="modifiedDatetime"
                value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">

            <table>
                <tr>
                    <th align="left">College Name<font color="red">* </font></th>
                    <td><input type="text" name="name" placeholder="Enter College Name"
                        value="<%=DataUtility.getStringData(bean.getName())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("name", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Address<font color="red">* </font></th>
                    <td><input type="text" name="address" placeholder="Enter College Address"
                        value="<%=DataUtility.getStringData(bean.getAddress())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("address", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">State<font color="red">* </font></th>
                    <td><input type="text" name="state" placeholder="Enter State"
                        value="<%=DataUtility.getStringData(bean.getState())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("state", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">City<font color="red">* </font></th>
                    <td><input type="text" name="city" placeholder="Enter City"
                        value="<%=DataUtility.getStringData(bean.getCity())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("city", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">PhoneNo<font color="red">* </font></th>
                    <td><input type="text" name="phoneNo" placeholder="Enter College Contact No."
                        value="<%=DataUtility.getStringData(bean.getPhoneNo())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("phoneNo", request)%></font></td>
                </tr>


               </table>
             </div>
             <div style="margin-left: 495px">
             
              <table id="btn"> 
                <tr>
                    <th></th>
                    <%if(bean.getId()>0){%>    
          			<td colspan="2"><input type="submit" name="operation"
                        value="<%=CollegeCtl.OP_UPDATE%>">
					<%  }else{ %>
					<td colspan="2"><input type="submit" name="operation"
                        value="<%=CollegeCtl.OP_SAVE%>">
					<%} %> <%
    
 %>&emsp; <input type="submit" name="operation"
                        value="<%=CollegeCtl.OP_CANCEL%>">
                        
                        &emsp; <input type="submit" name="operation"
                        value="<%=CollegeCtl.OP_RESET%>"></td>
                </tr>
            </table>
    </form>
    </center>
    </div>
   <div><%@ include file="Footer.jsp"%></div> 

</body>
</html>