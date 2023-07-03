package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Game;

public interface GameMapper {

	@Insert("insert into gamelist (user_id, game_title, game_content, game_max,"
			+ " game_people, game_date, game_age, game_gender, game_avg) values"
			+ " ( #{user_id}, #{game_title}, #{game_content}, #{game_max},"
			+ " #{game_people}, #{game_date}, #{game_age}, #{game_gender}, #{game_avg}) ")
	void insert(Game game);
	
	@Select({"<script>"," select * from gamelist<if test='game_num != null'> where game_num=#{game_num}</if> ",
			 "order by game_num",
			 "</script>"})
	List<Game> select(Map<String, Object> param);
	
	@Select("select * from gamelist where game_num=#{game_num}")
	Game selectOne(Map<String, Object> param);

	
	@Select("select ifnull(max(game_people),0) from gamelist")
	int maxPeople();

	@Update("update gamelist set game_people=ifnull(game_people,0) + 1 where game_num=#{game_num}")
	void update(Map<String, Object> param);
	
}
