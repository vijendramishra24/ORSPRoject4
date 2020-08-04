package com.rays.proj4.bean;

import java.util.Date;

/**
 * Timetable JavaBean encapsulates subject attributes
 * @author Bridge
 *
 */
public class TimetableBean extends BaseBean {
	
	/**
	 * Course Id in timetable
	 */
	private long courseId;
	/**
	 * Semester in timetable
	 */
	private String sem;
    /**
     * Subject Id in timetable
     */
    private long subjectId;
    /**
     * Date of Exam mention in timetable
     */
    private Date examDate;
    /**
     * Time of exam mention in timetable
     */
    private String examTime;
    

	public String getKey() {
		// TODO Auto-generated method stub
		return id + "";
	}

	

	public String getSem() {
		return sem;
	}

	public void setSem(String sem) {
		this.sem = sem;
	}

	

	public Date getExamDate() {
		return examDate;
	}

	public void setExamDate(Date examDate) {
		this.examDate = examDate;
	}

	public String getExamTime() {
		return examTime;
	}

	public void setExamTime(String examTime) {
		this.examTime = examTime;
	}

	public long getCourseId() {
		return courseId;
	}



	public void setCourseId(long courseId) {
		this.courseId = courseId;
	}



	public long getSubjectId() {
		return subjectId;
	}



	public void setSubjectId(long subjectId) {
		this.subjectId = subjectId;
	}



	public String getValue() {
		// TODO Auto-generated method stub
		return examDate +""+examTime;
	}

}
