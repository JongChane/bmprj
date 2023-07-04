package dao.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import dto.Gamer;

public interface GamerMapper {

		
	@Insert("insert into gamer (user_id, game_num) values (#{user_id}, #{game_num})")
	 void insert(Map<String, Object> param);
	
	@Select("select * from gamer where user_id=#{user_id} and game_num=#{game_num}")
	Gamer select(@Param("user_id") String user_id,@Param("game_num") Integer game_num);
}
