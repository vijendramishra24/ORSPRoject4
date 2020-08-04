    
<%@page import="com.rays.proj4.ctl.MarksheetCtl"%>
<%@page import="java.util.List"%>
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
	width: 81px;
	
}

select {
	margin: 4px 0 0;
	padding: 4px;
	width: 200px;
}
</style>
<body>
<div align="center">

<form action="<%=ORSView.MARKSHEET_CTL%>" method="post">
        <%@ include file="Header.jsp"%>

        <jsp:useBean id="bean" class="com.rays.proj4.bean.MarksheetBean"
            scope="request"></jsp:useBean>

        <%
            List l = (List) request.getAttribute("studentList");
        %>

        <center>
            <%if(bean.getId()>0){%>
            <h1>Update Marksheet</h1>
		<%  }else{ %>
		<h1>Add Marksheet</h1>
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
	<div style="margin-left: 525px">

            <input type="hidden" name="id" value="<%=bean.getId()%>">
            <input type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
            <input type="hidden" name="modifiedBy" value="<%=bean.getModifiedBy()%>"> 
            <input type="hidden" name="createdDatetime" value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
            <input type="hidden" name="modifiedDatetime" value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">
            

            <table>
                <tr>
                    <th align="left">Roll No<font color="red">* </font></th>
                    <td><input type="text" name="rollNo" placeholder="eg. 0837EC11MT18"
                        value="<%=DataUtility.getString(bean.getRollNo())%>"
                        <%=(bean.getId() > 0) ? "readonly" : ""%>> <font
                        color="red"> <%=ServletUtility.getErrorMessage("rollNo", request)%></font></td>
                </tr>
             
              <tr>
                    <th align="left">Name <font color="red">* </font></th>
                   <td> <%=HTMLUtility.getList("studentId",String.valueOf(bean.getStudentId()), l)%>
                    <font color="red"> <%=ServletUtility.getErrorMessage("studentId", request)%></font>
                   </td>
                	</tr>
             
                <tr>`
                    <th align="left">Physics<font color="red">* </font></th>
                    <td><input type="text" name="physics" placeholder="Enter Physis Marks"
                        value="<%=DataUtility.getStringData(bean.getPhysics())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("physics", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Chemistry<font color="red">* </font></th>
                    <td><input type="text" name="chemistry" placeholder="Enter Physis Marks"
                        value="<%=DataUtility.getStringData(bean.getChemistry())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("chemistry", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Maths<font color="red">* </font></th>
                    <td><input type="text" name="maths" placeholder="Enter Physis Marks"
                        value="<%=DataUtility.getStringData(bean.getMaths())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("maths", request)%></font></td>

                </tr>

</table>
              <table id="btn"> 
                
                <tr>
                    <th></th>
                     <%if(bean.getId()>0){%>    
          			<td colspan="2"><input type="submit" name="operation"
                        value="<%=MarksheetCtl.OP_UPDATE%>">&emsp;
					<%  }else{ %>
					<td colspan="2"><input type="submit" name="operation"
                        value="<%=MarksheetCtl.OP_SAVE%>">&emsp;
					<%} %>
                    
                    
                     
                         <input type="submit" name="operation"
                        value="<%=MarksheetCtl.OP_CANCEL%>">&emsp;
                        
                         <input type="submit" name="operation"
                        value="<%=MarksheetCtl.OP_RESET%>"></td>
                </tr>
            </table>
        </form>
        </center>
        </div>
        <bR><bR><bR><bR><bR><bR><bR><bR><bR><bR><bR>
        <%@ include file="Footer.jsp"%>


</body>
</html>