    
    <%@page import="com.rays.proj4.ctl.RoleListCtl"%>
<%@page import="com.rays.proj4.ctl.BaseCtl"%>
<%@page import="com.rays.proj4.bean.RoleBean"%>
<%@page import="com.rays.proj4.model.UserModel"%>

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

    <center>
        <h1>Role List</h1>

        <form action="<%=ORSView.ROLE_LIST_CTL%>" method="post">
            <table width="100%">
                <tr>
                    <td align="center"><label>Role Name </label> <input type="text"
                        name="name" placeholder="Enter Role Name"
                        value="<%=ServletUtility.getParameter("name", request)%>">
                        &nbsp; <input type="submit" name="operation" value="<%=RoleListCtl.OP_SEARCH %>">
                         &emsp; <input type="submit" name="operation" value="<%=RoleListCtl.OP_RESET %>">
                    </td>
                </tr>
            </table>
            
            <h4> <font color="red"><%=ServletUtility.getErrorMessage(request)%></font></h4>
			<H4><font color="green"> <%=ServletUtility.getSuccessMessage(request)%></font></H4>
            
            
            <table id="customers">
                <tr>
                    <th><input type="checkbox" onclick="checkAll(this)">Select</th>
                    <th>S.No.</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Edit</th>
                </tr>
                
                <%
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int index = ((pageNo - 1) * pageSize) + 1;

                    List list = ServletUtility.getList(request);
                    Iterator<RoleBean> it = list.iterator();
                    while (it.hasNext()) {
                        RoleBean bean = it.next();
                %>
                <tr>
                	<%if(bean.getId()==1){%>
                    	<td><input type="checkbox" disabled name="ids" value="<%=bean.getId()%>"></td>
                   <% }else{%>
                    <td><input type="checkbox" name="ids" value="<%=bean.getId()%>"></td>
                    <%} %>
                    <td><%=index++%></td>
                    <td><%=bean.getName()%></td>
                    <td><%=bean.getDescription()%></td>
                    <%if(bean.getId()==1){%>
                    <td>-NA-</td>
                   <% }else{%>
                    <td><a href="RoleCtl?id=<%=bean.getId()%>" style="color:blue">Edit</a></td>
                    <%} %>
                    
                </tr>
                <%
                    }
                %>
            </table>
            <table width="100%">
            
            <tr>
                <%if(pageNo>1){ %>
                
                    <td ><input type="submit" name="operation"
                        value="<%=RoleListCtl.OP_PREVIOUS%>"></td>
                        <%}else{ %>
                        <td ><input type="submit" disabled name="operation"
                        value="<%=RoleListCtl.OP_PREVIOUS%>"></td>
                        <%} %>
            
                
                     <td ><input type="submit"
                        name="operation" value="<%=RoleListCtl.OP_DELETE%>"></td>
                     <td ><input type="submit"
                        name="operation" value="<%=RoleListCtl.OP_ADD%>"></td>
                        
                        
                     <%
                    boolean flag=true;
                    int xx=list.size();
                    	if(xx<10){
                   		flag=false;
                     }                    
                     %>
                     
                     <%UserModel um=new UserModel();
                     int last_entry=um.nextPK();
                     last_entry=last_entry-1;
                     %> 

					 <%boolean flag1=true;
                     long check_entry=0;
                     
                     Iterator<RoleBean> it2 = list.iterator();
                     while (it2.hasNext()) {
                         RoleBean bean = it2.next();
                         check_entry=bean.getId();
                     }
                     %>

					               
                     
                     <% if(check_entry!=last_entry && flag){%>
                     <td align="right"><input type="submit" name="operation"
                        value="<%=RoleListCtl.OP_NEXT%>"></td>
                        
                        <%}else{ %>
                         <td align="right"><input type="submit" disabled name="operation"
                        value="<%=RoleListCtl.OP_NEXT%>"></td>
                        <%} %>
            
                </tr>
            </table>
            <input type="hidden" name="pageNo" value="<%=pageNo%>"> <input
                type="hidden" name="pageSize" value="<%=pageSize%>">
                
                Page No. <%=pageNo%>	&emsp;	Total Entries. <%=xx %> 
        </form>
    </center>
    <br><br><br><br><br><br>		
   <div><%@include file="Footer.jsp"%></div> 
</body>
</html>