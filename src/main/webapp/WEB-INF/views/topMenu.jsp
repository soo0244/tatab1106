<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
<!--     <script src="resources/js/jquery-3.3.1.min.js"></script> -->
    <script src="resources/js/jquery-3.3.1.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	
	
     <link rel="stylesheet" type="text/css" href="resources/css/board/boardcss.css">
    <!-- topMenu.css -->
    <link rel="stylesheet" type="text/css" href="resources/css/topMenu/topMenu.css?ver=2">
    
    
    
    <!-- topMenu.js -->
    <script src="resources/js/topMenu/topMenu.js?ver=1"></script>
    
    </head>
    
    <body>   
       <table border="1px" style="width:100%; height:50px;">
            <tr>
                <td style="width:13%">
                    <i class="far fa-calendar-alt"></i>
                    tatab
                </td>
                <td style="width:7%" id="projectsBtn">
                   
                    <i class="fas fa-bolt"></i>
                    &nbsp; 
                    ${projectName }
                    &nbsp; 
                    <i class="fas fa-angle-down"></i>
                </td>
                <td style=width:5%  id="infoBtn">
                   <i class="fas fa-info"></i> 
                </td>
                <td style=width:50%>
                </td>
                <td style=width:5% >
                    <table class="activeBtn">
                        <tr>
                            <td align="center">
                                9
                            </td>
                            <td rowspan="2">
                                <i class="fas fa-angle-down"></i>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Active
                            </td>
                        </tr>
                    </table>
                </td>
                <td style=width:5%>
                    <i class="far fa-clock"></i>
                </td>
                <td style=width:5% class="activityBtn">
                <i class="fas fa-at"></i>
                    <div onclick="history.back();" class="page_cover">   </div>
                    <div id="menu"> 
                    <div onclick="history.back();" class="activityClose"></div>
                    <!-- activity.jsp-->
                  	  <jsp:include page="/WEB-INF/views/topMenu/topMenu_activity.jsp"/>
                    </div>
                    
                </td>
                <td style=width:5%>
                    <i class="fas fa-cog"></i>
                </td>
                <td style=width:5%>
                    <i class="fas fa-user-circle"></i>
                </td>
            </tr>
        </table>
        
        <!-- kanban board -->
        <div class="kanban-container2">

            <!-- kanban-col end -->
            <!-- kanban 시작 -->
            <div class="kanban-board colsortable">
                
                  <!-- kanban-col section start -->
               <jsp:include page="/WEB-INF/views/kanban_col.jsp"/>
                   <!-- kanban-col end -->
                   
                <a href="#" id="col-add-box"><i class="fas fa-plus-circle add col-add-btn"></i></a>
            <div id="endline"></div>
            </div>
            <!-- kanban 끝 -->
        </div>
        <!-- kanban board -->
        
        <!-- projects Modal -->
        <div id="projectsModal" class="projectsmodal">
          <div class="projects-modal-content">
          	<jsp:include page="/WEB-INF/views/topMenu/topMenu_projects.jsp"></jsp:include>
          </div>
        </div>
        <!-- projects Modal -->
    
        <!-- projectManage Modal -->
        <div id="manageModal" class="manageModal">
            <!-- Modal content -->
            <div class="manage-modal-content">
            	<jsp:include page="/WEB-INF/views/topMenu/topMenu_projectManage.jsp"></jsp:include>
            </div>
        </div>
        <!-- projectManage Modal -->

    </body>
    

    <!-- script 참조 -->
    <script src='http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js'></script>
    <script src="resources/js/jquery-ui.js"></script>
    <script src="resources/js/jquery-ui.min.js"></script>
    <script src="resources/js/board/boardjs.js?ver=3"></script>
    
</html>