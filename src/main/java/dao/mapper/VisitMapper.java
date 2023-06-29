package dao.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Insert;

public interface VisitMapper {
	
	@Insert("insert into visit (vi_id, rv_num, vi_total, vi_avg, vi_game) values "
			+ "(#{vi_id},#{rv_num} ,#{vi_total}, #{vi_avg}, #{vi_game})")
	void insert(Map<String, Object> param);

	


}
