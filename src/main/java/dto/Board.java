package dto;

import java.util.Date;

import javax.validation.constraints.NotEmpty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Board {
	private int board_num;
	private String user_id;
	@NotEmpty(message="제목을 입력하세요")
	private String board_title;
	@NotEmpty(message="내용을 입력하세요")
	private String board_content;
	private int board_readcnt;
	private String board_id;
	private Date board_date;
}
