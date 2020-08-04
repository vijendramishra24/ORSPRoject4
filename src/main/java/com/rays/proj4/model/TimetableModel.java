package com.rays.proj4.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.rays.proj4.bean.CollegeBean;
import com.rays.proj4.bean.TimetableBean;
import com.rays.proj4.bean.UserBean;
import com.rays.proj4.exception.ApplicationException;
import com.rays.proj4.exception.DatabaseException;
import com.rays.proj4.exception.DuplicateRecordException;
import com.rays.proj4.util.JDBCDataSource;

/**
 * JDBC Implementation of Timetable Model
 * @author Bridge
 *
 */
public class TimetableModel {
	private static Logger log = Logger.getLogger(TimetableModel.class);
	
	
	/**
	 * Find next Pk
	 * @return
	 * @throws DatabaseException
	 */
	public Integer nextPK() throws DatabaseException {
		log.debug("Model nextPK Started");
		Connection conn = null;
		int pk = 0;
		try {
			conn = JDBCDataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(ID) FROM st_timetable");
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				pk = rs.getInt(1);
			}
			rs.close();

		} catch (Exception e) {
			log.error("Database Exception..", e);
			throw new DatabaseException("Exception : Exception in getting PK");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Model nextPK End");
		return pk + 1;
	}

	
	/**
	 * Time time table
	 * @param bean
	 * @return
	 * @throws ApplicationException
	 * @throws DuplicateRecordException
	 */
	public long add(TimetableBean bean) throws ApplicationException, DuplicateRecordException {
		log.debug("Model add Started");
		Connection conn = null;
		System.out.println("helooooooo111");
	//duplicacy check
		int pk = 0;
		TimetableBean duplicateName = findDuplicate1(bean.getCourseId(), bean.getSem(), bean.getSubjectId());
		if (duplicateName != null) {			
			throw new DuplicateRecordException("time table already exists");
		}
		TimetableBean duplicateTime = findDuplicate2(bean.getCourseId(), bean.getSem(), bean.getExamTime());
		
		if (duplicateTime != null) {
			System.out.println("duplicatTime");
			throw new DuplicateRecordException("time table already exists");
		}
		
		try {
			conn = JDBCDataSource.getConnection();
			pk = nextPK();
			// Get auto-generated next primary key
			//System.out.println(pk + " in ModelJDBC");
			conn.setAutoCommit(false); // Begin transaction
			PreparedStatement pstmt = conn.prepareStatement("INSERT INTO st_timetable VALUES(?,?,?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, pk);
			pstmt.setLong(2, bean.getCourseId());
			pstmt.setString(3, bean.getSem());
			pstmt.setLong(4, bean.getSubjectId());
			pstmt.setDate(5, new java.sql.Date(bean.getExamDate().getTime()));
			//pstmt.setDate(6, new java.sql.Date(bean.getDob().getTime()));
			pstmt.setString(6, bean.getExamTime());
			
			pstmt.setString(7, bean.getCreatedBy());
			pstmt.setString(8, bean.getModifiedBy());
			pstmt.setTimestamp(9, bean.getCreatedDatetime());
			pstmt.setTimestamp(10, bean.getModifiedDatetime());
			pstmt.executeUpdate();
			conn.commit(); // End transaction
			pstmt.close();
		} catch (Exception e) {
			log.error("Database Exception..", e);
			try {
				conn.rollback();
			} catch (Exception ex) {
				throw new ApplicationException("Exception : add rollback exception " + ex.getMessage());
			}
			throw new ApplicationException("Exception : Exception in add timetable");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Model add End");
		return pk;
	}

	/**
	 * Delete Timetable
	 * @param bean
	 * @throws ApplicationException
	 */
	public void delete(TimetableBean bean) throws ApplicationException {
		log.debug("Model delete Started");
		Connection conn = null;
		try {
			conn = JDBCDataSource.getConnection();
			conn.setAutoCommit(false); // Begin transaction
			PreparedStatement pstmt = conn.prepareStatement("DELETE FROM st_timetable WHERE ID=?");
			pstmt.setLong(1, bean.getId());
			pstmt.executeUpdate();
			conn.commit(); // End transaction
			pstmt.close();

		} catch (Exception e) {
			log.error("Database Exception..", e);
			try {
				conn.rollback();
			} catch (Exception ex) {
				throw new ApplicationException("Exception : Delete rollback exception " + ex.getMessage());
			}
			throw new ApplicationException("Exception : Exception in delete timetable");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Model delete Started");
	}

	/**
	 * To check duplicate entry during adding timetable
	 * @param courseId
	 * @param sem
	 * @param subjectId
	 * @return
	 * @throws ApplicationException
	 */
	public TimetableBean findDuplicate1(long courseId, String sem, long subjectId ) throws ApplicationException {
		log.debug("Model duplicate1 Started");
		StringBuffer sql = new StringBuffer("SELECT * FROM st_timetable WHERE (COURSE_ID=? AND SEM=? AND SUBJECT_ID=?)");
		TimetableBean bean = null;
		Connection conn = null;
		try {
			conn = JDBCDataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
			pstmt.setLong(1, courseId);
			pstmt.setString(2, sem);
			pstmt.setLong(3, subjectId);
			//pstmt.setDate(4, (java.sql.Date) examDate);
			
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				bean = new TimetableBean();
				bean.setId(rs.getLong(1));
				bean.setCourseId(rs.getLong(2));
				bean.setSem(rs.getString(3));
				bean.setSubjectId(rs.getLong(4));
				bean.setExamDate(rs.getDate(5));
				bean.setExamTime(rs.getString(6));
				bean.setCreatedBy(rs.getString(7));
				bean.setModifiedBy(rs.getString(8));
				bean.setCreatedDatetime(rs.getTimestamp(9));
				bean.setModifiedDatetime(rs.getTimestamp(10));

			}
			rs.close();
		} catch (Exception e) {
			log.error("Database Exception..", e);
			throw new ApplicationException("Exception : Exception in getting timetable by courseid,sem,subjectid");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Model duplicate1 End");
		return bean;
	}


	/**
	 * To check duplicate entry during adding timetable
	 * @param courseId
	 * @param sem
	 * @param examTime
	 * @return
	 * @throws ApplicationException
	 */
	public TimetableBean findDuplicate2(long courseId, String sem, String examTime ) throws ApplicationException {
		log.debug("Model duplicate1 Started");
		StringBuffer sql = new StringBuffer("SELECT * FROM st_timetable WHERE (COURSE_ID=? AND SEM=? AND TIME_EXAM=?)");
		System.out.println("inside dupicate 1");
		TimetableBean bean = null;
		Connection conn = null;
		try {
			conn = JDBCDataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
			pstmt.setLong(1, courseId);
			pstmt.setString(2, sem);
			pstmt.setString(3, examTime);
			//pstmt.setDate(4, (java.sql.Date) examDate);
			System.out.println("inside dupicate 2");
			
			ResultSet rs = pstmt.executeQuery();
			System.out.println("inside dupicate 3");
			while (rs.next()) {
				bean = new TimetableBean();
				bean.setId(rs.getLong(1));
				bean.setCourseId(rs.getLong(2));
				bean.setSem(rs.getString(3));
				bean.setSubjectId(rs.getLong(4));
				bean.setExamDate(rs.getDate(5));
				bean.setExamTime(rs.getString(6));
				bean.setCreatedBy(rs.getString(7));
				bean.setModifiedBy(rs.getString(8));
				bean.setCreatedDatetime(rs.getTimestamp(9));
				bean.setModifiedDatetime(rs.getTimestamp(10));
				System.out.println("inside dupicate 4");
			}
			rs.close();
		} catch (Exception e) {
			log.error("Database Exception..", e);
			throw new ApplicationException("Exception : Exception in getting timetable by courseid,sem,subjectid");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Model duplicate1 End");
		return bean;
	}
	
	
	/**
	 * Find timetable by pk
	 * @param pk
	 * @return
	 * @throws ApplicationException
	 */
	public TimetableBean findByPK(long pk) throws ApplicationException {
		log.debug("Model findByPK Started");
		StringBuffer sql = new StringBuffer("SELECT * FROM st_timetable WHERE ID=?");
		TimetableBean bean = null;
		Connection conn = null;
		try {
			conn = JDBCDataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
			pstmt.setLong(1, pk);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				bean = new TimetableBean();
				bean.setId(rs.getLong(1));
				bean.setCourseId(rs.getLong(2));
				bean.setSem(rs.getString(3));
				bean.setSubjectId(rs.getLong(4));
				
				bean.setExamDate(rs.getDate(5));
				bean.setExamTime(rs.getString(6));
				
				bean.setCreatedBy(rs.getString(7));
				bean.setModifiedBy(rs.getString(8));
				bean.setCreatedDatetime(rs.getTimestamp(9));
				bean.setModifiedDatetime(rs.getTimestamp(10));
			}
			rs.close();
		} catch (Exception e) {
			log.error("Database Exception..", e);
			throw new ApplicationException("Exception : Exception in getting timetable by pk");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Model findByPK End");
		return bean;
	}

	/**
	 * update a timetable
	 * @param bean
	 * @throws ApplicationException
	 * @throws DuplicateRecordException
	 */
	public void update(TimetableBean bean) throws ApplicationException, DuplicateRecordException {
		log.debug("Model update Started");
		Connection conn = null;

		TimetableBean beanExist = findDuplicate1(bean.getCourseId(), bean.getSem(), bean.getSubjectId());

		//douttttttttttt
		if (beanExist != null && beanExist.getId() != bean.getId()) {
			throw new DuplicateRecordException("Time Table already exist");
		}
			try {

			conn = JDBCDataSource.getConnection();

			conn.setAutoCommit(false); // Begin transaction
			PreparedStatement pstmt = conn.prepareStatement(
					"UPDATE st_timetable SET COURSE_ID=?,SEM=?,SUBJECT_ID=?,DATE_EXAM=?,TIME_EXAM=?,CREATED_BY=?,MODIFIED_BY=?,CREATED_DATETIME=?,MODIFIED_DATETIME=? WHERE ID=?");

			pstmt.setLong(1, bean.getCourseId());
			pstmt.setString(2, bean.getSem());
			pstmt.setLong(3, bean.getSubjectId());
			pstmt.setDate(4, new java.sql.Date(bean.getExamDate().getTime()));
			//pstmt.setDate(6, new java.sql.Date(bean.getDob().getTime()));
			pstmt.setString(5, bean.getExamTime());
			
			pstmt.setString(6, bean.getCreatedBy());
			pstmt.setString(7, bean.getModifiedBy());
			pstmt.setTimestamp(8, bean.getCreatedDatetime());
			pstmt.setTimestamp(9, bean.getModifiedDatetime());
			pstmt.setLong(10, bean.getId());
			pstmt.executeUpdate();
			conn.commit(); // End transaction
//System.out.println("check upadte 4");

			pstmt.close();
		} catch (Exception e) {
			log.error("Database Exception..", e);
			try {
				conn.rollback();
			} catch (Exception ex) {
				throw new ApplicationException("Exception : Delete rollback exception " + ex.getMessage());
			}
			throw new ApplicationException("Exception in updating st_timetable ");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Model update End");
	}

	/**
	 * Search st_timetable
	 * 
	 * @param bean
	 *            : Search Parameters
	 * @throws DatabaseException
	 */

	public List search(TimetableBean bean) throws ApplicationException {
		return search(bean, 0, 0);
	}

	/**
	 * Search TimeTable with pagination
	 * 
	 * @return list : List of Students
	 * @param bean
	 *            : Search Parameters
	 * @param pageNo
	 *            : Current Page No.
	 * @param pageSize
	 *            : Size of Page
	 * 
	 * @throws DatabaseException
	 */

	public List search(TimetableBean bean, int pageNo, int pageSize) throws ApplicationException {
		log.debug("Model search Started");
		StringBuffer sql = new StringBuffer("SELECT * FROM st_timetable WHERE 1=1");

		if (bean != null) {
			if (bean.getId() > 0) {
				sql.append(" AND id = " + bean.getId());
			}
			if (bean.getCourseId() != 0 && bean.getCourseId() > 0) {
				sql.append(" AND COURSE_ID like '" + bean.getCourseId() + "%'");
			}
			if (bean.getSem() != null && bean.getSem().length() > 0) {
				sql.append(" AND SEM like '" + bean.getSem() + "%'");
			}
			if (bean.getSubjectId() != 0 && bean.getSubjectId() > 0) {
				sql.append(" AND SUBJECT_ID = " + bean.getSubjectId());
			}
			if (bean.getExamDate() != null && bean.getExamDate().getDate() > 0) {
				sql.append(" AND DATE_EXAM like '" + bean.getExamTime() + "%'");
			}
			

		}

		// if page size is greater than zero then apply pagination
		if (pageSize > 0) {
			// Calculate start record index
			pageNo = (pageNo - 1) * pageSize;

			sql.append(" Limit " + pageNo + ", " + pageSize);
			// sql.append(" limit " + pageNo + "," + pageSize);
		}

		ArrayList list = new ArrayList();
		Connection conn = null;
		try {
			conn = JDBCDataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				bean = new TimetableBean();
				bean.setId(rs.getLong(1));
				bean.setCourseId(rs.getLong(2));
				bean.setSem(rs.getString(3));
				bean.setSubjectId(rs.getLong(4));
				
				bean.setExamDate(rs.getDate(5));
				bean.setExamTime(rs.getString(6));
				
				bean.setCreatedBy(rs.getString(7));
				bean.setModifiedBy(rs.getString(8));
				bean.setCreatedDatetime(rs.getTimestamp(9));
				bean.setModifiedDatetime(rs.getTimestamp(10));
				list.add(bean);
			}
			rs.close();
		} catch (Exception e) {
			log.error("Database Exception..", e);
			throw new ApplicationException("Exception : Exception in search Student");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}

		log.debug("Model search End");
		return list;
	}

	/**
	 * Get List of Student
	 * 
	 * @return list : List of Student
	 * @throws DatabaseException
	 */

	public List list() throws ApplicationException {
		return list(0, 0);
	}

	/**
	 * Get List of Student with pagination
	 * 
	 * @return list : List of Student
	 * @param pageNo
	 *            : Current Page No.
	 * @param pageSize
	 *            : Size of Page
	 * @throws DatabaseException
	 */

	public List list(int pageNo, int pageSize) throws ApplicationException {
		log.debug("Model list Started");
		ArrayList list = new ArrayList();
		StringBuffer sql = new StringBuffer("select * from st_timetable");
		// if page size is greater than zero then apply pagination
		if (pageSize > 0) {
			// Calculate start record index
			pageNo = (pageNo - 1) * pageSize;
			sql.append(" limit " + pageNo + "," + pageSize);
		}

		Connection conn = null;

		try {
			conn = JDBCDataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				TimetableBean bean = new TimetableBean();
				bean.setId(rs.getLong(1));
				bean.setCourseId(rs.getLong(2));
				bean.setSem(rs.getString(3));
				bean.setSubjectId(rs.getLong(4));
				
				bean.setExamDate(rs.getDate(5));
				
				bean.setExamTime(rs.getString(6));
				
				bean.setCreatedBy(rs.getString(7));
				bean.setModifiedBy(rs.getString(8));
				bean.setCreatedDatetime(rs.getTimestamp(9));
				bean.setModifiedDatetime(rs.getTimestamp(10));
				list.add(bean);
			}
			rs.close();
		} catch (Exception e) {
			log.error("Database Exception..", e);
			throw new ApplicationException("Exception : Exception in getting list of Student");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}

		log.debug("Model list End");
		return list;

	}

}

	

