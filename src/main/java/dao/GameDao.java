package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.GameMapper;
import dto.Game;
@Repository
public class GameDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param = new HashMap<>();
	private Class<GameMapper> cls = GameMapper.class;	
	
	public void insert(Game game) {
		template.getMapper(cls).insert(game);
	}

	public List<Game> list() {
		param.clear();
		return template.getMapper(cls).select(param);
	}
}
