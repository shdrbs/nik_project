package com.nik.project.service;

import java.util.List;

import com.nik.project.model.AttachImageVO;

public interface AttachService {
	
	// 이미지 데이터 반환
	public List<AttachImageVO> getAttachList(int id);
}
