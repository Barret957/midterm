import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AddBook extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("bookName");
        String author = request.getParameter("author");
        String priceStr = request.getParameter("price");
        String image = request.getParameter("image");
        String description = request.getParameter("description");
        String category_id = request.getParameter("category_id");
        double price = Double.parseDouble(priceStr);
        PrintWriter out = response.getWriter();
        if (name != null&&author != null&&priceStr != null&&image !=null&&description != null&&category_id !=null) {
            try {
                Class.forName("org.sqlite.JDBC");
                String url = "jdbc:sqlite::resource:bookstore.db";
                Connection conn = DriverManager.getConnection(url);
                String sql = "insert into book(name,author,price,image,description,category_id) values(?,?,?,?,?,?)";
                PreparedStatement pstat = conn.prepareStatement(sql);
                pstat.setString(1, name);
                pstat.setString(2, author);
                pstat.setDouble(3, price);
                pstat.setString(4, image);
                pstat.setString(5, description);
                pstat.setString(6, category_id);
                pstat.executeUpdate();
                out.println("<!DOCTYPE html>\n" +
                        "<html lang=\"en\">\n" +
                        "<head>\n" +
                        "    <meta charset=\"UTF-8\">\n" +
                        "    <title>提示页面</title>\n" +
                        "</head>\n" +
                        "<body>\n" +
                        "<h2>书籍录入成功！</h2><br/>\n" +
                        "<br/>\n" +
                        "<a href=\"addBook.jsp\">点击返回上页</a>\n" +
                        "</body>\n" +
                        "</html>");
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {

            out.println("<!DOCTYPE html>\n" +
                    "<html lang=\"en\">\n" +
                    "<head>\n" +
                    "    <meta charset=\"UTF-8\">\n" +
                    "    <title>错误提示</title>\n" +
                    "</head>\n" +
                    "<body>\n" +
                    "<h2>录入失败，请填完所有信息！！！</h2><br/>\n" +
                    "<br/>\n" +
                    "<a href=\"addBook.jsp\">返回书籍录入页面</a>\n" +
                    "</body>\n" +
                    "</html>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
