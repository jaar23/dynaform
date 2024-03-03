module controllers

import db.sqlite
import x.vweb { Controller, Result }
import models { Form, FormData, FormItem, FormItemOption, FormTemplate }
import json
import net.http

pub struct FormTemplateCtr {
	vweb.Middleware[FormTemplateCtx]
	pub: db &sqlite.DB
}

pub struct FormTemplateCtx {
	vweb.Context
	pub mut:
		template_c ?TemplateCreateDto
}

pub struct TemplateCreateDto {
	id int 
	name string
}

pub fn parse_body(mut ctx FormTemplateCtx) bool {
	if ctx.req.method == http.Method.post {
		template := json.decode(TemplateCreateDto, ctx.req.data) or {TemplateCreateDto {}}
		ctx.template_c = template
	}
	return true
}

pub fn new_form_template_controller(db &sqlite.DB) FormTemplateCtr {
	mut form_template_ctr := FormTemplateCtr {db: db}
	form_template_ctr.route_use('/', handler: parse_body)
	// form_template_ctr.route_use('/:id', handler: logging2)
	
	return form_template_ctr
}

@['/']
pub fn (ft &FormTemplateCtr) get(mut ctx FormTemplateCtx) Result {
	ft_result := sql ft.db {
		select from FormTemplate
	} or { 
		return ctx.text('db error ${err}')
	}
	println('result: ${ft_result}')
	return ctx.text('get form template ${ft_result}')
}

@['/:id']
pub fn (ft &FormTemplateCtr) get2(mut ctx FormTemplateCtx, id int) Result {
	ft_result := sql ft.db {
		select from FormTemplate
	} or { 
		return ctx.text('db error ${err}')
	}
	println('test result ${id}: ${ft_result}')
	return ctx.text('get form template ${ft_result}')
}


@['/'; post]
pub fn (ft &FormTemplateCtr) create(mut ctx FormTemplateCtx) vweb.Result {
	//data := json.decode(TemplateCreateDto, ctx.req.data) or { TemplateCreateDto {}}
	println('id: ${ctx.template_c?.id}, name: ${ctx.template_c?.name}')
	return ctx.ok("ok")
}