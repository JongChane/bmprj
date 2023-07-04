package dto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.AdminDao;

@Service
public class AdminService {
	@Autowired
	private AdminDao adminDao;

	public Admin selectAdmin(String admin_id) {
		return adminDao.selectOne(admin_id);
	}
}
