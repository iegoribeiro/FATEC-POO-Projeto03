/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author rlarg
 */
public class Result {
    private long rowId;
    private long result;
    private String fk_user_login;
    private long fk_category_enum;
    
    public static ArrayList<Result> getList()throws Exception{
        ArrayList<Result> list = new ArrayList<>();
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT ROW_NUMBER () OVER (ORDER BY results.result desc) rowid, results.result as result, users.name as fk_user_login, category_enum.name as fk_category_enum from results inner join users on results.fk_user_login = users.login inner join category_enum on results.fk_category_enum = category_enum.id order by results.result desc LIMIT 10 ");
        while(rs.next()){
            list.add(
                    new Result(
                            rs.getLong("rowid"), 
                            rs.getLong("result"), 
                            rs.getString("fk_user_login"),
                            rs.getLong("fk_category_enum")
                    )
            );
        }
        rs.close();
        stmt.close();
        con.close();
        return list;
    }
    public static Result getResult(long rowId)throws Exception{
        Result result = null;
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        String SQL = "SELECT rowid, * from results WHERE rowid=?";
        PreparedStatement stmt = con.prepareStatement(SQL);
        stmt.setLong(1, rowId);
        ResultSet rs = stmt.executeQuery();
        if(rs.next()){
            result = new Result(
                            rs.getLong("rowid"), 
                            rs.getLong("result"), 
                            rs.getString("fk_user_login"),
                            rs.getLong("fk_category_enum")
                    );
        }
        rs.close();
        stmt.close();
        con.close();
        return result;
    }
    public static void addResult(Long result, String fk_user_login, Long fk_category_enum) throws Exception{
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        String SQL = "INSERT INTO results(result, fk_user_login, fk_category_enum) VALUES(?,?,?)";
        PreparedStatement stmt = con.prepareStatement(SQL);
        stmt.setLong(1, result);
        stmt.setString(2, fk_user_login);
        stmt.setLong(3, fk_category_enum);
        stmt.execute();
        stmt.close();
        con.close();
    }
    public static void putResult(long rowId, Long result, String fk_user_login, Long fk_category_enum) throws Exception{
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        String SQL = "UPDATE results "
                + "SET result=?, "
                + "fk_user_login=?, "
                + "fk_category_enum=? "
                + "WHERE rowid=?";
        PreparedStatement stmt = con.prepareStatement(SQL);
        stmt.setLong(1, result);
        stmt.setString(2, fk_user_login);
        stmt.setLong(3, fk_category_enum);
        stmt.setLong(4, rowId);
        stmt.execute();
        stmt.close();
        con.close();
    }
    public static void removeResult(long rowId) throws Exception{
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        String SQL = "DELETE FROM result WHERE rowid=?";
        PreparedStatement stmt = con.prepareStatement(SQL);
        stmt.setLong(1, rowId);
        stmt.execute();
        stmt.close();
        con.close();
    }

    public Result(long rowId, Long result, String fk_user_login, Long fk_category_enum) {
        this.rowId = rowId;
        this.result = result;
        this.fk_user_login = fk_user_login;
        this.fk_category_enum = fk_category_enum;
    }

    public Long getResult() {
        return result;
    }

    public void setResult(Long result) {
        this.result = result;
    }

    public String getFk_user_login() {
        return fk_user_login;
    }

    public void setFk_user_login(String fk_user_login) {
        this.fk_user_login = fk_user_login;
    }

    public Long getFk_category_enum() {
        return fk_category_enum;
    }

    public void setFk_category_enum(Long fk_category_enum) {
        this.fk_category_enum = fk_category_enum;
    }

    public long getRowId() {
        return rowId;
    }

    public void setRowId(long rowId) {
        this.rowId = rowId;
    }
    
}