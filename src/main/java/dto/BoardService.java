package dto;

import java.io.File;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.BoardDao;

@Service
public class BoardService {
	@Autowired
	private BoardDao boardDao;

	public void uploadFileCreate(MultipartFile file, String path) {
		String orgFile = file.getOriginalFilename();
		File f = new File(path);
		if(!f.exists()) f.mkdirs();
		try {
			file.transferTo(new File(path+orgFile));
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	public void write(Board board) {
		int maxnum = boardDao.maxNum();
		board.setBoard_num(++maxnum);
		board.setBoard_grp(maxnum);
		boardDao.insert(board);
	}

	public int boardCount(String board_id, String searchtype, String searchcontent) {
		return boardDao.boardCount(board_id,searchtype,searchcontent);
	}

		
	public List<Board> boardList(Integer pageNum, int limit, String board_id, String searchtype, String searchcontent) {
		return boardDao.boardList(pageNum,limit,board_id,searchtype,searchcontent);
	}

	public Board getBoard(Integer board_num) {
		return boardDao.getBoard(board_num); //board_num해당된 board레코드 조회
	}

	public void addReadcnt(Integer board_num) {
		boardDao.addReadcnt(board_num); //조회수 증가
	}

	public void deleteBoard(int board_num) {
		boardDao.deleteBoard(board_num);
	}

	public boolean update(Board board) {
		return boardDao.update(board);
	}
	
	public void boardReply(Board board) {
		boardDao.updateGrpStep(board);
		int maxnum = boardDao.maxNum();
		board.setBoard_num(++maxnum);
//		board.setBoard_grplevel(board.getBoard_grplevel() + 1);
		board.setBoard_grpstep(board.getBoard_grpstep() + 1);
		boardDao.insert(board);
		System.out.println(board);
	}

	public void commentinsert(Comment comm) {
		boardDao.commentinsert(comm);
	}

	public Comment getComment(Integer board_num) {
		// TODO Auto-generated method stub
		return boardDao.getComment(board_num);
	}

	public void deleteComment(int board_num) {
		boardDao.deleteComment(board_num);
	}


	public void boardUpdate(int board_num) {
		boardDao.boardUpdate(board_num);
	}

	
	public List<Board> boardList(Integer pageNum, int limit) {
		return boardDao.adminBoardList(pageNum,limit);
	}

	public int boardCount() {
		return boardDao.adminBoardCount();
	}

	public int boardCounta() {
		return boardDao.adminBoardCounta();
	}

	public List<Board> boardLista(Integer pageNum, int limit) {
		return boardDao.adminBoardLista(pageNum,limit);
	}

	
	public int boardCountb() {
		return boardDao.adminBoardCountb();
	}

	public List<Board> boardListb(Integer pageNum, int limit) {
		return boardDao.adminBoardListb(pageNum,limit);
	}

	public int UserboardCount(String user_id,Integer board_anser) {
		return boardDao.UserboardCount(user_id,board_anser);
	}

	public List<Board> getUserBoard(String user_id,Integer pageNum, int limit, Integer board_anser) {
		return boardDao.getUserBoard(user_id,pageNum,limit,board_anser);
	}

}
