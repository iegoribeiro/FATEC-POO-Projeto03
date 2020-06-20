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
public class Question {
    private long rowId;
    private String question;
    private String answer1;
    private String answer2;
    private String answer3;
    private CategoryEnum category;

    public Question(long rowId, String question, String answer1, String answer2, String answer3, CategoryEnum category) {
        this.rowId = rowId;
        this.question = question;
        this.answer1 = answer1;
        this.answer2 = answer2;
        this.answer3 = answer3;
        this.category = category;
    }

    public Question(long rowId, String question, String answer1, String answer2, String answer3, long categoryEnumId) throws Exception {
        this.rowId = rowId;
        this.question = question;
        this.answer1 = answer1;
        this.answer2 = answer2;
        this.answer3 = answer3;
        this.category.setId(categoryEnumId);
//        this.category.setName(CategoryEnum.getCategoryEnum(categoryEnumId).getName());
    }
    
    public static ArrayList<Question> getList()throws Exception{
        ArrayList<Question> list = new ArrayList<>();
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT rowid, * from questions");
        while(rs.next()){
            list.add(new Question(
                rs.getLong("rowid"),
                rs.getString("question"), 
                rs.getString("answer1"),
                rs.getString("answer2"),
                rs.getString("answer3"),
                rs.getLong("fk_category_enum")
            ));
        }
        rs.close();
        stmt.close();
        con.close();
        return list;
    }
    
    public static Question getQuestionAndAnswers(long rowId) throws Exception{
        Question transaction = null;
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        String SQL = "SELECT rowId, * from questions WHERE rowid=?";
        PreparedStatement stmt = con.prepareStatement(SQL);
        stmt.setLong(1, rowId);
        ResultSet rs = stmt.executeQuery();
        if(rs.next()){
            transaction = new Question(
                rs.getLong("rowid"),
                rs.getString("question"), 
                rs.getString("answer1"),
                rs.getString("answer2"),
                rs.getString("answer3"),
                rs.getLong("fk_category_enum")
            );
        }
        rs.close();
        stmt.close();
        con.close();
        return transaction;
    }
    
    public static void addQuestion(String question, String answer1, String answer2, String answer3, CategoryEnum category) throws Exception{
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        String SQL = "INSERT INTO questions(question, answer1, answer2, answer3, fk_category_enum) VALUES(?,?,?,?,?)";
        PreparedStatement stmt = con.prepareStatement(SQL);
        stmt.setString(1, question);
        stmt.setString(2, answer1);
        stmt.setString(3, answer2);
        stmt.setString(4, answer3);
        stmt.setLong(5, category.getId());
        stmt.execute();
        stmt.close();
        con.close();
    }
    public static void putQuestion(String question, String answer1, String answer2, String answer3, CategoryEnum category, long rowId) throws Exception{
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        String SQL = "UPDATE questions SET question=?, answer1=?, answer2=?, answer3=?, fk_category_enum=? WHERE rowid=?";
        PreparedStatement stmt = con.prepareStatement(SQL);
        stmt.setString(1, question);
        stmt.setString(2, answer1);
        stmt.setString(3, answer2);
        stmt.setString(4, answer3);
        stmt.setLong(5, category.getId());
        stmt.setLong(6, rowId);
        stmt.execute();
        stmt.close();
        con.close();
    }
    public static void removeQuestion(long rowId) throws Exception{
        Class.forName("org.sqlite.JDBC");
        Connection con = DriverManager.getConnection(web.DbListener.URL);
        String SQL = "DELETE FROM questions WHERE rowid=?";
        PreparedStatement stmt = con.prepareStatement(SQL);
        stmt.setLong(1, rowId);
        stmt.execute();
        stmt.close();
        con.close();
    }

    public long getRowId() {
        return rowId;
    }

    public void setRowId(long rowId) {
        this.rowId = rowId;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getAnswer1() {
        return answer1;
    }

    public void setAnswer1(String answer1) {
        this.answer1 = answer1;
    }

    public String getAnswer2() {
        return answer2;
    }

    public void setAnswer2(String answer2) {
        this.answer2 = answer2;
    }

    public String getAnswer3() {
        return answer3;
    }

    public void setAnswer3(String answer3) {
        this.answer3 = answer3;
    }

    public CategoryEnum getCategory() {
        return category;
    }

    public void setCategory(CategoryEnum category) {
        this.category = category;
    }
        
}
