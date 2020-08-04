
    
    <%@page import="com.rays.proj4.ctl.MarksheetListCtl"%>
     <%@page import="com.rays.proj4.model.MarksheetModel"%>
<%@page import="com.rays.proj4.ctl.BaseCtl"%>
<%@page import="com.rays.proj4.util.ServletUtility"%>
<%@page import="com.rays.proj4.bean.MarksheetBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>

<html>

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
 


<%MarksheetBean bean=new MarksheetBean(); %>

   <div>
    <center>
        <h1>Marksheet List</h1>

        <form action="<%=ORSView.MARKSHEET_LIST_CTL%>" method="POST">

            <table width="100%">
                <tr>
                    <td align="center"><label> Name :</label> <input type="text"
                        name="name" placeholder="Enter Studnet Name"
                        value="<%=ServletUtility.getParameter("name", request)%>">
                        &emsp; <label>RollNo :</label> <input type="text" name="rollNo" placeholder="Enter Roll NO."
                        value="<%=ServletUtility.getParameter("rollNo", request)%>">&emsp;
                        <input type="submit" name="operation" value="<%=MarksheetListCtl.OP_SEARCH %>">
                        &emsp;
                        <input type="submit" name="operation" value="<%=MarksheetListCtl.OP_RESET %>"></td>
                </tr>
            </table>
            
            <h4> <font color="red"><%=ServletUtility.getErrorMessage(request)%></font></h4>
				<H4><font color="green"> <%=ServletUtility.getSuccessMessage(request)%></font></H4>
            
 
          
            <table id="customers">
                <tr>
                    <th><input type="checkbox" onclick="checkAll(this)">Select</th>
                    <th>RollNo</th>
                    <th>Name</th>
                    <th>Physics</th>
                    <th>Chemistry</th>
                    <th>Maths</th>
                    <th>Total</th>
                    <th>Percentage</th>
                    <th>Edit</th>
                </tr>
                
                <%
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int index = ((pageNo - 1) * pageSize) + 1;

                    List list = ServletUtility.getList(request);
                    Iterator<MarksheetBean> it = list.iterator();

                    while (it.hasNext()) {

                        bean = it.next();
                %>
                <tr>
                    <td><input type="checkbox" name="ids" value="<%=bean.getId()%>"></td>
                    <td><%=bean.getRollNo()%></td>
                    <td><%=bean.getName()%></td>
                    <%if(bean.getPhysics()<40){ %>
                    <td><font color="red"> <%=bean.getPhysics()%></font></td>
                    <%}else{ %>
                    <td><%=bean.getPhysics()%></td><%}
                    if(bean.getChemistry()<40){ %>
                    <td><font color="red"> <%=bean.getChemistry()%></font></td>
                    <%}else{ %>
                    <td><%=bean.getChemistry()%></td><%}
                    if(bean.getMaths()<40){ %>
                     <td><font color="red"> <%=bean.getMaths()%></font></td>
                    <%}else{ %>
                    <td><%=bean.getMaths()%></td><%} %>
                    <td><%=(bean.getMaths()+bean.getChemistry()+ bean.getPhysics())%>/300</td>
                    <td><%=(bean.getMaths()+bean.getChemistry()+ bean.getPhysics())/3%>%</td>
                    <td><a href="MarksheetCtl?id=<%=bean.getId()%>" style="color:blue">Edit</a></td>
                </tr>

                <%
                    }
                %>
            </table>
            <table width="100%">
                <tr>
                    <%if(pageNo>1){ %>
                
                    <td ><input type="submit" name="operation"
                        value="<%=MarksheetListCtl.OP_PREVIOUS%>"></td>
                        <%}else{ %>
                        <td ><input type="submit" disabled name="operation"
                        value="<%=MarksheetListCtl.OP_PREVIOUS%>"></td>
                        <%} %>
                    
                     <% if (list.size() != 0){%>  
                    <td><input type="submit"
                        name="operation" value="<%=MarksheetListCtl.OP_DELETE%>"></td>
                        <td><input type="submit" name="operation"
                        value="<%=MarksheetListCtl.OP_ADD%>"></td><%}else{ %>
                         <td ><input type="submit"
                        name="operation" value="<%=MarksheetListCtl.OP_BACK%>"></td><%} %>
                        
                   
                      <%
						
                    MarksheetModel mModel=new MarksheetModel();
                    if (((mModel.nextPK() - 1) == (int) bean.getId()) || list.size() < pageSize)

                    {
					%>
					<td align="right"><input type="submit" name="operation"
						class="btn_other1" disabled
						value="<%=MarksheetListCtl.OP_NEXT%>"></td>
					<%
						} else {
					%>

					<td align="right"><input type="submit" name="operation"
						class="btn_other" value="<%=MarksheetListCtl.OP_NEXT%>"></td>
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
    
     <div><%@ include file="Footer.jsp"%></div>
</body>
</html>