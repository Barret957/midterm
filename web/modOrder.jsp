<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: Barret
  Date: 2018/11/20
  Time: 11:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>订单查看及修改</title>
</head>
<body>
<h1>订单信息</h1>
<hr>
<table border="1">
    <tr>
        <th>订单编号</th>
        <th>订单时间</th>
        <th>订单金额</th>
        <th>用 户 ID</th>
        <th>订单状态</th>
        <th>修改状态</th>
    </tr>
<%
    Class.forName("org.sqlite.JDBC");
    String url = "jdbc:sqlite::resource:bookstore.db";
    Connection conn = DriverManager.getConnection(url);
    String sql = "select * from orders";
    Statement statement = conn.createStatement();
    ResultSet resultSet =  statement.executeQuery(sql);
    while (resultSet.next()){
        String state;
        if(resultSet.getBoolean("state")){
            state = "已完成";
        }else {
            state = "未处理";
        }
%>
    <tr>
        <td><%=resultSet.getString("id")%></td>
        <td><%=resultSet.getString("ordertime")%></td>
        <td><%=resultSet.getString("price")%></td>
        <td><%=resultSet.getString("user_id")%></td>
        <td><%=state%></td>
        <td><button onclick="changeState(<%=resultSet.getInt("id")%>)">修改状态</button></td>
    </tr>
    <%
        }
        statement.close();
        conn.close();
    %>
</table>

<a href="server.jsp">返回上页</a>

<script language="JavaScript">
    function changeState(id) {
        var xmlHttp = false;
        if(window.XMLHttpRequest) {
            xmlHttp = new XMLHttpRequest();
        }
        else if(window.ActiveXObject){
            try{
                xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
            }catch (e){
                try{
                    xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                }catch (e){
                    window.alert("不支持ajax")
                }
            }
        }
        xmlHttp.open("GET","ChangeState?id="+id,true);
        xmlHttp.onreadystatechange = function () {
            if(xmlHttp.readyState == 4){
                if(xmlHttp.status == 200){
                    alert("修改成功");
                }
                else
                    alert("修改失败!");
            }
        }
        xmlHttp.send();

    }
</script>
</body>
</html>
