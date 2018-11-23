<%@ page import="java.sql.*" %>
<%@ page import="java.util.logging.SimpleFormatter" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>
<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: Barret
  Date: 2018/11/13
  Time: 17:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>订单信息</title>
</head>
<body>
<%
    String username = (String) session.getAttribute("username");
    String[] price = request.getParameterValues("price");
    String[] quantity = request.getParameterValues("orderNumber");
    String[] book_id = request.getParameterValues("book_id");
    double total_price = 0.0;
    if(book_id.length > 0) {
        for (int i = 0; i < book_id.length; i++) {
            double pi = Double.parseDouble(price[i]);
            int qu = Integer.parseInt(quantity[i]);
            double x = pi * qu;
            total_price += x;
        }

        //得到时间
        Date date = new Date();
        SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String order_time = ft.format(date);

        //查询数据库得到user的信息
        Class.forName("org.sqlite.JDBC");
        String url = "jdbc:sqlite::resource:bookstore.db";
        Connection conn = DriverManager.getConnection(url);

        String  userId = (String) session.getAttribute("user_id");
        //执行更新orders表
        String sql_orders = "insert into orders (ordertime,price,state,user_id) values (?,?,?,?)";
        PreparedStatement  pstat = conn.prepareStatement(sql_orders);
        pstat.setString(1, order_time);
        pstat.setDouble(2, total_price);
        pstat.setBoolean(3, false);
        pstat.setString(4, userId);
        pstat.executeUpdate();

        String sql_orderid = "select  max(id)  from  orders ";
        pstat = conn.prepareStatement(sql_orderid);
        ResultSet rs_orderid = pstat.executeQuery();

        //执行更新oderitem表

        for (int i = 0; i < book_id.length; i++) {
                String sql_orderitem = "insert into  orderitem(quantity,price,order_id,book_id) values (?,?,?,?)";
                pstat = conn.prepareStatement(sql_orderitem);
                pstat.setInt(1, Integer.parseInt(quantity[i]));
                pstat.setDouble(2, Double.parseDouble(price[i]));
                pstat.setString(3, rs_orderid.getString(1));
                pstat.setString(4, book_id[i]);
                pstat.executeUpdate();
        }


        out.println("<b>订单提交成功，等待商家处理!</b>");

        pstat.close();
        conn.close();
        session.removeAttribute("books");
    } else {
        response.sendRedirect("index2.jsp");
    }
%>
<a href="index2.jsp">点击返回书店</a>
</body>
</html>
