module main

import db.sqlite
import os
import models { Form, FormData, FormItem, FormItemOption, FormTemplate }
import zztkm.vdotenv


fn main() {
	vdotenv.load()
	
	db_path := os.getenv('DYNAFORM_DB_PATH')

	mut db := sqlite.connect(db_path) or { panic(err) }

	defer {
		db.close() or { panic(err) }
	}

	sql db {
		create table FormTemplate
		create table Form
		create table FormItem
		create table FormItemOption
		create table FormData
	} or { panic(err) }

	form_result := sql db {
		select from Form
	} or { panic(err) }

	print(form_result)
}
