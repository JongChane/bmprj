package dao.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import dto.Reservation;

public interface ReservationMapper {

	@Insert("insert into reservation (user_id, lane_num, rv_now, rv_date, rv_game,"
			+ " rv_start, rv_end, rv_people) values "
			+ " (#{user_id}, #{lane_num}, now(), #{rv_date}, #{rv_game},"
			+ " #{rv_start}, #{rv_end}, #{rv_people})")
	void insert(Reservation reservation);

	@Select("SELECT rv_start"
			+ " FROM reservation"
			+ " WHERE rv_date = #{date}")
	List<String> rvCheck(String date);

}
