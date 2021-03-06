<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="DBPKG.Util" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String pagenum = Util.getParamNN(request.getParameter("pagenum"));	

	Connection conn = Util.getConnection();
	Statement stmt = conn.createStatement();
	
	int page_cur = Integer.parseInt(pagenum);
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시판</title>
	<link rel="stylesheet" href="./stylesheets/style.css">
</head>
<body>
	<header>
        <h3>게시판</h3>
    </header>
    <div class="board_list_wrap">
        <div class="board_list">
            <div class="board_list_head">
                <div class="idx">INDEX</div>
                <div class="title">TITLE</div>
                <div class="writer">AUTHOR</div>
                <div class="date">DATE</div>
                <div class="view">VIEW</div>
            </div>
            <div class="board_list_body">
            <%
            	String sql = "SELECT * FROM (SELECT A.*, ROWNUM AS RNUM, COUNT(*) OVER() AS TOTCNT FROM (SELECT * FROM page_prac ORDER BY id DESC) A ) WHERE RNUM >= 10*("+ pagenum +"-1)+1 AND RNUM <= " + pagenum + "*10";
            	ResultSet rs = stmt.executeQuery(sql);
            	while(rs.next()) {
            %>
                <div class="item">
                    <div class="idx"><%=rs.getString("id") %></div>
                    <div class="title"><a href="#"><%=rs.getString("title") %></a></div>
                    <div class="writer"><%=rs.getString("name") %></div>
                    <div class="date">2021-10-14</div>
                    <div class="view">1</div>
                </div>
            <%
            	}
            %>
            </div>
        </div>
        <%
        	Statement stmt2 = conn.createStatement();
        	String sql2 = "SELECT COUNT(*) cnt FROM page_prac";
        	ResultSet rs2 = stmt2.executeQuery(sql2);
        	rs2.next();
        	Integer pageno = (int)Math.ceil(rs2.getDouble(1) / 10);
        %>
        <div class="paging">
            <a href="index.jsp?pagenum=1" class="bt first">처음 페이지</a>
			<a href="index.jsp?pagenum=<%=page_cur - 1 %>" class="bt prev">이전 페이지</a>
            <%for(int pageidx = 1; pageidx <= pageno; pageidx++){ %>
            <a href="index.jsp?pagenum=<%=pageidx %>" class="idx"><%=pageidx %></a>
            <%} %>
            <a href="index.jsp?pagenum=<%=page_cur + 1 %>" class="bt next">다음 페이지</a>
            <a href="index.jsp?pagenum=<%=pageno %>" class="bt last">마지막 페이지</a>
        </div>
    </div>
</body>
</html>