import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

public class ChangeState extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        try {
            Class.forName("org.sqlite.JDBC");
            String url = "jdbc:sqlite::resource:bookstore.db";
            Connection conn = DriverManager.getConnection(url);
            Statement statement = conn.createStatement();
            String sql = "select state from orders where id = "+id;
            ResultSet resultSet = statement.executeQuery(sql);
            boolean flag = !(resultSet.getBoolean("state"));
            String sql_2 = "update orders set state =? where id = ?";
            PreparedStatement preparedStatement = conn.prepareStatement(sql_2);
            preparedStatement.setBoolean(1,flag);
            preparedStatement.setInt(2,Integer.parseInt(id));
            preparedStatement.executeUpdate();
            statement.close();
            preparedStatement.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
