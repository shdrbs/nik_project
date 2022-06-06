package com.nik.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nik.project.model.AttachImageVO;
import com.nik.project.repository.AttachDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AttachServiceImpl implements AttachService {
	
	@Autowired
	private AttachDAO attachDao;

	// 이미지 데이터 반환
	@Override
	public List<AttachImageVO> getAttachList(int id) {
		
		log.info("getAttachList.........");
		
		return attachDao.getAttachList(id);
	}

}
