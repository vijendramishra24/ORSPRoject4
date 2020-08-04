    
<%@page import="com.rays.proj4.ctl.TimetableListCtl"%>
<%@page import="com.rays.proj4.util.ServletUtility"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.rays.proj4.bean.TimetableBean"%>
<%@page import="com.rays.proj4.bean.CourseBean"%>
<%@page import="com.rays.proj4.bean.SubjectBean"%>

<%@page import="com.rays.proj4.model.TimetableModel"%>
<%@page import="com.rays.proj4.model.CourseModel"%>
<%@page import="com.rays.proj4.model.SubjectModel"%>

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
    padding-top: 6px;
    padding-bottom: 6px;
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
       List l2 = (List) request.getAttribute("subjectList");
       List l3 = (List) request.getAttribute("courseList");
        %>
      <div>  
    <center>
        <h1>Timetable List</h1>

        <form action="<%=ORSView.TIMETABLE_LIST_CTL%>" method="post">
        
        <jsp:useBean id="bean" scope="request" class="com.rays.proj4.bean.TimetableBean"></jsp:useBean>
        

            <table><!-- <table width="100%"> --> 
                <tr>
                    <td align="center">
                        <label>Course Name:</label><%=HTMLUtility.getList("courseList",String.valueOf(bean.getCourseId()), l3)%>                       
                        
                        &emsp;<label>Subject Name:</label><%=HTMLUtility.getList("subjectList",String.valueOf(bean.getSubjectId()), l2)%>
                                                
                    
                                    
                                               
                        &emsp;<input type="submit" name="operation" value="<%=TimetableListCtl.OP_SEARCH %>">
                       &emsp; <input type="submit" name="operation" value="<%=TimetableListCtl.OP_RESET %>">
                       
                       <!-- &emsp; <input type="submit" value="Reset"> --> 
                    </td>
                </tr>
            </table>
            
                   <h4> <font color="red"><%=ServletUtility.getErrorMessage(request)%></font></h5>

<H4><font color="green"> <%=ServletUtility.getSuccessMessage(request)%></font></H4>

            <table id="customers">
            <!-- <table border="1" width="100%"> -->
                <tr>
                    <th><input type="checkbox" onclick="checkAll(this)">Select</th>
                    <th>S.No.</th>
                    <th>Course Name</th>
                    <th>Semester</th>
                    <th>Subject Name</th>
                    <th>Exam Date</th>
                    <th>Exam Time</th>
                    <th>Edit</th>
                </tr>

               
                <%
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int index = ((pageNo - 1) * pageSize) + 1;

                    List list = ServletUtility.getList(request);
                    Iterator<TimetableBean> it = list.iterator();
                    while (it.hasNext()) {
                        bean = it.next();
                %>
                
                      <%
                CourseModel course = new CourseModel();
                CourseBean coursebean = course.findByPK(bean.getCourseId());
                
                SubjectModel sm=new SubjectModel();
                SubjectBean sbean=sm.findByPK(bean.getSubjectId());
                
                %>  
                
                            
                <tr>
                    
                    <td><input type="checkbox" name="ids" value="<%=bean.getId()%>"></td>
                    <td><%=index++%></td>
                    <td><%=coursebean.getName()%></td>
                    <td><%=bean.getSem()%></td>
                    <td><%=sbean.getName()%></td>
                    <td><%=bean.getExamDate()%></td>
                    <td><%=bean.getExamTime()%></td>
                    <td><a href="TimetableCtl?id=<%=bean.getId()%>" style="color:blue">Edit</a></td>
                        </tr>
                <%
                    }
                %>
            </table>
            
            
            <table width="100%">
                <tr>
                <%if(pageNo>1){ %>
                
                    <td ><input type="submit" name="operation"
                        value="<%=TimetableListCtl.OP_PREVIOUS%>"></td>
                        <%}else{ %>
                        <td ><input type="submit" disabled name="operation"
                        value="<%=TimetableListCtl.OP_PREVIOUS%>"></td>
                        <%} %>
                        
                         <% if (list.size() != 0){%>
                     <td ><input type="submit"
                        name="operation" value="<%=TimetableListCtl.OP_DELETE%>"></td>
                        
                        <td ><input type="submit"
                        name="operation" value="<%=TimetableListCtl.OP_ADD%>"></td><%}else{ %>
                         <td ><input type="submit"
                        name="operation" value="<%=TimetableListCtl.OP_BACK%>"></td><%} %>
                      
                      <%
						
                    TimetableModel tModel=new TimetableModel();
                    if (((tModel.nextPK() - 1) == (int) bean.getId()) || list.size() < pageSize)

                    {
					%>
					<td align="right"><input type="submit" name="operation"
						class="btn_other1" disabled
						value="<%=TimetableListCtl.OP_NEXT%>"></td>
					<%
						} else {
					%>

					<td align="right"><input type="submit" name="operation"
						class="btn_other" value="<%=TimetableListCtl.OP_NEXT%>"></td>
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