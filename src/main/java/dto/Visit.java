package dto;

import javax.validation.constraints.NotEmpty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Visit {
	@NotEmpty(message = "방문자 아이디를 입력하세요.")
	private String vi_id;
	private int rv_num;
	@NotEmpty(message = "총점을 입력하세요.")
	private int vi_total;
	private int vi_avg;
	@NotEmpty(message = "게임수를 입력하세요.")
	private int vi_game;
	private Reservation rv;

}


