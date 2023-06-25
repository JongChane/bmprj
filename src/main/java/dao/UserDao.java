package dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.UserMapper;
import dto.User;

@Repository
public class UserDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private Class<UserMapper> cls = UserMapper.class;

	public void insert(User user) {
		template.getMapper(cls).insert(user);

	}

	public User selectOne(String user_id) {
		param.clear();
		param.put("user_id", user_id);
		return template.getMapper(cls).selectOne(param);
	}

	public void update(User user) {
		template.getMapper(cls).update(user);

	}
}
