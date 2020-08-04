
    <%@page import="com.rays.proj4.ctl.FacultyListCtl"%>
<%@page import="com.rays.proj4.ctl.BaseCtl"%>
<%@page import="com.rays.proj4.bean.FacultyBean"%>
<%@page import="com.rays.proj4.util.ServletUtility"%>
<%@page import="java.util.List"%>
<%@page import="com.rays.proj4.model.FacultyModel"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.rays.proj4.util.HTMLUtility"%>
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

 <%
            List l = (List) request.getAttribute("courseList");
             
        %>
<div>
    <center>
        <h1>Faculty List</h1>

        <form action="<%=ORSView.FACULTY_LIST_CTL%>" method="post">
         <jsp:useBean id="bean" scope="request" class="com.rays.proj4.bean.FacultyBean"></jsp:useBean>
        
            <table width="100%">
                <tr>
                    <td align="center"><label> First Name :</label> <input
                        type="text" name="firstName" placeholder="Enter First Name"
                        value="<%=ServletUtility.getParameter("firstName", request)%>">
                        &emsp;<label>Last Name :</label> <input type="text" name="lastName" placeholder="Enter Last Name"
                        value="<%=ServletUtility.getParameter("lastName", request)%>">
                        
                       &emsp; <label>Course:</label><%=HTMLUtility.getList("courseList",String.valueOf(bean.getCourseId()), l)%>
                               
                        &emsp;<input type="submit" name="operation" value="<%=FacultyListCtl.OP_SEARCH %>">
                        &emsp;<input type="submit" name="operation" value="<%=FacultyListCtl.OP_RESET %>">
                        </td>
                </tr>
            </table>
            
            
                   <h4> <font color="red"><%=ServletUtility.getErrorMessage(request)%></font></h4>
				<H4><font color="green"> <%=ServletUtility.getSuccessMessage(request)%></font></H4>
         
            <table id="customers">
                <tr>
                <th><input type="checkbox" onclick="checkAll(this)">Select</th>
                    <th>S.No.</th>                   
                    <th>First Name.</th>
                    <th>Last Name.</th>
                    <th>Date Of Birth.</th>
                    <th>Mobile No.</th>
                    <th>Email ID.</th>
                    <th>College Name</th>
                    <th>Course Name</th>
                    <th>Subject Name</th>
                    <th>Edit</th>
                </tr>
               
                <%
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int index = ((pageNo - 1) * pageSize) + 1;

                    List list = ServletUtility.getList(request);
                    Iterator<FacultyBean> it = list.iterator();

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
                    <td><%=bean.getLogin()%></td>
                    <td><%=bean.getCollegeName()%></td>
                    <td><%=bean.getCourseName()%></td>
                    <td><%=bean.getSubjectName()%></td>
                    <td><a href="FacultyCtl?id=<%=bean.getId()%>" style="color:blue">Edit</a></td>
                </tr>
                <%
                    }
                %>
            </table>
            <table width="100%">
                <tr>                      
                        
                        <%if(pageNo>1){ %>
                
                    <td ><input type="submit" name="operation"
                        value="<%=FacultyListCtl.OP_PREVIOUS%>"></td>
                        <%}else{ %>
                        <td ><input type="submit" disabled name="operation"
                        value="<%=FacultyListCtl.OP_PREVIOUS%>"></td>
                        <%} %>
                        
                        <% if (list.size() != 0){%> 
                     <td ><input type="submit"
                        name="operation" value="<%=FacultyListCtl.OP_DELETE%>"></td>
                        
                        <td ><input type="submit"
                        name="operation" value="<%=FacultyListCtl.OP_ADD%>"></td><%}else{ %>
                         <td ><input type="submit"
                        name="operation" value="<%=FacultyListCtl.OP_BACK%>"></td><%} %>
                        
                        
                   <%
						
                    FacultyModel fModel=new FacultyModel();
                    if (((fModel.nextPK() - 1) == (int) bean.getId()) || list.size() < pageSize)

                    {
					%>
					<td align="right"><input type="submit" name="operation"
						class="btn_other1" disabled
						value="<%=FacultyListCtl.OP_NEXT%>"></td>
					<%
						} else {
					%>

					<td align="right"><input type="submit" name="operation"
						class="btn_other" value="<%=FacultyListCtl.OP_NEXT%>"></td>
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
    </center>
     <div><%@ include file="Footer.jsp"%></div>
</body>
</html>