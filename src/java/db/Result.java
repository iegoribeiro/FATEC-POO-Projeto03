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
public class Result {
    private long rowId;
    private long result;
    private String userLogin;
    private long categoryEnumId;
    private String username;

    public Result() {
    }
    
    public Result(long result, String userLogin, long categoryEnumId) {
        this.result = result;
        this.userLogin = userLogin;
        this.categoryEnumId = categoryEnumId;
    }

    public Result(long rowId, long result, String userLogin, long categoryEnumId) {
        this.rowId = rowId;
        this.result = result;
        this.userLogin = userLogin;
        this.categoryEnumId = categoryEnumId;
    }
    
    public Result(String username, long result) {
        this.username = username;
        this.result = result;
    }

    public static ArrayList<Result> getList() throws Exception{
        ArrayList<Result> list = new ArrayList<>();
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT rowid, * from results");
        while(rs.next()){
            list.add(new Result(
                rs.getLong("rowid"),
                rs.getLong("result"),
                rs.getString("fk_user_login"),
                rs.getLong("fk_category_enum")
            ));
        }
        rs.close();
        stmt.close();
        con.close();
        return list;
    }
    
    public static Result getResult(long id)throws Exception{
        Result transaction = null;
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        String SQL = "SELECT rowid, * from results WHERE id=?";
        PreparedStatement stmt = con.prepareStatement(SQL);
        stmt.setLong(1, id);
        ResultSet rs = stmt.executeQuery();
        if(rs.next()){
            transaction = new Result(
                rs.getLong("rowid"),
                rs.getLong("result"),
                rs.getString("fk_user_login"),
                rs.getLong("fk_category_enum")
            );
        }
        rs.close();
        stmt.close();
        con.close();
        return transaction;
    }
    
    public static void addResult(long result, String user, long category) throws Exception{
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        String SQL;
        if (category != 0) {
            SQL = "INSERT INTO results(result, fk_user_login, fk_category_enum) VALUES(?,?,?)";
        } else {
            SQL = "INSERT INTO results(result, fk_user_login) VALUES(?,?)";
        }
        PreparedStatement stmt = con.prepareStatement(SQL);
        stmt.setLong(1, result);
        stmt.setString(2, user);
        if (category != 0) {
            stmt.setLong(3, category);
        }
        stmt.execute();
        stmt.close();
        con.close();
    }
    
    public static void putResult(long result, User user, CategoryEnum category, long rowId) throws Exception{
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        String SQL;
        if (category != null) {
            SQL = "UPDATE results SET result=?, fk_user_login=?, fk_category_enum=?  WHERE id=?";
        } else {
            SQL = "UPDATE results SET result=?, fk_user_login=? WHERE id=?";
        }
        PreparedStatement stmt = con.prepareStatement(SQL);
        stmt.setLong(1, result);
        stmt.setString(2, user.getLogin());
        if (category != null) {
            stmt.setLong(3, category.getId());
            stmt.setLong(4, rowId);
        } else {
            stmt.setLong(3, rowId);
        }
        stmt.execute();
        stmt.close();
        con.close();
    }
    
    public static void removeResult(long id) throws Exception{
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        String SQL = "DELETE FROM results WHERE id=?";
        PreparedStatement stmt = con.prepareStatement(SQL);
        stmt.setLong(1, id);
        stmt.execute();
        stmt.close();
        con.close();
    }
    
    public static ArrayList<Result> getTenLastQuizzes() throws Exception{
        ArrayList<Result> list = new ArrayList<>();
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT u.name as username, r.result as result "
                                        + "FROM results r "
                                        + "INNER JOIN users u ON (r.fk_user_login = u.login)"
                                        + "ORDER BY r.rowId DESC LIMIT 10");
        while(rs.next()){
            list.add(new Result(
              rs.getString("username"), 
              rs.getLong("result")
            ));
        }
        rs.close();
        stmt.close();
        con.close();
        return list;
    }
    
    public static ArrayList<Result> getRanking() throws Exception{
        ArrayList<Result> list = new ArrayList<>();
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT u.name as username, r.result as result "
                                        + "FROM results r "
                                        + "INNER JOIN users u ON (r.fk_user_login = u.login)"
                                        + "ORDER BY r.result DESC LIMIT 10");
        while(rs.next()){
            list.add(new Result(
              rs.getString("username"), 
              rs.getLong("result")
            ));
        }
        rs.close();
        stmt.close();
        con.close();
        return list;
    }
    
    public static float getMediaByUser(String login) throws Exception{
        float media = 0;
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        PreparedStatement stmt;
        stmt = con.prepareStatement("SELECT avg(r.result) as average FROM results r INNER JOIN users u ON (r.fk_user_login = u.login) WHERE u.login = ?");
        stmt.setString(1, login);
        ResultSet rs = stmt.executeQuery();
        if(rs.next()){
            media = rs.getFloat("average");
        }
        rs.close();
        stmt.close();
        con.close();
        return media;
    }
    
    public static float getMediaByUserAndCategory(String login, long category) throws Exception{
        float media = 0;
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        PreparedStatement stmt;
        stmt = con.prepareStatement("SELECT avg(r.result) as average FROM results r INNER JOIN users u ON (r.fk_user_login = u.login) WHERE u.login = ? AND r.fk_category_enum = ?");
        stmt.setString(1, login);
        stmt.setLong(2, category);
        ResultSet rs = stmt.executeQuery();
        if(rs.next()){
            media = rs.getFloat("average");
        }
        rs.close();
        stmt.close();
        con.close();
        return media;
    }
    
    public static ArrayList<Result> getTenLastQuizzesByUser(String login) throws Exception{
        ArrayList<Result> list = new ArrayList<>();
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        PreparedStatement stmt;
        stmt = con.prepareStatement("SELECT u.name as username, r.result as result FROM results r INNER JOIN users u ON (r.fk_user_login = u.login) WHERE u.login = ? ORDER BY r.rowId DESC LIMIT 10");
        stmt.setString(1, login);
        ResultSet rs = stmt.executeQuery();
        while(rs.next()){
            list.add(new Result(
              rs.getString("username"), 
              rs.getLong("result")
            ));
        }
        rs.close();
        stmt.close();
        con.close();
        return list;
    }
    
    public long getRowId() {
        return rowId;
    }

    public void setRowId(long rowId) {
        this.rowId = rowId;
    }

    public long getResult() {
        return result;
    }

    public void setResult(long result) {
        this.result = result;
    }

    public String getUserLogin() {
        return userLogin;
    }

    public void setUserLogin(String userLogin) {
        this.userLogin = userLogin;
    }

    public long getCategoryEnumId() {
        return categoryEnumId;
    }

    public void setCategoryEnumId(long categoryEnumId) {
        this.categoryEnumId = categoryEnumId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
