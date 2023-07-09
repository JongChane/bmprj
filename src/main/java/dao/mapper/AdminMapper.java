package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Admin;
import dto.Notice;

public interface AdminMapper {
	
	@Select("select * from admin where admin_id=#{admin_id}")
	Admin selectOne(Map<String, Object> param);
	
	@Insert("insert into notice (admin_id,notice_title,notice_content,notice_regdate,notice_readcnt)"
			+ " values(#{admin_id},#{notice_title},#{notice_content},now(),0)")
	void insert(Notice notice);
	
	@Select("select count(*) from notice where admin_id = 'admin'")
	int listCount();
	
	@Select("select * from notice where admin_id=#{admin_id} order by notice_num desc limit #{startrow}, #{limit} ")
	List<Notice> noticeList(Map<String, Object> param);

	@Select("select * from notice where notice_num=#{value}")
	Notice getNotice(Integer notice_num);

	@Update("update notice set notice_title=#{notice_title}, notice_content=#{notice_content} where notice_num=#{notice_num}")
	void update(Notice notice);

	@Delete("delete from notice where notice_num=#{value}")
	boolean deleteNotice(Integer notice_num);
	
}
