package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.AdminMapper;
import dto.Admin;
import dto.Notice;

@Repository
public class AdminDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private Class<AdminMapper> cls = AdminMapper.class;
	public Admin selectOne(String admin_id) {
		param.clear();
		param.put("admin_id", admin_id);
		return template.getMapper(cls).selectOne(param);
	}
	
	public void insert(Notice notice) {
		template.getMapper(cls).insert(notice);
	}

	public int listCount() {
		return template.getMapper(cls).listCount();
	}

	public List<Notice> noticeList(String admin_id, Integer pageNum, int limit) {
		param.clear();
		param.put("startrow", (pageNum -1) * limit); //1페이지 : 0 2페이지 :10
		param.put("limit", limit);
		param.put("admin_id", admin_id);
		return template.getMapper(cls).noticeList(param);
	}

	public Notice getNotice(Integer notice_num) {
		return template.getMapper(cls).getNotice(notice_num);
	}

	public void update(Notice notice) {
		template.getMapper(cls).update(notice);
	}

	public boolean deleteNotice(Integer notice_num) {
		return template.getMapper(cls).deleteNotice(notice_num);
	}

	public List<Notice> noticeListUser(Integer pageNum, int limit) {
		param.clear();
		param.put("startrow", (pageNum -1) * limit); //1페이지 : 0 2페이지 :10
		param.put("limit", limit);
		return template.getMapper(cls).noticeListUser(param);
	}
}
