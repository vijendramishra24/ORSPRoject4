package com.rays.proj4.ctl;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rays.proj4.bean.BaseBean;
import com.rays.proj4.bean.TimetableBean;
import com.rays.proj4.exception.ApplicationException;
import com.rays.proj4.model.CollegeModel;
import com.rays.proj4.model.CourseModel;
import com.rays.proj4.model.SubjectModel;
import com.rays.proj4.model.TimetableModel;
import com.rays.proj4.util.DataUtility;
import com.rays.proj4.util.PropertyReader;
import com.rays.proj4.util.ServletUtility;

/**
 * TimeTable List functionality Controller. Performs operation for list, search
 * operations of TimeTable
 * @author Bridge
 *
 */
@WebServlet(name = "TimetableListCtl", urlPatterns = { "/ctl/TimetableListCtl" })
public class TimetableListCtl extends BaseCtl {

	
	private static Logger log = Logger.getLogger(TimetableListCtl.class);

	@Override
    protected void preload(HttpServletRequest request) {
        SubjectModel model2=new SubjectModel();
        CourseModel model3=new CourseModel();
        try {
            List l2=model2.list();
            List l3=model3.list();
            request.setAttribute("subjectList", l2);
            request.setAttribute("courseList", l3);
            
        } catch (ApplicationException e) {
            log.error(e);
        }

    }

	
	
	@Override
	protected TimetableBean populateBean(HttpServletRequest request) {
		TimetableBean bean = new TimetableBean();

		bean.setCourseId(DataUtility.getLong(request.getParameter("courseList")));

		bean.setSem(DataUtility.getString(request.getParameter("sem")));

		bean.setSubjectId(DataUtility.getLong(request.getParameter("subjectList")));

		//bean.setRoleId(DataUtility.getLong(request.getParameter("role")));// NEW

		//System.out.println("TimetableList populateBean check1");
		return bean;
	}

	/**
	 * Contains Display logics
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		log.debug("TimetableListCtl doGet Start");
		System.out.println("TimetableList doget start");
		List list = null;
		int pageNo = 1;
		int pageSize = DataUtility.getInt(PropertyReader.getValue("page.size"));
		TimetableBean bean = (TimetableBean) populateBean(request);
		String op = DataUtility.getString(request.getParameter("operation"));
		// get the selected checkbox ids array for delete list
		String[] ids = request.getParameterValues("ids");
		TimetableModel model = new TimetableModel();
		try {
			list = model.search(bean, pageNo, pageSize);
			ServletUtility.setList(list, request);
			if (list == null || list.size() == 0) {
				ServletUtility.setErrorMessage("No record found ", request);
			}
			ServletUtility.setList(list, request);
			ServletUtility.setPageNo(pageNo, request);
			ServletUtility.setPageSize(pageSize, request);
			ServletUtility.forward(getView(), request, response);
		} catch (ApplicationException e) {
			log.error(e);
			ServletUtility.handleException(e, request, response);
			return;
		}
		//System.out.println("TimetableList doget end");
		log.debug("TimetableListCtl doPOst End");
	}

	/**
	 * Contains Submit logics
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		log.debug("TimetableListCtl doPost Start");
		List list = null;
		int pageNo = DataUtility.getInt(request.getParameter("pageNo"));
		int pageSize = DataUtility.getInt(request.getParameter("pageSize"));

		pageNo = (pageNo == 0) ? 1 : pageNo;
		pageSize = (pageSize == 0) ? DataUtility.getInt(PropertyReader.getValue("page.size")) : pageSize;
		TimetableBean bean = (TimetableBean) populateBean(request);
		String op = DataUtility.getString(request.getParameter("operation"));
		// get the selected checkbox ids array for delete list
		String[] ids = request.getParameterValues("ids");
		TimetableModel model = new TimetableModel();
		try {

			if (OP_SEARCH.equalsIgnoreCase(op) || "Next".equalsIgnoreCase(op) || "Previous".equalsIgnoreCase(op)) {

				if (OP_SEARCH.equalsIgnoreCase(op)) {
					pageNo = 1;
				} else if (OP_NEXT.equalsIgnoreCase(op)) {
					pageNo++;
				} else if (OP_PREVIOUS.equalsIgnoreCase(op) && pageNo > 1) {
					pageNo--;
				}

			} else if (OP_RESET.equalsIgnoreCase(op)||OP_BACK.equalsIgnoreCase(op)) {
				ServletUtility.redirect(ORSView.TIMETABLE_LIST_CTL, request, response);
				return;
			} else if (OP_NEW.equalsIgnoreCase(op)) {
				ServletUtility.redirect(ORSView.TIMETABLE_CTL, request, response);
				return;
			} else if (OP_ADD.equalsIgnoreCase(op)) {
				ServletUtility.redirect(ORSView.TIMETABLE_CTL, request, response);
				return;
			} else if (OP_DELETE.equalsIgnoreCase(op)) {
				pageNo = 1;
				if (ids != null && ids.length > 0) {
					TimetableBean deletebean = new TimetableBean();
					for (String id : ids) {
						deletebean.setId(DataUtility.getInt(id));
						model.delete(deletebean);
					}
					ServletUtility.setSuccessMessage("Entry deleted successfully", request);
				} else {
					ServletUtility.setErrorMessage("Select at least one record", request);
				}
			}
			list = model.search(bean, pageNo, pageSize);
			ServletUtility.setList(list, request);
			if (list == null || list.size() == 0 && !OP_DELETE.equalsIgnoreCase(op)) {
				ServletUtility.setErrorMessage("No record found ", request);
			}
			ServletUtility.setList(list, request);
			ServletUtility.setPageNo(pageNo, request);
			ServletUtility.setPageSize(pageSize, request);
			ServletUtility.setBean(bean, request);
			ServletUtility.forward(getView(), request, response);

		} catch (ApplicationException e) {
			log.error(e);
			ServletUtility.handleException(e, request, response);
			return;
		}
		log.debug("TimetableListCtl doGet End");
	}

	
	@Override
	protected String getView() {
		// TODO Auto-generated method stub
		return ORSView.TIMETABLE_LIST_VIEW;
	}

}
