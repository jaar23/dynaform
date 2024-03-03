module main

import x.vweb { Controller, Result }
import os { getenv }
import db.sqlite
import zztkm.vdotenv
import form.controller as form_ctr


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


fn main() {
	vdotenv.load()

	db_path := getenv('DYNAFORM_DB_PATH')

	mut db := sqlite.connect(db_path) or { panic(err) }

	defer {
		db.close() or { panic(err) }
	}

	mut app := &App{db: &db}

	mut form_template_ctr := form_ctr.new_form_template_controller(&db)
	
	app.register_controller[form_ctr.FormTemplateCtr, Context]('/form-template', mut form_template_ctr)!

	vweb.run[App, Context](mut app, 8000)
}
