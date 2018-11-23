import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = request.getParameter("username");
        String password = request.getParameter("pwd");
        session.setAttribute("username",username); //得到了用户名在seesion中set了
        try {
            Class.forName("org.sqlite.JDBC");
            String url = "jdbc:sqlite::resource:bookstore.db";
            String sql = "select username,password,id from  user where username = '" +username+"'";
            Connection conn = DriverManager.getConnection(url);
            Statement stat = conn.createStatement();
            ResultSet rs  = stat.executeQuery(sql);

            PrintWriter out = response.getWriter();
            if(rs.next()){
                if(password.equals(rs.getString(2)) ) {
                    session.setAttribute("user_id",rs.getString("id"));
                    stat.close();
                    conn.close();
                    if(username.equals("root")){
                        response.sendRedirect("server.jsp");
                    }
                    response.sendRedirect("index2.jsp");
                }
                else {
                    out.println(
                            "<!DOCTYPE html>\n" +
                                    "<html lang=\"en\">\n" +
                                    "<head>\n" +
                                    "    <meta charset=\"UTF-8\">\n" +
                                    "    <title>登录错误提示</title>\n" +
                                    "</head>\n" +
                                    "<body>\n" +
                                    "<h2>用户名和密码错误！</h2><br/>\n" +
                                    "<br/>\n" +
                                    "<a href=\"/index.jsp\">点击返回重新登录</a>\n" +
                                    "</body>\n" +
                                    "</html>"
                    );
                }

            }
            else{
                out.println(
                        "<!DOCTYPE html>\n" +
                                "<html lang=\"en\">\n" +
                                "<head>\n" +
                                "    <meta charset=\"UTF-8\">\n" +
                                "    <title>登录错误提示</title>\n" +
                                "</head>\n" +
                                "<body>\n" +
                                "<h2>用户名和密码错误！</h2><br/>\n" +
                                "<br/>\n" +
                                "<a href=\"/index.jsp\">点击返回重新登录</a>\n" +
                                "</body>\n" +
                                "</html>"
                );
            }
        }
        catch (Exception e){
            System.out.print("出错");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
