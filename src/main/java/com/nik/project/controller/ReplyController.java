package com.nik.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nik.project.model.Criteria;
import com.nik.project.model.ReplyDTO;
import com.nik.project.model.ReplyPageDTO;
import com.nik.project.service.ReplyService;

@RestController
@RequestMapping("/reply")
public class ReplyController {

	@Autowired
	private ReplyService replyService;

	/* 리뷰 등록 */
	@PostMapping("/regist")
	public void registReplyPOST(ReplyDTO dto) {

		replyService.registReply(dto);
	}

	/* 리뷰 체크 */
	/* memberId, id 파라미터 */
	/* 존재 : 1 / 존재x : 0 */
	@PostMapping("/check")
	public String replyCheckPOST(ReplyDTO dto) {

		return replyService.checkReply(dto);
	}

	/* 리뷰 페이징 */
	// produces = MediaType.APPLICATION_JSON_UTF8_VALUE : 반환할 객체(ReplyPageDTO)를 JSON으로 변환해서 뷰에 전송
	@GetMapping(value="/list", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ReplyPageDTO replyListPOST(Criteria cri) {

		return replyService.replyList(cri);
	}

	/* 리뷰 수정 */
	@PostMapping("/update")
	public void replyModifyPOST(ReplyDTO dto) {

		replyService.updateReply(dto);
	}

	/* 댓글 삭제 */
	@PostMapping("/delete")
	public void replyDeletePOST(ReplyDTO dto) {

		replyService.deleteReply(dto);
	}

}
