package com.rays.proj4.ctl;


import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rays.proj4.bean.BaseBean;
import com.rays.proj4.bean.FacultyBean;
import com.rays.proj4.bean.UserBean;
import com.rays.proj4.exception.ApplicationException;
import com.rays.proj4.model.CourseModel;
import com.rays.proj4.model.FacultyModel;
import com.rays.proj4.model.RoleModel;
import com.rays.proj4.util.DataUtility;
import com.rays.proj4.util.PropertyReader;
import com.rays.proj4.util.ServletUtility;


/**
 * Faculty List functionality Controller. Performs operation for list, search
 * operations of Faculty
 * @author Bridge
 *
 */
@ WebServlet(name="FacultyListCtl",urlPatterns={"/ctl/FacultyListCtl"})
public class FacultyListCtl extends BaseCtl {
	
	private static Logger log = Logger.getLogger(FacultyListCtl.class);

	
	protected void preload(HttpServletRequest request) {
		System.out.println("UserCtl preload method");

		CourseModel model = new CourseModel();
		try {
			List l = model.list();
			request.setAttribute("courseList", l);
		} catch (ApplicationException e) {
			log.error(e);
		}

	}
	
    @Override
    protected BaseBean populateBean(HttpServletRequest request) {

        FacultyBean bean = new FacultyBean();

        bean.setFirstName(DataUtility.getString(request
                .getParameter("firstName")));
        bean.setLastName(DataUtility.getString(request.getParameter("lastName")));
        bean.setCourseId(DataUtility.getLong(request.getParameter("courseList")));

        return bean;
    }

    /**
     * Contains Display logics
     */
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        log.debug("FacultyListCtl doGet Start");
        List list = null;

        int pageNo = 1;

        int pageSize = DataUtility.getInt(PropertyReader.getValue("page.size"));

        FacultyBean bean = (FacultyBean) populateBean(request);

        String op = DataUtility.getString(request.getParameter("operation"));

        FacultyModel model = new FacultyModel();
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
        log.debug("FacultyListCtl doGet End");
    }

    /**
     * Contains Submit logics
     */
    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        log.debug("FacultyListCtl doPost Start");
        List list = null;
        int pageNo = DataUtility.getInt(request.getParameter("pageNo"));
        int pageSize = DataUtility.getInt(request.getParameter("pageSize"));
        pageNo = (pageNo == 0) ? 1 : pageNo;
        pageSize = (pageSize == 0) ? DataUtility.getInt(PropertyReader
                .getValue("page.size")) : pageSize;

        FacultyBean bean = (FacultyBean) populateBean(request);
        String op = DataUtility.getString(request.getParameter("operation"));
        FacultyModel model = new FacultyModel();
        String[] ids = request.getParameterValues("ids");

        try {

            if (OP_SEARCH.equalsIgnoreCase(op) || "Next".equalsIgnoreCase(op)
                    || "Previous".equalsIgnoreCase(op)) {

                if (OP_SEARCH.equalsIgnoreCase(op)) {
                    pageNo = 1;
                } else if (OP_NEXT.equalsIgnoreCase(op)) {
                    pageNo++;
                } else if (OP_PREVIOUS.equalsIgnoreCase(op) && pageNo > 1) {
                    pageNo--;
                }
            }
            else if (OP_RESET.equalsIgnoreCase(op)||OP_BACK.equalsIgnoreCase(op)) {
				ServletUtility.redirect(ORSView.FACULTY_LIST_CTL, request, response);
				return;
			}
                else if (OP_ADD.equalsIgnoreCase(op)) {
    				ServletUtility.redirect(ORSView.FACULTY_CTL, request, response);
    				return;
    			} else if (OP_DELETE.equalsIgnoreCase(op)) {
    				pageNo = 1;
    				if (ids != null && ids.length > 0) {
    					FacultyBean deletebean = new FacultyBean();
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
ServletUtility.setBean(bean, request);
            ServletUtility.setPageNo(pageNo, request);
            ServletUtility.setPageSize(pageSize, request);
            ServletUtility.forward(getView(), request, response);

        } catch (ApplicationException e) {
            log.error(e);
            ServletUtility.handleException(e, request, response);
            return;
        }
        log.debug("FacultyListCtl doGet End");
    }

    @Override
    protected String getView() {
        return ORSView.FACULTY_LIST_VIEW;
    }


}
