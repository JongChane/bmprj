package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Game;

public interface GameMapper {

	@Insert("insert into gamelist (user_id, game_title, game_content, game_max,"
			+ " game_people, game_date, game_age, game_gender, game_avg) values"
			+ " ( #{user_id}, #{game_title}, #{game_content}, #{game_max},"
			+ " 1, #{game_date}, #{game_age}, #{game_gender}, #{game_avg}) ")
	@Options(useGeneratedKeys=true, keyProperty="game_num")
	void insert(Game game);
	
	@Select({"<script>"," select * from gamelist<if test='game_num != null'> where game_num=#{game_num}</if> ",
			 "<if test='user_id != null'> where user_id=#{user_id}</if> ",
			 "<if test='searchtype != null'> and ${searchtype} like '%${searchcontent}%</if> ",
			 "<if test='limit != null'> order by game_num desc, game_num asc limit #{startrow}, #{limit}</if>",
			 "</script>"})
	List<Game> select(Map<String, Object> param);
	
	@Select("select * from gamelist g1, gamer g2  WHERE g1.game_num = g2.game_num AND g2.user_id =#{user_id}")
	List<Game> selectJoin(Map<String, Object> param);
	
	@Select("select * from gamelist where game_num=#{game_num}")
	Game selectOne(Map<String, Object> param);

	
	@Select("select ifnull(max(game_people),0) from gamelist")
	int maxPeople();

	@Update("update gamelist set game_people=ifnull(game_people,0) + 1 where game_num=#{game_num}")
	void update(Map<String, Object> param);
	
	@Delete("delete from gamelist where game_num=#{game_num}")
	void gmdelete(Integer gmnum);

	@Update("update gamelist set game_title=#{game_title}, game_max=#{game_max}, game_gender=#{game_gender},"
			+ "	game_avg=#{game_avg}, game_age=#{game_age}, game_date=#{game_date}, game_content=#{game_content}"
			+ " where game_num=#{game_num}")
	void gameupdate(Map<String, Object> param);
	
	@Select({"<script>",
			"select count(*) from gamelist ",
			"<if test='searchtype != null'> where ${searchtype} like '%${searchcontent}%'</if>",
			"</script>"})
	int gameCount(Map<String, Object> param);
	
	@Select({"<script>",
			" select * from gamelist",
			"<if test='searchtype != null'> where ${searchtype} like '%${searchcontent}%'</if>",
			" <if test='limit != null'> order by game_num desc limit #{startrow}, #{limit}</if>",
			 "</script>"})
	List<Game> gamepage(Map<String, Object> param);

	@Update("update gamelist set game_people=game_people-1 where game_num=#{value}")
	boolean gamepeople(Integer gmnum);

	@Select("select * from gamelist where game_num=#{gmnum} and user_id=#{user_id}")
	Game getmpGame(Integer gmnum, String user_id);
	
	
	
}
