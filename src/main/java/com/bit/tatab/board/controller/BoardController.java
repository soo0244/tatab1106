package com.bit.tatab.board.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.tatab.board.service.BoardService;
import com.bit.tatab.board.vo.BoardColVO;
import com.bit.tatab.board.vo.BoardTaskVO;
import com.bit.tatab.main.vo.MainBackgroundVO;

@Controller
public class BoardController {
	
	@Inject
	BoardService boardService;

	@ResponseBody
	@RequestMapping(value = "/board.do")
	public ModelAndView board(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ModelAndView mav = new ModelAndView("board");

		String projectName = request.getParameter("projectName");
		String project_no = request.getParameter("project_no");

		HttpSession session = request.getSession();
		
		if (project_no==null) {
			String no = session.getAttribute("project_no").toString();
			project_no = no;
		}
		
		session.setAttribute("projectName", projectName);
		session.setAttribute("project_no", project_no);
		
		// 배경이미지 가져오기(빈 값 포함)
		MainBackgroundVO mainBackgroundVO = (MainBackgroundVO) session.getAttribute("mainBackgroundVO");

		System.out.println("board 프로젝트 이름 : " + projectName + ", 프로젝트 고유번호 : " + project_no);

		//////////////////////// 해당 프로젝트의 컬럼 불러오기 /////////////////////////
		int prj_no = Integer.parseInt(project_no);
		List<BoardColVO> boardColList = boardService.selectAllProjectCol(prj_no);
		
		for(int i=0; i<boardColList.size(); i++) {
			System.out.println("[" + i + "] : " + boardColList.get(i).toString());
		}
		///////////////////////////////////////////////////////////////////////
		
		mav.addObject("projectName", projectName);
		mav.addObject("colData", boardColList);
		mav.addObject("mainBackgroundVO", mainBackgroundVO);
		
		return mav;
	}
	
	
	// Board 에 작업 추가
	@ResponseBody
	@RequestMapping(value = "/insertBoardTask.do", method = RequestMethod.POST)
	public void insertBoardTask(HttpServletRequest request, String task_name, @RequestParam("col_no")int no) throws Exception {

		HttpSession session = request.getSession();
		int project_no = Integer.parseInt((String) session.getAttribute("project_no"));
		
		System.out.println("파라미터 확인  \n" + "col_index : " + no + "\ntask_name : " + String.valueOf(task_name));

		BoardTaskVO boardTaskVO = new BoardTaskVO(project_no, no, task_name, "", "O", "-", "-");
		System.out.println("^^^" + boardTaskVO.toString());
		
		int index = boardService.checkTaskIndex(boardTaskVO);
		System.out.println("------------------" + String.valueOf(index));
		
		if(index == 0) {
			boardTaskVO.setTask_index(0);
			System.out.println("insert 전 index 확인 : " + String.valueOf(boardTaskVO.getTask_index()));
			boardService.insertBoardTask(boardTaskVO);
		} else {
			boardTaskVO.setTask_index(index);
			System.out.println("insert 전 index 확인 : " + String.valueOf(boardTaskVO.getTask_index()));
			boardService.insertBoardTask(boardTaskVO);
		}
		
		
	}
	
	@RequestMapping(value="insertCol.do", method=RequestMethod.POST)
	public String insertCol(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView("board");
		
		HttpSession session = request.getSession();
		String project_no = session.getAttribute("project_no").toString();
		String colName = request.getParameter("ColName");
		
		System.out.println("추가될 프로젝트 번호 : " + project_no + " 추가될 컬럼 이름 : " + colName); 
		
		boardService.insertCol(project_no, colName);
		 
		return "redirect:/board.do";
	}
	
	@RequestMapping(value="task.do", method=RequestMethod.GET)
	public ModelAndView task(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView("task");
		return mav;
	}
}
