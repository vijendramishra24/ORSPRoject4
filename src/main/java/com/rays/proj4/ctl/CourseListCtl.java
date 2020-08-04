package com.rays.proj4.ctl;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rays.proj4.bean.BaseBean;
import com.rays.proj4.bean.CourseBean;
import com.rays.proj4.exception.ApplicationException;
import com.rays.proj4.model.CourseModel;
import com.rays.proj4.util.DataUtility;
import com.rays.proj4.util.PropertyReader;
import com.rays.proj4.util.ServletUtility;

/**
 * Course List functionality Controller. Performs operation for list, search
 * operations of Course
 * @author Bridge
 *
 */
@ WebServlet(name="CourseListCtl",urlPatterns={"/ctl/CourseListCtl"})
public class CourseListCtl extends BaseCtl {

	private static Logger log = Logger.getLogger(CourseListCtl.class);

    @Override
    protected BaseBean populateBean(HttpServletRequest request) {
        CourseBean bean = new CourseBean();
        bean.setName(DataUtility.getString(request.getParameter("name")));

        return bean;
    }

    /**
     * Contains Display logics
     */
    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        log.debug("CourseListCtl doGet Start");
        List list = null;
        int pageNo = 1;
        int pageSize = DataUtility.getInt(PropertyReader.getValue("page.size"));
        CourseBean bean = (CourseBean) populateBean(request);
        String op = DataUtility.getString(request.getParameter("operation"));
        CourseModel model = new CourseModel();
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
            System.out.println("Course --doget--handelexception");
            ServletUtility.handleException(e, request, response);
            return;
        }
        log.debug("CourseListCtl doGet End");
    }

    /**
     * Contains Submit logics
     */
    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        log.debug("CourseListCtl doPost Start");
        List list = null;
        int pageNo = DataUtility.getInt(request.getParameter("pageNo"));
        int pageSize = DataUtility.getInt(request.getParameter("pageSize"));
        pageNo = (pageNo == 0) ? 1 : pageNo;
        pageSize = (pageSize == 0) ? DataUtility.getInt(PropertyReader
                .getValue("page.size")) : pageSize;
        CourseBean bean = (CourseBean) populateBean(request);
        String op = DataUtility.getString(request.getParameter("operation"));
        
        String[] ids = request.getParameterValues("ids");
        CourseModel model = new CourseModel();

        try {

			if (OP_SEARCH.equalsIgnoreCase(op) || "Next".equalsIgnoreCase(op) || "Previous".equalsIgnoreCase(op)) {

				if (OP_SEARCH.equalsIgnoreCase(op)) {
					pageNo = 1;
				} else if (OP_NEXT.equalsIgnoreCase(op)) {
					pageNo++;
				} else if (OP_PREVIOUS.equalsIgnoreCase(op) && pageNo > 1) {
					pageNo--;
				}

			} 
			else if (OP_ADD.equalsIgnoreCase(op)) {
				ServletUtility.redirect(ORSView.COURSE_CTL, request, response);
				return;
			}else if (OP_RESET.equalsIgnoreCase(op)||OP_BACK.equalsIgnoreCase(op)) {
				ServletUtility.redirect(ORSView.COURSE_LIST_CTL, request, response);
				return;
			} 
			else if (OP_DELETE.equalsIgnoreCase(op)) {
				pageNo = 1;
				if (ids != null && ids.length > 0) {
					CourseBean deletebean = new CourseBean();
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
			ServletUtility.forward(getView(), request, response);

        } catch (ApplicationException e) {
            log.error(e);
            System.out.println("check3333");
            ServletUtility.handleException(e, request, response);
            return;
        }
        log.debug("CourseListCtl doPost End");
    }

	
	
	@Override
	protected String getView() {
		
		return ORSView.COURSE_LIST_VIEW;
	}


	
}
