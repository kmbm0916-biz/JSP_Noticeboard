package DBPKG;

import java.sql.*;

//import java.security.MessageDigest;
//import java.security.NoSuchAlgorithmException;

public class Util {
	public static Connection getConnection() throws Exception {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = DriverManager.getConnection(
				"jdbc:oracle:thin:@//localhost:1521/xe",
				"system",
				"11111");
		return conn;

	}
	
	public static String getParamNN(String param) {
		if(param == null)
			return "1";
		return param;
	}
	
//	public static String sha256(String msg) throws NoSuchAlgorithmException{
//		MessageDigest md = MessageDigest.getInstance("SHA-256");
//		md.update(msg.getBytes());
//		
//		return bytesToHex(md.digest());
//		
//	}
//	
//	public static String bytesToHex(byte [] bytes) {
//		StringBuilder builder = new StringBuilder();
//		for(byte b : bytes) {
//			builder.append(String.format("%02x", b));
//		}
//		
//		return builder.toString();
//	}
}
