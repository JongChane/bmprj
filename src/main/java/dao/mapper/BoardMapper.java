package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Board;
import dto.Comment;

public interface BoardMapper {

	@Select("select ifnull(max(board_num),0) from board")
	int maxNum();
	
	@Insert("insert into board (board_num,user_id,board_title,board_content,board_readcnt,board_id,board_grp,board_grpstep)"
			 + " values (#{board_num},#{user_id},#{board_title},#{board_content},0,#{board_id},#{board_grp},#{board_grpstep})")
	void insert(Board board);
	
	//건의사항 전체 게시글 건수
	@Select({"<script>",
		"select count(*) from board where board_id=#{board_id} ",
		"<if test='searchtype != null'> and ${searchtype} like '%${searchcontent}%'</if>",
		"</script>"})
	int boardCount(Map<String, Object> param);

	
	@Select({"<script>",
		"select * from board",
		"<if test='board_num != null'> where board_num = ${board_num}</if>",
		"<if test='board_id != null'> where board_id = ${board_id}</if>",
		"<if test='searchtype != null'> and ${searchtype} like '%${searchcontent}%'</if>",
		"<if test='limit != null'> order by board_grp desc, board_grpstep asc limit #{startrow}, #{limit}</if>",
		"</script>"})
	List<Board> select(Map<String, Object> param);
	
	@Select("select * from board where board_num=#{board_num}")
	Board getBoard(Integer board_num);

	
	@Update("update board set board_readcnt = board_readcnt + 1 where board_num=#{board_num}")
	void addReadcnt(Integer board_num);
	
	
	@Delete("delete from board where board_num = #{board_num}")
	void deleteBoard(int board_num);
	
	@Update("update board set board_title=#{board_title}, board_content=#{board_content} where board_num=#{board_num}")
	boolean update(Board board);
	
	@Select("select * from board")
	List<Board> boardList();
	
	@Update("update board set board_grpstep=board_grpstep + 1"
			+ " where board_grp = #{grp} and board_grpstep > #{grpstep}")
	void updateGrpStep(Map<String, Object> param);
	
	
	@Insert("insert into comment (board_num,admin_id,comm_content,comm_date)"
			+ " values (#{board_num},#{admin_id},#{comm_content},now())")
	void commentinsert(Comment comm);
	
	
	@Select("select * from comment where board_num=#{board_num}")
	Comment getComment(Integer board_num);
	
	@Delete("delete from comment where board_num = #{board_num}")
	void deleteComment(int board_num);
	
	
	
	@Update("update board set board_anser=1 where board_num=#{board_num}")
	void boardUpdate(int board_num);
	
	
	@Select("select * from board order by board_num desc limit #{startrow}, #{limit} ")
	List<Board> adminBoardList(Map<String, Object> param);
	
	@Select("select count(*) from board")
	int adminBoardCount();
	
	@Select("select count(*) from board where board_anser=0")
	int adminBoardCounta();
	
	@Select("select * from board where board_anser=0 order by board_num desc limit #{startrow}, #{limit} ")
	List<Board> adminBoardLista(Map<String, Object> param);
	
	@Select("select count(*) from board where board_anser=1")
	int adminBoardCountb();
	
	@Select("select * from board where board_anser=1 order by board_num desc limit #{startrow}, #{limit} ")
	List<Board> adminBoardListb(Map<String, Object> param);
	
	@Select("select count(*) from board where user_id=#{user_id}")
	int UserboardCount(String user_id);
	
	@Select("select * from board where user_id=user_id order by board_num desc limit #{startrow}, #{limit} ")
	List<Board> getUserBoard(Map<String,Object> param);
	
	
	
}
