<%@page import="com.rays.proj4.ctl.ForgetPasswordCtl"%>
<%@page import="com.rays.proj4.util.DataUtility"%>
<%@page import="com.rays.proj4.util.ServletUtility"%>
<html>
<body>


 <form action="<%=ORSView.FORGET_PASSWORD_CTL%>" method="post">

        <%@ include file="Header.jsp"%>

        <jsp:useBean id="bean" class="com.rays.proj4.bean.UserBean"
            scope="request"></jsp:useBean>
<div>
        <center>
        <br><br><br><br><br>
            <h1>Forgot your password?</h1>
            <input type="hidden" name="id" value="<%=bean.getId()%>">


		<h3>Submit your email address and we'll send you password.</h3><br><br>
            <table>
                
                <label>Email Id :</label>&emsp;
                <input type="text" name="login" placeholder="Enter ID Here"
                    value="<%=ServletUtility.getParameter("login", request)%>">&emsp;
                <input type="submit" name="operation" value="<%=ForgetPasswordCtl.OP_GO%>">&emsp;
                <input type="submit" name="operation" value="<%=ForgetPasswordCtl.OP_RESET%>">
                <br>
                <font color="red"> <%=ServletUtility.getErrorMessage("login", request)%></font>
            </table>
            
            <H2>
                <font color="green"> <%=ServletUtility.getSuccessMessage(request)%>
                </font>
            </H2>
            <H2>
                <font color="red"> <%=ServletUtility.getErrorMessage(request)%>
                </font>
            </H2>
    </form>
    </center>
   </div>
    <div><%@ include file="Footer.jsp"%></div>

</body>
</html>