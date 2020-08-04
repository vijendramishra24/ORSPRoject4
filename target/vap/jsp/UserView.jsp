
<%@page import="com.rays.proj4.ctl.UserCtl"%>
<%@page import="java.util.List"%>
<%@page import="com.rays.proj4.util.HTMLUtility"%>
<%@page import="java.util.HashMap"%>
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
	width: 105px;
	
}

select {
	margin: 4px 0 0;
	padding: 4px;
	width: 200px;
}
</style>
<body>
 
<div align="center">

<form action="<%=ORSView.USER_CTL%>" method="post">
<%@ include file="Header.jsp"%>
       
        <script type="text/javascript" src="../js/calendar.js"></script>
        <jsp:useBean id="bean" class="com.rays.proj4.bean.UserBean"
            scope="request"></jsp:useBean>

        <%
            List l = (List) request.getAttribute("roleList");
                
        %>
       

        <center>	
        <%if(bean.getId()>0){%>
        	
       
            <h1>Update User</h1>
		<%  }else{ %>
		
		<h1>Add User</h1>
		
		<%} %>
            <H2>
                <font color="red"> <%=ServletUtility.getErrorMessage(request)%>
                </font>
            </H2>

            <H2>
                <font color="green"> <%=ServletUtility.getSuccessMessage(request)%>
                </font>
            </H2>

</div>
<div style="margin-left: 500px">

            <input type="hidden" name="id" value="<%=bean.getId()%>">
            <input type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
            <input type="hidden" name="modifiedBy" value="<%=bean.getModifiedBy()%>"> 
            <input type="hidden" name="createdDatetime" value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
            <input type="hidden" name="modifiedDatetime" value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">




            <table style="table-layout: fixed;">
                        
                <tr>
                    <th align="left">First Name <font color="red">* </font></th>
                    <td><input type="text" name="firstName" placeholder="Enter Name"
                        value="<%=DataUtility.getStringData(bean.getFirstName())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("firstName", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Last Name <font color="red">* </font></th>
                    <td><input type="text" name="lastName" placeholder="Enter Last Name"
                        value="<%=DataUtility.getStringData(bean.getLastName())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("lastName", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">LoginId <font color="red">* </font></th>
                    <td><input type="text" name="login" placeholder="Enter Login ID"
                        value="<%=DataUtility.getStringData(bean.getLogin())%>"
                        <%=(bean.getId() > 0) ? "readonly" : ""%>><font
                        color="red"> <%=ServletUtility.getErrorMessage("login", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Password <font color="red">* </font></th>
                    <td><input type="password" name="password" placeholder="Enter Password"
                        value="<%=DataUtility.getStringData(bean.getPassword())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("password", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Confirm Password <font color="red">* </font></th>
                    <td><input type="password" name="confirmPassword" placeholder="Re-Enter Password"
                        value="<%=DataUtility.getStringData(bean.getPassword())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("confirmPassword",
                    request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Gender <font color="red">* </font></th>
                    <td>
                        <%
                            HashMap map = new HashMap();
                            map.put("Male", "Male");
                            map.put("Female", "Female");
							//map.put("", "Select"); //dummy
												
                            String htmlList = HTMLUtility.getList("gender", bean.getGender(), map);
                        %> <%=htmlList%>
                        <font color="red"> <%=ServletUtility.getErrorMessage("gender", request)%></font></td>
                        
                    </tr>
                    
                    <tr>
                    <th align="left">Role <font color="red">* </font></th>
                   <td> <%=HTMLUtility.getList("roleId",String.valueOf(bean.getRoleId()), l)%>
                    <font color="red"> <%=ServletUtility.getErrorMessage("roleId", request)%></font>
                   </td>
                	</tr>
                
                <tr>
                    <th align="left">Date Of Birth <font color="red">* </font></th>
                    <!-- readonly="readonly" -->
                    <td><input type="text" name="dob" readonly="readonly" placeholder="Click Here"
								value="<%=DataUtility.getDateString(bean.getDob())%>"
								id="datepicker">
                    <font
                        color="red"> <%=ServletUtility.getErrorMessage("dob", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Mobile No. <font color="red">* </font></th>
                    <td><input type="text" name="mobileNo" placeholder="Enter Mobile number"
                        value="<%=DataUtility.getStringData(bean.getMobileNo())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("mobileNo", request)%></font></td>
                </tr>
               
               </table>
              </div>
               <div style="margin-left: 495px">
              <table id="btn"> 
               
                <tr>
                    <th></th>
                    
                    <%if(bean.getId()>0){%>    
          			<td colspan="2"><input type="submit" name="operation"
                        value="<%=UserCtl.OP_UPDATE%>">&emsp;
					<%  }else{ %>
					<td colspan="2"><input type="submit" name="operation"
                        value="<%=UserCtl.OP_SAVE%>">&emsp;
					<%} %>
                      <input type="submit" name="operation" value="<%=UserCtl.OP_CANCEL%>">&emsp;
                        <input type="submit" name="operation" value="<%=UserCtl.OP_RESET%>">
                        </td>
                </tr>
            </table>
    </form>
    </center>
    
    </div>
    <br><br><br><br><br><br>
    <div><%@ include file="Footer.jsp"%></div>


</body>
</html>