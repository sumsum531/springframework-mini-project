package com.mycompany.webapp.controller;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.json.JSONObject;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mycompany.webapp.dto.CommentDto;
import com.mycompany.webapp.dto.FreeBoardDto;
import com.mycompany.webapp.dto.LikeListDto;
import com.mycompany.webapp.dto.MarketAlignDto;
import com.mycompany.webapp.dto.MarketBoardDto;
import com.mycompany.webapp.dto.MarketFileDto;
import com.mycompany.webapp.dto.MarketPagerDto;
import com.mycompany.webapp.dto.NoticeBoardDto;
import com.mycompany.webapp.dto.PagerDto;
import com.mycompany.webapp.security.UserCustom;
import com.mycompany.webapp.service.CommentService;
import com.mycompany.webapp.service.FreeBoardService;
import com.mycompany.webapp.service.MarketBoardService;
import com.mycompany.webapp.service.NoticeService;
import com.mycompany.webapp.service.TakeService;
import com.mycompany.webapp.service.UserService;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/community")
public class CommunityController {

	@Resource
	private FreeBoardService freeBoardService;
	@Resource
	private UserService userService;
	@Resource
	private CommentService CommentService;
	@Resource
	private MarketBoardService marketBoardService;
	@Resource
	private TakeService takeService; //insertlikeLists ???????????? ?????? Resource
	@Resource
	private NoticeService noticeService;

	// ??????????????? - board -------------------------------------------------------------------------------------------------------------------
	@GetMapping("/board/list")
	public String boardList(@RequestParam(value="pageNo", defaultValue = "1") int pageNo,  Model model, HttpServletRequest request) { //???????????? 1??????????????? ????????????!
		
		String searchType = (String) request.getParameter("searchType");
		String searchContent = (String) request.getParameter("searchContent");
		
		//Board ????????? ?????? ????????????
		int totalBoardNum = freeBoardService.getTotalFreeBoardNum(); // ?????? ?????? ????????????
		PagerDto pager = new PagerDto(10, 10, totalBoardNum, pageNo);
		
		if(searchType != null) {
			pager.setSearchType(searchType);
		}
		if(searchContent != null) {
			pager.setSearchContent(searchContent);
		}
		
		model.addAttribute("pager", pager);
		
		//????????? ??????
		List<FreeBoardDto> freeboards = freeBoardService.getFreeBoards(pager);
		model.addAttribute("freeboards", freeboards);
		model.addAttribute("searchType", pager.getSearchType());
		model.addAttribute("searchContent", pager.getSearchContent());
		model.addAttribute("totalBoardNum", totalBoardNum);
		return "/community/board/list";
	}

	// board/list?????? ????????? ?????? ????????? ???
	@GetMapping("/board/insert")
	public String boardInsertBtn(HttpSession session) {
		if(session.getAttribute("sessionUserId") == null) {
			return "redirect:/index/loginForm";
		}else {
			return "/community/board/insert";
		}
	}

	// ????????? ?????? ??????
	@PostMapping("/board/insertContent")
	public String insertContent(@RequestParam("title") String title, @RequestParam("content") String content, HttpSession session) {
		String SessionUserid = (String) session.getAttribute("sessionUserId");
		
		//freeDto????????? user????????? ?????? ??????
		FreeBoardDto freeBoardDto = new FreeBoardDto();
		freeBoardDto.setFreeTitle(title);
		freeBoardDto.setFreeContent(content);
		freeBoardDto.setFreeWriter(SessionUserid);

		freeBoardService.insertFreeBoard(freeBoardDto);
		return "redirect:/community/board/list";
	}

	// ????????? ?????? ??????
	@RequestMapping("/board/insertCancle")
	public String insertCancle() {
		return "redirect:/community/board/list";
	}

	// ????????? ?????? ?????????
	@GetMapping("/board/boardDetail")
	public String boardDetail(int freeNo, Model model, HttpSession session, HttpServletRequest request) {

		//????????? ?????? ?????????!
		freeBoardService.setupdateHitCount(freeNo);
		
 		//freeBoardDto ?????? model??? ??????
		FreeBoardDto freeBoardDto = freeBoardService.getFreeBoard(freeNo);
		model.addAttribute("freeBoardDto", freeBoardDto);
		
		//????????? ?????? ?????? ??????
		String tempContent = freeBoardDto.getFreeContent();
		tempContent = org.springframework.web.util.HtmlUtils.htmlEscape(tempContent);
		tempContent = tempContent.replaceAll("\n", "<br/>");
		freeBoardDto.setFreeContent(tempContent);
		
		//?????? ???????????? ????????? id model??? ??????
		String SessionUserid = (String) session.getAttribute("sessionUserId");
		model.addAttribute("seesionUserid", SessionUserid);		
		
		if(SessionUserid!=null) {
			//?????? ???????????? ????????? ????????? ????????? ????????????
			String nickname = userService.getNickname(SessionUserid);
			model.addAttribute("sessionUserNickname", nickname);
			model.addAttribute("from", request.getParameter("from"));
			model.addAttribute("pageNo", request.getParameter("pageNo"));			
		}

		
		//????????? ?????? ????????????----------------------------
		//?????? ?????? ????????????
		int totalCommentNum = CommentService.totalCountwhenFreeNo(freeNo);
		PagerDto pager = new PagerDto(50,10,totalCommentNum,1);
		pager.setFreeNo(freeNo);
		model.addAttribute("pager",pager); //jsp?????? ????????? ?????? ??? ??????????????? model??? ?????????.
		
		//????????? ??????
		List<CommentDto> comments = CommentService.getselectByFreeNo(pager);
		model.addAttribute("comments", comments);
		
		return "/community/board/view";
	}
	
	@GetMapping("/board/freeBoardPostingDelete")
	public String freeBoardPostingDelete(int freeNo) {
		freeBoardService.deleteFreeBoard(freeNo);
		return "redirect:/community/board/list";
	}
	
	@RequestMapping("/board/view")
	public String boardView() {
		return "/community/board/view";
	}

	@RequestMapping("/board/insert")
	public String boardInsert1() {
		return "/community/board/insert";
	}

	@GetMapping("/board/update")
	public String boardUpdate(int freeNo, Model model, HttpServletRequest request) {
		String mypage = (String) request.getParameter("from");
		log.info(mypage);
		FreeBoardDto freeBoardDto = freeBoardService.getFreeBoard(freeNo);
		if(mypage != null) {
			model.addAttribute("from", mypage);
		} 
		model.addAttribute("freeBoardDto", freeBoardDto);
		return "/community/board/update";
	}
	
	@PostMapping("/board/updateForm")
	public String boardUpdateFrom(@RequestParam("title") String title, @RequestParam("content") String content, @RequestParam("freeNo") int freeNo, @RequestParam("from") String mypage) {

		//?????? ????????? ?????? ?????? ????????????
		FreeBoardDto freeBoardDto = freeBoardService.getFreeBoard(freeNo);
		freeBoardDto.setFreeTitle(title);
		freeBoardDto.setFreeContent(content);
		
		log.info(mypage);
		
		freeBoardService.updateFreeBoard(freeBoardDto);
		if(mypage != null) {
			return "redirect:/community/board/boardDetail?freeNo="+freeBoardDto.getFreeNo()+"&from=mypage";
		} else {
			return "redirect:/community/board/boardDetail?freeNo="+freeBoardDto.getFreeNo();	
		}
	}
	
	// ?????? ---------------------------------------------------------------------------------------------------------------------------------------------
	@PostMapping("/board/insertComment")
	public String insertComment(int freeNo, @RequestParam("commentContent") String commentContent, HttpSession session) {
		String SessionUserid = (String) session.getAttribute("sessionUserId");

		CommentDto commentDto = new CommentDto();
		commentDto.setCommentContent(commentContent);
		commentDto.setFreeNo(freeNo);
		commentDto.setCommentWriter(SessionUserid);
		
		CommentService.insertComment(commentDto);
		
		return "redirect:/community/board/boardDetail?freeNo="+freeNo;
	}

	@PostMapping("/board/commentDelete")
	public String commentDelete(CommentDto commentDto) {
		CommentService.deleteComment(commentDto);
		return "redirect:/community/board/boardDetail?freeNo="+commentDto.getFreeNo();
	}
	
	//?????? ?????? html ?????? ????????????
	@PostMapping("/board/updateContent")
	public String updateContent(String commentContent, int commentNo, String userNickname, int freeNo, Model model) {
		model.addAttribute("commentContent", commentContent);
		model.addAttribute("commentNo", commentNo);
		model.addAttribute("userNickname", userNickname);
		model.addAttribute("freeNo", freeNo);
		return "/community/board/commentModify";
	}
	
	//?????? ?????? ???????????? ????????? ???
	@PostMapping("/board/updateComment")
	public String updateContent(@RequestParam("freeNo") int freeNo, @RequestParam("commentContent") String commentContent, @RequestParam("commentNo") int commentNo) {
		CommentDto commentDto = new CommentDto();
		commentContent = org.springframework.web.util.HtmlUtils.htmlEscape(commentContent);
		commentContent = commentContent.replaceAll("<br/>", "\n");
		commentDto.setCommentContent(commentContent);
		commentDto.setCommentNo(commentNo);
		CommentService.updateComment(commentDto);
		
		return "redirect:/community/board/boardDetail?freeNo="+freeNo;
	}
	
	@PostMapping(value = "/board/bringReplyJson", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String bringReplyJson(int upperNo, String userId, int commentDepth, int freeNo, HttpSession session) {
		
		//1. ????????? ??????
		String userNickname = userService.getNickname(userId);

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("sessionUserNickname", userNickname);
		jsonObject.put("upperNo", upperNo);
		jsonObject.put("userId", userId);
		jsonObject.put("commentDepth", commentDepth);
		jsonObject.put("freeNo", freeNo);
		
		session.setAttribute("upperNo", upperNo);
		
		String json = jsonObject.toString();
		return json; 
	}
	
	
	@PostMapping(value="/board/registReply", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String replyComment(@RequestParam("upperNo") int upperNo, @RequestParam("freeNo") int freeNo, @RequestParam("commentContext") String commentContent, @RequestParam("userId") String sessionUserId, @RequestParam("commentDepth") int commentDepth){
		
		//?????? ?????? ??????
		Date utilDate = new Date();
		long timeInMilliSeconds = utilDate.getTime();
		java.sql.Date sqlDate = new java.sql.Date(timeInMilliSeconds);
		
		CommentDto commentDto = new CommentDto();
		commentDto.setUpperNo(upperNo);
		commentDto.setFreeNo(freeNo);
		commentDto.setCommentContent(commentContent);
		commentDto.setCommentWriter(sessionUserId);
		commentDto.setCommentDepth(commentDepth+1);
		commentDto.setCommentModifyDate(sqlDate);
		commentDto.setCommentRegistDate(sqlDate);

		int commentNo = CommentService.insertReplyComment(commentDto);
		commentDto.setCommentNo(commentNo);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("commentDto", commentDto);
		
		String json = jsonObject.toString();
		
		return json;
	}


	// ??????????????? - market ---------------------------------------------------------------------------------------------------------------------------------
	@RequestMapping("/market/list")
	public String marketList(Model model, HttpServletRequest request) {
		
		//????????? marketAlign ?????? ????????????
		MarketAlignDto marketAlign = new MarketAlignDto();
		marketAlign.setAlign(request.getParameter("align")==null?"":request.getParameter("align"));
		marketAlign.setCategory(request.getParameter("category")==null?"":request.getParameter("category"));
		marketAlign.setSearchContent(request.getParameter("searchContent")==null?"":request.getParameter("searchContent"));
		marketAlign.setSearchType(request.getParameter("searchType")==null?"":request.getParameter("searchType"));
		
		log.info("ccc: " +marketAlign.getCategory());
		
		if(marketAlign.getCategory().equals("0")) {
			marketAlign.setCategory("");
		}
		
		if(marketAlign.getAlign().equals("a0")) {
			marketAlign.setAlign("");
		}
		
		//????????? ?????? ????????? ?????? ??????
		int totalBoardNum = marketBoardService.getTotalMarketBoardCount(marketAlign); // ?????? ?????? ????????????
		log.info("tt : " + totalBoardNum);
		
		int pageNo = 1;
		
		log.info("r : " + request.getParameter("pageNo"));
		
		
		if(request.getParameter("pageNo") != null) {
			if(!request.getParameter("pageNo").equals("")) {
				pageNo = Integer.parseInt(request.getParameter("pageNo"));
			}
		}
		
		//pager ???????????????
		MarketPagerDto pager = new MarketPagerDto(8, 10, totalBoardNum, pageNo);
		if(marketAlign != null) {
			pager.setAlign(marketAlign.getAlign());
			pager.setCategory(marketAlign.getCategory());
			pager.setSearchContent(marketAlign.getSearchContent());
			pager.setSearchType(marketAlign.getSearchType());
		}
		
		//market ????????? ?????? ????????????
		model.addAttribute("pager", pager);
		
		log.info("pn : " + pageNo);

		//????????? ??????
		List<MarketBoardDto> marketboards = marketBoardService.getMarketBoards(pager);
		log.info("-------------------");
		log.info(marketboards);
		model.addAttribute("marketBoards", marketboards);
		
		//????????? ?????? ????????????
		model.addAttribute("pageNo", pageNo);
		
		return "/community/market/list";
	}
	
	//??????????????? ???????????? ?????????, ???????????? index??? ???????????? ?????? ????????????
	@RequestMapping("/market/getMarketImage")
	public void getMarketImage(HttpServletResponse res, int marketNo, String img) throws IOException {
		List<MarketFileDto> files = marketBoardService.selectImageFileByMarketNo(marketNo);
		int num = Integer.parseInt(img);
		byte[] temp = files.get(num).getImageFileData();
		InputStream is = new ByteArrayInputStream(temp);
		IOUtils.copy(is, res.getOutputStream());
   	    
	}
	
	//view??????????????? ?????? ?????? ?????????.
   @RequestMapping(value="/market/checkLike", produces = "application/json; charset=UTF-8")
   @ResponseBody
   public String checkLike(String id, String type, String marketNo) {
	   LikeListDto lld = new LikeListDto();
	   
	   lld.setLikeListNo(Integer.parseInt(marketNo));
	   lld.setLikeType(type);
	   lld.setLikeUserId(id);
	   
	   String json;
	   JSONObject jsonObject = new JSONObject();
	   int check = takeService.selectLikeListByBuildingNo(lld);
	   
	   if(check == 1) {
		   jsonObject.put("likeCheck", "like");
	   }else {
		   jsonObject.put("likeCheck", "noLike");
	   }
	   json = jsonObject.toString();
	   return json;
   }
   
	
   //?????? ???????????? ???????????? ??? ?????????. 
   @RequestMapping(value="/market/setLikeLists", produces = "application/json; charset=UTF-8")
   @ResponseBody
   public void setLikeLists(String check, String id, String type, int marketNo, String likeCnt) {
	   LikeListDto lld = new LikeListDto();
	   
	   lld.setLikeListNo(marketNo);
	   lld.setLikeType(type);
	   lld.setLikeUserId(id);
	   
	   MarketBoardDto mdt = new MarketBoardDto();
	   mdt.setMarketLikeCount(Integer.parseInt(likeCnt));
	   mdt.setMarketNo(marketNo);
	   
	   //????????? ?????? ????????? ??????
	   if(check.equals("before")) {
		   takeService.insertLikeLists(lld);
		   marketBoardService.updateLikeCount(marketNo); //????????? ??? ????????????
		   
	   }else { //????????? ?????? ????????? ??????
		   takeService.deleteLikeLists(lld);
		   marketBoardService.updateLikeCountDown(marketNo); //????????? ??? ????????????
	   }
   }

	// ????????? ?????? ?????????
	@RequestMapping("/market/marketDetail")
	public String marketDetail(
			HttpSession session, 
			int marketNo, 
			Model model,
			@RequestParam(value="pageNo", required=false) String pageNo,
			@RequestParam(value="category", required=false) String category,
			@RequestParam(value="align", required=false) String align,
			@RequestParam(value="searchContent", required=false) String searchContent,
			@RequestParam(value="searchType", required=false) String searchType) {	

		//????????? ??????
		marketBoardService.setUpdateHitCount(marketNo);
		
		//marketBoardDto ?????? ????????????
		MarketBoardDto marketBoardDto = marketBoardService.getMarketBoard(marketNo); 
		
		//????????? ?????? ?????? ?????? 
		String tempContent = marketBoardDto.getMarketContent();
		tempContent = org.springframework.web.util.HtmlUtils.htmlEscape(tempContent);
		tempContent = tempContent.replaceAll("<br/>", "\n");
		marketBoardDto.setMarketContent(tempContent);
		
		//????????? , ??????
		String price = marketBoardDto.getMarketPrice();
		DecimalFormat formatter = new DecimalFormat("###,###");
		price = formatter.format(Long.parseLong(price));
		marketBoardDto.setMarketPrice(price);
		
		//marketBoardDto ?????? model??? ??????
		model.addAttribute("marketBoardDto", marketBoardDto);
		model.addAttribute("pageNo",pageNo);
		
		log.info("dpn : " + pageNo);
		log.info("mn : " + marketNo);
		
		//marketFileDto ?????? model??? ??????
		List<MarketFileDto> marketFileList = marketBoardService.selectImageFileByMarketNo(marketNo);
		model.addAttribute("marketFileList", marketFileList);
		
		//?????? ???????????? ????????? id model??? ??????
		String SessionUserid = (String) session.getAttribute("sessionUserId");
		model.addAttribute("sessionUserId", SessionUserid);
		
		//????????????, ?????????, ???????????? model??? ??????
		model.addAttribute("category", category);
		model.addAttribute("align", align);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchContent", searchContent);

		return "/community/market/view";
	}
	
	

	//????????? ???????????? ????????? ?????? ????????? ???
	@RequestMapping("/market/gotoInsert")
	public String marketInsert(HttpSession session) {
		if(session.getAttribute("sessionUserId") == null) {
			return "redirect:/index/loginForm";
		} else {
			return "/community/market/insert";			
		}
	}
	
	@GetMapping("/market/update")
	public String marketUpdate(int marketNo, Model model) {
		//?????? ??? ?????? ?????? ????????????
		MarketBoardDto marketBoardDto = marketBoardService.getMarketBoard(marketNo);
		List<MarketFileDto> marketFiles = marketBoardService.selectImageFileByMarketNo(marketNo);
		
		//????????? ????????? model??? ????????? jsp?????? ??????
		model.addAttribute("marketBoardDto", marketBoardDto);
		model.addAttribute("marketFiles", marketFiles);
		model.addAttribute("marketFilesSize", marketFiles.size());
		
		return "/community/market/update";
	}

	//?????????????????? ????????? ???????????? ????????????!
	@RequestMapping("/market/getImageByteArrayToFile")
	public void getImageByteArrayToFile(HttpServletResponse res, int marketNo, int img, 
			@RequestHeader("User-Agent") String userAgent) throws IOException {
		List<MarketFileDto> marketFiles = marketBoardService.selectImageFileByMarketNo(marketNo);
		
		//img??? marketFiles??? index??????.
		
		String contentType = marketFiles.get(img).getAttachType();
		String originalFilename = marketFiles.get(img).getAttachOriginalName();
		
		res.setContentType(contentType);
		
		//??????????????? ???????????? ????????? ??????
		if(userAgent.contains("Trident") || userAgent.contains("MSIE")) {
			//IE ??????????????? ??????
			originalFilename = URLEncoder.encode(originalFilename, "UTF-8");
		} else {
			//??????, ??????, ???????????? ??????
			originalFilename = new String(originalFilename.getBytes("UTF-8"), "ISO-8859-1");
		}
		res.setHeader("Content-Disposition", "attachment; filename=\"" + originalFilename + "\"");
		
		FileCopyUtils.copy(new ByteArrayInputStream(marketFiles.get(img).getImageFileData()), res.getOutputStream());		
	}
	
	@RequestMapping("/market/view")
	public String marketView() {
		return "/community/market/view";
	}

	@GetMapping("/market/marketViewtoList")
	public String marketViewToList(int marketNo) {
		return "redirect:/community/market/list";
	}

	// ????????? ?????? ??????
	@PostMapping("/market/insertMarketContent")
	public String insertMarketContent(HttpServletRequest request,
    		HttpSession session,
    		@RequestPart("attach_file") List<MultipartFile> files,
 		    Model model) throws IOException {
		
	   String userId = (String)session.getAttribute("sessionUserId");
	   String category = request.getParameter("category");
	   
	   MarketBoardDto marketBoardDto = new MarketBoardDto();
	   marketBoardDto.setMarketCategory(category);
	   marketBoardDto.setMarketContent(request.getParameter("content"));
	   marketBoardDto.setMarketPrice(request.getParameter("price"));
	   marketBoardDto.setMarketTitle(request.getParameter("title"));
	   marketBoardDto.setMarketWriter(userId);
	   
	    int cnt = marketBoardService.insertMarket(marketBoardDto);
	    
	    //???????????? ??????
	    if(cnt > 0) {
	       if(files.size() != 0) {
	          for(MultipartFile m : files) {
	             String saveFilename = new Date().getTime()+"-"+m.getOriginalFilename();

	             MarketFileDto marketFileDto = new MarketFileDto();
	             marketFileDto.setAttachOriginalName(m.getOriginalFilename());            
	             marketFileDto.setAttachSaveName(saveFilename);
	             marketFileDto.setAttachType(m.getContentType());
	             marketFileDto.setImageFileData(m.getBytes());
	             marketFileDto.setMarketNo(marketBoardDto.getMarketNo());
	             marketBoardService.insertMarketFile(marketFileDto);
	             
	          }
	       }   
	    }
	   return "redirect:/community/market/list";
	}
	
	// ????????? ?????? ??????
    @RequestMapping("/market/updateMarketContent")
    @ResponseBody
	public String updateMarketContent(HttpServletRequest request,
			@RequestPart(value="attach_file", required=false) List<MultipartFile> files,
 		    @RequestParam(value="deleteDBImgBySeq") String deleteDb) throws IOException {
	   
	   		String result ="?????? ????????? ?????????????????????.";
		
		   String category = request.getParameter("category");
		   int marketNo = Integer.parseInt(request.getParameter("marketNo"));
		   MarketBoardDto marketBoardDto = new MarketBoardDto();
		   marketBoardDto.setMarketCategory(category);
		   marketBoardDto.setMarketNo(marketNo);
		   marketBoardDto.setMarketTitle(request.getParameter("title"));
		   marketBoardDto.setMarketPrice(request.getParameter("price"));
		   marketBoardDto.setMarketContent(request.getParameter("content"));
		   
		   String[] deleteImgNoList = deleteDb.split(",");
		   log.info("deleteDb"+deleteDb);
		   log.info("deleteImgNoList: " + deleteImgNoList.length);
		   	   
		   if((!deleteDb.equals(""))) {
			   for(String deleteImgNo : deleteImgNoList) {
				   log.info("deleteImgNoList??????: "+deleteImgNo);
				   int imgNo = Integer.parseInt(deleteImgNo);
				   marketBoardService.deleteImageByFileNo(imgNo);
			   }
		   }

		   //???????????? ????????????(?????? ????????? ???????????? ?????? ??????.)
		   marketBoardService.updateMarketBoard(marketBoardDto);
		   
			//???????????? ??????
			if(files != null) {
			   for(MultipartFile m : files) {
			      String saveFilename = new Date().getTime()+"-"+m.getOriginalFilename();
			
			      MarketFileDto marketFileDto = new MarketFileDto();
			      marketFileDto.setAttachOriginalName(m.getOriginalFilename());            
			      marketFileDto.setAttachSaveName(saveFilename);
			      marketFileDto.setAttachType(m.getContentType());
			      marketFileDto.setImageFileData(m.getBytes());
			      marketFileDto.setMarketNo(marketNo);
			      
			      //DB marketFiles??? file ??????
			      marketBoardService.insertMarketFile(marketFileDto);
			   }
			}
		return result;
	}

	// ????????? ?????? ??????
    @RequestMapping("/market/marketInsertCancle")
    public String marketInsertCancle() {
       return "redirect:/community/market/list";
    }
    
	//??? ?????? ?????? 
	@GetMapping(value="/market/deleteMarketBaord", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String deleteMarketBaord(int marketNo) {
		//cascade ???????????? market?????? ??? ????????? ??????????????? ?????? ?????????!
		marketBoardService.deleteMarketBoardByMarketNo(marketNo);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("result", "success");
		String json = jsonObject.toString(); //json ?????? ??????.
		
		return json;
	}
	
	//????????????
	@GetMapping(value="/market/updateSaleYn", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String updateSaleYn(int marketNo) {
		marketBoardService.updateSaleYn(marketNo);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("result", "success");
		String json = jsonObject.toString(); //json ?????? ??????.
		
		return json;
	}
 
	// ??????????????? - list ---------------------------------------------------------------------------------------------------------
	@GetMapping("/notice/list")
	//@mypageLoginCheck
	public String noticeList(@RequestParam(value="pageNo", defaultValue = "1") int pageNo, Model model, HttpSession session) { //???????????? 1??????????????? ????????????!
		
		//Notice ????????? ????????? ?????? ????????????
		int totalBoardNum = noticeService.totalCount();
		PagerDto pager = new PagerDto(10, 10, totalBoardNum, pageNo);
		model.addAttribute("pager", pager);
		if(session.getAttribute("sessionUserId") != null) {
			model.addAttribute("sessionMid", session.getAttribute("sessionUserId").toString());
		}		
		
		//????????? ??????
		List<NoticeBoardDto> noticeboards = noticeService.getNoticeBoardByPage(pager);
		model.addAttribute("noticeboards", noticeboards);
		
		return "/community/notice/list";
	}

	// ?????? ?????? ?????????
	@GetMapping("/notice/noticeDetail")
	public String noticeDetail(int noticeNo, Model model, HttpSession session) {
		
		//????????? 1 ?????????
		noticeService.updateHitCount(noticeNo);
		
		//noticeBoardDto ?????? DB?????? ????????????
		NoticeBoardDto noticeBoardDto = noticeService.getNoticeBoardByNoticeNo(noticeNo);
		
		//????????? ?????? ?????? ??????
		String tempContent = noticeBoardDto.getNoticeContent();
		tempContent = org.springframework.web.util.HtmlUtils.htmlEscape(tempContent);
		tempContent = tempContent.replaceAll("\n", "<br/>");
		noticeBoardDto.setNoticeContent(tempContent);
		
		//noticeBoardDto ?????? model??? ??????
		model.addAttribute("noticeboard", noticeBoardDto);
		if(session.getAttribute("sessionUserId") != null) {
			model.addAttribute("sessionMid", session.getAttribute("sessionUserId").toString());
		}		
		
		return "/community/notice/view";
	}
	
	//???????????? ????????? ???????????? ??????
	@GetMapping("/notice/insert")
	public String noticeInsert(Authentication authentication) {
		String userId;
		
		//?????? ????????? ?????? ?????? ?????? >> ???????????? ?????? ?????? ?????????????????? ??????
		if(authentication != null) {
			UserCustom userCustom = (UserCustom)authentication.getPrincipal();
			userId = userCustom.getUsername();
		}else {	
			userId = null;
			return "redirect:/index/loginForm";
		}
		return "/community/notice/insert";
	}

	@RequestMapping("/notice/update")
	public String noticeUpdate(int noticeNo, HttpSession session, HttpServletRequest request, Model model) {
		NoticeBoardDto noticeBoardDto = noticeService.getNoticeBoardByNoticeNo(noticeNo);
		
		//noticeBoardDto ?????? model??? ??????
		model.addAttribute("noticeboard", noticeBoardDto);
		model.addAttribute("sessionMid", session.getAttribute("sessionUserId").toString());
		model.addAttribute("referer", request.getHeader("Referer"));
		return "/community/notice/update";
	}
	
	@RequestMapping("/notice/updateSave")
	public String updateSave(NoticeBoardDto notice, String referer) {
		noticeService.updateNoticeBoard(notice);
		return "redirect:"+referer;
	}

	// ????????? ?????? ??????
	@PostMapping("/notice/insertNoticeContent")
	public String insertNoticeContent(HttpServletRequest request,
    		@RequestPart(value="attach_file", required=false) List<MultipartFile> files,
 		    Authentication authentication) {
		
		//?????? ?????? ????????? ????????? ?????????
		String userId;
		UserCustom userCustom = (UserCustom)authentication.getPrincipal();
		userId = userCustom.getUsername();

		NoticeBoardDto noticeBoardDto = new NoticeBoardDto();
		noticeBoardDto.setNoticeTitle(request.getParameter("title"));
		noticeBoardDto.setNoticeContent(request.getParameter("content"));
		noticeBoardDto.setNoticeWriter(userId);
		
		noticeService.noticeBoardInsert(noticeBoardDto);

		return "redirect:/community/notice/list";
	}

	// ????????? ?????? ??????
	@RequestMapping("/notice/insertNoticeCancle")
	public String insertNoticeCancle() {
		return "redirect:/community/notice/list";
	}
	
	@RequestMapping("/notice/deleteNoticeBoard")
	@ResponseBody
	public String deleteNoticeBoard(int noticeNo) {
		noticeService.deleteNoticeBoard(noticeNo);
		return "success";
	}	
}