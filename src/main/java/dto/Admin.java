package dto;

import javax.validation.constraints.NotEmpty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Admin {
	@NotEmpty(message="아이디를 입력하세요.")
	private String admin_id;
	@NotEmpty(message="비밀번호를 입력하세요.")
	private String admin_pass;
	private String admin_name;
}
