<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko"> 
<head>
    <title>TRACER - 캘린더</title>
    
    <!-- Meta -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <meta name="description" content="Portal - Bootstrap 5 Admin Dashboard Template For Developers">
    <meta name="author" content="Xiaoying Riley at 3rd Wave Media">    
    <link rel="shortcut icon" href="favicon.ico"> 
    
    <!-- FontAwesome JS-->
    <script defer src="assets/plugins/fontawesome/js/all.min.js"></script>
    
    <!-- App CSS -->  
    <link id="theme-style" rel="stylesheet" href="assets/css/portal.css">

<script src="${path}/a00_com/dist/index.global.js"></script>
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script src="/gantt/codebase/dhtmlxgantt.js?v=8.0.9"></script>
<link rel="stylesheet" href="/gantt/codebase/dhtmlxgantt.css?v=8.0.9">
<style>
		#calendar {
	max-width:960px;
	margin: 0 auto;
	}
	</style>
</head> 

<body class="app">   	
<jsp:include page="/headerSidebar.jsp"/> 
    <div class="app-wrapper">
	    
	    <div class="app-content pt-3 p-md-3 p-lg-4">
		    <div class="container-xl">
			    
			    <div class="row g-3 mb-4 align-items-center justify-content-between">
				    <div class="col-auto">
			            <h1 class="app-page-title mb-0">캘린더</h1>
			            <br>
			            <select class="calendar-opts">
			            	<option>프로젝트 일정</option>
			            	<option>팀 일정</option>
			            	<option>개인 일정</option>
			            </select>
				    </div>
			    </div><!--//row-->
			   
			    
		<div class="container">
			<div id="calendar"></div>
		</div>
		
		</div>
		<div id="showModel" data-toggle="modal" data-target="#calModal"></div>
	<!--showModel 클릭시, 연동되어 있는 모달창이 로딩..
		특정한 기능에 의해서 모달창을 로딩할려면, showModel를 강제로 클릭과 동일한
		코드로 처리. $("#showModel").click() 실제 클릭이 아니고 코드로 이벤트
		수행과 동일한 효과..
	 -->
	<div class="modal fade" id="calModal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalCenterTitle"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalTitle">타이틀</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close" id="clsBtn">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<%--
				<style>
.input-group-text{width:100%;background-color:linen;
		color:black;font-weight:bolder;}
.input-group-prepend{width:35%;}				
				</style>
				 --%>
				<div class="modal-body">
					<form id="frm02" class="form" method="post">
						<input type="hidden" name="id" value="0"/>
						<div class="input-group mb-3">	
							<div class="input-group-prepend ">
								<span class="input-group-text  justify-content-center">일정명</span>
							</div>
							<input name="title" placeholder="일정 입력"  class="form-control" />	
						</div>	
						<div class="input-group mb-3">	
							<div class="input-group-prepend ">
								<span class="input-group-text  justify-content-center">담당자</span>
							</div>
							<input name="writer" placeholder="담당자 입력"  class="form-control" />	
						</div>	
						<div class="input-group mb-3">	
							<div class="input-group-prepend ">
								<span class="input-group-text  justify-content-center">시 작(일/시)</span>
							</div>
							<input id="start"  class="form-control" /><!-- 화면에 보일 날짜/시간.. -->	
							<input name="start" type="hidden"   />	<!-- 실제 저장할 날짜/시간 -->
						</div>	
						<div class="input-group mb-3">	
							<div class="input-group-prepend ">
								<span class="input-group-text  justify-content-center">종 료(일/시)</span>
							</div>
							<input id="end"  class="form-control" />	
							<input name="end" type="hidden"   />	
						</div>		
						<div class="input-group mb-3">	
							<div class="input-group-prepend ">
								<span class="input-group-text  justify-content-center">내용</span>
							</div>
							<textarea name="content" rows="5" cols="10" class="form-control"></textarea>			
						</div>																				
					</form>
				</div>
				<div class="modal-footer">
					<button id="regBtn" type="button" class="btn btn-primary">등록</button>				
					<button id="uptBtn" type="button" class="btn btn-info">수정</button>				
					<button id="delBtn" type="button" class="btn btn-warning">삭제</button>				
					<button id="clsBtn" type="button" class="btn btn-secondary"
						data-dismiss="modal">창닫기</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function() {
		
		var calendarEl = document.getElementById('calendar');

		var calendar = new FullCalendar.Calendar(calendarEl, {
			headerToolbar : {
				left : 'prev,next today',
				center : 'title',
				right : 'dayGridMonth,dayGridWeek'
			},
			initialDate : '2024-07-05', /*초기 로딩되는 날짜.*/
			navLinks : true, // can click day/week names to navigate views
			selectable : true,
			selectMirror : true,
			select : function(arg) { // 기본 일정 등록시, 처리되는 이벤트..
				$("#showModel").click() //강제이벤트 처리.
				console.log("# 캘린터 기본 속성 확인 #")
				console.log(arg)
				console.log(arg.startStr)
				console.log(arg.endStr)
				$("#modalTitle").text("일정 등록") 
				// 같은 모달창에서 상세와 등록 같이 처리하기에
				$("form")[0].reset()
				// 입력form의 내용을 초기화:이전 입력데이터/상세데이터 삭제 처리
				$("#regBtn").show()
				$("#uptBtn").hide()
				$("#delBtn").hide()
				// 같은 모달창(등록/상세)에서 등록버튼만 화성화 처리..
				$("#start").val(arg.start.toLocaleString())
				// 보이는 날짜 처리 형식
				$("[name=start]").val(arg.startStr)
				// 실제 저장할 날짜 처리 형식..
				$("#end").val(arg.end.toLocaleString())
				$("[name=end]").val(arg.endStr)
				
				calendar.unselect()
			},
			eventClick : function(arg) {
				console.log("# 상세 일정 #")
				console.log(arg.event)
				$("#modalTitle").text("일정상세")
				$("#regBtn").hide()
				$("#uptBtn").show()
				$("#delBtn").show()
				addForm(arg.event)
				$("#showModel").click()
				// 상세화면 - 수정/삭제
				/*
				if (confirm('Are you sure you want to delete this event?')) {
					arg.event.remove()
				}
				*/
			},
			eventDrop:function(arg){
				addForm(arg.event)
				ajaxFun("uptScheduleCalendar")
				$(".form")[0].reset()
			},
			eventResize:function(arg){
				addForm(arg.event)
				ajaxFun("uptScheduleCalendar")		
				$(".form")[0].reset()
			},
			editable : true,
			dayMaxEvents : true, // allow "more" link when too many events
			events : function(info, successCallback, failureCallback){
				// callList.do
				$.ajax({
					type : "POST",
					url: "getScheduleCalendarList",
					dataType: "json",
					success: function(data){
						console.log(data) // 서버에서 받은 데이터(controller)
						calendar.removeAllEvents() // 현재 기본 일정 데이터 초기화(삭제처리)
						successCallback(data) // data.모델명(json형식데이터)
						// d.addAttribute("calList", service.getFullCalendarList());
					}
				})	
			},
			error:function(err){
				console.log(err)
				failureCallback(err)
			}
		});
		
		function addForm(event){
			$("form")[0].reset()
			// 기본 설정값으로 설정이 가능한 데이터
			$("[name=id]").val(event.id)
			$("[name=title]").val(event.title)

			// 전달되는 데이터와 호출하여 보이는 데이터 차이가 있는 데이터
			$("[name=start]").val(event.startStr)
			$("#start").val(event.start.toLocaleString())
			if(event.end==null){
				$("[name=end]").val(event.startStr)
				$("#end").val(event.start.toLocaleString())			
			}else{
				$("[name=end]").val(event.endStr)
				$("#end").val(event.end.toLocaleString())				
			}
			// fullcalendar 자체에서는 없지만 사용자에 의해서 필요한 추가 속성..
			$("[name=writer]").val(event.extendedProps.writer)
			$("[name=content]").val(event.extendedProps.content)
		}
		calendar.render();
		$("#regBtn").click(function(){
			if(confirm("등록하시겠습니까?")){
				ajaxFun("insScheduleCalendar")
			}
		})	
		
		$("#clsBtn").click(function(){
			console.log('초기화')
			$(".form")[0].reset()
			$("#showModel").click()
		})
		
		$("#uptBtn").click(function(){
			if(confirm("수정하시겠습니까?")){
				ajaxFun("uptScheduleCalendar")
			}
		})	
		$("#delBtn").click(function(){
			if(confirm("삭제하시겠습니까?")){
				ajaxFun("delScheduleCalendar")
			}
		})	
		function ajaxFun(url){
			$.ajax({
				type :"POST",
				dataType:"json",
				url:url,
				data:$(".form").serialize(),
				success:function(data){
					// 등록이 완료된 후,  등록성공/실패 메시지와 다시 등록이 된 내용을 적용한
					// 화면을 로딩하기 위한 처리..
					alert(data.msg)
					calendar.removeAllEvents()
					var events = data.res.map(function(item){
						return{
							allDay: item.allDay,
							backgroundColor: item.backgroundColor,
							content: item.content,
							end: item.end,
							id: item.id,
							start: item.start,
							textColor: item.textColor,
							title: item.title,
							url: item.url,
							writer: item.writer,	
						}
					})
					console.log(events)
					calendar.addEventSource(events)
					if(data.msg.indexOf('수정')==-1){
						$("#clsBtn").click()
					}
				},
				error:function(err){
					console.log(err)
				}
			})
		}		
		
		
	});
	</script>  
				
				
				
	    </div><!--//app-content-->
	    
	   
	    
    </div><!--//app-wrapper-->    					

 
    <!-- Javascript -->          
    <script src="assets/plugins/popper.min.js"></script>
    <script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>  
    
    
    <!-- Page Specific JS -->
    <script src="assets/js/app.js"></script> 
</body>
</html> 

