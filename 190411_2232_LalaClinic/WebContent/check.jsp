<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%
response.setDateHeader("Expires", 0);
response.setHeader("Pragma", "no-cache");

if (request.getProtocol().equals("HTTP/1.1")) {
	response.setHeader("Cache-Control", "no-cache");
}
%>
	<script type="text/javascript">
	alert("로그아웃 되었습니다");
	location.href="index.jsp";
	</script>