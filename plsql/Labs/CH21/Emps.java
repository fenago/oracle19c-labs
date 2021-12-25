import java.sql.*;
import java.io.*;
import oracle.sql.*;
import oracle.jdbc.*;
import oracle.oracore.*;
import oracle.jdbc2.*;
import java.math.*;
public class Emps implements SQLData
{ //----- Attributes -----//
  private BigDecimal employee_id;
  private String first_name;
  private BigDecimal salary;
  private BigDecimal grade;
  private String sql_type;
  //----- Methods -------//  
  public void add() 
  throws SQLException
  {
    String sql = "INSERT INTO EMPS(employee_id, first_name, salary, grade) "+
                 "VALUES (?,?,?,?)";
    try
    {
      Connection conn = DriverManager.getConnection("jdbc:default:connection:");
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setBigDecimal(1, employee_id);
      pstmt.setString(2, first_name);
      pstmt.setBigDecimal(3, salary);
      pstmt.setBigDecimal(4, grade);
      pstmt.executeUpdate();
      pstmt.close();
      
    }
    catch (SQLException e)
    {
      System.err.println(e.getMessage());
    }
  }

  public void modify() 
  throws SQLException
  {
    String sql = "UPDATE EMPS "+
                 "SET first_name= ?, salary=?, grade=? "+
                 "WHERE employee_id=?";
    try
    {
      Connection conn = DriverManager.getConnection("jdbc:default:connection:");
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, first_name);
      pstmt.setBigDecimal(2, salary);
      pstmt.setBigDecimal(3, grade);
      pstmt.setBigDecimal(4, employee_id);
      pstmt.executeUpdate();
      pstmt.close();
      
    }
    catch (SQLException e)
    {
      System.err.println(e.getMessage());
    }
  }

  public void remove()  throws SQLException
  {
    String sql = "DELETE FROM EMPS "+
                 "WHERE employee_id=?";
    try
    {
      Connection conn = DriverManager.getConnection("jdbc:default:connection:");
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setBigDecimal(1, employee_id);
      pstmt.executeUpdate();
      pstmt.close();
      
    }
    catch (SQLException e)
    {
      System.err.println(e.getMessage());
    }
  }
  
  public String getSQLTypeName() throws SQLException
  {
    return sql_type;
  }

  public void readSQL(SQLInput stream, String typeName) throws SQLException
  {
    sql_type = typeName;
    employee_id = stream.readBigDecimal();
    first_name = stream.readString();
    salary = stream.readBigDecimal();
    grade = stream.readBigDecimal();
  }

  public void writeSQL(SQLOutput stream) throws SQLException
  {
    stream.writeBigDecimal(employee_id);
    stream.writeString(first_name);
    stream.writeBigDecimal(salary);
    stream.writeBigDecimal(grade);
  }

}


    
