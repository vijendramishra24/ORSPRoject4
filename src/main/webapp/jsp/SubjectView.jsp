    
    <%@page import="com.rays.proj4.ctl.SubjectCtl"%>
<%@page import="com.rays.proj4.ctl.BaseCtl"%>
<%@page import="com.rays.proj4.util.DataUtility"%>
<%@page import="java.util.List"%>
<%@page import="com.rays.proj4.util.ServletUtility"%>
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

<form action="<%=ORSView.SUBJECT_CTL%>" method="post">
        <%@ include file="Header.jsp"%>

        <jsp:useBean id="bean" class="com.rays.proj4.bean.SubjectBean"
            scope="request"></jsp:useBean>

        <%
            List l = (List) request.getAttribute("courseList");
                
        %>
        <center>
        
           <%if(bean.getId()>0){%>
        	
       
            <h1>Update Subject</h1>
		<%  }else{ %>
		
		<h1>Add Subject</h1>
		
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

            <input type="hidden" name="id" value="<%=bean.getId()%>">
            <input type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
            <input type="hidden" name="modifiedBy" value="<%=bean.getModifiedBy()%>"> 
            <input type="hidden" name="createdDatetime" value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
            <input type="hidden" name="modifiedDatetime" value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">
            

            <table>
                <tr>
                    <th align="left">Name<font color="red">* </font></th>
                    <td><input type="text" name="name" placeholder="Enter Subject"
                        value="<%=DataUtility.getString(bean.getName())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("name", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Description<font color="red">* </font></th>
                    <td><input type="text" name="description" placeholder="Details of Subject.."
                        value="<%=DataUtility.getString(bean.getDescription())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("description", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Subject Code<font color="red">* </font></th>
                    <td><input type="text" name="subjectcode" placeholder="Enter Subject Code"
                        value="<%=DataUtility.getString(bean.getSubjectCode())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("subjectcode", request)%></font></td>
                </tr>
                
                <!-- dropdown of course name w.r.to course id -->
                
                 <tr>
                    <th align="left">Course Name<font color="red">* </font></th>
                   <td> <%=HTMLUtility.getList("courseId",String.valueOf(bean.getCourseId()), l)%>
                    <font color="red"> <%=ServletUtility.getErrorMessage("courseId", request)%></font>
                   </td>
                	</tr>
                
</table>
              <table id="btn"> 
                                
                <tr>
                    <th></th>
                   <%if(bean.getId()>0){%>    
          			<td colspan="2"><input type="submit" name="operation"
                        value="<%=SubjectCtl.OP_UPDATE%>">&emsp;
					<%  }else{ %>
					<td colspan="2"><input type="submit" name="operation"
                        value="<%=SubjectCtl.OP_SAVE%>">&emsp;
					<%} %>
                   <input type="submit"
                        name="operation" value="<%=SubjectCtl.OP_CANCEL%>">&emsp;<input type="submit"
                        name="operation" value="<%=SubjectCtl.OP_RESET%>"></td>
                </tr>
            </table>
    </form>
    </center>
    </div>
    <br><br><br><br><br><br><br><br><br>
    <%@ include file="Footer.jsp"%>
</body>
</html>