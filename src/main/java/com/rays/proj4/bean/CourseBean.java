package com.rays.proj4.bean;

/**
 * @author Bridge
 * Course JavaBean encapsulates Course attributes
 *
 */
public class CourseBean extends BaseBean{

	/**
	 * Name of Course
	 */
	private String name;
	/**
	 * Description of Description of Course
	 */
	private String description;
    /**
     * Code of Course
     */
    private String courseCode;
    
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	
	public String getCourseCode() {
		return courseCode;
	}

	public void setCourseCode(String courseCode) {
		this.courseCode = courseCode;
	}

	public String getKey() {
		return id + "";
	}

	public String getValue() {
		
		return name;
	}

}
