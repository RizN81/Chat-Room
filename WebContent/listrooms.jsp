
<%@ page session="true" errorPage="error.jsp"
	import="chatroom.services.*,chatroom.helper.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Set"%>
<%@ page import="chatroom.helper.*"%>
<html>
<head>
<title>SS Chat - Room List</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/chat.css">
<!-- <meta name="viewport" -->
<!-- 	content="width=device-width, initial-scale=1, maximum-scale=1"> -->
<script language="JavaScript">
<!--
	if (window.top != window.self) {
		window.top.location = window.location;
	}
//-->
</script>
</head>

<body bgcolor="#FFFFFF">
	<%
		String nickname = (String) session.getAttribute("nickname");
		if (nickname == null || nickname == "")
		{
			response.sendRedirect("login.jsp");
			//System.out.println("Redirecting");
		}
		else
		{
			String roomname = request.getParameter("rn");
			String descr = request.getParameter("sd");
			boolean see = false;
			if (descr != null && descr.equals("y"))
			{
				see = true;
			}
	%>
	<%@ include file="header.jsp"%>
	<table width="80%" align="center">
		<!--<tr>
		<td class="normal">Welcome <span class="chattername"><%=nickname%></span></td>
	</tr>	
	-->
		<tr>
			<td width="100%">Select the room you want to enter or click view
				description to view description about the room.</td>
		</tr>
	</table>
	<BR>
	<%
		try
			{
			
			chatroom.helper.ChatRoomList roomlist = (chatroom.helper.ChatRoomList) application.getAttribute("chatroomlist");
				ChatRoom[] chatrooms = roomlist.getRoomListArray();
				if (roomname == null)
				{
					roomname = roomlist.getRoomOfChatter(nickname).getName();
				}
				roomname = roomname.trim();
	%>
	<div align="center">
		<center>
			<form name="chatrooms"
				action="<%=request.getContextPath()%>/start.jsp" method="post">
				<table width="80%" border="1" cellspacing="1" cellpadding="1"
					align="center">
					<tr>
						<td colspan="2" class="pagetitle">Room List</td>
					</tr>
					<%
						for (int i = 0; i < chatrooms.length; i++)
								{
									if (chatrooms[i].getName().equalsIgnoreCase("StartUp"))
										continue;
					%>
					<tr>
						<td width="50%"><input type=radio name="rn"
							value="<%=chatrooms[i].getName()%>"
							<%if (chatrooms[i].getName().equals(roomname))
							out.write("checked");%>><%=chatrooms[i].getName()%></A>
						</td>
						<%
							if (see == true && chatrooms[i].getName().equals(roomname))
										{
						%>
						<td width="50%"><%=chatrooms[i].getDescription()%></td>
						<%
							}
										else
										{
						%>
						<td width="50%"><A
							href="<%=request.getContextPath()%>/listrooms.jsp?rn=<%=chatrooms[i].getName()%>&sd=y">View
								Description</A></td>
						<%
							}
						%>
					</tr>
					<%
						}
							}
							catch (Exception e)
							{
								System.out.println("Unable to get handle to Servlet Context: " + e.getMessage());
								
							}
					%>
					<tr>
						<td>&nbsp;<A href="<%=request.getContextPath()%>/addRoom.jsp"
							title="Add new Room">Add new Room</A></td>
						<td><input type="Submit" value="Start"></td>
					</tr>
				</table>
			</form>
		</center>
	</div>
	<%
		}
	%>
	<%@ include file="/footer.jsp"%>
</body>
</html>