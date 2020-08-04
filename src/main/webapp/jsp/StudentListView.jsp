    
<%@page import="com.rays.proj4.ctl.StudentListCtl"%>
<%@page import="com.rays.proj4.model.StudentModel"%>

<%@page import="com.rays.proj4.util.ServletUtility"%>
<%@page import="com.rays.proj4.bean.StudentBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.rays.proj4.model.UserModel"%>
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
        <h1>Student List</h1>

        <form action="<%=ORSView.STUDENT_LIST_CTL%>" method="post">
        <%StudentBean bean=new StudentBean(); %>
            <table width="100%">
                <tr>
                    <td align="center"><label> First Name :</label> <input
                        type="text" name="firstName" placeholder="Enter First Name"
                        value="<%=ServletUtility.getParameter("firstName", request)%>">
                       &emsp; <label>Last Name :</label> <input type="text" name="lastName" placeholder="Enter Last Name"
                        value="<%=ServletUtility.getParameter("lastName", request)%>">
                        &emsp;<label>Email Id:</label> <input type="text" name="email" placeholder="Enter Email Id"
                        value="<%=ServletUtility.getParameter("email", request)%>">
                        &emsp;<input type="submit" name="operation" value="<%=StudentListCtl.OP_SEARCH %>">
                         &emsp;<input type="submit" name="operation" value="<%=StudentListCtl.OP_RESET %>"></td>
                </tr>
            </table>
            
         <h4> <font color="red"><%=ServletUtility.getErrorMessage(request)%></font></h4>
				<H4><font color="green"> <%=ServletUtility.getSuccessMessage(request)%></font></H4>
         
            <table id="customers">
                <tr>
                <th><input type="checkbox" onclick="checkAll(this)">Select</th>
                    <th>S.No.</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Date Of Birth</th>
                    <th>Mobile No</th>
                    <th>Email ID</th>
                    <th>College Name</th>
                    <th>Edit</th>
                </tr>
                
                <%
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int index = ((pageNo - 1) * pageSize) + 1;

                    List list = ServletUtility.getList(request);
                    Iterator<StudentBean> it = list.iterator();

                    while (it.hasNext()) {

                         bean = it.next();
                %>
                <tr>
                    <td><input type="checkbox" name="ids" value="<%=bean.getId()%>"></td>
                    <td><%=index++%></td>
                    <td><%=bean.getFirstName()%></td>
                    <td><%=bean.getLastName()%></td>
                    <td><%=bean.getDob()%></td>
                    <td><%=bean.getMobileNo()%></td>
                    <td><%=bean.getEmail()%></td>
                    <td><%=bean.getCollegeName() %></td>
                    <td><a href="StudentCtl?id=<%=bean.getId()%>" style="color:blue">Edit</a></td>
                </tr>
                <%
                    }
                %>
            </table>
            <table width="100%">
                <tr>                      
                        
                        <%if(pageNo>1){ %>
                
                    <td ><input type="submit" name="operation"
                        value="<%=StudentListCtl.OP_PREVIOUS%>"></td>
                        <%}else{ %>
                        <td ><input type="submit" disabled name="operation"
                        value="<%=StudentListCtl.OP_PREVIOUS%>"></td>
                        <%} %>
                        
                        <% if (list.size() != 0){%> 
                     <td ><input type="submit"
                        name="operation" value="<%=StudentListCtl.OP_DELETE%>"></td>
                        
                        <td ><input type="submit"
                        name="operation" value="<%=StudentListCtl.OP_ADD%>"></td><%}else{ %>
                         <td ><input type="submit"
                        name="operation" value="<%=StudentListCtl.OP_BACK%>"></td><%} %>
                        
                    <% 
                    StudentModel stModel=new StudentModel();
                    if (((stModel.nextPK() - 1) == (int) bean.getId()) || list.size() < pageSize)

                    {
					%>
					<td align="right"><input type="submit" name="operation"
						class="btn_other1" disabled
						value="<%=StudentListCtl.OP_NEXT%>"></td>
					<%
						} else {
					%>

					<td align="right"><input type="submit" name="operation"
						class="btn_other" value="<%=StudentListCtl.OP_NEXT%>"></td>
					<%
						}
					%>
                        
                </tr>
            </table>
            <input type="hidden" name="pageNo" value="<%=pageNo%>"><input
                type="hidden" name="pageSize" value="<%=pageSize%>">

Page No. <%=pageNo%>	&emsp;	Total Entries. <%=list.size()%>
        </form>
        </div>
    
    
   <div><%@include file="Footer.jsp"%></div> 
</body>
</body>
</html>