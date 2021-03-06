package com.mycompany.webapp.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mycompany.webapp.dao.TakeDao;
import com.mycompany.webapp.dto.BuildingDto;
import com.mycompany.webapp.dto.BuildingFileDto;
import com.mycompany.webapp.dto.EquipmentDto;
import com.mycompany.webapp.dto.LikeListDto;
import com.mycompany.webapp.dto.MessageDto;

@Service
public class TakeService {
	@Resource
	private TakeDao takeDao;

	public int insertBuilding(BuildingDto bdt) {
		takeDao.insertBuilding(bdt);
		int buildingNo = bdt.getBuildingNo();
		return buildingNo;
	}

	public void insertEquipments(EquipmentDto equip) {
		takeDao.insertEquipments(equip);
	}

	public void insertBuildingFile(BuildingFileDto bfd) {
		takeDao.insertImageFile(bfd);
	}

	public List<BuildingDto> selectBuildingList() {
		return takeDao.selectBuildingList();
	}

	public List<BuildingFileDto> selectBuildingFiles() {
		return takeDao.selectBuildingFiles();
	}

	public List<BuildingFileDto> selectImageFileByBuildingNo(String buildingNo) {
		return takeDao.selectImageFileByBuildingNo(buildingNo);
	}

	public BuildingDto selectBuildingByBuildingNo(String buildingNo) {
		return takeDao.selectBuildingByBuildingNo(buildingNo);
	}

	public List<EquipmentDto> selectEquipmentByBuildingNo(String buildingNo) {
		return takeDao.selectEquipmentByBuildingNo(buildingNo);
	}
	
	public int sendMessage(MessageDto message) {
		return takeDao.insertMessage(message);
	}

	public int buildingFilesCount(String buildingNo) {
		return takeDao.buildingFilesCount(buildingNo);
	}

	public int selectLikeListByBuildingNo(LikeListDto lld) {
		return takeDao.selectLikeListByBuildingNo(lld);
	}

	public void insertLikeLists(LikeListDto lld) {
		takeDao.insertLikeLists(lld);
	}

	public void deleteLikeLists(LikeListDto lld) {
		takeDao.deleteLikeLists(lld);
	}

	public void updateLikeCount(BuildingDto bdt) {
		takeDao.updateLikeCount(bdt);
	}

	public void deleteEquipments(int buildingNo) {
		takeDao.deleteEquipments(buildingNo);
	}

	public void deleteBuildingImagesByImageNo(int imgNo) {
		takeDao.deleteBuildingImagesByImageNo(imgNo);
	}

	public void updateBuilding(BuildingDto bdt) {
		takeDao.updateBuilding(bdt);
	}

	public void deleteBuildingByNo(int buildingNo) {
		takeDao.deleteBuildingByNo(buildingNo);
	}

	public void updateBuildingUseYN(int buildingNo) {
		takeDao.updateBuildingUseYN(buildingNo);
	}
}
