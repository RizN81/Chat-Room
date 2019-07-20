
package chatroom.services;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;

import chatroom.helper.ChatRoom;
import chatroom.helper.ChatRoomList;
import chatroom.helper.Chatter;

/**
It is used by Chat Application for listening to session events.
 * 
 */
public class SessionListener implements HttpSessionAttributeListener {
	@Override
	public void attributeAdded(HttpSessionBindingEvent hsbe) {
		//System.out.println("Attribute has been bound");
	}

	@Override
	public void attributeReplaced(HttpSessionBindingEvent hsbe) {
		//System.out.println("Attribute has been replaced");
	}

	/** This is the method we are interested in. It deletes a user from this list of users when his session
		expires.
	 */
	@Override
	public void attributeRemoved(HttpSessionBindingEvent hsbe) {
		String name = hsbe.getName();
		HttpSession session = hsbe.getSession();
		if ("nickname".equalsIgnoreCase(name))
		{
			String nickname = (String) hsbe.getValue();
			if (nickname != null)
			{
				ServletContext application = session.getServletContext();
				if (application != null)
				{
					Object chatroomListObject = application.getAttribute("chatroomlist");
					if (chatroomListObject != null)
					{
						ChatRoomList roomList = (ChatRoomList) chatroomListObject;
						ChatRoom room = roomList.getRoomOfChatter(nickname);
						if (room != null)
						{
							Object chatter = room.removeChatter(nickname);
							if (chatter != null)
							{
								String chatterName = ((Chatter) chatter).getName();
								System.out.println("Name " + chatterName);
							}

						}
					}
				}
				else
				{
					System.out.println("ServletContext is null");
				}
			}
		}
	}
}