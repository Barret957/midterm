<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: Barret
  Date: 2018/11/20
  Time: 9:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的订单</title>
</head>
<body>
<%
    String userID = (String) session.getAttribute("user_id");

    Class.forName("org.sqlite.JDBC");
    String url = "jdbc:sqlite::resource:bookstore.db";
    Connection conn = DriverManager.getConnection(url);
    String sql_order = "select * from orders where user_id = '"+ userID+"'";
    Statement stat = conn.createStatement();
    ResultSet rs =  stat.executeQuery(sql_order);
    int count = 0;
    while (rs.next()){
        count++;
        out.println("<br><b>订单编号</b>"+count+"<br>"+
                "<b>订单时间</b>"+rs.getString(2)+"<br>"+
                "<b>订单金额</b>"+rs.getString(3)+"<br>" +
                "订单详情: ");

        String sql_item = "select book_id,quantity,price from orderitem where order_id =?";
        PreparedStatement pstat = conn.prepareStatement(sql_item);
        pstat.setString(1,rs.getString(1));
        ResultSet rs_item = pstat.executeQuery();
        while(rs_item.next()){
            String sql_book = "select name from book where id = "+ rs_item.getString("book_id");
            Statement st = conn.createStatement();
            ResultSet rs_book = st.executeQuery(sql_book);
            out.println("<br><b>书名:</b>"+rs_book.getString("name") +
                    "&nbsp;&nbsp;<b>数量：</b>" +rs_item.getInt("quantity")+
                    "&nbsp;&nbsp;<b>价格：</b>" +rs_item.getString("price"));
            st.close();
        }
        pstat.close();

    }
    stat.close();
    conn.close();
%>
<br>
<a href="index2.jsp">返回书店</a>
</body>
</html>
