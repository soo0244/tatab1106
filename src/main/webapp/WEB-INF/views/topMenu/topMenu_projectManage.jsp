<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <!-- topMenu_projectManage.css-->
    <link rel="stylesheet" type="text/css" href="resources/css/topMenu/topMenu_projectManage.css?ver=2">
    
    <!-- web font -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">

    <!-- topMenu_projectMenu.js -->    
    <script src="resources/js/topMenu/topMenu_projectManage.js?var=2"></script>
    <script>
    	$(document).ready(function() {
    		// projectManage overview 데이터 호출
    		$('#infoBtn').click(getProjectInfo);
    		$('.overviewBtn').click(getProjectInfo);
			
    		// memberList 조회
    		$('.membersBtn').click(getMemberList);
    	});
    	
    	function getProjectInfo() {
    		$.ajax({
    			url : "boardProjectManage.do",
    			type : "post",
    			 
    			success : function(data) {
    				// console.log(data);
    				
    				$('.projectTitle').html(data.project_name);
    				$('.projectNames').val(data.project_name);
    				$('.projectDescription').val(data.project_comment);
    			}
			})
			return false;
    	}
    	
    	function getMemberList() {
			$.ajax({
				url : "memberList.do",
				type : "post",
				
				success : function(data) {
					$('.memberDiv').empty();
					for(i=0; i<data.length; i++) {
	    				var tag1 = '<div class="memberList"><div class="memberName">';
	    				var tag2 = '</div><div class="memberId">';
	    				var tag3 = '</div></div>'  
	    					
	    				var tag = tag1 + data[i].login_name + tag2 + data[i].login_email + tag3;
	    				
	    				$(tag).hide().appendTo('.memberDiv').show();
					}
					
				}
			})
			return false;
		}
    	
    	// done 버튼 클릭시 projectVO update
		function update() {
// 			$('.updateProjectVO').submit();
			$.ajax({
				url:'updateProjectVO.do',
				type:'post',
				data:{'projectDescription':$('#projectDescription').val(),'projectName':$('#projectName').val()},
				success:function(result){
	        				alert('수정되었습니다.');
	        				$('.projectTitle').html(result.project_name);
	        				$('.projectNames').attr("value", result.project_name);
	        				$('.projectDescription').val(result.project_comment);
				}
			})
			return false;
		}
    	
    	// 유저 초대하기
    	function addUser() {
    		if($('.addMemberInput').val().length == 0) {
				alert('아이디를 입력해주세요');
    			false;
    		} else {
			//	$('.addUser').submit();
    			// ajax로 값 넘기기 - 유저 추가
    			$.ajax({
    				url:'addUser.do',
    				type:'post',
    				data:{'user':$('#addMemberInput').val()},
    				success:function(result){
    					if(result == 'true'){
    						getMemberList();
    						alert('사용자가 추가되었습니다.');
    					}else {
    						alert('없는 아이디입니다.');
    					}
    				}
    			})
    			
    			// ajax로 값 넘기기 - 액티비티 추가
    			$.ajax({
    				url : "addUserActivity.do",
    				data : {'login_email0': $('.addMemberInput').val()
    						},
    				type : "get",
    				success : function() {
    					}
    			});
    		}
    		return false;
    	}
    	
    	function deleteProject() {
    		if(confirm("프로젝트를 삭제하시겠습니까?") == true) {
	    		location.href="deleteProject.do";
    		}
			return false;    		
    	}
    </script>
       
    <body>
        <div class="manageWrapper">
                   <div class="title2">
                       <div class="name2">
                           <a id="projectTitle" class="projectTitle manage-a"></a>
                       </div>
                       <div class="close1">
                           <a class="manage-a"><i class="fas fa-times "></i></a>
                       </div> 
                       <div class="trash" onclick="deleteProject()">
                           <a class="manage-a"><i class="fas fa-trash-alt"></i></a>
                       </div>
                   </div>

                   <div class="menu">
                       <div class="overviewBtn"><a class="manage-a">Overview</a></div>
<!--                        <div class="checklistBtn"><a class="manage-a">Checklist</a></div> -->
                       <div class="membersBtn"><a class="manage-a">Members</a></div>
                   </div>
                    
                   <div class="content overview">
						<form method="post" class="updateProjectVO" action="updateProjectVO.do">
	                       <div class="pj">
	                           <div class="pjName">
	                               Project name
	                           </div>
	                           <div class="pjInput">
                                   <input class="projectNames" id="projectName" name="projectName" type="text" style="width:410px; height:50px;" >
	                           </div>
	                       </div>
	                       <div class="dpt">
	                           <div class="dptName">
	                               Project Description
	                           </div>
	                           <div class="dptdpt">
	                              <textarea class="projectDescription" id="projectDescription" name="projectDescription" style="width:410px; height:200px; resize:none;">
								  </textarea>
								</div>
	                       </div>
	               		</form>	        
                    </div>
          </div>
                   
<!--                    Checklist 메뉴 -->
<!--                    <div class="content checklist"> -->
<!--                        <div class="pj">  -->
<!--                            <div class="pjName"> -->
<!--                                checklist -->
<!--                            </div> -->
<!--                            <div class="pjInput"> -->
<!--                                <form> -->
<!--                                    <input type="text" style="width:300px; height:50px;" placeholder="ABC"> -->
<!--                                </form>	 -->
<!--                            </div> -->
<!--                        </div> -->

<!--                        <div class="dpt"> -->
<!--                            <div class="dptName"> -->
<!--                                Project Discription -->
<!--                            </div> -->
<!--                            <div class="dptdpt"> -->
<!--                               <input type="text" style="width:300px; height:200px;" placeholder="DB에서 가져올 내용"> -->
<!--                            </div> -->
<!--                        </div> -->
<!--                    </div> -->
<!--                    Checklist 메뉴 -->
                   
<!--                    Members 메뉴 -->
                   <div class="content members">
                        <div class="pjName">
	                       Members
                        </div>
					   
					    <div class="memberDiv">
					   		memberList add
			 	   		</div>
			 		   	
			 		   	<form class="addUser" action="addUser.do" method="post">
				 		    <div class="addUser">
					   			<input type="text" id="addMemberInput" class="addMemberInput" name ="user" placeholder="추가할 아이디를 입력해주세요">
							    <div class="addUserBtn" onclick="addUser()">
									<a id="invite">Invite</a>
							    </div>
						    </div>
				    	</form> 
                   </div>
<!-- 				   Members 메뉴 -->

                 

                   <div class="footer">
                       <div>
                           <div class="done">
                               <a onclick="update()">done</a>
                           </div>
                       </div>
                   </div>
    </body>
    
    
</html>