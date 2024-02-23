package VO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardVO {
	private int b_idx, m_idx, b_auth;
	private String b_title, b_content, b_date, m_id;
}
