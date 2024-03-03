module controller

import db.sqlite
import x.vweb { Result }
import json
import entities.view { TemplateCreateDto }
import entities
import service as form_service
import net.http

pub struct FormTemplateCtr {
	vweb.Middleware[FormTemplateCtx]
pub:
	db &sqlite.DB
}

pub struct FormTemplateCtx {
	vweb.Context
pub mut:
	template_c ?TemplateCreateDto
}

pub fn parse_body(mut ctx FormTemplateCtx) bool {
	if ctx.req.method == http.Method.post {
		template := json.decode(TemplateCreateDto, ctx.req.data) or { TemplateCreateDto{} }
		ctx.template_c = template
	}
	return true
}

pub fn new_form_template_controller(db &sqlite.DB) FormTemplateCtr {
	mut form_template_ctr := FormTemplateCtr{
		db: db
	}
	form_template_ctr.route_use('/', handler: parse_body)

	return form_template_ctr
}


@['/'; get]
pub fn (ft &FormTemplateCtr) get(mut ctx FormTemplateCtx) Result {
	ft_result := sql ft.db {
		select from entities.FormTemplate
	} or { return ctx.text('db error ${err}') }
	println('result: ${ft_result}')
	return ctx.text('get form template ${ft_result}')
}

@['/:id'; get]
pub fn (ft &FormTemplateCtr) get_one(mut ctx FormTemplateCtx, id int) Result {
	ft_result := sql ft.db {
		select from entities.FormTemplate where id == id
	} or { return ctx.text('db error ${err}')}

	println('test result ${id}: ${ft_result}')

	return ctx.text('get form template ${ft_result}')
}

@['/'; post]
pub fn (ft &FormTemplateCtr) create(mut ctx FormTemplateCtx) Result {
	println('${ctx.template_c?}')
	form_service.create()
	return ctx.ok('ok')
}
