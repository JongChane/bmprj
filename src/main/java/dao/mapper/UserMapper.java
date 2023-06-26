package dao.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.User;

public interface UserMapper {
	@Insert("insert into user (user_id, user_pass, user_name, user_gender, user_tel, "
													+ "user_email, user_avg) values "
													+ "(#{user_id}, #{user_pass}, #{user_name}, #{user_gender}, #{user_tel}, "
													+ "#{user_email}, #{user_avg})")
	void insert(User user);

	@Select("select * from user where user_id=#{user_id}")
	User selectOne(Map<String, Object> param);
	
	@Update("update user set user_name=#{user_name}, user_gender=#{user_gender}, user_tel=#{user_tel}, "
												+ "user_email=#{user_email}, user_avg=#{user_avg} where user_id=#{user_id}")
	void update(User user);
	
	@Select("select * from user where user_email=#{user_email}")
	User idSearch(Map<String, Object> param);


	

}
