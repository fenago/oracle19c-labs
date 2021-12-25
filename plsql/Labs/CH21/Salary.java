import java.sql.*;
import oracle.jdbc.*;
import java.io.*;
public class Salary
{
  public static void totalSalary(int emp_id) throws SQLException
  {
    String sql = "SELECT SUM(salary) AS salaryTotal FROM employees "+
                 "WHERE employee_id ="+emp_id;
    try
    {
      Connection conn = DriverManager.getConnection("jdbc:default:connection:");
      PreparedStatement pstmt = conn.prepareStatement(sql);
      ResultSet rset = pstmt.executeQuery();
      print(rset);
      rset.close();
      pstmt.close();
    }
    catch (SQLException e)
    {
      System.err.println(e.getMessage());
    }
  }
  static void print (ResultSet rset) throws SQLException
  {
    try
    {
      rset.next();
      System.out.println(rset.getString(1));
    }
    catch (SQLException e)
    {
      System.err.println(e.getMessage());
    }
  }
}


    
