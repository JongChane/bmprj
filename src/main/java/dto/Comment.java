package dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Comment {
	private int comm_num;
	private int board_num;
	private String user_id;
	private String comm_content;
	private int comm_grp;
	private Date comm_date;
}
