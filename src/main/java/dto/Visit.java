package dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Visit {
	private String vi_id;
	private int rv_num;
	private int vi_total;
	private int vi_avg;
	private int vi_game;
}
