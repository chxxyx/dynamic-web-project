package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDao {


    private Connection conn; // 접근해줄 수 있게 해주는 접근객체
    private PreparedStatement pstmt; // sql 해킹 기법을 막는 PreparedStatement 기법.
    private ResultSet rs;

    public UserDao() {
        /*
            db 연결 부분
         */
        try{
            String dbUrl = "jdbc:mariadb://localhost:3306/testdb1";
            String dbId = "root";
            String dbPassword = "1234";
            Class.forName("org.mariadb.jdbc.Driver");
            conn = (Connection) DriverManager.getConnection(dbUrl, dbId, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 로그인 시도 함수
    public int login(String userID, String userPassword) { // 아이디와 비밀번호를 입력 받고 !
        String SQL = "SELECT userPassword FROM USER WHERE userID = ?"; // 해당 sql 구문 실행
                    // 아이디가 존재하는지, 존재한다면 그 해당 아이디의 패스워드는 무엇인지 가져오는 것
        try{
            pstmt = conn.prepareStatement(SQL); // 어떠한 sql 문장을 데이터 베이스에 삽입하는 형식으로 pstmt(인스턴스)를 가져온다
            pstmt.setString(1, userID); //   하나의 sql 구문 문장을 준비해두고, 추후에 ? 에 해당하는 내용으로 userID를 넣어준 거임
            rs = pstmt.executeQuery(); // 결과를 담을 수 있는 하나의 rs(객체)에 실행한 결과를 넣어준다.

                // rs.next() =? 결과가 존재한다면 !!
            if (rs.next()) {
                if (rs.getString(1).equals(userPassword)) { // 결과로 나온 비밀번호랑 로그인을 시도하는 비밀번호가 일치하면
                    return 1; // 로그인 성공 !!
                } else {
                    return 0; // 일치하지 않으면 비밀번호 불일치
                }
            } return -1; // 아이디가 없다고 알려주기
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // 데이터 베이스 오류

    }

    public int join(User user) {
        String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";

        try{
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUserID());
            pstmt.setString(2, user.getUserPassword());
            pstmt.setString(3, user.getUserName());
            pstmt.setString(4, user.getUserGender());
            pstmt.setString(5, user.getUserEmail());
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1; // db 오류
    }
}










