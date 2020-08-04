package com.rays.proj4.bean;

import java.sql.Timestamp;
import java.util.Date;

/**
 * Faculty JavaBean encapsulates Faculty attributes
 * @author Bridge
 *
 */
public class FacultyBean extends BaseBean {
	private String firstName;
	/**
	 * Last Name of Faculty
	 */
	private String lastName;
	/**
	 * Login of faculty
	 */
	private String login;
	
	/**
	 * Date of Birth of faculty
	 */
	private Date dob;
	/**
	 * MobielNo of faculty
	 */
	private String mobileNo;
	/**
	 * College Id of faculty
	 */
	private long subjectId;
	
	/**
	 * College Id of faculty
	 */
	private long courseId;
	/**
	 * College Id of faculty
	 */
	private long collegeId;
	/**
	 * College Name of Faculty
	 */
	private String collegeName;
	/**
	 * Subject Faculty takes
	 */
	private String subjectName;
	/**
	 * Course to which faculty belongs
	 */
	private String courseName;
	
	
	public long getSubjectId() {
		return subjectId;
	}

	public void setSubjectId(long subjectId) {
		this.subjectId = subjectId;
	}

	public long getCourseId() {
		return courseId;
	}

	public void setCourseId(long courseId) {
		this.courseId = courseId;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public Date getDob() {
		return dob;
	}

	public void setDob(Date dob) {
		this.dob = dob;
	}

	public long getCollegeId() {
		return collegeId;
	}

	public void setCollegeId(long collegeId) {
		this.collegeId = collegeId;
	}

	public String getCollegeName() {
		return collegeName;
	}

	public void setCollegeName(String collegeName) {
		this.collegeName = collegeName;
	}

	
	
	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public String getKey() {
		
		return id + "";
	}

	public String getValue() {
		return firstName + " " + lastName;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public String getSubjectName() {
		return subjectName;
	}

	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}

}
