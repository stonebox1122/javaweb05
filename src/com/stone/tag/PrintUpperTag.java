package com.stone.tag;

import java.io.IOException;
import java.io.StringWriter;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.JspFragment;
import javax.servlet.jsp.tagext.SimpleTagSupport;

public class PrintUpperTag extends SimpleTagSupport {
	private String time;
	public void setTime(String time) {
		this.time = time;
	}
	
	@Override
	public void doTag() throws JspException, IOException {
		//1.得到标签体内容
		JspFragment jspFragment = getJspBody();
		StringWriter stringWriter = new StringWriter();
		jspFragment.invoke(stringWriter);
		String content = stringWriter.toString();
		
		//2.变为大写
		content  = content.toUpperCase();
		
		//3.得到out隐含变量
		//4.循环输出
		int count = 1;
		try {
			count = Integer.parseInt(time);
		} catch (NumberFormatException e) {}
		for (int i = 0; i < count; i++) {
			getJspContext().getOut().print(i + 1 + "." + content + "<br>");
		}
	}
}