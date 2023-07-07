package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import dto.Gamer;

public interface GamerMapper {

		
	@Insert("insert into gamer (user_id, game_num) values (#{user_id}, #{game_num})")
	 void insert(Map<String, Object> param);
	
	@Select("select * from gamer where user_id=#{user_id} and game_num=#{game_num}")
	Gamer select(@Param("user_id") String user_id,@Param("game_num") Integer game_num);

	@Select({"<script>"," select * from gamer<if test='usre_id != null'> where user_id=#{user_id}</if> ",
			 "order by user_id",
			 
			 "</script>"})
	List<Gamer> gselect(Map<String, Object> param);

	@Select("select * from gamer where game_num=#{game_num}")
	List<Gamer> GmList(int game_num);
	
	@Delete("delete from gamer where game_num=#{game_num}")
	void gamerdelete(Integer gmnum);
	
	@Delete("delete from gamer where game_num=#{gmnum} and user_id=#{user_id}")	
	boolean mygamedelete(Map<String, Object> param);
}
