    <%@page import="com.rays.proj4.ctl.TimetableCtl"%>
<%@page import="java.util.List"%>
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

<!-- JAVA SCRIP FOR CLAENDER -->
<script type="text/javascript"
	src="<%=ORSView.APP_CONTEXT%>/js/calendar.js"></script>
<script type="text/javascript"
	src="<%=ORSView.APP_CONTEXT%>/js/jquery-1.12.4.js"></script>
<script type="text/javascript"
	src="<%=ORSView.APP_CONTEXT%>/js/jquery-ui.js"></script>
<script type="text/javascript">
	$(function() {
		$("#datepicker1").datepicker({
			dateFormat : 'yy/mm/dd',
			changeMonth : true,
			changeYear : true,
			yearRange : 'c:c+1', 
			minDate :'+1'
			
		});
	});
</script>


<form action="<%=ORSView.TIMETABLE_CTL%>" method="post">
        <%@ include file="Header.jsp"%>
        <script type="text/javascript" src="../js/calendar.js"></script>
        <jsp:useBean id="bean" class="com.rays.proj4.bean.TimetableBean"
            scope="request"></jsp:useBean>

        

        <center>
        <%if(bean.getId()>0){%>
        	
       
            <h1>Update Timetable</h1>
		<%  }else{ %>
		
		<h1>Add Timetable</h1>
		
		<%} %>
		
		
		<%
            List l1 = (List) request.getAttribute("courseList");
			List l2 = (List) request.getAttribute("subjectList");
                
        %>
       
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
                    <th align="left">Course Name <font color="red">* </font></th>
                   <td> <%=HTMLUtility.getList("courseId",String.valueOf(bean.getCourseId()), l1)%>
                    <font color="red"> <%=ServletUtility.getErrorMessage("courseId", request)%></font>
                   </td>
                	</tr>
                <tr>
                    <th align="left">Semester <font color="red">* </font></th>
                    <td><%  HashMap map = new HashMap();
                            map.put("I", "I");
                            map.put("II", "II");
                            map.put("III", "III");
                            map.put("IV", "IV");
                            map.put("V", "V");
                            map.put("VI", "VI");
                            map.put("VII", "VII");
                            map.put("VIII", "VIII");
                            map.put("IX", "IX");
                            map.put("X", "X");
                      				
                            String htmlList = HTMLUtility.getList("sem", bean.getSem(), map);
                        %> <%=htmlList%>
                        <font color="red"> <%=ServletUtility.getErrorMessage("sem", request)%></font></td>
                        
                    </tr>
                    
                 <tr>
                    <th align="left">Subject Name <font color="red">* </font></th>
                   <td> <%=HTMLUtility.getList("subjectId",String.valueOf(bean.getSubjectId()), l2)%>
                    <font color="red"> <%=ServletUtility.getErrorMessage("subjectId", request)%></font>
                   </td>
                	</tr>
                
                    <tr>
                    <th align="left">Date of Exam <font color="red">* </font></th>
                    
                    <td><input type="text" name="examDate" readonly="readonly" placeholder="yyyy/mm/dd"
								value="<%=DataUtility.getDateString(bean.getExamDate())%>"
								id="datepicker1">
                    </a><font
                        color="red"> <%=ServletUtility.getErrorMessage("examDate", request)%></font></td>
                </tr>
                
                <tr>
                    <th align="left">Time of Exam <font color="red">* </font></th>
                    <td><%  HashMap map1 = new HashMap();
                            map1.put("08:00 AM - 11:00 AM", "08:00 AM - 11:00 AM");
                            map1.put("11:00 AM - 02:00 PM", "11:00 AM - 02:00 PM");
                            map1.put("02:00 PM - 05:00 PM", "02:00 PM - 05:00 PM");
                                                				
                            String htmlList1 = HTMLUtility.getList("examTime", bean.getExamTime(), map1);
                        %> <%=htmlList1%>
                        <font color="red"> <%=ServletUtility.getErrorMessage("examTime", request)%></font></td>
                        
                    </tr>
       </table>
              <table id="btn"> 
                         
                <tr>
                    <th></th>
                    
                    <%if(bean.getId()>0){%>    
          			<td colspan="2"><input type="submit" name="operation"
                        value="<%=TimetableCtl.OP_UPDATE%>">&emsp;
					<%  }else{ %>
					<td colspan="2"><input type="submit" name="operation"
                        value="<%=TimetableCtl.OP_SAVE%>">&emsp;
					<%} %>
                      <input type="submit" name="operation" value="<%=TimetableCtl.OP_CANCEL%>">&emsp;
                        <input type="submit" name="operation" value="<%=TimetableCtl.OP_RESET%>">
                        </td>
                </tr>
            </table>
    </form>
    </center>
    </div>
    <br><br><br><br><br><br><bR><bR><bR><bR><bR>
    <%@ include file="Footer.jsp"%>



</body>
</html>