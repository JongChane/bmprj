package dto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.UserDao;

@Service
public class BmService {
	@Autowired
	private UserDao userDao;

	public void userInsert(User user) {
		userDao.insert(user);

	}

	public User selectUser(String user_id) {
		return userDao.selectOne(user_id);
	}

	public void userUpdate(User user) {
		userDao.update(user);

	}

	public User idSearch(String user_email) {
		return userDao.idSearch(user_email);
	}

	public boolean emailDuplicated(String email) {
		User user = userDao.idSearch(email);
		return user != null;
	}

	public boolean idEmailIsEmpty(String email, String user_id) {
		User user = userDao.idEmailSearch(email, user_id);
		return user != null;
	}

	public void userChgpass(String user_id, String chgpass) {
		userDao.chgpass(user_id, chgpass);

	}

	public void userDelete(String user_id) {
		userDao.delete(user_id);

	}



}
