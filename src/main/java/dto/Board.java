package dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Board {
	private int board_num;
	private String user_id;
	private String board_title;
	private String board_content;
	private int board_readcnt;
	private String board_id;
	private Date board_date;
}
