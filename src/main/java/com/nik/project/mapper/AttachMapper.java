package com.nik.project.mapper;

import java.util.List;

import com.nik.project.model.AttachImageVO;

public interface AttachMapper {

	/* 이미지 데이터 반환 */
	public List<AttachImageVO> getAttachList(int id);
}
