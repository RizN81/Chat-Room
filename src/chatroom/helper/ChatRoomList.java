
package chatroom.helper;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

public class ChatRoomList {

	private Map<String, ChatRoom>	roomList;

	public ChatRoomList() {

		roomList = new HashMap<String, ChatRoom>();
	}

	public synchronized void addRoom(ChatRoom room) {
		roomList.put(room.getName(), room);
	}

	public synchronized void removeRoom(String name) {
		roomList.remove(name);
	}

	public ChatRoom getRoom(String name) {
		return roomList.get(name);
	}

	public ChatRoom getRoomOfChatter(String name) {
		ChatRoom[] rooms = this.getRoomListArray();
		for (int i = 0; i < rooms.length; i++)
		{
			boolean chatterexists = rooms[i].chatterExists(name);
			if (chatterexists)
			{
				return rooms[i];
			}
		}
		return null;
	}

	public Set<?> getRoomList() {
		return roomList.entrySet();
	}

	@SuppressWarnings("rawtypes")
	public ChatRoom[] getRoomListArray() {
		ChatRoom[] roomListArray = new ChatRoom[roomList.size()];
		Set<?> roomlist = getRoomList();
		Iterator<?> roomlistit = roomlist.iterator();
		int i = 0;
		while (roomlistit.hasNext())
		{
			Map.Entry me = (Map.Entry) roomlistit.next();
			String key = (String) me.getKey();
			roomListArray[i] = (ChatRoom) me.getValue();
			i++;
			System.out.println("Room List Array Key [ " + key + "]");
		}
		return roomListArray;
	}

	public boolean isChatterExists(String nickName) {
		boolean chatterexists = false;

		if (getRoomList().contains(nickName))
		{
			chatterexists = true;
		}
		return chatterexists;
	}

	public boolean chatterExists(String nickname) {
		boolean chatterexists = false;
		ChatRoom[] rooms = this.getRoomListArray();
		for (int i = 0; i < rooms.length; i++)
		{
			chatterexists = rooms[i].chatterExists(nickname);
			if (chatterexists)
			{
				break;
			}
		}
		return chatterexists;
	}
}
