    <%@page import="com.rays.proj4.ctl.ChangePasswordCtl"%>
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
	width: 200;
	
}

select {
	margin: 4px 0 0;
	padding: 4px;
	width: 200px;
}
</style>
<body>
<div align="center">
<form action="<%=ORSView.CHANGE_PASSWORD_CTL%>" method="post">
        
        <%@ include file="Header.jsp"%>

        <jsp:useBean id="bean" class="com.rays.proj4.bean.UserBean"
            scope="request"></jsp:useBean>

        <center>
         
            <h1>Change Password</h1>


            <H2>
                <font color="red"> <%=ServletUtility.getErrorMessage(request)%>
                </font>
            </H2>
<H2>
                <font  color="green"> <%=ServletUtility.getSuccessMessage(request)%>
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



                <tr>
                    <th align="left">Old Password<font color="red">* </font></th>
                    <td><input type="password" name="oldPassword" placeholder="Enter Yours Old Password"
                        value=<%=DataUtility
                    .getString(request.getParameter("oldPassword") == null ? ""
                            : DataUtility.getStringData(request
                                    .getParameter("oldPassword")))%>><font
                        color="red"> <%=ServletUtility.getErrorMessage("oldPassword", request)%></font></td>
                </tr>

                <tr>
                    <th align="left">New Password<font color="red">* </font></th>
                    <td><input type="password" name="newPassword" placeholder="Enter Yours New Password"
                        value=<%=DataUtility
                    .getString(request.getParameter("newPassword") == null ? ""
                            : DataUtility.getStringData(request
                                    .getParameter("newPassword")))%>><font
                        color="red"> <%=ServletUtility.getErrorMessage("newPassword", request)%></font></td>
                </tr>

                <tr>
                    <th align="left">Confirm Password<font color="red">* </font></th>
                    <td><input type="password" name="confirmPassword" placeholder="Re-Enter Yours New Password"
                        value=<%=DataUtility.getString(request
                    .getParameter("confirmPassword") == null ? "" : DataUtility
                    .getString(request.getParameter("confirmPassword")))%>><font
                        color="red"> <%=ServletUtility
                    .getErrorMessage("confirmPassword", request)%></font></td>
                </tr>

</table>
</div>
	<div style="margin-left: 647px">
              <table id="btn"> 

                <tr>
                    <th></th>
                    <td colspan="2"><input type="submit"
                        name="operation" value="<%= ChangePasswordCtl.OP_SAVE%>"> &nbsp;<br><input type="submit" name="operation"
                        value="<%=ChangePasswordCtl.OP_CHANGE_MY_PROFILE %>"> &nbsp; </td>
                </tr>

            </table>
                </form>
    </center>
    </div>
    <br><br><br><br><br><br><br><br><br><br>
    <div><%@ include file="Footer.jsp"%></div>

</body>
</html>