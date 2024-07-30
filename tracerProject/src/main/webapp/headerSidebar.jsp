  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="messages"/>
  <script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function(){
	/* if('${user_info.email}'==''||'${user_info.email}'==null){
		alert('세션이 만료되었습니다. 로그인 페이지로 이동합니다.')
		location.href='login'
	} */
	$("form").on('keydown', function(event) {
	      if (event.key === 'Enter') {
	        event.preventDefault();
	      }
	    })
	let isWorking = isAlready('${user_info.email}')
	let addEmail = ['${user_info.email}']
	let nickname
	let auth = ['admin']
	let count = 0
	$(".newProject").click(function(){
		if(!isAlready){
			$(".newPrjFrm").show(400)
		}else{
			alert('이미 작업중입니다.')
		}
	})
	
	$(".clsBtn").click(function(){

		$("#inTeamList").html(
		"참여 인원<br>"
        +"<p>닉네임 : ${user_info.nickname} / 권한 : admin</p>"
   		)
   		addEmail = ['${user_info.email}']
		count = 0
		auth = ['admin']
		$(".newPrjFrm").hide(400)
		$(".newPrjFrm input").val("")
		$(".newPrjFrm textarea").val("")
	})
	$(".innerCls").click(function(){
		$('.authSel').prop('selectedIndex', 0);
		$(".emailSch").hide(400)
		addEmail.pop()
		$("input[name=invEmail]").val("")
	})
	
	$("#schEmailBtn").click(function(){
		let email = $("[name=invEmail]").val()
		$.ajax({
			data: {email:email},
			url: 'alreadyWorking',
			type: 'POST',
			success: function(data){
				if(!data){
					$.ajax({
						data: $("form").serialize(),
						url: 'schByEmail',
						type: 'POST',
						success: function(data){
							if(data.nickname==null)
								alert('해당 사용자를 초대할 수 없습니다.')
							else if('${user_info.email}'==$("[name=invEmail]").val()||
									dupEmailChk($("[name=invEmail]").val())){
								alert('이미 참가가 되어있는 사용자입니다.')
							}
							else{
								$(".invNickname").html(data.nickname+"님<br> 초대")
								nickname = data.nickname
								$(".emailSch").show(400)
								addEmail.push(data.email)
								console.log(data.email)
							}
						},
						error: function(err){
							console.log(err)
						}
					}) 
				}else	alert('이미 작업 중입니다.')
			},
			error: function(err){
				console.log(err)
			}
		}) 
	})
	
	$(".inviteBtn").click(function(){

		if($("[name=auth]").val()=="")
			alert('권한을 선택해주세요')
		else{
			auth.push($("[name=auth]").val())
			console.log(auth)
			console.log(addEmail)
			$("#inTeamList").append("<p class='team"+(count++)+
					"'>닉네임 : "+nickname+" / 권한 : "+auth[auth.length-1]+"</p>")
			$("input[name=invEmail]").val("")
	        $(".emailSch").hide(400)
		}
	})
	$(".insNewPrjBtn").click(function(){
		createPrj(auth, addEmail)
		$(".clsBtn").click()
	})
	$(".newPrjFrm").hide(400)
	function dupEmailChk(val){
		let isDup = false
		addEmail.forEach(function(el){
			if(el==val){
				isDup = true;
			}
		})
		return isDup;
	}
	function createPrj(auth, email){
		$.ajax({
			data: $("form").serialize(),
			url: 'createPrj',
			type: 'POST',
			success: function(data){
				console.log(data)
				alert(data)
				getCurrPid(auth, email)
			},
			error: function(err){
				console.log(err)
			}
		}) 
	}		
	function createPrjTeam(auth, email, pid){
		insData = email
		auth.forEach(function(el, idx){
			$.ajax({
				data: {email:insData[idx], auth:el, pid:pid},
				url: 'createPrjTeam',
				type: 'POST',
				success: function(data){
					console.log(data)
				},
				error: function(err){
					console.log(err)
				}
			}) 
		})
		
	}
	function getCurrPid(auth, email){
		$.ajax({
			url: 'getCurrPid',
			type: 'POST',
			success: function(data){
				console.log(data)
				createPrjTeam(auth, email, data)
			},
			error: function(err){
				console.log(err)
			}
		}) 
	}
	function isAlready(email){
		let result = false
		$.ajax({
			data: {email:email},
			url: 'alreadyWorking',
			type: 'POST',
			success: function(data){
				if(data){
					console.log
					result = data
				}
			},
			error: function(err){
				console.log(err)
			}
		}) 
		return result
	}
})
</script>
    <header class="app-header fixed-top">	   	            
    <div class="app-header-inner">  
        <div class="container-fluid py-2">
            <div class="app-header-content"> 
                <div class="row justify-content-between align-items-center">
                    <div class="col-auto">
                        <a id="sidepanel-toggler" class="sidepanel-toggler d-inline-block d-xl-none" href="#">
                            <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 30 30" role="img"><title>Menu</title><path stroke="currentColor" stroke-linecap="round" stroke-miterlimit="10" stroke-width="2" d="M4 7h22M4 15h22M4 23h22"></path></svg>
                        </a>
                    </div><!--//col-->
                    <div class="search-mobile-trigger d-sm-none col">
                        <i class="search-mobile-trigger-icon fa-solid fa-magnifying-glass"></i>
                    </div><!--//col-->
                    <div class="app-search-box col">
                        <form class="app-search-form">   
                            <input type="text" placeholder="<fmt:message key='search.placeholder'/>" name="search" class="form-control search-input">
                            <button type="submit" class="btn search-btn btn-primary" value="Search"><i class="fa-solid fa-magnifying-glass"></i></button> 
                        </form>
                    </div><!--//app-search-box-->
                    <div class="app-utilities col-auto">
                        <div class="app-utility-item app-notifications-dropdown dropdown">    
                            <a class="dropdown-toggle no-toggle-arrow" id="notifications-dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false" title="Notifications">
                                <!--//Bootstrap Icons: https://icons.getbootstrap.com/ -->
                                <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-bell icon" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2z"/>
                                    <path fill-rule="evenodd" d="M8 1.918l-.797.161A4.002 4.002 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4.002 4.002 0 0 0-3.203-3.92L8 1.917zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5.002 5.002 0 0 1 13 6c0 .88.32 4.2 1.22 6z"/>
                                </svg>
                                <span class="icon-badge">3</span>
                            </a><!--//dropdown-toggle-->
                            <div class="dropdown-menu p-0" aria-labelledby="notifications-dropdown-toggle">
                                <div class="dropdown-menu-header p-3">
                                    <h5 class="dropdown-menu-title mb-0"><fmt:message key='notifications.title'/></h5>
                                </div><!--//dropdown-menu-title-->
                                <div class="dropdown-menu-content">
                                    <div class="item p-3">
                                        <div class="row gx-2 justify-content-between align-items-center">
                                            <div class="col-auto">
                                                <img class="profile-image" src="assets/images/profiles/profile-1.png" alt="">
                                            </div><!--//col-->
                                            <div class="col">
                                                <div class="info"> 
                                                    <div class="desc">Amy shared a file with you. Lorem ipsum dolor sit amet, consectetur adipiscing elit. </div>
                                                    <div class="meta"> 2 hrs ago</div>
                                                </div>
                                            </div><!--//col--> 
                                        </div><!--//row-->
                                        <a class="link-mask" href="notification"></a>
                                    </div><!--//item-->
                                    <div class="item p-3">
                                        <div class="row gx-2 justify-content-between align-items-center">
                                            <div class="col-auto">
                                                <div class="app-icon-holder">
                                                    <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-receipt" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                                        <path fill-rule="evenodd" d="M1.92.506a.5.5 0 0 1 .434.14L3 1.293l.646-.647a.5.5 0 0 1 .708 0L5 1.293l.646-.647a.5.5 0 0 1 .708 0L7 1.293l.646-.647a.5.5 0 0 1 .708 0L9 1.293l.646-.647a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .801.13l.5 1A.5.5 0 0 1 15 2v12a.5.5 0 0 1-.053.224l-.5 1a.5.5 0 0 1-.8.13L13 14.707l-.646.647a.5.5 0 0 1-.708 0L11 14.707l-.646.647a.5.5 0 0 1-.708 0L9 14.707l-.646.647a.5.5 0 0 1-.708 0L7 14.707l-.646.647a.5.5 0 0 1-.708 0L5 14.707l-.646.647a.5.5 0 0 1-.708 0L3 14.707l-.646.647a.5.5 0 0 1-.801-.13l-.5-1A.5.5 0 0 1 1 14V2a.5.5 0 0 1 .053-.224l.5-1a.5.5 0 0 1 .367-.27zm.217 1.338L2 2.118v11.764l.137.274.51-.51a.5.5 0 0 1 .707 0l.646.647.646-.646a.5.5 0 0 1 .708 0l.646.646.646-.646a.5.5 0 0 1 .708 0l.646.646.646-.646a.5.5 0 0 1 .708 0l.646.646.646-.646a.5.5 0 0 1 .708 0l.509.509.137-.274V2.118l-.137-.274-.51.51a.5.5 0 0 1-.707 0L12 1.707l-.646.647a.5.5 0 0 1-.708 0L10 1.707l-.646.647a.5.5 0 0 1-.708 0L8 1.707l-.646.647a.5.5 0 0 1-.708 0L6 1.707l-.646.647a.5.5 0 0 1-.708 0L4 1.707l-.646.647a.5.5 0 0 1-.708 0l-.509-.51z"/>
                                                        <path fill-rule="evenodd" d="M3 4.5a.5.5 0 0 1 .5-.5h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1-.5-.5zm8-6a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5z"/>
                                                    </svg>
                                                </div>
                                            </div><!--//col-->
                                            <div class="col">
                                                <div class="info"> 
                                                    <div class="desc">You have a new invoice. Proin venenatis interdum est.</div>
                                                    <div class="meta"> 1 day ago</div>
                                                </div>
                                            </div><!--//col-->
                                        </div><!--//row-->
                                        <a class="link-mask" href="notifications.html"></a>
                                    </div><!--//item-->
                                    <div class="item p-3">
                                        <div class="row gx-2 justify-content-between align-items-center">
                                            <div class="col-auto">
                                                <div class="app-icon-holder icon-holder-mono">
                                                    <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-bar-chart-line" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                                        <path fill-rule="evenodd" d="M11 2a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v12h.5a.5.5 0 0 1 0 1H.5a.5.5 0 0 1 0-1H1v-3a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3h1V7a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v7h1V2zm1 12h2V2h-2v12zm-3 0V7H7v7h2zm-5 0v-3H2v3h2z"/>
                                                    </svg>
                                                </div>
                                            </div><!--//col-->
                                            <div class="col">
                                                <div class="info"> 
                                                    <div class="desc">Your report is ready. Proin venenatis interdum est.</div>
                                                    <div class="meta"> 3 days ago</div>
                                                </div>
                                            </div><!--//col-->
                                        </div><!--//row-->
                                        <a class="link-mask" href="notifications.html"></a>
                                    </div><!--//item-->
                                    <div class="item p-3">
                                        <div class="row gx-2 justify-content-between align-items-center">
                                            <div class="col-auto">
                                               <img class="profile-image" src="assets/images/profiles/profile-2.png" alt="">
                                            </div><!--//col-->
                                            <div class="col">
                                                <div class="info"> 
                                                    <div class="desc">James sent you a new message.</div>
                                                    <div class="meta"> 7 days ago</div>
                                                </div>
                                            </div><!--//col--> 
                                        </div><!--//row-->
                                        <a class="link-mask" href="notifications.html"></a>
                                    </div><!--//item-->
                                </div><!--//dropdown-menu-content-->
                                <div class="dropdown-menu-footer p-2 text-center">
                                    <a href="notifications.html"><fmt:message key='view.all'/></a>
                                </div>
                            </div><!--//dropdown-menu-->					        
                        </div><!--//app-utility-item-->
                        <div class="app-utility-item">
                            <a href="resource" title="Settings">
                                <!--//Bootstrap Icons: https://icons.getbootstrap.com/ -->
                                <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-gear icon" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd" d="M8.837 1.626c-.246-.835-1.428-.835-1.674 0l-.094.319A1.873 1.873 0 0 1 4.377 3.06l-.292-.16c-.764-.415-1.6.42-1.184 1.185l.159.292a1.873 1.873 0 0 1-1.115 2.692l-.319.094c-.835.246-.835 1.428 0 1.674l.319.094a1.873 1.873 0 0 1 1.115 2.693l-.16.291c-.415.764.42 1.6 1.185 1.184l.292-.159a1.873 1.873 0 0 1 2.692 1.116l.094.318c.246.835 1.428.835 1.674 0l.094-.319a1.873 1.873 0 0 1 2.693-1.115l.291.16c.764.415 1.6-.42 1.184-1.185l-.159-.291a1.873 1.873 0 0 1 1.116-2.693l.318-.094c.835-.246.835-1.428 0-1.674l-.319-.094a1.873 1.873 0 0 1-1.115-2.692l.16-.292c.415-.764-.42-1.6-1.185-1.184l-.291.159A1.873 1.873 0 0 1 8.93 1.945l-.094-.319zm-2.633-.283c.527-1.79 3.065-1.79 3.592 0l.094.319a.873.873 0 0 0 1.255.52l.292-.16c1.64-.892 3.434.901 2.54 2.541l-.159.292a.873.873 0 0 0 .52 1.255l.319.094c1.79.527 1.79 3.065 0 3.592l-.319.094a.873.873 0 0 0-.52 1.255l.16.292c.893 1.64-.902 3.434-2.541 2.54l-.292-.159a.873.873 0 0 0-1.255.52l-.094.319c-.527 1.79-3.065 1.79-3.592 0l-.094-.319a.873.873 0 0 0-1.255-.52l-.292.16c-1.64.893-3.433-.902-2.54-2.541l.159-.292a.873.873 0 0 0-.52-1.255l-.319-.094c-1.79-.527-1.79-3.065 0-3.592l.319-.094a.873.873 0 0 0 .52-1.255l-.16-.292c-.892-1.64.902-3.433 2.541-2.54l.292.159a.873.873 0 0 0 1.255-.52l.094-.319z"/>
                                    <path fill-rule="evenodd" d="M8 5.754a2.246 2.246 0 1 0 0 4.492 2.246 2.246 0 0 0 0-4.492zM4.754 8a3.246 3.246 0 1 1 6.492 0 3.246 3.246 0 0 1-6.492 0z"/>
                                </svg>
                            </a>
                        </div><!--//app-utility-item-->
                        <div class="app-utility-item app-user-dropdown dropdown">
                            <a class="dropdown-toggle" id="user-dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false"><img src="assets/images/user.png" alt="user profile"></a>
                            <ul class="dropdown-menu" aria-labelledby="user-dropdown-toggle">
                                <li><a class="dropdown-item" href="account"><fmt:message key='user.management'/></a></li>
                                <li><a class="dropdown-item" href="settings.jsp"><fmt:message key='settings'/></a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="logout"><fmt:message key='logout'/></a></li>
                            </ul>
                        </div><!--//app-user-dropdown--> 
                    </div><!--//app-utilities-->
                </div><!--//row-->
            </div><!--//app-header-content-->
        </div><!--//container-fluid-->
    </div><!--//app-header-inner-->
    <div id="app-sidepanel" class="app-sidepanel"> 
        <div id="sidepanel-drop" class="sidepanel-drop"></div>
        <div class="sidepanel-inner d-flex flex-column">
            <a href="#" id="sidepanel-close" class="sidepanel-close d-xl-none">&times;</a>
            <div class="app-branding">
                <a class="app-logo" href="index"><img class="logo-icon me-2" src="logo.png" alt="logo"><span class="logo-text">TRACER</span></a>
            </div><!--//app-branding-->  
            <nav id="app-nav-main" class="app-nav app-nav-main flex-grow-1">
                <ul class="app-menu list-unstyled accordion" id="menu-accordion">
                    <li class="nav-item">
                        <a class="nav-link" href="index">
                            <span class="nav-icon">
                                <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-house-door" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd" d="M7.646 1.146a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 .146.354v7a.5.5 0 0 1-.5.5H9.5a.5.5 0 0 1-.5-.5v-4H7v4a.5.5 0 0 1-.5.5H2a.5.5 0 0 1-.5-.5v-7a.5.5 0 0 1 .146-.354l6-6zM2.5 7.707V14H6v-4a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 .5.5v4h3.5V7.707L8 2.207l-5.5 5.5z"/>
                                    <path fill-rule="evenodd" d="M13 2.5V6l-2-2V2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5z"/>
                                </svg>
                            </span>
                            <span class="nav-link-text"><fmt:message key='main.screen'/></span>
                        </a><!--//nav-link-->
                    </li><!--//nav-item-->
                    <li class="nav-item">
                        <a class="nav-link newProject" href="#">
                            <span class="nav-icon">
                                <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-house-door" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd" d="M7.646 1.146a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 .146.354v7a.5.5 0 0 1-.5.5H9.5a.5.5 0 0 1-.5-.5v-4H7v4a.5.5 0 0 1-.5.5H2a.5.5 0 0 1-.5-.5v-7a.5.5 0 0 1 .146-.354l6-6zM2.5 7.707V14H6v-4a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 .5.5v4h3.5V7.707L8 2.207l-5.5 5.5z"/>
                                    <path fill-rule="evenodd" d="M13 2.5V6l-2-2V2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5z"/>
                                </svg>
                            </span>
                            <span class="nav-link-text"><fmt:message key='new.project'/></span>
                        </a><!--//nav-link-->
                    </li><!--//nav-item-->
                    <li class="nav-item">
                        <a class="nav-link" href="docs.html">
                            <span class="nav-icon">
                                <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-folder" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M9.828 4a3 3 0 0 1-2.12-.879l-.83-.828A1 1 0 0 0 6.173 2H2.5a1 1 0 0 0-1 .981L1.546 4h-1L.5 3a2 2 0 0 1 2-2h3.672a2 2 0 0 1 1.414.586l.828.828A2 2 0 0 0 9.828 3v1z"/>
                                    <path fill-rule="evenodd" d="M13.81 4H2.19a1 1 0 0 0-.996 1.09l.637 7a1 1 0 0 0 .995.91h10.348a1 1 0 0 0 .995-.91l.637-7A1 1 0 0 0 13.81 4zM2.19 3A2 2 0 0 0 .198 5.181l.637 7A2 2 0 0 0 2.826 14h10.348a2 2 0 0 0 1.991-1.819l.637-7A2 2 0 0 0 13.81 3H2.19z"/>
                                </svg>
                            </span>
                            <span class="nav-link-text"><fmt:message key='timeline'/></span>
                        </a><!--//nav-link-->
                    </li><!--//nav-item-->
                    <li class="nav-item">
                        <a class="nav-link" href="orders.jsp">
                            <span class="nav-icon">
                                <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-card-list" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd" d="M14.5 3h-13a.5.5 0 0 0-.5.5v9a.5.5 0 0 0 .5.5h13a.5.5 0 0 0 .5-.5v-9a.5.5 0 0 0-.5-.5zm-13-1A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-13z"/>
                                    <path fill-rule="evenodd" d="M5 8a.5.5 0 0 1 .5-.5h7a.5.5 0 1 1 0 1h-7A.5.5 0 0 1 5 8zm0-2.5a.5.5 0 0 1 .5-.5h7a.5.5 0 1 1 0 1h-7a.5.5 0 0 1-.5-.5zm0 5a.5.5 0 0 1 .5-.5h7a.5.5 0 1 1 0 1h-7a.5.5 0 0 1-.5-.5z"/>
                                    <circle cx="3.5" cy="5.5" r=".5"/>
                                    <circle cx="3.5" cy="8" r=".5"/>
                                    <circle cx="3.5" cy="10.5" r=".5"/>
                                </svg>
                            </span>
                            <span class="nav-link-text"><fmt:message key='calendar'/></span>
                        </a><!--//nav-link-->
                    </li><!--//nav-item-->
                    <li class="nav-item has-submenu">
                        <a class="nav-link submenu-toggle" href="#" data-bs-toggle="collapse" data-bs-target="#submenu-1" aria-expanded="false" aria-controls="submenu-1">
                            <span class="nav-icon">
                                <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-files" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd" d="M4 2h7a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2zm0 1a1 1 0 0 0-1 1v10a1 1 0 0 0 1 1h7a1 1 0 0 0 1-1V4a1 1 0 0 0-1-1H4z"/>
                                    <path d="M6 0h7a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2v-1a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H6a1 1 0 0 0-1 1H4a2 2 0 0 1 2-2z"/>
                                </svg>
                            </span>
                            <span class="nav-link-text"><fmt:message key='boards'/></span>
                            <span class="submenu-arrow">
                                <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-down" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd" d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z"/>
                                </svg>
                            </span><!--//submenu-arrow-->
                        </a><!--//nav-link-->
                        <div id="submenu-1" class="collapse submenu submenu-1" data-bs-parent="#menu-accordion">
                            <ul class="submenu-list list-unstyled">
                                <li class="submenu-item"><a class="submenu-link" href="notifications.jsp"><fmt:message key='risk.management.board'/></a></li>
                                <li class="submenu-item"><a class="submenu-link" href="account.jsp"><fmt:message key='schedule.board'/></a></li>
                                <li class="submenu-item"><a class="submenu-link" href="settings.jsp"><fmt:message key='approval.board'/></a></li>
                                <li class="submenu-item"><a class="submenu-link" href="settings.jsp"><fmt:message key='completed.approval.board'/></a></li>
                            </ul>
                        </div>
                    </li><!--//nav-item-->
                    <li class="nav-item">
    <a class="nav-link" href="#" onclick="openChatWindow('/chatting'); return false;">
        <span class="nav-icon">
            <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-columns-gap" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd" d="M6 1H1v3h5V1zM1 0a1 1 0 0 0-1 1v3a1 1 0 0 0 1 1h5a1 1 0 0 0 1-1V1a1 1 0 0 0-1-1H1zm14 12h-5v3h5v-3zm-5-1a1 1 0 0 0-1 1v3a1 1 0 0 0 1 1h5a1 1 0 0 0 1-1v-3a1 1 0 0 0-1-1h-5zM6 8H1v7h5V8zM1 7a1 1 0 0 0-1 1v7a1 1 0 0 0 1 1h5a1 1 0 0 0 1-1V8a1 1 0 0 0-1-1H1zm14-6h-5v7h5V1zm-5-1a1 1 0 0 0-1 1v7a1 1 0 0 0 1 1h5a1 1 0 0 0 1-1V1a1 1 0 0 0-1-1h-5z"/>
            </svg>
        </span>
        <span class="nav-link-text"><fmt:message key='chat'/></span>
    </a><!--//nav-link-->
</li><!--//nav-item-->
<script>
function openChatWindow(url) {
    window.open(url, "ChatWindow", "width=1000,height=800");
}
</script>

                    <li class="nav-item">
                        <a class="nav-link" href="notifications">
                            <span class="nav-icon">
                                <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-question-circle" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                                    <path d="M5.255 5.786a.237.237 0 0 0 .241.247h.825c.138 0 .248-.113.266-.25.09-.656.54-1.134 1.342-1.134.686 0 1.314.343 1.314 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.003.217a.25.25 0 0 0 .25.246h.811a.25.25 0 0 0 .25-.25v-.105c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.267 0-2.655.59-2.75 2.286zm1.557 5.763c0 .533.425.927 1.01.927.609 0 1.028-.394 1.028-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94z"/>
                                </svg>
                            </span>
                            <span class="nav-link-text"><fmt:message key='notifications'/></span>
                        </a><!--//nav-link-->
                    </li><!--//nav-item-->					    
                </ul><!--//app-menu-->
            </nav><!--//app-nav-->
            <div class="app-sidepanel-footer">
                <nav class="app-nav app-nav-footer">
                    <ul class="app-menu footer-menu list-unstyled">
                        <li class="nav-item">
                            &nbsp; TRACER는 <br> &nbsp; 당신의 행보를 항상 응원합니다. <br>
                            &nbsp; 행복하자 우리 아프지말고<br>
                            &nbsp; 다치지말고
                        </li><!--//nav-item-->
                    </ul><!--//footer-menu-->
                </nav>
            </div><!--//app-sidepanel-footer-->
        </div><!--//sidepanel-inner-->
    </div><!--//app-sidepanel-->
</header><!--//app-header-->
 <div class="modal newPrjFrm" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">새로운 프로젝트 생성하기</h5>
        <button type="button" class="btn-close clsBtn" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form>
      <div class="prjInput modal-body">
       	프로젝트명
       	<input name="title" class="form-control mr-sm-2" placeholder="프로젝트 이름 입력" required/><br>
       	시작날짜
       	<input type="date" name="start_date" class="form-control mr-sm-2" placeholder="프로젝트 이름 입력" required/><br>
       	종료날짜
       	<input type="date" name="end_date" class="form-control mr-sm-2" placeholder="프로젝트 이름 입력" required/><br>
       	프로젝트 설명
        <textarea style="width: 100%; height: 300px;" 
        name="description" class="form-control mr-sm-2" placeholder="프로젝트 설명 입력" required></textarea><br>
       	<div id="inTeamList">
	        참여 인원<br>
	        <p>닉네임 : ${user_info.nickname} / 권한 : admin</p>
       	</div>
        <input type="email" name="invEmail" class="form-control" placeholder="이메일 검색" required/>
        <button type="button" id="schEmailBtn" class="btn btn-info" style="width: 15%;">검색</button>
        <br>
  
    
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary clsBtn" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary insNewPrjBtn">프로젝트 생성하기</button>
      </div>
      </form>
    </div>
  </div>
</div>


 <div class="modal emailSch" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="invNickname modal-title"></h5><br>
        <div class="modal-body">
	        <select name="auth" class="authSel form-select form-select-lg mb-3" aria-label=".form-select-lg example">
			  <option selected value="">권한</option>
			  <option value="admin">대표/임원</option>
			  <option value="manager">관리자</option>
			  <option value="user">참여자</option>
			  <option value="viewer">조회자</option>
			</select>
			<button type="button" class="btn btn-info inviteBtn" data-bs-dismiss="modal">확인</button>
			<button type="button" class="btn btn-secondary innerCls" data-bs-dismiss="modal">닫기</button>
        </div>
        <button type="button" class="btn-close innerCls" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      </div>
    </div>
  </div>