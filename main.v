module main

import x.vweb { Controller, Result }
import db.sqlite
import zztkm.vdotenv
import os { getenv }
import controllers {FormTemplateCtr, FormTemplateCtx}

pub struct Context {
	vweb.Context
}

pub struct App {
	vweb.Middleware[Context]
	Controller
mut:
	db &sqlite.DB
}

@['/']
pub fn (app &App) index(mut ctx Context) Result {
	return ctx.html('<h1>Hello vweb</h1>')
}


pub fn logging(mut ctx Context) bool {
	println('middleware ${ctx.req.url}')
	return true
}

fn middleware_unreachable(mut ctx Context) bool {
	ctx.text('unreachable, ${ctx.req.data}')
	return false
}


fn main() {
	vdotenv.load()

	db_path := getenv('DYNAFORM_DB_PATH')

	mut db := sqlite.connect(db_path) or { panic(err) }

	defer {
		db.close() or { panic(err) }
	}

	mut app := &App{db: &db}

	mut form_template_ctr := controllers.new_form_template_controller(&db)
	
	app.register_controller[FormTemplateCtr, Context]('/form-template', mut form_template_ctr)!
	
	app.use(handler: logging)

	vweb.run[App, Context](mut app, 8000)
}
