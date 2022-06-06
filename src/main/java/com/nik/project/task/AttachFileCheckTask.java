package com.nik.project.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.nik.project.model.AttachImageVO;
import com.nik.project.repository.AdminDAO;

import lombok.extern.log4j.Log4j2;
import lombok.extern.slf4j.Slf4j;

@Component
@Log4j2
public class AttachFileCheckTask {

	@Autowired
	private AdminDAO adminDao;

	// 어제자 날짜를 구하기 위한 메소드
	private String getFolderYesterDay() {

		// 날짜 데이터를 원하는 포맷형식으로 바꾸기 위함
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		System.out.println("sdf : "+sdf); 				// java.text.SimpleDateFormat@f67a0200

		// 현재 날짜와 시간정보를 구하기 위함
		Calendar cal = Calendar.getInstance();
		System.out.println("cal : "+cal.getTime()); 	// Thu May 19 09:52:24 KST 2022

		// 어제 날짜를 구하기 위함
		cal.add(Calendar.DATE, -1);
		System.out.println("cal : "+cal.getTime()); 	// Wed May 18 09:52:24 KST 2022

		// 어제 날짜를 "yyyy-MM-dd"포맷으로 바꾸기 위함
		String str = sdf.format(cal.getTime());
		System.out.println("str : "+str); 				// 2022-05-18

		// File.separator : 프로그램이 실행중인 OS에 맞게 구분자를 바꿔준다
		return str.replace("-", File.separator); 		// 2022\05\18
	}

	@Scheduled(cron="0 0 1 * * *") // 매일 새벽 1시에 배치 프로그램이 수행
	public void checkFiles() throws Exception{

		log.warn("File Check Task Run..........");
		log.warn(new Date());
		log.warn("========================================");

		// DB에 저장된 파일(이미지) 리스트
		List<AttachImageVO> fileList = adminDao.checkFileList(); // DB에서 어제자 이미지 리스트를 가져와서 변수 fileList에 저장

		// 비교 기준 파일 리스트(Path객체) 선언 및 초기화
		List<Path> checkFilePath = new ArrayList<Path>();

		// 원본 이미지
		// Paths.get() : Path경로를 정의 하기 위한 메서드
		fileList.forEach(vo -> {
			Path path = Paths.get("C:\\develop\\work_space\\project\\nik_project\\upload",
					vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName());
			checkFilePath.add(path);
		});

		// 썸네일 이미지
		fileList.forEach(vo -> {
			Path path = Paths.get("C:\\develop\\work_space\\project\\nik_project\\upload",
					vo.getUploadPath(), "thumbnail_" +  vo.getUuid() + "_" + vo.getFileName());
			checkFilePath.add(path);
		});

		// 디렉토리 파일 리스트
		// toFile() : 경로를 File객체로 변환해주는 메서드
		// listFiles() : 디렉토리 경로에 있는 파일들을 배열로 리턴
		File targetDir = Paths.get("C:\\develop\\work_space\\project\\nik_project\\upload",
				getFolderYesterDay()).toFile();
		File[] targetFile = targetDir.listFiles();

		// 삭제 대상 파일 리스트(분류)
		// DB에 저장된 이미지 정보와 실제 디렉토리에 존재하는 파일을 비교해서 겹치지 않는 것을 삭제
		List<File> removeFileList = new ArrayList<File>(Arrays.asList(targetFile));
		for(File file : targetFile){
			checkFilePath.forEach(checkFile ->{
				if(file.toPath().equals(checkFile))
					removeFileList.remove(file);
			});
		}

		// 삭제 대상 파일 제거
		log.warn("file Delete : ");
		for(File file : removeFileList) {
			log.warn(file);
			file.delete();
		}

		log.warn("========================================");

	}

}
