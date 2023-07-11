package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.GameMapper;
import dto.Game;
import dto.User;
@Repository
public class GameDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param = new HashMap<>();
	private Class<GameMapper> cls = GameMapper.class;	
	
	public int insert(Game game) {
		template.getMapper(cls).insert(game);
		System.out.println(game.getGame_num());
		return game.getGame_num();
	}

	public List<Game> list(String user_id) {
		param.clear();
		param.put("user_id", user_id);
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

	public List<Game> listjoin(String user_id) {
		param.clear();
		param.put("user_id",user_id);
		return template.getMapper(cls).selectJoin(param);
	}

	public void gmdelete(Integer gmnum) {
		template.getMapper(cls).gmdelete(gmnum);
	}

	public void gameupdate(Game game, Integer game_num) {
		param.clear();
		param.put("game_title", game.getGame_title());
		param.put("game_content", game.getGame_content());
		param.put("game_max", game.getGame_max());
		param.put("game_date", game.getGame_date());
		param.put("game_age", game.getGame_age());
		param.put("game_gender", game.getGame_gender());
		param.put("game_avg", game.getGame_avg());
		param.put("game_num", game_num);
		
		template.getMapper(cls).gameupdate(param);
	}

	public int gameCount(String searchtype, String searchcontent) {
		param.clear();
		param.put("searchtype", searchtype);
		param.put("searchcontent", searchcontent);
		return template.getMapper(cls).gameCount(param);
	}

	public List<Game> gamepage(Integer pageNum, int limit, String searchtype, String searchcontent) {
		param.getClass();
		param.put("startrow", (pageNum -1) * limit); //1페이지 : 0 2페이지 :10
		param.put("limit", limit);
		param.put("searchtype", searchtype);
		param.put("searchcontent", searchcontent);
		return template.getMapper(cls).gamepage(param);
	}

	public boolean gamepeople(Integer gmnum) {
		return template.getMapper(cls).gamepeople(gmnum);
	}

	public Game getmpGame(Integer gmnum, String user_id) {
		return template.getMapper(cls).getmpGame(gmnum,user_id);
	}
}
