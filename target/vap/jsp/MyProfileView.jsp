
    
<%@page import="com.rays.proj4.ctl.MyProfileCtl"%>
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
	width: 200px;
	
}

select {
	margin: 4px 0 0;
	padding: 4px;
	width: 200px;
}
</style>
<body >
<div align="center">
<form action="<%=ORSView.MY_PROFILE_CTL%>" method="post">

        <%@ include file="Header.jsp"%>
        <script type="text/javascript" src="../js/calendar.js"></script>
        <jsp:useBean id="bean" class="com.rays.proj4.bean.UserBean"
            scope="request"></jsp:useBean>

        <center>
        
            <h1>My Profile</h1>
            
            <H2>
                <font color="red"> <%=ServletUtility.getErrorMessage(request)%>
                </font>
            </H2>
            
            </div>
	<div style="margin-left: 520px">
            <input type="hidden" name="id" value="<%=bean.getId()%>">
            <input type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
            <input type="hidden" name="modifiedBy" value="<%=bean.getModifiedBy()%>"> 
            <input type="hidden" name="createdDatetime" value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
            <input type="hidden" name="modifiedDatetime" value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">
            

            <table>
                <tr>
                    <th align="left">LoginId<font color="red">* </font></th>
                    <td><input type="text" name="login"
                        value="<%=DataUtility.getString(bean.getLogin())%>"readonly="readonly"><font
                        color="red"> <%=ServletUtility.getErrorMessage("login", request)%></font></td>
                </tr>

                <tr>
                    <th align="left">First Name<font color="red">* </font></th>
                    <td><input type="text" name="firstName"
                        value="<%=DataUtility.getString(bean.getFirstName())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("firstName", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Last Name<font color="red">* </font></th>
                    <td><input type="text" name="lastName"
                        value="<%=DataUtility.getString(bean.getLastName())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("lastName", request)%></font></td>
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
                  
                    <th align="left">Mobile No<font color="red">* </font></th>
                    <td><input type="text" name="mobileNo"
                        value="<%=DataUtility.getString(bean.getMobileNo())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("mobileNo", request)%></font></td>
                </tr>

                <tr>
                    <th align="left">Date Of Birth<font color="red">* </font></th>
                    <!--readonly="readonly"  -->
                    <td><input type="text" name="dob"  
                        value="<%=DataUtility.getDateString(bean.getDob())%>" id="datepicker">
                    <font
                        color="red"> <%=ServletUtility.getErrorMessage("dob", request)%></font></td>
                </tr>
                
            <H2>
                <font color="green"> <%=ServletUtility.getSuccessMessage(request)%>
                </font>
            </H2>
              
              
              </table>
              
              </div>
	<div style="margin-left: 625px">
              <table id="btn"> 
                <tr>
                    <th></th>
                    
                    <td colspan="2"> <input type="submit"
                        name="operation" value="<%=MyProfileCtl.OP_SAVE %>"> &nbsp;<bR><input type="submit" name="operation"
                        value="<%=MyProfileCtl.OP_CHANGE_MY_PASSWORD %>"> &nbsp;</td>
                </tr>
            </table>
    </form>
    </center>
    </div>
    <br><br><br><br><br><br><br><br>
    <div><%@ include file="Footer.jsp"%></div>

</body>
</html>