<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Portal - Bootstrap 5 Admin Dashboard Template For Developers</title>
    
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
</head>
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<body class="app">   	
<jsp:include page="/headerSidebar.jsp"/>

<div class="app-wrapper">
    <div class="app-content pt-3 p-md-3 p-lg-4">
        <div class="container-xl">
            <h1 class="app-page-title"><fmt:message key="user.management"/></h1>
            <div class="row gy-4">
                <div class="col-12 col-lg-6">
                    <div class="app-card app-card-account shadow-sm d-flex flex-column align-items-start">
                        <div class="app-card-header p-3 border-bottom-0">
                            <div class="row align-items-center gx-3">
                                <div class="col-auto">
                                    <div class="app-icon-holder">
                                        <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-person" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                            <path fill-rule="evenodd" d="M10 5a2 2 0 1 1-4 0 2 2 0 0 1 4 0zM8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm6 5c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
                                        </svg>
                                    </div>
                                </div>
                                <div class="col-auto">
                                    <h4 class="app-card-title"><fmt:message key="profile"/></h4>
                                </div>
                            </div>
                        </div>
                        <div class="app-card-body px-4 w-100">
                            <div class="item border-bottom py-3">
                                <div class="row justify-content-between align-items-center">
                                    <div class="col-auto">
                                        <div class="item-label mb-2"><strong><fmt:message key="프로필 사진"/></strong></div>
                                        <div class="item-data"><img class="profile-image" src="assets/images/user.png" alt=""></div>
                                    </div>
                                    <div class="col text-end">
                                        <a class="btn-sm app-btn-secondary" href="#"><fmt:message key="change"/></a>
                                    </div>
                                </div>
                            </div>
                            <div class="item border-bottom py-3">
                                <div class="row justify-content-between align-items-center">
                                    <div class="col-auto">
                                        <div class="item-label"><strong><fmt:message key="이름"/></strong></div>
                                        <div class="item-data">${user_info.name }</div>
                                    </div>
                                    <div class="col text-end">
                                        <button class="btn-sm app-btn-secondary" data-bs-toggle="tooltip" data-bs-placement="left" title="<fmt:message key='cannot.change'/>" disabled><fmt:message key="cannot.change"/></button>
                                    </div>
                                </div>
                            </div>
                            <div class="item border-bottom py-3">
                                <div class="row justify-content-between align-items-center">
                                    <div class="col-auto">
                                        <div class="item-label"><strong><fmt:message key="이메일"/></strong></div>
                                        <div class="item-data">${user_info.email }</div>
                                    </div>
                                    <div class="col text-end">
                                        <button class="btn-sm app-btn-secondary" data-bs-toggle="tooltip" data-bs-placement="left" title="<fmt:message key='cannot.change'/>" disabled><fmt:message key="cannot.change"/></button>
                                    </div>
                                </div>
                            </div>
                            <div class="item border-bottom py-3">
                                <div class="row justify-content-between align-items-center">
                                    <div class="col-auto">
                                        <div class="item-label"><strong><fmt:message key="닉네임"/></strong></div>
                                        <div class="item-data">${user_info.nickname }</div>
                                    </div>
                                    <div class="col text-end">
                                        <a class="btn-sm app-btn-secondary" href="#" id="changeNicknameBtn"><fmt:message key="change"/></a>
                                    </div>
                                </div>
                            </div>
                            <div class="modal" id="changeNicknameModal" tabindex="-1" role="dialog">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title"><fmt:message key="닉네임 변경하기"/></h5>
                                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <input type="text" class="form-control" id="newNickname" placeholder="<fmt:message key='새 닉네임'/>">
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"><fmt:message key="닫기"/></button>
                                            <button type="button" class="btn btn-primary" id="saveNicknameBtn"><fmt:message key="저장하기"/></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="item border-bottom py-3">
                                <div class="row justify-content-between align-items-center">
                                    <div class="col-auto">
                                        <div class="item-label"><strong><fmt:message key="phone.number"/></strong></div>
                                        <div class="item-data">${user_info.phone }</div>
                                    </div>
                                    <div class="col text-end">
                                        <a class="btn-sm app-btn-secondary" href="#" id="changePhoneBtn"><fmt:message key="change"/></a>
                                    </div>
                                </div>
                            </div>
                            <div class="modal" id="changePhoneModal" tabindex="-1" role="dialog">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title"><fmt:message key="전화번호 변경하기"/></h5>
                                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <input type="text" class="form-control" id="newPhone" placeholder="<fmt:message key='새 전화번호'/>">
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"><fmt:message key="닫기"/></button>
                                            <button type="button" class="btn btn-primary" id="savePhoneBtn"><fmt:message key="저장하기"/></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-lg-6">
                    <div class="app-card app-card-account shadow-sm d-flex flex-column align-items-start">
                        <div class="app-card-header p-3 border-bottom-0">
                            <div class="row align-items-center gx-3">
                                <div class="col-auto">
                                    <div class="app-icon-holder">
                                        <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-sliders" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                            <path fill-rule="evenodd" d="M11.5 2a1.5 1.5 0 1 0 0 3 1.5 1.5 0 0 0 0-3zM9.05 3a2.5 2.5 0 0 1 4.9 0H16v1h-2.05a2.5 2.5 0 0 1-4.9 0H0V3h9.05zM4.5 7a1.5 1.5 0 1 0 0 3 1.5 1.5 0 0 0 0-3zM2.05 8a2.5 2.5 0 0 1 4.9 0H16v1H6.95a2.5 2.5 0 0 1-4.9 0H0V8h2.05zm9.45 4a1.5 1.5 0 1 0 0 3 1.5 1.5 0 0 0 0-3zm-2.45 1a2.5 2.5 0 0 1 4.9 0H16v1h-2.05a2.5 2.5 0 0 1-4.9 0H0v-1h9.05z"/>
                                        </svg>
                                    </div>
                                </div>
                                <div class="col-auto">
                                    <h4 class="app-card-title"><fmt:message key="기타 설정"/></h4>
                                </div>
                            </div>
                        </div>
                        <div class="app-card-body px-4 w-100">
                            <div class="item border-bottom py-3">
                                <div class="row justify-content-between align-items-center">
                                    <div class="col-auto">
                                        <div class="item-label"><strong><fmt:message key="언어"/></strong></div>
                                        <div class="item-data">한국어</div>
                                    </div>
                                    <div class="col text-end">
                                        <a class="btn-sm app-btn-secondary" href="#"><fmt:message key="change"/></a>
                                    </div>
                                </div>
                            </div>
                            <div class="item border-bottom py-3">
                                <div class="row justify-content-between align-items-center">
                                    <div class="col-auto">
                                        <div class="item-label"><strong>Time Zone</strong></div>
                                        <div class="item-data">Central Standard Time (UTC-6)</div>
                                    </div>
                                    <div class="col text-end">
                                        <a class="btn-sm app-btn-secondary" href="#"><fmt:message key="change"/></a>
                                    </div>
                                </div>
                            </div>
                            <div class="item border-bottom py-3">
                                <div class="row justify-content-between align-items-center">
                                    <div class="col-auto">
                                        <div class="item-label"><strong>Currency</strong></div>
                                        <div class="item-data">$(US Dollars)</div>
                                    </div>
                                    <div class="col text-end">
                                        <a class="btn-sm app-btn-secondary" href="#"><fmt:message key="change"/></a>
                                    </div>
                                </div>
                            </div>
                            <div class="item border-bottom py-3">
                                <div class="row justify-content-between align-items-center">
                                    <div class="col-auto">
                                        <div class="item-label"><strong>이메일 알림</strong></div>
                                        <div class="item-data">Off</div>
                                    </div>
                                    <div class="col text-end">
                                        <a class="btn-sm app-btn-secondary" href="#"><fmt:message key="change"/></a>
                                    </div>
                                </div>
                            </div>
                            <div class="item border-bottom py-3">
                                <div class="row justify-content-between align-items-center">
                                    <div class="col-auto">
                                        <div class="item-label"><strong>SMS 알림</strong></div>
                                        <div class="item-data">On</div>
                                    </div>
                                    <div class="col text-end">
                                        <a class="btn-sm app-btn-secondary" href="#"><fmt:message key="change"/></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="app-card-footer p-4 mt-auto">
                            <a class="btn app-btn-primary" href="#" id="deleteAccountBtn"><fmt:message key="회원 탈퇴"/></a>
                        </div>
                        <div class="modal" id="deleteAccountModal" tabindex="-1" role="dialog">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title"><fmt:message key="회원 탈퇴"/></h5>
                                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <p><fmt:message key="정말로 회원 탈퇴를 하시겠습니까? 이 작업은 되돌릴 수 없습니다."/></p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"><fmt:message key="닫기"/></button>
                                        <button type="button" class="btn btn-danger" id="confirmDeleteBtn"><fmt:message key="탈퇴하기"/></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer class="app-footer">
        <div class="container text-center py-3">
            <!--/* This template is free as long as you keep the footer attribution link. If you'd like to use the template without the attribution link, you can buy the commercial license via our website: themes.3rdwavemedia.com Thank you for your support. :) */-->
            <small class="copyright">Designed with by <a class="app-link" href="http://themes.3rdwavemedia.com" target="_blank">Xiaoying Riley</a> for developers</small>
        </div>
    </footer>
</div>
<div class="modal chgPwd" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><fmt:message key="비밀번호 변경하기"/></h5>
                <button type="button" class="btn-close clsBtn" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form>
                <div class="modal-body">
                    <fmt:message key="이메일"/> <input type="email" value="${user_info.email }" name="email" class="form-control mr-sm-2" placeholder="<fmt:message key='이메일 입력'/>" required readonly/><br>
                    <fmt:message key="현재 비밀번호"/> <input type="password" name="curPwd" class="form-control mr-sm-2" placeholder="<fmt:message key='현재 비밀번호 입력'/>" required/><br>
                    <fmt:message key="변경할 비밀번호"/> <input type="password" name="password" class="form-control mr-sm-2" placeholder="<fmt:message key='변경할 비밀번호 입력'/>" required/><br>
                    <fmt:message key="비밀번호 확인"/> <input type="password" name="pwdChk" class="form-control mr-sm-2" placeholder="<fmt:message key='비밀번호 확인 입력'/>" required/><br>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary clsBtn" data-bs-dismiss="modal"><fmt:message key="닫기"/></button>
                    <button type="button" class="btn btn-primary chgPwdBtn"><fmt:message key="비밀번호 변경하기"/></button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="assets/plugins/popper.min.js"></script>
<script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>
<script src="assets/js/app.js"></script>

<script type="text/javascript">
$(document).ready(function() {
    // 회원 탈퇴 모달 초기화
    $('#deleteAccountBtn').click(function() {
        $('#deleteAccountModal').modal('show');
    });

    $('#confirmDeleteBtn').click(function() {
        $.ajax({
            url: '/deleteAccount',
            type: 'POST',
            success: function(response) {
                alert(response);
                if (response === '회원 탈퇴 성공') {
                    location.href = '/login'; // 회원 탈퇴 후 로그인 페이지로 이동
                }
            },
            error: function(xhr, status, error) {
                console.error('Error: ' + error);
                alert('회원 탈퇴 중 오류가 발생했습니다. 다시 시도해 주세요.');
            }
        });
    });

    // Enter 키로 인한 폼 제출 방지
    $('form').on('keydown', function(event) {
        if (event.key === 'Enter') {
            event.preventDefault();
        }
    });

    // 비밀번호 변경 모달 초기화
    $(".chgPwd").hide(400)
    $(".showChgPwd").click(function() {
        $(".chgPwd").show(400)
    })
    $(".clsBtn").click(function() {
        $(".chgPwd").hide(400)
    })
    $(".chgPwdBtn").click(function() {
        if ($("[name=curPwd]").val() != '${user_info.password}')
            alert("현재 비밀번호가 일치하지 않습니다.")
        else if ($("[name=password]").val() != $("[name=pwdChk]").val())
            alert("변경 비밀번호와 비밀번호 확인이 일치하지 않습니다.")
        else {
            if (confirm('정말로 변경하시겠습니까?'))
                chgPwd()
        }
    });

    // 닉네임 변경 모달 초기화
    $('#changeNicknameBtn').click(function() {
        $('#changeNicknameModal').modal('show');
    });

    $('#saveNicknameBtn').click(function() {
        var newNickname = $('#newNickname').val();
        $.ajax({
            url: '/updateNickname',
            type: 'POST',
            data: { nickname: newNickname },
            success: function(response) {
                alert(response);
                if (response === '닉네임 변경 성공') {
                    location.reload();
                }
            },
            error: function(xhr, status, error) {
                console.error('Error: ' + error);
            }
        });
    });

    // 전화번호 변경 모달 초기화
    $('#changePhoneBtn').click(function() {
        $('#changePhoneModal').modal('show');
    });

    $('#savePhoneBtn').click(function() {
        var newPhone = $('#newPhone').val();
        $.ajax({
            url: '/updatePhone',
            type: 'POST',
            data: { phone: newPhone },
            success: function(response) {
                alert(response);
                if (response === '전화번호 변경 성공') {
                    location.reload();
                }
            },
            error: function(xhr, status, error) {
                console.error('Error: ' + error);
            }
        });
    });

    // Initialize Bootstrap tooltips
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
});

function chgPwd() {
    $.ajax({
        data: $("form").serialize(),
        url: 'chgPwd',
        type: 'POST',
        success: function(data) {
            alert(data + ", 로그인 페이지로 이동합니다.")
            if (data == "비밀번호변경성공")
                location.href = 'logout'
        },
        error: function(err) {
            console.log(err)
            alert('비밀번호는 영어 대소문자, 숫자, 특수문자로 이루어진 8~20글자만 허용합니다')
        }
    })
}
</script>

</body>
</html>
