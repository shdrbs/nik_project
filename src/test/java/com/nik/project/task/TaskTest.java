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

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nik.project.mapper.AdminMapper;
import com.nik.project.model.AttachImageVO;
import com.nik.project.repository.AdminDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class TaskTest {

	@Autowired
	private AdminMapper mapper;

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

	@Test
	public void checkFiles() throws Exception{

		System.out.println("File Check Task Run..........");
		System.out.println(new Date());
		System.out.println("========================================");

		// DB에 저장된 파일(이미지) 리스트
		List<AttachImageVO> fileList = adminDao.checkFileList();

		// 비교 기준 파일 리스트(Path객체) 선언 및 초기화
		List<Path> checkFilePath = new ArrayList<Path>();

		// 원본 이미지
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
		System.out.println("fileList : "+fileList);
		System.out.println("checkFilePath : "+checkFilePath);

		// 디렉토리 파일 리스트
		File targetDir = Paths.get("C:\\develop\\work_space\\project\\nik_project\\upload",
				getFolderYesterDay()).toFile();
		File[] targetFile = targetDir.listFiles();
		System.out.println("targetDir : "+targetDir);
		System.out.println("targetFile : "+targetFile[2]);

		// 삭제 대상 파일 리스트(분류)
		List<File> removeFileList = new ArrayList<File>(Arrays.asList(targetFile));
		for(File file : targetFile){
			checkFilePath.forEach(checkFile ->{
				if(file.toPath().equals(checkFile))
					removeFileList.remove(file);
			});
		}

		// 삭제 대상 파일 제거
		for(File file : removeFileList) {
			System.out.println("file : "+file);
			file.delete();
		}

	}

}
