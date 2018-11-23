<%--
  Created by IntelliJ IDEA.
  User: Barret
  Date: 2018/11/20
  Time: 11:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>书籍录入</title>
</head>
<body>
<form action="/AddBook" method="post">
    <label for="bookName">书  名：
        <input name="bookName" id="bookName" type="text" placeholder="输入录入书籍的书名">
    </label>
    <label for="author">作  者：
        <input type="text" name="author" id="author" placeholder="输入作者名">
    </label>
    <label for="price">价  格：
        <input type="number" name="price" id="price" min="0"  step="0.01" placeholder="输入书籍价格">
    </label>
    <label for="image">图  片：
        <input type="url" name="image" id="image" placeholder="输入图片的url地址">
    </label><br>
    <label for="description">简  介：<br>
        <textarea name="description" id="description" cols="20" rows="5"></textarea>
    </label><br>
    类  别：
    <select name="category_id" id="category">
        <option value="1">文学</option>
        <option value="2">体育</option>
    </select>
    <br>
    <input type="submit" value="提交">
</form>
<br>
<a href="server.jsp">返回上页</a>
</body>
</html>
