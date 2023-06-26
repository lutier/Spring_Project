package com.spring.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.spring.domain.BoardAttachVO;
import com.spring.mapper.BoardAttachMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Component	//@Component is a class level annotation
public class FileCheckTask {
	@Setter(onMethod_=@Autowired)
	private BoardAttachMapper attachMapper;
	
	@Scheduled(cron = "0 0 0 ? * SUN") //(cron = "0 * * ? * *")
	public void checkFiles() throws Exception{
		log.info("checkFiles");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		String uploadpath = sdf.format(cal.getTime());
		for (int i=0; i<DayOfWeek.SUNDAY.getValue(); i++) {
			cal.add(Calendar.DATE, -1);
			uploadpath = sdf.format(cal.getTime()).replace("-", "/");
			log.info("cal....uploadpath : " + uploadpath);
			List<BoardAttachVO> fileList = attachMapper.getOldFiles(uploadpath);
			
			//files on the tbl_attach
			List<Path> fileListPaths = new ArrayList<Path>();
			for(BoardAttachVO vo : fileList) {
				fileListPaths.add(Paths.get("/Users/tunamayo/Downloads/project_temp", vo.getUploadpath(), vo.getUuid() + "_" + vo.getFilename()));
				if(vo.isFiletype()) {
					fileListPaths.add(Paths.get("/Users/tunamayo/Downloads/project_temp", vo.getUploadpath(), "s_" + vo.getUuid() + "_" + vo.getFilename()));
				}
			}
			
			log.info("--------------------------------------");
			log.info("database files......");
			for(Path path : fileListPaths) {
				log.info(path.toString());
			}
			
			//files on the directory
			log.info("--------------------------------------");
			File dir = Paths.get("", uploadpath).toFile();
			for(File file : dir.listFiles()) {
				if(!fileListPaths.contains(file.toPath())) {
					log.info("this file will be deleted......");
					log.info(file.getAbsolutePath());
					file.delete();
				}
			}
		}
	}

}
