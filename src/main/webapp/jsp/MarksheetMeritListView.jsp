    
    <%@page import="com.rays.proj4.ctl.MarksheetMeritListCtl"%>
<%@page import="com.rays.proj4.util.ServletUtility"%>
<%@page import="com.rays.proj4.bean.MarksheetBean"%>
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
    padding-top: 6px;
    padding-bottom: 6px;
    text-align: left;
    background-color: black;
    color: white;
}

</style>

<body>

<%@include file="Header.jsp"%>
    <center>
        <h1>Marksheet Merit List</h1>

        <form action="<%=ORSView.MARKSHEET_MERIT_LIST_CTL%>" method="POST">
            <br>
            <table id="customers">
                <tr>

                    <th>S.No.</th>
                    <th>Roll No</th>
                    <th>Name</th>
                    <th>Physics</th>
                    <th>Chemistry</th>
                    <th>Maths</th>
                    <th>Total</th>
                    <th>Percentage</th>

                </tr>
                <tr>
                    <td colspan="8"><font color="red"><%=ServletUtility.getErrorMessage(request)%></font></td>
                </tr>
                <%
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int index = ((pageNo - 1) * pageSize) + 1;

                    List list = ServletUtility.getList(request);
                    Iterator<MarksheetBean> it = list.iterator();

                    while (it.hasNext()) {

                        MarksheetBean bean = it.next();
                %>
                <tr>

                    <td><%=index++%></td>
                    <td><%=bean.getRollNo()%></td>
                    <td><%=bean.getName()%></td>
                    <td><%=bean.getPhysics()%></td>
                    <td><%=bean.getChemistry()%></td>
                    <td><%=bean.getMaths()%></td>
                    <td><%=(bean.getPhysics()+bean.getChemistry()+bean.getMaths()) %>/300</td>
                    <td><%=(bean.getPhysics()+bean.getChemistry()+bean.getMaths())/3 %>%</td>

                </tr>

                <%
                    }
                %>
            </table>
            <table>
                <tr>
                    <td align="right"><input type="submit" name="operation"
                        value="<%=MarksheetMeritListCtl.OP_BACK%>"></td>
                </tr>
            </table>
            <input type="hidden" name="pageNo" value="<%=pageNo%>"> <input
                type="hidden" name="pageSize" value="<%=pageSize%>">
        </form>
    </center>
    <%@include file="Footer.jsp"%>
</body>
</html>