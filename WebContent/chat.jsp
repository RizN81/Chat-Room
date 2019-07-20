
<%@ page session="true"
	import="chatroom.helper.ChatRoomList,chatroom.helper.ChatRoom;"
	errorPage="error.jsp"%>
<%
	String nickname = (String) session.getAttribute("nickname");
	if (nickname != null && nickname.length() > 0)
	{
		ChatRoomList roomList = (ChatRoomList) application.getAttribute("chatroomlist");
		ChatRoom room = roomList.getRoomOfChatter(nickname);
		String roomname = room.getName();
%>

<HTML>
<HEAD>
<TITLE>Chat Room - <%=nickname%> (<%=roomname%>)
</TITLE>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
</HEAD>
<FRAMESET rows="80%,20%">
	<FRAME SRC="displayMessages.jsp#current" name="MessageWin">
	<FRAME SRC="sendMessage.jsp" name="TypeWin">
</FRAMESET>
<NOFRAMES>
	<H2>This chat rquires a browser with frames support</h2>
</NOFRAMES>
</HTML>
<%
	}
	else
	{
		response.sendRedirect("login.jsp");
	}
%>