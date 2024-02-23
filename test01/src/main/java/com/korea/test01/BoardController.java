package com.korea.test01;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import DAO.BoardDAO;
import VO.BoardVO;
import util.MyCommon;
import VO.PagingVO;

@Controller
public class BoardController {
	
	@Autowired
	BoardDAO board_dao;
	@Autowired
	HttpServletRequest request;
	@Autowired
	HttpSession session;

/*	
	@RequestMapping(value = { "/", "board_list.do" })
	public String select(Model model) {
		List<BoardVO> list = board_dao.selectList();
		model.addAttribute("list", list);
		return MyCommon.VIEW_PATH_B + "board_list.jsp";
	}
*/
	@RequestMapping(value = { "/", "board_list.do" })
	public String select(PagingVO vo, Model model, 
			@RequestParam(value="nowPage", required = false) String nowPage,
			@RequestParam(value="cntPerPage", required = false) String cntPerPage,
			@RequestParam(value="orderby", required = false) String orderby
			) {
		
		int total = board_dao.countBoard1();
		if(nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		}else if(nowPage == null){
			nowPage = "1";
		}else if(cntPerPage == null) {
			cntPerPage ="5";
		}
		vo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		
		if(orderby != null) {
			vo.setOrderby(orderby);
		}
		List<BoardVO> list = board_dao.selectList(vo);
		model.addAttribute("paging", vo);
		model.addAttribute("list", list);
		return MyCommon.VIEW_PATH_B + "board_list.jsp";
	}
	
	// 상세보기
	@RequestMapping("board_view.do")
	public String view(Model model, int b_idx) {
		BoardVO vo = board_dao.selectOne(b_idx);
		model.addAttribute("vo", vo);
		return MyCommon.VIEW_PATH_B + "board_view.jsp?b_idx=" + b_idx;
	}
	
	// 게시물 작성 폼으로 이동
	@RequestMapping("board_insert_form.do")
	public String board_insert_form() {
		return MyCommon.VIEW_PATH_B + "board_insert_form.jsp";
	}
	
	// 게시물 작성
	@RequestMapping("board_insert.do")
	public String board_insert(BoardVO vo) {
		int res = board_dao.board_insert(vo);
		if(res > 0) {
			return "redirect:board_list.do";
		}else {
			return null;
		}
	}
	
	// 게시물 수정
	@RequestMapping("board_modifiy.do")
	public String content_modify(BoardVO vo) {
		int res = board_dao.board_update(vo);
		if(res>0) {
			return "redirect:board_view.do?b_idx=" + vo.getB_idx();
		}
		return null;
	}
	
	// 게시글 삭제
	@RequestMapping("board_delete.do")
	public String board_delete(int b_idx, int m_idx) {
		int res = board_dao.board_delete(b_idx);
		if(res>0) {
			return "redirect:board_list.do";
		}
		return null;
	}
	
	// 게시물 검색
	@RequestMapping("search_board.do")
	public String search_board(PagingVO vo, Model model, String type, String keyword,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage,
			@RequestParam(value = "orderby", required = false) String orderby) {
	
		int total;
		if(keyword.equals("")) {
			return "redirect:board_list.do";
		}
		vo.setKeyword(keyword);
		
		if(type.equals("b_title")) {
			total = board_dao.countBoard_b_title(keyword);
		}else if(type.equals("b_content")){
			total = board_dao.countBoard_b_content(keyword);
		}else {
			total = board_dao.countBoard_m_id(keyword);
		}
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) {
			cntPerPage = "5";
		}
		vo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		if (orderby != null) {
			vo.setOrderby(orderby);
		}
		vo.setKeyword(keyword);
		List<BoardVO> res_list;
		if(type.equals("b_title")) {
			res_list = board_dao.selectList_b_title(vo);
		}else if(type.equals("b_content")){
			res_list = board_dao.selectList_b_content(vo);
		}else {
			res_list = board_dao.selectList_m_id(vo);
		}
		
		model.addAttribute("paging", vo);
		model.addAttribute("res_list", res_list);
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);
		
		return MyCommon.VIEW_PATH_B + "board_res_list.jsp";
	}
}
