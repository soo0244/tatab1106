package com.bit.tatab.board.service;

import java.util.List;

import com.bit.tatab.board.vo.BoardTaskVO;
import com.bit.tatab.board.vo.TaskCommentVO;

public interface TaskService {

	// task data 가져오기
	public BoardTaskVO selectAllTask(String task_no);

	// 댓글 추가
	public void insertComment(TaskCommentVO commentVO);
	
	// task 댓글 가져오기
	public List<TaskCommentVO> selectAllComment(String task_no);

	// 댓글 삭제
	public void deleteTaskComment(String commentNo);
}
