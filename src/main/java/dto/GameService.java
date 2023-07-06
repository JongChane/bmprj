package dto;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.GameDao;
import dao.GamerDao;
@Service
public class GameService {
	@Autowired
	private GameDao gamedao;
	@Autowired
	private GamerDao gamerdao;
	
	public int gameInsert(Game game) {
		return gamedao.insert(game);
	}

	public List<Game> gameList() {
		return gamedao.list(null);
	}

	public Game getGame(Integer game_num) {
		return gamedao.getGame(game_num);
	}

	public void gameupdate(String user_id, Integer game_num) {
		gamedao.update(user_id,game_num);
	}

	public void gamerInsert(String user_id, Integer game_num) {
		 gamerdao.insert(user_id,game_num);
	}

	public Gamer getGamer(String user_id,Integer game_num) {
		return gamerdao.selectOne(user_id,game_num);
	}

	
}
