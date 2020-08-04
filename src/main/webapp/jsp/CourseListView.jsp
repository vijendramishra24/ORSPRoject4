    
     <%@page import="com.rays.proj4.ctl.CourseListCtl"%>
<%@page import="com.rays.proj4.ctl.BaseCtl"%>
<%@page import="com.rays.proj4.bean.CourseBean"%>
<%@page import="com.rays.proj4.model.CourseModel"%>

<%@page import="com.rays.proj4.util.ServletUtility"%>
<%@page import="java.util.List"%>

<%@page import="java.util.Iterator"%>
<html>
<style>
#customers {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

#customers td, #customers th {
    border: 1px solid #ddd;
    padding: 4px;
}

#customers tr:nth-child(even){background-color: #ddd;}
#customers tr:nth-child(odd){background-color: #ddd;}

#customers tr:hover {background-color: grey;}

#customers th {
    padding-top: 2px;
    padding-bottom: 2px;
    text-align: left;
    background-color: black;
    color: white;
}

</style>

<body>

<%@include file="Header.jsp"%>
<script type="text/javascript">
		function checkAll(bx) {
			var form = bx.form;
			var isChecked = bx.checked;
			for (var i = 0; i < form.length; i++) {
				if (form[i].type == 'checkbox') {
					form[i].checked = isChecked;
				}
			}
		}
	</script>

<div>
    <center>
        <h1>Course List</h1>

        <form action="<%=ORSView.COURSE_LIST_CTL%>" method="post">
        <%CourseBean bean=new CourseBean(); %>
            <table width="100%">
                <tr>
                    <td align="center"><label>Course Name </label> <input type="text"
                        name="name" placeholder="Enter Course Name"
                        value="<%=ServletUtility.getParameter("name", request)%>">
                        &nbsp;
                         <input type="submit" name="operation" value="<%=CourseListCtl.OP_SEARCH %>">
                         &emsp; <input type="submit" name="operation" value="<%=CourseListCtl.OP_RESET %>">
                       
                    </td>
                </tr>
                
            </table>

<h4><font color="red"><%=ServletUtility.getErrorMessage(request)%></font></h4>
<h4><font color="green"><%=ServletUtility.getSuccessMessage(request)%></font></h4>

            <table id="customers">
                <tr>
                <th><input type="checkbox" onclick="checkAll(this)"> Select</th>
                    <th>S.No.</th>
                    <th>Course Name</th>
                    <th>Description</th>
                    <th>Course Code</th>
                   <!--<th>Course Id</th>  --> 
                    <th>Edit</th>
                </tr>
               

                <%
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int index = ((pageNo - 1) * pageSize) + 1;

                    List list = ServletUtility.getList(request);
                    Iterator<CourseBean> it = list.iterator();
                    while (it.hasNext()) {
                        bean = it.next();
                %>
                <tr>
                <td><input type="checkbox" name="ids" value="<%=bean.getId()%>"></td>
                    <td><%=index++%></td> 
                    <td><%=bean.getName()%></td>
                    <td><%=bean.getDescription()%></td>
                    <td><%=bean.getCourseCode()%></td>
                    
                   
                    <td><a href="CourseCtl?id=<%=bean.getId()%>" style="color:blue">Edit</a></td>
                </tr>
                <%
                    }
                %>
            </table>
            <table width="100%">
                <tr>
                    <%if(pageNo>1){ %>
                
                    <td ><input type="submit" name="operation"
                        value="<%=CourseListCtl.OP_PREVIOUS%>"></td>
                        <%}else{ %>
                        <td ><input type="submit" disabled name="operation"
                        value="<%=CourseListCtl.OP_PREVIOUS%>"></td>
                        <%} %>
                        
                        <% if (list.size() != 0){%>  
                     <td ><input type="submit"
                        name="operation" value="<%=CourseListCtl.OP_DELETE%>"></td>
                        
                        <td ><input type="submit"
                        name="operation" value="<%=CourseListCtl.OP_ADD%>"></td><%}else{ %>
                         <td ><input type="submit"
                        name="operation" value="<%=CourseListCtl.OP_BACK%>"></td><%} %>
                        
                     
                     
                     <%
						
                    CourseModel cModel=new CourseModel();
                    if (((cModel.nextPK() - 1) == (int) bean.getId()) || list.size() < pageSize)

                    {
					%>
					<td align="right"><input type="submit" name="operation"
						class="btn_other1" disabled
						value="<%=CourseListCtl.OP_NEXT%>"></td>
					<%
						} else {
					%>

					<td align="right"><input type="submit" name="operation"
						class="btn_other" value="<%=CourseListCtl.OP_NEXT%>"></td>
					<%
						}
					%>                        
                    
                </tr>
            </table>
            <input type="hidden" name="pageNo" value="<%=pageNo%>"> <input
                type="hidden" name="pageSize" value="<%=pageSize%>">
                
                Page No. <%=pageNo%>	&emsp;	Total Entries. <%=list.size() %> 
        </form>
        
        </div>
    
    </center>
    <div><%@ include file="Footer.jsp"%></div>
    


</body>
</html>