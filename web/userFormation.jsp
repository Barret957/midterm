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
    <title>查看所有用户信息</title>
</head>
<body>
<table border="1">
    <tr>
        <td>ID</td>
        <td>用户名</td>
        <td>密  码</td>
        <td>电  话</td>
        <td>Email</td>
        <td>地  址</td>
    </tr>
<%
    Class.forName("org.sqlite.JDBC");
    String url = "jdbc:sqlite::resource:bookstore.db";
    Connection conn = DriverManager.getConnection(url);
    Statement statement = conn.createStatement();
    String  sql = "select * from user";
    ResultSet resultSet = statement.executeQuery(sql);
    while (resultSet.next()){
%>
    <tr>
        <td><%=resultSet.getInt("id")%></td>
        <td><%=resultSet.getString("username")%></td>
        <td><%=resultSet.getString("password")%></td>
        <td><%=resultSet.getString("phone")%></td>
        <td><%=resultSet.getString("email")%></td>
        <td><%=resultSet.getString("address")%></td>
    </tr>
    <%
        }
        statement.close();
        conn.close();
    %>
</table>
<a href="server.jsp">返回上页</a>
</body>
</html>
