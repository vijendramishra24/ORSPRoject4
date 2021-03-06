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
import com.rays.proj4.exception.ApplicationException;
import com.rays.proj4.exception.DuplicateRecordException;
import com.rays.proj4.model.CollegeModel;
import com.rays.proj4.model.CourseModel;
import com.rays.proj4.model.FacultyModel;
import com.rays.proj4.model.SubjectModel;
import com.rays.proj4.util.DataUtility;
import com.rays.proj4.util.DataValidator;
import com.rays.proj4.util.PropertyReader;
import com.rays.proj4.util.ServletUtility;

/**
 * Faculty functionality Controller. Performs operation for add, update, delete
 * and get Faculty
 * @author Bridge
 *
 */
@ WebServlet(name="FacultyCtl",urlPatterns={"/ctl/FacultyCtl"})
public class FacultyCtl extends BaseCtl {
	private static Logger log = Logger.getLogger(FacultyCtl.class);

    @Override
    protected void preload(HttpServletRequest request) {
        CollegeModel model1 = new CollegeModel();
        SubjectModel model2=new SubjectModel();
        CourseModel model3=new CourseModel();
        try {
            List l1 = model1.list();
            List l2=model2.list();
            List l3=model3.list();
            request.setAttribute("collegeList", l1);
            request.setAttribute("subjectList", l2);
            request.setAttribute("courseList", l3);
            
        } catch (ApplicationException e) {
            log.error(e);
        }

    }

    @Override
    protected boolean validate(HttpServletRequest request) {

        log.debug("FacultyCtl Method validate Started");

        boolean pass = true;

        String op = DataUtility.getString(request.getParameter("operation"));
        String email = request.getParameter("email");
        String dob = request.getParameter("dob");

        if (DataValidator.isNull(request.getParameter("firstName"))) {
            request.setAttribute("firstName",
                    PropertyReader.getValue("error.require", "First Name"));
            pass = false;
        }
        if (DataValidator.isNull(request.getParameter("lastName"))) {
            request.setAttribute("lastName",
                    PropertyReader.getValue("error.require", "Last Name"));
            pass = false;
        }
        if (DataValidator.isNull(request.getParameter("mobileNo"))) {
            request.setAttribute("mobileNo",
                    PropertyReader.getValue("error.require", "Mobile No"));
            pass = false;
        }
        
        else if (!DataValidator.isMobile(request.getParameter("mobileNo"))) {
            request.setAttribute("mobileNo",
                    PropertyReader.getValue("error.require", "Mobile No"));
            pass = false;
        }
        if (DataValidator.isNull(email)) {
            request.setAttribute("email",
                    PropertyReader.getValue("error.require", "Email "));
            pass = false;
        } else if (!DataValidator.isEmail(email)) {
            request.setAttribute("email",
                    PropertyReader.getValue("error.email", "Email "));
            pass = false;
        }
        if (request.getParameter("collegeId").equals("---select---")) {
			request.setAttribute("collegeId", PropertyReader.getValue("error.select", "College Name"));
			pass = false;
		}
        
        if (request.getParameter("subjectId").equals("---select---")) {
			request.setAttribute("subjectId", PropertyReader.getValue("error.select", "Subject Name"));
			pass = false;
		}
        if (request.getParameter("courseId").equals("---select---")) {
			request.setAttribute("courseId", PropertyReader.getValue("error.select", "Course Name"));
			pass = false;
		}
        if (DataValidator.isNull(dob)) {
            request.setAttribute("dob",
                    PropertyReader.getValue("error.require", "Date Of Birth"));
            pass = false;
        } else if (!DataValidator.isDate(dob)) {
            request.setAttribute("dob",
                    PropertyReader.getValue("error.date", "Date Of Birth"));
            pass = false;
        }//age validation
		else if(!DataValidator.isAge(dob)){
			request.setAttribute("dob", PropertyReader.getValue("error.age", "Age"));
			pass = false;
		}
        
System.out.println("validation"+pass);        

        log.debug("FacultyCtl Method validate Ended");

        return pass;
    }

    @Override
    protected BaseBean populateBean(HttpServletRequest request) {

        log.debug("FacultyCtl Method populatebean Started");

        FacultyBean bean = new FacultyBean();

        bean.setId(DataUtility.getLong(request.getParameter("id")));

        bean.setFirstName(DataUtility.getString(request
                .getParameter("firstName")));

        bean.setLastName(DataUtility.getString(request.getParameter("lastName")));

        bean.setDob(DataUtility.getDate(request.getParameter("dob")));

        bean.setMobileNo(DataUtility.getString(request.getParameter("mobileNo")));

        bean.setLogin(DataUtility.getString(request.getParameter("email")));

        bean.setCollegeId(DataUtility.getLong(request.getParameter("collegeId")));

        bean.setCourseId(DataUtility.getLong(request.getParameter("courseId")));

        bean.setSubjectId(DataUtility.getLong(request.getParameter("subjectId")));

        
        bean.setCourseName(DataUtility.getString(request.getParameter("courseName")));
        
        bean.setSubjectName(DataUtility.getString(request.getParameter("subjectName")));

 
        populateDTO(bean, request);

        log.debug("FacultyCtl Method populatebean Ended");

        return bean;
    }

    /**
     * Contains Display logics
     */
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

        log.debug("FacultyCtl Method doGet Started");

        String op = DataUtility.getString(request.getParameter("operation"));
        long id = DataUtility.getLong(request.getParameter("id"));

        // get model

        FacultyModel model = new FacultyModel();
        if (id > 0 || op != null) {
            FacultyBean bean;
            try {
                bean = model.findByPK(id);
                ServletUtility.setBean(bean, request);
            } catch (ApplicationException e) {
                log.error(e);
                ServletUtility.handleException(e, request, response);
                return;
            }
        }
        ServletUtility.forward(getView(), request, response);
        log.debug("FacultyCtl Method doGett Ended");
    }

    /**
     * Contains Submit logics
     */
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

        log.debug("FacultyCtl Method doPost Started");
        
        System.out.println("faculty ---dopost");

        String op = DataUtility.getString(request.getParameter("operation"));

        // get model

        FacultyModel model = new FacultyModel();

        long id = DataUtility.getLong(request.getParameter("id"));

        if (OP_SAVE.equalsIgnoreCase(op)||OP_UPDATE.equalsIgnoreCase(op)) {

            FacultyBean bean = (FacultyBean) populateBean(request);

            System.out.println("faculty ---dopost--save");

            try {
                if (id > 0) {
                    model.update(bean);
                } else {
                	System.out.println("faculty ---dopost--add start");

                	long pk = model.add(bean);
                    bean.setId(pk);
                    System.out.println("faculty ---dopost--add ends");

                }

                ServletUtility.setBean(bean, request);
                ServletUtility.setSuccessMessage("Data is successfully saved",
                        request);

            } catch (ApplicationException e) {
                log.error(e);
                ServletUtility.handleException(e, request, response);
                return;
            } catch (DuplicateRecordException e) {
                ServletUtility.setBean(bean, request);
                ServletUtility.setErrorMessage(
                        "Faculty Email Id already exists", request);
            }

        }

        else if (OP_DELETE.equalsIgnoreCase(op)) {

            FacultyBean bean = (FacultyBean) populateBean(request); 
            try {
                model.delete(bean);
                ServletUtility.redirect(ORSView.FACULTY_LIST_CTL, request,
                        response);
                return;

            } catch (ApplicationException e) {
                log.error(e);
                ServletUtility.handleException(e, request, response);
                return;
            }

        }
        else if (OP_RESET.equalsIgnoreCase(op)) {

           ServletUtility.redirect(ORSView.FACULTY_CTL, request, response);
             //ServletUtility.forward(ORSView.FACULTY_VIEW, request, response); 
        	//ServletUtility.forwardView(ORSView.FACULTY_VIEW, request, response);
            return;

        }
        else if (OP_CANCEL.equalsIgnoreCase(op)) {

            ServletUtility
                    .redirect(ORSView.FACULTY_LIST_CTL, request, response);
            return;

        }
        ServletUtility.forward(getView(), request, response);

        log.debug("FacultyCtl Method doPost Ended");
    }

    @Override
    protected String getView() {
        return ORSView.FACULTY_VIEW;
    }


	

}
