package dto;

import java.util.Date;

import javax.validation.constraints.NotEmpty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Notice {
	private String notice_num;
	private String admin_id;
	@NotEmpty(message="제목을 입력하세요")
	private String notice_title;
	@NotEmpty(message="내용을 입력하세요")
	private String notice_content;
	private Date notice_regdate;
	private int notice_readcnt;
}
