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
		boardDao.insert(board);
	}

	public int boardCount(String board_id, String searchtype, String searchcontent) {
		return boardDao.boardCount(board_id,searchtype,searchcontent);
	}

		
	public List<Board> boardList(Integer pageNum, int limit, String board_id, String searchtype, String searchcontent) {
		return boardDao.boardList(pageNum,limit,board_id,searchtype,searchcontent);
	}
}
