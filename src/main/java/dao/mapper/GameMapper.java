package dao.mapper;

import org.apache.ibatis.annotations.Insert;

import dto.Game;

public interface GameMapper {

	@Insert("insert into gamelist (user_id, game_title, game_content, game_max,"
			+ " game_people, game_date, game_age, game_gender, game_avg) values"
			+ " ( #{user_id}, #{game_title}, #{game_content}, #{game_max},"
			+ " #{game_people}, #{game_date}, #{game_age}, #{game_gender}, #{game_avg}) ")
	void insert(Game game);

}
