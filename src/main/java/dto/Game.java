package dto;


import java.util.Date;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;

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
	@NotBlank(message="제목을 입력하세요")
	private String game_title;
	@NotBlank(message="주의사항을 입력하세요")
	private String game_content;
	private int game_max;
	private int game_people;
	@NotNull(message="경기날짜를 입력하세요")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date game_date;
	@NotNull(message="나이를 선택해 주세요")
	private int game_age;
	@NotNull(message="성별을 선택해주세요")
	private String game_gender;
	@Min(value=0, message="0이상 300이하로 입력해주세요")
	@Max(value=300, message="0이상 300이하로 입력해주세요")
	private int game_avg;
}
