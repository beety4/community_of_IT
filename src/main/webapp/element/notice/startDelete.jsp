<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="notice.noticeDTO" %>
<%@ page import="notice.noticeDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("sID") != null) {
			userID = (String) session.getAttribute("sID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요한 서비스입니다.');");
			script.println("location.href='../../login/index.jsp';");
			script.println("</script>");
			script.close();
		}
	
		int num = 0;
		if(request.getParameter("num") != null) {
			num = Integer.parseInt(request.getParameter("num"));
		}
		if(num == 0 ) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 게시글 입니다.');");
			script.println("location.href='index.jsp';");
			script.println("</script>");
			script.close();
		}
	
		noticeDTO noticeDAO = new noticeDAO().showBoard(num);
		if(!userID.equals(noticeDAO.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권환이 없습니다.');");
			script.println("location.href='index.jsp';");
			script.println("</script>");
			script.close();
		}
		else{
			noticeDAO notice = new noticeDAO();
			int result = notice.delete(num);
			if(result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('게시글 삭제에 실패하였습니다.');");
				script.println("location.href='index.jsp';");
				script.println("</script>");
				script.close();
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('게시글 삭제를 성공하였습니다!');");
				script.println("location.href='index.jsp';");
				script.println("</script>");
				script.close();
			}
		}

	%>
</body>
</html>