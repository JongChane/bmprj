package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import dto.Reservation;

public interface ReservationMapper {

	@Insert({
	    "INSERT INTO reservation (rv_num, user_id, lane_num, rv_now, rv_date, rv_game,",
	    " rv_start, rv_end, rv_people, rv_price) VALUES",
	    " (#{rv_num}, #{user_id}, #{lane_num}, now(), #{rv_date}, #{rv_game},",
	    "  #{rv_start}, #{rv_end}, #{rv_people}, (#{rv_game}*#{rv_people})*3000)"
	})
	void insert(Reservation reservation);

	@Select({
    "<script>",
    "SELECT rv_start, rv_end",
    "FROM reservation",
			"WHERE rv_date = #{date} AND (",
    "<foreach item='item' index='index' collection='laneNumbers' separator='OR'>",
    "FIND_IN_SET(#{item}, lane_num) > 0",
    "</foreach>",
			")",
    "</script>"
})
List<Map<String, Object>> rvCheck(@Param("date")String date, @Param("laneNumbers")List<String> laneNumbers);

	
@Select("SELECT * FROM rv_view")
	List<Reservation> rvList();
	
	@Select("select ifnull(max(rv_num),0) from reservation")
	int maxRvnum();

	@Select("select count(*) from rv_view where vi_id=#{vi_id}")
	int UserReserveCount(@Param("vi_id") String vi_id);

	@Select("SELECT * FROM rv_view WHERE vi_id=#{vi_id} ORDER BY rv_num DESC LIMIT #{startrow}, #{limit}")
	List<Reservation> getUserReserve(Map<String, Object> param);
}
