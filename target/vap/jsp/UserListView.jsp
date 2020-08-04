  
<%@page import="com.rays.proj4.ctl.UserListCtl"%>
<%@page import="com.rays.proj4.util.ServletUtility"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.rays.proj4.bean.RoleBean"%>
<%@page import="com.rays.proj4.model.RoleModel"%>
<%@page import="com.rays.proj4.model.UserModel"%>
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
<div><%@include file="Header.jsp"%></div>


<!-- js for check box--select all -->
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
            List l = (List) request.getAttribute("roleList");
                
        %>
    
    <div>
    <center>
        <h1>User List</h1>

        <form action="<%=ORSView.USER_LIST_CTL%>" method="post">
        <jsp:useBean id="bean" scope="request" class="com.rays.proj4.bean.UserBean"></jsp:useBean>
      <%--   <%UserBean bean=new UserBean(); %> --%>

            <table><!-- <table width="100%"> --> 
                <tr>
                    <td align="center"><label>First Name :</label> <input
                        type="text" name="firstName" placeholder="Enter First Name"
                        value="<%=ServletUtility.getParameter("firstName", request)%>">
                        &emsp; <label>Login ID :</label> <input type="text" name="login" placeholder="Enter Login Id" 
                        value="<%=ServletUtility.getParameter("login", request)%>">
                        
                        &emsp; <label>Role :</label> <%=HTMLUtility.getList("roleId",String.valueOf(bean.getRoleId()), l)%>
                                                       
                        &emsp;<input type="submit" name="operation" value="<%=UserListCtl.OP_SEARCH %>">
                       &emsp; <input type="submit" name="operation" value="<%=UserListCtl.OP_RESET %>">
                       
                       <!-- &emsp; <input type="submit" value="Reset"> --> 
                    </td>
                </tr>
            </table>
            
                   <h4> <font color="red"><%=ServletUtility.getErrorMessage(request)%></font></h4>
				<H4><font color="green"> <%=ServletUtility.getSuccessMessage(request)%></font></H4>


            <table id="customers">
            <!-- <table border="1" width="100%"> -->
                <tr>
                    <th><input type="checkbox" onclick="checkAll(this)">Select</th>
                    <th>S.No.</th>
                    <th>FirstName</th>
                    <th>LastName</th>
                    <th>LoginId</th>
                    <th>Gender</th>
                    <th>Role</th>
                    <th>DOB</th>
                    <th>Edit</th>
                </tr>

               
                <%
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int index = ((pageNo - 1) * pageSize) + 1;

                    List list = ServletUtility.getList(request);
                    Iterator<UserBean> it = list.iterator();
                    while (it.hasNext()) {
                         bean = it.next();
                %>
                
                                
                
                <%
                RoleModel role = new RoleModel();
                long rollId = bean.getRoleId();
                RoleBean rolebean = role.findByPK(rollId);
                rolebean.getName();
                %>
                
                
                <tr>
                    <%if(bean.getRoleId()==1){%>
                    	<td><input type="checkbox" disabled name="ids" value="<%=bean.getId()%>"></td>
                   <% }else{%>
                    <td><input type="checkbox" name="ids" value="<%=bean.getId()%>"></td>
                    <%} %>
                    <td><%=index++ %></td>
                    <td><%=bean.getFirstName()%></td>
                    <td><%=bean.getLastName()%></td>
                    <td><%=bean.getLogin()%></td>
                    <td><%=bean.getGender()%></td>
                    <td><%=rolebean.getName()%></td>
                    <td><%=bean.getDob()%></td>
                    <%if(bean.getRoleId()==1){%>
                    <td>-NA-</td>
                   <% }else{%>
                    <td><a href="UserCtl?id=<%=bean.getId()%>" style="color:blue">Edit</a></td>
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
                        value="<%=UserListCtl.OP_PREVIOUS%>"></td>
                        <%}else{ %>
                        <td ><input type="submit" disabled name="operation"
                        value="<%=UserListCtl.OP_PREVIOUS%>"></td>
                        <%} %>
                        
                   <% if (list.size() != 0){%>      
                     <td ><input type="submit"
                        name="operation" value="<%=UserListCtl.OP_DELETE%>"></td>
                        
                        <td ><input type="submit"
                        name="operation" value="<%=UserListCtl.OP_ADD%>"></td><%}else{ %>
                         <td ><input type="submit"
                        name="operation" value="<%=UserListCtl.OP_BACK%>"></td><%} %>
                        
                    
                    
                    
 <%
						
                    UserModel userModel=new UserModel();
                    if (((userModel.nextPK() - 1) == (int) bean.getId()) || list.size() < pageSize)

                    {
					%>
					<td align="right"><input type="submit" name="operation"
						class="btn_other1" disabled
						value="<%=UserListCtl.OP_NEXT%>"></td>
					<%
						} else {
					%>

					<td align="right"><input type="submit" name="operation"
						class="btn_other" value="<%=UserListCtl.OP_NEXT%>"></td>
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

<div><%@ include file="Footer.jsp"%></div>
 
</body>
</html>