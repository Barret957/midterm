<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: Barret
  Date: 2018/11/12
  Time: 23:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
<%
    String username = (String) session.getAttribute("username");
    ArrayList books = (ArrayList)session.getAttribute("books") ;
    if(books==null){
        books = new ArrayList();
        session.setAttribute("books",books);
    }
    Class.forName("org.sqlite.JDBC");
    String url = "jdbc:sqlite::resource:bookstore.db";
    String sql = "select id,name,author,price,image,description,category_id from book where id = ?";
    String categoryID = request.getParameter("id");
    Connection conn = DriverManager.getConnection(url);
    PreparedStatement pstat = conn.prepareStatement(sql);
    pstat.setString(1,categoryID);
    ResultSet rs = pstat.executeQuery();
    while (rs.next()){
        books.add(rs.getString("id"));   //书籍id
        books.add(rs.getString("name")); //书籍名称
        books.add(rs.getString("author"));            //书籍作者
        books.add(rs.getString("price"));//书籍价格
    }
    pstat.close();
    conn.close();
%>
<div class="modal-title">
    <h1 class="text-center">我的购物车</h1>
</div>
<div class="modal-body">
    <form class="form-group" action="orders.jsp" method="post">
        <%
            for (int i =0; i <books.size();i+=4){
                out.println(
                        "   <b> 书&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</b>"+books.get(i+1)+" <br>\n" +
                                "    <b>作&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;者：</b>"+books.get(i+2)+" <br>\n" +
                                "    <b>单本价格:</b> <input type=\"text\" name=\"price\" readonly value=\" "+ books.get(i+3)+ "\"> <br>\n" +
                                "    <b>数 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;量:</b>  <input type=\"number\" name=\"orderNumber\" min=\"1\"  value=\"1\"><br>"+
                                "<div class=\"text-right\">\n" +
                                "        <button type=\"button\" class=\"btn-group\" onclick=\"deletebook("+ i +")\">删除</button>\n" +
                                "    </div>" +
                                "    <input type=\"hidden\" name=\"book_id\" value=\" "+books.get(i) +" \"> <br>"
                );
            }
        %>
        <div class="text-right">
            <button class="btn-primary" type="submit">结算</button>
            <button class="btn-danger"  data-dismiss="modal">取消</button>
        </div>
    </form>
</div>
<script language="JavaScript">
    function deletebook(i) {
        var xmlHttp;
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
        xmlHttp.open("GET","deleteBook.jsp?i="+ i ,true);
        xmlHttp.onreadystatechange = function () {
            if(xmlHttp.readyState == 4){
                if(xmlHttp.status == 200){
                    alert("删除成功!");
                }
                else
                    alert("删除失败！出现了点错误。");
            }
        }
        xmlHttp.send();
    }
</script>



<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>
</html>
