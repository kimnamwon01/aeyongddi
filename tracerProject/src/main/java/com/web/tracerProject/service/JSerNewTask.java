package com.web.tracerProject.service;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.tracerProject.mapper.JDaoNewTask;
import com.web.tracerProject.vo.Approval;
import com.web.tracerProject.vo.Task;

@Service
public class JSerNewTask {
    @Autowired(required = false)
    private JDaoNewTask dao;
    
    @Autowired(required = false)
    private JSerNewAppro approvalService;

    // 날짜 포맷터
    private static final SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

    public List<Task> getAllTasks() {
        List<Task> tasks = dao.findAllTasks();

        // 각 Task 객체에 대해 날짜 포맷팅 적용 및 Approval 객체 설정
        for (Task task : tasks) {
            if (task.getStartDate() != null) {
                task.setFormattedStartDate(formatter.format(task.getStartDate()));
            }
            if (task.getEndDate() != null) {
                task.setFormattedEndDate(formatter.format(task.getEndDate()));
            }

            // Approval 객체를 설정
            Approval approval = approvalService.getApprovalByTaskId(task.getTkid());
            task.setApproval(approval);
        }

        return tasks;
    }

    public void addTask(Task task) {
        dao.insertTask(task);
    }

    public void updateTask(Task task) {
        dao.updateTask(task);
    }

    public void deleteTask(String tkid) {
        dao.deleteTask(tkid);
    }

    public Task getTaskById(String tkid) {
        Task task = dao.findTaskById(tkid);
        Approval approval = approvalService.getApprovalByTaskId(task.getTkid());
        if (approval != null) {
            task.setApproval(approval);
        }
        return task;
    }
    
    public void requestApproval(String tkid, String approvalTitle, String approvalDescription, String fileName) {
        Approval approval = new Approval();
        approval.setTkid(tkid);
        approval.setApprovalTitle(approvalTitle);
        approval.setApprovalDescription(approvalDescription);
        approval.setUpfile(fileName);
        approval.setRequestDateTime(LocalDateTime.now());  // 요청 시각 설정
        approvalService.addApproval(approval);
    }

}
