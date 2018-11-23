<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: Barret
  Date: 2018/11/17
  Time: 17:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    ArrayList books = (ArrayList)session.getAttribute("books");
    String i = request.getParameter("i");
    int number = Integer.parseInt(i);
    books.remove(number);
    books.remove(number);
    books.remove(number);
    books.remove(number);
%>
</body>
</html>
