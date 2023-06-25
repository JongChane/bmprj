package dto;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class User {
	@Size(min=3, max=10, message="아이디는 3자이상 10자이하로 입력하세요.")
	private String user_id;
	@Size(min=3, max=10, message="비밀번호는 3자이상 10자이하로 입력하세요.")
	private String user_pass;
	@NotEmpty(message="이름을 입력하세요.")
	private String user_name;
	@NotEmpty(message = "성별을 선택하세요.")
	private String user_gender;
	@Pattern(regexp = "\\d+", message = "전화번호는 숫자만 입력하세요.")
	private String user_tel;
	@NotEmpty(message="email을 입력하세요.")
	private String user_email;
	@Min(value=0, message="0이상 300이하로 입력해주세요.")
	@Max(value=300, message="0이상 300이하로 입력해주세요.")
	private int user_avg;
}
