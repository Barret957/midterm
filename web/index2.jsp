<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: Barret
  Date: 2018/11/12
  Time: 23:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />
    <title>网上书店</title>
</head>
<body onload="initAJAX()">
<div class="header">
    <div class="container">
        <div class="row">
            <div class="login span4">
                <h1><a href="">欢迎来到<strong>我的</strong>书店</a><span class="red">.</span><b style="font-size: 22px;"><a href="myOrders.jsp" >查看我的订单</a></b></h1>
            </div>

            <div class="links span8">
                <a  class="logout" href="index.jsp" rel="tooltip" data-placement="bottom" ></a>
                <a class="car" href="car.jsp" rel="tooltip" data_placement="bottom" data-toggle="modal" data-target="#myModal"></a>
            </div>
        </div>
    </div>
</div> <%-- header--%>

<div class="modal fade" id="myModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header"></div>
            <div class="modal-body"></div>

            <div class="modal-footer"></div>
        </div>
    </div>
</div>


<div class="row"> <%--下方左右div控制--%>
    <div class="col-md-3"> <%-- 左侧菜单div控制--%>
        <ul class="nav nav-list">
            <li class="nav-header">书籍类型</li>
            <%
                Class.forName("org.sqlite.JDBC");
                String url = "jdbc:sqlite::resource:bookstore.db";
                String sql = "select id,name,description from category";
                Connection conn = DriverManager.getConnection(url);
                Statement stat = conn.createStatement();
                ResultSet rs = stat.executeQuery(sql);
                while (rs.next())
                {
            %>
            <li>
                <a href="javascript:" onclick='showBook("<%=rs.getString("id")%>")'> <%=rs.getString("name")%></a>
            </li>
            <%
                }
                stat.close();
                conn.close();
            %>
        </ul>
    </div>  <%-- 左侧菜单div控制--%>
    <div class="col-md-9" id="book"> <%-- 书籍布局控制--%>

    </div><%-- 书籍布局控制--%>
</div>  <%--下方左右div控制--%>

<script language="JavaScript">
    function showBook(categoryID) {
        xmlHttp.open("GET","getBook.jsp?id="+categoryID,true);

        xmlHttp.onreadystatechange = function () {
            if(xmlHttp.readyState == 4){
                if(xmlHttp.status == 200){
                    var data = xmlHttp.responseText;
                    document.getElementById("book").innerHTML = data;
                }
            }
        }
        xmlHttp.send();
    }
    function add(id,price) {
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
        xmlHttp.open("GET","car.jsp?id="+id,true);
        xmlHttp.onreadystatechange = function () {
            if(xmlHttp.readyState == 4){
                if(xmlHttp.status == 200){
                    alert("添加入购物车成功！");
                }
                else
                    alert("添加失败！");
            }
        }
        xmlHttp.send();

    }
</script>


<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/commons.js"></script>
</body>
</html>
