<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: Barret
  Date: 2018/11/1
  Time: 18:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<%
    String username = (String) session.getAttribute("username");
    Class.forName("org.sqlite.JDBC");
    String url = "jdbc:sqlite::resource:bookstore.db";
    String sql = "select id,name,author,price,image,description,category_id from book where category_id = ?";
    String categoryID = request.getParameter("id");
    Connection conn = DriverManager.getConnection(url);
    PreparedStatement pstat = conn.prepareStatement(sql);
    pstat.setString(1,categoryID);
    ResultSet rs = pstat.executeQuery();
    while (rs.next()){
%>
<div class="col-sm-9 col-md-3">
    <div class="thumbnail">
        <img src="images/book.jpg">
        <div class="caption" style="height: 330px">
            <h4>
                <%=rs.getString("name")%>
            </h4>
            <p style="height: 220px">
                <%=rs.getString("description")%>
            </p>
            <p >
                <a href="javascript:"  onclick='add(<%=rs.getString("id")%>)' class="btn btn-primary" role="button">加入购物车</a>
                <a href="#" class="btn btn-default" role="button">查看详情</a>
            </p>
        </div>
    </div>
</div>
<%
    }
    pstat.close();
    conn.close();
%>

</body>

</html>
