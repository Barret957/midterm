<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: Barret
  Date: 2018/11/11
  Time: 14:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    Class.forName("org.sqlite.JDBC");
    String url = "jdbc:sqlite::resource:bookstore.db";
    String username = request.getParameter("username");
    String sql = "select id,username from user where username ="+ username;
    Connection conn = DriverManager.getConnection(url);
    Statement stat = conn.createStatement();
    ResultSet rs = stat.executeQuery(sql);
    if(rs.next()){
        out.print("<p style='color: red'>用户名已存在</p> ");
    }
    else{
        out.print("<p style='color:#23FF00'>用户名可以使用</p> ");
    }
%>
</body>
</html>
