    
    <%@page import="com.rays.proj4.ctl.SubjectListCtl"%>
<%@page import="com.rays.proj4.ctl.BaseCtl"%>
<%@page import="com.rays.proj4.bean.SubjectBean"%>
<%@page import="com.rays.proj4.bean.CourseBean"%>
<%@page import="com.rays.proj4.util.ServletUtility"%>
<%@page import="java.util.List"%>
<%@page import="com.rays.proj4.model.CourseModel"%>
<%@page import="com.rays.proj4.model.SubjectModel"%>
<%@page import="com.rays.proj4.util.HTMLUtility"%>
<%@page import="com.rays.proj4.model.UserModel"%>
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
 <%
            List l = (List) request.getAttribute("courseList");
                
        %>
  
<div>
    <center>
        <h1>Subject List</h1>

        <form action="<%=ORSView.SUBJECT_LIST_CTL%>" method="post">
            <jsp:useBean id="bean" scope="request" class="com.rays.proj4.bean.SubjectBean"></jsp:useBean>
            
            <table width="100%">
                <tr>
                    <td align="center"><label>Subject Name :</label> <input type="text"
                        name="name" placeholder="Enter Subject Name" value="<%=ServletUtility.getParameter("name", request)%>">
                         &emsp; <label>Course Name :</label> <%=HTMLUtility.getList("courseList",String.valueOf(bean.getCourseId()), l)%>
                         &nbsp;
                         <input type="submit" name="operation" value="<%=SubjectListCtl.OP_SEARCH %>">
                         &emsp; <input type="submit" name="operation" value="<%=SubjectListCtl.OP_RESET %>">
                       
                    </td>
                </tr>
                
            </table>

<h4><font color="red"><%=ServletUtility.getErrorMessage(request)%></font></h4>
<h4><font color="green"><%=ServletUtility.getSuccessMessage(request)%></font></h4>

            <table id="customers">
                <tr>
                <th><input type="checkbox" onclick="checkAll(this)">Select</th>
                    <th>S.No.</th>
                    <th>Subject Name</th>
                    <th>Description</th>
                    <th>Subject Code</th>
                   <th>Course Name</th> 
                    <th>Edit</th>
                </tr>
               

                <%
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int index = ((pageNo - 1) * pageSize) + 1;

                    List list = ServletUtility.getList(request);
                    Iterator<SubjectBean> it = list.iterator();
                    while (it.hasNext()) {
                         bean = it.next();
                %>
                
                <%
                CourseModel course = new CourseModel();
                int courseId = bean.getCourseId();
                CourseBean coursebean = course.findByPK(courseId);
                coursebean.getName();
                %>
                
                
                <tr>
                <td align="center"><input type="checkbox" name="ids" value="<%=bean.getId()%>"></td>
                    <td align="center"><%=index++%></td>
                    <td><%=bean.getName()%></td>
                    <td><%=bean.getDescription()%></td>
                    <td><%=bean.getSubjectCode()%></td>
                     <td><%=coursebean.getName()%></td>
                    <td><a href="SubjectCtl?id=<%=bean.getId()%>" style="color:blue">Edit</a></td>
                </tr>
                <%
                    }
                %>
            </table>
            <table width="100%">
                <tr>
                    <%if(pageNo>1){ %>
                
                    <td ><input type="submit" name="operation"
                        value="<%=SubjectListCtl.OP_PREVIOUS%>"></td>
                        <%}else{ %>
                        <td ><input type="submit" disabled name="operation"
                        value="<%=SubjectListCtl.OP_PREVIOUS%>"></td>
                        <%} %>
                        
                        <% if (list.size() != 0){%>
                     <td ><input type="submit"
                        name="operation" value="<%=SubjectListCtl.OP_DELETE%>"></td>
                        
                        <td ><input type="submit"
                        name="operation" value="<%=SubjectListCtl.OP_ADD%>"></td><%}else{ %>
                         <td ><input type="submit"
                        name="operation" value="<%=SubjectListCtl.OP_BACK%>"></td><%} %>
                        
                    <%
						
                    SubjectModel sModel=new SubjectModel();
                    if (((sModel.nextPK() - 1) == (int) bean.getId()) || list.size() < pageSize)

                    {
					%>
					<td align="right"><input type="submit" name="operation"
						class="btn_other1" disabled
						value="<%=SubjectListCtl.OP_NEXT%>"></td>
					<%
						} else {
					%>

					<td align="right"><input type="submit" name="operation"
						class="btn_other" value="<%=SubjectListCtl.OP_NEXT%>"></td>
					<%
						}
					%>
                    
                        
                    
                </tr>
            </table>
            <input type="hidden" name="pageNo" value="<%=pageNo%>"> <input
                type="hidden" name="pageSize" value="<%=pageSize%>">
                
                Page No. <%=pageNo%>	&emsp;	Total Entries. <%=list.size()%>
        </form>
        </div>
    </center>
     <div><%@include file="Footer.jsp"%></div> 
</body>
</html>