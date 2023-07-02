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

	public Game getGame(Integer game_num) {
		param.clear();
		param.put("game_num", game_num);
		return template.getMapper(cls).selectOne(param);
	}

	public void update(String user_id, Integer game_num) {
		param.clear();
		param.put("user_id",user_id);
		param.put("game_num", game_num);
		template.getMapper(cls).update(param);
	}

	public int maxpeople() {
		
		return template.getMapper(cls).maxPeople();
	}
}
