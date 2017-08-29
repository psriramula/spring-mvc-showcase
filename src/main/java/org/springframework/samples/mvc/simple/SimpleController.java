package org.springframework.samples.mvc.simple;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;

@Controller
public class SimpleController {

	@Autowired
	private ServletContext servletContext;

	@RequestMapping("/simple")
	public @ResponseBody String simple() {


		ApplicationContext context =
				WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);
		HelloMessage helloMessage=(HelloMessage) context.getBean("helloMessage");
		return helloMessage.getMessage();
	}

}
