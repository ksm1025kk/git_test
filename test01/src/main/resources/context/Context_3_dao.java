package context;


import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import DAO.BoardDAO;
import DAO.MemberDAO;


@Configuration
public class Context_3_dao {
	// 3) dao 객체 생성
	@Bean
	public BoardDAO boardDAO() {
		return new BoardDAO();
	}
	
	@Bean
	public MemberDAO memberDAO() {
		return new MemberDAO();
	}
	
	
	
	
	
}