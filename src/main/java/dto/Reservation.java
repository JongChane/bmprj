package dto;

import java.time.LocalTime;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

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
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date rv_date;
	private int rv_game;
	@DateTimeFormat(pattern = "HH:mm")
	private LocalTime rv_start;
	@DateTimeFormat(pattern = "HH:mm")
	private LocalTime rv_end;
	private int rv_people;
}
