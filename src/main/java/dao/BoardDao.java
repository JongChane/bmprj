package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.BoardMapper;
import dto.Board;
import dto.Comment;

@Repository
public class BoardDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private Class<BoardMapper> cls = BoardMapper.class;
	
	public int maxNum() {
		return template.getMapper(cls).maxNum();
	}

	public void insert(Board board) {
		template.getMapper(cls).insert(board);
	}

	public int boardCount(String board_id, String searchtype, String searchcontent) {
		param.clear();
		param.put("board_id", board_id);
		param.put("searchtype", searchtype);
		param.put("searchcontent", searchcontent);
		return template.getMapper(cls).boardCount(param);
	}

	public List<Board> boardList(Integer pageNum, int limit, String board_id, String searchtype, String searchcontent) {
		param.getClass();
		param.put("startrow", (pageNum -1) * limit); //1페이지 : 0 2페이지 :10
		param.put("limit", limit);
		param.put("board_id", board_id);
		param.put("searchtype", searchtype);
		param.put("searchcontent", searchcontent);
		return template.getMapper(cls).select(param);
	}

	public Board getBoard(Integer board_num) {
		param.clear();
		param.put("board_num", board_num);
		return template.getMapper(cls).getBoard(board_num);
	}

	public void addReadcnt(Integer board_num) {
		param.clear();
		param.put("board_num", board_num);
		template.getMapper(cls).addReadcnt(board_num);
	}

	public void deleteBoard(int board_num) {
		param.clear();
		param.put("board_num", board_num);
		template.getMapper(cls).deleteBoard(board_num);
	}

	public boolean update(Board board) {
		return template.getMapper(cls).update(board);
	}

	public List<Board> boardList() {
		return template.getMapper(cls).boardList();
	}

	public void updateGrpStep(Board board) {
		param.clear();
		param.put("grp", board.getBoard_grp());
		param.put("grpstep", board.getBoard_grpstep());
		template.getMapper(cls).updateGrpStep(param);
	}

	public void commentinsert(Comment comm) {
		template.getMapper(cls).commentinsert(comm);
	}

	public Comment getComment(Integer board_num) {
		param.clear();
		param.put("board_num", board_num);
		return template.getMapper(cls).getComment(board_num);
	}

	public void deleteComment(int board_num) {
		param.clear();
		param.put("board_num", board_num);
		template.getMapper(cls).deleteComment(board_num);
	}	
}
