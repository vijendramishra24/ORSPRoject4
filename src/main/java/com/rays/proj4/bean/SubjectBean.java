package com.rays.proj4.bean;

import java.sql.Timestamp;

/**
 * Subject JavaBean encapsulates subject attributes
 * @author Bridge
 *
 */
public class SubjectBean extends BaseBean {
	/*database entrie
	 * 
	 * 	SUBJECT_NAMEvarchar(225) NULL
		DESCRIPTIONvarchar(225) NULL
		SUBJECT_CODEvarchar(20) NULL
		CREATED_BYvarchar(225) NULL
		MODIFIED_BYvarchar(225) NULL
		CREATED_DATETIMEtimestamp NOT NULL
		MODIFIED_DATETIMEtimestamp NOT NULL
		COURSE_ID bigint(2)
	 * 
	 */
	
	/*ALreday define in 
	 * 
	 * 	protected long id;
    	protected String createdBy;
    	protected String modifiedBy;
    	protected Timestamp createdDatetime;
    	protected Timestamp modifiedDatetime;
	 */
	/**
	 * Name of Subject
	 */
	private String name;
	/**
	 * Description of subject
	 */
	private String description;
    /**
     * Code of Subject
     */
    private String subjectCode;
    /**
     * Course id to which subject belongs
     */
    private int courseId;
    

	
	public String getSubjectCode() {
		return subjectCode;
	}

	public void setSubjectCode(String subjectCode) {
		this.subjectCode = subjectCode;
	}

	public int getCourseId() {
		return courseId;
	}

	public void setCourseId(int courseId) {
		this.courseId = courseId;
	}

	public String getKey() {
		
		return id + "";
	}

	public String getValue() {
		
		return name;
	}

	
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
