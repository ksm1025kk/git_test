package DAO;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import VO.MemberVO;

public class MemberDAO {
	@Autowired
	SqlSession sqlSession;
	// 로그인
	public MemberVO id_check(String m_id) {
		return sqlSession.selectOne("m.id_check", m_id);
	}
	
	// 아이디 중복체크
	public int check_id(String m_id) {
		return sqlSession.selectOne("m.check_id", m_id);
		
	}
	// 회원가입
	public int member_insert(MemberVO vo) {
		return sqlSession.insert("m.member_insert", vo);
	}
	
	// 내 글 보기
	public MemberVO selectOne(int m_idx) {
		return sqlSession.selectOne("m.member_selectOne", m_idx);
	}
	// 개인정보 수정
	public int member_modify(MemberVO vo) {
		return sqlSession.update("m.member_modify", vo);
		
	}
	// 비밀번호 변경
	public int update_pwd(MemberVO vo) {
		return sqlSession.update("m.pwd_change", vo);
	}
}
