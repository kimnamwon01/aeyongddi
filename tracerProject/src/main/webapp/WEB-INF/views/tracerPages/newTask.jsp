<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>TRACER - 작업 관리</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="assets/css/portal.css">
    <script src="${path}/a00_com/jquery.min.js"></script>
    <script src="${path}/a00_com/bootstrap.min.js"></script>
</head>

<body class="app">
    <jsp:include page="/headerSidebar.jsp" />
    <div class="app-wrapper">
        <div class="app-content pt-3 p-md-3 p-lg-4">
            <div class="container-xl">
                <div class="row g-3 mb-4 align-items-center justify-content-between">
                    <div class="col-auto">
                        <h1 class="app-page-title mb-0">작업 관리</h1>
                    </div>
                </div>

                <!-- 결재 요청 모달 트리거 -->
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addApprovalModal">결재 요청</button>

                <!-- 결재 요청 모달 -->
                <div class="modal fade" id="addApprovalModal" tabindex="-1" aria-labelledby="addApprovalModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addApprovalModalLabel">결재 요청</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="/newTask/requestApproval" method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="tkid" value="${task.tkid}" />

                                    <div class="form-group">
                                        <label for="approvalTitle">결재 제목</label> 
                                        <input type="text" class="form-control" id="approvalTitle" name="approvalTitle" required>
                                    </div>

                                    <div class="form-group">
                                        <label for="approvalDescription">설명</label>
                                        <textarea class="form-control" id="approvalDescription" name="approvalDescription" required></textarea>
                                    </div>

                                    <div class="form-group">
                                        <label for="approvalFile">파일 첨부</label> 
                                        <input type="file" class="form-control" id="approvalFile" name="approvalFile">
                                    </div>

                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                                        <button type="submit" class="btn btn-primary">결재 요청</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 작업 리스트 -->
                <div class="app-card app-card-orders-table shadow-sm mb-5">
                    <div class="app-card-body">
                        <div class="table-responsive">
                            <table class="table app-table-hover mb-0 text-left">
                                <thead>
                                    <tr>
                                        <th class="cell">Task ID</th>
                                        <th class="cell">제목</th>
                                        <th class="cell">시작 날짜</th>
                                        <th class="cell">종료 날짜</th>
                                        <th class="cell">상태</th>
                                        <th class="cell">수정/삭제</th>
                                        <th class="cell">피드백 확인</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="task" items="${tasks}">
                                        <tr>
                                            <td class="cell task-row" data-taskid="${task.tkid}">${task.tkid}</td>
                                            <td class="cell task-row" data-taskid="${task.tkid}">${task.name}</td>
                                            <td class="cell task-row" data-taskid="${task.tkid}">${task.formattedStartDate}</td>
                                            <td class="cell task-row" data-taskid="${task.tkid}">${task.formattedEndDate}</td>
                                            <td class="cell">
                                                <select class="form-control status-select" data-taskid="${task.tkid}">
                                                    <option value="false" ${!task.endYn ? 'selected' : ''}>진행 중</option>
                                                    <option value="true" ${task.endYn ? 'selected' : ''}>완료</option>
                                                </select>
                                            </td>
                                            <td class="cell">
                                                <!-- 수정 버튼 -->
                                                <button type="button" class="btn btn-sm btn-secondary" data-bs-toggle="modal" data-bs-target="#editTaskModal-${task.tkid}">수정</button>

                                                <!-- 삭제 버튼 -->
                                                <form action="/newTask/delete" method="post" style="display: inline;">
                                                    <input type="hidden" name="tkid" value="${task.tkid}" /> 
                                                    <input type="hidden" name="sid" value="${task.sid}" />
                                                    <button type="submit" class="btn btn-sm btn-danger">삭제</button>
                                                </form>
                                            </td>
                                            <td class="cell">
                                                <!-- 피드백 확인 버튼 -->
                                                <button type="button" class="btn btn-sm btn-info" data-bs-toggle="modal" data-bs-target="#feedbackModal-${task.tkid}">피드백 확인</button>
                                            </td>
                                        </tr>

                                        <!-- 작업 수정 모달 -->
                                        <div class="modal fade" id="editTaskModal-${task.tkid}" tabindex="-1" aria-labelledby="editTaskModalLabel-${task.tkid}" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="editTaskModalLabel-${task.tkid}">작업 수정</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form action="/newTask/update" method="post">
                                                            <input type="hidden" name="tkid" value="${task.tkid}" />
                                                            <input type="hidden" name="sid" value="${task.sid}" />

                                                            <div class="form-group">
                                                                <label for="name-${task.tkid}">제목</label> 
                                                                <input type="text" class="form-control" id="name-${task.tkid}" name="name" value="${task.name}" required>
                                                            </div>

                                                            <div class="form-group">
                                                                <label for="description-${task.tkid}">설명</label>
                                                                <textarea class="form-control" id="description-${task.tkid}" name="description" required>${task.description}</textarea>
                                                            </div>

                                                            <div class="form-group">
                                                                <label for="startDate-${task.tkid}">시작 날짜</label> 
                                                                <input type="date" class="form-control" id="startDate-${task.tkid}" name="startDate" value="${task.formattedStartDate}" required>
                                                            </div>

                                                            <div class="form-group">
                                                                <label for="endDate-${task.tkid}">종료 날짜</label> 
                                                                <input type="date" class="form-control" id="endDate-${task.tkid}" name="endDate" value="${task.formattedEndDate}">
                                                            </div>

                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                                                                <button type="submit" class="btn btn-primary">수정하기</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- 피드백 확인 모달 -->
                                        <div class="modal fade" id="feedbackModal-${task.tkid}" tabindex="-1" aria-labelledby="feedbackModalLabel-${task.tkid}" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="feedbackModalLabel-${task.tkid}">피드백 확인</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <h4>결재 제목: ${task.approval.approvalTitle}</h4>
                                                        <p><strong>결재 설명:</strong> ${task.approval.approvalDescription}</p>
                                                        <p><strong>피드백:</strong> ${task.approval.feedback}</p>
                                                        <p><strong>첨부 파일:</strong> <a href="/upload/files/${task.approval.upfile}">다운로드</a></p>

                                                        <form action="/newTask/submitFeedback" method="post">
                                                            <input type="hidden" name="apid" value="${task.approval.apid}" />
                                                            <div class="form-group">
                                                                <label for="userFeedback">보완 피드백:</label>
                                                                <textarea class="form-control" id="userFeedback" name="userFeedback" required></textarea>
                                                            </div>
                                                            <button type="submit" class="btn btn-primary mt-3">피드백 제출</button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer class="app-footer">
            <div class="container text-center py-3">
                <small class="copyright">Designed with by <a class="app-link" href="http://themes.3rdwavemedia.com" target="_blank">Xiaoying Riley</a> for developers</small>
            </div>
        </footer>
    </div>

    <script>
        $(document).ready(function() {
            // 작업 상세 정보를 보기 위해 테이블 셀을 클릭 시 모달을 띄움
            $('.task-row').on('click', function() {
                var taskId = $(this).data('taskid');
                var target = '#viewTaskModal-' + taskId;
                $(target).modal('show');
            });

            // 상태 변경 시 AJAX 요청을 통해 상태 업데이트
            $('.status-select').on('change', function() {
                const taskId = $(this).data('taskid');
                const newStatus = $(this).val() === "true";

                fetch('/newTask/updateStatus', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        tkid: taskId,
                        endYn: newStatus
                    })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('현재 상태가 수정되었습니다.');
                    } else {
                        alert('현재 상태가 변경되지 않았습니다.');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                });
            });
        });
    </script>

    <script src="assets/plugins/popper.min.js"></script>
    <script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/js/app.js"></script>
</body>
</html>
