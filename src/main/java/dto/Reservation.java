package dto;

import java.sql.Time;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Reservation {
	private int rv_num;
	private String user_id;
	private int lane_num;
	private Date rv_now;
	private Date rv_date;
	private int rv_game;
	private Time rv_start;
	private Time rv_end;
	private int rv_people;
	private String rv_check;
}
