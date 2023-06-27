package dto;

import java.util.Date;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Game {
	private int game_num;
	private String user_id;
	private String game_title;
	private String game_content;
	private int game_max;
	private int game_people;
	@NotEmpty(message="경기날짜를 입력하세요")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date game_date;
	private int game_age;
	private String game_gender;
	private int game_avg;
}
