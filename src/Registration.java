import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;


public class Registration extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            Class.forName("org.sqlite.JDBC");
            String url = "jdbc:sqlite::resource:bookstore.db";
            String username = request.getParameter("username");
            String password = request.getParameter("pwd");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            PrintWriter out = response.getWriter();

            session.setAttribute("username",username);
            if(username!=null&&password!=null &&phone!=null&&email!=null&&address!=null) {
                String sql = "insert into user(username, password, phone, cellphone, email, address) values (?,?,?,?,?,?)";
                Connection conn = DriverManager.getConnection(url);
                PreparedStatement pstat = conn.prepareStatement(sql);
                pstat.setString(1, username);
                pstat.setString(2, password);
                pstat.setString(3, phone);
                pstat.setString(4, phone);
                pstat.setString(5, email);
                pstat.setString(6, address);
                pstat.executeUpdate();
                pstat.close();
                conn.close();
                out.println("success!");
            }
            else {
                Exception ex = new Exception("null!");
                throw ex;
            }
        } catch (Exception e){
            PrintWriter out = response.getWriter();
            out.println("fail!");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
