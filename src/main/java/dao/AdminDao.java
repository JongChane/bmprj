package dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.AdminMapper;
import dto.Admin;

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
}
