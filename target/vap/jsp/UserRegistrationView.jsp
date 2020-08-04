<%@page import="com.rays.proj4.ctl.UserRegistrationCtl"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.rays.proj4.util.HTMLUtility"%>
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
	width: 88px;
}

select {
	margin: 4px 0 0;
	padding: 4px;
	width: 200px;
}
</style>
<body>
<div align="center">
<form action="<%=ORSView.USER_REGISTRATION_CTL%>" method="post">

        <%@ include file="Header.jsp"%>
        <script type="text/javascript" src="./js/calendar.js"></script>
        <jsp:useBean id="bean" class="com.rays.proj4.bean.UserBean"
            scope="request"></jsp:useBean>

        <center>
        <br><br><br>
            <h1>User Registration</h1>

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
            <input type="hidden" name="id" value="<%=bean.getId()%>">
            <input type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
            <input type="hidden" name="modifiedBy" value="<%=bean.getModifiedBy()%>"> 
            <input type="hidden" name="createdDatetime" value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
            <input type="hidden" name="modifiedDatetime" value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">
            

            <table>
<!-- .getString at place of .getStringData (5 places) -->
                <tr>
                    <th align="left">First Name<font color="red">* </font></th>
                    <td><input type="text" name="firstName" placeholder="Enter your First Name"
                        value="<%=DataUtility.getString(bean.getFirstName())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("firstName", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Last Name<font color="red">* </font></th>
                    <td><input type="text" name="lastName" placeholder="Enter your Last Name"
                        value="<%=DataUtility.getString(bean.getLastName())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("lastName", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">LoginId<font color="red">* </font></th>
                    <td><input type="text" name="login"
                        placeholder="Must be Email ID"
                        value="<%=DataUtility.getString(bean.getLogin())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("login", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Password<font color="red">* </font></th>
                    <td><input type="password" name="password" placeholder="Set your Password"
                        value="<%=DataUtility.getString(bean.getPassword())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("password", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Confirm Password<font color="red">* </font></th>
                    <td><input type="password" name="confirmPassword" placeholder="Re-Enter your Password"
                        value="<%=DataUtility.getString(bean.getConfirmPassword())%>"><font
                        color="red"> <%=ServletUtility
                    .getErrorMessage("confirmPassword", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Gender<font color="red">* </font></th>
                    <td>
                        <%
                            HashMap map = new HashMap();
                            map.put("M", "Male");
                            map.put("F", "Female");

                            String htmlList = HTMLUtility.getList("gender", bean.getGender(), map);
                        %> <%=htmlList%>

                    <font color="red"> <%=ServletUtility.getErrorMessage("gender", request)%></font></td></td>
                </tr>

                <tr>
                    <th align="left">Date Of Birth<font color="red">* </font></th>
                    <td><input type="text" name="dob" readonly="readonly" placeholder="yyyy/mm/dd"
								value="<%=DataUtility.getDateString(bean.getDob())%>"
								id="datepicker">
                    <font color="red"> <%=ServletUtility.getErrorMessage("dob", request)%></font></td>
                </tr>
                
                 </table>
 
  </div>
	<div style="margin-left: 630px">
              <table id="btn"> 
                <tr>
                    <th></th>
                    <td colspan="2">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        &nbsp; <input type="submit" name="operation" value="<%=UserRegistrationCtl.OP_SIGN_UP %>">
                    </td>
                </tr>
            </table>
    </form>
   
    
    </center>
    </div>
   <div><%@ include file="Footer.jsp"%>
          </div> 
         
</body>
</html>