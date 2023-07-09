package dto;

import java.util.List;

import javax.validation.Valid;

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

	public void insert(Notice notice) {
		adminDao.insert(notice);
	}

	public int listCount() {
		return adminDao.listCount();
	}

	public List<Notice> noticeList(String admin_id, Integer pageNum, int limit) {
		return adminDao.noticeList(admin_id,pageNum,limit);
	}

	public Notice getNotice(Integer notice_num) {
		return adminDao.getNotice(notice_num);
	}

	public void update(Notice notice) {
		adminDao.update(notice);
	}

	public boolean deleteNotice(Integer notice_num) {
		return adminDao.deleteNotice(notice_num);
	}
}
