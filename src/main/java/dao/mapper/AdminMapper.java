package dao.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Select;

import dto.Admin;

public interface AdminMapper {
	
	@Select("select * from admin where admin_id=#{admin_id}")
	Admin selectOne(Map<String, Object> param);

}
