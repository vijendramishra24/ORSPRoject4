    <%@page import="com.rays.proj4.ctl.LoginCtl"%>
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
 <div><form action="<%=ORSView.LOGIN_CTL%>" method="post"></div>
        <%@ include file="Header.jsp"%>
 
        <jsp:useBean id="bean" class="com.rays.proj4.bean.UserBean"
            scope="request"></jsp:useBean>

        <center>
                <br><br><br>
        
           <h1>Login</h1>

				<H2>
					<font color="red"> <%=ServletUtility.getErrorMessage(request)%>
				</h2>
				</font>

				<%
					String msg = (String) request.getAttribute("success");
					if (msg == null) {
						msg = "";

					} else {
				%>
				<h2>
					<font color="green"><%=ServletUtility.getSuccessMessage(request)%></font>
				</h2>
				<%
					}
				%>


				<%
					if (request.getAttribute("message") == null) {
					} else {
				%>
				<font color="red"> <%=request.getAttribute("message")%>
				</font>
				</H2>
				<%
					}
				%>
     </div>
	<div style="margin-left: 525px">
           
              <input type="hidden" name="uri" value="<%=request.getAttribute("targeturi")%>">
              <input type="hidden" name="id" value="<%=bean.getId()%>">
              <input type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
              <input type="hidden" name="modifiedBy" value="<%=bean.getModifiedBy()%>"> 
              <input type="hidden" name="createdDatetime" value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
              <input type="hidden" name="modifiedDatetime" value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">

            <table>
                <tr>
                    <th align="left">LoginId<font color="red">* </font></th>
                    <td><input type="text" name="login" placeholder="Enter Login ID" size=30
                    value="<%=DataUtility.getString(bean.getLogin())%>"></td><!--  DataUtility.getStringData(bean.getPassword()):::ORIGINAL: but no method named getStringData in DataUtility -->
                    <td><font color="red"><%=ServletUtility.getErrorMessage("login", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Password<font color="red">* </font></th>
                    <td><input type="password" name="password" placeholder="Enter Password" size=30
                        value="<%=DataUtility.getString(bean.getPassword())%>"></td><td><!--  DataUtility.getStringData(bean.getPassword()):::ORIGINAL: but no method named getStringData in DataUtility --><font
                        color="red"> <%=ServletUtility.getErrorMessage("password", request)%></font></td>
                </tr>
                
              </table>
              </div>
              <div style="margin-left: 605px">
              <table id="btn"> 
                <tr>
                    <th></th>
                    <td colspan="2"><input type="submit" name="operation"
                        value="<%=LoginCtl.OP_SIGN_IN %>"> &nbsp; <input type="submit"
                        name="operation" value="<%=LoginCtl.OP_SIGN_UP %>" > &nbsp;</td>
                </tr>
                <tr><th></th>
            </tr>
            </table>
           &nbsp; <a href="<%=ORSView.FORGET_PASSWORD_CTL%>"  style="color:blue"><b>Forget password</b></a>
    </form>
    </center>
   </div>
<div> <%@ include file="Footer.jsp"%></div>   


</body>
</html>