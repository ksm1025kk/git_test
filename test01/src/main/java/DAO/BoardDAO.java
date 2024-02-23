package DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import VO.BoardVO;
import VO.PagingVO;

public class BoardDAO {
	@Autowired
	SqlSession sqlSession;
	
	// 게시물 수 조회
	public int countBoard1() {
		return sqlSession.selectOne("b.countBoard1");
	}
	
	// 조건에 맞는게시물 수 조회
	public int countBoard2(int m_idx) {
		return sqlSession.selectOne("b.countBoard2", m_idx);
	}
	// 제목이 비슷한 게시물 총개수
	public int countBoard_b_title(String keyword) {
		return sqlSession.selectOne("b.countBoard_b_title", keyword);
	}
	// 내용이 비슷한 게시물 총개수
	public int countBoard_b_content(String keyword) {
		return sqlSession.selectOne("b.countBoard_b_content", keyword);
	}
	// 작성자가 비슷한 게시물 총개수
	public int countBoard_m_id(String keyword) {
		return sqlSession.selectOne("b.countBoard_m_id", keyword);
	}
	
	// 게시물 전체 조회
	public List<BoardVO> selectList(PagingVO vo){
		return sqlSession.selectList("b.board_list", vo);
	}
	
	// 게시물 1개 조회
	public BoardVO selectOne(int b_idx) {
		return sqlSession.selectOne("b.board_selectOne", b_idx);
	}
	
	// 게시물 작성
	public int board_insert(BoardVO vo) {
		return sqlSession.insert("b.board_insert", vo);
	}
	// 내게시물 보기
	public List<BoardVO> select_list_my_content(PagingVO vo){
		return sqlSession.selectList("b.select_list_my_content", vo);
	}
	
	// 게시물 수정
	public int board_update(BoardVO vo) {
		return sqlSession.update("b.board_update", vo);
	}
	
	// 게시물 삭제
	public int board_delete(int b_idx) {
		return sqlSession.delete("b.board_delete", b_idx);
	}
	// 제목이 비슷한 게시물 조회
	public List<BoardVO> selectList_b_title(PagingVO vo) {
		return sqlSession.selectList("b.selectList_b_title", vo);
		
	}
	// 내용이 비슷한 게시물 조회
	public List<BoardVO> selectList_b_content(PagingVO vo) {
		return sqlSession.selectList("b.selectList_b_content", vo);
	}
	// 작성자가 비슷한 게시물 조회
	public List<BoardVO> selectList_m_id(PagingVO vo) {
		return sqlSession.selectList("b.selectList_m_id", vo);
	}
}
