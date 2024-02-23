package com.korea.test01;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import DAO.BoardDAO;
import DAO.MemberDAO;
import VO.BoardVO;
import VO.MemberVO;
import VO.PagingVO;
import util.MyCommon;

@Controller
public class MemberController {
	@Autowired
	BoardDAO board_dao;
	@Autowired
	MemberDAO member_dao;
	@Autowired
	HttpServletRequest request;
	@Autowired
	HttpSession session;
	@Autowired
	SqlSession sqlSession;

	@RequestMapping("login_form.do")
	public String login_form() {
		return MyCommon.VIEW_PATH_B + "login_form2.jsp";
	}
	
	@RequestMapping("login.do")
	@ResponseBody
	public String login(String m_id, String m_pwd) {
		MemberVO vo = member_dao.id_check(m_id);
		if(vo == null) {
			return "[{'param':'no_m_id'}]";
		}
		if(!vo.getM_pwd().equals(m_pwd)) {
			return"[{'param':'no_m_pwd'}]";
		}
		session.setAttribute("account", vo);
		return "[{'param':'clear'}]";
	}
	
	@RequestMapping("logout.do") 
	public String logout() {
		session.removeAttribute("account");

		return "redirect:board_list.do";
	}
	
	@RequestMapping("member_insert_form.do")
	public String member_insert_form() {
		return MyCommon.VIEW_PATH_B + "member_insert_form.jsp";
	}
	
	@RequestMapping("check_id.do")
	@ResponseBody
	public String check_id(String m_id) {
		int res = member_dao.check_id(m_id);
		if(res==0) {
			return "[{'res' : 'yes'}]";
		}
		return "[{'res' : 'no'}]";
	}
	
	@RequestMapping("member_insert.do")
	public String member_insert(MemberVO vo) {
		int res = member_dao.member_insert(vo);
		if(res>0) {
			return "redirect:board_list.do";
		}
		return null;
	}
/*
	@RequestMapping("my_content.do")
	public String my_content(Model model, int m_idx) {
		MemberVO vo = member_dao.selectOne(m_idx);
		List<BoardVO> list = board_dao.select_list_my_content(m_idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("list", list);
		return MyCommon.VIEW_PATH_B + "my_content.jsp";
	}
*/	
	@RequestMapping("my_content.do")
	public String select(PagingVO vo, Model model, int m_idx,
			@RequestParam(value="nowPage", required = false) String nowPage,
			@RequestParam(value="cntPerPage", required = false) String cntPerPage,
			@RequestParam(value="orderby", required = false) String orderby
			) {
		
		
		int total = board_dao.countBoard2(m_idx);
		
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
		vo.setM_idx(m_idx);
		
		List<BoardVO> list = board_dao.select_list_my_content(vo);
		MemberVO vo2 = member_dao.selectOne(m_idx);
		model.addAttribute("vo", vo2);
		model.addAttribute("paging", vo);
		model.addAttribute("list", list);
		
		return MyCommon.VIEW_PATH_B + "my_content.jsp";
	}
	
	// 프로필
	@RequestMapping("member_info.do")
	public String member_info() {
		return MyCommon.VIEW_PATH_B + "member_info.jsp";
	}
	
	// 개인정보수정
	@RequestMapping("member_modify.do")
	public String member_modify(MemberVO vo) {
		int res = member_dao.member_modify(vo);
		if(res>0) {
			return "redirect:logout.do";
		}
		return null;
	}
	
	// 비밀번호 찾기 탭 이동
	@RequestMapping("pwd_find.do")
	public String pwd_find() {
		return MyCommon.VIEW_PATH_B + "pwd_find.jsp";
	}
	
	@RequestMapping("id_checked.do")
	@ResponseBody
	public String id_checked(String m_id) {
		
		int res = member_dao.check_id(m_id);
		
		if(res==1) {
			return "[{'res' : 'yes'}]";
		}
		return "[{'res' : 'no'}]";
	
		
	}

	@RequestMapping("pwd_found.do")
	public String pwd_found(MemberVO vo) {
		int res = member_dao.update_pwd(vo);
		if(res>0) {
			return "redirect:login_form.do";
		}
		return null;
	}
}
