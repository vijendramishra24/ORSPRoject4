    
<%@page import="com.rays.proj4.ctl.FacultyCtl"%>

<%@page import="com.rays.proj4.util.ServletUtility"%>
<%@page import="com.rays.proj4.bean.FacultyBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.rays.proj4.util.DataUtility"%>
<%@page import="com.rays.proj4.util.HTMLUtility"%>
    
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
	width: 92px;
	
}

select {
	margin: 4px 0 0;
	padding: 4px;
	width: 200px;
}
</style>
<body>
<div align="center">


<center>

<form action="<%=ORSView.FACULTY_CTL%>" method="post">
        <%@ include file="Header.jsp"%>
        <script type="text/javascript" src="../js/calendar.js"></script>
        <jsp:useBean id="bean" class="com.rays.proj4.bean.FacultyBean"
            scope="request"></jsp:useBean>

       <%
            List l1 = (List) request.getAttribute("collegeList");
       List l2 = (List) request.getAttribute("subjectList");
       List l3 = (List) request.getAttribute("courseList");
        %>

        <center>
        <%if(bean.getId()>0){%>
        	
       
            <h1>Update Faculty</h1>
		<%  }else{ %>
		
		<h1>Add Faculty</h1>
		
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


            <table>
                <tr>
                    <th align="left">First Name <font color="red">* </font></th>
                    <td><input type="text" name="firstName" placeholder="Enter Name"
                        value="<%=DataUtility.getString(bean.getFirstName())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("firstName", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Last Name <font color="red">* </font></th>
                    <td><input type="text" name="lastName" placeholder="Enter Last Name"
                        value="<%=DataUtility.getString(bean.getLastName())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("lastName", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">EmailId <font color="red">* </font></th>
                    <td><input type="text" name="email" placeholder="Enter Email ID"
                        value="<%=DataUtility.getString(bean.getLogin())%>"
                        <%=(bean.getId() > 0) ? "readonly" : ""%>><font
                        color="red"> <%=ServletUtility.getErrorMessage("email", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Mobile No <font color="red">* </font></th>
                    <td><input type="text" name="mobileNo" placeholder="Enter Mobile Number"
                        value="<%=DataUtility.getString(bean.getMobileNo())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("mobileNo", request)%></font></td>
                </tr>
               
              <tr>
                    <th align="left">College Name <font color="red">* </font></th>
                   <td> <%=HTMLUtility.getList("collegeId",String.valueOf(bean.getCollegeId()), l1)%>
                    <font color="red"> <%=ServletUtility.getErrorMessage("collegeId", request)%></font>
                   </td>
                	</tr>
                      
                   
                <tr>
                    <th align="left">Date Of Birth <font color="red">* </font></th>
                    <!-- readonly="readonly" -->
                    <td><input type="text" name="dob" readonly="readonly" placeholder="Click Here"
								value="<%=DataUtility.getDateString(bean.getDob())%>"
								id="datepicker">
                    </a><font
                        color="red"> <%=ServletUtility.getErrorMessage("dob", request)%></font></td>
                </tr>
                
              <tr>
                    <th align="left">Subject Name <font color="red">* </font></th>
                   <td> <%=HTMLUtility.getList("subjectId",String.valueOf(bean.getSubjectId()), l2)%>
                    <font color="red"> <%=ServletUtility.getErrorMessage("subjectId", request)%></font>
                   </td>
                	</tr>
              <tr>
                    <th align="left">Course Name <font color="red">* </font></th>
                   <td> <%=HTMLUtility.getList("courseId",String.valueOf(bean.getCourseId()), l3)%>
                    <font color="red"> <%=ServletUtility.getErrorMessage("courseId", request)%></font>
                   </td>
                	</tr>
                           
</table>
              <table id="btn"> 
                                             
               
                <tr>
                    <th></th>
                    
                    <%if(bean.getId()>0){%>    
          			<td colspan="2"><input type="submit" name="operation"
                        value="<%=FacultyCtl.OP_UPDATE%>">&emsp;
					<%  }else{ %>
					<td colspan="2"><input type="submit" name="operation"
                        value="<%=FacultyCtl.OP_SAVE%>">&emsp;
					<%} %>
                      <input type="submit" name="operation" value="<%=FacultyCtl.OP_CANCEL%>">&emsp;
                        <input type="submit" name="operation" value="<%=FacultyCtl.OP_RESET%>">
                        </td>
                </tr>
            </table>
    </form>
    </center>
</div>
    <br><br><br><br><br><br>
    <%@ include file="Footer.jsp"%>


        


</body>
</html>