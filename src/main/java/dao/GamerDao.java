package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.GamerMapper;
import dto.Gamer;
@Repository
public class GamerDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param = new HashMap<>();
	private Class<GamerMapper> cls = GamerMapper.class;
	
	public void insert(String user_id, Integer game_num) {
		param.clear();
		param.put("user_id", user_id);
		param.put("game_num",game_num );
		template.getMapper(cls).insert(param);
	}

	public  Gamer selectOne(String user_id, Integer game_num) {
		return template.getMapper(cls).select(user_id,game_num);
	}

	public List<Gamer> list() {
	
		return template.getMapper(cls).gselect(param);
	}
}
