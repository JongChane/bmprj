package dto;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.GameDao;
@Service
public class GameService {
	@Autowired
	private GameDao gamedao;
	
	public void gameInsert(Game game) {
		gamedao.insert(game);
	}

	public List<Game> gameList() {
		return gamedao.list();
	}

	public Game getGame(Integer game_num) {
		return gamedao.getGame(game_num);
	}

	public void gameupdate(String user_id, Integer game_num) {
		gamedao.update(user_id,game_num);
	}
}
