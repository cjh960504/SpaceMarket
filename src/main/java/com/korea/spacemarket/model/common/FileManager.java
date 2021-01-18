/*
 * 파일과 관련된 유용한 기능을 모아놓는 클래스
 * */
package com.korea.spacemarket.model.common;

import java.io.File;
import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
@Data
@Component /*component-scan의 대상 중 하나임..*/
public class FileManager {
	private static final Logger logger = LoggerFactory.getLogger(FileManager.class);
	private String saveBasicDir="/resources/data/basic";
	private String saveAddonDir="/resources/data/addon";
	private String saveProductImgDir="/resources/data/product_img";
	private String saveThumbImgDir="/resources/data/thumb_img";
	
	//확장자만 추출하기 
	public static String getExtend(String path) {
		int lastIndex = path.lastIndexOf(".");
		String ext = path.substring(lastIndex+1, path.length());
		//System.out.println(ext);		
		return ext;
	}
	
	//파일삭제  : 호출자는 삭제하고싶은 파일의 경로를 넘긴다
	public static boolean deleteFile(String path) {
		File file = new File(path);
		return file.delete();
	}
	
	//파일 저장하기
	public void saveFile(String realDir , MultipartFile multi) {
		try {
			multi.transferTo(new File(realDir));
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}




