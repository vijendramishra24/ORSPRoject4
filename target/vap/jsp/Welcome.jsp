<%@page import="com.rays.proj4.ctl.ORSView"%>
<%@page import="com.rays.proj4.bean.UserBean" %>
<%@page import="com.rays.proj4.bean.RoleBean" %>

<html>
<body>

<form action="<%=ORSView.WELCOME_CTL%>">
        <%@ include file="Header.jsp"%>
                    <h1 align="Center">
                    <br><br><br>
                        <font size="10px" color="black">Welcome to ORS </font>
                    </h1>
        
                    <%
                    UserBean beanUserBean = (UserBean) session.getAttribute("user");
                        if (beanUserBean != null) {
                            if (beanUserBean.getRoleId() == RoleBean.STUDENT) {
                    %>
        
                    <h2 align="Center">
                        <a href="<%=ORSView.GET_MARKSHEET_CTL%>">Click here to see your Mark sheet </a>
                    </h2>
                     
                     <%
                            }
                        }
                     %>
                <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
                </form>
        
<div><%@ include file="Footer.jsp"%>
</div> 

</body>
</html>