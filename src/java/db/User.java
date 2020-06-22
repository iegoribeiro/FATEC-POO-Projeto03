package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author grupo03
 */
public class User {
    private String login;
    private String name;
    private String role;
    
    public static ArrayList<User> getList()throws Exception{
        ArrayList<User> list = new ArrayList<>();
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * from users");
        while(rs.next()){
            list.add(
                new User(
                    rs.getString("login"), 
                    rs.getString("name"), 
                    rs.getString("role")
                )
            );
        }
        rs.close();
        stmt.close();
        con.close();
        return list;
    }
    
    public static User getUser(String login, String password)throws Exception{
        User user = null;
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        PreparedStatement stmt = con.prepareStatement
        ("SELECT * from users WHERE login=? AND password_hash=?");
        stmt.setString(1, login);
        stmt.setLong(2, password.hashCode());
        ResultSet rs = stmt.executeQuery();
        if(rs.next()){
            user = new User(
                rs.getString("login"), 
                rs.getString("name"),
                rs.getString("role")
            );
        }
        rs.close();
        stmt.close();
        con.close();
        return user;
    }
    
    public static String getNameUserByLogin(String login)throws Exception{
        User user = null;
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        PreparedStatement stmt = con.prepareStatement
        ("SELECT name from users WHERE login=?");
        stmt.setString(1, login);
        ResultSet rs = stmt.executeQuery();
        String username = null;
        if(rs.next()){
            username = rs.getString("name");
        }
        rs.close();
        stmt.close();
        con.close();
        return username;
    }
    
    
    
    public static void addUser(String login, String name, String role, String password) throws Exception{
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        String SQL = "INSERT INTO users(login, name, role, password_hash) VALUES(?,?,?,?)";
        PreparedStatement stmt = con.prepareStatement(SQL);
        stmt.setString(1, login);
        stmt.setString(2, name);
        stmt.setString(3, role);
        stmt.setLong(4, password.hashCode());
        stmt.execute();
        stmt.close();
        con.close();
    }
    
    public static void removeUser(String login) throws Exception{
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        String SQL = "DELETE FROM users WHERE login=?";
        PreparedStatement stmt = con.prepareStatement(SQL);
        stmt.setString(1, login);
        stmt.execute();
        stmt.close();
        con.close();
    }
    
    public static void changePassword(String login, String newPassword) throws Exception{
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        String SQL = "UPDATE users SET password_hash=? WHERE login=?";
        PreparedStatement stmt = con.prepareStatement(SQL);
        stmt.setLong(1, newPassword.hashCode());
        stmt.setString(2, login);
        stmt.execute();
        stmt.close();
        con.close();
    }

    public User(String login, String name, String role) {
        this.login = login;
        this.name = name;
        this.role = role;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
    
}