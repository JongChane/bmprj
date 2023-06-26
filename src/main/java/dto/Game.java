package dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Game {
	private int game_num;
	private String user_id;
	private int game_max;
	private int game_people;
	private int game_age;
	private int game_avg;
	private String game_title;
	private String game_content;
	private String game_gender;
	private Date game_date;
}
