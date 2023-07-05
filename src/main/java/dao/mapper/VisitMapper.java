package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Visit;

public interface VisitMapper {
	
	@Insert("insert into visit (vi_id, rv_num, vi_game) values(#{vi_id}, #{rv_num}, #{vi_game})")
	void insert(Map<String, Object> param);
	
	@Select("select * from visit where rv_num=#{rv_num}")
	List<Visit> visitList(Map<String, Object> param);
	
	@Update("update visit set vi_total=#{vi_total}, vi_avg=#{vi_avg} where "
	        + "rv_num=#{rv_num} and vi_id=#{vi_id}")
	void update(Map<String, Object> param);
	
	@Select("select * from visit") //전체 회원 점수 목록
	List<Visit> viList();



}
