package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author iego_
 */
public class CategoryEnum {
    private long id;
    private String name;
    
    public CategoryEnum(long id, String name) {
        this.id = id;
        this.name = name;
    }
    
    public static ArrayList<CategoryEnum> getList()throws Exception{
        ArrayList<CategoryEnum> list = new ArrayList<>();
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * from category_enum");
        while(rs.next()){
            list.add(new CategoryEnum(
                rs.getLong("id"), 
                rs.getString("name")
            ));
        }
        rs.close();
        stmt.close();
        con.close();
        return list;
    }
    
    public static CategoryEnum getCategoryEnum(long id)throws Exception{
        CategoryEnum transaction = null;
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        String SQL = "SELECT * from category_enum WHERE id=?";
        PreparedStatement stmt = con.prepareStatement(SQL);
        stmt.setLong(1, id);
        ResultSet rs = stmt.executeQuery();
        if(rs.next()){
            transaction = new CategoryEnum(
                rs.getLong("id"), 
                rs.getString("name")
            );
        }
        rs.close();
        stmt.close();
        con.close();
        return transaction;
    }
    
    public static void addCategoryEnum(String name) throws Exception{
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        String SQL = "INSERT INTO category_enum(name) VALUES(?)";
        PreparedStatement stmt = con.prepareStatement(SQL);
        stmt.setString(1, name);
        stmt.execute();
        stmt.close();
        con.close();
    }
    
    public static void putCategoryEnum(String name, long id) throws Exception{
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        String SQL = "UPDATE category_enum SET name=? WHERE id=?";
        PreparedStatement stmt = con.prepareStatement(SQL);
        stmt.setString(1, name);
        stmt.setLong(2, id);
        stmt.execute();
        stmt.close();
        con.close();
    }
    
    public static void removeCategoryEnum(long id) throws Exception{
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        String SQL = "DELETE FROM category_enum WHERE id=?";
        PreparedStatement stmt = con.prepareStatement(SQL);
        stmt.setLong(1, id);
        stmt.execute();
        stmt.close();
        con.close();
    }
    
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
