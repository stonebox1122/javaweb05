package com.stone.tag;

import java.io.IOException;
import java.util.Collection;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

public class ForEach extends SimpleTagSupport {
	private Collection<?> items;
	private String var;
	public void setItems(Collection<?> items) {
		this.items = items;
	}
	public void setVar(String var) {
		this.var = var;
	}
	@Override
	public void doTag() throws JspException, IOException {
		//1. 遍历Items对应的集合
		if (items != null) {
			for (Object obj : items) {
				//2.把正在遍历的对象放入到 pageContext 中, 键: var, 值: 正在遍历的对象
				getJspContext().setAttribute(var, obj);
				//3.把标签体的内容直接输出到页面上
				getJspBody().invoke(null);
			}
		}
	}
}