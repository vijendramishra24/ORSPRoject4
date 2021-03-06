package com.rays.proj4.ctl;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rays.proj4.bean.BaseBean;
import com.rays.proj4.bean.SubjectBean;
import com.rays.proj4.exception.ApplicationException;
import com.rays.proj4.exception.DuplicateRecordException;
import com.rays.proj4.model.CourseModel;
import com.rays.proj4.model.SubjectModel;
import com.rays.proj4.util.DataUtility;
import com.rays.proj4.util.DataValidator;
import com.rays.proj4.util.PropertyReader;
import com.rays.proj4.util.ServletUtility;

/**
 * Subject functionality Controller. Performs operation for add, update, delete
 * and get subject
 * @author Bridge
 *
 */
@ WebServlet(name="SubjectCtl",urlPatterns={"/ctl/SubjectCtl"})
public class SubjectCtl extends BaseCtl {

	private static final long serialVersionUID = 1L;

    private static Logger log = Logger.getLogger(SubjectCtl.class);
    
    
    @Override
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
    protected boolean validate(HttpServletRequest request) {

        log.debug("SubjectCtl Method validate Started");

        boolean pass = true;

        if (DataValidator.isNull(request.getParameter("name"))) {
            request.setAttribute("name",
                    PropertyReader.getValue("error.require", "Name"));
            pass = false;
        }

        if (DataValidator.isNull(request.getParameter("description"))) {
            request.setAttribute("description",
                    PropertyReader.getValue("error.require", "Description"));
            pass = false;
        }

        if (DataValidator.isNull(request.getParameter("subjectcode"))) {
            request.setAttribute("subjectcode",
                    PropertyReader.getValue("error.require", "Subject Code"));
            pass = false;
        }
        
        if (request.getParameter("courseId").equals("---select---")) {
			request.setAttribute("courseId", PropertyReader.getValue("error.select1", "Course Name"));
			pass = false;
		}

        
        
        log.debug("SubjectCtl Method validate Ended");

        return pass;
    }

    @Override
    protected BaseBean populateBean(HttpServletRequest request) {

        log.debug("SubjectCtl Method populatebean Started");

        SubjectBean bean = new SubjectBean();

        bean.setId(DataUtility.getLong(request.getParameter("id")));

        bean.setName(DataUtility.getString(request.getParameter("name")));
        bean.setDescription(DataUtility.getString(request.getParameter("description")));

        bean.setSubjectCode(DataUtility.getString(request.getParameter("subjectcode")));
        
        bean.setCourseId(DataUtility.getInt(request.getParameter("courseId")));
       // bean.setDescription(DataUtility.getString(request.getParameter("courseid")));
        populateDTO(bean, request);

        log.debug("SubjectCtl Method populatebean Ended");

        return bean;
    }

    /**
     * Contains Display logics
     */
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        log.debug("SubjectCtl Method doGet Started");

       
        String op = DataUtility.getString(request.getParameter("operation"));

        // get model
        SubjectModel model = new SubjectModel();

        long id = DataUtility.getLong(request.getParameter("id"));
        if (id > 0 || op != null) {
            SubjectBean bean;
            try {
                
            	bean =model.findByPK(id);
                ServletUtility.setBean(bean, request);
            } catch (ApplicationException e) {
                log.error(e);
                ServletUtility.handleException(e, request, response);
                return;
            }
        }
        ServletUtility.forward(getView(), request, response);
        log.debug("SubjectCtl Method doGetEnded");
    }

    /**
     * Contains Submit logics
     */
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        log.debug("SubjectCtl Method doGet Started");

        System.out.println("In do get");

        String op = DataUtility.getString(request.getParameter("operation"));

        // get model
        SubjectModel model = new SubjectModel();

        long id = DataUtility.getLong(request.getParameter("id"));

        if (OP_SAVE.equalsIgnoreCase(op)||OP_UPDATE.equalsIgnoreCase(op)) {

            SubjectBean bean = (SubjectBean) populateBean(request);

            try {
                if (id > 0) {
                    model.update(bean);
                } else {
                    long pk = model.add(bean);
                    bean.setId(pk);
                }

                ServletUtility.setBean(bean, request);
                ServletUtility.setSuccessMessage("Data is successfully saved",request);

            } catch (ApplicationException e) {
                log.error(e);
                ServletUtility.handleException(e, request, response);
                return;
            } catch (DuplicateRecordException e) {
                ServletUtility.setBean(bean, request);
                ServletUtility.setErrorMessage("Subject already exists", request);
            }

        } else if (OP_RESET.equalsIgnoreCase(op)) {

            ServletUtility.redirect(ORSView.SUBJECT_CTL, request, response);
            return;

        }

        else if (OP_CANCEL.equalsIgnoreCase(op)) {

            ServletUtility.redirect(ORSView.SUBJECT_LIST_CTL, request, response);
            return;

        }

        ServletUtility.forward(getView(), request, response);

        log.debug("SubjectCtl Method doPOst Ended");
    }

	
	@Override
	protected String getView() {
		return ORSView.SUBJECT_VIEW;
	}

}
